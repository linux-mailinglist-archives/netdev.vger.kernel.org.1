Return-Path: <netdev+bounces-39247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EF7BE74E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018C11C20310
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C63419A;
	Mon,  9 Oct 2023 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vqCOr7Rg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7391C693;
	Mon,  9 Oct 2023 17:04:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBAAF;
	Mon,  9 Oct 2023 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zU+K2+yrfsZfVEULhh5cTmfxulTUaZqpD8BIDKXNbwI=; b=vq
	COr7Rg9kp4p8OdtCRsUdTKn4r7BkXPNSYgn2zy6WAj4whzWWDPnVJ+6Z3CBYp12VjtgVn8PpV7OTu
	52r7SwpGZ0/zS+0XNnnKW3mwkicKHt1MAm4/WqdwgANG/4K70wKNBd/OXvWW0nYwxr2bg9ih+8STg
	hsetrxNj1GO/LX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qptfk-000wfo-DM; Mon, 09 Oct 2023 19:04:00 +0200
Date: Mon, 9 Oct 2023 19:04:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <79ed3531-4f5f-4da4-99ba-4faa053554cc@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
 <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <183d4a59-acf1-4784-8194-da8e484ccb1b@lunn.ch>
 <CANiq72knE9zK1Z0W6RMW-dn0Mqq2gZjJXukQPeXN4=MFcCExyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72knE9zK1Z0W6RMW-dn0Mqq2gZjJXukQPeXN4=MFcCExyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 04:48:34PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 9, 2023 at 3:54 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Can rustdoc be invoked in a similar way? Perform a check on a file,
> > issue errors, but don't actually generate any documentation? If it
> > can, it would be good to extend W=1 with this.
> 
> The Rust docs (like the Rust code) are supposed to be warning-free
> (and should remain like that, at the very least for `defconfig` and so
> on -- modulo mistakes, of course).

'supposed to' is often not enough.

The netdev CI results can be seen here:

https://patchwork.kernel.org/project/netdevbpf/patch/20231009013912.4048593-2-fujita.tomonori@gmail.com/

It would of been nice if netdev/kdoc test had failed if rustdoc found
problems.

We could add a new test, if rustdoc can be run on individual files.

   Andrew

