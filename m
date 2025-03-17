Return-Path: <netdev+bounces-175408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C33A65AEE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A461884EA9
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F11A38E3;
	Mon, 17 Mar 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtX15H/G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18217D346
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232886; cv=none; b=YFMR6LT2tqoA3WMcM1O7S1w4kryiK/f2ZHajxQvUEthYkN9lpR9T79iAaiQ7HkHhdnB2BWAw59rIZQLhJoZG4dFueQPH59yhnUHmEtfbE5B8wCzo8FGVfQDbo4tvwWxspxv7r8ArokNAu4GjANTlPRGT8+r1A3uye9j6GN2bMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232886; c=relaxed/simple;
	bh=AE7O+HTLc6aGD7Swg7gzHI3sU9vyqgNlA5NhaXp5jb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MftSL9RgrEsbNAmlOOCQlSGUXbsL8l5pENLIeEkOEwRneuy6tU6cyX5Mq8Jl+c3v83Uzj4DYXTIanwImNV5Iz8oWsTCMjM0CcajroeQTA1m5L/0EUYPHsZPVW8tbvhQTT/AdvKH4BTAhW/xUlqd1n6ATpCHS2QerZ3h47/pS3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtX15H/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742232883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rcx4jW3bSmWrOin2e+jHJf2gUgkUZibpiqGShvUlvuw=;
	b=ZtX15H/GujJAoQkjatP6mRRHQYlELgw1tDpnzuTtZ5ejbYbvW2guyt1UndsdtKC3htUmxY
	86D6tgU2ymg/xx0TEhjIEsI4+fYCngcy6rNDvc+CJcUNggbpcBWW/XVwvRHLwK68Cnq50L
	AqEkP5jzf27pJdy8T4/B3+RQdH/W2Xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-cjwP5p6nMUuVCOzd0B2NDQ-1; Mon, 17 Mar 2025 13:34:42 -0400
X-MC-Unique: cjwP5p6nMUuVCOzd0B2NDQ-1
X-Mimecast-MFC-AGG-ID: cjwP5p6nMUuVCOzd0B2NDQ_1742232881
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so12566845e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232881; x=1742837681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcx4jW3bSmWrOin2e+jHJf2gUgkUZibpiqGShvUlvuw=;
        b=KfDvfzQrv14+dtEtJ9WcYl8wJY+Q1/vhDObtp/qA3H4uMM7HfbJufZi0npJcY0XM1k
         kxgt/j3pR3lOLz6fY+DA6W4h2Nm4ytVzPKbY59F1+7IhKYg6ZsahvC/9qLfuaT+NK1Kh
         FPnXRoRh9FAYyHTQh5J1AGRuBEZmym49z9I1lPorwFV/vuKfqA0TeQbN3p/5ZMiccJMW
         8kgH15Y3lEnL2TUVW0mjLKwier9p4eIQA/KR7ehMIeec+4VDoTM9+lok4+0wxM03kmDg
         xkIYmz9VbiNVNenKlZffgjxh8vcbmTcbFMm/LJ77IStzQCxG8L+ceM3JVA6+9LAE3Jhl
         62cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUinVetwoNPYh5xDlx830nUXognGG5WbVFPyRaaOswh4VrhK/hcea5L6Plm0u1HAJQTdEwc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYk+lyjPZZFGDEO/rubDkt4j214kzpQrJ8sSpqcqqsjkxcjx0t
	lkZIgC36DYMpYr66W4hYX+Sf50/ySAGizkzroUI+JaEyP+61Jo3LR4uoFOvYVVsFs/DV2EbVA7D
	AJOcC1ntRQOYUMEDxYFQVDr6ZADyJsoNpiHvceW7PNKnBpPxXG6oyLg==
X-Gm-Gg: ASbGncsTI9mKncRVFww/fCXr2Jz8PzDWzRZTD/otvA01cMIgkak30VXQa47qKlRdCij
	lwWQGxwhmULTERBNDwW/cjZ8/Y4BpgiT+30nlnLnTqUr9mv5UuGzrpl5N/FddegdI1J4yBD6zWF
	cz9p+i7IzfMnZDNGlpIAHlZo+sFr710MWyhI3sduZZ34zdODkwyBwsGhI5v3X85Gx/6iS89XwnJ
	jBTQh7Dry9xQSUtFS/NtcHLgkvIH0EjHQJ9WIVfoEGCwPyZT5ycUPKXFjFWWlv5eEg0T1meysSe
	sPxRPkdsV3C3fOnERS+AbZdCaDhVYcHVqT22Fsdp4/lYkw==
X-Received: by 2002:a5d:64cc:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3971f9e798cmr15340426f8f.54.1742232881181;
        Mon, 17 Mar 2025 10:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH07D2ZOpfJBFzw6dlnkXuEvZ1zAjKVlbD1ulYGuVlRyj1HqmH+xeyba+sV8D+fEP+JRkYLHg==
X-Received: by 2002:a5d:64cc:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3971f9e798cmr15340406f8f.54.1742232880843;
        Mon, 17 Mar 2025 10:34:40 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm110075705e9.38.2025.03.17.10.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:34:39 -0700 (PDT)
Message-ID: <0c5a60bd-ceaa-42f1-8088-b1e38f36157b@redhat.com>
Date: Mon, 17 Mar 2025 18:34:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/18] openvswitch: Merge three per-CPU
 structures into one.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-11-bigeasy@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250309144653.825351-11-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
> exec_actions_level is a per-CPU integer allocated at compile time.
> action_fifos and flow_keys are per-CPU pointer and have their data
> allocated at module init time.
> There is no gain in splitting it, once the module is allocated, the
> structures are allocated.
> 
> Merge the three per-CPU variables into ovs_action, adapt callers.
> 
> Cc: Pravin B Shelar <pshelar@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/openvswitch/actions.c  | 49 +++++++++++++-------------------------
>  net/openvswitch/datapath.c |  9 +------
>  net/openvswitch/datapath.h |  3 ---
>  3 files changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 704c858cf2093..322ca7b30c3bc 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -78,17 +78,22 @@ struct action_flow_keys {
>  	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
>  };
>  
> -static struct action_fifo __percpu *action_fifos;
> -static struct action_flow_keys __percpu *flow_keys;
> -static DEFINE_PER_CPU(int, exec_actions_level);
> +struct ovs_action {
> +	struct action_fifo action_fifos;
> +	struct action_flow_keys flow_keys;
> +	int exec_level;
> +};

I have the feeling this is not a very good name, as 'OVS action' has a
quite specific meaning, not really matched here.

Also more OVS people, as Pravin is not really active anymore.

Thanks,

Paolo


