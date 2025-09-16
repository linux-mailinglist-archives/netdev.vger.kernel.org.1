Return-Path: <netdev+bounces-223396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA4B5901A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781AA1B2273A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2628A1F1;
	Tue, 16 Sep 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I422P7/x"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0F264F81
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010341; cv=none; b=ETSfbGCEdvkkZxGG6+KSWkICSY/GaYEhqFjsn65qp4fDeL5VHpTokxfnRRi53ExcVfvqUqQpYT2JZLz4vwk5eJaAQscQTfb89/lSFRd/HaDNgiFT/Sbayq1zEQ/0ntxUv4rR4V8b9aGolG/sSrv68LeF1nIJZKVPOzRynOW9s80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010341; c=relaxed/simple;
	bh=pkce+jGzodkXaiRgQjuOTkSEiMTNx+A9Iqb0yK0hNsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6Mui53JDIEZARv4S84pVkUTyD1e4yaRDQCL4q3rXvcLs31Ctadbw/sBvHT+jxAz655aooLo9ozt9QpfhoJxvI7Gw4cNphRNA+wKiIE/9tA+l1aXhlLyt0AQdOTd/+jh4bCPpduJYnzla+seyopJl8HbW1jEC9DQKLMJf1jvOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I422P7/x; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09d9a014-5687-4b60-9646-95c3644efe19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758010334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq8i+FrvoUldSg+h34xo0dhV0YLyNZdNrb44Lwik8ik=;
	b=I422P7/xtbqfx+dq/dDnuBlD/sAnA5IDn54VQM6Sg8ztVHXFH3mGRubc18+BHWxoB8E/pe
	AKZ0T2uTj+vkMidmxxM8lzmDau/t2eTZ8ikdSn2vi5bJI9xO6Wu6ZQOIrqhclUK3B1M4GE
	QOFsjsXy4CvgZNJBrF8epM5DjYC7Gy0=
Date: Tue, 16 Sep 2025 16:11:25 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iLC6F3P6PcP4cKG9=f7+ymW1By1EyhFH+Q0V6V-xXn7jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/16 15:30, Eric Dumazet 写道:
> On Mon, Sep 15, 2025 at 11:47 PM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
>> TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
>> during the switch from reqsk/sk to sk/tw.
>>
>> Now that both timewait sock (tw) and full sock (sk) reside on the same
>> ehash chain, it is appropriate to introduce hlist_nulls replace
>> operations, to eliminate the race conditions caused by this window.
>>
>> ---
>> Changes:
>>    v2:
>>      * Patch 1
>>          * Use WRITE_ONCE() to initialize old->pprev.
>>      * Patch 2&3
>>          * Optimize sk hashed check. Thanks Kuni for pointing it out!
>>
>>    v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.luo@linux.dev/
> Note : I think you sent an earlier version, you should have added a
> link to the discussion,
> and past feedback/suggestions.
>
> Lack of credit is a bit annoying frankly.
>
> I will take a look at your series, thanks.

This patch's solution isn't very related to previous ones, so I didn't
include prior discussions.

But to help others get the full picture, I'll share past links and
earlier discussions related to this type of issue in the next version
or a reply. Sorry for any oversight.

Thanks
Xuanqiang.

>> Xuanqiang Luo (3):
>>    rculist: Add __hlist_nulls_replace_rcu() and
>>      hlist_nulls_replace_init_rcu()
>>    inet: Avoid ehash lookup race in inet_ehash_insert()
>>    inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
>>
>>   include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
>>   include/net/sock.h            | 23 +++++++++++++
>>   net/ipv4/inet_hashtables.c    |  4 ++-
>>   net/ipv4/inet_timewait_sock.c | 15 ++++-----
>>   4 files changed, 93 insertions(+), 10 deletions(-)
>>
>> --
>> 2.25.1
>>

