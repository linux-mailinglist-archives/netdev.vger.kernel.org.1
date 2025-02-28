Return-Path: <netdev+bounces-170792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F0A49EB6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8AC3BA83F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D9D26A0DB;
	Fri, 28 Feb 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf0O7Pd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2041EF37E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759887; cv=none; b=dZp3IYyha7JO0qH9ybwCLSrydNzBJ3nF0rVwVyqK6Tz9/rcaB+fhaHT1gq60WnEf74Dy8/kg/v6K41G9rI4LItW/P7RFHNJSq2Gbo0budNJ/HNJA4yx2bbaqPD5PAS0UWIKeZx2wWgahS4vYJb+mDrcGmesYF8Yw0onI5t1w/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759887; c=relaxed/simple;
	bh=sgciAErqb7O5GqGaXsr5wauLPT3mpfZNNm7P3OWRyK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPJuw75rxDpK/xC85PEfHYABCQTF99TdZIWEVWvfw5rqaXPANFllzvrKp3cijH/0bCQHh2a2XGQhN5Vs22RVoCs3uodPlZP0uVyHPqyDelpXMsOZxzpi0Brx35gPJlC6XcNINy9pUu+6prSYP53Ly4NeSxYXhY9Bu8KYOrTOQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf0O7Pd+; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-855a5aa9360so161984939f.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759885; x=1741364685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSlYymPvFV7Y7PB6cqD/l3MDwbw8Vi6rv7NX7ylfqOo=;
        b=gf0O7Pd+NFiVgiDMdWDnl+m0YCsRKzgTJj+0jGhONiA7/STK8RMz1r+8F44K+y4tTL
         OfT3Yuzp9PweFfNgWkYR3XuCgxoDtwLOHtIeuzMkpsBjDJOYmQ9lFVWYICwGTf6LPHR2
         1YIsvMIif0b/aIKo+2wgf7Up8O1/NePy3QLJNYl8l0/A1ZTm1+P2ORxAxFuW+Qw+7CpJ
         eIwYijVY4lom/VY0bIz3J2ejKzZJGgiw3Df0DB4ypP2hB81CyDXbRCdJc8WAZrRtV1Bw
         42ZX32F7KAmEM4ZEFIKQP/0JM4WNtx+SS+8hH0W9ABsqSIivl48nv5+81HTeKdf5LPCo
         T3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759885; x=1741364685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSlYymPvFV7Y7PB6cqD/l3MDwbw8Vi6rv7NX7ylfqOo=;
        b=e4YuNbT+QgIp5t9VFF3KTP8QZLSEK3YSe+odA1zm1MwFwCE9Dpxh5YWsHHwiIEkvbQ
         QccWM1Mjo6i1eYZI1LD5oCAiFA78hM2Kr1hTJMUO+3rUqDZJPo2OBaangw44U+o9ShSV
         ek3ideSGzCCF8nV28ahYZbNIsIHrjIda914m39Q8m25cYhJMC5cC0IMKbB8UjUtu6Qfp
         cxPYxofvKfxwm2nXjuuPbpDSMPZER1rtxm7q67/6gR1j3KybQQW53yk0FYpniJG0yHQY
         Pr84AYy8j+z8ThvurZQN2obfSrNJn04VrdGaBulMJCFiP8AvNynZn8wM/Yr+d2K1BIZk
         nLWw==
X-Gm-Message-State: AOJu0Yxm+ZWpzeInmcessVVkcM6TrWwkK+lGzWfZLEVmJ5OOvGsAMRWL
	zz/O6S6BqANQip+lgG6xVs6UP9JhjcIy+EIJpNYuunpc/VO1gyNq
X-Gm-Gg: ASbGncsGYtQ0wMg1U+jClNVmQnEV7DJV6DKNFmfFRyblcdskABQHzlZEh+ABLnkF0YR
	hAuz+yzgOfcgX0DxXVe4Sp6tsPRNkqvbz1rzRuT8b9BexhqTa3BtAi1nnaAajhK/QW4ZiET8ViM
	4pRf7ZjckfduPwY/7YU24/2GQJeOxasuvrl/koPJvjd7pOy0IxPjaAdWCQg4R607zhJVxUox7CF
	tefSYvp/6vRt2Cne7tSC6pJAUcTj0/s8C/t+/hrVv9zc+u4WR2V+IqP4z54SCyLpw8fam/IAUV4
	jpesVCO4ojCIcB4AUu6976/FQo5xMckGu2emUH77D0ubBCdXEGQjL40t6a2kne2uaJ3R0pobYYE
	n501jTRNaBA==
X-Google-Smtp-Source: AGHT+IFQ7gz8cmrtGOCVjofmMbJcnCEQrV8rUkznzz9uadd6F9/MCtKrwSqBIb05798HUnc7oiNHUw==
X-Received: by 2002:a05:6602:2b91:b0:855:cca0:ed1e with SMTP id ca18e2360f4ac-85881fc4be3mr371545339f.11.1740759884932;
        Fri, 28 Feb 2025 08:24:44 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:712f:546:eb4f:9a17? ([2601:282:1e02:1040:712f:546:eb4f:9a17])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4f061f790bcsm962815173.126.2025.02.28.08.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:24:44 -0800 (PST)
Message-ID: <21c724bd-181a-4364-9a21-b2413862fa56@gmail.com>
Date: Fri, 28 Feb 2025 09:24:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 0/5] iprule: Add mask support for L4
 ports and DSCP
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, petrm@nvidia.com
References: <20250225090917.499376-1-idosch@nvidia.com>
 <Z78ww29QI4X5bI+o@debian>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <Z78ww29QI4X5bI+o@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 8:18 AM, Guillaume Nault wrote:
> On Tue, Feb 25, 2025 at 11:09:12AM +0200, Ido Schimmel wrote:
>> Add mask support for L4 ports and DSCP in ip-rule following kernel
>> commit a60a27c7849f ("Merge branch 'net-fib_rules-add-port-mask-support'")
>> and commit 27422c373897 ("Merge branch 'net-fib_rules-add-dscp-mask-support'").
> 
> Reviewed-by: Guillaume Nault <gnault@redhat.com>
> 


applied 2-5 to iproute2-next.

Guillaume: I missed adding your reviewed-by; thank for you reviewing the
set.

