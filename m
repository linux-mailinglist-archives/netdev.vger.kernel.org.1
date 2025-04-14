Return-Path: <netdev+bounces-182055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E98A8788D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC9A16E500
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 07:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C57257AE8;
	Mon, 14 Apr 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxNGzkn2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF3257AC8
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615057; cv=none; b=AueX8LWqlfkW7xBFVgCIs5kSNdbQyLid2n7dpWVIC2JRNgSzwgGMWePV9f4qBCE+rqzl8lkdq4SuyyQe5n7mETm3ZO4mjYPA70wh3I423jNzTjcoN8zTAdhpjaHxtZz2wk0YgcTutCaizAgpkgXDD6lZLS/ugKg6BzmCtnCoRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615057; c=relaxed/simple;
	bh=j6SwR74zPcLnawGyfD6E/DUW+Qkj4TkGT0i1w4bdZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ3cog36fcPS1syttCSZurtmwwKXW3jggAqLh8rInQWj63VLauFqkErE1u//IBXm7R3dPMTyI5YxHXzkcAfIaLart+hDAK6fmItmS9JxMlXCb9w7kBI0VPA44PfADKJxlrc32y9V1oVRaGwuI2j9edJ5SpYLtW5qIwWNhfUra/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxNGzkn2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8D5E11401E4;
	Mon, 14 Apr 2025 03:17:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 03:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744615054; x=1744701454; bh=iQIHwn72PtERMcqWnBytQofOT8EqjeadFEn
	JU+qbYuI=; b=QxNGzkn2FJrXyHlKJ5zrF8gw+8GBRCxrpaYcZAAHQ2ObHcNaFlg
	sXOi8NTSvQk4y/Rmz7HE4fPHka6JeM4W5SoQjzduO9g3c1+ztPW2v+kV/ddRTIV7
	l3JRfwzDxNym5LQdasR3gpn+qNfUoOwhAU/f8G0IV3m1PQhjJILc8REEPEnm9JCw
	UUcfT+eqH6BRhaThS6RIluF8N0ex1dD8/1zi+hpo3PiOCnZ4Dyq1COsu15zCd7F5
	SNkiiCCRIvKxsHFmrngR1hSOSBkop/qRRF7QOOE3ADA3KnF1FNZiTPLilV+lcCtp
	Ir6yG+PMsFa/24i3jY6MlIQsE5cSRsCkcnQ==
X-ME-Sender: <xms:jrb8Z3-KPK29vGE00FXtJGUFobdlgLMtDHpZP-mRVIGvlQ0yRtdTuA>
    <xme:jrb8ZzsuPz4Y5eUsPG_4SPK_emJyV78Z8icgoEhdisfUORYYbLWQNDtas4NiJ2AZk
    0sFeX3PWZFYVoA>
X-ME-Received: <xmr:jrb8Z1AJNAQb8H9fxLRKEJYV42cNBxWuUxg-4x5KMbbBQ9DaRCLNL0--P98A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgv
    lhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvud
    efveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesih
    guohhstghhrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehhrghnhhhuihhhuhhiheeshhhurgifvghirdgtohhmpdhrtghpthhtoh
    epughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:jrb8ZzdDKcXlzZPAjkRTpbMUYVaelaEb9OiB4pTuUNA-NIJ_lwQpPg>
    <xmx:jrb8Z8PM7OkJj-SzhGdOA2B6XifREg2qvYv8dL3wEgxDMxo3blFrzw>
    <xmx:jrb8Z1n9dLgPmI5WnYmWxkFoGyzz5lNsBZQ87XyasPOKvzn92xdiyg>
    <xmx:jrb8Z2tmF9SeG0mEzFAcsjNplRyU8DTstVFnixMIx4qG_ZG4DoP5-w>
    <xmx:jrb8Z2uQYy7Skd1zKaiIhorWpJWitoVXTgPSwHSSFCOy9Y04uSJ_XFdN>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:17:33 -0400 (EDT)
Date: Mon, 14 Apr 2025 10:17:31 +0300
From: Ido Schimmel <idosch@idosch.org>
To: hanhuihui <hanhuihui5@huawei.com>
Cc: dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] resume oif rule match l3mdev in fib_lookup
Message-ID: <Z_y2i05h0uLFnkhb@shredder>
References: <Z_V--XONvQZaFCJ8@shredder>
 <20250412131910.15559-1-hanhuihui5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412131910.15559-1-hanhuihui5@huawei.com>

On Sat, Apr 12, 2025 at 09:19:10PM +0800, hanhuihui wrote:
> flowi_oif will be reset if flowi_oif set to a l3mdev (e.g., VRF) device.
> This causes the oif rule to fail to match the l3mdev device in fib_lookup.
> Let's get back to previous behavior.
> 
> Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
> Signed-off-by: hanhuihui hanhuihui5@huawei.com
> ---
>  net/core/fib_rules.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index 4bc64d9..3c2a2db 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -268,7 +268,7 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
>  		goto out;
>  
>  	oifindex = READ_ONCE(rule->oifindex);
> -	if (oifindex && (oifindex != fl->flowi_oif))
> +	if (oifindex && (oifindex != (fl->flowi_l3mdev ? : fl->flowi_oif)))

This will prevent us from matching on the output device when the device
is enslaved to a VRF. We should try to match on L3 domain only if the
FIB rule matches on a VRF device. I will try to send a fix today (wasn't
feeling well in the last few days).

>  		goto out;
>  
>  	if ((rule->mark ^ fl->flowi_mark) & rule->mark_mask)
> -- 
> 2.27.0
> 

