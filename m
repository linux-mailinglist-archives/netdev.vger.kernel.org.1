Return-Path: <netdev+bounces-223433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BFB591FC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A35A3AD423
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE427A909;
	Tue, 16 Sep 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LDZco6Cn"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3142868A6
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014495; cv=none; b=q5t9PRL491E/L77X/BzGAcLEzBv4BGzUOTrjh5gTqK21CRyHce1pehArGwGEskunDUKwHCyqtdG0DSx4ri67pQ8HHmnqSPO1ShFPfLWC8nVz5qxAn7vDeDeXWnlV4PyRlZks9ziOuRMorJCAoTMGhcaBM/RMo/5eohsII7ySGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014495; c=relaxed/simple;
	bh=fHCgaSHMfZ8MihYV55qC/Iyj1UrsAPT7d42hSGY4LLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqtRnXo1Dhf8RoUtlrtmDtYO4exJcmnNmIJ+/rLAITeAMKRaP6t5Htz0ZQu9jU9xLHl1KhnMFw7Qnsa1b5BZAo8Z2D1xjzp5rTk0zTlbp7sx5MmCead0nQTffJfk7oVPuQC0GgHiJ9zhmUOcgk1lGTlvNsrZArNVcg6xmPPi8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LDZco6Cn; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ab15522-d5cd-4898-881f-4a8c867e4980@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758014491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXj6W/toc1FHvht0kF0dcaLY4qFh6ccrS0Ipr0OO1o0=;
	b=LDZco6CnmhMKcw9l8HcVVX7893dPcMtYVpQ3PsaL0sqc0KTW6uHGN1qbXTAbUJgor1Qycw
	2w3jv4wJbZCsii3DfDMgU9gBUUkYCssQEXtlSJ5lL9UvD/yE8jFeY1PAFX7EArtN2ZCEtJ
	mqW1lkP5U7WyubYu3tNAunupiqczAQM=
Date: Tue, 16 Sep 2025 17:20:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/3] net: Avoid ehash lookup races
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
 <CANn89iLC6F3P6PcP4cKG9=f7+ymW1By1EyhFH+Q0V6V-xXn7jA@mail.gmail.com>
 <09d9a014-5687-4b60-9646-95c3644efe19@linux.dev>
 <CANn89iKHr_cxcsPG0Oy7SJ9jyZS5zRAgPZL_wy8PSighy+Cy6A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iKHr_cxcsPG0Oy7SJ9jyZS5zRAgPZL_wy8PSighy+Cy6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/16 17:02, Eric Dumazet 写道:
> On Tue, Sep 16, 2025 at 1:12 AM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2025/9/16 15:30, Eric Dumazet 写道:
>>> On Mon, Sep 15, 2025 at 11:47 PM <xuanqiang.luo@linux.dev> wrote:
>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>
>>>> After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
>>>> TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
>>>> during the switch from reqsk/sk to sk/tw.
>>>>
>>>> Now that both timewait sock (tw) and full sock (sk) reside on the same
>>>> ehash chain, it is appropriate to introduce hlist_nulls replace
>>>> operations, to eliminate the race conditions caused by this window.
>>>>
>>>> ---
>>>> Changes:
>>>>     v2:
>>>>       * Patch 1
>>>>           * Use WRITE_ONCE() to initialize old->pprev.
>>>>       * Patch 2&3
>>>>           * Optimize sk hashed check. Thanks Kuni for pointing it out!
>>>>
>>>>     v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.luo@linux.dev/
>>> Note : I think you sent an earlier version, you should have added a
>>> link to the discussion,
>>> and past feedback/suggestions.
>>>
>>> Lack of credit is a bit annoying frankly.
>>>
>>> I will take a look at your series, thanks.
>> This patch's solution isn't very related to previous ones, so I didn't
>> include prior discussions.
> This is completely related, aiming to fix the same issue, do not try
> to pretend otherwise.
>
> Really, adding more context and acknowledging that reviewers
> made suggestions would be quite fair.
>
> This is a difficult series, with a lot of potential bugs, you need to bring
> us on board.

I understand your point. I’m sorry for wasting your time on this. Please 
disregard this series submission — I will send the next version soon, 
which will include the mentioned background information. I apologize 
again for my misunderstanding.
Thanks Xuanqiang.


