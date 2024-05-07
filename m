Return-Path: <netdev+bounces-94247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0508BEC3F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 21:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E703B284963
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00EE16DEC3;
	Tue,  7 May 2024 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VZAU9o5v"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E115B0FC
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108739; cv=none; b=FY4FLhpQcKIIslaT230Ru6G9qcSSAHxFy0UxGWJmR+7iJYlvZtCSikkbyhbpn0xTYyQOUnJRR/IJOTHW4bQ8VZgxg/3RicYZZVaxRONAPmG/SF6K+4HwjS9U4Mtab0YPltRinQTmng0hEoVaZDBFBa0CzW0eopenmpcAXzgKBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108739; c=relaxed/simple;
	bh=HfUHSMhfC2GMIDnc1btJgQSOtB9g9DB5VDsItm/cMzM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eZFFj+OHCVswWNqvEwQztY9ErpEG82VUORXiBx8EmnrVSa9q7giFgXiLzdcW772So1NXoHRCRK2vEON0ffPr+yYc9atMtjRzshypAlm/+13n2eY/kxlhrjS4wxUpQnBo3lc1yX7Y1AtOz16WlqOftUsvEkqqvpxol724ypaMHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VZAU9o5v; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s4Q81-00EOY0-Pq; Tue, 07 May 2024 21:05:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=G34FhpurWnGMdGKs3TakH9ftdjo8C+puRcBLwQgloeU=; b=VZAU9o5vSMO9/BAFflM5G2o1Oa
	qB4Ehs5g9lUYB9fcRD/t0UC6Gi6NsHrwZ7nFaZQVovcnSc5ZQaWOhKl3VACg0NytBnBhleHil3Wcv
	MacPNw0QuavoB/HTEJlj17fPJ+OgMJ5Xonre0eKgWKmyqHIgwrBa4QUelHMKoNVBkr3E6AK6vAb6X
	ZAV8Fn3LmOrvvBKKwzlfm7TN322enx6RWMS66zFkgW/HH2WiqQIUXpEf2e5ZNGXFzY+n+Z71WGopa
	RPPmR4wj3bhe05eQqVlTO3UEiRU/pMlDOvphu1ACjtlG6b2t6WagYWEeTeDksCB6VnzPWS9vRbdwV
	KsX7R1eQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s4Q80-0004IY-4L; Tue, 07 May 2024 21:05:28 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s4Q7l-0034og-Ls; Tue, 07 May 2024 21:05:13 +0200
Message-ID: <a8cfc1ce-4ab5-4738-846c-73084b621b9f@rbox.co>
Date: Tue, 7 May 2024 21:05:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next] af_unix: Fix garbage collector racing against
 send() MSG_OOB
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20240507163653.1131444-1-mhal@rbox.co>
 <20240507172606.85532-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240507172606.85532-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/24 19:26, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Tue,  7 May 2024 18:29:33 +0200>>
>> ...
>> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
>> index d76450133e4f..f2098653aef8 100644
>> --- a/net/unix/garbage.c
>> +++ b/net/unix/garbage.c
>> @@ -357,11 +357,10 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
>>  		u = edge->predecessor;
>>  		queue = &u->sk.sk_receive_queue;
>>  
>> -		spin_lock(&queue->lock);
>> -
>>  		if (u->sk.sk_state == TCP_LISTEN) {
>>  			struct sk_buff *skb;
>>  
>> +			spin_lock(&queue->lock);
>>  			skb_queue_walk(queue, skb) {
>>  				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
>>  
>> @@ -370,18 +369,21 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
>>  				skb_queue_splice_init(embryo_queue, hitlist);
>>  				spin_unlock(&embryo_queue->lock);
>>  			}
>> +			spin_unlock(&queue->lock);
>>  		} else {
>> +			spin_lock(&queue->lock);
>>  			skb_queue_splice_init(queue, hitlist);
>> +			spin_unlock(&queue->lock);
>>  
>>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>> +			unix_state_lock_nested(&u->sk, U_LOCK_GC_OOB);
> 
> I've just noticed you posted a similar patch to the same issue :)
> https://lore.kernel.org/netdev/20240507170018.83385-1-kuniyu@amazon.com/

Yeah, I'm really sorry for the noise. I'm not on netdev and haven't seen
your patch :(

> But we cannot acquire unix_state_lock() here for receiver sockets
> (listener is ok) because unix_(add|remove|update)_edges() takes
> unix_state_lock() first and then unix_gc_lock.
> 
> So, we need to avoid the race by updating oob_skb under recvq lock
> in queue_oob().

Arrgh, sure, now I get it. Thanks!

Michal

