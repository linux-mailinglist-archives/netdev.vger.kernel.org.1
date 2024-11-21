Return-Path: <netdev+bounces-146605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836819D4880
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70CE282D74
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15051CACE9;
	Thu, 21 Nov 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pdy497Zq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327A1CACE5
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176571; cv=none; b=jtAE6AznGEw4A49ekl3MNJk9bjOkgoTKIQqgnrkWGAV7LXuSLdnsEN1XnLlqIL5jyIvpvEaNK94s6B8QmuR1upynLiEHKXToTmWifN1Si3Ej8pODU4XbJT5qNSQayNp+80FAhax4tGrUXacZSPsE+lubdTJ3e4C5giXK+eJsIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176571; c=relaxed/simple;
	bh=s46hFa6ecksXK2SkZcrr65nuuOnGivVtBnbvFbWCVpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dJ/TGtzZywGV5fc+HFY72D+TLXOfINtPG1zX5TLzRqPt40qKsoGoqib3J1gvBQnr0zNTna/O0Yj1C+QyUloHeHGd/TAcE52z6Ho9xLnR2hBqXkF7exSqyZy36uFW2V9RxLhQ41BdnWtsyktGYFjO3wBEo8LkeEAhlryel7vR/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pdy497Zq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732176569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpi7rCWd4HfFMoe5pScamTV+6mR7Qrp53TiLbWsccao=;
	b=Pdy497Zq4cjuvTdLtbuYqKnJOK/8E9tf24Jl+468An2sCafaI/tsk03WWkfx1wJMenjoaH
	Jncl/N5Boh07bG+MOwnQpWVMcsp//fP301VTDYEehzUcZcRifKAmiElVefBynSHnuWvUlK
	607DpZRdeYMmHwZl/77ORZ1+ydoTa4k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ArDHmm5pPU2YkEqcXBoCmA-1; Thu, 21 Nov 2024 03:09:27 -0500
X-MC-Unique: ArDHmm5pPU2YkEqcXBoCmA-1
X-Mimecast-MFC-AGG-ID: ArDHmm5pPU2YkEqcXBoCmA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-382341057e6so298611f8f.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176566; x=1732781366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpi7rCWd4HfFMoe5pScamTV+6mR7Qrp53TiLbWsccao=;
        b=Dtg21doD8wjHimM+P4QHFDTARTEp0MJjVmtTsWGw5TSw2U9pHtPIkMo3DPk0dbvuZ3
         XThDCO2uUxIpBlyPTWo9zHm4FMxINRVed2JVY0XnRIbF16hBHaxDgpiAEZpJoDzRn0SK
         XJ3wV2miwoquTpjiIWI9lkdFOr+Lh0N7BH+g3caMqzGmq285xA8eBfCWbezA4uHyJoM7
         hC0daNAlIFaSTVFZsacVv9XB0b3XkimNNk4QhQcdKgilLY8A0cxH6We5Bp4aqcsB1D06
         KE4N4M4tS6zYRIKzz/nOGTMOca48G2jsDFYGNk5He8pHQPAiSanswyVRbFED03E81p2+
         ET4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDNeL4QSOjwIZZqS1LT6THiuTKKEscJiTJ2OhXkSFzABBzXO+kPcQ1CTnG7771/3QOCyCt0JI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx874zrI3xyKc96iygIsxPKxbBBxQSYq+n+rEQz358lKtRhryGg
	aIxJflXZ58hhfw2MQdu6EAdoN/G2NGAkjdVLSSbqyB7DvcPataP6flcbD72lXTI3Dl3Z8VnYwWM
	T7CHixvLGD1o5pQkq7pTezB6qhx2GT3a9zP4gd3UmZSMwFssPQzWyfQ==
X-Received: by 2002:a5d:6482:0:b0:382:3ae2:9e57 with SMTP id ffacd0b85a97d-38254adedaamr4276989f8f.12.1732176566184;
        Thu, 21 Nov 2024 00:09:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGz2MlBEAciKiqIP3JgHwH/zSJPlb7U1MIWRHxlKsBogKLXug0YOPouwD+MtNJw6vEUeRsNQ==
X-Received: by 2002:a5d:6482:0:b0:382:3ae2:9e57 with SMTP id ffacd0b85a97d-38254adedaamr4276976f8f.12.1732176565878;
        Thu, 21 Nov 2024 00:09:25 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549051d2sm4241878f8f.6.2024.11.21.00.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:09:25 -0800 (PST)
Message-ID: <3d487b58-6850-499c-a131-b8169061759a@redhat.com>
Date: Thu, 21 Nov 2024 09:09:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet when
 if_id is set
To: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com, leonro@nvidia.com
References: <20241119220411.2961121-1-wangfe@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119220411.2961121-1-wangfe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/19/24 23:04, Feng Wang wrote:
> From: wangfe <wangfe@google.com>

Unneeded, since the author (you) matches the submitter email address
(yours).

BTW please include a patch revision number into the subj prefix to help
reviewers.

> @@ -240,6 +256,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
>  	struct xfrm_state *xs;
>  	struct nsim_sa *tsa;
>  	u32 sa_idx;
> +	struct xfrm_offload *xo;

This is network driver code, please respect the reverse x-mas tree order
above.

> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index e5722c95b8bb..59ac45f0c4ac 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  	struct xfrm_state *x = skb_dst(skb)->xfrm;
>  	int family;
>  	int err;
> +	struct xfrm_offload *xo;
> +	struct sec_path *sp;

I see the xfrm subtree is more relaxed with the reverse x-mas tree
order, but for consistency I would respect it even here.

Cheers,

Paolo


