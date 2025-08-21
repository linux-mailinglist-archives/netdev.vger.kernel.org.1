Return-Path: <netdev+bounces-215617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFEAB2F909
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB9C17F42D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CA320CC7;
	Thu, 21 Aug 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwxRVUqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8431E0F8
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780740; cv=none; b=Ji/Zg2y6sSEP724HZ/eUw+lITdCrp1pn5gIjJRSwE9Gc+jBYdAFyREBLVfmz/MymoEax+ByDVo7qP91XImyX8vZjwL62RUtcps4jWOuKfJOug9dwpvSk3ioSIMLQ1DV2+SmAp/Z+nOUh2tueTIMR7kM9fKqkyXe3trqhO2dcx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780740; c=relaxed/simple;
	bh=LLujgo17aIxSBLq0GGYcaNSwdVWwDosgbd4HO6Yv0z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NufoaDW8hIxk0EGY0JVLuIiHmMcc6MyxbWgsgNdnrYeQHIlHeqjz6VOyRf4sFoxC/bBpzsK4sKDhsk8PGjBbE1HAK7jnFm0oCPfkKUBY8EckDU37ZlCI7PH7DrE08LJCbPHIutVsqgYLTTVrQt+6X++NuNWqi2sVqJH3UYYuDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwxRVUqu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so5227655e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755780736; x=1756385536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUsL83zsecC7yRV/e3S2bWkQ9rwjTqlIbBsHbqavuDw=;
        b=ZwxRVUquafbd/ELBupcDXlwK/jhzyMMDdHRxfaVjlIcK2qIU5Zbkzx+yuSgiJBG/0B
         KDTy9/cS7fGvHKAqoESzIgpXSH4crgCnQYpoX0v+X0R0ZqaN/MagyRDFRdGsalr1HLZL
         qZasoT8RS9FTnCC93f+/y5lWsp/ydL0tK7jDSb6C/gUBeIrEXlwqPBsmr0vs3F8rMkrZ
         8JnxBwNCxs3S+We0dqIhw9hWwlUtVAFsSTv5/AVZz19w/j2SALVNQmIadsxsoGvri58H
         k0MEDIqk9WrZJMU1WeW8UtfSS9rHDQpYTCrW5Tyzg0c0WouKpRLGixi59mMeHzoxwhdY
         Ql+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780736; x=1756385536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUsL83zsecC7yRV/e3S2bWkQ9rwjTqlIbBsHbqavuDw=;
        b=nbVGbrN0p7/G9kB/gDk2OZyPkllLLkl33T6eGFSaLNmrW2iXYFPK0/2vgIxuOpV+w9
         OPD67ASLgMQhhSHSxrjP11mVPVp7enKejAIp/GJA2WLLY0jNDEg1wloyAIS5OO8XNhaq
         yGBCZrlZfREyK7zM+AaAur2+XETfa+81lreQhb8+XeCbnTMH/bjVBzyzNja1USTvjnPO
         kcIGUN60qOzUrqcNPog0qnsvcLXX6pRRITF8CxHRq1JxnJFpoSsuAQTr+yzlJ56Rv3KH
         SPhiSI/D43pRJhzizsst2lWtwST169a8fyt5qfs8bKbvC4UHKahSbSRMxvd/dw4PgNTN
         jR+Q==
X-Gm-Message-State: AOJu0Yz6IohNAo7hKy8E+z2zcDO/bfRko4DyVAPgJMMSYyxcWrlPaelu
	xWCmIixvI5k5QogoQmqfpBd+ltCmXYoioLuHDYKpq+QBpGVcZU5n0PBdJebN+YxOCYDDvpHCM1t
	j4iW9
X-Gm-Gg: ASbGnctQ/h1MckPhQp3rnvozJqyExwaERrFn8ID6UVh4tvg/wEDi3gZHSSwPC0yPiHf
	0YTwMfzOEddH0G4ZVGayxRfsldAd3l11MorKGV1gtCkdi6w33gRJTkzgSXuQv9yeCPqlsIIi8iD
	efvFhHbhaZSukRM76A5JWtBDe4WcSXBM1GoGk9kASd5W0ZXu/0vzq3gSUj8VNi8MGqg9N3fUVGv
	QX1ERAlH9c0zphBGv6S5a19qkwMI/crKlCRNjNmiUNG/i+gWuvb+W1eUEwiC8uMBcNZY6B2AfTB
	YjFnfc83AfNXKU3js0a9XvAxsku4ClLXnaLmEhY9/I3cts25sU76WdUctqN7Tz09COTlQpYSPPK
	7Y2XVBoAOyc5nDmyK7eT+a5KMrxCLgnAugWFaGQ==
X-Google-Smtp-Source: AGHT+IFks1UjqoTs3zcB6As7czWYaenw+YDRjeJCaniM0ZwF9o4gJA0TsV6eIfS1nlqXA8r4whdavg==
X-Received: by 2002:a05:600c:3b04:b0:459:dde3:1a3d with SMTP id 5b1f17b1804b1-45b4d86c120mr20248785e9.26.1755780736319;
        Thu, 21 Aug 2025 05:52:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4db2ab9esm27009175e9.9.2025.08.21.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:52:15 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:52:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
	alexanderduyck@fb.com, andrew+netdev@lunn.ch, ast@kernel.org,
	bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
	horms@kernel.org, john.fastabend@gmail.com, kernel-team@meta.com,
	kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next V4 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
Message-ID: <aKcWe3bm3wQqlfdx@stanley.mountain>
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
 <20250813221319.3367670-6-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813221319.3367670-6-mohsin.bashr@gmail.com>

On Wed, Aug 13, 2025 at 03:13:15PM -0700, Mohsin Bashir wrote:
> @@ -1251,6 +1293,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
>  	}
>  
>  	for (j = 0; j < nv->rxt_count; j++, i++) {
> +		xdp_rxq_info_unreg(&nv->qt[i].xdp_rxq);
>  		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
>  		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
>  		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
> @@ -1423,6 +1466,11 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
>  		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
>  		fbn->rx[rxq_idx] = &qt->cmpl;
>  
> +		err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, rxq_idx,
> +				       nv->napi.napi_id);
> +		if (err)
> +			goto free_ring_cur_qt;
> +
>  		/* Update Rx queue index */
>  		rxt_count--;
>  		rxq_idx += v_count;
> @@ -1433,6 +1481,25 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
>  
>  	return 0;
>  
> +	while (rxt_count < nv->rxt_count) {
               ^^^^^^^^^^^^^^^^^^^^^^^^^
This should be <= otherwise it won't free enough.  Then qt will point to
the wrong thing and the next loop will crash.

The loops in this function are mind bendingly complicated.  It might be
easiter to write them as:

	for (i = 0; i < nv->txt_count; i++) {
		qt = &nv->qt[i];
		...
	}

	for (i = 0; i < nv->rxt_count; i++) {
		qt = &nv->qt[txt_count + i];
		...
	}

Generally, I would just unwind the partial loop before the goto instead
of doing a jump to the middle of the goto.  It's more lines of code, but
I'm stupid, so I prefer code which is easy even if it's longer.

regards,
dan carpenter

> +		qt--;
> +
> +		xdp_rxq_info_unreg(&qt->xdp_rxq);
> +free_ring_cur_qt:
> +		fbnic_remove_rx_ring(fbn, &qt->sub0);
> +		fbnic_remove_rx_ring(fbn, &qt->sub1);
> +		fbnic_remove_rx_ring(fbn, &qt->cmpl);
> +		rxt_count++;
> +	}
> +	while (txt_count < nv->txt_count) {
> +		qt--;
> +
> +		fbnic_remove_tx_ring(fbn, &qt->sub0);
> +		fbnic_remove_tx_ring(fbn, &qt->cmpl);
> +
> +		txt_count++;
> +	}
> +	fbnic_napi_free_irq(fbd, nv);
>  pp_destroy:
>  	page_pool_destroy(nv->page_pool);
>  napi_del:


