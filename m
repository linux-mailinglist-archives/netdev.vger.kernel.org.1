Return-Path: <netdev+bounces-210943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D312B15E19
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A7856000D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88B275867;
	Wed, 30 Jul 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gK/NGT1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ha5X9Hc8"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E784D13
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871202; cv=none; b=U9bF9lUw6r1WUTTCC3wkYAuGQUfOm+w/NvfYjAMSfjHRrmNmRnlwGMSu1SdGgV17Q2/WIjEKn7VqYSwOBsDxfmpj0Ag+Pp/IdHIJ3332YO3MrM4FuttHEiqWBxICmQYe/7UtaVE9CAFnmH5adKc2NAnPROlhHrG1jkBbqSgbzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871202; c=relaxed/simple;
	bh=jYlby3J5Yujsoi785Td6sYdTpujnP5w3Qxgj12s+Zuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsqaKCSRrgsLR30+g9WK54hqkFsct9o26AEaCKiWlIX3TtuKIfj4zqLiyE1OfTpA5OQkfm09iy87tlDLy/kbMPHB4iD/7bu1AvVLuc2XOvaZuKTTLD8rfWvpxaDAzRXQNzN5tILfIRgAnTt5UTc9YNH9sWkdU8eN4kx23mSLQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gK/NGT1b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ha5X9Hc8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B5ADAEC20F2;
	Wed, 30 Jul 2025 06:26:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 06:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753871196; x=
	1753957596; bh=gBs5IB71R0/S8kKi+HXCzIurBgH3zlnTdbgJ4fqb3HA=; b=g
	K/NGT1bYIt8Z36mUkWgtcvyhetTJdPXtdGcJAwkwENhG91MVZX9/ae/OoplOQ99p
	o7ZfgD20JohbWN2gR25Ajtz3a8e+PT9TXm426HtTdxk/rbbaD2giq3+UpZaw9dGX
	FpplBBs5+7KDgs0z+AZiQ3nAlbRPiGvr2392HUcnLJE/i2sezCt4Ruue2FOkme4k
	2hDm6NhjubkuTMcBrVOd7Z4R60XNUlIDKuHD0F7WwQkXaqja2mm/lcOGGHe9HinE
	s1aeGfhcg+K/cECU0vhrwPX5INtv397wuG6TSCvWjjJ+kARd6a+9pNFoUBry//Ec
	hm9g9biuWilYiGsNIEKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753871196; x=1753957596; bh=gBs5IB71R0/S8kKi+HXCzIurBgH3zlnTdbg
	J4fqb3HA=; b=ha5X9Hc8G6yCXxrgSjAskQ137MxNUV2q/2o1KflqsNofOOg4Olu
	SneMyPH5tYWezkhn0+V4xCOAfeXjk+9cE15rQ91uKPPqn+nQMAY2LdKndFV1VbKZ
	HiDqvpB4TISnTZd/AuXToKz53t63wOl+x4U24n/QVDBwRV7tNtt82M+KYMbtkWzX
	32PjmoyelNpCk+e6uRcsnom+mSEgtQgI3oPTl6AvEgKB8korxoU72Fswx5Eq+Xhg
	BHc35T2rDUC0bLasARtytBBW9lNzAb1EmDgRt6C9RO/m7tLsjMt23+VewDTf6qpE
	ENkEYwbOFeFXTh2CpSFonfQM5ejgmoyZAzw==
X-ME-Sender: <xms:XPOJaBQ-IF3l13r1yNcoMvTBTFwNHPkqTK_16RXH9RngSYTeL-8oYA>
    <xme:XPOJaGT5AtRtpHSI0A4Vsyx8cDlWeiiei0FypelmWYtxzHdDzvk-l1Bkp_tomjyK8
    9J2Q_lI3kNuj8HmMAA>
X-ME-Received: <xmr:XPOJaNQxJReM4kjlPTkOxa1LHY2DPOUOQwGK2Rp_g7R2AWo0Rg2P-YEqIjN5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejkeelveelkeefgfeuheevjeeukedvhedvueegvdekleeghfelgeeiveff
    tdeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlvghonhhrohesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrg
    gtkhifrghllhdrohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthes
    shgvtghunhgvthdrtghomh
X-ME-Proxy: <xmx:XPOJaD5sIEIzpkoX7nWC4ObP61RCrFXtqklHtqaOGka5WIJBGqu1Mg>
    <xmx:XPOJaB0kMtrxfndR49I5qdOXgMEOpJCsKJ76Z_EU-4SBTI0FzVORhw>
    <xmx:XPOJaGC2wLpJoA189MvZb4JWDConykj8DNehmFGjNpQRSE_-rRMJkw>
    <xmx:XPOJaEMo2f8i8zkXShUenHsJJlSa79xYAG1Xcr4RhXfwtHRnxEtYHQ>
    <xmx:XPOJaNpxknjAQTzZzd5nuAzA6rm_OTewEjBCzdfL0mGOhImWromQm557>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 06:26:35 -0400 (EDT)
Date: Wed, 30 Jul 2025 12:26:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check
 from validate_xmit_xfrm"
Message-ID: <aInzWYscMcTRylVg@krikkit>
References: <cover.1753631391.git.sd@queasysnail.net>
 <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
 <6d307bb5f84cdc4bb2cbd24b27dc00969eabe86e.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d307bb5f84cdc4bb2cbd24b27dc00969eabe86e.camel@nvidia.com>

2025-07-29, 15:27:39 +0000, Cosmin Ratiu wrote:
> On Mon, 2025-07-28 at 17:17 +0200, Sabrina Dubroca wrote:
> > This reverts commit d53dda291bbd993a29b84d358d282076e3d01506.
> > 
> > This change causes traffic using GSO with SW crypto running through a
> > NIC capable of HW offload to no longer get segmented during
> > validate_xmit_xfrm.
> > 
> > Fixes: d53dda291bbd ("xfrm: Remove unneeded device check from
> > validate_xmit_xfrm")
> > 
> 
> Thanks for the fix, but I'm curious about details.
> 
> In that commit, I tried to map all of the possible code paths. Can you
> please explain what code paths I missed that need real_dev given that
> only bonding should use it now?

After running some more tests, it's not about real_dev, it's the other
check ("unlikely(x->xso.dev != dev)" below) that you also removed in
that patch that causes the issue in my setup. I don't know how you
decided that it should be dropped, since it predates bonding's ipsec
offload.
The codepath is the usual:
__dev_queue_xmit -> validate_xmit_skb -> validate_xmit_xfrm

Since the commit message made the incorrect claim "ESP offload off:
validate_xmit_xfrm returns early on !xo." I didn't check if a partial
revert was enough to fix the issue. My bad.

-- 
Sabrina

