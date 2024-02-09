Return-Path: <netdev+bounces-70490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A948A84F395
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9EF1F22B42
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45224B2F;
	Fri,  9 Feb 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dUc6su7z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF12421D
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475122; cv=none; b=g35OF8ZBhSbTu3+oOVutBaIBG49NIdzvA/bryvC0xpLVguMEDtvJGi8ib/EWqcutJJTHHt14BrvaV+qZCMTQcF9QQY2M4PTpvVUAz2TrU9UOeBY6egm+9qmqFkGEHbjb5BADwpR89DOR/AeyzME80gYFjcUoo1xC/vpfvhnXbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475122; c=relaxed/simple;
	bh=AdGLuSDUgdRKcKbG+AAXbZF1yPUywnC8Z1fZNsd9E84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0XeaUwVJ9hN2MOpfGCGrHC9YzugHOyNkRit+yUDXJgKxpFNjhBqu7jBfCaz9rxXfHZGXpBWM/KydD8GeTM9oJYUe03/tNxG9rDQX3H3zA6ju1gNH7HsQJIwCR/KBEhhQYbG5d+yjBD4l97mwHQKHgblOq5B+1GWfneiv8v9HV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dUc6su7z; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a38a1a9e2c0so93833966b.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1707475119; x=1708079919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eotkroT+61bC9Mu1QBDYWe4mxTygOqxJxiimEJs0tc=;
        b=dUc6su7zD972G956eAp/RflJ0ilSzdEWhbxDdhNC61MFJbzA9PLbdTQN54HzBXsMlf
         4wRKBn9Krz/eBvfz5lDA7YYVsWwUtV8CGARjIhEe9X9etVd8Gyut1INhF4oEQnd+VKiS
         8NfB0jpXITUCEbKv2W0ASHqgDf69DbWLYYMDEu2QaNkAltb20B36Y3OFj3lLVcm6068a
         M0xAF3+CfQR1isgtZ23j2MRq0vbpW58fI1ebO4uhrRBzpj5tvLQhA943fk7l4GAlshy5
         Ag6c//txHoTw7/5bSXjsCnYSKb1bpkRwvjknoUQs0EKbcH8mjZoS5arcodmDH7CMmOLE
         0JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475119; x=1708079919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eotkroT+61bC9Mu1QBDYWe4mxTygOqxJxiimEJs0tc=;
        b=LgaKDiTAFuGlR86L4RftHVZZRWzMOavUPW7+acJ7hsvrGcxQq/8A749pS1SOG2tELx
         Jc8stvkEif4Kn7nBiv5Foj7lYniCMz7AuOHqo61KZpuZjCVpW3H0MqYxZswj4gksxXMt
         k2N35OZ6HddUvISkBn6+j/uH3npBHMt1ce0av+1WmL3ozALzI4527RLdmH3BHESmgzpl
         +H66DeI4cKuIHK/9G6hk/dfFsnUMBFE1ODEVwnd1QGgKxrRer7ZIjFX0rxgTr1N5Ghc+
         orpU3jDrneVqVanKDWf9BrE0xzKonzbkZkGuJ/0uZ4PBf+wCG1rqHfcnWtDwi1HMhdvb
         PYsg==
X-Gm-Message-State: AOJu0YwZm2+P7gIBAnozYrHtbEq+OBywpNt1wrekhLz+99RDSMZ4zPb1
	Q2xHqkXOlbkcNj5q9WE7v6THgNhHi0/OX6ywbpot8dTD6uV195uufxZRrD2KyQk=
X-Google-Smtp-Source: AGHT+IGa4EqcktpvGetehclPAHMHoHZzzd4a0t3esTUFOZDaSMcGbMKZLur7QpnMm3qf2edjHSI0hg==
X-Received: by 2002:a17:906:561a:b0:a38:a6b2:b335 with SMTP id f26-20020a170906561a00b00a38a6b2b335mr886011ejq.2.1707475119029;
        Fri, 09 Feb 2024 02:38:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAQ6W0V1aKGY2OLOhinKOCcGAQTYygBD9JzySf/xhyIqIqmtbqfVJ5fZCw1KylxA5cvLPjHxtOGVN5KwzBH3/xu8LQkExb9cXpe8HFI1G/MU00rbGut/qsjrkiejrLWKNWTqBdzE0GtxIrSD1wqza7J7HIAu017cBZ747PkylgppgnwgTZd4/jI6bCIfaL/x0a/4+OGcyKCfNKYzqPW06BE9Csz2CR3vYjHbC3rn9A5N89NwuSBXGXLuCfmEUSCY9KQp9U
Received: from [192.168.0.106] (176.111.176.127.kyiv.volia.net. [176.111.176.127])
        by smtp.gmail.com with ESMTPSA id tl13-20020a170907c30d00b00a38378d11e7sm626760ejc.132.2024.02.09.02.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 02:38:38 -0800 (PST)
Message-ID: <ffd89f0a-96b8-49b3-ae60-8ce70a5b3594@blackwall.org>
Date: Fri, 9 Feb 2024 12:38:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests: net: Fix bridge backup port test
 flakiness
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shuah@kernel.org, petrm@nvidia.com
References: <20240208123110.1063930-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240208123110.1063930-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 14:31, Ido Schimmel wrote:
> The test toggles the carrier of a bridge port in order to test the
> bridge backup port feature.
> 
> Due to the linkwatch delayed work the carrier change is not always
> reflected fast enough to the bridge driver and packets are not forwarded
> as the test expects, resulting in failures [1].
> 
> Fix by busy waiting on the bridge port state until it changes to the
> desired state following the carrier change.
> 
> [1]
>   # Backup port
>   # -----------
>   [...]
>   # TEST: swp1 carrier off                                              [ OK ]
>   # TEST: No forwarding out of swp1                                     [FAIL]
>   [  641.995910] br0: port 1(swp1) entered disabled state
>   # TEST: No forwarding out of vx0                                      [ OK ]
> 
> Fixes: b408453053fb ("selftests: net: Add bridge backup port and backup nexthop ID test")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      * Use busy waiting instead of 1 second sleep.
> 
>   .../selftests/net/test_bridge_backup_port.sh  | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



