Return-Path: <netdev+bounces-175409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD77A65AF7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6501718AD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013111AB528;
	Mon, 17 Mar 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLWFAtED"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152D1A4F21
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233134; cv=none; b=cDlnoApRJIQpJhXM2oFbW4qjzDqH3l8cLrNEefhyZW5k9iPhbjQSLEKbVfcpfdaVWRlZw8IIKj7nvm/CnMMoGmf3gxpBTr+kGsnNktv18rzUuRu0YyQ4nad66kIvQlOGBVM76rb5k5nKHYvee5EoMRLFGD4eKLyNHuEg54L65yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233134; c=relaxed/simple;
	bh=s+9ZsvkD2j3GdUweFp66Lf7ZZK215lyFm/3uP/3NPVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ugb9+OVE4WfO5U4yvLAiEzTI5gMg9Fnc0xSjd/WrbFjSulpIBJsBFJ4l8reL5AMdtmR6Eq+Yv9uCICFoL6Tc48RvroXIJmcmurLPsjFWBiK941kodoVU8vghyGW5hQjBrdRvC7p5Bz8K6l5NKzPTu0daHShZPpJEtb1JQFjsi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLWFAtED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742233132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxJEMSGeykA76gAbT4QG8RZ8xXKOHWsugBkWtHC9fEs=;
	b=BLWFAtEDTuAHmbQtAthaE9yZHyaQ3QDUQw3/8g/Zqyce131MVc1ZxCDrXoT4o5RGQRRX1+
	HxtayVhQdHi1Xiou0ADYzxhQlePUC2WN7BuwZlRH6rSFbkfc/AFbnleiRCFnJPqexGTO0M
	27OUC6yza8EXFT8mudC4uIU60byHFHM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-0B4KQaF2Pa-hRC9t98bOEw-1; Mon, 17 Mar 2025 13:38:50 -0400
X-MC-Unique: 0B4KQaF2Pa-hRC9t98bOEw-1
X-Mimecast-MFC-AGG-ID: 0B4KQaF2Pa-hRC9t98bOEw_1742233130
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so20724365e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233129; x=1742837929;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxJEMSGeykA76gAbT4QG8RZ8xXKOHWsugBkWtHC9fEs=;
        b=qH79WFFkWUe+DMMCuuRvIvE2dsCe5i2dPRfMaWiAmm+dffMT+Gs/hJXyxrtd4vy7mE
         5TErYdsjNpUwcmO3AKfTf8gwAOwQPatCWSAv13yHx6fV/NQAZPlTTbNf8h+FHFHlBocT
         6hippYPvlNehdGrP0S7jUQIfbTo5EDMM0/s0i6bn0htDzYAFfZ3/ivuYjsYqQ7nO8gB+
         qbr9Ooj22JKGuwUi8mLDSt9EDadNIXFIiYPBc0e31amHhlHEKS4TyoQQkOW2OTG7g+Bo
         ENPCAZ9DX8sRWgh11gROfcJI4C2YvCbIq04Z2r1VarSZTtL4B0lP/8LPEHsiqA1vn6S2
         eUag==
X-Forwarded-Encrypted: i=1; AJvYcCWkVDhBdpKo6mtlp9GjMPB2+XNcJ9COj0cnjcm57SyDw0PEVsEw65Io8fhrkXwh5BiPBwdfOKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUhtA4IFnnR5XRgnDnwys2DX1gZsyJgt6FjBRJ1fY9Q6+Mn2m
	vJlPhmsz5ZZwY/PwrOTLrNVsuZeiR1ctKBe0Ygh6MM4Ngi7x3c2UiC6Y7OoPPfzUiAsQsolPoz+
	UsCEsNNcICFG9DaE2LkJeh+mtYKa+9LEqvEQWT1dRFaefli5+5XfAGg==
X-Gm-Gg: ASbGnctFK4TJaEKwPBWJffuqJoOpwFe+J67+rqym+PfR7Em0IhrZj5hlD9ZdAY7k4hj
	Pf+eTvaa9b52HRdzAfUkkPTuNblCf+ARXwnJZwTOQC6dPybF2td8ThV7dtP1Ttl+aUUZxM7qZwx
	3eiWnqA7AeN1MC4uoeyN2up2a+EWGIioCbIFP5GnG489iIr8IZXzdhp9q1mfknyOV7CLFJ1NtHf
	TbwIegyon2+89p4z5VN+L+cKNLvZolXnEaE7AdLouffia54UQIUSccErqrnoZUJ3B1kIIJSaOY1
	YF7ZA3tm+7RnQXRInGREotlmHeWDiUdTHVyX+EzUpzeqQg==
X-Received: by 2002:a05:600c:1392:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-43d2565453fmr83010425e9.28.1742233129620;
        Mon, 17 Mar 2025 10:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH79Njna9ru06osa+6QDxJxQgmXhABSjMREkRCTNMy/jkQd2pnE4lCUFaOogWeF/asOX2iycg==
X-Received: by 2002:a05:600c:1392:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-43d2565453fmr83010255e9.28.1742233129187;
        Mon, 17 Mar 2025 10:38:49 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe152ffsm110082015e9.13.2025.03.17.10.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:38:48 -0700 (PDT)
Message-ID: <64d435b2-ef49-4be3-aa73-a065d7b9fbbf@redhat.com>
Date: Mon, 17 Mar 2025 18:38:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/18] openvswitch: Merge three per-CPU
 structures into one.
From: Paolo Abeni <pabeni@redhat.com>
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
 <0c5a60bd-ceaa-42f1-8088-b1e38f36157b@redhat.com>
Content-Language: en-US
In-Reply-To: <0c5a60bd-ceaa-42f1-8088-b1e38f36157b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/25 6:34 PM, Paolo Abeni wrote:
> On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
>> exec_actions_level is a per-CPU integer allocated at compile time.
>> action_fifos and flow_keys are per-CPU pointer and have their data
>> allocated at module init time.
>> There is no gain in splitting it, once the module is allocated, the
>> structures are allocated.
>>
>> Merge the three per-CPU variables into ovs_action, adapt callers.
>>
>> Cc: Pravin B Shelar <pshelar@ovn.org>
>> Cc: dev@openvswitch.org
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  net/openvswitch/actions.c  | 49 +++++++++++++-------------------------
>>  net/openvswitch/datapath.c |  9 +------
>>  net/openvswitch/datapath.h |  3 ---
>>  3 files changed, 17 insertions(+), 44 deletions(-)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 704c858cf2093..322ca7b30c3bc 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -78,17 +78,22 @@ struct action_flow_keys {
>>  	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
>>  };
>>  
>> -static struct action_fifo __percpu *action_fifos;
>> -static struct action_flow_keys __percpu *flow_keys;
>> -static DEFINE_PER_CPU(int, exec_actions_level);
>> +struct ovs_action {
>> +	struct action_fifo action_fifos;
>> +	struct action_flow_keys flow_keys;
>> +	int exec_level;
>> +};
> 
> I have the feeling this is not a very good name, as 'OVS action' has a
> quite specific meaning, not really matched here.
> 
> Also more OVS people, as Pravin is not really active anymore.

FTR, I'm processing the PW backlog in sequence (and with latency...),
and I see only now this point has been discussed in the next patch.
Sorry for the noise.

/P


