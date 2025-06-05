Return-Path: <netdev+bounces-195165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B9ACE8F3
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 06:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A223AA0A8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 04:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662E7DA9C;
	Thu,  5 Jun 2025 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQkcuyv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F11C27;
	Thu,  5 Jun 2025 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749097413; cv=none; b=osAQnax4c2CnaipHB6PQp1i5urKIKugX3j1qwSELnyd+8q/59H0ts9RDTOmAFmwiMceR589F/FlLt9tNKXp01CfR/Gcj4dP9+NpKirrDPU3eQ2KLSnx4ru1eLmjcuj9nPgX37VeM1SMhQf2g9UZ8/kJPBlGO/yA1nQ55H8RZkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749097413; c=relaxed/simple;
	bh=xcqSsH8JG67hjrSowQ1GFIuINC5lXrn+xg+F6QxuczM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnirxnRfjHL0cCnoXBaaMu2TTEjI+ve0EqBW4XoJKzJKMRcE8nLi5wU3VBLNHn4fHJtQU4kQWMOhnFV8dEdBys4Yh20n0j8oZIKSnV+4qzq3zoiAtXxv8ej816rIvZg0iOxyOvePcLp3APY2gYa8A/inL3ofk501DaK+byN/pyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQkcuyv2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7080dd5fe92so5353957b3.3;
        Wed, 04 Jun 2025 21:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749097411; x=1749702211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcOrzpWjq/BkBEzwdw8mv0dCDmFt7adswzP9QPspSUg=;
        b=BQkcuyv25nsHTMEq7yDAiS5iR1bfv4DfMb+aeDZjvNDcxUfZNPHtSP60hpavbgSQdv
         d4kZCmL7M19lzUcvtWOgovv2oIIAq2j5Yb4zhxdhFbYrrq5D7QVwBJPNMTSuPvI4GphM
         RCee9rsxVWZtjyc1ls6TXKSlecSrtiTf5i0FxP4A8xiZpIi9AI4wP5+TKqk/C6K2UvS8
         v8caZ07qfHG4TlO3XWNl+MeZgT4n1O41rVAFuHXFDcjRwFAN715/w84j+jqZ5l/7zHGR
         1Ns0sSf6rntyPGiSfumXvdieq08jtNf36bA0pDyZgovleIx+nRpU6G5+6SIEYI8n2u6N
         n8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749097411; x=1749702211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcOrzpWjq/BkBEzwdw8mv0dCDmFt7adswzP9QPspSUg=;
        b=tkjAo1+iHiodW0M+RZ4ocweYeCHuVTahSdWG4chK1oVzHWnwn+dDOWBjNB7EEQc9OD
         zBZq+1JuAcMLh9VNUpEMCuWUR5GBTCLL+qss5uolv6Uj+Lazoiv4yt0kJsmTEGh9LRQA
         /cfxRbsRNa/UEnTbWkXEET54yb79QzzG7sTH1QcKWjR0vxGJ0jKH84bHckzKkO36DJQ4
         YsghAIHjy+SEEO95KQWIl9k65Pad4URMQzW8yKwo59YRQBa+dBZCsk/8X5MBkJB7mxeU
         6PSoFczFQqqQDxX5rmj8fIhHodxvRsFhMTBtV1qHumaaZub/w1FJ82mGRL97uC6Tui1n
         Q8wA==
X-Forwarded-Encrypted: i=1; AJvYcCWOPNuM9vXHKVwFaQKI9bqK+P8M8INYS+kThtjw2OKiR8oXzuNq3XfmooMllO25JvCCx6sw/1Tz@vger.kernel.org, AJvYcCXGRb4LW72odsxUDpyE9bWoWwdnpaTQnxJFwTBSx7Pu7yRuJHscPCsOkAsQryzEdFl3Y8cYLH+BZvesKPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+BUrSWhKvB2IYMLJxAKyf3L1zoTCMEEtvilgf1GAzl7AEHa0
	lFZIm3Arqe3u9dBHLLfgOt2W4nQ4mhoYNKk+1gRMp15hnDWLWCXS3LSL
X-Gm-Gg: ASbGncvFktWsQg9lRBuuteIuBgf7Q6SEYxoM4Dlcg9JI2NO1Abycp4PPQCInU4tw6xr
	uyvRRGISbQsZSHsCJ8aKblcSajp7husqiczZ+q5dp3aQ2A9y4uiyynkMKU6iwPWcA7SpcA+G3Mz
	vLkL3dndWvU/wvNIQMfKBWYq5eu/EPJVg+MOGKGhQbH8CV0w3bbQmMvS1I5KYWbwscTWW4T8Xf3
	a43imCKZ4tlkSAb81hB78dU2rZUJIxC6taz2jPQ6SmqABoeKQGEdWCmflN/P1aW8abIpYo7v1KK
	EktLobw8teCLP627/4yOFzYuk7btwWKG5IAvbDoEjeBj91N5vURJuhwfFxeFyP52rOHcj/Xnu9P
	CinstMq3U+mc=
X-Google-Smtp-Source: AGHT+IGwjW7MDmAwX88wzy2K6C4SsiEVtRq6YqAm1ZsuSD7WYUpOBa/WcBffoD7Zr8Xr/9saSv6bAA==
X-Received: by 2002:a05:6902:2e05:b0:e81:8760:15c8 with SMTP id 3f1490d57ef6-e8187601fc2mr3665429276.28.1749097410596;
        Wed, 04 Jun 2025 21:23:30 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7f733ee856sm3483847276.30.2025.06.04.21.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 21:23:29 -0700 (PDT)
Date: Thu, 5 Jun 2025 00:23:29 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard/queueing: simplify wg_cpumask_next_online()
Message-ID: <aEEbwQzSoVQAPqLq@yury>
References: <20250604233656.41896-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604233656.41896-1-yury.norov@gmail.com>

On Wed, Jun 04, 2025 at 07:36:55PM -0400, Yury Norov wrote:
> wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> function significantly simpler. While there, fix opencoded cpu_online()
> too. 
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/net/wireguard/queueing.h | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> index 7eb76724b3ed..3bfe16f71af0 100644
> --- a/drivers/net/wireguard/queueing.h
> +++ b/drivers/net/wireguard/queueing.h
> @@ -104,17 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
>  
>  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
>  {
> -	unsigned int cpu = *stored_cpu, cpu_index, i;
> +	if (likely(*stored_cpu < nr_cpu_ids && cpu_online(*stored_cpu)))
> +		return cpu;

Oops... This should be 
                return *stored_cpu;

I'll resend, sorry for noise.

>  
> -	if (unlikely(cpu >= nr_cpu_ids ||
> -		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
> -		cpu_index = id % cpumask_weight(cpu_online_mask);
> -		cpu = cpumask_first(cpu_online_mask);
> -		for (i = 0; i < cpu_index; ++i)
> -			cpu = cpumask_next(cpu, cpu_online_mask);
> -		*stored_cpu = cpu;
> -	}
> -	return cpu;
> +	*stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
> +	return *stored_cpu;
>  }
>  
>  /* This function is racy, in the sense that it's called while last_cpu is
> -- 
> 2.43.0

