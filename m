Return-Path: <netdev+bounces-202941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EBDAEFCA9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB988189968A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3831C2737FB;
	Tue,  1 Jul 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="irP1kLzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+MmPHZZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD03C47B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380393; cv=none; b=eUdgaEbIvh77sLKDpTJekjwYAcMtj6lncG38MfHWTH7q2/QBHFGq6wugUPQZR/o/ZiXMWFsiLkFmMUptsuJwvY7RHMEsb6I7fXf0cEaBb5XFl5mM5nDTe8Ux8JEjYAQMKqhnaXaPfsF3Zwp6pyrOXBgPUSe8bi02/9uNlXMJPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380393; c=relaxed/simple;
	bh=xhoyR0CNPKxbgsZtKH9XLz+2Tk+c/3ZFzUNaYyNRsbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz3pRng4sTmnJfdIXRi1bh/TM3rI7l5DQBOjWjahIIUdN56GKYj+ld67xyA8WYJ8xjzkouS9460ppRxd0evdqwtqvLTO90w7z20qhfnmLvOVuB5Pr3vQYfH3zzTarWZ/TZDFPPEOyo7XnAwDTlBzi1E07wR0dnlAoAnImbtlthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=irP1kLzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+MmPHZZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BD1B31D0014A;
	Tue,  1 Jul 2025 10:33:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 10:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751380388; x=
	1751466788; bh=M5LRWx9bVGNHVJf4kXtD7I0Z8IU6nJMKvhV8HCxkvZM=; b=i
	rP1kLzGboLqwwRlt6x8QvoWpBtug3yCVveX2YXXmkfatPo3KKyoGVoEwKRqlkDTF
	1Hy8D/eVXAmJkdNbYkEfBZXCUj4VkHDAr2adPn++1UvoWhIoEY+J7BfnYvWQK5Ce
	4hebw8oIPcz9Fl5nr/gi8ppUzBhkYa34rD1LwQlugW1ICI8JF+kARUf0m/+fBZk4
	vMCodEijk9k4F8L6bRjSOPXVN0ATBa1+kK3m/Y2jMqGsoffJf3lcDX8EW6siDxg4
	2T7xad1mpzskjxgYTsrCDiE1daGicNcPOJ8r+n9V/MWUCjMmPyDt4ENlpv3dwEEL
	SZSWK40r5bXT9B4unLnPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751380388; x=1751466788; bh=M5LRWx9bVGNHVJf4kXtD7I0Z8IU6nJMKvhV
	8HCxkvZM=; b=U+MmPHZZJ0FWyvaR/KRRmxB8nw+U9vz5kypGzLg7Ca2V1Iky2WN
	2RXjPK1PUTo896IixboH3WLrIBou9zXzRvLCHR3pfkP1kSAPSlEtyUK3vRjYf1jo
	5g0MYP26NOzPJELHEy/5837+lW3EXduMwnxTZtNDHHh+y6+Yu8Yt89kPI5mY+63s
	CrkJtyrXpCTWfsngIqsuZQdBF7KFUNx5ipAx07b1HSQjGy0iBz1aoLAX8DvsoU4p
	T+bDVCz+xidlteVQqXymo5bnWSLsBW7J55VT1kVeaJyF7MweXn7EopkJ3UgMAQL+
	PrMfZJ8g2uTKsc7K+/osnXFlYBGP2MoPSJg==
X-ME-Sender: <xms:o_FjaHcWfh5NdgSxNGcbgO4rorLAxJWbgjgL-96kQ_eSToP6JALW6A>
    <xme:o_FjaNOWiHM_JjzWBLo-hwiCEP2gw5lNlmE6KSBZZl6Dn7iqI0aFOKdf6jzh-Jv0t
    QcV2IPXw_Zl4Yvhxk4>
X-ME-Received: <xmr:o_FjaAgijuThUM1WdDDjEi-SsreDrWW3cjwQVuFHKp07THwWC5cC4umV6oSZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghtvghnrghrtheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvnhhglhhonhhgkedrughonhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:o_FjaI8ZW5eLYfbAp2ErXHg7VgqIA_drh40nfI82eHhtPY8wketYTg>
    <xmx:o_FjaDsg2BhfIulXfvLpoW_IztCEuXJsT0VDhqwqe5WH_9UerN90pA>
    <xmx:o_FjaHFXRSJ9ZVwtgL8vS-nF4S0K_4FLKSRJBRl4Y9L2igc1jEA__Q>
    <xmx:o_FjaKNS3_BrL4LAyR3MEqjJct1dXKZejBpt3N5xV2JPnSA8YOehjQ>
    <xmx:pPFjaEDt0Yl5JtyCe-aOcIBxhjw5siABX_Yu0rU8u8xQmFTmA1rD-4zc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 10:33:07 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:33:05 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: fix stat increase when udp early demux
 drops the packet
Message-ID: <aGPxoZsW8_qa5gyF@krikkit>
References: <20250701074935.144134-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701074935.144134-1-atenart@kernel.org>

2025-07-01, 09:49:34 +0200, Antoine Tenart wrote:
> udp_v4_early_demux now returns drop reasons as it either returns 0 or
> ip_mc_validate_source, which returns itself a drop reason. However its
> use was not converted in ip_rcv_finish_core and the drop reason is
> ignored, leading to potentially skipping increasing LINUX_MIB_IPRPFILTER
> if the drop reason is SKB_DROP_REASON_IP_RPFILTER.
> 
> This is a fix and we're not converting udp_v4_early_demux to explicitly
> return a drop reason to ease backports; this can be done as a follow-up.
> 
> Fixes: d46f827016d8 ("net: ip: make ip_mc_validate_source() return drop reason")
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
> Changes in v2:
>   - Reset the drop reason to NOT_SPECIFIED if not returning early. The
>     diff remains small and this aligns with the rest of the function.
> ---
>  net/ipv4/ip_input.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Antoine.

-- 
Sabrina

