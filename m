Return-Path: <netdev+bounces-206251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7543B0245C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAC81C45CB7
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4B92EF9CC;
	Fri, 11 Jul 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LgV75rzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F12AEF1
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261233; cv=none; b=Apmd2d9UqsGTnxGGycmSWeIIz9+Xrs2jKKzUiGvpEBstDK1Vy8RTM2HKej8SCuq64nLjGu19q9rtMNsFaXrznU3QVDNzVxcgP3w1+euS3gERb1OYW14GizxcKrQT+gSK67DeW2/sOAsIYkjpgDD0vXiXbkUfjFOsMLKriIEOKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261233; c=relaxed/simple;
	bh=8BcgoOo7d/63OSh4rLBJxxOjFAkETtCGtPh9tO6j+qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bBWXeAGZutxZosoxVkc3sBkfDAdy3qRKr9yYa3G1o5SY1d3oWXWZRNtUDy7lMcSYM2uLqY/HKOUPeetMgB6Qezf0ZvtgX0AzSgRDqFOTZ4/SIbDA/kTv5y/B0twINaEHPEUxCLWur9tCTpYxmeW2qbVV7GorgikqdxY6JVzrZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LgV75rzR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1561305b3a.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1752261231; x=1752866031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pw8tMXj6rdfFqpDgsVOf13IKaNoTZhX9xFiQLvS94yg=;
        b=LgV75rzRHB2Fdyj5hHJ7d9m/lI+WGAhFn02MxEeEdIKicncdN0ARzLJsqZOMNnPi2w
         sYxPHSQ1MXfX0a7gjNd8AozqriuISyCTgrDxB4/ghRZRN2N8MOD5JVnSBEOlERygKLVm
         +7gFkDp4D5EK8L08fKTK5CWoQRn73vVgjiqJKQ53Z4ZpmEY3xlA1/23QoAk/O26GcqNB
         asqDMB9IKQ/KhTLsI5N/PCWFqFlRpYzRqc6821bJiXlcIvbzCG/OLUxDS1XJRdtw6yaf
         jgA5psXfEw6AEmn4Iww4ynyiIlC3/tVWWbAcO+UwWNikB7UPegYHnmiopGniR8xN23wG
         SPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261231; x=1752866031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw8tMXj6rdfFqpDgsVOf13IKaNoTZhX9xFiQLvS94yg=;
        b=NjCHOQe9TTa24VNDlYUTX3a5vrE27YXm+DY+8pA8D0F8TtnaiOMtnS2xDbunCFyydd
         MUlcHU3cRKm/ZCobdRIK2pS34gP42NVC3sjCE2FS7V5+Xp/C9MJqz7AonDInHxeaf89W
         mNPNHdKU2n4D3jBTParkgqaj5J3GOcq2nMBwT6dhsSDriKHT/uOG72ktV7VJpzmmnVx3
         Xzx7qbNSY+BkuQ78b+ePAu6262vmV2rlmfIAuk4K/5EzDhy9S+GZDaxbyn82sMue+cPo
         CvIsW4434+CqBhY4x7a9aJvHKyGs+JPUxYzHP37VzWK+JKI7Yl2+tLFBRLUABhB65X3w
         DNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwnDpp4Ho/qVSUcw2q07ax/Ow5nuNj9xYdHXq9TVw3Y65FfJraMmaJO4eGytggucFGu+SrgqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5fvmExpW/QNP5bsR9ZrI7ilq1his1gSvgTuSQU4hfoXyX9Eg
	+fJ+/DNnbz4A8wKZ9JKrv09BazbATZgmCBd/Z2QFzJHOQWaj/p8u/IwwFDx1X1Xxug==
X-Gm-Gg: ASbGncv5N1PvYxWR98He+k9HJKcNXfT4Tw168IBZLKe6WCZHi0v0yZuV1l8xUjeqsln
	l26lJ3EhSMEllVAKJllEX42haHiNVyV1crfzZLd28VgcjXqCHUjnIgjUYThVofNQKeNWii0xBC5
	IjZ3CFjliyRoxglIYf6SWA527oiVcI3RAenA2icvVmSjQRVJ5i/MPjQfgflFLITkU+3tqhsW0jx
	HaTRjX+/qILQf9wH29bElZEB4Zmi1SxC3YsoDHj/3ZmU2eGsYl8j3BFvZr/vsGoed3vTbXv/3MA
	408v5CMrGZ43480k5GJWmtgj0B/WYip8bwNAk8/c0eLQKp99zmiaVT6QHkcEOSJz68R9UBmEffG
	sTbO/gLk8iqvmRubee67gtLP1bmIZiwIRYm23Rm+9GtkRs4I6Yjdym27P3uXl5c0=
X-Google-Smtp-Source: AGHT+IEzJq7kKuHcKxI7SDNUkv1XPsZWGFsK3Uidxo93DA1wc2S/2yvIBurC0Sbg+3Bd5W2zZyl8hw==
X-Received: by 2002:aa7:8886:0:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-74ee3237980mr5280760b3a.22.1752261231255;
        Fri, 11 Jul 2025 12:13:51 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c2:381b:47:222f:5788:dacb? ([2804:7f1:e2c2:381b:47:222f:5788:dacb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f9762esm6198861b3a.148.2025.07.11.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:13:50 -0700 (PDT)
Message-ID: <01a580b4-0c8d-4d22-a3e4-264335d7a947@mojatatu.com>
Date: Fri, 11 Jul 2025 16:13:42 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 net-next 5/6] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
 <20250711143208.66722-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250711143208.66722-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 11:32, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> and add following self-test cases for DualPI2:
> 
>    Test a4c7: Create DualPI2 with default setting

This test case is failing now:

Test a4c7: Create DualPI2 with default setting
exit: 2
exit: 0
Error: sch_dualpi2: Dualpi2 options are required.

cheers,
Victor

