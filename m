Return-Path: <netdev+bounces-249424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3AD18A3A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 449AF30155DE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44D38E13E;
	Tue, 13 Jan 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPZTjifV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYjL3mBh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA82BE7D6
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306192; cv=none; b=lnUY5SrRmumW44mzdcgqIELHU731HemoqfGfPZ3qzyAS//VB7c9tHmSWg0pJlpBLqPBWs6HeVm1RIrY0JBa5q7dYYqsKtt/StV3vrwHBfeurTzBq5+E9pqfgYcMJLxhipeDUlJ58Rcoj5+lWUnT2YI2dBQbXxTHG2ocXwjjQ+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306192; c=relaxed/simple;
	bh=FOyIQHUl4fbCHcsoPOztRQ8Gbk8nvysXb5RItoObpWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJDm+vEPPCoDKTbQrWT0EMaULRCAHTS1erLYazwbbGgy6uqfRTsPjnuRZy2IYNhSVj5Wgm+o57067TBb+EzOX6+dX4lvtckxRsKL2OIQcnAUroomG93IqIs8On3d7x8s9AlJmR894HbPefblBf4UwuPPOqZkExSooaKMrHcaD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPZTjifV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYjL3mBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768306190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsGcz1WvRRNjaeiS8L2jAs44Dq1ERVZgiS9YT2RR8qE=;
	b=bPZTjifVP+d1diN3DS88PLkz+Fxj8RfgR1n4RR5ELvvGgzovKtYlEavdXoY4VL7v3ygfLe
	tKvrVI39Hx+DdSmE9eqEYby19fn3s0Qm4hegAvSE2jzKBZe/DGMkTU/Nxgn/87jKckxA2+
	/lC19Bt3N4xjY5MEXJ3aI9gKzG1PFm0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-IuJvHpBxNuOEuA8q-4rDqw-1; Tue, 13 Jan 2026 07:09:49 -0500
X-MC-Unique: IuJvHpBxNuOEuA8q-4rDqw-1
X-Mimecast-MFC-AGG-ID: IuJvHpBxNuOEuA8q-4rDqw_1768306188
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso65125855e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768306188; x=1768910988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsGcz1WvRRNjaeiS8L2jAs44Dq1ERVZgiS9YT2RR8qE=;
        b=ZYjL3mBh7xGNgKFDW04/ZK8hTDoTtzhKnE7XG9z1Cgv2t8jSF80/1GoG6BVslmWlWU
         LREtawf4HIukG1BSCb6bP8yPvLx3zZ0b8l+DLyiFY5nL6YI3acNkfahwpRQsxZVpEHtx
         0TxdUNM3nYupd042UBW3JvsotV1nNIP9Y9SJPwH1qhKzy+p0Xsi2zRePFe7f0bUw5LJB
         xLRK5FE3thYI1uA1ML8LFF8HcB19KLCRCL5e6vn+DJEB7ryxl7fuKQyAZ8qHSjtuZBog
         rRXqPPAfbqXJPQi3TuWxrCHvD78j0Ezauetg3DxC5gAPSfwXy3wY9V6EhrlkBEvZ8b4g
         gLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306188; x=1768910988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsGcz1WvRRNjaeiS8L2jAs44Dq1ERVZgiS9YT2RR8qE=;
        b=O4jReRXI/zJ/zTNqyzlycrOtVc6NdslyXoblGOMWrs3rL3rDVZoijeg4XUjwffXnC5
         XArfJcNzhhG5eu04Ell9jfwfCyZDvZT1rp0rqOuKt2ssNfxPq9tUR4DQXMh9aA9+bho6
         st3wt1B4AvMFhHhLgD/jKtQj2VzPPubStfMcbL6xfEqJcW4UDVB+OFwFjrMNvSB7Erxk
         kJU9MdIJ/EIXPCEI4YNSMa1ECRC2mJPyq/TS2IwrfsX4pa4FWB6+VBgoj5YIl6NQC9cv
         mt9nJedmXIkJkEkvixehP5s6SJoyN+DQJwhUlmjX617PehI6IihTIeWpe2KN1Dmcpy9X
         7pcw==
X-Gm-Message-State: AOJu0Ywh2ZErZ/lOvFeFI+tEM6J/wlS9Rb/WnuFE6q0kxHsGJyzH0f4R
	0g5TWi3ZUbQ25si0neHazMbkXNDqxPvb24Gwft5WOY2iMgeuqpssErWfwrgdOdV4fTB28wX2gK/
	PF1qs6WaRsZjfqRwiS6RPwV3+ZO9a0JNHd/ddn4TYAyWMzwX2XFVxuZdIlQ==
X-Gm-Gg: AY/fxX7yvI1D6YV5kfpOwwmERNoC3lXVeScT1OUH/Gy0al2zKWRKrX55ZB2+ZZdLw5j
	o7UNjuMFcWechJ8/XaYMIFOyVFdyBFm3WhzP1PtOz4TwoSVpnaL/pUVob5Gr0AvkEIRbT8HOdAM
	Eh0eI6DSRz+11/rJJVa48wDfmSud2FMsAA1EcVSAgRIagPtaKoeB13BCmH/btmjVn+4QXeu97Sq
	njSnt3nTddhoBVQCAPYsTha5X2DQkYM7b+ac8s4ErzZUD0UjNxq5p8NaVPHZsKGly3RgiaQAN1d
	hKNQMs9+5Rq4spg7yNeq1eKv4bxkroeWQ4k9cOGs9KBzR71r/O2uag8sRD6R1IbiHpLjZeGOcmv
	hM5FL/ZbKxU8N
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47d84b3baa1mr178881755e9.20.1768306188264;
        Tue, 13 Jan 2026 04:09:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbuQTgjpKPcD3xlT3gcWAoP5ISZy4bXMwf1kvmiWmEM/sGrJ6JqtEl7Khb8z0QKPsiYSNlnw==
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47d84b3baa1mr178881355e9.20.1768306187854;
        Tue, 13 Jan 2026 04:09:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm43465294f8f.37.2026.01.13.04.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 04:09:47 -0800 (PST)
Message-ID: <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
Date: Tue, 13 Jan 2026 13:09:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
To: Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112190856.3ff91f8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 4:08 AM, Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 22:05:14 +0100 Jakub Sitnicki wrote:
>> This series is split out of [1] following discussion with Jakub.
>>
>> To copy XDP metadata into an skb extension when skb_metadata_set() is
>> called, we need to locate the metadata contents.
> 
> "When skb_metadata_set() is called"? I think that may cause perf
> regressions unless we merge major optimizations at the same time?
> Should we defer touching the drivers until we have a PoC and some
> idea whether allocating the extension right away is manageable or 
> we are better off doing it via a kfunc in TC (after GRO)?
> To be clear putting the metadata in an extension right away would
> indeed be much cleaner, just not sure how much of the perf hit we 
> can optimize away..

I agree it would be better deferring touching the driver before we have
proof there will not be significant regressions.

IIRC, at early MPTCP impl time, Eric suggested increasing struct sk_buff
size as an alternative to the mptcp skb extension, leaving the added
trailing part uninitialized when the sk_buff is allocated.

If skb extensions usage become so ubicuos they are basically allocated
for each packet, the total skb extension is kept under strict control
and remains reasonable (assuming it is :), perhaps we could consider
revisiting the above mentioned approach?

/P


