Return-Path: <netdev+bounces-210754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E800BB14AD0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0972C3ACD3D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E326286404;
	Tue, 29 Jul 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyCvYG50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E822ACF3;
	Tue, 29 Jul 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780233; cv=none; b=RglHWOdRI/vznxb/lEupl2CdBPdShEDAv8U5SonIC6KOZGeABInGAwTDrczz34bu6SeMayn/WAMI99b1swemlE6lRRuIHEx9HUEHhyY1mSUPesBro1Xu0qNcQJFZUvdD5YhSXv6Y8r9b7lFwd56IiYPNh2HSU/BiqL7hbGjdFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780233; c=relaxed/simple;
	bh=T0I9+8eEyw46rOv+JBH8JlwKZx8kdQqKLsYuvjIRixg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5zQUMWMBxMEcagZmCBsjv2J3kayi8HEBIXfgQeaGKJiZOleTA/R3D7WZ/nhVpHJqoqnRz/TtxVw4ggBq/RZPNeVfXn33QKNMsY/rKz96i7tg1yo7s5OK2y+BxjnTMb02HlxoPc5GHmSGOwLqI2LbZVMybaiDQ3US47muBppWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyCvYG50; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b788feab29so1461075f8f.2;
        Tue, 29 Jul 2025 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780230; x=1754385030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5d72/CUGwB9F5w72AiF0d7TRfVgoOjMW++MS+u5Taw=;
        b=jyCvYG50hhQ2xhlhE7j46/aeHeoXWSbnkxhGYtau7RQJfF5SD7KmyZN2G5V9sDw2II
         W7+U+X+4+wMLc9kOFm4t96tjD6ix3bfBu+ZK3KHHZUfELE75QgXyQevkUy8v2XsWNv6m
         cwC04NqV4ZU/D4MXF/qSHQMt9yNScSd0x5jH4bZ+w6718uUKP6NQ3Ev5tL1BJH4MJ9zU
         D0VRY7oR6DMQzAxKWLb+koXHSbHFZhJl+5s09vIXBgo4xGyvG6yJVtV3Hz6Ok4PnSHAs
         WkuDNyTX3jyzkO8GUYRxFyRmvvb5sDaZx8JUkZwFiBWoitfZKbz9SusMKFJx9Ji0bhfu
         FmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780230; x=1754385030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5d72/CUGwB9F5w72AiF0d7TRfVgoOjMW++MS+u5Taw=;
        b=kmcgKqQTe2Zychkc7yqVZue/umjrTWrmjgO8uH/pCEwUfWNZnb8uazfYfTJm1cIpNH
         1IPQjcinxpYTGl6F7jFwCNHbqpUfhuLYbvL1IA/I8JRgWirjESBkXGwCyUeWkeM8vcsZ
         GAOtrVjbjl1p05+tH/DBZxuC0btlu5tb9WIctp/qX7SplBz4HyukAXDhqQfv3bFhBkbT
         GPjgQ3hKzn7nzq22g+KprjDPZms9ziL3uPhMZzGA+G0lKOJuLmBP9r7jxhpR23cqr0uX
         /qtEZrdypMIvPfjjUd7muXgFuwoIdfaD97YabqrA+RDehzwMeBP4J/NRScRebaZP29QS
         ypsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7GarDqlJk3625UfgMdnE0VswDltj8QBUOibrTfZ9gIO5RA4BGLDAvmsle5ibwd308fDbLgQalQ2HeiQ8=@vger.kernel.org, AJvYcCVYCvxHKExDAcb6s2qnY0cesG2Db04xPdtsLNvYwd4uyqExSGvjiHNxmA+Id7b6bsfVWpPmZAWp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/o7nat1zsZzO7TqH5z/JD2N5eG6ke3OB4QzEmW0AtFMSV/x26
	CauKs016+0Xl57DVu/cCeINFbSdPBarCpYgdZadbYcrJ5tiA02kTOIxA
X-Gm-Gg: ASbGncuL09L/Us7KeZoVI/yPURNZsZRp4/7tF0DGBmCQ1UvvluCHsSlKjIPCnAXto1N
	uAi+gzj7OwNoNZJPg7P8jtWWKfskRU7QLbrAmtPPTWWu1/SCdlcoAcvNCiGG0f56z84fQQpR2VT
	H4bWkk5CPVbU6sI77CajZ2XakPa5Ryz1cmH2zvfrxNVB1CDqr7uTFv452QJWmJpbLHMf7EB3GvA
	hf3J7t45pcKIzd++5FcpFMPQGa/mZZCl6WnYo2GZ4szDEhisOF8PR4bCOp8OaEE8iUd32osJBEk
	rPhVLEowwRuAR1TxiohOlrJ07ZhBEutmHuMoOcgwQak9ZH50+Q7v4298l8ZIaFNmY35yMG2tF2X
	gqFljS1Yh4UiBt2lgJxhDfp5bLHE/IVj2YaA=
X-Google-Smtp-Source: AGHT+IGvibxPDDXvQMAmjPqamEm+8IJtbphJ6txv2EOFbA5FHRGXzhmRky518PKnEwpopYy35jDd1Q==
X-Received: by 2002:a05:6000:2508:b0:3b7:8481:e365 with SMTP id ffacd0b85a97d-3b78481e380mr5662076f8f.10.1753780229987;
        Tue, 29 Jul 2025 02:10:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:72ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c477sm11340564f8f.58.2025.07.29.02.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:10:29 -0700 (PDT)
Message-ID: <1dbe988f-5703-4ccc-8f53-dea455192983@gmail.com>
Date: Tue, 29 Jul 2025 10:11:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 toke@redhat.com, kernel_team@skhynix.com
References: <20250728042050.24228-1-byungchul@sk.com>
 <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
 <b239b40b-0abe-43a5-af41-346283a634f6@gmail.com>
 <087ca43a-49b7-40c9-915d-558075181fd1@gmail.com>
 <20250729011711.GE56089@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250729011711.GE56089@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/25 02:17, Byungchul Park wrote:
> On Mon, Jul 28, 2025 at 07:58:13PM +0100, Pavel Begunkov wrote:
>> On 7/28/25 19:46, Pavel Begunkov wrote:
>>> On 7/28/25 18:44, Mina Almasry wrote:
>>>> On Sun, Jul 27, 2025 at 9:21 PM Byungchul Park <byungchul@sk.com> wrote:
...>>
>>
>>> info to the compiler to optimise it out without assumptions on
>>> the layouts nor NET_IOV_ASSERT_OFFSET. Currently it's not so bad,
>>> but we should be able to remove this test+cmove.
>>>
>>>       movq    %rdi, %rax    # netmem, tmp105
>>>       andq    $-2, %rax    #, tmp105
>>>       testb    $1, %dil    #, netmem
>>>       cmove    %rdi, %rax    # tmp105,, netmem, <retval>
>>>       jmp    __x86_return_thunk
>>
>> struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>> {
>>         void *p = (void *)((__force unsigned long)netmem & ~NET_IOV);
>>
>>         if (netmem_is_net_iov(netmem))
>>                 return &((struct net_iov *)p)->desc;
>>         return __pp_page_to_nmdesc((struct page *)p);
>> }
> 
> I wanted to remove constraints that can be removed, but Mina want not to
> add additional overhead more.  So I'm thinking to keep the constraint,
> 'netmem_desc is the first member of net_iov'.
> 
> Thoughts?

We don't want extra overhead, the function above doesn't add
any, so just use it. You don't need to explicitly check that
layouts match.

-- 
Pavel Begunkov


