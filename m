Return-Path: <netdev+bounces-176980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A4A6D24A
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BB53B5312
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590C1DB13E;
	Sun, 23 Mar 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eUtJHaq+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA51D89F8
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742770126; cv=none; b=j2iYecVZIAZP4ZtG59CCr3X8AhHtOiP7sKTBLVa3n8vxNefh/goj9JNwz/pASH479N4uyDQLwJAUJq2vbrly1ISQNG17sK9VZZrtE4XGdtAJgqf0hAJwRAu+/czme9lKALseWNbOAEluEK5zTDGmzbUsmJFoYSU9mBahucE2H30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742770126; c=relaxed/simple;
	bh=hVUhEIQYfU4c1VpfbwttCZioxyZgUoso0NSCUS7hUH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhuZMvoqsVN7n2CjRBkE6LeynWBS51c0xC1oqqZZfseb3tGH4JZE+QO5xPXYp4VOuGWA6AL/11pXgdMLN7V+6RlTZWuGqZ5H50qTNxJ0rOJqYRg4FCzz32ziH9ZUjHPV7h7z8caehyO2RsWvjO27nB60taOkrsDX/qnKSbPdqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eUtJHaq+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227b650504fso7409425ad.0
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 15:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1742770123; x=1743374923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GLP4GE38xNQpMOoA9Ak2oim0vMGIDQux+qqnVDv2oo=;
        b=eUtJHaq+uPb7omFB5gk41s/lV7zYQ1aWt0ils0WZsqegkxfVBVkPCoJAErrvhrgCO+
         9z+98WRea8ds0ib6bDACdZkiFiXxPKgODrJwr8kP2dDGXjkw3lIkeazzn8RUL8YMyPEm
         KWH7ze2yfB3/l6azH7cANG0N0epGtvLj3DXZOCcVePE/OXSAUbRQoVaAAcArbkDH+8xd
         OG56xaLvXtVqaKpw+MJzFLEXMOfo/dnM9YE2krp3Uw6H862o9h1d6uZ6HzaIQmseUHPd
         sVvPFNGD8H0v4pJibRClH3yOilVcUYJqo0k/1lDrtbFOnp6yqme/p30rTo5FRo4UUbll
         Kg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742770123; x=1743374923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GLP4GE38xNQpMOoA9Ak2oim0vMGIDQux+qqnVDv2oo=;
        b=HfzfMkJAWn9szBt+aqe9NSHBwR94/qF2G8UBeODkXGT5TJFWKiT8HGHJ4lNP5g20+e
         CbB5AFeJ7+Yezwiw8rg0YSx4baw+AR058QsIsyoJS59gShzOqWaLgKMS5Ou5LeBo7imX
         4mfmgVmDws1gqZ/Zxe7CEpoEqCvmUmFpE/4bffvhIhYsCdpHPRTyB40FShgQqTg90Rpm
         Von71W9Hmk4sHhlDgwyKiheVidP9RoObkD7i0PyE0br1NKWDYPXex0vd9cGZf+9S6sBI
         GHxg+2ksynsyIBbn4dn4UFcB9awas6WsvrFqs+MBl2Yw1+kZRalZL5e+y6TXftKliSP3
         SmtA==
X-Forwarded-Encrypted: i=1; AJvYcCXGcCDLxHxCtuYSOA7nbU3GLY9MuYbZi9d6SQPuFnW0K2igvsV3r63SeNeN2R+H5TD6fNB2xDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqTWTRWqaWXv4JKojBkRoWmO1xwCPHu6jEGjJtcEJUximsQHbB
	0wrebJAQKobB63GVnvQFHltNAA0VU0Km47UmhM+6SaoBll36ZXEeezuwjB5k1g5nq28cUo8BCjo
	=
X-Gm-Gg: ASbGncv8VCOKuO9W9MMg0nUQoBhJyS09TYVzzHNDgrzr8y+PLhXh9lL9QheKK4nQR00
	8VrlgYqd3l11gaR4kk+CF4LCfT53wLGBl/ucnEfsrP+y/uwXlFrzlncJLvGsVvx+4nosd1iVy4q
	8rlIE/qC+clvFfVP37RFuPVJxT/CopqA5aT0c5R0b3FQQQZ+xAM/ivt6IW94iLUbhFHzynAijic
	LctHHAWwhKWmPySVGxKXdErO5v2m2L7gi245u+/Ug+9YCQuhG6HnYwh2wZvDXWp4KsGaVn1ZXw4
	n+K+GOaxPNkkT+3gL+LHf2k3P+U7tob7EoW9iA0iEAnV7fwy6J4fti4L6vHEUwtnFayoneZ3T31
	Fu+GG/vm1/2CbrGApgZ9LW6CC2w==
X-Google-Smtp-Source: AGHT+IGHW1r3CsVPu1BAb6HJMAJ1GUZe49cnw3+bfq0ZyR0VXDvNJ7fBC+cxpwMqjYYyU3F/8XiFsw==
X-Received: by 2002:a17:903:46c3:b0:21b:d2b6:ca7f with SMTP id d9443c01a7336-22780e07919mr202630385ad.32.1742770123525;
        Sun, 23 Mar 2025 15:48:43 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:3274:95db:1cd8:e67d:6773? ([2804:7f1:e2c3:3274:95db:1cd8:e67d:6773])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d573sm6552682b3a.100.2025.03.23.15.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 15:48:42 -0700 (PDT)
Message-ID: <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com>
Date: Sun, 23 Mar 2025 19:48:39 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 08/12] selftests/tc-testing: Add a test case for CODEL
 with HTB parent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, edumazet@google.com,
 gerrard.tai@starlabs.sg, Pedro Tammela <pctammela@mojatatu.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-8-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250320232539.486091-8-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 20:25, Cong Wang wrote:
> Add a test case for CODEL with HTB parent to verify packet drop
> behavior when the queue becomes empty. This helps ensure proper
> notification mechanisms between qdiscs.
> 
> Note this is best-effort, it is hard to play with those parameters
> perfectly to always trigger ->qlen_notify().
> 
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Cong, can you double check this test?
I ran all of your other tests and they all succeeded, however
this one specifically is always failing:

Test a4bd: Test CODEL with HTB parent - force packet drop with empty queue

All test results:

1..1
not ok 1 a4bd - Test CODEL with HTB parent - force packet drop with 
empty queue
         Could not match regex pattern. Verify command output:
qdisc codel 10: parent 1:10 limit 1p target 9us interval 999us
  Sent 2884 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
  backlog 0b 0p requeues 0
   count 0 lastcount 0 ldelay 11.5s drop_next 0us
   maxpacket 1442 ecn_mark 0 drop_overlimit 0

cheers,
Victor

