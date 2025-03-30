Return-Path: <netdev+bounces-178230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51FA75C42
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 23:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA5E18857CD
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFC1DD525;
	Sun, 30 Mar 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1NG6aSzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD58632E
	for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368713; cv=none; b=tUCEvCN/XIL8oRsVptiD52cBvw0o5UlaR5EgEEC58eCY5pNjpet4lcYr9YUMutAwczmuHqTB8oNGHUQKabOUsPrfUd/MbIk45EDWJhZ6Kr4kNlGoRMAucriyZcsj53Ez69KD5EOViMfPfYlJB/41ObaRrDPO/2jnrwTnz0tB5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368713; c=relaxed/simple;
	bh=3aXeHs9CT5e37EQCXVgvB3dhx7VyD650fhKOAdY6zPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDjXrRpa2dxR7Bc5Zq6yT1Ie49NF0dTh0o9PxKFDyY7DR52iMkNKqkMMoPt/XIX1NMK8fZP1fHahIzFhvzxcMe568QBQmzbDPhs26E0GchSPP4AfQNrOvdXk+TBNMDrHpTyygOknUyLNzvrMja+YQuQ4cxJgbVhO+tK2hEvGFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1NG6aSzf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22423adf751so70305755ad.2
        for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743368711; x=1743973511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owvZCcutf1DOBU1B335ocM2X92cpRzydyIoT1nTXsp8=;
        b=1NG6aSzf80yzZicBaxC4TA8SqogSBBuTGqA5v+tIUlnNIQWgSYMHQfJW0oV2oB7/qT
         fQO10o6gFxJEtR03aRnI5DTg15BgvwR4RxXyZ3IVg9cIqhV51r4ulA0i/8fIYF4x4PUL
         Cw6cAww/Dq5XX5LOSKhh4LClVlZo5muscpN60Q9UDKO5Iy/ayOBCb43IA6MNp9/KP2G/
         ko9c0sMpl9BpeZVgzhv+jIp7QMuQpxYH8Obqr8o/3mVjb161I+GUyppNvks3EECJMkZQ
         eTDq2lo9jobAASsFWQWEBTPCGfRnllQbkt2YfnOv59IdLXkrnfGcdWTD1gEiVlZ4M0Ac
         0ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743368711; x=1743973511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owvZCcutf1DOBU1B335ocM2X92cpRzydyIoT1nTXsp8=;
        b=wjzUCLGUqltQPnXrTFz3xe2WQ4y2miP3CSy+3FUjXjihZxU9WO9YUhEfILs1oakOZw
         No0WpnPGhZ3FI14vhGwAZLPjdbGTVOX8KYg9FiKyrfwhJAAD2ONnVQNapOGU5saDB1ZC
         nSEpGWGFs25XDZ8DkMe8sSybJEC/qvbpGNR9ST1NYcyD8O85UdJS2mpKk0J5GRUCPyj2
         bVWVRUugTz9Z7KikS5kE93n09WHcbrPWFVkqT7CrPM2cCA5QJL8xNXdoHBFRRmxpQ2Hk
         i0SvzO+WztU+UBW1jQDopojoVhQ93ZaSrfWML6m51Ze3NNMmIEDLdJ5q1KIkAHgdABox
         KwWA==
X-Gm-Message-State: AOJu0YyNwSAqFoGawQNgrvKgu/uwnEaRUL0K7yhEe5L5k2/m0Pwi03iu
	lvOjjQ5dKTNFFYv65BDB0fiGGPR8UNaGroNtO3t9g1GhYyx3tXcn7uhASIc2nw==
X-Gm-Gg: ASbGncsod0mAXI7cH8bjmFcIMGPyw3egZH8JrP3QfTnSu6sBsuP7+/dlsFoFKs1vxiz
	j5LCy4Sdol22WXEa8AD7Cm+LaF+M6mC8U7GoziYxUknOgYG8GztZPxYnxpzMZg5MivOGi5ygkCm
	Eonu+JCVF1+nArNA00UvwHnb6hA0nketMIpk8GAurPDi3iGgElSEPKuwg88pTB2rIvTTs5aacx/
	91yBr2UmU80l8sTYIhg93L7xvDRKWv+5HpvFPfgp89e5qBTvSi7Syvr4w7oTWLMXUrDTRFrCdlR
	Oz1M65pw2KSYnYcSCM8Ef77TJa7iA1xb1KlS2i1b0BASTKz9hDfIO04TwQ8dtQ4YqddiDQmqujf
	3AaCsqWN2BR0mYjQ=
X-Google-Smtp-Source: AGHT+IHdhXnGtjsqCEC5p/QBjcq51Cp0cWADstjN3yOzMP8Pq9i6AJK49nuolnZ61M5Hb4tFrZKwIA==
X-Received: by 2002:a05:6a00:2408:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-739804684d8mr8690562b3a.23.1743368710832;
        Sun, 30 Mar 2025 14:05:10 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710db4cfsm5801329b3a.176.2025.03.30.14.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 14:05:10 -0700 (PDT)
Message-ID: <9a1b0c60-57d2-4e6d-baa2-38c3e4b7d3d5@mojatatu.com>
Date: Sun, 30 Mar 2025 18:05:06 -0300
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
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <Z+cIB3YrShvCtQry@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2025 17:35, Cong Wang wrote:
> On Sun, Mar 23, 2025 at 07:48:39PM -0300, Victor Nogueira wrote:
>> On 20/03/2025 20:25, Cong Wang wrote:
>>> Add a test case for CODEL with HTB parent to verify packet drop
>>> behavior when the queue becomes empty. This helps ensure proper
>>> notification mechanisms between qdiscs.
>>>
>>> Note this is best-effort, it is hard to play with those parameters
>>> perfectly to always trigger ->qlen_notify().
>>>
>>> Cc: Pedro Tammela <pctammela@mojatatu.com>
>>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>>
>> Cong, can you double check this test?
>> I ran all of your other tests and they all succeeded, however
>> this one specifically is always failing:
> 
> Interesting, I thought I completely fixed this before posting after several
> rounds of playing with the parameters. I will double check it, maybe it
> just becomes less reproducible.

I see.
I experimented with it a bit today and found out that changing the ping
command to:

ping -c 2 -i 0 -s 1500 -I $DUMMY 10.10.10.1 > /dev/null || true

makes the test pass consistently (at least in my environment).
So essentially just changing the "-s" option to 1500.

If you could, please try it out as well.
Maybe I just got lucky.

cheers,
Victor

