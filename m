Return-Path: <netdev+bounces-280720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI/0Agr66WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:52:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A873450F01
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 138183020FFD
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AA3876B8;
	Thu, 23 Apr 2026 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUplgvgE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mOroCPqh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91037DE80
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941573; cv=none; b=YeFywaW9DIdLjfA/NjowCgNowFPZC3Dj6dG84vSrU/1sB1otVbm8dJV+c3Ca3XkiQ/EYFNSGNcQL1ZiQoaViDkbXd6zbPtS7c9bsSKJNxmy33ShX4YBGh73O7cW00q34dNsiXJ3gIJ5/pEGpW6JtxPSxRFP6bJb3Kanso7pDerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941573; c=relaxed/simple;
	bh=m101j43P5lzRFczyB45ahCNexSnh1DduvS39dTm8j24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RTShBSGV2giaj5+dLyo651CUlGqNctq1/GiRnqEcG9s8PWIUBKB31pbTgRqJ8Jfhy5YlOzkqXSETguirdC/NBMPpPWv4fmgxd2RyHG31jsUmyg1Y6Otjb8pQ9oIHTdE70aCKDNzELYLoQdDp2BlppE4MXWlIMIY0sffvTrAtt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUplgvgE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mOroCPqh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776941571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xC8tXl/B81gFeHZNp2utQBvI0XuSwkdb9RxGKsRnn8I=;
	b=YUplgvgEAqgd73ZbwswMhNnJAB3WXCmyVLtkMykuepCS0knFbxWMuEt6s5Stm98o0A+gjO
	tx9mX9pxMyRoyQeDRTt5Kc8NhtRG0nmr2MeYhi3DFODnYxO2KYIHUgFgwNU8sSWByyLf/j
	cWbx12t0AzNgZjY4WITS/c9sB9QvHBE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-9oxgl-CJNhCV2I-2Xey7Rg-1; Thu, 23 Apr 2026 06:52:50 -0400
X-MC-Unique: 9oxgl-CJNhCV2I-2Xey7Rg-1
X-Mimecast-MFC-AGG-ID: 9oxgl-CJNhCV2I-2Xey7Rg_1776941569
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adc527eaf5so52131585ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776941569; x=1777546369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xC8tXl/B81gFeHZNp2utQBvI0XuSwkdb9RxGKsRnn8I=;
        b=mOroCPqheaaqKJ5+iHKdrC2TUFvjdhj8u4L8JDh7nm2LqvVYa4JjbKsaeiJCdyguq6
         w+yIazrrhxNxEAyo4nXD7tcNF+U/aYkpL+qfE5FodjLobeAqMV/X+L823nOrHdyB3sJo
         NRFwqKdpMUKsCOSwmWe9Yys9GFXEA7Yb5B1M01j4VFQSrR0tzrAwsT8Zd+as6tYlPGZP
         45W9U1V0cI9ZlDPmYDxR2XqmGdiNKe+DvocTJORUOzNn4qKyXOTvbIlN5L1ot8UC8guM
         0xCBlbEwQkcneTHCRw5v0IPpt6xhQT1i4UC5qZrpb404RW+5rQE6nTcjU62bsFEVIAGY
         ZVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941569; x=1777546369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC8tXl/B81gFeHZNp2utQBvI0XuSwkdb9RxGKsRnn8I=;
        b=koHIbpGN0iykQFZgW3XH/jKS0+fpSwOsyLTnXu4hk9It/hGcxhKg40kqb3VzwlV5Lf
         7nGDqcpcckbHRzfzeI+2nVEpraVahoZKO7pce17ybn3otVvZDqn6J2g8lQMgkRyvLFiU
         6Za1q+a4oPHHqWD68X8E2HgEf2nWeBNz9m0EJEUpCHKKTrHCBaHd+kqErlilc4toewmc
         R2df3/+pFmkPdk2uPeLrztODirh53umQ3DvXEO9amy2l+9wjwYIzQJJomz0pkJSTIKMn
         FKAndDJvk6howvMq30fkKqm55rMLBTRdMmbrpowL/bpYc+mXz6ZUHXH+z93K9Glc0Fj8
         AwSA==
X-Forwarded-Encrypted: i=1; AFNElJ+/oW8dI0gWpxmo/cPiqfHgTPra9WbNWyOQeTBbAzMMVZLYl/VMy0e984hLc7L/N5OP4K+DDT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/K4I8tEzuAvNHkvvN4aonUNNtujacmqeVVdYMCCU/XU4Em5Ux
	4avrjUavuE+I/5TQ1XfLb1yeDnA3ubWbphrdS8e9bbiYXTnr7ggnZPHvGxiNYph3OxRmjvtPKKy
	nbZ8h2NK28z4DaGmqJcYPA0y3rltDZlTWu01acdSjf2GKygaBImD0CCbUxA==
X-Gm-Gg: AeBDieu9jRPyAny7aM5J892hTPc/PjtPLPm8W7Ox987VWYm8I79HpzcooRz+bBuXNaF
	EKVjWJ1sz+RDo3X4CS7jEwnZTrGzgyDyIJGNKtIkj9wB4gGx78DWFPZR5Fks7hH3LbLEIW7AN6d
	A0qXz+OjRhyrm3fZDUdajxGLZiDXd4ljWVcsMiRHsJwh8ZdaSk0fQnFkNZNqAjyRb2FICoju7pf
	O5M60qtJ4UkikmMOKpsFZr27yzVjl9V91Wajeh3XL2BN/7vXi78EiZnl4FrNmBijGUmQUmwehIz
	XYrnfQGOKOXquXaRbUR9ByeJGu+GB5ZXdTx7+wBTDbtZcOyhD/MuUFD+bTujIrFSQvAGJi2iRju
	7igj8xWlpaUVt3Gk5C3oCgpU/7S3lC0gxHAvv3h6DAwN8wN2KXLT2TbLrAnXXMh9fD6g=
X-Received: by 2002:a17:903:2c5:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b5f9e8cac7mr273754985ad.3.1776941569005;
        Thu, 23 Apr 2026 03:52:49 -0700 (PDT)
X-Received: by 2002:a17:903:2c5:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b5f9e8cac7mr273754785ad.3.1776941568531;
        Thu, 23 Apr 2026 03:52:48 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff71esm198582245ad.8.2026.04.23.03.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:52:48 -0700 (PDT)
Message-ID: <d47894f2-4af2-47d5-9961-51ba07441212@redhat.com>
Date: Thu, 23 Apr 2026 12:52:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/5] net: mana: Guard mana_remove against double
 invocation
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
 shirazsaleem@microsoft.com, kees@kernel.org, kotaranov@microsoft.com,
 leon@kernel.org, shacharr@microsoft.com, stephen@networkplumber.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
 <20260420124741.1056179-4-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260420124741.1056179-4-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280720-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A873450F01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 2:47 PM, Erni Sri Satya Vennela wrote:
> If PM resume fails (e.g., mana_attach() returns an error), mana_probe()
> calls mana_remove(), which tears down the device and sets
> gd->gdma_context = NULL and gd->driver_data = NULL.
> 
> However, a failed resume callback does not automatically unbind the
> driver. When the device is eventually unbound, mana_remove() is invoked
> a second time. Without a NULL check, it dereferences gc->dev with
> gc == NULL, causing a kernel panic.
> 
> Add an early return if gdma_context or driver_data is NULL so the second
> invocation is harmless. Move the dev = gc->dev assignment after the
> guard so it cannot dereference NULL.
> 
> Fixes: 635096a86edb ("net: mana: Support hibernation and kexec")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v4:
> * Update Fixes tag to 635096a86edb
> Changes in v3:
> * Add this patch to the patchset
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 468ed60a8a00..ce1b7ec46a27 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3731,11 +3731,16 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct mana_context *ac = gd->driver_data;
>  	struct mana_port_context *apc;
> -	struct device *dev = gc->dev;
> +	struct device *dev;
>  	struct net_device *ndev;
>  	int err;
>  	int i;

The above breaks the reverse christmas tree order. I'll apply the patch
as-is to avoid additional traffic for very little to no gain, but should
you touch again this code in the future for other reasons, please
restore the above.

/P


