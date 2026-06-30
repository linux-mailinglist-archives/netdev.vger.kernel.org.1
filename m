Return-Path: <netdev+bounces-303284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TggbFljlQ2rOlAoAu9opvQ
	(envelope-from <netdev+bounces-303284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:48:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EB6E6180
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:48:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bBwUtpYb;
	dkim=pass header.d=redhat.com header.s=google header.b=AAw8Zg0W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303284-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1B3930985F5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDE3D6688;
	Tue, 30 Jun 2026 15:44:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320B34EEFD
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:44:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834254; cv=none; b=R/vkkpG3C6WK54+gSBw9DmUINE3lL8kCK4uARv2mED9iUBkT2pgAabfhCSmSNPddL6Ya6Txg9g1cLvV0MPp83jwS5l63Xpd1Z+6OzFj7nlJUuJbWg2+1XcYR5qbzxXKpe1Gp21idzwrqL5/u/5NOxevU7QUV8wbtAQ6/2D4T7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834254; c=relaxed/simple;
	bh=p799ufXSGXuyj/zIgcPsPBXIup9xsSLGE0ftZL6aQ0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiDIHrYxdCJkyOusJNKV9y2r2gu2z7k0F74F5BmnHDJmlhos2A0KhwW+r1tc1s3+V5Kte0kSBvzGMgV1AANl74qcn8bSAZKlvrW8QgH6wFM2qJjANRYzirpy0/i8q4Z8mXrlCUirkMZnhzgU7XbkqNnpMTookLZnNIF1KOXwcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBwUtpYb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAw8Zg0W; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ew0XKPxtXMcesAbrszv84Xa1Xt+7GkqKXKHIWM0PuJk=;
	b=bBwUtpYbVRnGjCklhcCKGhjnlhUY4/zvp9iGnVegH9ipwen5rIeq19y1vvK9Hv92z+cecP
	blYK5Ph5AiNSA5rmoel5kDJwbQeeuf5CXRk5HxPF/9NdFEt+ZjRAqirsvM5dWlTEumE4lp
	+5oVz+meejkoKsYgajQRZK93JTOGoqM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-xuBr8TdtM9qJQpXaIkWJMg-1; Tue, 30 Jun 2026 11:44:11 -0400
X-MC-Unique: xuBr8TdtM9qJQpXaIkWJMg-1
X-Mimecast-MFC-AGG-ID: xuBr8TdtM9qJQpXaIkWJMg_1782834250
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-80ee3cb097eso56928617b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834250; x=1783439050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ew0XKPxtXMcesAbrszv84Xa1Xt+7GkqKXKHIWM0PuJk=;
        b=AAw8Zg0Wbst1ER0rsi/UhP9IzP2fExU7Chvb7dJOC5IWxJTC/BfpEjXHA9QD2c97RL
         YdOQFVb3NmuKKLuJWq1n1ub8/m8lZfno7rBIdmdDklqVlXjUq4lZx06QZIiRbmM7jbjd
         HBRBOMyda+WRpRViJikfZd3k33BHSBqqoQ8wl9D5eB/2fpN8p0UpVtep8iCEjvANvmW8
         O0Q34W+9Pdty3SNrYYKAt8u4cPeZ7iMwvXjRAM5qXb0+rndUmpLjo8r8MpO2Qiujhp0N
         Da4WYTBLqq/nmO/R3emKOqvK7WKr79PkACVl+c8PvYFpwHcPZnIKFLuIOSkTzDFG9hMh
         MKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834250; x=1783439050;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew0XKPxtXMcesAbrszv84Xa1Xt+7GkqKXKHIWM0PuJk=;
        b=H9u6NFGfe7H2rzkqH4FVmQ8Oryjsc0Q4FuyM32rXVWXBcV6WIQNVnPUh418aX5YA6j
         vBVnSlAtkNmwIMuL8U0LLsI93u9erMZ2/bPLa9O96QmHuMohG+MkljD0bLdzN7gnYY92
         k9mYNHwsYJOpSxJdO2FIlFLCg6wA0I+WNC/JArqAt3fiCV48F1Utz/yEVJs0mPFW7Uw3
         pQzfR0JL/QdFMKzU566czxy9pqh7NZ6fkBYtMnMCdbePuo8elc/Z7PAHO7vn68cb4Nm/
         lRfj34n+kB+J/udPNrn5fT+F/U2lI2brc6GhVc9FJQ1LPQtHvVBz/cxQW+OYzYpvJW5S
         BhmA==
X-Forwarded-Encrypted: i=1; AHgh+RpoFqSguw+ISmt1cQOXRJzm6VTf3bGnn9XIdcRMwOgd7CFwIKa2NZIqYUps5cEbrd88N/KHoy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/Txpl2JSREJR30i6QH8AWOPUmh6eo33ikOef8+8Lrt6sv14i
	WcR4DrKWlq0BWzcvBIHGVMoZO0fRA0LAAx/lQlcdqM2HhnH2lhtV3v6LCwKRbCGB/oKFiUMPVwQ
	9Pq3uiEjX5Bl7hh6Yqw85LCR8vhbRhQaPuG9hqeCVgCKJD3rkYXfxjH5uPg==
X-Gm-Gg: AfdE7clOu6i8/HaTBrkX/gBODRQ7+qEOScaXL2BonUXtHF3DlsEZP/rqXXmQ1Xwww3o
	EpzT0MI6VRDIMaj0HUI1c5skEShBU1yEoTLgcL4OHVPC4zpHy09tBDrMTK+xNtZn8/toV8Mk4qd
	8EZ+Cq5Jjmom+7pyel9S8K+S1KP/IUOoEgmSWfUChlRlxwOznL7O2F2irDk8WgPBX3CN/LGqFNq
	r3tLGOEcvsPvVyWzDsTbg79XkzsgPRKaOUhLcIgn6WtpDSr5LsRaXL8jcc5imwg7XOJuCY/cCsI
	DXOg3w/FvBlEAikBQDO8R2mUbpPgEySK6AHIOdadOBz2CWPfn+bdnlkGZ2wymCHfr4Hgwhpr9z/
	6BojijfIo8VAPPQzg6FFw0tEcCXmZ98BteM520ILuhYP9GCWds+hUNHb+KD0hhaMymizmgTHLE/
	dBsT7Yj/HuEQ==
X-Received: by 2002:a05:690c:34ca:b0:7fd:9dbe:4d87 with SMTP id 00721157ae682-810da312e4bmr47934767b3.52.1782834250412;
        Tue, 30 Jun 2026 08:44:10 -0700 (PDT)
X-Received: by 2002:a05:690c:34ca:b0:7fd:9dbe:4d87 with SMTP id 00721157ae682-810da312e4bmr47934137b3.52.1782834249734;
        Tue, 30 Jun 2026 08:44:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e7288a7csm12312487b3.2.2026.06.30.08.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:44:09 -0700 (PDT)
Message-ID: <94901706-e7f3-4ff7-9b19-9965f593e228@redhat.com>
Date: Tue, 30 Jun 2026 17:44:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: fix max receive size configuration
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260625-airoha-fix-rx-max-len-v1-1-45b9b827358d@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260625-airoha-fix-rx-max-len-v1-1-45b9b827358d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303284-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B94EB6E6180

On 6/25/26 8:49 AM, Lorenzo Bianconi wrote:
> Set the GDM maximum receive size to AIROHA_MAX_RX_SIZE unconditionally
> during hardware initialization instead of updating it according to the
> configured MTU. This avoids dropping incoming frames that exceed the
> current MTU but could still be processed by the networking stack, which
> is able to fragment the reply on the TX side (e.g. ICMP echo requests).
> Move the per-port MTU configuration to the PPE egress path where it
> belongs, and set the tx frame size running airoha_ppe_set_xmit_frame_size()
> to dynamically track the maximum MTU across running interfaces sharing
> the same PPE instance.
> Fix the PPE MTU register addressing to pack two port entries per
> register word and add WAN_MTU0 configuration for non-LAN GDM devices.
> 
> Fixes: 54d989d58d2a ("net: airoha: Move min/max packet len configuration in airoha_dev_open()")
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P


