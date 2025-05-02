Return-Path: <netdev+bounces-187440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B54BAA72D4
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8076C169D25
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD924676A;
	Fri,  2 May 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcEzcoIr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13642049
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191156; cv=none; b=mUdOp58q17MTdKYCWqvWrwnbNc64a29VUQlExr+0lb/PhIFRS8hL1FLDOTAOTYiNfYlFuTIe8hpXENQqlKDakVjXAPxxw2dYNEELe4KXpji4u8VMhjrFisC2pZM7/MfjYbwaVU8tntwzKLDg5XXowAfx6rUBkQtmrGdcqyH+tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191156; c=relaxed/simple;
	bh=ThxPZZefkO6ccE1r7dEv+qr8reoUOV9RWERJ1bG/7MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZJNgNKQy8p/S0DtSq4yGC7Vr+IyQcztOXxqyMgGs0AkzX87irEU8AC6znoRJvDs+zyUaoL+BEgP9UePO1nSi4C506yXy2aSLxhpzqJ4vqBtr7dnLUEnDFUZO+CKR4cVQg5FzCSXz8x46PaCdOzI9pnD+KEDugp//f1UMXqMvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcEzcoIr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746191154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3gW6mlhffHhh1n9pvflSPn8OiRLEan3lJqSmN71dWk=;
	b=UcEzcoIr0bUInPV9flQoVDdXSXK9/oF4epEZUGA3q2l7hINnzcClFdkkeV2kPWX4A/kmKg
	Zw/VnrSx1RtxB08u77yWUbkKsyrZLSvDSeier9bYuBzK9T6b9+QzotUKQpBYagsiWWrUgx
	MmYu7YYDp1q3RqT0yVyuMaayEh5hMtI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-6kvCaP17MKyDC1nGDceWew-1; Fri, 02 May 2025 09:05:52 -0400
X-MC-Unique: 6kvCaP17MKyDC1nGDceWew-1
X-Mimecast-MFC-AGG-ID: 6kvCaP17MKyDC1nGDceWew_1746191152
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a07a7b4298so929405f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 06:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746191151; x=1746795951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3gW6mlhffHhh1n9pvflSPn8OiRLEan3lJqSmN71dWk=;
        b=Dy6x+xW78hR3ICCqAZXeWSbrkt/42wYDLSVeuwWCfB4XyCHtIBSmqaCNM9rEUGahKq
         bCzsN0YFS9zzNoAyer4o42WQ3+QNUiGDsT2MymeD26W+szXI+y8mRtWQGMQO2XaHMs3n
         zx7b0tSc33qQNWkIxf87Sg4UrkwzMSQHkU6aEvtRVNcsp74gfLGvAhw0byqSGa7f2zZM
         RypcPgYVZyzs8Ldw10ie/h0xnXEe4mZsOYyC7pc8/C3bL2/Km9CKVpZqnSe1bZSxz0Qm
         A/8b2ce+jxBOISt6ZtjfPaTAjt7TJjfM3sU/u471NcpBldMGDeGUkI3xJu3ASYnZyr8H
         uxgQ==
X-Gm-Message-State: AOJu0YztxElnbApHV6DkQGti2dcCNJ2CVivLYQ5OquryqZe48PZdM9WN
	go7iQtutCQhTCUpIPrgVhaPgu+Gw9GLIVDqRL9tZurAM+2x4j4KC9BZKnrusA5HR7NGHjRmIoVE
	sgRc8PPFbzZIjJC76xtreujC2GJCMHdOqny0fie6+JKd0tZPp6+d8Zw==
X-Gm-Gg: ASbGncvKS238RwecXSXI0m2Win4IwNRuFvXm7GJAQE2AvDTU1Vl912SN1PcJb5teHRQ
	82Y+moEcarHPCmU6wswt4aTiny8rCIOABQOZLCO0GODAXAiqONTHmqveOexpHYEXRhH/Q/2SJiw
	lwOX1u5BJbTkunAulpLXUdyhJG4TRToWotag8f10yTAllCA0rPbLvPi0wLAEnPFVK3fIIwSnJFS
	6nQxhZD6COlvrr6ybPo6xfLfUYAXRiSkV/NVV2FN+Iwj/yQAmQICeJSct+8pblnoiNOGsAjAtVI
	gT1zDKjnQS4tIz9sQJA=
X-Received: by 2002:a5d:67c3:0:b0:3a0:99de:5309 with SMTP id ffacd0b85a97d-3a099de56ebmr1607629f8f.18.1746191151396;
        Fri, 02 May 2025 06:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmlDrq4esQgIs8sXEIsIllslf5/QjKHYKbfmMh14tvL8V/tT0QxJugXZSxfAWZv8Ds0uWHHQ==
X-Received: by 2002:a5d:67c3:0:b0:3a0:99de:5309 with SMTP id ffacd0b85a97d-3a099de56ebmr1607596f8f.18.1746191151014;
        Fri, 02 May 2025 06:05:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3bc0sm2164980f8f.35.2025.05.02.06.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 06:05:50 -0700 (PDT)
Message-ID: <f94dc055-6c3b-4fae-868a-723f9dc63db5@redhat.com>
Date: Fri, 2 May 2025 15:05:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: exit cleanly on SIGTERM /
 timeout
To: Edward Cree <ecree.xilinx@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, willemb@google.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
References: <20250429170804.2649622-1-kuba@kernel.org>
 <2e16fc73-e272-4277-b232-b912c84f5d4b@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2e16fc73-e272-4277-b232-b912c84f5d4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 8:03 PM, Edward Cree wrote:
> On 29/04/2025 18:08, Jakub Kicinski wrote:
>> +class KsftTerminate(KeyboardInterrupt):
>> +    pass
> ...
>> @@ -229,11 +249,12 @@ KSFT_DISRUPTIVE = True
>>              cnt_key = 'xfail'
>>          except BaseException as e:
>>              stop |= isinstance(e, KeyboardInterrupt)
>> +            stop |= isinstance(e, KsftTerminate)
> 
> The first isinstance() will return True for a KsftTerminate as it's a
>  subclass of KeyboardInterrupt, and thus the second line isn't needed.

@Jakub: I'm using the selftests code to refresh my rather rusty python
skills, I think it would be good to address the above and keep the
codebase clean.

Thanks,

Paolo


