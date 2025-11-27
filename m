Return-Path: <netdev+bounces-242331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BE2C8F44C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B320F341D8C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDE334396;
	Thu, 27 Nov 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNoF6weI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4o19SF0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99927602C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257395; cv=none; b=eMM6KJ17qbn8bm+2uLIJoZ3/6Z/6UAxxC8Q+x/qeFoxCIZACeeDSFoC5pXTkb2TeTZDx/TC+9ihZXAaZ+Lwaqcv6akgmhN296DE16iWfHiuOmEG9tUaKdp8lvX6EtAC48GkmDmiEVIApKbEH+ZPL4mSM6eH03azWUGCcidUAxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257395; c=relaxed/simple;
	bh=Q+yvDDwFY1D+geMCQr2vNJ4z+lz0BHU2Zk7Ni0x8J78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1QnysjPEK8ctr+a5v2e6jya6IsHRdiAIZqmRZ6f+0tHsTpgn6G8naDDBWnEwSWD9aO0KQvCRYQXF0D10iYW3ovGQuhV9oeCvnGToeYBTH4Jb8cpgwVTXQ2dbdJy2gd94TcgXzofA/PH4G13kedsBh5lyJtaDcOOWHGe+65pdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNoF6weI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4o19SF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764257392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qr2PgG7xe5f+wEkqXvKcY1v2BMi6s2PMaZnRkPGnt8=;
	b=NNoF6weIhWqAh6bg2m9ySrMqgXpTVz7enZWpOI8uN4arfE9/y6uYD9tI7xyTN4wUojW8ue
	P73wZ8hwRnXxsMzq/sy+BBMDJxJjxS4i3pdJb3skCIxE5CFQJWDuBti3M7Bi8OHmPWgP84
	UXtssbVZ2wxOjmX7rdukAgZcm7EkM2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-4XFtMsE_PzSyUTUAMtTtrQ-1; Thu, 27 Nov 2025 10:29:51 -0500
X-MC-Unique: 4XFtMsE_PzSyUTUAMtTtrQ-1
X-Mimecast-MFC-AGG-ID: 4XFtMsE_PzSyUTUAMtTtrQ_1764257390
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b432aecso6245615e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764257390; x=1764862190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qr2PgG7xe5f+wEkqXvKcY1v2BMi6s2PMaZnRkPGnt8=;
        b=c4o19SF0FnABCVYBe29uQ3meY7YPWYOFSjLTSAPaw87Kn6BPRf1T2Qw+/lYYb1K10j
         mFxpxqv1DQleHr3baCVrM1Vg1nY/JcBF4A0rfvZbDaO8FW2yD6GcM8LiMs9ZPFUQSXp/
         PJhKmCoGnhD2JWFzF+P8xm0kHYkeAv+aa0kIp/Q2IjNjDrzF8mlOAtmWJQwz13BM+xXZ
         JZYo5zd1HanHB39Q8LMFxP9S+FyPrDi+hNVFzVzW131bj7Sqtpn6R3hnnPsu+QWwfr2P
         ADHJ+XC4eKuC66Ncw+D0Bf59lm2FF8dYEsYwGERD5uFiMBTisVR/GyOQmDRkyEAKAWpD
         G63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257390; x=1764862190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qr2PgG7xe5f+wEkqXvKcY1v2BMi6s2PMaZnRkPGnt8=;
        b=YoOv3zbHqx0APPOgPg32NoXxbd2wCrnpetCxS55m/izrr2DJ/GqDfwSXIPRMHqiyqe
         Qwej096ykl0cQUrMZ6sKRX3j31g0FbjHbZc+NGhDJljB844Be/J0cMlFwGZm2Y4WNoVf
         Yz4a05pD7uQO0S5eWoC+K5B9aW01YYw9MZBWd0kCsPl5TUgdQXMgE2iwJ1FJFA2Ujpoo
         yXj9I+R6cSFlCLWu2AvljFc9i8xRYEwc35KSJcIl1KAyaWTbO1VH5boElIG/JmjFQL0k
         XGZIugkA6I8kyUBoRBLlDYYgZpFdbRAWBTNibbFfJyedMCOA48P8PQY/5RQLICx3+kzP
         ut5Q==
X-Gm-Message-State: AOJu0Yzmtw+eRrdz+o8fnxnUY9SnaPIbnOxzjAsQRnb9kUrqrBeCwvLZ
	r4Qdazv9fnNL56HmpVmN4S6vtbduYzOHaRJQcB7JoxGrJfQLY0AwERKmmFpv0iUh1/eDA+mCTT4
	036L2Vjo5sIIRNvHSqMBs2/tN5WwsLDApS/ZKbJ5XTOzY4pCsrAlfc7hBpA==
X-Gm-Gg: ASbGncs6L1aQINE99C8lF852raZXt/T2NlqwXU9xaxzZ3lvdVZ2AGLqp3rw0qA88t6t
	WllR/3QALkZh/87AyGkaLQtcs5QVbXeYnNPiDAYWLjnZR+l9saaTSJO0dKkzP0C62YD01Nd8GXY
	9mWruUqaVZ7zpX9lGj5AYSvXvN+27dnTyvxMQnfPK3iPCw6Z1uZNriAxmCMJE+elgIQk3Oo4Zt+
	OK7MFc7VgWeDtP+QAqDfamxZH/vQdDi4EN2HPZzOhMETVmzdlWq00yUnRCPxmWsSYicQfZqtdD9
	Ygq86DB5/677PCGswdSGhL9SsfThyToLHJuwtz8h/vQpvApohs/15vqtw6UwRwPRggO3cAIkvHU
	T1ze6onM0EG+uFw==
X-Received: by 2002:a05:600c:19d4:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-477c112635amr208634645e9.27.1764257390228;
        Thu, 27 Nov 2025 07:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6EjJopCbjI/4LJUJi5H8NRT2Y1f3vZt8QNHKaMLuh5wJZtyqrpT4xy5o+MTv2JVA9T3EZvA==
X-Received: by 2002:a05:600c:19d4:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-477c112635amr208634365e9.27.1764257389834;
        Thu, 27 Nov 2025 07:29:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm67904185e9.13.2025.11.27.07.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:29:49 -0800 (PST)
Message-ID: <7f7238d8-bf0d-43f3-8474-7798e8b18090@redhat.com>
Date: Thu, 27 Nov 2025 16:29:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] bonding: restructure ad_churn_machine
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-3-liuhangbin@gmail.com>
 <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com> <aShbAp7RZo8sfq2C@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aShbAp7RZo8sfq2C@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 3:06 PM, Hangbin Liu wrote:
> On Thu, Nov 27, 2025 at 11:36:43AM +0100, Paolo Abeni wrote:
>> On 11/24/25 5:33 AM, Hangbin Liu wrote:
>>>  static void ad_churn_machine(struct port *port)
>>>  {
>>> -	if (port->sm_vars & AD_PORT_CHURNED) {
>>> +	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
>>> +	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
>>> +	bool partner_churned = port->sm_vars & AD_PORT_PARTNER_CHURN;
>>> +	bool actor_churned = port->sm_vars & AD_PORT_ACTOR_CHURN;
>>> +
>>> +	/* ---- 1. begin or port not enabled ---- */
>>> +	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
>>>  		port->sm_vars &= ~AD_PORT_CHURNED;
>>> +
>>>  		port->sm_churn_actor_state = AD_CHURN_MONITOR;
>>>  		port->sm_churn_partner_state = AD_CHURN_MONITOR;
>>> +
>>>  		port->sm_churn_actor_timer_counter =
>>>  			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
>>>  		port->sm_churn_partner_timer_counter =
>>> -			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
>>> +			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
>>> +
>>
>> Please avoid white-space changes only, or if you are going to target
>> net-next, move them to a pre-req patch.
> 
> OK, what's pre-req patch?

I mean: a separate patch, earlier in the series, to keep cosmetic and
functional changes separated and more easily reviewable.
>>> +		if (actor_synced) {
>>> +			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
>>>  			port->sm_churn_actor_state = AD_NO_CHURN;
>>> -		} else {
>>> -			port->churn_actor_count++;
>>> -			port->sm_churn_actor_state = AD_CHURN;
>>> +			actor_churned = false;
>>>  		}
>>
>> I think this part is not described by the state diagram above?!?
> 
> This part is about path (3), port in monitor or churn, and actor is in sync.
> Then move to state no_churn.
> 
> Do you mean port->sm_vars &= ~AD_PORT_ACTOR_CHURN is not described?
> Hmm, maybe we don't need this after re-organise.

I mean the state change in the else part, I can't map them in the state
machine diagram.

>>>  	}
>>> +
>>> +	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
>>> +	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_churned && !actor_synced) {
>>> +		port->sm_churn_actor_state = AD_CHURN_MONITOR;
>>> +		port->sm_churn_actor_timer_counter =
>>> +			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
>>
>> Should this clear sm_vars & AD_PORT_ACTOR_CHURN, too?
> 
> Yes, or we can just remove AD_PORT_ACTOR_CHURN as I said above.
Generally speaking less state sounds simpler and better.

/P


