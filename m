Return-Path: <netdev+bounces-183940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E7A92CD7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC228A650D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9F2063C2;
	Thu, 17 Apr 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jJTxpx5/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20D1CEADB
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926599; cv=none; b=E+blxLYAj2fGCA1LzL+f0EBEl1sQx9/BBdpNhgmLJPYqZDranHU8sEexXvVjpVgtQ7OLgAEwNn6Xi5V2J9o5uwi+4UTQF1M95m1n6G7rosXihQxS2a+dY45kD0lW9d14xWnedVl55JJU3uPUvgFtrX+uoZoW0jKsKxf4SPIx+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926599; c=relaxed/simple;
	bh=DKXXp6X1XuLcy0ZpGTtE+AFPfu235RcljydGqa539lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoVccSf10Q+zMqio61KFJZqpj3Y/fKKECpFLLmCPPauZiznyXx655pdIvjlqwohCAXykcLoSHICsC+LnI25HxHmwLxkN+Kvo5qQ3PiMtHCs9k9rRokBT4UEICQux5cEI+TORRYJEpjFDHWq8a+rNcdhMhEfAQGGJGabLKypPIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jJTxpx5/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22438c356c8so16431975ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744926597; x=1745531397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ng3NOrkYbq8iG4ODweerIT86OxCFKf0tIxCvmAFjqDc=;
        b=jJTxpx5/QybbJSydFkn57Ky+f6vxq1FJfZEee9z8NF7S+L3X33O1Ou8OFTOnIiUXkf
         I4sY1+V6iP2anxgzu4pc7tB0BSLS1QdLYB30fhJF0DG5HyyqnK3d4idZtIYIVeP0qhr1
         Fed6hOsxBEt2MGgabOVEGcWdXSb1pVcFEatyJk4rTsCM7dQ/eYFCbkPmAewowLADElDJ
         LI2Y5uRxZi7XfYgPwXnl8W1JBhGKymDPUaxrXxkVdCQYK8nkzr0HYJ3qr51hpVEzSyri
         otY7YKKdLurK1rKSO6xmHmocNr8SlOgvP0zrWOWzCj7GLUnRrQB53Nol5cwYCr/klYy7
         ALXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744926597; x=1745531397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ng3NOrkYbq8iG4ODweerIT86OxCFKf0tIxCvmAFjqDc=;
        b=oXpJKFp+1+PM50n1MAq+wJad8hrH7MIw6mCqz0h70VhKXIzv+jQiWvmzYWsu2aPffY
         Fi2mblOjYIaT7ghcqPY13IcRioftrPIa9YIRMCymohYYacWgc+y7BDeobFbcliPigU+k
         CojiF5wDHzNq5/GoYo4tBc7RWgNvX/SXI2+BDA/h0Wxi4UQyIaW2vDev53LUlbzAgYHk
         +S6sHMEPnO6gSZwSD7vnFS4TYG0NrthK8uwHUkgOeyQSsSth7eQ5HEPsF6QouUr240QK
         12QBsmdkbxaM0b4dnesmh0WlyQFVAlwc29rOmXA9rzacXV5F8Ei0dDQcvEhZdp4laTED
         CM0g==
X-Gm-Message-State: AOJu0YxSAVS1KwueWk5LRnNrZ+TtlR6bRGyrxk2Uw5nLc/5x9qj6Ndjz
	PjG90i1QjRBHg4wz2gBkUsQVJ2LhAmgVeCAYaSpbMU+/gOhb2jJLjpBSwXYMlg==
X-Gm-Gg: ASbGncuJXyebd3IzhX7eUD/ulW8by3F3y1c40T/hZmDKYq87TenrljlWjlEMUsNnmb1
	uXfQvR/JUf7r0jX5Crf9Wgc+06dsjpEe1qOAlHRlSOJ2ZAN0NfKTnBu7ytPzwC1fBbDgLyaQz23
	WJT6/2pSaAdRSA/pzA5UdBB1B44c4/pMSE5jCBO9o4IJZBpK1Ebl3ScxjCyw0lZZSKyUQXFk8Ub
	/2O9q+x4a26W+24nLT9S4CKbjZ3kk3+2NOLsOTywGwA943o3LIoroQDh4vOD8EQ0DzKiyDdPiFu
	hXo3lta/B1c+gM7a44dNa07vZK+zzRyTzKFdiGnYV9xA4wL7I/smM8BRgHqZfnNgVupgvkDajuU
	KWx0CA9PackI=
X-Google-Smtp-Source: AGHT+IGNH4apmDHeoCXJY+dzkomk6EttKKQ6y+j1UnXkq8EwQwSV74gtnteRQ56Tp/vtcCd7FzlIZQ==
X-Received: by 2002:a17:903:1cf:b0:223:669f:ca2d with SMTP id d9443c01a7336-22c53611146mr7282785ad.35.1744926596637;
        Thu, 17 Apr 2025 14:49:56 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3b87sm5077705ad.85.2025.04.17.14.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 14:49:55 -0700 (PDT)
Message-ID: <0fc72ff2-c13a-4da4-941a-36b4c945a015@mojatatu.com>
Date: Thu, 17 Apr 2025 18:49:51 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
 pctammela@mojatatu.com, Stephen Hemminger <stephen@networkplumber.org>
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <20250417090728.5325e724@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250417090728.5325e724@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 13:07, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 07:24:22 -0300 Victor Nogueira wrote:
>> As described in Gerrard's report [1], there are cases where netem can
>> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
>> qfq) break whenever the enqueue callback has reentrant behaviour.
>> This series addresses these issues by adding extra checks that cater for
>> these reentrant corner cases. This series has passed all relevant test
>> cases in the TDC suite.
> 
> Sorry for asking this question a bit late, but reentrant enqueue seems
> error prone. Is there a clear use case for netem as a child?

We discussed this internally as well before i sent this fix.
The 3 examples are buggy in picking the correct active class in the
corner case the poc produced. So these are bug fixes regardless - and
they happen to fix the issue.
We also wondered why it was not appropriate for netem to always be root
qdisc. Looking around the manpage states that you can have a qdisc
like tbf as a parent. This issue happens only when netem "duplication
feature" is used. Not sure what other use cases are out there that
expect netem to be a child.
+Cc Stephen who can give a more authoritative answer.

> If so should we also add some sort of "capability" to avoid new qdiscs
> falling into the same trap, without giving the problem any thought?
I think the bug needs to be fix regardless, but I think your
suggestion also makes sense and is more future proof.
I can send another patch later that adds a "capability",as you
suggested, (let's say ALLOWS_REENTRANT_ENQ or something similar)
and only allows netem to be a child of qdiscs that have this flag.

