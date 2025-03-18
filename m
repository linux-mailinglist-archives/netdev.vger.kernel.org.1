Return-Path: <netdev+bounces-175628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B7A66F3B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DE1179771
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD11C6FF4;
	Tue, 18 Mar 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCBrm/XU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AF189915
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288547; cv=none; b=gEV4MW5Z1JblVwGO8I5kDou7Riz5LDY0AL+2S4wmRWSKQ+XOIxXCjH8hiFZErBKdI59nNvbLp9AuOZ3U+YjLKlD7wQA/ELUUdp6xhYWleYqQpwc4YvCX6a42tUZb4c8cgNncCoEs93GMwn4Sye75FazsVIpc62vwAbNQMnVnO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288547; c=relaxed/simple;
	bh=d+iu5R0bIqWiBL+2PYzliZdZopVRCw5pTpDMAQQCfBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+hk71qlQCY/r4hrQRdYXr2RJ/n9bhO09Mcg2fBOdIMsSEIer6nMMBK2FJOYPHnNsigET2yAwUPhdDqWjo03YgJKbO5LJ8q0GdYLKog9Z4YIfsj/ZpPilLW0sj5LPE6LgIZ/7QsjHdV2GLt2q/9dUPpbVwVkQD9Vwe//ftEJt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCBrm/XU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742288544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZHjSj6IIBOV2oO1qsgTstoal0zFQK2lDaOtzns/K7o=;
	b=FCBrm/XUDuu+1RIgk5EwfhohDVTdfsqRURwRvP0tptdEmQ/asc8DJ5j0RljBqG7TmmSOTu
	eoBcanbzpgamqytjJau1bJI1at6c5xRmT+SpB1+p7N4RcN0NpcRmy28PTjDOsJGrx0Y6uF
	JaTqfq2eizrgeZYtyQ01218ztu0uf9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-qCE4SR0sPsOGfR4J-GXbAQ-1; Tue, 18 Mar 2025 05:02:23 -0400
X-MC-Unique: qCE4SR0sPsOGfR4J-GXbAQ-1
X-Mimecast-MFC-AGG-ID: qCE4SR0sPsOGfR4J-GXbAQ_1742288542
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c489babso14616025e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742288541; x=1742893341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZHjSj6IIBOV2oO1qsgTstoal0zFQK2lDaOtzns/K7o=;
        b=dl/n2NA3gT74zqdYj8GL8WPsPgQ2wjof0QGXkAogc5UqbIPtYx9i+coehl1xBOKc5X
         7Hvt+owdyBL40kbGXpNS94NSYIrtVSwPdqWerqhcpEBaJ0+F7Rq6rs/mmSZz0LBO3i1K
         Xzklaywki7PqQAQobrkPfIWaHZqXnRNw5ecgD2cq/CvB6ckDuBhNB+43tfs1Z2VaoLSB
         8lr1cp6w5Aoq8AdplJ/EoAg9kWccs+JFKuY3QdIsyVLcIvH7hMAHiaigEBjh7uasZOpK
         xKfN1nCoZWAI4ggYSy/81rDDH89VrQlAafOxD9aKF68mxkIV1HIGV75CZnjG2qtTs3kd
         ABdw==
X-Forwarded-Encrypted: i=1; AJvYcCU38IPghLqzoqTFko3s8ictqxNdhkI+g24rVtUT3ftHQKoWoZ7EXJasJOWwARllIUsNSLR6tSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVQRtKhCAF74Qsf5i+KPzMenOxeMxg7VsIHQ9aI9ylC22n+9X
	SyuveaDz4vOEjPgW6oo/TkotF64mW8UZDuaB8lmcWQUPjOf37ZSJmSteVFRleOlxOJD5DsjvcP1
	LwnAxVad4DKVCbxmW8jtQNT216l8mURy5AMv4piQs4U4hcN7ch2N4fgIlr9c1sg==
X-Gm-Gg: ASbGncsuwFDbm7c046Mty44zOaeQOOoBGmjorkHnjiiSOE6CFBDI0XHWeV1S+rpr38u
	5k7wu58Pgv2Q/eJsnaojklPaMEqxBEOQts0kkWifP5v5Oj0JCY4i4agDBosRR6rlJmd69FYg1wJ
	no0jvgQP/gPeY6tQRUwrrV7n1iaaSGvkddp+Bbpdi4PXlzcTgVHVx1wZt53V+tM8G+Sebhh7SHo
	id4FoBKws9QGcWN4TzCAplJX/nNKBGfwLqbY4HzOt9stEzf91GHf3wTgXmrCljqPax8eTn2NxVp
	asm2BVwxwVhp1QI2+y4iITI6KBaPoOBdN0fJenyQnMjNkw==
X-Received: by 2002:a05:600c:1d2a:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43d3b9a3068mr14573725e9.16.1742288541399;
        Tue, 18 Mar 2025 02:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3MoVj2rFNREk2X3PyaxgWZ0vjggNG2HOk3QYwZwwTPXtRls/v5wq6NIwPPvIM1+s13Yb09g==
X-Received: by 2002:a05:600c:1d2a:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43d3b9a3068mr14573205e9.16.1742288540915;
        Tue, 18 Mar 2025 02:02:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d21d67819sm122107795e9.21.2025.03.18.02.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:02:20 -0700 (PDT)
Message-ID: <aa21376c-18de-402e-bb0c-aef2eb7610cf@redhat.com>
Date: Tue, 18 Mar 2025 10:02:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] ipv6: sr: reject unsupported SR HMAC algos with
 -ENOENT
To: Nicolai Stange <nstange@suse.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310165857.3584612-1-nstange@suse.de>
 <20250310165857.3584612-2-nstange@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250310165857.3584612-2-nstange@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 5:58 PM, Nicolai Stange wrote:
> The IPv6 SR HMAC implementation supports sha1 and sha256, but would
> silently accept any other value configured for the ->alg_id -- it just
> would fail to create such an HMAC then.
> 
> That's certainly fine, as users attempting to configure random ->alg_ids
> don't deserve any better.
> 
> However, a subsequent patch will enable a scenario where the instantiation
> of a supported HMAC algorithm may fail, namely with SHA1 when booted in
> FIPS mode.
> 
> As such an instantiation failure would depend on the system configuration,
> i.e. whether FIPS mode is enabled or not, it would be better to report a
> proper error back at configuration time rather than to e.g. silently drop
> packets during operation.
> 
> Make __hmac_get_algo() to filter algos with ->tfms == NULL, indicating
> an instantiation failure. Note that this cannot happen yet at this very
> moment, as the IPv6 SR HMAC __init code would have failed then. As said,
> it's a scenario enabled only with a subsequent patch.
> 
> Make seg6_hmac_info_add() to return -ENOENT to the user in case
> __hmac_get_algo() fails to find a matching algo.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Please specify the target tree inside the subj prefix, in this case
'net-next'.

> ---
>  net/ipv6/seg6_hmac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index bbf5b84a70fc..77bdb41d3b82 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -108,7 +108,7 @@ static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
>  	alg_count = ARRAY_SIZE(hmac_algos);
>  	for (i = 0; i < alg_count; i++) {
>  		algo = &hmac_algos[i];
> -		if (algo->alg_id == alg_id)
> +		if (algo->alg_id == alg_id && algo->tfms)
>  			return algo;
>  	}
>  
> @@ -293,8 +293,13 @@ EXPORT_SYMBOL(seg6_hmac_info_lookup);
>  int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
>  {
>  	struct seg6_pernet_data *sdata = seg6_pernet(net);
> +	struct seg6_hmac_algo *algo;
>  	int err;
>  
> +	algo = __hmac_get_algo(hinfo->alg_id);
> +	if (!algo || !algo->tfms)

The above check '!algo->tfms' looks redundant with the previous one.

Thanks,

Paolo


