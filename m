Return-Path: <netdev+bounces-212435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DFB20495
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206EC1717A6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8321ADB9;
	Mon, 11 Aug 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fFgFNwCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87A2264A3
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906034; cv=none; b=MwewcydxORcr9mmZX5NSPDZWCel4xW38yO3CsC2AS5HYhE7ZPGgzxOODmW4IHN9tRO0kqX6A1tE3UZlEEKgDyZYJ0HnW+3GhNIA+TwvWf7+2DB6oTRS5ndec+FQYc/Bfmn5Q/Pqe/WFlSINx9W033x1EpuocTzAbg1ojcWcGjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906034; c=relaxed/simple;
	bh=Id6hAsBzqvvvJuLnhifWVuPprxw97gs5pfxiXKcIU18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ifln+QM42rzIo9rfPmMU9y/jGHgfCwnUgOlW5dJWHYX8IHFlp8u7yVjAN18aSKkaMe3cxGh394Z48/iVv0WGCw1ZzEjKG+DzKg3LCJoUV+FxvR9ci/MsaE3ptEXxy8xLB+ZtoEO9dEWfMnNA8jfYMItw4NQQfMs7DHLTmt9cq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fFgFNwCA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bdc73f363so3557561b3a.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1754906032; x=1755510832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWk6+fuhPROgdnZouTKBsa+OgjZO72VHnDBSFJOn8Gk=;
        b=fFgFNwCAUInchQmzAB97HWuHq8cqzKMMcOP1FLwZCqCdrhV3I/vddcnWELCT1e2Lwu
         Iioh4J+Ebc1X5y5Oa5rBpzWbuYYbhNZ8BhAjQZcCa3kQopMMfMcL7BxnkJGTH9t0VxrL
         AHiqmuKy3KiR8gL4HPchGvdEfjCaF1nJm8gjYRZlxCpCe7m87ICf/K7e3wzoL0Yag//T
         5e5iHn42mk8uI9RYUK0YpKEaVlYwLih63DgWJcYO84xeSat2ZVcXxhJtOqG0jGcoI7zq
         gKYWQaP/csSRRShVsPv7BkULppkMBRrdH/v1pLmE6RRts7SwKV04dWTDuqHlsoTfactl
         ggDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906032; x=1755510832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWk6+fuhPROgdnZouTKBsa+OgjZO72VHnDBSFJOn8Gk=;
        b=VJZVSnbXpTkOqiEh8BqR/HzW/LJN6fQMbSSQUqwaNobdd84ZfNEFkc6rAgBbHXDgiI
         NkchvkpccZIoX057rua5U2Tz0SU7z5tdO8M+jNpThjJbrwX7m82wMw158yCVW/IfJ1n5
         f3fil3084Fxm9p03EHc7AK3FgaP12ZbSNjkH89NV0B11D+M5cD0yH9FwE9/9IUN7fo7d
         AVGNCna8Hw5jKyquyo0dRL+w8VVZ0pGUN9M//rvJIQzPqts2PgK8X9hRfNoatjGnCL4i
         V1nWaRyh/8U5Iy3m38UtvyPoBwqDsWfhBQ35MyEWSWHvltEMC0zR9t9R0ML/+K9s5pC6
         RkyA==
X-Forwarded-Encrypted: i=1; AJvYcCXjYxPh7+DyioyjcXsJX37P6i0ZhuvNODn6anDQHBYp+zWdBl7FaSfvy/l8YOQ2DEMAky/5mBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/eFf6MXOBvj+ZDTnhBai1ucyeXVIvDQ5uDnKF27J19SWKGOd
	W+Y2Ns0wSZn0bjutrTXr//cR2erfXgyDt9PK+QFsDATyTFGY0uwMyxvgF62C/bK/Pw==
X-Gm-Gg: ASbGnctwGyPs5OxO4JSCfekpEM51+K6YjgBoDKdw69GUzKP/zU7ghjznVIeKpk0U/4o
	XrltAWSOxO84vAQH9JYV+7WaQmXO4YjJ1+9vbgKuh4U5x8jD3RzxXgghai+yiQfxhWgzhGlkibx
	krjC6b7rMUXQFlnY/pmfPj7vDJlaUHsLoPM5sF4A07gVVH6P4BOH3zsFGeProMpIVM3KqFwnHTB
	qsju7pKNj5T0tgycxTKPiFk2Mj0uhUIZ+kXbZGglh+noP2cBWo11oXux9GfVrXce1NN9s1fIImX
	RgrVKNxrTVx6bfP9Bql77ub4LTSVPSNRJzBREYGfrfnKxPAnngIhx0TFq18VXPWEJffL0eIKw6L
	rvKR+c1AlhaWuNDN+3lFyAeyRcMB3gcXW799nZQK1MhfGk0698+lh8vbmJXT6nC+fhzul
X-Google-Smtp-Source: AGHT+IFo7vi6HrItK7v1CufJvGlHeDnQfSmmkZbZztaZyc+WP0vxOvzwHR3Pd05E0yhcxcqlyvO5/A==
X-Received: by 2002:a05:6a20:5493:b0:240:17d2:bff9 with SMTP id adf61e73a8af0-24055044d6amr18674326637.18.1754906032394;
        Mon, 11 Aug 2025 02:53:52 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea? ([2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd1d8csm26307631b3a.101.2025.08.11.02.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:53:51 -0700 (PDT)
Message-ID: <81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
Date: Mon, 11 Aug 2025 06:53:47 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging unused
 classes
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>,
 Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
 Ivan Vecera <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
 <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
 <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 04:49, Davide Caratti wrote:
> On Fri, Aug 08, 2025 at 03:15:13PM -0300, Victor Nogueira wrote:
>> On 8/7/25 12:48, Davide Caratti wrote:
> 
> [...]
>   
>>> Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")
>>> Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
>>> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
>>> Reported-by: Li Shuang <shuali@redhat.com>
>>> Closes: https://issues.redhat.com/browse/RHEL-108026
>>> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>>
>> Can you submit a tdc test case for this bug?
> 
> hello Victor,
> 
> Thanks for looking at this!
> 
> At a first look: TDC is not the correct tool here, because it doesn't
> allow changing the qdisc tree while the scapy plugin emits traffic.

I see.

> Maybe it's better to extend sch_ets.sh from net/forwarding instead?
> If so, I can follow-up on net-next with a patch that adds a new
> test-case that includes the 3-lines in [1] - while this patch can go
> as-is in 'net' (and eventually in stable). In alternative, I can
> investigate on TDC adding "sch_plug" to the qdisc tree in a way
> that DWRR never deplete, and the crash would then happen with "verifyCmd".
> 
> WDYT?

That works for me as well.

cheers,
Victor

