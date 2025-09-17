Return-Path: <netdev+bounces-224102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056EB80B81
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1788C7BB953
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE2E341379;
	Wed, 17 Sep 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Cq3oyj5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOGB0u4d"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7B34137C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123952; cv=none; b=I2YOqbc9Pzl+Ebam2wUSa9+/tsWyc24xqencdGgm6kwV7hU71U11XA/W6rzFWy4V4iSQLiiXGsVL7ypw7JaCo4b14fFG1DCuG5NqZiPd6Mio/KarpDQ2yXLjnXnO8kyBH4HcQ/aMaB9SyivjdNo365xECPvq+RJlNjgWYBaVy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123952; c=relaxed/simple;
	bh=l246g3Xr6quwtSd+ppry0mbwERAmMkSn9r9ymesoL3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IatBo1H5JbFhv3FI0yp44p+fF9h33m2CriWYU2J6PnMLTecTOBD8BemazRyJyojttQ2mtCHIGMM6/A3+lwxvqOBFq0oSR4LXEj2dYwkTZRYPNAyOwSG/YSIFANj0+MaX38H4rC2yDuDNkmIVVHk8O112DXMuBTYHgv2U/WCL8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Cq3oyj5Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOGB0u4d; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 352257A025F;
	Wed, 17 Sep 2025 11:45:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 11:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758123948; x=
	1758210348; bh=HGRwnYimjwr9i8ofPPsfwEH3vIpHU4VAoRFD/nq3EFU=; b=C
	q3oyj5YGV2+QIfYQ4giuK6svHYTMtAHijcU5QC3wAUQBHEeZuyMpFKjrzWqB+NG6
	ozER5wD4zEc8D1lGfQO5gEC6OaT3GdpCcQHcHlVmwaCTyMTZyHyad4z1N4tsOR8v
	7Essd4Gly/fZRyvWuiNjOv6hmCRp1NgyAoUlXnardo1y7RQTqPaOkI5f6uLlGiDy
	01Q+l6DAgVG53XTnPO5QBM8ev7/LVUZ5fay5T3zqwUrrZkBRxlpUssR+hylVzewA
	YamsAJBT29QjObIxzBfaBLDUA9zyPIq9L5HbJqpT13gGceES9H5glfQlYchhwc+u
	8gByHXB2gZYH20HeyZwGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758123948; x=1758210348; bh=HGRwnYimjwr9i8ofPPsfwEH3vIpHU4VAoRF
	D/nq3EFU=; b=BOGB0u4dhY6mZo1NyIg6glBNhkh3H0vbg5y2PCyPZTTbrSWPP9m
	kiwn29yniMp4zNjinLMVmp/t+IvKE7I9zSyKbA72KRiIC95mhzPZwkm0ZrwXBpH4
	gILCOAOdO+6UYJPkzGoJGFl4sxbyQWZni7P7j/d9gzqubf7mTnFOaDplha6fsX9B
	ZkULjXMdYgTEEVLXJwh9R/MWHXUnUM8K2YnLTw+ZKajuKM1lZ24h9k/pE/YvvXL9
	dH+2rXs7UjrNF1uJ77VR1Wa0ABEnD4ucPARU3JUevBJPyT0ObKgtkoJiMSGGrLrj
	hdd9V2wV4TWVYbniMZsKs6TlFV1w+t7nx7w==
X-ME-Sender: <xms:q9fKaHLtHqg1BUlQ7a2w0OHvhRBcVtj6sG6pFkPw5Y8uQAHBreT60A>
    <xme:q9fKaG2-PZNj1oetvCD48msB3is_XMr_ZNdPc_PX9bctFRnYgN6AJ7BxH9E0CsgIa
    akIaDvbb5grHRTBEPw>
X-ME-Received: <xmr:q9fKaMIDUW0VVV1qGa-KdfTT-9D22K7oij4yX18Sc1YQKehQT0BSlk0lZ_Z_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihihuhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhiudekge
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:q9fKaJi91GPwmB2UmzyT4lspcbzexWRI34ClZvZxNa7HBrb9_kOXDw>
    <xmx:q9fKaEDBDRWRAnmaDtyvbKtxo_QiPGq5w6scix6PqXIypnOE7SM_ig>
    <xmx:q9fKaD4xO40GQ9Scml5MwCblw3XmxGffMtkTvMTmH1jvP4HiSxJb0A>
    <xmx:q9fKaBG8CzxifBCgzgMJ3_C_RCnFua1LArRTt8hYO_FE06mt2LMqcQ>
    <xmx:rNfKaDtVnTEBdNQ-2FIfUZf_FRaihgvuBHvV3IkiQUtPzkVeJm_Z_j8w>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 11:45:46 -0400 (EDT)
Date: Wed, 17 Sep 2025 17:45:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Ilya Lesokhin <ilyal@mellanox.com>
Subject: Re: [PATCH v2 net-next 5/7] tls: Use __sk_dst_get() and
 dst_dev_rcu() in get_netdev_for_sock().
Message-ID: <aMrXqeATjFj2Ak4c@krikkit>
References: <20250916214758.650211-1-kuniyu@google.com>
 <20250916214758.650211-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916214758.650211-6-kuniyu@google.com>

2025-09-16, 21:47:23 +0000, Kuniyuki Iwashima wrote:
> get_netdev_for_sock() is called during setsockopt(),
> so not under RCU.
> 
> Using sk_dst_get(sk)->dev could trigger UAF.
> 
> Let's use __sk_dst_get() and dst_dev_rcu().
> 
> Note that the only ->ndo_sk_get_lower_dev() user is
> bond_sk_get_lower_dev(), which uses RCU.
> 
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

