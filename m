Return-Path: <netdev+bounces-60189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 441CC81E00B
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 12:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36631F21066
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578951011;
	Mon, 25 Dec 2023 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="k2I1fD0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F65100A
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sAXhjKtvlXBmxV1cQ2mDNbJiiLW+yCdjHevsOdWnhhk=; b=k2I1fD0nmtqAjc2dvQqcLA2Y4O
	uQtSqz8/UVFRQpWasnfxfWdCidFVtz77jYM3pFA9sO9EpJE4ZvLj5UzFZoByjfELh5UdOWozc+uCR
	5PFkMiF3iyCNKasLmDF1RfC/jJ4es6G6ZgMfOfmq+YpU1btu4nad7knUH9JYKptmZacKPoDp0e/Hn
	R/u+kVkBNfjPPIXHL6n6kM5riQHqysUw+Fb/Xo5+DjVpjrZ7iMRzm9h8j4JG5vw2ODEjZMuSrb5fp
	y6HtbHKyKYky4hvosEaiaCi7P1V8U6/bJX5eh72IQE6dIVd9NTJYXaeranyQfERZVe0Gh5dK3nZLi
	ZU4p+rEw==;
Received: from lfbn-idf3-1-20-89.w81-249.abo.wanadoo.fr ([81.249.147.89]:51810 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rHj1w-00088B-5Z by authid <merlins.org> with srv_auth_plain; Mon, 25 Dec 2023 03:21:56 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
	(envelope-from <marc@merlins.org>)
	id 1rHj1u-000egR-KY; Mon, 25 Dec 2023 03:21:54 -0800
Date: Mon, 25 Dec 2023 03:21:54 -0800
From: Marc MERLIN <marc@merlins.org>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v3] net: ethtool: do runtime PM
 outside RTNL
Message-ID: <20231225112154.GA33012@merlins.org>
References: <20231206084448.53b48c49@kernel.org>
 <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
 <a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
 <20231207094021.1419b5d0@kernel.org>
 <20231211045200.GC24475@merlins.org>
 <83dc80d3-1c26-405d-a08d-2db4bc318ac8@gmail.com>
 <20231215174634.GA10053@merlins.org>
 <20231224163043.GA6759@merlins.org>
 <5ca7edbb-cf61-45b2-b9ba-888cb157ecbb@gmail.com>
 <79d4bf3e-fdc7-4273-aa1e-9b5e8194696b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d4bf3e-fdc7-4273-aa1e-9b5e8194696b@intel.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.147.89
X-SA-Exim-Mail-From: marc@merlins.org

On Mon, Dec 25, 2023 at 10:03:23AM +0200, Sasha Neftin wrote:
> > > I can't patch that kernel easily. How exactly do I disable runtime PM
> > > from the kernel command line for "that device" which I'm not even sure
> > 
> > Change <device>/power/control from "auto" to "on".
> 
> Need to figure out your controller location in a file system via lspci/lspci
> -t and then change to "on"
> For example: echo on >
> /sys/devices/pci0000\:00/0000\:00\:1c.0/0000\:ae\:00.0/power/control
> 
> We are starting to look at this problem, but I can't reproduce the problem
> on my machines yet.

Thanks. I realized it was going to be hard either way if the boot hangs
before I get to a command prompt, which was what was happening
yesterday.
I had to boot ubuntu to debug a sound issue, and it was very tricky
since most of the time it hung before I got to a command prompt, but I
was finally able to get it to work long enough to debug the sound issue
and go back to my self built kernel to port over the sound config I
needed.

I wish I could tell you exactly how to reproduct this in a more useful
way, sorry about that.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

