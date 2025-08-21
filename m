Return-Path: <netdev+bounces-215564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B8CB2F3C6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264E0B62909
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FFE2F068B;
	Thu, 21 Aug 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM5fe4ma"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8C2D47FB
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768212; cv=none; b=eCSS3VAL7KI8dOTDfgV1p2Vq8DuozyLuabLgn7S4U10atQl84hI3IOTtgu2REhee2zjnjWyWruB0hOClUSyY1+HAWHQTsOljPCpj/+n5lzyl0R86VpO+Ba6DvQSdTYVg4RSsTdcO8Ht5xmWw2j+KyvLjW9lRv+5kZidx5FA3tX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768212; c=relaxed/simple;
	bh=bqK1EohHu71zjabqHTqoKWsH2VYa/lqUaQNt1/AZT4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1nnXLJsJRGVRBZTSqaiTboLoSfUWfGDhrBE89W85vgngxbcIBgXuD2Nux3JQ3EXOrE6CiRt1Rdjwrc0/WCTl9jOfgusTwyzSBSk0oC4kAZCoXvr6U8aeASQP7e5hRfEtrgLqrp8g6obfJlP58MRS3LEZBarS/kL+OX62PHNAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AM5fe4ma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755768209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOJOZZdThAmSYOmW8vQd0bDMJuONYkO1YWwTFftLPfc=;
	b=AM5fe4maG/g/9HnhWALhkMhB7DAVlIfNZW2OnmvPGcRFmuBi2R18sKXaGL/Vp8t019OohU
	drQDgcMMHjxLxZESSfUYkIzrbC5tcaAaXRrxZhv9IoKJZqMNqkHge1yGhAvnScSLcqImMR
	zqfsyqM6dExxXSewXNRKtHvXzleoUsA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Ubn9_8LMOheWsVBbMH_v3Q-1; Thu, 21 Aug 2025 05:23:28 -0400
X-MC-Unique: Ubn9_8LMOheWsVBbMH_v3Q-1
X-Mimecast-MFC-AGG-ID: Ubn9_8LMOheWsVBbMH_v3Q_1755768207
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a927f570eso17071636d6.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768207; x=1756373007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOJOZZdThAmSYOmW8vQd0bDMJuONYkO1YWwTFftLPfc=;
        b=BUyUMLZrSMi5cbCqbx1s1/wilSOYjKBK3S+L0gdj8yzWTGrCE1zeM1Cbq7thaZvSIF
         y6Mtf/GuXgLdF8Dk5eCuv13seGLys2tNfyxmgjN98coZ0Mf80qY8oqOxiYL5vRk/dWKb
         +sm0v5oCdm2rKTKd7lbF5R+LKQ0rywcdYxM6sQCx/QAbWlVa+qywup1uvYTFuFgzwbyY
         q8x/3GiVDHhv/tA2fk6rEUmTro4c0pXCGSSDDXLtwXIaXmc3rGFq29Zi3IPryL4JkFvL
         YADJ5Dqe0G/cGXCy6vpuUEV1LnUCpil6t5L1jcAYf05VUbT5gKMNAm9vULGzVrOz1X/h
         lDUQ==
X-Gm-Message-State: AOJu0YzbB0WB1HFEg99TRSWKl2MBbcOYfxlyMZeAjWDhPpz+NKmoGcsW
	0zLD51EHW4TBJReNGSUiXFbfZG6u0cez+kDuTCXARfEv+bLtTed6etxavpn2KHoCCRCxhmaFeMx
	9XjT3PaMeEo9a5trYPBK+THWGXfJBh/JdAcDTmlskDRz5EJ8ehbzs4wUeaQ==
X-Gm-Gg: ASbGncuyvGNcUiST/3umvhUYbJ8s75SrJegeF5E/Vqnj6dKExe9tuJ/Vkn48LyoE6lG
	jb+ZCSSNg9QyIOfa0yECOiM+W3YfqgWfdkWwqvDovowyvR4/Plpc8ze7gQCgkm8QSbef+2a/Eir
	x3ACCrw+o9pBY9OhbkvPnwghRGbxVMfri3gpv8ctSNjrlF5y/tra3QP60pFiixigCojMwcg2amB
	wZi88r05cg05Lg6A9qNGIzDtUV5iwKnvsTvbwoXHo6cml1qC1TjiHiFBigcKH4OkLjQZFXJPiDL
	OMD9m5u7CY9JiRY+MHX5Kpzf4JE5wuSpGlL6p8tYDHRNEtD3Z9D//uNm2tIHtgJweUIExGUOrjO
	eCvqLWUv2Puw=
X-Received: by 2002:ad4:5bac:0:b0:707:4aa0:2fb with SMTP id 6a1803df08f44-70d88e92700mr14422396d6.16.1755768207421;
        Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHQeoOWaOCAlmZqkreErWZ1WAJZpVAGCQsupGfVEE7FWFJd2NfiFuKMU9Iyktu8wjNf2tj3A==
X-Received: by 2002:ad4:5bac:0:b0:707:4aa0:2fb with SMTP id 6a1803df08f44-70d88e92700mr14422236d6.16.1755768207031;
        Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9382300sm100386566d6.64.2025.08.21.02.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:23:26 -0700 (PDT)
Message-ID: <062219ff-6abf-4289-84da-67a5c731564e@redhat.com>
Date: Thu, 21 Aug 2025 11:23:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: mcast: extend RCU protection in igmp6_send()
To: Chanho Min <chanho.min@lge.com>, "David S . Miller"
 <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20250818092453.38281-1-chanho.min@lge.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818092453.38281-1-chanho.min@lge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 11:24 AM, Chanho Min wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 087c1faa594fa07a66933d750c0b2610aa1a2946 ]
> 
> igmp6_send() can be called without RTNL or RCU being held.
> 
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> Cc: stable@vger.kernel.org # 5.4
> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://patch.msgid.link/20250207135841.1948589-9-edumazet@google.com
> [ chanho: Backports to v5.4.y. v5.4.y does not include
> commit b4a11b2033b7(net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams),
> so IPSTATS_MIB_OUTREQUESTS was changed to IPSTATS_MIB_OUTPKGS defined as
> 'OutRequests'. ]
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

FWIW, the SoB chain above looks incorrect, as I think that neither Jakub
nor Sasha have touched yet this patch.

/P


