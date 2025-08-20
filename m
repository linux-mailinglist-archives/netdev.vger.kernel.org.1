Return-Path: <netdev+bounces-215251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C46B2DC77
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437593A38CC
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22D305E37;
	Wed, 20 Aug 2025 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZGnbz35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E62F3C20;
	Wed, 20 Aug 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692854; cv=none; b=HTk3UsHPfcZ7bOK8QsUQh2Ngfe0Rr1Ob9LgEfBluooZThfSTAwtkInLbIHFipcVTT1pGAb1YwEtK4UOrniNAPiqb1G+nC131rwN6eDsk44MfnpcIBfhumVIu9o6GsiCBKPmG1MloFEdkaAF+I2blk8zjLOGs/tvUf4FlIaRGMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692854; c=relaxed/simple;
	bh=JozVgzE5OpdNK0U/lRsP7Vb02zfKR4iqBk4vRlL9sJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWhYkHhcGktqH46I+3ocoG9ALrWU+WL7p04pO/41NDESS2SohW/BHZFq6o4RKt+Ufwt5Xz2KBmQMfCf/ujHdN55ppfg/mRIVSuark4jkAXw/ULyCPB8HDQY/Y3/fk6wXujZrN08x801sSuKnx1kVfP1i01mLa4Y1zbhNYdMzwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZGnbz35; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so40020775e9.1;
        Wed, 20 Aug 2025 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692850; x=1756297650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETWd0Uz8dmq2q1FPGS8zdhheeQpSbWBvfVF/jZk52Rs=;
        b=bZGnbz35sCsAhX5JY31h87aEPomVxY1UaX66dDr58CbXG4WLJObPdFWy8/GtGg4HDS
         CXTgytshuYr5JfUsdQmtQw+Taji4iLOI0xUI13/r0Jhj/7ZKl9T8659idszIhtSBc74N
         XP/IAEZvyKMMz+4mkwZ3NxCq7zBnH9aJAzCswJsT0oHYwcP0ls6q6FYBJ3p7tdmE2qWd
         q8MJCLGrg/pgmmVQz4Yvac2iswRQcwL2gz9Rmkz+P19ofyRo7ZLc2HkVbLXCnVi9TI/e
         +YvV6xsNOP/3BE16JqLK1EnKPZFuPyqw00IKh31n/Mf/OeaXJru0QLiNm2svuXrgxaQp
         l50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692850; x=1756297650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETWd0Uz8dmq2q1FPGS8zdhheeQpSbWBvfVF/jZk52Rs=;
        b=f8j0gwFu8PLZ6BZWmJ1pAiCPRHgradBbAPzkN4gSExk3iNI1ic/IC93gFfiBSoMtYb
         fFztKcVYW64yWNJcwZifjFYYIkIYaw+Tk/nibLipTn9M1ybYD8WYk9fBs96EAtxioYF1
         tboXhxI/Jb/xg1Ms7fYn5l6Sg3kw1+k/FCx+9NCB2nvkDyCcjyX66V3bzTFZuOcq2cxq
         wH+jRyTvC/iarfVZThEpSIo7ZuE7Je7yjtsGUZIvpTh56wEoM/6tauW2i990Znj2yROo
         f+PWgu/RO7oj14o8JjCw/g/thx6w9WFtN/nM3lul5Fs8IY85W7i/DZyg84YLHGs0Psov
         XlWg==
X-Forwarded-Encrypted: i=1; AJvYcCWxDdKbthRJVmbN/2ciXsdIIbtpyFcXmO3rMqergdEmSVXU2/hMUX5r/r1kMmHyo8JUxgaz/o5thbrEK1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHICf2t9Utxd3DSdi3HZ7ZX9KGv0zZbOfHRnA+twE2NAa4Ot0M
	BXGdSvKLKvxfu/F2voicKXyuNeq0N3pUm7CCzjoXE+urPvsAd23XmlWw
X-Gm-Gg: ASbGncu3+y+xRCjJt+7CbmvxteWpetnYcyQmO5kW+8k9vfICWyFLoPp7FjKdQPER/Dk
	vm1JU82P6eN/27YZI8JDFJsp+WGam9yBy0DIMzv1Qw5F0CykJRkNWvMLnctKEcrMjq7Oc4a4GTM
	+Z6L/GvVHKwl6eXSdpm2BRpo2zecPGpGpUCuKQv0RI0TpaiRY2W2mVxhauV/PmH9xndnkD2gQNi
	kH8g33wp7K5SokhQwN55nTTExcAbkUzLoU0zfMd6saoj5OtLibwtN36TAn0UuRO90ZINYX+xatB
	bS5FFmUFtHNOELHtuPbUs2hM6mPUJY23ZAmEMOsp+gOx03wfFM1u0cBYdHkx4bh+EAa5zcGDpVm
	w+b6hyYh4nCTkO7eF/4yHv1cmM8zitU5yBw==
X-Google-Smtp-Source: AGHT+IH0PuOuR2aoV4+cA5Zj9PRupwltnu5jmvMpiaGyaN9CYcbxj/L5Iag7R5MYzOdHAh/XjQHAvA==
X-Received: by 2002:a05:600c:1d14:b0:445:1984:247d with SMTP id 5b1f17b1804b1-45b4adeb610mr11415615e9.7.1755692850383;
        Wed, 20 Aug 2025 05:27:30 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47cac162sm33996535e9.20.2025.08.20.05.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 05:27:30 -0700 (PDT)
Message-ID: <bb28ffa4-d91d-479a-9293-fa3aa52c57e5@gmail.com>
Date: Wed, 20 Aug 2025 14:27:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
To: Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
References: <20250819063223.5239-1-richardbgobert@gmail.com>
 <20250819063223.5239-3-richardbgobert@gmail.com>
 <willemdebruijn.kernel.a8507becb441@gmail.com>
 <20250819173005.6b560779@kernel.org>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250819173005.6b560779@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 19 Aug 2025 10:46:01 -0400 Willem de Bruijn wrote:
>> It's a bit unclear what the meaning of inner and outer are in the
>> unencapsulated (i.e., normal) case. In my intuition outer only exists
>> if encapsulated, but it seems you reason the other way around: inner
>> is absent unless encapsulated. 
> 
> +1, whether the header in unencapsulted packet is inner or outer
> is always a source of unnecessary confusion. I would have also
> preferred your suggestion on v1 to use _ENCAP in the name.

Yeah, I guess that was the source of confusion. IMO, it makes more sense that
INNER is absent unless encapsulated since that seems to be the convention in
the rest of the network stack. (e.g. inner_network_header for both skb and
napi_gro_cb is only relevant for encapsulation)

I could rename the OUTER variant to simply SKB_GSO_TCP_FIXEDID so that it's
clearer that it's the default (resembling network_header). WDYT?


