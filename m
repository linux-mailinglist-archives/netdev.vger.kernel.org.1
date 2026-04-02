Return-Path: <netdev+bounces-274503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mArRHddZzml2nAYAu9opvQ
	(envelope-from <netdev+bounces-274503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:58:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2017F388AD7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DD943007A59
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E103C5DCA;
	Thu,  2 Apr 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ioOLEhK9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ozLlAdi6"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBA3CA49D;
	Thu,  2 Apr 2026 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130309; cv=none; b=i8eUTIooXDv3oeRLhnBC2fzLYcywlWoThRdRa9e2x/mTLO7Y2lbzBvdWvEIs/aTtrolIrKvDNnVuIE6YrzitlJwbjGQJRfDWYdB8n0vm6JdEISJGCoDMHdBCbewcTHSSTP5flCaLNh6GoTBGGZJpGSKovzK6mfq5TFK2CF0q43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130309; c=relaxed/simple;
	bh=bLJ24ALkCOyv2BYpQw/HvK9MHn5DT7Sn4UhQSFyAfjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/VBrb46t8sFyssSK8tVa4jX7aWnyhOjisb1STtm/DoEFBC/6LIZCPOESTim/6nllAmLoeoT1xDIUeeclzlA/OGKGCb7I8vD+efmrHPe0eTZ9Cc3FLwyUrM99GcqXcJgZjQ1v5KaccuLKu9WkbVLsSRsOP8bh8CnVjnGhihaS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ioOLEhK9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ozLlAdi6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BFFF9EC0218;
	Thu,  2 Apr 2026 07:44:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 07:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775130298; x=
	1775216698; bh=wt4uugK6D4ZSntGA1q6SDx8XBsohHO+lhiewq/9Xgvw=; b=i
	oOLEhK9nssd9R6HghZyHBi1rEMxENTyHaHwBQJRaHZdqMuGd3jYn2yFsb0kpxDQ1
	QtX7zs6/7ug35A0jkFQ7ircy2cePssUmZOkyX53yn0hY2BvCHziMbQGKm8D+XaKQ
	mmDgK/xEpFKvop3LyQ6YJJfqHkN/CgkVwIWKtkbD12GiAmt0vUEPde0sFosGIuyQ
	SxWGG/J5DHKj3X+SO1nCi4c1s7H/tzo/q54rZGJutg4R8rHyrNUs6cRe3vEeK+im
	8pg9HuiYb8RSWlK3xhrvXvS7gVkYGCBqPFvzg5DkeyLerTvWWhD40mjvM0KGdYkQ
	VsCBdp+M/t+SLNXSLxi7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775130298; x=1775216698; bh=wt4uugK6D4ZSntGA1q6SDx8XBsohHO+lhie
	wq/9Xgvw=; b=ozLlAdi6W8fOUZ8Ge/fy8hmrZrhk6Y1F/KO+wQw6SJNhez+Bqfh
	L7w/dUaVI3Gamy5b+jt3DyR670gaN8AxY45B/gt61ufbxrmFQrax1eSnzKW5VR/P
	7O/YsPC/i1CyopBund8IXZ5OubI7y4Aam6dDpTrS0nHmYCzmNVJuvDLkm7Fgv1+2
	4yhePqm6vzwJYi2OFneC/Nbml5jUlzhKP+hi+3J4xBX5rGm+U+3fcnFR3dW0jZxy
	6aF1yvWnuO259lWPrFsKKDOlgCYdcA/iJKP0veZCBx0HquZxsuX41U3bFOazA671
	cx1qt5AnZuPjNUfwHU/WiCnuf3TSM+0SWJQ==
X-ME-Sender: <xms:ulbOafVy-Z81-pDpRiclOMqIR05sgQZ1_5DDa8hx5sG-jVg778CRbA>
    <xme:ulbOaeGvxw-KGHKORN69Ff8mspZVRC-kXW6M4hpKyasSHBEHkyjUhsBSV6ceaK6na
    vNJ7MRczbmGmBrBOSQAc3HYH9t1G7Xsk87IFAP0aAgW3v0OUwYLFCNb>
X-ME-Received: <xmr:ulbOaZYTYPoyp8dL7yMySQgCMlApm9ZCD8MJ1hATkLRP0UT2AvzLx1Slsf5K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvg
X-ME-Proxy: <xmx:ulbOadFmcxwB2DUryfK3wvXpmQqg5N5t6sMUj45Xr7iqD73tEL2SVQ>
    <xmx:ulbOaf1vHEwRmMJiCeAi_FNtMevy_0ttGgr5HGiX1f7vTwMvWu-jIw>
    <xmx:ulbOaRzwujWuEKdtuWUyES42h3l_YxRiARQIekWeHdQICQ19OAialA>
    <xmx:ulbOaYixmD0lATDNB7KMdvSG9pUEpZuKdiaH0GFQrKWTkcZP0NX3hg>
    <xmx:ulbOaV2jqx3nXEOqVfm3bLzCFMPqxbdBDvoiT1RRlbt1ylpzeI4pyLPj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 07:44:57 -0400 (EDT)
Date: Thu, 2 Apr 2026 13:44:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, David Wei <dw@davidwei.uk>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v7 0/4] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <ac5Wt4vWxHMTcsae@krikkit>
References: <20260402111034.1494714-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402111034.1494714-1-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2017F388AD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-02, 14:10:30 +0300, Cosmin Ratiu wrote:
> This short series adds support for VLANs in MACsec devices when offload
> mode is enabled. This allows VLAN netdevs on top of MACsec netdevs to
> function, which accidentally used to be the case in the past, but was
> broken. This series adds back proper support.
> 
> As part of this, the existing nsim-only MACsec offload tests were
> translated to Python so they can run against real HW and new
> traffic-based tests were added for VLAN filter propagation, since
> there's currently no uAPI to check VLAN filters.
> 
> ---
> 
> V7: 
> - Added missing ethtool feature checks.

Sorry that I couldn't get to your patches earlier (-EBUSY, progressing
toward -ENOTRECOVERABLE), but please don't rush to repost while I was
still going through what you had already posted.

-- 
Sabrina

