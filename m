Return-Path: <netdev+bounces-139571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5459B33AA
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E4A282AE9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96191D95B5;
	Mon, 28 Oct 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0acZjteH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47E13D539
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126168; cv=none; b=i4xNHDKu7xyPYDifhIQ98384xsDwIOfJDq6rFZZZYpZliFMmAjXGqpJ60p8ZQmXUvcrypTVVOu33ydhthf0RPpmjWdXJ1NFnNnPW7tFKZ6rL0tcKS09KELJf+ZZUSXOWJFJcDST9TOuA6fRcDZv3uIEkETqIZSnG7AEMHoJU7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126168; c=relaxed/simple;
	bh=GeBjp+E/pKpvvMbUD14Gi/sPLlc1y8zXVwjanq2enZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDX1ALZqcqReXSwK45/ocMTLmDqNwTWbxU+7sREzTMjQMQgBDH46y71TgQjWScEIMkIV4gzphB0drOZbtY2fIBEw5ZEVo7aZbTsLKR9F5LbumDyjPT9idtFFA/p5q2bnKJEE2EriyPMK/y4VDSRfIaOfWLS2uHZqxPwKcmendZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0acZjteH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72070d341e5so1253351b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1730126165; x=1730730965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VErrHr7xGoqoJAwH+xykppNXfsTQ7wlzfNEAIEk+JU=;
        b=0acZjteHBjY1Gud9I7G7UUzfLhc/krKrxoKAkUgNJfyfC0l07wipvGE45Mz2BvbflN
         tvTXViYB9ZTa2GSCloT3b1ciZRLO6APSqFjT4Ugh4yWuWUTRAxIYzBGJT44JRRrbd9E9
         tL/2XlTm24iTEoWNF70/JvyxALuhHwhXYkp5ij1/RQ2m23eTZhE2ed5GpNEydgQbl3cT
         xvoUpYedPmQOYv0UCaMFQ02btrMLjgkxNUkw/tuQLJhie75uPQLqZnNPNTpd4XrV55sR
         J+oU4J7P26g/0f6LEe+R9l0Rgt9Z40fpZnhtMh+8y23lSQNEIcX660vFDvuV6z73dMS8
         WtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126165; x=1730730965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VErrHr7xGoqoJAwH+xykppNXfsTQ7wlzfNEAIEk+JU=;
        b=vB7DN3P+zVjS1bXXuPqQjSRSxSahoevqwF80qjQlJs4S2sXw08580EAdJRr6oXOWYR
         h7O48/57U18QRMAcuHk0ARWvwvqKzF0JN6MSnh82INL6vpXYlDJ2ff9W7/8awaDR1yxA
         hyprIUMHGPluLVv4pHUSJ7P+cLt7/6fpIBLtZ01Ly6m1484z8VYfGdk6dsnhtbx4XZOH
         uNnOMO7Ic7/CJvjEbVzg9Q4ZfJwLAOKcGPZgInWdYADrQQtrk+CBwfBCudBEPp2Dws67
         2RnNBe8C7VWAR79dS6t5gNEBfTeQ+cp2uQrBDOHZZaLj73Vf7bXtTLBVY46e7DwD7no+
         LMCg==
X-Gm-Message-State: AOJu0Yz/hqyW9VTclD7Wvqb1o3+7E6/XdVUjTpWYoE1CzZQUb9wDEfoe
	kIAs2Qcu3aHnmfScZMbGr2ukvDN8QE8vKTx2FR7W7QJtt6oxUhZFKNrsAHf0dQ==
X-Google-Smtp-Source: AGHT+IHLmv8ISa1DpvydISGm0gkoxTPr8M1/P+5uxCjuCse790+6Ls7IUfHu/hW1liGArK6IX8gMlg==
X-Received: by 2002:a05:6a00:1890:b0:71e:6a57:7290 with SMTP id d2e1a72fcca58-72062bdeaabmr13797281b3a.0.1730126165307;
        Mon, 28 Oct 2024 07:36:05 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793273csm5741119b3a.74.2024.10.28.07.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 07:36:04 -0700 (PDT)
Message-ID: <9ce50453-c78a-4883-a888-51e31f673f40@mojatatu.com>
Date: Mon, 28 Oct 2024 11:36:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-n] net/sched: stop qdisc_tree_reduce_backlog on
 TC_H_ROOT
To: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, markovicbudimir@gmail.com, victor@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jiri@resnulli.us
References: <20241024165547.418570-1-jhs@mojatatu.com>
 <Zx0dHmOtsI6FmOeN@pop-os.localdomain>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <Zx0dHmOtsI6FmOeN@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2024 13:47, Cong Wang wrote:
> On Thu, Oct 24, 2024 at 12:55:47PM -0400, Jamal Hadi Salim wrote:
>> From: Pedro Tammela <pctammela@mojatatu.com>
>>
>> In qdisc_tree_reduce_backlog, Qdiscs with major handle ffff: are assumed
>> to be either root or ingress. This assumption is bogus since it's valid
>> to create egress qdiscs with major handle ffff:
>> Budimir Markovic found that for qdiscs like DRR that maintain an active
>> class list, it will cause a UAF with a dangling class pointer.
>>
>> In 066a3b5b2346, the concern was to avoid iterating over the ingress
>> qdisc since its parent is itself. The proper fix is to stop when parent
>> TC_H_ROOT is reached because the only way to retrieve ingress is when a
>> hierarchy which does not contain a ffff: major handle call into
>> qdisc_lookup with TC_H_MAJ(TC_H_ROOT).
>>
>> In the scenario where major ffff: is an egress qdisc in any of the tree
>> levels, the updates will also propagate to TC_H_ROOT, which then the
>> iteration must stop.
>>
>> Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix qdisc_tree_decrease_qlen() loop")
>> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
>> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>>   net/sched/sch_api.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Can we also add a selftest since it is reproducible?

Yep, we are just waiting for it to be in net-next so we don't crash 
downstream CIs

