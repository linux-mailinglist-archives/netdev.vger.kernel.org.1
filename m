Return-Path: <netdev+bounces-280203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOpyMvW052lU/wEAu9opvQ
	(envelope-from <netdev+bounces-280203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D013543E052
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8A87301DE5A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88902BE05E;
	Tue, 21 Apr 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0YUd/O8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRlHKD0L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0842236E3
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792758; cv=none; b=k/XEk/mPbnqufvdMsy63O32ouBaP1EqSxHKzXNNfb/XjqIDs73YAMGkeHi0rW+DLvifTT3g5Q3JT5unHiCV2AgqJ0yGNHfSlktZPhcIcTM0DnC2OHDGPAjMjqBMn4J3bvHjSQLgHlCqHydHxnfVzDucL9O4A9X8WlNn/ysZd7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792758; c=relaxed/simple;
	bh=bpsjPHfEDdQEs+P2rr1e32nq9nhyKU0zqj4ANIF0BIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfhiCiejReotDvAA3VTvfoWn148niCd23QoIN9j8GRLK4VKtwgsQwzFbjYQrrBhfl9euVzky9sErJlQA6+nvwXVlzCYwbLSylrW3JE4IanTNvaAHiP1cmXMxugWcCKv0ChUU6r73k8e6PgDpeEmpkAF0GToi67AQN73Jd2oBYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0YUd/O8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRlHKD0L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776792756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmtPtPbnl4AV5j+ij+q4DGBojJ4/yQwbp4U1xRsU4aQ=;
	b=h0YUd/O8xPulR4Z9xjURbJbH4Y5TNfk0SJZMHApM2RlGN1brllARQH2oU0mWVC6tPE76Y4
	pftUU4QdqQ4BDj0+uJZ3703MK5VG56qHfdE3pCopACSfX3zLGC/9sVgEuOoFj409e24aiM
	PzUAR5Xp44Oj4DwiVnOsWgH0XoaA1t4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-A6BQxp14NqSZq5d62UpIlw-1; Tue, 21 Apr 2026 13:32:35 -0400
X-MC-Unique: A6BQxp14NqSZq5d62UpIlw-1
X-Mimecast-MFC-AGG-ID: A6BQxp14NqSZq5d62UpIlw_1776792754
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b241be0126so90135765ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776792754; x=1777397554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmtPtPbnl4AV5j+ij+q4DGBojJ4/yQwbp4U1xRsU4aQ=;
        b=IRlHKD0LMefk/LJIqnJ1s5fRe9KBRe7xBLCFNZGtoIrmtWOm2txZErVKw+kIDqmigP
         0Izi4vjbi6REu947yViohYnVewJ6XLyDrur1I/lhtVV7syWDjpB9PldNH28IWHClQjAD
         2JYtxyOSoW4nL1LY9OHlZliNnFw64cDzUuWUXnX/BxowENdkcydNm9POoTkB9SEITzjb
         J/p7Nk9kmC8QRaBwJikHdc4yziZVGg+MKu7mj26GEjsoueuQFPaZF64a0bTXnaxooD+F
         jeWH8nWNSAY2hCUXg/8kCzGpQvVyDPgse9keOeJlblMxrWhoJBl2Ll/Gg0XVnom0RkBt
         rSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792754; x=1777397554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmtPtPbnl4AV5j+ij+q4DGBojJ4/yQwbp4U1xRsU4aQ=;
        b=f4PCT4QbkbG/6tnsXVAB0bDil8JtnecubXAj61pnRDd5GlWxG6uo69Sh55kyuQu3KA
         DGJCHKJ/Pwf91o86BwhXePJn1t4pSx5hR852TKjcowV9wMdE8YpM+fTR06LqH/XPGgJg
         tMpAgJpoZM+rvsXgqpE9gbB7IgCBNVRomc5wa395+oEWdyLhn3ikGkQVuOIUXzPL0p9u
         ZjYjT6GmxRqCL1jfYMuVUinfLS3xYRAWeU7r8ywMR5+gX/S0bDr0h77GjbAo/KqYCVLF
         D9UovZFOqc0UWI+JMEh8+LJ2v8pqaRrnN1q8ZN6syOTxaBh4V7Cs53ZO0IlZC0J15T+7
         6IRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IGjcoA42S11WLk9fIEyDPdTUtlEVDg6zC+TSXQQfL4FSjgiGg7XbEi0afFdE0U9jCGgUG4dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiL/8SdNQXNbJ9/+hEsGT67VKFL9kTQ3Za1WAaz/vlpVxfxM9F
	B0vX1wqcz3MLyWQ/78GSX4HBJt/6gV00UV6iy9YseNlQNyevNp4ZG0U/g8KMDWvmFeRYgHnIF9+
	uxEpb9JqIuL+xDxS/NlaL4nUST+3SdeqTifZ/VHBvfOPqMHCLwhYcvu8tpQ==
X-Gm-Gg: AeBDievHHIiU70h9hleNSyQY3y5uaCHDBtKTkpVErE3jOw4dDkyI5PzOvgqnPWstUKK
	jiSyYcODP0DyNE4sYttFxZhk9IEbp0J8SqfS6WQSP//3MdRRI/1g/v727Plv/7MzDHn0mTVhOqJ
	wLDBen9QXbhPuagxgUBv05hyCUmTy03ypWwiAq01Ptz1W3EWarfmnSTi4RwAkAsOr6iNNPMUgKL
	Bn6RdvlfCi9SgQwF7xsot+3iYC8IabUBzVvbqguEy8O6ywZF1vW3MKcwlQTeWIHXhnSL+6vLkgB
	8AH5DexHiN0kjmZb2A3nho0oZY7nGJ6YZGb4apLDUHBGljNT/qjih4B3mADZHD8VQKur0/XeFd/
	1JV50ADeCO0QdU4WouG+bOsiqvxlrZ6MF+dVnXdsGt6C1rqOFMUVo+IaEIXI5kULBTRY=
X-Received: by 2002:a17:903:b4f:b0:2b2:ae89:fd44 with SMTP id d9443c01a7336-2b5f9eaf3d6mr212359675ad.6.1776792753282;
        Tue, 21 Apr 2026 10:32:33 -0700 (PDT)
X-Received: by 2002:a17:903:b4f:b0:2b2:ae89:fd44 with SMTP id d9443c01a7336-2b5f9eaf3d6mr212359275ad.6.1776792752543;
        Tue, 21 Apr 2026 10:32:32 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm175412135ad.7.2026.04.21.10.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:32:31 -0700 (PDT)
Message-ID: <b9d1e3b6-ad3c-4bdc-98aa-2e00a2937585@redhat.com>
Date: Tue, 21 Apr 2026 19:32:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
 <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-2-e04bcc2c9642@kernel.org>
 <210f5d0b-6232-4c0f-adff-3a97d54159b3@redhat.com>
 <aeewoVjN7EHLZTW_@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aeewoVjN7EHLZTW_@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280203-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D013543E052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 7:15 PM, Lorenzo Bianconi wrote:
>> On 4/17/26 8:36 AM, Lorenzo Bianconi wrote:
>>> @@ -1055,8 +1058,33 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
>>>  		e->dma_addr = 0;
>>>  		e->skb = NULL;
>>>  		list_add_tail(&e->list, &q->tx_list);
>>> +
>>> +		/* Reset DMA descriptor */
>>> +		WRITE_ONCE(desc->ctrl, 0);
>>> +		WRITE_ONCE(desc->addr, 0);
>>> +		WRITE_ONCE(desc->data, 0);
>>> +		WRITE_ONCE(desc->msg0, 0);
>>> +		WRITE_ONCE(desc->msg1, 0);
>>> +		WRITE_ONCE(desc->msg2, 0);
>>
>> Sashiko has some complains on this patch that look legit to me.
>>
>> Also the pre-existing issues mentioned WRT patch 1/2 makes such patch
>> IMHO almost ineffective, I think you should address them in the same series.
>>
>> Note that you should have commented on sashiko review on the ML, it
>> would have saved a significant amount of time on us.
> 
> Since this series is marked as 'Changes Requested', it is not clear to me what
> next steps are. I guess we have two possible approach here:
> 
> 1) - Post patch 1/2 ("net: airoha: Move ndesc initialization at
>      end of airoha_qdma_init_tx()") with the series available upstream
>      (not merged yet) in [0] where I am fixing similar issues for
>      airoha_qdma_init_rx_queue() and airoha_qdma_tx_irq_init().
>    - Post patch 2/2 ("net: airoha: Add missing bits in
>      airoha_qdma_cleanup_tx_queue()") with a fix for airoha_ndo_stop() waiting
>      for TX/RX DMA engine to complete before running
>      airoha_qdma_cleanup_tx_queue().
> 
> 2) - Since all the issues rised by Sashiko are not strictly related to this
>      series and they are already fixed in pending patches, just apply the fixes
>      separately without the needs to repost this series.

Given the current flood on the ML I think option 2 could be the better.
Note that the tree is currently in Jakub's hands and he can very legitly
disagree.

/P


