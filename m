Return-Path: <netdev+bounces-274589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oqv7E5qCzmmWoAYAu9opvQ
	(envelope-from <netdev+bounces-274589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:52:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F738AD40
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03875300B100
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411F3EBF07;
	Thu,  2 Apr 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JQOuF3xZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6fj7Gdg"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856473E0C45;
	Thu,  2 Apr 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141303; cv=none; b=SMx2Sbg6R2wvATyKVYqbm+o/tbNoxv5do0H/EiXWeQsQxIyRNBmsSawQS/+h9DbmeqgVMegebM2Jaf5Wfz+HT7ZQ/mdBC7YKmzA16Pn21BOzXyVlMVGCkiPDR8RumAdaeLC9ZQnn6sV7WPEmPQA1OEjd2u/PfOVk3e+IgqzytVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141303; c=relaxed/simple;
	bh=wMBQiCs9KWhb3wZSPanFzYW+/vuSCs/Zb0o1JRU+LuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB4EX2yb/83ECgQMLtoOYqi/B4jPFWqYl5uBRg0uwjFOpJMI0qk7ot6byIoK8EZAWjqlXTntVYUfMyqWpZVFZapTBTYqaCT2wamZz8DTY+EyDDCZl0Cw8tsrh32fSr+orL8BJZkTj9kw2SOmZD0xKJ2L2Ys70SFI/ALCkQ4Xgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JQOuF3xZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o6fj7Gdg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FE8E1400285;
	Thu,  2 Apr 2026 10:48:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 10:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775141299; x=
	1775227699; bh=Uy22VF3t2Ih4TkzJ7sG0SWRBj5Z6qy24lhBo/iuqstY=; b=J
	QOuF3xZzfcJdTLhXe56S4ktxQNVwn/qzKFiv/QB1/QjDraVGVPiEEbk6STzpVxSD
	TVHPa2Opj6ygsU9JlYP5YASAvUmfP53ZX47nu4JNjkKaxdZk2EdUdZqMrQrkDN7C
	5Om26AlKItU1lSlrrXOnTvEZcthuhtx9W87AOPksLWVPVaxAKxQUExyKPLoWNfKi
	UpQtmvsfwvdKXs28oc98nD/DlIxD49H33UWL25ybLIvkMF60twoMm1uygW1rhMIX
	Sa7/GPobuh7sFIHFBrxSp68InWA+KkqB+6W43iURYGYjW9wYPkTgbrivw14b0G/m
	RPVP63xj/UTTGPQxfkJ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775141299; x=1775227699; bh=Uy22VF3t2Ih4TkzJ7sG0SWRBj5Z6qy24lhB
	o/iuqstY=; b=o6fj7Gdg7iYzJrRg9IaOPXtMgrMI9TUnvVMowXXgt6erES9+f+B
	3GcmfXaJ77XQtzEb7TO6KqZ5lfcUdXFv8wRzuaOBsoBqtvEzSMUK0Iz3lPk5zVEJ
	oc7Y7Mn7PdgXn6BJmLZ6QNnlw7Mv65PEwbbnktXHyF/uE3PyV3rTFTg8a4vTjz/i
	1G/Lcm4V9vPEaZuW+RKY3q9JiUHQBwfgg+4Gq47ZcYIx7/yH49ejY1dMuCwamFsQ
	mu7plj7hn08+tc+j01L6lfKZORiKRWBsEBcm/df/hqS5FnwL2ouwr53MSkm8F3bo
	NwQpu3hYUvPB9oZehKJr38D7Zcmhd2z31Kw==
X-ME-Sender: <xms:s4HOaSEdvA4Aq4IqM5UUu-StRuYFXS-jBdVJ5xxCvQik2FBNwdb-ZQ>
    <xme:s4HOaU5KXvNQY5XWUb7ZfiQbCK5UqAYDsQzHJeqhMYf1p19FQboUbZrTkTqdjLhJW
    ie7NGerUGgfUQx2EhfZctVd-EPWhMIZK-sGHVxX6gQNnz1EnnW_sZk>
X-ME-Received: <xmr:s4HOabZNWsCpdjMTAsM6Ldwe2TMraKGG9OePwE5wNFGdlN6RiQ0JILqXu3xq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepleeujeeivdehheffleelvdffueeludfgjeegudduteeugfeuudejieegjeet
    vdeunecuffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhn
    vghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eptghrrghtihhusehnvhhiughirgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgufhesfhhomhhitghhvghvrdhmvg
X-ME-Proxy: <xmx:s4HOaShsC6sEVPyxSuDE4eIY-UmJ32k7KJKQui78K-bQ2hYADQ1BmQ>
    <xmx:s4HOadcKgkVeV6tmb37G_qYSs_bAJTpiant-zfdwAvNuHpIt8m1j7w>
    <xmx:s4HOaRlGujCpKwJk57R7guOgxtlew4CCTdYh_axryqEZJsf6wlGnjw>
    <xmx:s4HOaSxwRuRn4k_eCqbqvNSapxjH7cMsmqrdrPQjAaLSn2B5Nxr_bQ>
    <xmx:s4HOabqT9kTDEnx8SYWN30WEZCnhAGDVrsaXyeiaFbc_mObONajtFvLx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 10:48:17 -0400 (EDT)
Date: Thu, 2 Apr 2026 16:48:16 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Message-ID: <ac6BsG4IhAajip1s@krikkit>
References: <20260330130130.989236-1-cratiu@nvidia.com>
 <20260330130130.989236-5-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330130130.989236-5-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274589-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,queasysnail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 4B8F738AD40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-30, 16:01:30 +0300, Cosmin Ratiu wrote:
> @@ -2616,14 +2616,22 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
>  	if (!ops)
>  		return -EOPNOTSUPP;
>  
> -	macsec->offload = offload;
> -
>  	ctx.secy = &macsec->secy;
>  	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
>  					    : macsec_offload(ops->mdo_add_secy, &ctx);
> -	if (ret) {
> -		macsec->offload = prev_offload;
> +	if (ret)
>  		return ret;
> +
> +	/* Remove VLAN filters when disabling offload. */
> +	if (offload == MACSEC_OFFLOAD_OFF) {
> +		vlan_drop_rx_ctag_filter_info(dev);
> +		vlan_drop_rx_stag_filter_info(dev);
> +	}
> +	macsec->offload = offload;
> +	/* Add VLAN filters when enabling offload. */
> +	if (prev_offload == MACSEC_OFFLOAD_OFF) {
> +		vlan_get_rx_ctag_filter_info(dev);
> +		vlan_get_rx_stag_filter_info(dev);

Paolo pointed me to the sashiko review for this patch
https://sashiko.dev/#/patchset/20260330130130.989236-1-cratiu%40nvidia.com

A simple way to trigger this is to do s/VLAN_N_VID/500/ in
nsim_vlan_rx_*_vid.

For example:

echo 1 > /sys/bus/netdevsim/new_device
ip link add link eni1np1 macsec0 type macsec
ip link add link macsec0 macsec0.1 type vlan id 1
ip link add link macsec0 macsec0.1000 type vlan id 1000
ip link set macsec0 type macsec offload mac
cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/vlan      # empty


If this happens on a real device, the VLAN filters will be broken. I'm
not sure what the right behavior would be:

1. reject the request to enable offload
2. switch to promiscuous mode


OTOH maybe we don't need to care, since __netdev_update_features also
(kind of) ignores those errors:

echo 1 > /sys/bus/netdevsim/new_device
ethtool -K eni1np1 rx-vlan-filter off
ip link add link eni1np1 eni1np1.1 type vlan id 1
ip link add link eni1np1 eni1np1.1000 type vlan id 1000
cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/vlan      # empty as expected
ethtool -K eni1np1 rx-vlan-filter on                         # succeeds
ethtool -k eni1np1 | grep rx-vlan-filter                     # "rx-vlan-filter: on"
cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/vlan      # still empty because id=1000 was rejected
                                                             # and everything got rolled back
ip link add link eni1np1 eni1np1.123 type vlan id 123        # succeeds
cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/vlan      # only "ctag 123"


[at this point running
    ip link del eni1np1.1
or
    ethtool -K eni1np1 rx-vlan-filter off
will splat because vlan_filter_push_vids did a rollback/never added
id=1, and now we call vlan_kill_rx_filter_info, but that's specific to
this vid limit]

-- 
Sabrina

