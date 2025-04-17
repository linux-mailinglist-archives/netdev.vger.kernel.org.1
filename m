Return-Path: <netdev+bounces-183680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2665A91841
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B87172670
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14EE226548;
	Thu, 17 Apr 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gySrXnWp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6B226D02
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883296; cv=none; b=QJEJmoir1SvjZyXFejhSPxP1bWcOZNaqlXJNAxpXl8YUY+1q/L9fn6LWiBP7hAx5d7dSyrUJBNyEcAszRXoA0fAgkRlF2MZL0JlBpTBYSYt6OeeL82DU6RKxLWLYwD/dzsOddI7bGTRm05qUnjqWUSn96xAYeXFPOUXa6MZ13U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883296; c=relaxed/simple;
	bh=/aHET5kZKvLdkox/3VQPga2z8hoW/sDglTDP1G290yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULCQnFktSKc9cpMqLU8GCtJDMIvslJB9+KOdSXOxwqqf6hg9RKaRXGe2qwf0MFKlwSEYPgyjN5RPVX6xiMB0WQ6AIfipl55aaDIjKEzS6VLagtRndCo5As4Z/SqY5pmcOep2oTLyNO9iuL9tlxozi/dYRyIgegrXli3tfkksYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gySrXnWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744883293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YKSRN7Y1CSOmPsR55ndAShefoLbgMNdj/tzKyeXbOo=;
	b=gySrXnWp1K9t4BG0CaNrbS4J5CQ2oAfS2x53Q8s7uH1k9cuTRi0nCCmLtxAG5bRaEu/z3Q
	iDaRjtzNKoosRtMf4K3Vjp1b+B1vDSWBWXzWRK2w0hJjbRVV1P2XXIEmO+tjQjJQscRoTa
	nRXVH1VQiHHXt+diW9TCWkislgYiUew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-B5sc7PW0OV2V2HTakPz24w-1; Thu, 17 Apr 2025 05:48:09 -0400
X-MC-Unique: B5sc7PW0OV2V2HTakPz24w-1
X-Mimecast-MFC-AGG-ID: B5sc7PW0OV2V2HTakPz24w_1744883288
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43f251dc364so3887875e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 02:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744883288; x=1745488088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YKSRN7Y1CSOmPsR55ndAShefoLbgMNdj/tzKyeXbOo=;
        b=Y5y88RzSw169taRWfgpyMwPYyBQVq4ZjASUPLPJlmNl5866x2vtaJPBUxGx2Qys88q
         VSsEDqkW51j6ROuKV0qUHKyrdztvg2nMu+VGITv+pMGN9ia3rranXGKWXtdRDIEsCNF7
         nBM9d4tfbKtCfkvig8NS+rXUwSwN3AYQ6uUmEjFucGciZ3wPSQ/lw5BhOMcISVyoSBzx
         Gw74f/+VcR0ifmoD3Gj1pUjQQmSpVFgfSw+rK2e0toUnvo3++26Xqfyi0xI4OlbyccG/
         yaNLlF4Io/tQElIg6atMN6tncIjElGch7AS3NY2OoowK0Htxqv7D9scGJbhHfALnIX5+
         w55Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdasc0XSBNN9qHmhsT873ZeaDdCjmo0NHgUxyjm79ZFdIxQhHf55uMfNOomN+hwAjQQSYUDP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNL05Bi2SgJ4h1ZbIMmxXuX2JWJeegzWbXEvN1fCLPGUipv08q
	ny/9JTfWND9P7DOzJBOqSoUvG5kyjWxHsCX1JAG7J0j144TO0NdnB1tWsQnm0Y3AAtzY/jutpX8
	HIZCsp5Gih4pQl+6UTUD24rkYOQvDKQ8Bq218NNdK7wEJ07Y04WXDCw==
X-Gm-Gg: ASbGnctB/HladT5jBC7EuTf83cFIPrlyQcXS/yRdMqO2ug/PssHwjag8naviXDl3XxB
	dBjt+Umpdbf2hVx+vDz13znZgV2sXcKzD2T2xjZstLVdOIoduV2PKOEhdiqhwELfDXJLN3rYLt3
	YeJMaoRmUZddgq1NhcOVhMh/28d8v/aBJMlwyC8bGBEW/V9PZCs31cd57X6yrK02XA1CZH6AJR5
	VWdPt+XOAoRKxzUjyxKTlwud33SunPe89BIZAV9Mrcm1wd6EXPzblpszObY9quf8KC/X6UA83dL
	orsBomXF94J00MGJ2cYvTrZOn7iREXjdvwYXcsEf1w==
X-Received: by 2002:a05:600c:a15:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-4405d61ce41mr54456485e9.9.1744883288556;
        Thu, 17 Apr 2025 02:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLDK3NSaV4N4d3HAevD3oTSYRJ2ZVpwnswgN3/kRFztBAp62+ivbgG75Xh2sCTm/nE3qRRBw==
X-Received: by 2002:a05:600c:a15:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-4405d61ce41mr54454955e9.9.1744883285195;
        Thu, 17 Apr 2025 02:48:05 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b50b964sm47241655e9.27.2025.04.17.02.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 02:48:04 -0700 (PDT)
Message-ID: <94076638-1bc7-4408-b09c-7c51f995d36f@redhat.com>
Date: Thu, 17 Apr 2025 11:48:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move ovs_frag_data_storage
 into the struct ovs_pcpu_storage
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de> <f7tbjsxfl22.fsf@redhat.com>
 <20250416164509.FOo_r2m1@linutronix.de>
 <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
 <20250417090810.ps1WZHQQ@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417090810.ps1WZHQQ@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/25 11:08 AM, Sebastian Andrzej Siewior wrote:
> On 2025-04-17 10:01:17 [+0200], Paolo Abeni wrote:
>> @Sebastian: I think the 'owner' assignment could be optimized out at
>> compile time for non RT build - will likely not matter for performances,
>> but I think it will be 'nicer', could you please update the patches to
>> do that?
> 
> If we don't assign the `owner' then we can't use the lock even on !RT
> because lockdep should complain. What about this then:
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index a3989d450a67f..b8f766978466d 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -294,8 +294,11 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
>  	sf_acts = rcu_dereference(flow->sf_acts);
>  	/* This path can be invoked recursively: Use the current task to
>  	 * identify recursive invocation - the lock must be acquired only once.
> +	 * Even with disabled bottom halves this can be preempted on PREEMPT_RT.
> +	 * Limit the provecc to RT to avoid assigning `owner' if it can be
> +	 * avoided.
>  	 */
> -	if (ovs_pcpu->owner != current) {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner != current) {
>  		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
>  		ovs_pcpu->owner = current;
>  		ovs_pcpu_locked = true;
> @@ -687,9 +690,11 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>  
>  	local_bh_disable();
>  	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
> -	this_cpu_write(ovs_pcpu_storage.owner, current);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		this_cpu_write(ovs_pcpu_storage.owner, current);

Perhaps implement the above 2 lines in an helper, to keep the code tidy?
otherwise LGTM.

Thanks,

Paolo


