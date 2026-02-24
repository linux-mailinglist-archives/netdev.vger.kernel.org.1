Return-Path: <netdev+bounces-260447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDvcJP98nWk1QQQAu9opvQ
	(envelope-from <netdev+bounces-260447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2E18550D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ACDA3003BD6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40406377556;
	Tue, 24 Feb 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecLhR61Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ab04KmOf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C141428F4
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928825; cv=none; b=NdpU6AtkZ+K9GzmEHuEhOLtEmGdqPdm0qut0z/sV+XB2Ch0Ti85gx0hRIwgUFh3MhRCmV+SwAiUgD0S8sAgOuWY17UhEBCHWckFvP+3pkwGkD/v0jh/0gxwYt0nlFe8NVzPjKWwFk0W2Q1B/ImTOW96E8mOR4+yWDQr2U07ly40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928825; c=relaxed/simple;
	bh=wTne68v2nDFhFg4/7AEfyvEfbzI82g7vxXOQAOPtvus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSG2F/O3/7spZPcHXWDjes7tqYk9kjjTkYwcF41DguouKKqxEQ142PqnBUn34G2+Xga53r/Uc1imur5ndAimd5n4lkkKGMWlX96j8NLDj/vMwv+V1Apf60rhPsktDulCDa+yYGM6kvTYKbDza94AZVjr8K4Ik0C4StHbrUqj+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecLhR61Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ab04KmOf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771928823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaoQvsa8iJzkxn1rUG/TO1E0ZCh1w3NUEqJN02Z3AJI=;
	b=ecLhR61YIgG4P849HBnBeOJ6kADxSJXBniMSyiI+rh99GP7Yh/RrxLgjoU6HjbcRqQZIX0
	VZ9LEtByjS8u2QL6SxYEV/hS60NOKw5gtCybj5kNv9AJMYcCo2T9T1LtTa99Cnd2pMSAh5
	Otv8h4dmhr62/lIl/DvfAjuvZrKntGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-C3aMsM-SOauZe84YKr91jg-1; Tue, 24 Feb 2026 05:27:01 -0500
X-MC-Unique: C3aMsM-SOauZe84YKr91jg-1
X-Mimecast-MFC-AGG-ID: C3aMsM-SOauZe84YKr91jg_1771928820
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48079ae1001so21256685e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771928820; x=1772533620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaoQvsa8iJzkxn1rUG/TO1E0ZCh1w3NUEqJN02Z3AJI=;
        b=Ab04KmOfCFTn2P1NWgxkl7xYdNWOEhvk6ZPI2ro52DnNfV6B7K11hsFnkQbPOfMHDA
         hOI11kjRcZWaLCWEn9IBlf+eK/DPOwcgkDieIM4e4uTIZUY1qrOqEBQrqj13z6XlkJKA
         0TVaZT2ck2UvY6ujTom49dFpti5ZI/ttcyGWAfnKMruXt7pj0r3Ar9zOsEM98qIt7TGj
         xDUFwYX4d3+5cIgP0Cta6Gd91lIBiZeEaK1wvGmzqCBg4pjKELKsrUi19f83q+EMGT/b
         8LSEFDKdMUIG5FSvVmMm62od7PQNajyB4f889ioz7ccUzQeyy5UuXsQo83VKlNBPXRYo
         RUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928820; x=1772533620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaoQvsa8iJzkxn1rUG/TO1E0ZCh1w3NUEqJN02Z3AJI=;
        b=azr8RUvN27wUBZw8Ted/na0A3Oo6RlSH9zfpQNM1a3gMv9m/5dcTG/8kpm/UvW0xQO
         GU+zKNJFGklq1RGCRxzQ170KVyv68oNPW+kmdf7n6Z+mT21Y5bnsDS4uVctEHCzXVLmd
         mTDqfHSrQFbrnzSLlu6XfN62IjYgkBYrH925RBhz6vR09jC+PrMogkfACDuQP1/m1V6X
         OQsiRg9JgDiCm35cP0KNhQfxjJp9ZEKY6CE+OfGErbL1QKOGRFFehnvuUZtmD8ejaQcz
         +wJN8j4QhvV/9yglt8dnMPLvnkcBjCwYWgRCx7lWhuuqfS6+PirTnoYtY9qmg0BKI2wN
         hdfw==
X-Forwarded-Encrypted: i=1; AJvYcCXEfX4xLsE5vXEOL/bkqKKViZHC2KHZUsJtvtfMzG7q6FKTQGM2M/d8ct6/KbiX6aEIwPG5Xws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiWk0gafLY55SXoYK3+tNNT7YsHhdkItgStKe0gjRqGFdSMac
	Hg8ttXhIV7n7yPj3L7EzxlZG0mAwIJrg1SWQG0GLJ6ANpsyBVqFn5zM2W8/8K0mY5hv12uGJuhm
	5Dx3ufKXWG7jjhNZPAqdMEpiKk0Xj+zQ6YsAJljvRFf06HKJupSKzToDYjA==
X-Gm-Gg: AZuq6aJegN8+qy72rCiYBNm30f2VJdj8BIbUhqHqDpNrujilzdRSCXvrPWCVJ1eSF8D
	SsvZW8z0HTnNG1rZWIm0Vfv1BLuGGIFL47xQqjaII4q/cGBakqUzzoNcBthgIne/UWLkAF3+7hO
	dUMmdq3/LY8z4Hh3JhvotZvRbcX6dwy19wHEePSZgkFNuDCBv4Au2coSx2k7qQhhiJ5NuTLR7DJ
	T+RW5CcFHxFn4kqYrXVquwbV6HJZQ2O0Y6qpxFxd08tbMdOzvMerMwdb+3wX6zzdCvXgaG3zMy/
	Cy2AzWynm1KCxmbYeX53c2duMhdAPSIB60cLcU8/xUb1CC7KoyY8uiuT1RM3v0Y5eru+lcuYriI
	qRlV6nv2ZzgPCiFcS1lNX
X-Received: by 2002:a05:600c:8717:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-483a9635abbmr158190535e9.26.1771928819997;
        Tue, 24 Feb 2026 02:26:59 -0800 (PST)
X-Received: by 2002:a05:600c:8717:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-483a9635abbmr158190265e9.26.1771928819593;
        Tue, 24 Feb 2026 02:26:59 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b88ead80sm33222605e9.2.2026.02.24.02.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 02:26:58 -0800 (PST)
Message-ID: <55b24261-45cb-41f1-857f-f29527a1ee8d@redhat.com>
Date: Tue, 24 Feb 2026 11:26:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Kurt Kanzenbach
 <kurt@linutronix.de>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>
References: <20260220183858.N4ERjFW6@linutronix.de>
 <20260220132932.1ed45656@kernel.org>
 <willemdebruijn.kernel.85c1623c5d65@gmail.com>
 <20260220140241.51be1e30@kernel.org> <20260223170750.q5nhbkSe@linutronix.de>
 <20260223152738.7e8e95fb@kernel.org>
 <CANn89iLcbysm43F7RPH87vjQBrswT4GNNwJ+ySGF7mhPsThr0w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLcbysm43F7RPH87vjQBrswT4GNNwJ+ySGF7mhPsThr0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-260447-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDD2E18550D
X-Rspamd-Action: no action

On 2/24/26 10:02 AM, Eric Dumazet wrote:
> On Tue, Feb 24, 2026 at 12:27 AM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Mon, 23 Feb 2026 18:07:50 +0100 Sebastian Andrzej Siewior wrote:
>>> How do we move forward? Merge this, backport stable and then convert
>>> in-tree user away from IRQ delivery _or_ fix the driver one by one and
>>> backport them stable? Or…
>>
>> If we plan to convert in-tree users away from IRQ delivery I'd do that
>> directly, without applying this patch. But I'll let Paolo have the final
>> word. Eric's review tag seems to indicate to me that he disagrees.
> 
> This patch is orthogonal and will reduce cpu costs for NAPI drivers ?

I find this point rater convincing: we will have this code regardless of
the fix tag.

/P



