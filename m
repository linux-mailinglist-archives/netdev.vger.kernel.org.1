Return-Path: <netdev+bounces-214405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA6B2944F
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391851966597
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F82FD1AD;
	Sun, 17 Aug 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cL1YHVp2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE56245006
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449888; cv=none; b=cNWohOudt3IgPeExY2iBOXQI9HVgGpeiogZW9yY6k+ecoXbaBJsW3QumzZpWAYrB16ySKdeXTUcZsyyb5XF/2lopanhOLiB1fJXjZS58k2NyYyzJUqSSamJi7BdpR8JzyYgJRYTkH9a7hnsYjckFuzNeBH5QEUXf2WmduGy9Oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449888; c=relaxed/simple;
	bh=dZZs/Hlm7qFOTJeTJJnuNBkTXUeFU5g7unhg89fcJdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6XIRkaA8tjXHLavFYQY2A2/o+CVc1iR6CWNZMZAHUPmm38dnZCo8t1vnHhQanHjBEwNcXdLyPwykawXAgLt5ejviVoJk2kHujWbNZaTntYEXMkwllVe+QOuTCbRNRYMkFiZOER/K1XsbTbqQPmTFVxzW8sNq2GySUopjTJE6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cL1YHVp2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 675141400045;
	Sun, 17 Aug 2025 12:58:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 17 Aug 2025 12:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755449885; x=1755536285; bh=LTFB6H4XgQdjW1q59gBpOXXnyiu7mjy6UGO
	DZG+CLO8=; b=cL1YHVp2vFrToUs7vssTVGBbWo/CmvQ4UqBvTfcouoI1Rf1bzOT
	xO8DSd7cet5n3rSKumjky8tb+rDYHMpEmJ9Fetu+R1w5DsSNpEGdQHL4A/+oYMqk
	d4PZOsYmo3w2x+t19qQi4Rn34Zr17LrNsTMojIEKzwNWhzjVVcBDuYfLTtCq68n1
	sEWNupTC4qp9Co8q0woqA91vj7Ozq01ilNRhKudL7vUKKy6a5YMNS0WHB5YTse0d
	3LqtTCP+C+uP+/oMhsxAz4Lm48AP/xWesqVdsjS+S+eY5/8D6Sr06Tyzxt2JStOo
	2GwTBXJr36tsr05LuhIFMinKWXcF0fbplAA==
X-ME-Sender: <xms:GwqiaK3qqQJdLZ1eEV5vuEisbvhyFXj79OusnKOmIh0Zw0fS5-UBVw>
    <xme:GwqiaFi0b3EU1ZrOx7jglkLgKpBVABMK6PCs-smExbxoc6EQa2cEsy3zAFmlq0F55
    UPGYRhVksOOBtQ>
X-ME-Received: <xmr:GwqiaDVJpB2idY5QLyL5UF22tuInDgtPWT0DBL5Tu4lr0JSIngGOSIpKfnCv0eot3fFAylzhIF08nsKINZ-0nw97L5K8qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvsghigh
    hgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusehgohhoghhl
    vgdrtghomhdprhgtphhtthhopegrnhgurhgvrgdrmhgrhigvrhesuhhnihhrohhmrgdvrd
    hithdprhgtphhtthhopegulhgvsghruhhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghmih
    hnhhhonhhgsehkhihlihhnohhsrdgtnh
X-ME-Proxy: <xmx:GwqiaMWYChKC67NowULMKdjuB_o0A6ZOREypu9OZuppA18QriaaAyA>
    <xmx:GwqiaLgokG7hn__AxfX6TaAuUYwZ0r4FYiEZx7pFj2UfPU-bJm25aQ>
    <xmx:GwqiaPYcn7_Xg5-urWuTbJk9G3SPdHNUh8lhBzVGUx4iR18sAAUzSw>
    <xmx:GwqiaApdWpBm2pu1SDEiYsgyraFg57oGQqKwnfjbwaOtDgWH7_XW4Q>
    <xmx:HQqiaDm_qzxB7IzS9jUPuNhopxZy1veOV_vJ5XuyQEi3Ewj-FRHpLb_D>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 12:58:03 -0400 (EDT)
Date: Sun, 17 Aug 2025 19:58:00 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, andrea.mayer@uniroma2.it,
	dlebrun@google.com, netdev@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: Re: [PATCH net-next 2/3] ipv6: sr: Use HMAC-SHA1 and HMAC-SHA256
 library functions
Message-ID: <aKIKGI72EklLRfwO@shredder>
References: <20250816031136.482400-3-ebiggers@kernel.org>
 <20250816070227.1904762-1-kuniyu@google.com>
 <20250816072639.GA291962@sol>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816072639.GA291962@sol>

On Sat, Aug 16, 2025 at 12:26:39AM -0700, Eric Biggers wrote:
> On Sat, Aug 16, 2025 at 07:01:28AM +0000, Kuniyuki Iwashima wrote:
> > From: Eric Biggers <ebiggers@kernel.org>
> > Date: Fri, 15 Aug 2025 20:11:35 -0700
> > > @@ -106,79 +95,17 @@ static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct ipv6_sr_hdr *srh)
> > >  		return NULL;
> > >  
> > >  	return tlv;
> > >  }
> > >  
> > > -static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
> > > -{
> > > -	struct seg6_hmac_algo *algo;
> > > -	int i, alg_count;
> > > -
> > > -	alg_count = ARRAY_SIZE(hmac_algos);
> > > -	for (i = 0; i < alg_count; i++) {
> > > -		algo = &hmac_algos[i];
> > > -		if (algo->alg_id == alg_id)
> > > -			return algo;
> > > -	}
> > > -
> > > -	return NULL;
> > > -}
> > 
> > This chunk will cause build failure when net.git is merged
> > to net-next due to the patch below.  You may want to respin
> > the series after this lands to net-next.
> > 
> > https://lore.kernel.org/netdev/20250815063845.85426-1-heminhong@kylinos.cn/
> 
> Thanks for pointing that out.  I hadn't seen that patch.  Patch 3 in my
> series actually fixes the exact same problem, though in my patch it's
> more of a side effect of preparing the HMAC key rather than the main
> point of the patch.  If that patch lands first, I'll rebase my series.
> 
> We do need to decide whether the algorithm ID validation and key
> preparation should be done in seg6_hmac_info_add() as in that patch, or
> in seg6_genl_sethmac() as in my patch.  seg6_hmac_info_add() is fine I
> guess, but let me know if you have a preference.

FWIW, I think that as you have it now is fine given the other parameters
are also validated in seg6_genl_sethmac(). Exposing __hmac_get_algo()
seemed wrong to me so I suggested either moving the check to
seg6_hmac_info_add() or exposing something like 'bool
seg6_hmac_algo_is_valid(u8 alg_id)' which internally calls
__hmac_get_algo().

