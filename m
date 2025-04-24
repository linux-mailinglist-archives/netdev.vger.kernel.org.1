Return-Path: <netdev+bounces-185584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3AA9B006
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CB11944344
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1F14D2B7;
	Thu, 24 Apr 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTIRFbcv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D4143895
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503327; cv=none; b=t1kROt+eY6TjSWNcHEXjfKBjdeQ5Rutpt44zr6mIOVU8rJOloO3PwdAbwbbQ5lKXAXpaveIi5UKge1IybkZxO+QoXpPkJZQvYY7ilJaJ7RobgASK5z/BcmSqJsuP1bf60WIpy+u8gyHiERwWL0vMrhfUEvG5pwNjQEzIkfiQopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503327; c=relaxed/simple;
	bh=jNF/LtDvOjw3MFL6cmDmyh+djyOEOptyQoCDk1MHM+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoPzz/SxLKzeGizzToXbrq75T0MfZBhRLdm8P2sUXrHZLYMRkCRFWKp76Z5pc+fhiSB0BE6tYPHqiiGToUwn55fCRpaXpu4AxBDms1MjhbPZLPCY04mk8EjA7hU03lY+E8Ng+kFPd0+DusDLWnHn9qBTRxwmHYA/dq2SVq/JS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTIRFbcv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4ugVGJrIOXPLKTfodxB2+3jdBwbDeinBPFLmm2APus=;
	b=hTIRFbcvkjP+T/12lWUNWFEvbPO3YVUAqId1vWLce/vAFEFnlKPkje9n1dyKlLjWtba41k
	OB0Ii6BbCfHURmB9G0JlWO0UsgLM92EjpnC4IYbh1NqJLlQvP+YFzA4bQmebxS36aIWCgi
	5KESsIDvr3kmrRb0WUjS+vQz2Bw6acg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-ph7KuqxBMHyQfschxyOR0g-1; Thu, 24 Apr 2025 10:02:03 -0400
X-MC-Unique: ph7KuqxBMHyQfschxyOR0g-1
X-Mimecast-MFC-AGG-ID: ph7KuqxBMHyQfschxyOR0g_1745503322
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aea90b4so356232f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503322; x=1746108122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4ugVGJrIOXPLKTfodxB2+3jdBwbDeinBPFLmm2APus=;
        b=SErq+wTT/jqAj5C28k2thVXr8Kppg3H67P6ww9dv/ximynpzToaGb+2O/MLPY418gT
         bHQj/peYYxvu2vIbbAWXY0GDmfYbQwpQ9aNbbwn6YqayX9LtqSwX+DmCxsMxqbY3oAK5
         FuvFEjeHG3M+vyhcCbmRbRmypUE0EcOgV7vMnzcZOMOmYTPQp9blakFoeWT3EXSrmsl+
         gBZI+B1HqzK7SiSjN2d6lWJJqmGZhQ0lfXwShT8TzlN3/rlU5MI89PWY0pkyDrArV8Ph
         7LdjRdZ+TrJogN0SEj5urFRaRNTdm1kTK8ZDejXw4iZENPVb9shMB7QHw1wT+XBVAUNZ
         cxsA==
X-Forwarded-Encrypted: i=1; AJvYcCU0yCJ2Bs6l83ZAXLkIN5HdosRhIieaqbKvyg6KIbLhwSe7EbA/C66K+TvAyXIlM0ULz2sdNlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIF1qbujW3bF2dEot4Y5+ANMCMO9pylRPIaoBf1Ylle3GYof32
	uuK8ICFx0nkFMJnVcvEI6yLQeMME4A7p3WzNAY+p9HMoca0ooYcu3Ga5dRJMmkIuzGzE1D+UxSJ
	QoxJYik+fnodXwun4fTQC4X93p5Kp5jBx3Hr4AEz6adfd2nlFrqmEXg==
X-Gm-Gg: ASbGncuD2s36n7E+Q7vQR4TAfXYVaICBYbmngJSP5denMX5brsykGwLF5mXY/ELYfVA
	Z9ET2da/nI3B0om5EWcLmnIf1U03jwCGT+FoUR7pBp29xIF+q4ImF+TDIN1XOM/S8B2mY5EdcBb
	nyMhFxEXrBeSIQx6KPD+XBfliB5k6WS3yONvOdTFZZRrhRaBiQ6uM1gXGlB02JuLbXTuEHyvJy1
	zb2yok82wWIYmaUKFj5pwRAAAPSRzJsLnZOGeYTYf9oNmM9kV+FpUsLQ2lkHZP98EyQxexCpaoY
	UPZpUXiZE//Y7gzN1lyvQUE5Mj2O53dxjY0G+kz0oB2K
X-Received: by 2002:a5d:6da2:0:b0:39e:cbe3:881 with SMTP id ffacd0b85a97d-3a06cf500ebmr2146831f8f.12.1745503322220;
        Thu, 24 Apr 2025 07:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi2MyDjeYnsm282w03PIg0ezMg4+0Nef0fUuxO4htYKbflocCbb2gPImMfldtpvJugOyJ/5g==
X-Received: by 2002:a5d:6da2:0:b0:39e:cbe3:881 with SMTP id ffacd0b85a97d-3a06cf500ebmr2146763f8f.12.1745503321508;
        Thu, 24 Apr 2025 07:02:01 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54c4c5sm2170778f8f.88.2025.04.24.07.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:02:01 -0700 (PDT)
Message-ID: <96bd9677-c257-480b-be3c-7c4b9b79b238@redhat.com>
Date: Thu, 24 Apr 2025 16:02:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests: can: Import tst-filter from can-tests
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <a4468403cc51ea6c0e8495d7d095befb37aa5aaf.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.25 09:42, Vincent Mailhol wrote:
> On Tue. 22 Apr. 2025 at 21:08, Felix Maurer <fmaurer@redhat.com> wrote:
[...]
>> +ALL_TESTS="
>> +       test_raw_filter
>> +"
>> +
>> +net_dir=$(dirname $0)/..
>> +source $net_dir/lib.sh
>> +
>> +VCANIF="vcan0"
> 
> Here, you are making the VCANIF variable configuration, but then, in
> your test_raw_filter.c I see:
> 
>   #define VCANIF "vcan0"
> 
> This means that in order to modify the interface, one would have to
> both modify the .sh script and the .c source. Wouldn't it be possible
> to centralize this? For example by reading the environment variable in
> the C file?
> 
> Or maybe there is a smarter way to pass values in the kernel selftests
> framework which I am not aware of?

Good point, I'll try to come up with something to avoid the duplication
(either from the selftest framework or just for the CAN tests). I'd
prefer an argument to the program though, as I find this the more usual
way to pass info if one ever wants to run the test directly.

>> +setup()
>> +{
>> +       ip link add name $VCANIF type vcan || exit $ksft_skip
>> +       ip link set dev $VCANIF up
>> +       pwd
>> +}
>> +
>> +cleanup()
>> +{
>> +       ip link delete $VCANIF
>> +}
> 
> I guess that this setup() and this cleanup() is something that you
> will also need in the other can tests. Would it make sense to declare
> these in a common.sh file and just do a
> 
>   source common.sh
> 
> here?

I usually try to avoid making changes in anticipation of the future. I'm
not sure if all the tests need a similar environment and would prefer to
split this when we encounter that they do. Are you okay with that?

Thanks,
   Felix


