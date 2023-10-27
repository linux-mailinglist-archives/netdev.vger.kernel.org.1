Return-Path: <netdev+bounces-44615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0317D8C76
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BAD2821AE
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920C4179;
	Fri, 27 Oct 2023 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XQ/4E0qz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A62160;
	Fri, 27 Oct 2023 00:07:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61138198;
	Thu, 26 Oct 2023 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=R2G3EbMAjFyFArxWxFusjiN0c6cLZqQgdNFPGps24BE=; b=XQ
	/4E0qz2mr+JApLyfY6LbbVPToucWNdb3Q3kzGkFo9a1Ku4IXUyHfb5h3MzVNfAW36QcBO7In2DOad
	cDJk6Fh307oH2nan+13Xf1RgvK1n91+qI3p7f3YfyOyDlJ0W9OuKylvdzhMVDBCmdshONnRoRA8mT
	4dGkdYjGuQUevOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwAO1-000IJ0-31; Fri, 27 Oct 2023 02:07:37 +0200
Date: Fri, 27 Oct 2023 02:07:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com, ojeda@kernel.org
Subject: Re: [PATCH net-next v7 3/5] rust: add second `bindgen` pass for enum
 exhaustiveness checking
Message-ID: <feb34b35-e847-43f4-824f-157b1b96c7f0@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-4-fujita.tomonori@gmail.com>
 <CANiq72n6Cvxydcef03kEo9fy=5Zd7MXYqFUGX1MBaTKF2o63nw@mail.gmail.com>
 <20231026.205434.963307210202715112.fujita.tomonori@gmail.com>
 <CANiq72=QgT2tG3wy5pioTQ9n416kksZrL1791pehwR=1ZGP52w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=QgT2tG3wy5pioTQ9n416kksZrL1791pehwR=1ZGP52w@mail.gmail.com>

On Thu, Oct 26, 2023 at 02:22:23PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 26, 2023 at 1:54 PM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Sorry, I totally misunderstand your intention. I thought that the PHY
> > abstractions needs to be merged with your patch together.
> >
> > I'll drop your patch in the next version and focus on my patches.
> 
> No harm done! I understand you were trying to help, and I apologize if
> I sounded too harsh.
> 
> Your abstractions are not blocked on this patch -- they could go in
> without this, that is why I suggested marking this one as RFC and
> putting it at the end of the series.

That is not how netdev works. It messes up the patch flow, since the
machinery expects to commit all or nothing.

The best way forwards is you create a stable branch with this
patch. The netdev Maintainer can then pull that branch into netdev,
and Tomonori can then add his patches using it on top. When everything
meets up in linux-next, git then recognises it has the same patch
twice and drops one of them, depending on the order of the merge.

> I will send the patch soon, and assuming it lands, then you can start
> using the feature if you wish. I would recommend basing your patches
> on top of that patch (or `rust-next` when the patch lands),

That does not work. Networking patches need to be on net-next. The
stable branch solves that when we have cross subsystem dependencies.

       Andrew

