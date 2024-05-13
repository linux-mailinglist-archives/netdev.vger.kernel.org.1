Return-Path: <netdev+bounces-95929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D048C3DE9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882EB1F223C3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3981487CC;
	Mon, 13 May 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="yXr/cY9j"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E514830A
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591716; cv=none; b=CO8ldWLHekJyUwikwoDCEyFRF72Jeu5pxY2i4XRk40QDKwhG4fpnGDDeRlbZpYfhXM6GgrrG63Ya5rm56A6VC7MSrMKcm639a94/vhqWDNlO6lFiZ1ZVVDJieWVghIoE5VhnZMDpJNj00bArDfE6VuVdtqiFbnxShuL4TkeM1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591716; c=relaxed/simple;
	bh=njotRqbOjxRZbR584ECycCCFDmt0nH1b2ir/edqXDak=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y3XMo1O4YjYgx6g2gIJx0GESA+X9eWWdvqJlVZIs3UbUineEHkb5Wfgd9iCW117jM6bt3L/DSFoVvJJj7T9QYCHBvHFRp/QRzc2MgTS8OePpTzbOpdwuf1BeNfqLHVUDKJf8ZJ1NdoUXifgZzoM8SPegAqQPPlrmFDPYT4+D8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=yXr/cY9j; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s6Rlt-00BUkG-C2; Mon, 13 May 2024 11:15:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=nBHfnIfs9y73UkJaTuWB9351kWhKlYOWGuEJafP5PCA=; b=yXr/cY9joya4E9rUzWmaqcr4Zy
	c19EeweTxTOGumRJq+WDJtLWNfK8czJN+5NIblCFmRrRgux7uFDKKrH+1cw2xIBEFBEihgFBmhJhf
	t38rgNnz9Oa/JNTyNQw3CRdP7uqq6JSEmE3h2EbjIW3MdRBDs4IPfvnntOEC8fytwGJkmzGYNEqzl
	iR/T3YwHjQB7shygAEE57NVxVZxl8oejjtdrcRRmjHVuO1Y5BlHSs9J+gHmDYr+SKtEz62948PESi
	nOUzIKgDz/LJ0o14GXPINqgtjHYSjzEqMAoN3N7/8JKjA1gbU0asbJ9gwz4wu33JmLy3LenGdKGRy
	Ii7o+tPw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s6Rlr-0003s3-S0; Mon, 13 May 2024 11:15:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s6RlY-006Dvu-F0; Mon, 13 May 2024 11:14:40 +0200
Message-ID: <3bbea91b-5b2b-4695-bb5d-793482f05e9f@rbox.co>
Date: Mon, 13 May 2024 11:14:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: billy@starlabs.sg, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <a00d3993-c461-43f2-be6d-07259c98509a@rbox.co>
 <20240513074415.9027-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240513074415.9027-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 09:44, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Mon, 13 May 2024 08:40:34 +0200
>> What I'm talking about is the quoted above (unchanged) part in manage_oob():
>>
>> 	if (!WARN_ON_ONCE(skb_unref(skb)))
>>   		kfree_skb(skb);
> 
> Ah, I got your point, good catch!
> 
> Somehow I was thinking of new GC where alive recvq is not touched
> and lockdep would end up with false-positive.
> 
> We need to delay freeing oob_skb in that case like below.
> ...

So this not a lockdep false positive after all?

Here's my understanding: the only way manage_oob() can lead to an inverted locking
order is when the receiver socket is _not_ in gc_candidates. And when it's not
there, no risk of deadlock. What do you think?

