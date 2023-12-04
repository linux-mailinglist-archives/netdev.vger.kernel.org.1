Return-Path: <netdev+bounces-53674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC4804101
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D762D1F2127D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6AE381C2;
	Mon,  4 Dec 2023 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mChIJu57"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC6AA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7JmWiw2OjGew/L9t8WojbOOKVqJKnGxbMVBwCRVjGDA=;
	t=1701725551; x=1702935151; b=mChIJu57D94WwqsN5YKWbezoTd6ZadBf3AYYNRZS3wWluK1
	XOyviJek5AAH+OoMlpPbbLT0Z2jKNJ0jb07H0kuTG598rk6jEYFbie9mcMemWjUN4icBwIcT/+Wu4
	3L4L7JpkJklwOQ2CBn4Z11ttvNwnGtpMKQbNX2UVMLuy/JBPiyRQTmzMJCjZeVb9o05Fr6BmgFWfI
	TCW+hzVmasHpoxfBZsNkISt9r+OtOH04LL+A5rd+906VKRgU/x6fSSggeTUQEC1hUMPj8DLqeIpxb
	ZyqbNiJANnUQDXmD+XJXL4FVu74t0rcRltS4gQCYmqT+e8yp7zMKIfXK3QAK34Vg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAGYE-0000000FGpo-1Fro;
	Mon, 04 Dec 2023 22:32:26 +0100
Message-ID: <69c0fa67c2b0930f72e99c19c72fc706627989af.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Marc MERLIN <marc@merlins.org>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Date: Mon, 04 Dec 2023 22:32:25 +0100
In-Reply-To: <20231204212849.GA25864@merlins.org>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <20231204200038.GA9330@merlins.org>
	 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
	 <20231204203622.GB9330@merlins.org>
	 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
	 <20231204205439.GA32680@merlins.org> <20231204212849.GA25864@merlins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 13:28 -0800, Marc MERLIN wrote:
>=20
> Where do you we go from here? Is the patch obviously good/safe, or do we
> need to narrow things down/test some more?
>=20

Well, I was hoping that

 (a) ethtool folks / Jakub would comment if this makes sense, but I
     don't see a good reason to do things the other way around (other
     than "code is simpler"); and

 (b) Intel wired folks could help out with getting the patch across the
     finish line, seeing how their driver needs it :) I think the dev
     get/put needs to use the newer API, but I didn't immediately see
     how that works locally in a function without an allocated tracker

johannes

