Return-Path: <netdev+bounces-103584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F183908B53
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87820281D16
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B54198826;
	Fri, 14 Jun 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hArU+Bgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CA196DA2
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367195; cv=none; b=HIjQA4+bg64Ld36PQLBcrOJbEmPOW6kVdyFBOXZMMf6XFP3Gc5DuWUZ8kWIlbqop6t4otPpeTpbhmDGJy/m9pPMrdIM6jYERRg8vSIsBr6aFvOvl8QkLDGAfg/M3EXTcBIpbYRp9laMZeEFtraE5MmQ7DNlWkE0CdLthOcnFtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367195; c=relaxed/simple;
	bh=lL5yo5qqDaKurH6U5U7Fp28JXI5DPylMtIqXyKbjXCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P85x7CNx98bGSE67iE2FgveDOVphmVdRz+InqiMpXbiHwssqMChNykp/6CphlBuddmSuNnmqvWrx6d/RzMoap1N2xEDrtJ7Etxlws+ugNukywj23wYmsJ3IfGM6UfCRQWDNtRZGuOdCJu/N/SCtrEzMmsAOhSZ3yyye2uEKYWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hArU+Bgo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f862f7c7edso7781815ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718367193; x=1718971993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH66qDF7GWcMmMf4y8Y1JoXkk/KQutuhkZaxUXORmL0=;
        b=hArU+BgonqGoa1Ade/lbY8lr12qDt3TxY9GKZQyiqGpV7+5llcnu+eZTCN6ktX+Mmb
         mrDwS6SuLmaSzMaQB2Qwjr8nkrZeqeifrFc+DnM7knHAvAjnvjZccA/u3vRKuUeKeSu3
         yC6KDKkGodOF9gCTepvP2vv35+seMuCxNHhI5vkkELsX3GsnQHNCFHPes1yYjRkp4ygL
         YJF6fQ9o1JKJ/RrC4ZDZV8maYFnowA32ZOJa78YM0IrmIzUludwrNoUu4CFnL9SalpEn
         noJ1pAcUycv7f1IMlvjssGSKzJxj8iJEDTo2lN73C10hHfi0c+94/7LZ0k79pxJpSiH0
         aArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367193; x=1718971993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH66qDF7GWcMmMf4y8Y1JoXkk/KQutuhkZaxUXORmL0=;
        b=E6qYMvzmzHBZm7D6EA+KJzKCJ5IgA1cRhgrHLKWhMOmvNg3fxZTLTq+vtdmf6wKyTs
         e3+S1+MsszoVq8tASngN1SSzWBCvinJZeB5j1+5I2tPHcj57kE8tFJqP96NfOXlTHS6e
         Jy1IHui1hOjHxsRQIr2CmjxW9A9aV1qA6f6gQmudJApuDLSnyj/AYj/RlwroikomP5PH
         jzOqzyNDZEOHiCmkhAoGOVq3+WDCyFhQY857ikJ4NubnqeZP63X3y0MXvW3OZ6I3RZ4Y
         DPPRqGIdKZmAP4UhfD/Ut3b0ExiZQGzpf8hwaWrt5cyXXUqhZ7TEd6aMhFouOAe0D+A0
         ENbg==
X-Forwarded-Encrypted: i=1; AJvYcCUQBdS3KLLfQl1+uJSlGgk3DOlPybiGFKLBn/EVDQQTQrSdI13/kUmyfPpXcExrX5gPcge/vY6Ipaj3T4yZ7SnL8VKkAQ6/
X-Gm-Message-State: AOJu0Yz1vR/9M+K9p2d6lV2VMDweiCAg8KYEOn7FwtVXL3RtSjEfzehp
	sMCEzZ9YEiBcNlZO/wsjIOySdrnmRRJnrklWdpktIJIQKUrf8VvPuiMx+wffEA==
X-Google-Smtp-Source: AGHT+IFEwsUG+fOA4AM5DWv8SyZWoLN+djI/Iyk9iD/4DH5/hNXVqwEpcPXJI6TaW64LFKiWrRENNg==
X-Received: by 2002:a17:902:c404:b0:1f7:2135:ce6d with SMTP id d9443c01a7336-1f8625cefd1mr33743035ad.18.1718367192746;
        Fri, 14 Jun 2024 05:13:12 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:3a42:c007:5df5:153a? ([2804:14d:5c5e:44fb:3a42:c007:5df5:153a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e706adsm30937105ad.86.2024.06.14.05.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:13:12 -0700 (PDT)
Message-ID: <d1443c9d-f57d-427f-9517-89b8c9f8bbf1@mojatatu.com>
Date: Fri, 14 Jun 2024 09:13:07 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net/sched] Question: Locks for clearing ERR_PTR() value from
 idrinfo->action_idr ?
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Network Development
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
 <de8e2709-8d7f-4e51-a4a4-35bad72ba136@mojatatu.com>
 <522c0b17-c515-475d-8224-637ca0eaf6a2@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <522c0b17-c515-475d-8224-637ca0eaf6a2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/06/2024 01:00, Tetsuo Handa wrote:
> On 2024/06/14 11:47, Pedro Tammela wrote:
>> On 13/06/2024 21:58, Tetsuo Handa wrote:
>>>
>>> Is there a possibility that tcf_idr_check_alloc() is called without holding
>>> rtnl_mutex?
>>
>> There is, but not in the code path of this reproducer.
>>
>>> If yes, adding a sleep before "goto again;" would help. But if no,
>>> is this a sign that some path forgot to call tcf_idr_{cleanup,insert_many}() ?
>>
>> The reproducer is sending a new action message with 2 actions.
>> Actions are committed to the idr after processing in order to make them visible
>> together and after any errors are caught.
>>
>> The bug happens when the actions in the message refer to the same index. Since
>> the first processing succeeds, adding -EBUSY to the index, the second processing,
>> which references the same index, will loop forever.
>>
>> After the change to rely on RCU for this check, instead of the idr lock, the hangs
>> became more noticeable to syzbot since now it's hanging a system-wide lock.
> 
> Thank you for explanation. Then, what type of sleep do we want?

This patch should fix the bug: 
https://lore.kernel.org/netdev/20240613071021.471432-1-druth@chromium.org/


