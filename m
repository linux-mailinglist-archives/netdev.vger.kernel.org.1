Return-Path: <netdev+bounces-182387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03584A889B1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B90C1893F86
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC43284685;
	Mon, 14 Apr 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPcG3Xcd"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25B27B515
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651457; cv=none; b=pTnktpAHjPWUrwBmts9gTYJP3rP6ISH9Ghm1lktxQ5YeBVG5BL6fzp6hJMkTMGKuMCVn/Pf7yK1jkkSaOi3vwKyMcCRKdXfsg6lzCcU5ik5Cd/LuHieh99Z/Zo/U4TAgZgYV3cg5/ZUB1acSUvt/BRF6rv6Vd3QIm7EnRqhtoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651457; c=relaxed/simple;
	bh=M77IwV8tnvB0H0QQzo7EDet09S/1jjbb+XU36hUK2Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERmY5iwtJC/gINVAYF1UQyYjMJsRuWgdR1O0u19qsM8Ej8OyAQdvdXdnlpSZdIK4YTOAsgE17Xxs/7r4itrsOac2k8GXFCOLdeq720v/CBajOG2Y+vd6i/38nfluoC/7QvO+WbvldKfvNaiGt4abO+Zu45UtAsOgg21LzDmmHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPcG3Xcd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CF8A91140298;
	Mon, 14 Apr 2025 13:24:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 13:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744651454; x=1744737854; bh=e/v1EMd+ufbni7jiHPFHf5bJ1kdfR49f/Kl
	UhIcOe4M=; b=gPcG3XcdCZvQa9OKOC/CT8DZ+RM3LEMwtWhDVubF2Jyad3cdlB8
	1BgdLCW+/8Fkx2DZoHq/PEPw30eQGdA7MZwRUOWsTozODSU11yd14pBaqqrVJPu2
	bx5is5vjwr6I5Db4mVXl+BRtkWqYAuMon6mZPsj/Flkrzn9kiZoP2WUMxm2tQ86Z
	FBFkcrpDJ80+YN/ViCktxwBxsXKhRz7fkTjTOl/lW0Mp5LsGAmOmVNNFOkL6RZ+A
	wDZJOg97mfNUvdSyRCxwBgRKyughriS+efY98c6OuGOZ/W4yOzi+4A5YGMvF+m8c
	lYPccX1Wg2nzwxuv8HrVam0qqQl3uRU8n0g==
X-ME-Sender: <xms:vUT9Z6zJsQpA5MKMCvekvz1-ZBw8GU-T3zOdfjEgogfsHRW4UpF8lQ>
    <xme:vUT9Z2SCaaPQVE_cKXFKrL9Q4HBrPPRv7BalXis4dWNyJvQH2b4Y0-BBKkc8lhfYf
    GL7fBkmfAwRaHo>
X-ME-Received: <xmr:vUT9Z8W0okKvB_TMK00kNCW52C75nR-1dRf2JsF5LOztpl-fHfkWds5lmxYr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgv
    lhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhf
    dtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfejkeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhhhuhhihhhuih
    ehsehhuhgrfigvihdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vUT9ZwhiL06QEZot62jfzULPOx5cnDs2k-og-WjLshAjzPuC3CKznQ>
    <xmx:vUT9Z8Cx42cIJPVAX0WNc3S8QlDNGRfW2oMfz0UsyL7Ms5Nu18wLfg>
    <xmx:vUT9ZxLLi6tk3IETvCeFH3ZmSX5WQuNrcoZ-i5iC6G2FFyejlmUtMw>
    <xmx:vUT9ZzA0LeYCmt3Q0bOUg-gLuu3y9RizRA4HwQAUMyRQrvOIExWUdw>
    <xmx:vkT9Zzxo67A-YoOeEPGxTKd5H1RK6jgYZywmDhwXY32Jj-iuEmTVAlzN>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 13:24:13 -0400 (EDT)
Date: Mon, 14 Apr 2025 20:24:11 +0300
From: Ido Schimmel <idosch@idosch.org>
To: hanhuihui <hanhuihui5@huawei.com>
Cc: dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] resume oif rule match l3mdev in fib_lookup
Message-ID: <Z_1Eu2xm3QAncMx8@shredder>
References: <Z_V--XONvQZaFCJ8@shredder>
 <20250412131910.15559-1-hanhuihui5@huawei.com>
 <Z_y2i05h0uLFnkhb@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_y2i05h0uLFnkhb@shredder>

On Mon, Apr 14, 2025 at 10:17:35AM +0300, Ido Schimmel wrote:
> On Sat, Apr 12, 2025 at 09:19:10PM +0800, hanhuihui wrote:
> > flowi_oif will be reset if flowi_oif set to a l3mdev (e.g., VRF) device.
> > This causes the oif rule to fail to match the l3mdev device in fib_lookup.
> > Let's get back to previous behavior.
> > 
> > Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
> > Signed-off-by: hanhuihui hanhuihui5@huawei.com
> > ---
> >  net/core/fib_rules.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> > index 4bc64d9..3c2a2db 100644
> > --- a/net/core/fib_rules.c
> > +++ b/net/core/fib_rules.c
> > @@ -268,7 +268,7 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
> >  		goto out;
> >  
> >  	oifindex = READ_ONCE(rule->oifindex);
> > -	if (oifindex && (oifindex != fl->flowi_oif))
> > +	if (oifindex && (oifindex != (fl->flowi_l3mdev ? : fl->flowi_oif)))
> 
> This will prevent us from matching on the output device when the device
> is enslaved to a VRF. We should try to match on L3 domain only if the
> FIB rule matches on a VRF device. I will try to send a fix today (wasn't
> feeling well in the last few days).

Posted a fix:
https://lore.kernel.org/netdev/20250414172022.242991-2-idosch@nvidia.com/

Can you please test it and tag it if it fixes your issue?

Thanks

