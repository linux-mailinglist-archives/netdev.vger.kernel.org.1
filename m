Return-Path: <netdev+bounces-258989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kp1FUwtlGmdAQIAu9opvQ
	(envelope-from <netdev+bounces-258989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:56:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABBC14A203
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3FB0302867B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C92EA172;
	Tue, 17 Feb 2026 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUkVfFwj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eW/Tjl+M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F262F260C
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318572; cv=none; b=K3m4JXxXLUQPBy5sMkBVGaMhSgLSgTKOFiCueu2UAv7CL/KqTIfjxgltzoFxRqmvRSJrwWRJRoy+KcHRYj7IXR5p2s2DfB6K4ZCRlHKGNX1ZGuSXRBtShud6pLPA8hT9/13kgswSmLsQ6OacHkaTOIx97ohbCRpu89vwmdpezoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318572; c=relaxed/simple;
	bh=Xl8vU02FQuUG6TRf0v5tTiVaO/OQQXOZXKiqrnEce/U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tqdfbFVO9KMIZ+3N7ocN93NBnRNa46+Sh/G2O0bR/8JdFJjc05XmJGr4bQS/yOKw+G0fFxNjWLWaCZ1K3dSF1d2LV+zgYsD52PitE2x6y8ZUxyngnBtEiyYqlf1ERvSaB1JuUP+ftFGutZQzAIpAylHwezibjabv/ulY/6//Y5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUkVfFwj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eW/Tjl+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771318570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeqDASRJlcgXUCGyq3VQ0ULXt0d2kVFCeY+6VKAR6oU=;
	b=BUkVfFwjKiTqEeLJkkM49ffQ1uE7k9ww0ozz14wMWOFVNr7nTsRSkK1L5wk2tHVneR6HqJ
	aMTZUFk1NVeryUlPDov5B0kJhP+L56HOMtqeScrBxBWQd0DG7dQr+WFrLyq+G61jI6N7tw
	IiWinITatMqG1Fa/L3CbK/xFuK1swbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-zoyNe9YkN6CkdLen6DOHFA-1; Tue, 17 Feb 2026 03:56:08 -0500
X-MC-Unique: zoyNe9YkN6CkdLen6DOHFA-1
X-Mimecast-MFC-AGG-ID: zoyNe9YkN6CkdLen6DOHFA_1771318567
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso27430925e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771318567; x=1771923367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TeqDASRJlcgXUCGyq3VQ0ULXt0d2kVFCeY+6VKAR6oU=;
        b=eW/Tjl+MX2BWYUk4dal03d9HmCltvZo5jetOxi8jhSEwULevPEimiugdhy1/ZaqPsM
         06B/jj7cLgcNuZ5W6W0c4tJ4wBOayA71JRrLVHNTXOr9S7fCMQQ2RR3DAXJrNSTtDy3f
         k5zeaRzdMHtaOb5dnSmzSv4kShC32fPkpSTnahm8vk4Mezp5BnzvPXBKq+wehm7gfhC3
         LxbBNWaLbK3RTyS0IIxs0worffrxTYLdBetvdypz0hJlvqp9NqFgX22suULAMJqo14zg
         pqyWFAA1o3bIvUavoxRRpT79sjhNIkL8GdWAXBEJnLe0ycx9tKBHP+ZmXR9mmoaUDCba
         0cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318567; x=1771923367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeqDASRJlcgXUCGyq3VQ0ULXt0d2kVFCeY+6VKAR6oU=;
        b=PjgNr80vwXu/y57SAbt2bF5RBi5DG7pAI7VyQeQ+Y9TCw09EzYw7lAIxdNcQteGqNH
         j2rrdEwKTKDxCaGl4mMI3SryMPXYcqDP0Nm36mGha6jHoQYugropdfQvdizHWMpeFtxI
         FrBNRcmJpwH2fOf2dqMwS6bRLzN98H5Jp5AxT3fc/NMUq/d6nLnHIbIrtVwUUXwPAorL
         eBquRfIHZMbWe1RfvjMHFOK2u2WCuK+hKawQJ51pIO0fh2SMY8Gb4Sna5PEuCIxfSYD6
         2eLi31pCxE025FsvE7Y1NN1BNKnXe8j0VPHZQ2KGCDhv8y1GqTwgzx0j3m6oO85cCDzx
         l/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUAzf/hQdCnA51egmboDWFH7R8Xe0LtdXVs0lhSPji/wC3uk9w9FrJur8jH1EOWjl8yIB8hXdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2LhJ6DxDRwgfY0NJJZx+z0tcnhjSZwMhYdSS7d6GdpfRCPvy
	QeP5iJMy77/D+NaBvucoYKsZrmGl3ji+eXdCknTX0zjoS/ju6mmEMjRMuWKuDwDmsNIu2/USGfY
	QKl7442I9SiT55OClP3TlhbeGsVfnZVQDNXQcSEeU0esWBdYQuE6pC8GJlw==
X-Gm-Gg: AZuq6aKcemerZ2WcyWFB7Et5AKbk77ADYXqxpugQ/CcDIL92twlkP+YahH2ptezIZCa
	ey4XS1AZeMp21Hct47HfIPb0ldbYwCIoAf10NUoXLDRUASvOj9eo+TSNjZU3OshYAJVjDQoRvIq
	dnkWrj5pRwwy8xTQJLS9brENthTErNiHNMMehlDGhFPL9bLbEfL47CyK2CZ7daup63RCQkveewU
	0WZg8q+7be2ec/idQtYKrAVRfXfRn9mbhwtlwf2fBC0K0H3tGaUIfNOOlIfPaqycuJ+FluvZEJV
	0EqFos6A9Zko6rKJwNqKlRo+vUDvyDEQJMeAc7s12Ck5+iNQw4hIOYwr/ylNSubfUI/3CVCPwUV
	XjtkOaeFrsQKWCnQMg78UhNffIA==
X-Received: by 2002:a05:600c:3b93:b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-48373a02c73mr260469425e9.10.1771318567391;
        Tue, 17 Feb 2026 00:56:07 -0800 (PST)
X-Received: by 2002:a05:600c:3b93:b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-48373a02c73mr260469135e9.10.1771318566972;
        Tue, 17 Feb 2026 00:56:06 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm33443288f8f.26.2026.02.17.00.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 00:56:06 -0800 (PST)
Message-ID: <65665dd2-90ee-4f52-9238-55ef79832967@redhat.com>
Date: Tue, 17 Feb 2026 09:56:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: kaweth: remove TX queue manipulation in
 kaweth_set_rx_mode
From: Paolo Abeni <pabeni@redhat.com>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu>
 <d697a88f-dd8c-4ec1-ae4d-c97578a98498@lunn.ch>
 <CAMFT1=bFkHFsh-3U+Ca7Dey1mzPdz0rpQweCLmXFrattwZ_uMw@mail.gmail.com>
 <119e20b9-4ecd-480d-b629-1c57b2088a41@redhat.com>
Content-Language: en-US
In-Reply-To: <119e20b9-4ecd-480d-b629-1c57b2088a41@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258989-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ABBC14A203
X-Rspamd-Action: no action

On 2/17/26 9:50 AM, Paolo Abeni wrote:
> On 2/9/26 6:48 PM, Ziyi Guo wrote:
>> On Mon, Feb 9, 2026 at 7:56 AM Andrew Lunn <andrew@lunn.ch> wrote:
>>>
>>> I think there needs to be a better explanation why it is safe to
>>> remove these stop and wake queue operations. r8152 does the same. Is
>>> it also broken? Rather than removing these, should we actually be
>>> waiting for the completion of the urb?
>>>
>>>         Andrew
>>
>> Hi Andrew,
>>
>> Thank you for your time and email, here is my understanding (correct
>> me if I'm wrong).
>>
>> I think ndo_set_rx_mode runs in atomic context with a spinlock held,
>> if we wait for the completion, this would sleep under a spinlock.
>>
>> And it seems the architecture of r8152 is different from kaweth and
>> rtl8150. In r8152, the ndo_set_rx_mode callback (rtl8152_set_rx_mode)
>> won't directly call netif_stop_queue/netif_wake_queue. It only sets a
>> flag and schedules delayed work.
>> The function that does call netif_stop_queue/netif_wake_queue is
>> _rtl8152_set_rx_mode(), which runs from the work handler
>> rtl_work_func_t() under tp->control mutex, not from the ndo callback
>> under netif_addr_lock_bh.
>> Also, r8152's start_xmit never submits URBs directly. It only queues
>> SKBs to a software queue. Actual URB submission happens in a separate
>> tasklet using a pool of 4 independent TX aggregation buffers, each
>> with its own URB.
>>
>> So even if netif_wake_queue() triggers start_xmit, it just adds an SKB
>> to the software queue, no URB is touched, and no double-submission can
>> occur.
>>
>> In kaweth and rtl8150, start_xmit calls usb_submit_urb() directly on a
>> single shared tx_urb, so the netif_wake_queue() from the ndo callback
>> causes the stack to call start_xmit while that URB is still in-flight.
> 
> It looks like kaweth_set_rx_mode() is already functionally broken: the
> real set_rx_mode action is performed by kaweth_async_set_rx_mode, which
> in turn is not a no-op only at ndo_open() time.
> 
> So this looks safe to me.

@Ziyi Guo: I'm sorry I'm low on coffee and I did not notice a couple of
relevant things. This needs a fixes tag. Also please specify the target
tree ('net' in this case) on re-submit.

Thanks!

Paolo


