Return-Path: <netdev+bounces-236299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1382DC3AA90
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82480189F0E8
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695D3101C9;
	Thu,  6 Nov 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdEyq71R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lnvYLxbr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EA3101C8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429344; cv=none; b=kDNhPEWtjg6fVzYx0tMK/6Azm+OTFMrL0iMH0BNQHqRxUaaw/CiG8pwhNM4jg006b6PcAku7NtB65kItSeVM0ye0WS0n+aVbNY92gKkgG9TO9ON17RV9rbz7pzdYQLw/8y1AapabN8REjxdh+JuOtaw8aGiebxp4L20J2QlFS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429344; c=relaxed/simple;
	bh=skC26cRzfhs694yk1GvmPhOCKjrsCkj5WGjm2V3nag0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YADTbi6BeQjDilr6d9TTkERVwyZILZ6rOkw43v7WNU3P6vbB+hXHgauL4g4pYLwABpQR8+eg2IAHguN6R3DbBZLU7Wx+W3Bnk5VhGK+134EgrAzJDxe26KSEG5iu8a+mlaeXnFEph9z58CB0loWY7I4rK+mhfC7BHtYLTGOBE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdEyq71R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lnvYLxbr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
	b=YdEyq71RCqFAJgz6OBuuP0L5rIylrDW2XGpa3TRB8cM2kg2ZJ16bcBrK4INvzCGmaDRpln
	8NmXaQOf3uBxYgVR9JX5jVeBeqP84tr5dapc66jDyL8We145yR2bioCKhQ5ZSIahoZLoMr
	H78m8atfbyXFd/FhuR0u5QWpSzuK1ZU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-wQM8MupFP1GHtWpOC25Hgw-1; Thu, 06 Nov 2025 06:42:18 -0500
X-MC-Unique: wQM8MupFP1GHtWpOC25Hgw-1
X-Mimecast-MFC-AGG-ID: wQM8MupFP1GHtWpOC25Hgw_1762429338
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so271341466b.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429338; x=1763034138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
        b=lnvYLxbry/U9OU0LBYf5XlgU6ioCAzO2geBEsRSwpVkyfcxFo7PB8igo5pBex/t5Nr
         mQS76EBVyKHa8HMEf/zrL6c2Xm3dSs/KDGQq6F7gPC9gGvYCeeKrZmWb1flnQLlJVCgg
         zNgxJ1f6ZccUjKsUp9lZBqeYMLuy0szITyR5laghUJdL9Xriz2uMUE8/Tk/mz+20mwFV
         OL/zZ5csXkRH8Fz1N+n4qz3pnbBiRq0CtcOjOM4Ni5nhQbirr1gY3c4qUGWWobimbozM
         lz+vaURRuW6IbKx4uzcsglhScB2ybHUKjqSsIboOMCtl/5HchlUHgN5H4I9LtFYxviRV
         YK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429338; x=1763034138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
        b=h2csJqreickgZQPZ1W5nHM874e4FxLqlGHZ+8h68QfMGeH5QoPBx1qtfCkdvukWkQm
         UdsEpWElr1Mhn6ehDb7nkdGUaoylFnY6pyXse3/LighjQb2x4oqtDoiG7Rs6sP3SDyM1
         TxBtbqTfHz0CVH/KXngL1AtrtT//JB1af9L00ibE37uaqmGlRkjMOcub6ezrmwIdW87T
         rFChbt1OphekbbeJCj2a7EXHFYHYxJZiY/tBrQKbdJOSD7/GIaaVwSkEnuttvY5UQNJ/
         EZt1mmXVzQvXvf3t35kng20ui71EBA2n7cpbrsyd7y2ihEDIKYVF6fUmpBD6VuDD6GS8
         l/ww==
X-Forwarded-Encrypted: i=1; AJvYcCU9SaS5+MLk90D4CH28JnMzI+KZrLDdb989u81KJcoBkrpCIgLztNcD+dwMKSH3e4EHQnM4UtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNe5FNvpkFxw2nNpg1zum4M96KbJBr1CVYmv3kxDT2efKcRgzD
	VYbH4PTe1bTt3OuXADqXZRSYLpSSzClYx4GgtE+4KDky6HkzA0GELkkaOwgMImHRR+c5H3ivH6U
	wUQAJncrGZ8uoPonvOWLiNfjcd+svg+yHSZsVWt8XJstcctPeulGap02A6Q==
X-Gm-Gg: ASbGncuugj59yUwCnqeI94DAqVoGpv4RVrBiXzaP1j59rLpPN7q4jmMAR6QEfmt+Ayt
	5HGs00t9U431ccjZ+W5VT5BKGygceATPr4g43JqPVk9btvrDNqgmHkCLqltYjE7qbCMb43iBNf9
	6oWNRKuh6FUNsrC5IyF8g45ePggGvR2HKJLMMlkqg40+7MV3ddeosJL04UPqlsvtiN77ai6baDs
	FU0sZgCfbq/q2FXtxC421KXZX7B7YezY3gW3AH3doG1kOWwNvLk2ByrXez1W1Xc/Bi66YaBHTvS
	ePu8+jRlu74CaGLTYYWtf7vJk+AEuIEd/PnpAh1u36ujw1tsXufS5doT6MrjVkQY09ZStGQsY8H
	Ljw==
X-Received: by 2002:a17:906:f591:b0:b70:c6ee:8956 with SMTP id a640c23a62f3a-b72893d8e8fmr339801066b.12.1762429337664;
        Thu, 06 Nov 2025 03:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOB8p8VKAkDWd7Zb5ZOoLgXt76WYCHhozdvWiOM8SoWc4iM6IK84Od+ej6rTPGojaDwrxUhw==
X-Received: by 2002:a17:906:f591:b0:b70:c6ee:8956 with SMTP id a640c23a62f3a-b72893d8e8fmr339798666b.12.1762429337263;
        Thu, 06 Nov 2025 03:42:17 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289645397sm194955666b.41.2025.11.06.03.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:42:16 -0800 (PST)
Message-ID: <aeaa5b5f-8697-4431-82b1-c890d67ebd41@redhat.com>
Date: Thu, 6 Nov 2025 12:42:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 06/14] tcp: disable RFC3168 fallback
 identifier for CC modules
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> When AccECN is not successfully negociated for a TCP flow, it defaults
> fallback to classic ECN (RFC3168). However, L4S service will fallback
> to non-ECN.
> 
> This patch enables congestion control module to control whether it
> should not fallback to classic ECN after unsuccessful AccECN negotiation.
> A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
> behavior expected by the CA.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


