Return-Path: <netdev+bounces-119290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AA95511C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A5B284A8D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCAA1C37BF;
	Fri, 16 Aug 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l04tZdMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40D1C37AE
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834501; cv=none; b=hQgXed9o6DWl7mgKKHV7OLjampzHGKw63fJ3xwfVSBj0DxBs7e0An+Sgk+LgTKEXSAwzriG9EEd6G9Jfq0yUTH6yJyJ3cOhhyLMrp+4KlNl22jojNpmrVZIQ1+NPFTmQaPHC8+aeujthK+nOkXie25o8hj2KGKofjJVSSxVVoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834501; c=relaxed/simple;
	bh=2+L2EWdiLx3gFyrOqJ1/eXE4cjytF3yRoztLa0EE5EM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Nt2i8tlOauWdlXA16Ga21IabvvNoCvWYuTrsgbG3+m6pwOa5rSuK4Rh+8kCeAGjCJuWDaaeVCvLE1pLo4TiThQGUl/vmnVQJuRsP7S20saYzGJKqWuwQi387CIA7BTf4PCstwtmvCO43OMXSCpb9CSxxPNfKG39ir/ugD+C2LpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l04tZdMO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fe106616eso13154471cf.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723834499; x=1724439299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RBYjjnrmmphVDoGmqusomgPl8FE1Ki8nWpmQ97A8Ps=;
        b=l04tZdMOk2WiwtgbKnqMcLJDlIb+t0cTKdUvDvZk36yNAqqAfF4tltsiR+Vsm0kkhh
         1zzKnZ7XsxUiV7MWsLY/xw+Z7UydLOsiIIss14ErHiYnypX9NRaQFRn3avFUK5M1DXTt
         OiDUIZCZVfuWxwiB0MtRBg0Ig0SlQcyjFjHs38+rg8rEP693ClVRsz8PlsNsWw18sYW3
         CRalkR6cbRYaIIJBmVRNAM1rimjPTxIWvHy5IAMs1Z6wOvrr6Ox2LMHEEDYjpeQxPSwg
         nTWw3ruvMUtn+ALCSwPD6/rgzYGdBtg4rjIP8dV4ZWBWwGbPYVllPc3tHQ6zRiKmMjA7
         EuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723834499; x=1724439299;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RBYjjnrmmphVDoGmqusomgPl8FE1Ki8nWpmQ97A8Ps=;
        b=PTWTZoC5bOHIDr1RgU58bWnkx4DZnBEn5cVoKrYJUsvC+H2EBnoeenHG9mNZ8eirdY
         Q/3Xur535i0NncSeEFp//W2bUQmMgS1rPcUcL9iPtxF4lHVrs4idZyy+oAu2EKeb1YoO
         P4kILl47h6/y0Yg+dptvOThLrdLbKlr1SPCjEK53/PE5z1z+YB51+M1gRZ9CXFG9lWBc
         hfXKL5erzu6xGGpOl03aW4RzqdHufI/jRykPHteEh0PRYK8mSVJvBEDgMd5i30LhUn7m
         FBZEtCViiGG+I1C7CcuCCNYe8jf3cCJv6bIdC5GoEWMH5sq9UiYU31860yx4UL5GL2vj
         TbPw==
X-Forwarded-Encrypted: i=1; AJvYcCWcukEBtVbAItXPdzvzs2wRgGtWBl+WkPBG+iR180UHL46t2Rgq749JH3WohrzS/77uRc5nYDCLgg78oyJ2X0DeFmQ8+AKF
X-Gm-Message-State: AOJu0YwMs/7vzmAEu//w7WWD0cqzFNnZNMYb4N+KmV9QWaDRttdCuVkp
	McSr1sxvi/HidnXRSsLaxKc88LcbmkIbD+E5XTNc/yfEpQwQe2qa
X-Google-Smtp-Source: AGHT+IEe63HGrjMSbkoQdZwXiAcjEAPLnWC1msUYfZwH3Nf3UrVy3qPVRK/B7kwWKb7NhjkChNCEag==
X-Received: by 2002:a05:622a:5a98:b0:451:d5c3:6860 with SMTP id d75a77b69052e-45374207209mr42001741cf.4.1723834499152;
        Fri, 16 Aug 2024 11:54:59 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd910dsm19405681cf.18.2024.08.16.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:54:58 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:54:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa0823734a_184d66294a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-2-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-2-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 01/12] flow_dissector: Parse ETH_P_TEB and
 move out of GRE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
> a plain Etherent frame. Add case in skb_flow_dissect to parse
> packets of this type
> 
> If the GRE protocol is ETH_P_TEB then just process that as any
> another EtherType since it's now supported in the main loop
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> -	if (gre_ver == 0) {
> -		if (*p_proto == htons(ETH_P_TEB)) {
> -			const struct ethhdr *eth;
> -			struct ethhdr _eth;
> -
> -			eth = __skb_header_pointer(skb, *p_nhoff + offset,
> -						   sizeof(_eth),
> -						   data, *p_hlen, &_eth);
> -			if (!eth)
> -				return FLOW_DISSECT_RET_OUT_BAD;
> -			*p_proto = eth->h_proto;
> -			offset += sizeof(*eth);
> -
> -			/* Cap headers that we access via pointers at the
> -			 * end of the Ethernet header as our maximum alignment
> -			 * at that point is only 2 bytes.
> -			 */
> -			if (NET_IP_ALIGN)
> -				*p_hlen = *p_nhoff + offset;
> -		}
> -	} else { /* version 1, must be PPTP */

> @@ -1284,6 +1268,27 @@ bool __skb_flow_dissect(const struct net *net,
>  
>  		break;
>  	}
> +	case htons(ETH_P_TEB): {
> +		const struct ethhdr *eth;
> +		struct ethhdr _eth;
> +
> +		eth = __skb_header_pointer(skb, nhoff, sizeof(_eth),
> +					   data, hlen, &_eth);
> +		if (!eth)
> +			goto out_bad;
> +
> +		proto = eth->h_proto;
> +		nhoff += sizeof(*eth);
> +
> +		/* Cap headers that we access via pointers at the
> +		 * end of the Ethernet header as our maximum alignment
> +		 * at that point is only 2 bytes.
> +		 */
> +		if (NET_IP_ALIGN)
> +			hlen = nhoff;

I wonder why this exists. But besides the point of this move.

> +
> +		goto proto_again;
> +	}


