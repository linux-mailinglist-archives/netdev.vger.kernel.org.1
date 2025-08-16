Return-Path: <netdev+bounces-214274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE240B28B65
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273BAB60A69
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3257226D0D;
	Sat, 16 Aug 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh0DiUJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC05226CFD
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329265; cv=none; b=Wux0UgE6NGI4hdjZ66RrpmWReOIy8m8GyUWvHEQuoktUWQPRhVj7t9rdzXIBOx4vXzINRedoAbJZEn66UzPUj3HWs+WOq5Qy3AI28cr0bK/w2opxiE4r/vWdpSYEMFCMohpmKmmkLooxK80rTdjzetqub47XwNeL8dUobtFAuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329265; c=relaxed/simple;
	bh=5lgLmDZGzWV60KtO5256JLeMb6iSts3NhD470bV9oQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRKnOmpZGZuieD9fNNPa4pz2D4VmqPqHFUe5ZPPW6uDQ8z4qkJGlsZUTed72QFq9FGW3PW3BjI/pUKbc0Unt95W5k/nZvg4pGPOUbZ5nRKlYRpteNTCGnXtLsJNr6NClTehJqnop7c8fv7R7JJntfhVFBhOFZuEQjrWWLpVxotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh0DiUJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF517C4CEF0;
	Sat, 16 Aug 2025 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755329265;
	bh=5lgLmDZGzWV60KtO5256JLeMb6iSts3NhD470bV9oQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh0DiUJmD3B4rk7xQuOebbPfuTCfPIjB7rqh1dA8qYDzAJ2S/m7EJdFXNjkNWJRda
	 65nQyENzKLV16SUW2eQ9vGrOvTamLSs/K+6dN+dKfdnsPG+YeuTczwW1um3q4Ksb6N
	 V72hn3dW5LP6HuWz2Gilq89vHCMZ6E8yF2Nf7T/6Gwp4kPVKNQ//5/KjlCHZRY60B6
	 s6BNm5oBD6rt/jXGAYh4Gbfjgdwg3Ekv/hS8ScwN5+7slDXzFmLrgJNr8pQfrLd10w
	 gZm0Cx0gAbttYEHS8gTwSlvMuoG58bhXu3iXaYeIGi/l8MXln60sF7KfEoxz406X9A
	 RfrAilYyFNJJQ==
Date: Sat, 16 Aug 2025 00:26:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrea.mayer@uniroma2.it, dlebrun@google.com, netdev@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: Re: [PATCH net-next 2/3] ipv6: sr: Use HMAC-SHA1 and HMAC-SHA256
 library functions
Message-ID: <20250816072639.GA291962@sol>
References: <20250816031136.482400-3-ebiggers@kernel.org>
 <20250816070227.1904762-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816070227.1904762-1-kuniyu@google.com>

On Sat, Aug 16, 2025 at 07:01:28AM +0000, Kuniyuki Iwashima wrote:
> From: Eric Biggers <ebiggers@kernel.org>
> Date: Fri, 15 Aug 2025 20:11:35 -0700
> > @@ -106,79 +95,17 @@ static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct ipv6_sr_hdr *srh)
> >  		return NULL;
> >  
> >  	return tlv;
> >  }
> >  
> > -static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
> > -{
> > -	struct seg6_hmac_algo *algo;
> > -	int i, alg_count;
> > -
> > -	alg_count = ARRAY_SIZE(hmac_algos);
> > -	for (i = 0; i < alg_count; i++) {
> > -		algo = &hmac_algos[i];
> > -		if (algo->alg_id == alg_id)
> > -			return algo;
> > -	}
> > -
> > -	return NULL;
> > -}
> 
> This chunk will cause build failure when net.git is merged
> to net-next due to the patch below.  You may want to respin
> the series after this lands to net-next.
> 
> https://lore.kernel.org/netdev/20250815063845.85426-1-heminhong@kylinos.cn/

Thanks for pointing that out.  I hadn't seen that patch.  Patch 3 in my
series actually fixes the exact same problem, though in my patch it's
more of a side effect of preparing the HMAC key rather than the main
point of the patch.  If that patch lands first, I'll rebase my series.

We do need to decide whether the algorithm ID validation and key
preparation should be done in seg6_hmac_info_add() as in that patch, or
in seg6_genl_sethmac() as in my patch.  seg6_hmac_info_add() is fine I
guess, but let me know if you have a preference.

- Eric

