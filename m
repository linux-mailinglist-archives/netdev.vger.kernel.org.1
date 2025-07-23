Return-Path: <netdev+bounces-209337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4618B0F3F8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203071665DD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335362E54A1;
	Wed, 23 Jul 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPRn2BAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2A28C86D;
	Wed, 23 Jul 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277289; cv=none; b=pVeRlzbnsIgFbszQBxGjWKaOpsw+s6NbEq9xt7BKUjkgWKHf47Iss4BwxKEZtz/kDrRd8dCFqmYkwNOpE9iPgkH4YFwOv8yGf4BeWkwD2UNG9r+ZwLG4exWYSVLmh/kE3Nygu7hBhxxcrLPV3I7lTzK5+V2FWh8UZVjZr3VmO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277289; c=relaxed/simple;
	bh=2HMzz8PkQN5nY90uYDgDlI4eBV1Z0YDth16VGGdgEzQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P4aiOc0T4u9hd+1BgxNpzv4a1jHJI1k8aT3MZYBGAwr7Xvbf9MiG87A2rZ0NyNcpA/YwGj8FKHDcFrpK5EUCmepGrjIzjsVTINd9eyQJjrcRZYEJz0F66Pwla7vz1ZFFx1ujT7tLqR38Hp1NmntYt5wvQ/gve4oDmi+X9eURL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPRn2BAy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-708d90aa8f9so62896357b3.3;
        Wed, 23 Jul 2025 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753277287; x=1753882087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72AR8Xp3tkYByZnElqmZPIIc8gwCiBiyx98dQPA9PbM=;
        b=PPRn2BAyhtRKewLjUfFDHUXJcJ9XFnlYsQmkWKmIOlJcqUmrNQFOpl9jzQuNY4nZt2
         Dkb43pcJnuAoGt4LgKtiRGyQTfrcLD80icEuzC36poD30QSHLmFdVyVnVZBGv5GU7Xaj
         yEItSgnWjJ1clpY9VoYgxrEy9y+ZIeOMEEdAHSwONSQhTeskXww6XNCvJTFkB8MAVNII
         fA90/7dHlPS+HbSq2/shR10AMDX/6v+/SWhdAW57JgWEeOBUY9U/tjntnGg1KHF5g2vV
         BxfkbLiAUOMozugTc7DbUWQPJVOr/+i7t/+J3dihyHlPRhokTJNU312nQYgAEWq6VQh1
         yZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277287; x=1753882087;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72AR8Xp3tkYByZnElqmZPIIc8gwCiBiyx98dQPA9PbM=;
        b=WFQvEFo/OAchIPTaLnXbkenSaPASboe/m8MZ/hUVCtnR+DQCzWK+GWmPwDA+C/LNM2
         6lnJEmODMoXBRWmCUPqQO0oQPIMMXqB3T9lXkoWRTgLRQo8eiFsLet8qd8+1GZibw+6e
         h2yJskgf1BbRtYYnZjQhs69g6Nz+hG+RA+j7rrSmhthTAxi+gKNV25qb4ixN+JpH+idJ
         045bSgiDQWSjyI2AZGIjHVR39CNYVgNzYb0rDDrXz39iNtnsehDwFJ1zzXgO5tPArdDc
         6yK2oKdbqdmAyOBiz8LBDDGkAu9sZ6jBJw6b8C2WTPCqntzDQA7FqjzEO0w5eyLnj95u
         tNUg==
X-Forwarded-Encrypted: i=1; AJvYcCWAEoU97EospExsbICnVryjrQpcai4YbU8sJCnUb7oXzzPi7l7UVXlIHcHqcWqLagy1nYSc0qnshu0AscQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFs3UJaPApHY97XgvoUYmDJC34jWya+KTx2t/91L3eUZj2aOlQ
	GQ5WvXdw5xtvmzCjtXYgkzssZcnzAx89KRZV4LJSCCyL231VA/iOb1lP
X-Gm-Gg: ASbGncuDweR4SLdseq9+sNCVpoj1AZJLP8vIDsdZKohwbIMXNDxVQR0dzozR/02YbY7
	oCHvptPOgTi4decLOR9e7ntAIikQMRCbshZu21TkUFeRW2SXVmJ/pDW2Hr+I0u+rG7756o6YEaR
	JypQlVZ4m+ncjfxbZ2rWLl8fvLEsjYdS64oVnh3jj1cr1HjgtG97IkQDsyxNyOABNFpuIR0009k
	VlkUldTkG58ZazOil9TysboqgbexWNVK5LNO55S+CRUsf44lfM5t/tIe7VJw/W/w8LFsfy+e2wk
	hOrHQ7CZQYcv6Bkv7FheDZ/dR0vbZkFaRtOBjLdmWtB1ysXQ+M2EquST0HBwKJzomkNXqqeE4HC
	bKhk+R1kMS5VFsc301Nyod4vgjWyvnDQSDiyMb2XjsQPrM7yRUFLPC4GhXXTVGWrVSgqPFg==
X-Google-Smtp-Source: AGHT+IGhSxtX3GaDeaSf+rBxmDG/7JM/zGVlEyp7PWD2w3XC61fybzwU5GeJ4kyrRRbZojLLjAyaKg==
X-Received: by 2002:a05:690c:6f8a:b0:719:5a26:ef6c with SMTP id 00721157ae682-719b422f724mr41768577b3.17.1753277286683;
        Wed, 23 Jul 2025 06:28:06 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719a869bde1sm7290157b3.107.2025.07.23.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:28:06 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:28:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pengtao He <hept.hept.hept@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Michal Luczaj <mhal@rbox.co>, 
 Eric Biggers <ebiggers@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pengtao He <hept.hept.hept@gmail.com>
Message-ID: <6880e365b84d2_334c6729452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250723063119.24059-1-hept.hept.hept@gmail.com>
References: <20250723063119.24059-1-hept.hept.hept@gmail.com>
Subject: Re: [PATCH] net/core: fix wrong return value in __splice_segment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pengtao He wrote:
> Return true immediately when the last segment is processed,
> without waiting for the next segment.

This can use a bit more explanation. Which unnecessary wait is
avoided.

The boolean return from __skb_splice_bits has a bit odd semantics. But
is ignored by its only caller anyway.

The relevant __splice_segment that can cause an early return is in the
frags loop. But I see no waiting operation in here.

Aside from that, the commit also should target [PATCH net-next],
assuuming that this is an optimization, not a fix.

> 
> Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
> ---
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948..cc3339ab829a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3114,6 +3114,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
>  		*len -= flen;
>  	} while (*len && plen);
>  
> +	if (!*len)
> +		return true;
> +
>  	return false;
>  }
>  
> -- 
> 2.49.0
> 



