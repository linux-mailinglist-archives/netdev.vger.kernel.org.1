Return-Path: <netdev+bounces-42036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF37CCBD5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965531C2048D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167EEBE;
	Tue, 17 Oct 2023 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N3HTsTe2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF322EAEF
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:10:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FDF7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q6hagcCPa4li9xS4hq++0sBFuHSj3jvcxFmcy/DU0EY=; b=N3
	HTsTe23nXDpRsQWxWWii6bnqpt9f17+D19N1zRIT9j6d7ZoQ+czzeQyQ4l2UKa1ll0geigukKJ+zq
	pcP/Dlxr0LFQVYGubpx0oH76brvDRso/n0fXjUhWuWJD0x9R97kVhzcY+XorTgwUw/61NXF4lAASo
	cKpyDbYBQ6aPE/0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qspS1-002W5e-Vr; Tue, 17 Oct 2023 21:09:57 +0200
Date: Tue, 17 Oct 2023 21:09:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path
 variables
Message-ID: <353dcd1e-a191-488c-8802-fede2a644453@lunn.ch>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-3-lixiaoyan@google.com>
 <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
 <CANn89iJVGQ0hpX8aSXjyfubntfy_a9xrZ5gGrx+ekY0THZ4p+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJVGQ0hpX8aSXjyfubntfy_a9xrZ5gGrx+ekY0THZ4p+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:10:21PM +0200, Eric Dumazet wrote:
> On Tue, Oct 17, 2023 at 3:57 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Tue, Oct 17, 2023 at 01:47:13AM +0000, Coco Li wrote:
> > > From: Chao Wu <wwchao@google.com>
> > >
> > > Reorganize fast path variables on tx-txrx-rx order.
> > > Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
> > > There are only read-write variables here.
> > >
> > > Below data generated with pahole on x86 architecture.
> > >
> > > Fast path variables span cache lines before change: 12
> > > Fast path variables span cache lines after change: 2
> >
> > As i pointed out for the first version, this is a UAPI file.
> >
> > Please could you add some justification that this does not cause any
> > UAPI changes. Will old user space binaries still work after this?
> >
> > Thanks
> >         Andrew
> 
> I do not think the particular order is really UAPI. Not sure why they
> were pushed in uapi in the first place.
> 
> Kernel exports these counters with a leading line with the names of the metrics.
> 
> We already in the past added fields and nothing broke.
> 
> So the answer is : user space binaries not ignoring the names of the
> metrics will work as before.
> 
> nstat is one of the standard binary.

This is the sort of thing which i think should be in the commit
message. It makes it clear somebody has thought about this, and they
think the risk is minimal. Without such a comment, somebody will ask
if changing to a uapi file is safe.

   Andrew

