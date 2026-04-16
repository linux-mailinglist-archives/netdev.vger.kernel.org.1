Return-Path: <netdev+bounces-278960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN6SMnmY4GlMkAAAu9opvQ
	(envelope-from <netdev+bounces-278960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:06:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805B40B513
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 684BC302CA6F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97438C2D1;
	Thu, 16 Apr 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQsbz+Ec";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8B6iMCl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AA224B05
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326775; cv=none; b=XjlS5i9r2gjwCMRcP9i9b+5y6Ilchif9izFL0nqGt2FDYIs6OOTRe0rP5RX8T3nSmzK7mwjPpqseXTYuRSGERXlbD5D2CfzFQTsGcpd672FfEp60v9mgxR9iNIgRq+S85hVCvxpblNoKbBot6dt0EuJbp4NH9gxCr2Ylttd7/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326775; c=relaxed/simple;
	bh=Ru2dAGDmXt2BWDG4LBRI+9WbLDGbJdMohF9oYmlNENI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgezO4WOwO8as3QVO1+CkPwJ10oKXq9G8NuY0KDctoez2UG9uH0BlV6Zj5ghbZKjybWH3wC9k8AwIbAOjUJCiXHNzUaKXSP6n9chH6K5MLo+SM9npSQmELGATw1w68pxHM1yBulQyoREMDdGipvn8WkTN7c5krvm58NNXfuKS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQsbz+Ec; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8B6iMCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776326772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJyyJYZcE0qwxf80pcu1qJxxfSACe3cGGgbV2D39A3A=;
	b=UQsbz+EcEgR2rbPv3GbKf2fbrZOABO8gkBytREmZ/sBoxg/tnnzj1zr3Uql2U3zBjxxdTp
	NQ+5qhDXY3h+lxeegWb9phDW3E6rElr0hbbdeSNzYuNi3SmxrGdCZ1JaDCkHm8LIUQTS3i
	05Y5wNzPEi0uV6f09TJIvfajZPnEjOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-U36KZHzxO0qj8A8FIqUTBw-1; Thu, 16 Apr 2026 04:06:11 -0400
X-MC-Unique: U36KZHzxO0qj8A8FIqUTBw-1
X-Mimecast-MFC-AGG-ID: U36KZHzxO0qj8A8FIqUTBw_1776326768
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so4811046f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776326768; x=1776931568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJyyJYZcE0qwxf80pcu1qJxxfSACe3cGGgbV2D39A3A=;
        b=G8B6iMCl/xN7TnIVwNj+aX1dyLzNM4Z+/nUVjtBnNBk26k75hjkIinHjPWczobgxIC
         4PWiyZ5l/ojEovkqyXhuH+9TY5WS7iluuPltxj2zEu86JCIigBqxioX7O9wZB5jUSkUr
         w4S0k8ot0Y7fV5LSO0OBKQ+O6jjuNzimjB1cpuAS08tHaCtwzSa6Rq4wI7oqBk+0Bu5g
         obm0vgFhDjg2h7pz8fLs15diEs/L8D1980IPvAsCa4dlKCva4g5y/uASt7twCKP27LyP
         OrJMKVgjLRV1I8bglb6epVkwooJqARY9Y3+GAN/RBs0o3mAlDJrw/DtsWwYWu0xVkAlm
         CP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776326768; x=1776931568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJyyJYZcE0qwxf80pcu1qJxxfSACe3cGGgbV2D39A3A=;
        b=kimXC3/mB3FUS6d9eqdi9q1WDvrnoVAF7QgZ7YtbPkcesPGoIYSzdNdTur8ZFRFKSu
         kTHnD3/t1ttte1Luo4N8tFkE2Ai2LHG530zYszO3R5Lg2AppZcXeWxLTjUcbpGzSsR0+
         AM76YwoTjPcQ9AhyNnExeQAk8Sil8eTfTlN3nvh/lwJ+1c2LDDWzFqmUoqCpouvCv3L+
         aGbh9iTHE+hdbcJ3a0DyDxUGh/WKx5lFrqx9UrtC9e+DPXOyL7mH2lVU/HYqLaO7zhr5
         sM8u+kZ9wSDueNXVkKRngrEje3q2N2lMTaw4e8Ww7eytVQSkMl7EncaGxboaMtaw+5tz
         /0MQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lXUIyUl6SJutsTILhYm2T2VU+ZIUbpAQaXigXmfCYEs1P0zCfHuY/YaqGaIU4+jrMWIO4RAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDOlrYQZnzPgi7KZkPBwTThCQZgqS+4rg/LFR4MN3GUMsF2ymS
	3R3TEWhCu5ZSqPLJeMw0gANhBA2QzDPuqX+Q0IKcMjRXUMttcCr9UQ1RGzW8g4efOJ2g62PPutH
	bGtt+rj5z03cAjHDbVk6l8i2qNNI3jD8ySTzGS59z3xNf5G5zkzcONRLnnQ==
X-Gm-Gg: AeBDieva4KC3ajpgtMezizCZzUlqE1o92Ew/YnfQmzGDliYQXyF+a/RAzGYA6Our8a2
	BGt4dx1YGRsf0AGteXQCsRThCMiOCkrqsKTHdNM/uI68wD6P39b5v8bnShiK/Z4t9yy0JdzfR9N
	5GxbVUkuf6mCGPqp5xbFPaz1t6ytVYonmxr340UU9Tmwnl+bowCoi3JDhtklP26t1aM6F3GOE24
	4YP0KO8byhnNjYJNRbsuoQum2VkxhNc+eQLhcCuiSyO6q5+qRCQsdPg0ugUjLrPh6P/2ruCbmJH
	J98C/X12Lc/NhBLdvp9cN+kbGzv4gsQiv6LJKsrFxkhjjmb/Zl4VQBx0bKdzuEhpkuIpzRmq53/
	fiS7a9kgW6kKs4u0a37+kTBOQV4SX92ZIzjRAyZOfoSrkVfoxq514fPymejJnQ7kM9Gk=
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr291004265e9.21.1776326767714;
        Thu, 16 Apr 2026 01:06:07 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr291003615e9.21.1776326767184;
        Thu, 16 Apr 2026 01:06:07 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0a6da96sm41903285e9.13.2026.04.16.01.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:06:06 -0700 (PDT)
Message-ID: <2d4193fe-354f-4318-ac65-30c375a90f6b@redhat.com>
Date: Thu, 16 Apr 2026 10:06:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/7] net: bcmgenet: add XDP support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260416054743.1289191-1-nb@tipi-net.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416054743.1289191-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,iogearbox.net,davemloft.net,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5805B40B513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 7:47 AM, Nicolai Buchwitz wrote:
> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
> 
> The first patch converts the RX path from the existing kmalloc-based
> allocation to page_pool, which is a prerequisite for XDP. The remaining
> patches incrementally add XDP functionality and per-action statistics.
> 
> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
> - XDP_PASS latency: 0.164ms avg, 0% packet loss
> - XDP_DROP: all inbound traffic blocked as expected
> - XDP_TX: TX counter increments (packet reflection working)
> - Link flap with XDP attached: no errors
> - Program swap under iperf3 load: no errors
> - Upstream XDP selftests (xdp.py): pass_sb, drop_sb, tx_sb passing
> - XDP-based EtherCAT master (~37 kHz cycle rate, all packet processing
>   in BPF/XDP), stable over multiple days

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for
v7.1, and therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


