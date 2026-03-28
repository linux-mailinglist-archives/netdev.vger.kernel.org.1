Return-Path: <netdev+bounces-272729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EXMRGb5yx2mmXgUAu9opvQ
	(envelope-from <netdev+bounces-272729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:18:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C353134D7DA
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F9CC3042981
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA123EAAB;
	Sat, 28 Mar 2026 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hsAZ4yEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16118A6A7
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774678714; cv=none; b=a9A2bDEGJ3New58qvTLIyDETcVjXLdY/v5/woOnJjlN4G7uMcN2zjVvY1GLpfabGkrWQoPTeZxzWJyA4tvCjVnlu7XCCmIecpiy0KPpL/atnK1zziUkyRU+cnWTwxZ7xvQA7NriKPB6vi7zWD+YPgUpvYlwh+a++oEc7bS6SBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774678714; c=relaxed/simple;
	bh=fpWGD4WzwufnasbHIbkLS6WpSJ/8pnZ3W3U3rLEMYmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f40ZGqGznGvqnDEAdOJmP1SNtXVRPiyBHnjIDbknMS6AQgiWPkE23WqHEU0cFBgQ25tFnYxchbOVjZL8wavxhKKE3H2ghh2YL44wQzu3a+d+BkcrMX6GTonFz9f6WuzwbqGshdHKA2SwR5mMX/1KDXdzN1TaQXrGlImkz/OXks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hsAZ4yEO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2634998f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774678711; x=1775283511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+7pAhqIKsXBo8wnUBwzZQUNvGJtnEKbwOvep909ul0=;
        b=hsAZ4yEO/j/MSMcb05rMghFRtYHDRKc0/5/UXAFi2DdXtjr6v8KX08kKknSCc+pZnZ
         eM9O0rPhP1ywpYORV9yEXPxndWuzUgiyKLPiuUuHUFYBy3EjG8mWPt2lpsoBhLbpV9nz
         muIMxVJ+8yEyj7ahSXYflP7E9L241lfUT7gNQHlTaBtQGh7UDXwmreq7Adka0NNPlPuV
         ZDHgJlA1LETy7zkd8n3AX/9rgXHD9hXqnYWljYuB7MsWNLBt5olAaF8oyuWxmYhXqe9I
         7m+cnI2U5TK17u+TfnyMwHW0oBTIytbNi9Z17tclyJhTNwRU+zcFz6BXqYEoUrF0Cf/9
         opXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774678711; x=1775283511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+7pAhqIKsXBo8wnUBwzZQUNvGJtnEKbwOvep909ul0=;
        b=XOLX7imamHMwtIJNwzgWsdbXy9P14JPlm8+KUKxlJeDWHRy6S4+0u5rCMyCT2QAyeu
         Hk0n+M5kZFAAvUiv+UhhQ7FT/IMHu9/o/eApTF3l8936NEJGOBU9b1Vp5eYYNMS0u4gg
         jrxKkvmEiu0vEt/Hs+ZXuPAng6pFzpFcZkgaLt79kaxcfEjlwUZHWnsA3Y4aVZdzU5Js
         Fj4XzFlQ7IgSKTpXNPCCMPCB+ZxSiyOCFErjeNnKi9af5P0PJia2n4ftCGzokQmE0Vja
         Y1tXDeOQrc5sPzXCT9poCthXBvaIAxGHXKUO1dSynI5b0Hlu0Uv5wNyCrwS1Tp9gmQ8G
         vKBA==
X-Forwarded-Encrypted: i=1; AJvYcCUQfghg0vP0ClngXDnsryVt5WDoK9LrnI6ckmyRUGKV1ClJV/VK9R/pRn2GJz3penHL9yCMcNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmzEjrSwN+lzpRDMchNsjWzHKtnt4Qq0jqGviXdDKtbFzQB+p
	yA0kc+VyEqzXSgmfcyvPZ4mssTMlq6csOW3ZrDN7lIWv3hwuVjDsGv59F+nN5+D9Uj0=
X-Gm-Gg: ATEYQzzW94hhGgfpa/EabicXvhLaD1p0FXUttSOg+UtawElpFHNUs7uH0n+xnOsasiy
	1FjT7+dPbY1LZKiUdBK9Y6Ugf/tcwFe8GMa8Caq5hSQatr49151eZRzi149YoAa1rQdpU7pTroT
	FCbCWhH85oss3pc6w5pgIyver7PIprsD39wEzlNuRAB4/QYVIEO7x+wut1VG4KW5tkQ7Tf8Uu8g
	9IzcauLf2XSWlnlcWP+4Nu/Ift6dFfI1xWl7bf8I5XGS/bCItEDaJ7XTFVlA0NV+Ghx80UR5Fud
	fjXcwJtWsZ2jhVSOnvBjI2wuXBuD462njEq8gKrAC71ZCONyF6xhejZJIKwlSmdvgdqr9l29bV+
	C4Updpladb741QX0j55FS38qYDsMJsHrymwRQhEnR+37e+5xNH9CceabQld/xBMokTdbLYRd6d4
	ACOTPw9dl8+sbJdYN0sCNz4JFvybAxAr4O/ciSV937RFDoEM//rm8EvA==
X-Received: by 2002:a05:6000:26c1:b0:43b:3a65:8c9d with SMTP id ffacd0b85a97d-43b9e9e90b8mr8793617f8f.19.1774678710530;
        Fri, 27 Mar 2026 23:18:30 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f87esm3003997f8f.22.2026.03.27.23.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:18:30 -0700 (PDT)
Message-ID: <85e823e3-394f-4bff-a8ab-90bbd2e1ab0d@blackwall.org>
Date: Sat, 28 Mar 2026 08:18:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>,
 netdev@vger.kernel.org, bridge@lists.linux.dev, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
 <20260327171917.7575d715@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327171917.7575d715@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FREEMAIL_CC(0.00)[kernel.org,asu.edu,vger.kernel.org,lists.linux.dev,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C353134D7DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/03/2026 02:19, Jakub Kicinski wrote:
> On Fri, 27 Mar 2026 13:46:39 +0200 Nikolay Aleksandrov wrote:
>> On 27/03/2026 13:34, Simon Horman wrote:
>>> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
>>>> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
>>>> interval value from netlink without validation. When interval is 0,
>>>> usecs_to_jiffies(0) yields 0, causing the delayed work
>>>> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
>>>> itself with zero delay. This creates a tight loop on system_percpu_wq
>>>> that allocates and transmits MRP test frames at maximum rate, exhausting
>>>> all system memory and causing a kernel panic via OOM deadlock.
>>>
>>> I would suspect the primary outcome of this problem is high CPU consumption
>>> rather than memory exhaustion. Is there a reason to expect that
>>> the transmitted fames can't be consumed as fast as they are created?
>>
>> +1
>> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
>> conditions. This is a configuration error and OOM doesn't lead to panic unless
>> instructed to. I don't think this is worth changing at all.
> 
> Then again if there's no practical use for 0 we should consider
> the risk of getting this sort of submission over and over again?
> Dunno..

Sure, I'm fine either way. To that end the patch looks good, just need the
fixes tag as mentioned earlier.

