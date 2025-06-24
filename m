Return-Path: <netdev+bounces-200639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC9AE66B3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B09F164E58
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761682C08B2;
	Tue, 24 Jun 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IrQPB/Gm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzJAEeYg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02C6F06B;
	Tue, 24 Jun 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772338; cv=none; b=j6c1Eyozz/pOTJErQoLv0U3cpNpVAJhpxXhNAhyJq+uOxbPQbDLV0F5+EhImUURczjiq6fSBAFN3i/ZFE/JLMcqTq+bp/115TXIalSt+iTxYlUKdY0wzBDOPu27JMuFQkh+AuTbZnYqUC/Z0wvwcxOOGsyp5ZWrpHmNIwByfxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772338; c=relaxed/simple;
	bh=+CYvnD4VZo92BHf+lotr3uGNvnEFQ0fqvQqcmJ6UY4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RecmCOyK8oK8lISKbQC1wgzbj6IatXntUcoyLOWJWgIT9kmMv77FLSaq/jbtHVpKyFu7fphC+gaKn+/3K3XWMRZV7t0V8z4N4+iWOEErVnGptlcAyNclo2V75cvL7a2DfqNt2uqJbKhUmRU6tlhFtmwexH2SuioynE5+4i2TGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IrQPB/Gm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xzJAEeYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750772335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCDk8KX5+PBclq+nUZ+ex/H03LE8E5BREomDxlJChvc=;
	b=IrQPB/GmHQsMGNTzcNmUUhFk4yTj/dKVsQHBg9dQNySj4fF6ynFd41NrA79w3iIPvy2hzL
	axJjpJjiKE6mgoZs74pZjh7txY9sndUq3wvGW+0CS3KGhS7TSB4nh16hsg3f6jIjDG9srS
	lkyU6kehE/oVIuXI59A5bXCO74qgE7QSuG4zyM7GB9zmhUVJ46nWkN0/E6Tex78XTzqpiq
	VqEk7O7DXiSp8oTt+vLy5W3H1/6BKV6NEScCxjMwCAX5Fju2QZOdMesI3ND2Rk8pRbA5pq
	gSgffFkntoiMr6LEi4kw3dqOr+jq/ueohzTs57VTL5eSA61+t9MkC7LgCviP+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750772335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCDk8KX5+PBclq+nUZ+ex/H03LE8E5BREomDxlJChvc=;
	b=xzJAEeYg1EVE4sI6JnnUc14M/MbT2lWk36NtEibG3B+N3tSNykCpvYfkKw/auMjvuSmiKQ
	aDr0rhuzV3NpNBCQ==
To: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 13/13] ptp: Convert ptp_open/read() to __free()
In-Reply-To: <287fc833-a643-40d3-b663-72446e1344f5@redhat.com>
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.533741574@linutronix.de>
 <287fc833-a643-40d3-b663-72446e1344f5@redhat.com>
Date: Tue, 24 Jun 2025 15:38:54 +0200
Message-ID: <8734bpntsh.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 24 2025 at 11:48, Paolo Abeni wrote:
> On 6/20/25 3:24 PM, Thomas Gleixner wrote:
>>  	scoped_guard(spinlock_irq, &queue->lock) {
>> -		size_t qcnt = queue_cnt(queue);
>> -
>> -		if (cnt > qcnt)
>> -			cnt = qcnt;
>> +		size_t qcnt = min((size_t)queue_cnt(queue), cnt / sizeof(*event));
>>  
>> -		for (size_t i = 0; i < cnt; i++) {
>> +		for (size_t i = 0; i < qcnt; i++) {
>>  			event[i] = queue->buf[queue->head];
>>  			/* Paired with READ_ONCE() in queue_cnt() */
>>  			WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
>>  		}
>>  	}
>>  
>> -	cnt = cnt * sizeof(struct ptp_extts_event);
>> -
>> -	result = cnt;
>> -	if (copy_to_user(buf, event, cnt)) {
>> -		result = -EFAULT;
>> -		goto free_event;
>> -	}
>> -
>> -free_event:
>> -	kfree(event);
>> -exit:
>> -	return result;
>> +	return copy_to_user(buf, event, cnt) ? -EFAULT : cnt;
>>  }
>
> I'm likely low on coffee, but it looks like the above code is now
> returning the original amount of provided events, while the existing
> code returns the value bounded to the number of queue events.

Duh. Indeed. Well spotted.

Thanks,

        tglx


