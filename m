Return-Path: <netdev+bounces-300050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ENJFINRDMmqvxgUAu9opvQ
	(envelope-from <netdev+bounces-300050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF2696F36
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:50:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300050-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300050-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB2830A19A3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC14D3B38B8;
	Wed, 17 Jun 2026 06:48:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0943064AE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:48:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678924; cv=none; b=cSs30IcbUcpnGDvqPrZDnjJHXtMQRgdUN7kn3chHkDIB40vVY7Z17DzAg2Z+XjRrgoxGchm2DLP9Sk1KOgXFlCcj6HUJcdEJfwBskrBhZ0/8JrpDZYkHLhvDYW/lSGyAw6Ab2ChZ39skdCnlO53/eCsl2dmmKkLD2oCnptIeT9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678924; c=relaxed/simple;
	bh=9EhSdvYnNJvk8KIBHAqKwEp2ArS/nAALopSYcQ+7Jsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYJ3y0Dl2JRhUD6pjP/1st73BI3BvFTi6U2YYTF5UP653yb54gLnkCL4L6p/dU5BT5L9Ntw1TWPKedGmWp0mV+FRAIABh/7M8p8vaL5IJn8R1MM3oMZfi1huHICO+OebSFzju+jukvXRtma62WvqCM7K1lupQ8/s175TRARePt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.175.55.52
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAA3DqM5QzJqWVmxAA--.18483S2;
	Wed, 17 Jun 2026 14:48:25 +0800 (CST)
Received: from [198.18.0.1] (unknown [39.144.124.20])
	by gateway (Coremail) with SMTP id _____wDn7+s2QzJqmf8sAA--.48457S2;
	Wed, 17 Jun 2026 14:48:24 +0800 (CST)
Message-ID: <c14e4b47-0cc0-4141-b0d8-f80633594402@hust.edu.cn>
Date: Wed, 17 Jun 2026 14:48:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: pn533: prevent division by zero in the listen
 mode timer
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, David Heidelberg <david+nfc@ixit.cz>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dan Carpenter <error27@gmail.com>, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com
References: <20260615103547.1599528-1-dddddd@hust.edu.cn>
 <20260616140209.GU712698@horms.kernel.org>
From: Yinhao Hu <dddddd@hust.edu.cn>
In-Reply-To: <20260616140209.GU712698@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrAA3DqM5QzJqWVmxAA--.18483S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw18Jr4rXr47XFWfXw48Crg_yoW5WrW5p3
	98XF1ayr4DXr4UtF4jga98W3WrZ3Z7JFW8JrWrK39rCF90gF1ftFW5ta1agF4vkrZ5Ar12
	yFW0gr98uay5AFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bxrWwUUUUU
	=
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300050-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ixit.cz,kernel.org,gmail.com,hust.edu.cn,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hust.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:david+nfc@ixit.cz,m:krzk@kernel.org,m:kuba@kernel.org,m:error27@gmail.com,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,m:david@ixit.cz,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6AF2696F36

On 6/16/26 10:02 PM, Simon Horman wrote:
> On Mon, Jun 15, 2026 at 03:35:47AM -0700, Yinhao Hu wrote:
>> The listen-mode timer handler advances the polling state machine through
>> pn533_poll_next_mod(), which computes:
>>
>> dev->poll_mod_curr = (dev->poll_mod_curr + 1) % dev->poll_mod_count;
>>
>> pn533_poll_reset_mod_list() clears dev->poll_mod_count without first
>> stopping that timer: pn533_dep_link_down() deletes no timer at all, and
>> pn533_stop_poll() uses timer_delete(), which does not wait for a handler
>> already running on another CPU. When the handler runs after the count
>> has been zeroed, it divides by zero:
>>
>> Oops: divide error: 0000 [#1] SMP
>> RIP: 0010:pn533_listen_mode_timer+0x9b/0x110
>>
>> Delete the timer synchronously in pn533_poll_reset_mod_list(), the single
>> place that clears the list, so the handler can no longer run past a reset.
>> Also return early when poll_mod_count is already zero, covering the window
>> where pn533_wq_poll() re-arms the timer just before a reset.
>>
>> Fixes: 6fbbdc16be38 ("NFC: Implement pn533 polling loop")
>> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
>> ---
>>  drivers/nfc/pn533/pn533.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
>> index d7bdbc82e2ba..88df99001b4a 100644
>> --- a/drivers/nfc/pn533/pn533.c
>> +++ b/drivers/nfc/pn533/pn533.c
>> @@ -951,6 +951,7 @@ static inline void pn533_poll_next_mod(struct pn533 *dev)
>>  
>>  static void pn533_poll_reset_mod_list(struct pn533 *dev)
>>  {
>> +	timer_delete_sync(&dev->listen_timer);
>>  	dev->poll_mod_count = 0;
>>  }
>>  
>> @@ -1235,6 +1236,10 @@ static void pn533_listen_mode_timer(struct timer_list *t)
>>  {
>>  	struct pn533 *dev = timer_container_of(dev, t, listen_timer);
>>  
>> +	/* Polling may have been stopped while the timer was pending. */
>> +	if (!dev->poll_mod_count)
>> +		return;
>> +
> 
> I am concerned that access to poll_mod_count is not synchronised and thus
> this may not work as intended.
> 

Thanks for the review.

The guard's read is lockless, but it isn't what makes the fix safe;
timer_delete_sync() is. pn533_poll_reset_mod_list() is the only place
that clears the count, and it now syncs the timer before the store, so
the handler can't be mid-pn533_poll_next_mod() when the count is zeroed.

The early return is just a backstop for a timer re-armed after that
reset, and it mirrors the existing lockless guard in
pn533_poll_complete() ahead of the other pn533_poll_next_mod() call, the
same pattern already in-tree.

If you'd still prefer the lockless accesses marked explicitly, I can add
READ_ONCE()/WRITE_ONCE() in v2.

>>  	dev->cancel_listen = 1;
>>  
>>  	pn533_poll_next_mod(dev);
>> -- 
>> 2.43.0
>>


