Return-Path: <netdev+bounces-39330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F97BED13
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A891C20A12
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522041A87;
	Mon,  9 Oct 2023 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="upSPK5b/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8D156C3;
	Mon,  9 Oct 2023 21:21:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBE1713;
	Mon,  9 Oct 2023 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=y258R4tYn2ASUhxooXI9HDwo6MCdCIhW1mOUV2mlQ0c=; b=up
	SPK5b/BclabmHhjQkAxJMFu2crAZSE5ThmtbPV2oyL3Rj5EebGp2wpp7GiuRaA4oMOBvJ+nlsRKIR
	IBoIEonKAuqUE5KEeEuBMExUdGcfA6pes+zpy7sk5qPNb20je4XV5c8SX/mS5UewpT930b8q9Xy50
	PnATn4x/DtOH0bs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpxgd-0010Yf-BI; Mon, 09 Oct 2023 23:21:11 +0200
Date: Mon, 9 Oct 2023 23:21:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, gregkh@linuxfoundation.org,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <16509b83-27a8-4b43-a27d-a895772e4693@lunn.ch>
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
 <2023100926-ambulance-mammal-8354@gregkh>
 <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
 <CALNs47unEPkVtRVBZfqYJ_-tgf3HJ6mxz_pybL+y3=AXgX2o8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNs47unEPkVtRVBZfqYJ_-tgf3HJ6mxz_pybL+y3=AXgX2o8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 05:07:18PM -0400, Trevor Gross wrote:
> On Mon, Oct 9, 2023 at 11:24 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> > Trevor gave Reviewed-by. Not perfect but reasonable shape, IMHO. Seems
> > that we have been discussing the same topics like locking, naming, etc
> > again and again.
> 
> To be clear: this is ONLY for the rust design, I am not at all
> qualified to review the build system integration. I provided a review
> with the known caveats that:

There is this patch going through review at the moment.

https://lore.kernel.org/netdev/fad9a472-ae78-8672-6c93-58ddde1447d9@intel.com/T/

Which says:

+It's safe to assume that the maintainers know the community and the level
+of expertise of the reviewers. The reviewers should not be concerned about
+their comments impeding or derailing the patch flow.

Even though Rust is new to netdev, there has been enough discussion
that we should be able to figure out what reviewers domain of
expertise is. That is part of the job of being a Maintainer for
netdev.

    Andrew

