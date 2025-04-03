Return-Path: <netdev+bounces-178939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C7A7999B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2CC189396C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB628DB3;
	Thu,  3 Apr 2025 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="h25Sm3Pt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACF1EA91
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643409; cv=none; b=THP7JwjSddPm+fbPkDo4XwG20obL/WDjAV7dXjylTyQCD9fqbbD4mRs/WCaYb5yExGdvz/TYBbKVl2SGOfTs1NeCgU+wjglvDNxpAcIFA+02s2Y7oLQoNdQ+XBOiAolCqQhWTrLK6ToHx3m5H791435Plemyfml8MnQA2uo6BAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643409; c=relaxed/simple;
	bh=gq/RjGRlwq2gLFeSlN3ARVhyo7iSbQ7bu9dtlYgz3Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHshAbRZNfSbd121Dyck/dne+949CFou+7h9HMVeetNKNv4PK/J3S+kx7xu5sHCakEc45cJZ/JYA8F9vsj2S9xA+K9u+xtRloekOMHqOT4iLkdW18TsNK9LzCiWpIonr5DUMwGGTMARCtkfYsfsGDR0vZd/7S9C1aFho9+UYrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=h25Sm3Pt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7398d65476eso265040b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743643406; x=1744248206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbjbqyKVAsU/z1eNMwlx1Ib0p3vVEhxGVFKklO+5F1U=;
        b=h25Sm3PtybGHhEXju4ojkrFZFhkmkTkXM2v/tHp47MOnhzDjrHo7oEuSm9YumMN4EC
         p35fq+sNNo86wXaLJaYwMaZWCX6kbcUjioN2cl6UZtTSzaTaJtgtH9AInw2CbOA2sEZe
         usaP/bJjgs8/aaPiP9vEfRlJiYwMiXJrH2F2Rw6XumKu+/bUSHZB8Gwe49bypXwU6/kK
         uqAVQ633IdNZlEMzOZdUp4c5vB9pfM4JrAJZbQioy9DtdPANKo+PZ96cSWd0NvP+Mf+w
         +Sk7TZ5du6cUqmHw4C2MsqlOUdLOEOe72gSi/+a0HTUutW6x/jIFT0ME61fNgH1U9nJh
         EUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743643406; x=1744248206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbjbqyKVAsU/z1eNMwlx1Ib0p3vVEhxGVFKklO+5F1U=;
        b=sOUtIAqJFVCHz6ptb36HnbDi8Kswe+fhPuMoJhNLG31ks64/5+QEDXZEOBf6rRd1ok
         TYaOpG75Ty3/7R3GrLKUukDWMKnds5gWpXN+Ki/2hH6H50FFvTmFCyIYRCrxys4Z4xMV
         KCgfBY4cQFwqnVhc+VMJ3eJMqBsyuL8QZ0T/PsJ+yrtyZEpgbdJ7qfPg4NgluPWnsEff
         udLmNMqH/LtWYg7eiXmNwZh9tPmyOiUwl5pmFKtZ6bfAP11XpPAbkudk5lSO73QzSfui
         h9L0Os4beyH8sEbHfJmq9ArJG1X8856t4w/MAUy5w4QD3mVccyjRJgDbUvWyG9eRiVgC
         TTSA==
X-Gm-Message-State: AOJu0Yz8Yj9Wo7YRvoESZY+mDDep+6nNna8IZcysAovS0VubtWTxAsZI
	JydQD0YlIMuv6fFdUoka2A4gcaxICUy2dM4oKyS4jVewecYU85pb6Sp/cypcmw==
X-Gm-Gg: ASbGncvFvqEf3GCEnQNdnnuAP/rsdbqsBnH6wUZfALmeMluB8Zq5sTzy8IWlbpf/8gP
	H9l7XZwTGCXcSaHdp0oYNObkSM8IUswD1EgUJWvNagTrGpV8sDdN75dNv6ixQVaElzj+JEP1+Ca
	s7ouRVspaiUiki984qoNGlugQ8EYoi14cYFCwt24ntGtZTpcoHuGk0b43CpRtg5oloPBXQbV37Q
	D91DXkYTEGTnnrF4Wp/FPr5OEHwAgE8nTVUO8BkqhS/DW9YCFbCsUydWULkFEgvTlgYfNGy+wF5
	6SteFivL5eP+dqsWCve4DtWR//MceveTH/8zezcv+v2aVUh01cjZmEESb4u5oGqiG1Nf37hmSPp
	ZtlzcyAHPabMCtQQ=
X-Google-Smtp-Source: AGHT+IFbfI4kpSGLi0bpsqeSGircrEqDkgO6AZXt0kU9DnWushi7Nl1oNfX0kTW7J/rwteRCTf402Q==
X-Received: by 2002:a05:6a00:1483:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-739d634e67cmr2039116b3a.2.1743643406081;
        Wed, 02 Apr 2025 18:23:26 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0dea7esm196660b3a.161.2025.04.02.18.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 18:23:25 -0700 (PDT)
Message-ID: <90069d47-8963-4caf-acdf-0577c19e999d@mojatatu.com>
Date: Wed, 2 Apr 2025 22:23:22 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 08/12] selftests/tc-testing: Add a test case for CODEL
 with HTB parent
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 edumazet@google.com, gerrard.tai@starlabs.sg,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-8-xiyou.wangcong@gmail.com>
 <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com>
 <Z+cIB3YrShvCtQry@pop-os.localdomain>
 <9a1b0c60-57d2-4e6d-baa2-38c3e4b7d3d5@mojatatu.com>
 <Z+nUiSlKoARY0Lj/@pop-os.localdomain>
 <CAM_iQpW7f5QJRXBpEMAmMVNvF5aGk_2YNLVF=bcnoZhMhjDU4A@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM_iQpW7f5QJRXBpEMAmMVNvF5aGk_2YNLVF=bcnoZhMhjDU4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/2025 21:40, Cong Wang wrote:
> On Sun, Mar 30, 2025 at 4:32 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> On Sun, Mar 30, 2025 at 06:05:06PM -0300, Victor Nogueira wrote:
>>> On 28/03/2025 17:35, Cong Wang wrote:
>>>> On Sun, Mar 23, 2025 at 07:48:39PM -0300, Victor Nogueira wrote:
>>>>> On 20/03/2025 20:25, Cong Wang wrote:
>>>>>> Add a test case for CODEL with HTB parent to verify packet drop
>>>>>> behavior when the queue becomes empty. This helps ensure proper
>>>>>> notification mechanisms between qdiscs.
>>>>>>
>>>>>> Note this is best-effort, it is hard to play with those parameters
>>>>>> perfectly to always trigger ->qlen_notify().
>>>>>>
>>>>>> Cc: Pedro Tammela <pctammela@mojatatu.com>
>>>>>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>>>>>
>>>>> Cong, can you double check this test?
>>>>> I ran all of your other tests and they all succeeded, however
>>>>> this one specifically is always failing:
>>>>
>>>> Interesting, I thought I completely fixed this before posting after several
>>>> rounds of playing with the parameters. I will double check it, maybe it
>>>> just becomes less reproducible.
>>>
>>> I see.
>>> I experimented with it a bit today and found out that changing the ping
>>> command to:
>>>
>>> ping -c 2 -i 0 -s 1500 -I $DUMMY 10.10.10.1 > /dev/null || true
>>>
>>> makes the test pass consistently (at least in my environment).
>>> So essentially just changing the "-s" option to 1500.
>>>
>>> If you could, please try it out as well.
>>> Maybe I just got lucky.
>>
>> Sure, I will change it to 1500.
> 
> Hmm, it failed on my side:
> 
> Test a4bd: Test CODEL with HTB parent - force packet drop with empty queue
> [...]

I see, this test seems to be very environment sensitive.
I think it will be better if we do what you suggested earlier.
It's not fair to stall this set because of this single test.
Can you resend your patches excluding this test?
I can try and figure this one out later so that we can
unblock.

cheers,
Victor

