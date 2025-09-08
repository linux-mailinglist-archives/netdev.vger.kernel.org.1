Return-Path: <netdev+bounces-220837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70FB4907A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2025934663E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAED30CD90;
	Mon,  8 Sep 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Bfj2Qnt8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5TRi9Uk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914730C63F
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339695; cv=none; b=n46PCHbsV4xYdz+xeVLCzmL4Dg4zdFKiSdCKR8S39YoN/6Imfx+n0+gGdSlgNpqformcvRbi0VSmyV79n67vFLa8tP3S9pez8jhiyITx8dGG2+c3Xxqxk60m26UL/lw5E6LmzsCYCsBdUP/nhn6wxwBwTwBWa8lf9d4oEqkw9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339695; c=relaxed/simple;
	bh=OJXDNX53MQ8EEN9uYOXtsOCqtHtQZvz3FVAIJwgBgZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFS1VcGDh4K3X0p5JgcClh1TzFu0oaAVeLvbHrTGYMJ4nSG7Xsz4OkxeSIRfviqMHYMC1IiPkHbnDuecLg6va/euVJOitypoTruGt29fGZieluF0X2/skO7TrgShTVVBBDxwMO70BERKmS7AdBzEjHu2gxWsJLOiKqmym1mBydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Bfj2Qnt8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5TRi9Uk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3EFA7A0109;
	Mon,  8 Sep 2025 09:54:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 09:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757339692; x=
	1757426092; bh=koMqeES2tH56wcG7rkvF2aRD2nxc6VqC9XQs3LmNwfg=; b=B
	fj2Qnt8YesAFmoDLrhAD5A6UHmK6unN4Q1+Wu+CzTn+x7OmNUNxqZZf0bKUQFi7u
	tVAxFkefUKACP2I2uShpo2kPdhoRmYmdpovMLF2yppH+QJWPJv1h5t2laXdE2XON
	pmTrTvtYUjaZXv2kH8skQ6CmKqq1IXx7nUwrh2YiY9qv66JLjS3VpZ/yMt+NBka+
	9uP5+PwSIZY9oh7zNeKZYS/jZoa2Cs2odt6IDmHdMR/BQJ4MUKHbyilXsSBwkuFj
	ZAG9+EVdT9X7k9kOgGVlM62CJ+9mqU1Ql8EXQbC3ycGopJX8Nu9LrK5IMgK8nW0D
	QhmJNJ4oif5nRgJsP8VuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757339692; x=1757426092; bh=koMqeES2tH56wcG7rkvF2aRD2nxc6VqC9XQ
	s3LmNwfg=; b=A5TRi9Uka1txd/QeFd0ytFIhLyPUjXQ+uX/DdjB2GWXuPuv2NSc
	qmcxrefcOJMJ07kHAy+zr57/8zdY7rJP6DNx05wSv0ksEckJLGlXax2HhvBUy6Du
	oeDxSn8yV2r8qxyyRQM3hULJxYopVHIsvZbM7E4b5oKShV6ortN8FMnWNBWvG3/d
	B8EGk8lIq1RYtkzDbi78yVAfzCv1CNwliZXfXEHpqi8te3xzHNo0t/piAGL42MLL
	fJlzl9y1uSpM34zH2nXP7rhZ2hjQmnW6QyBh1GhETaAKhZWDl6+nWQQXMzrJAOaO
	pn14zmXaYiBeUrYrDEPHVp1AhXNx23xStjA==
X-ME-Sender: <xms:LOC-aEn9TfvDkNYFpMu_miOce_pGyfn5a9875fEGD0gUktDI9sxJ8Q>
    <xme:LOC-aPimtlKF_o2Wbg-gKaVRaUA1s5yisMnrN-OqvwvIF2YsRDJ-8NxG43GnsdtNW
    q2UlXIjDqUXTSfEVPA>
X-ME-Received: <xmr:LOC-aPHo3H7pDFOY_w-weLW9epSGLTLLsVOmEjQ-5sR3Apiuzl24wxARSmaP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LOC-aJuMoZUgUDBEybW2i8fWWrGMAtVGUfQBqFu8ZqLOwNdVRREm6g>
    <xmx:LOC-aIeXArzligoCDNFoQx0QmCjI-Ghorzh0vhzwFTlfVoOnNC_OvA>
    <xmx:LOC-aHk3crfZJE09_8Ry64DfpvrzYnvMWB7UQuJHvE2GnQ-FYxU1oQ>
    <xmx:LOC-aDBldo1goZXnsqElBojX79zsogSbjzoGfHZ2FWzb9i3IUxzW6A>
    <xmx:LOC-aGKKoUdocg-OXNOv-e5-XZIbFQEqD0PXnp9EjiZoM-ba7Dmmcv-s>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 09:54:51 -0400 (EDT)
Date: Mon, 8 Sep 2025 15:54:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 4/9] ipv4: snmp: do not use SNMP_MIB_SENTINEL
 anymore
Message-ID: <aL7gKh7D4_bDw8XA@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-5-edumazet@google.com>

2025-09-05, 16:58:08 +0000, Eric Dumazet wrote:
> Use ARRAY_SIZE(), so that we know the limit at compile time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/proc.c | 65 +++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

