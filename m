Return-Path: <netdev+bounces-258234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHxNCZBNjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:36:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81F122CB3
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D23308C2AE
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F9356A05;
	Wed, 11 Feb 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SynnIBCg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwhCW/tr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7A3563FC
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802459; cv=none; b=B2VEAKSXsNT33nznbum2gimo746ywCAQkL4hQhTK1W2+I/6jVF1NyHn6kNeB9e6EAM+ZMmtMtxtuOy7nBrZ2v5cLQpMJS7MDP+GBkdxBsSMQBf4C/fnQGNMXSRgK6V6b9bhGPlL0PhyneI1+nQFTDnnz/jwcwTMDfYvQIJc0Zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802459; c=relaxed/simple;
	bh=5m5YewVGrTKoAlUjWX5+VQrFf3zi2ZxKtV9x7JwW7nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfSefjVHRoNpYexryn2EZASTFolsV4fuL40aN/JRj5rZHel9mkHM0AopO8WrtBbpxeZe7bPz2q4QHoK2moXayz6aTkjS1QZkO5sGVX5RML2Ah2gc6zQ5oCAjxRkTPw6TM5w1pN1LJW4W7pKTJbgYjWiP8m9n4XYBqooKzy0obtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SynnIBCg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwhCW/tr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770802457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THRpbx6Sr4LFBbLZno7YozYPuKMz6mvA+7rtPu9uuMY=;
	b=SynnIBCgWyRFlg6NEBzLCxt3dctzJJjYo3L8fuuMI2HmGatFq0YyLg/+ew9f8QykXVFlWB
	poi5eM5aTp8btHU23BQqcGr6S+zrgrsTxRw+XBcCiuA+LPVSpDuobxPXRxAUakblnRsF6F
	TSa/9FGtY05ttP8SkqkxIFdarzoSLZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-CukDiQkdMDu_-sQXMmKBCA-1; Wed, 11 Feb 2026 04:34:16 -0500
X-MC-Unique: CukDiQkdMDu_-sQXMmKBCA-1
X-Mimecast-MFC-AGG-ID: CukDiQkdMDu_-sQXMmKBCA_1770802455
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-437812b8bb0so532703f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770802455; x=1771407255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THRpbx6Sr4LFBbLZno7YozYPuKMz6mvA+7rtPu9uuMY=;
        b=CwhCW/trmUy6Vf90Q/703mpcntlb/I2RmZfmPgI9TVc3mRouXeRJxxJIQo8lPbyt6F
         nyHdjSwYF9XSxWq31A9QKu1JUN7/qufLwTGKpGNm4SihxqtWkcjIoGaOqLCZOOlswlX2
         gRmBo3u+gdPU4hnN1dKovWh726ey026g9GeJBnyCm2qcRpYxboF6s+S632qTmHkMrs3D
         m+DBnuIcX5Wp+0JYQgMHgJIJiT54errGt3EQta7Y8wccI0igOxSTxS6/hcYzt1ryYOBI
         kQX3M0mZSqEDlZ3HyfSfs5KbKWMPs0NxVgciY/WJXyHXbOfOQwR/goTs7AApOrAZ/qQ3
         UZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802455; x=1771407255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THRpbx6Sr4LFBbLZno7YozYPuKMz6mvA+7rtPu9uuMY=;
        b=M/3tYNwUseMpVCwT67K9IG7AdZLxJ7Ql2BARgMdQY1Xu3ieH6k4Z9EMKeKu63Ws1Fb
         X10Twe2RKZvwi27Ue2d5PnVmyBFNW3tWdGpJVzabHiOsPj5EfS19CjCET/H0FdTP0sOZ
         WmV6eCyo2T3cuH4OJNk13FX6kYPSLPBFpic/JIsU+ffpCnUMX3K/TtGgxYdAootjjlQw
         STQl8keu2OHbnLNTZVQtrXl1EZwbIXQYthxdGjzW/XQc1rUsEkJwO5qEhIl4m3SCUIWa
         yJQUWJtWCmV1OqOVKVHeVpwKoBpku9TWAlu4Va839NL43hKp8dEnxJjuMGs6ze4m+hUO
         /gRw==
X-Forwarded-Encrypted: i=1; AJvYcCWJzhOd3/M/cvxJmWUa1T84DKZDjkw3Mdasr91+N2xSRgkArena25ExPIvo2rdv6TTBi0htvRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpZ7CPIuHyqJVfgLXa/s4o3x+WvCohNhhcn80zmJF4JrqIP0h
	HKK0T4qhJ30GSN9u/Kg4ur9UjoH4PfxCUmiggDYgXkGf0s4v3LAZE8yC0/9dEplWPufIeKFvb3Q
	rAG+JAkJt8cLT/VW6VoGfhNiSWax5BkgqqnirW8XxOtyofrBZeABbv0GPoQ==
X-Gm-Gg: AZuq6aJpgJ+STyMZUP9Cw70SbRa/Pdgu8XQ7C6dsW/eJLH9XuSbYqBPG5aSBCl5hlQl
	kTcM3q3o0zG2od7e3GWqFr56ANOBw06PaI0K+GZ06abP9JW1gcgh8VnVW8GTfjEUYaXe83aQyDn
	WomSpPywCFTujicbiDo0R6KypoKjVeTneKluJb0XUk6OPRgN15nOkT4vjuL5CuVUP1i67cgQAI2
	fh2YAxBp1CVrl/ZEwfHtwwnxqSpW9EH/uzdg6pl4hvKpvG8gb49GETDnC4cjS5SbYpSjYqeH8UH
	IEwRJuzxNAS0zsoH0lfzLwXVPt0qYXeVUjpdUj1mWIrQbModWOOf7B12KUHq/RHeZ1SD0MTHHeD
	boSy/bL1PBvMDLHgmx6nfrUbGhw==
X-Received: by 2002:a05:6000:2012:b0:430:fb6d:1442 with SMTP id ffacd0b85a97d-43629386018mr30005981f8f.62.1770802455009;
        Wed, 11 Feb 2026 01:34:15 -0800 (PST)
X-Received: by 2002:a05:6000:2012:b0:430:fb6d:1442 with SMTP id ffacd0b85a97d-43629386018mr30005931f8f.62.1770802454488;
        Wed, 11 Feb 2026 01:34:14 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e544e2sm3795611f8f.32.2026.02.11.01.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:34:13 -0800 (PST)
Message-ID: <53ae4a20-aadc-434a-b056-65b306e64278@redhat.com>
Date: Wed, 11 Feb 2026 10:34:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] gve: Update QPL page registration logic
To: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>,
 Matt Olson <maolson@google.com>, Bailey Forrest <bcf@google.com>,
 Tim Hostetler <thostet@google.com>, Jordan Rhee <jordanrhee@google.com>,
 linux-kernel@vger.kernel.org, Max Yuan <maxyuan@google.com>
References: <20260207011734.437205-1-joshwash@google.com>
 <20260207011734.437205-2-joshwash@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207011734.437205-2-joshwash@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258234-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BB81F122CB3
X-Rspamd-Action: no action

On 2/7/26 2:17 AM, Joshua Washington wrote:
> +void gve_update_num_qpl_pages(struct gve_priv *priv,
> +			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg,
> +			      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg)
> +{
> +	u64 ideal_tx_pages, ideal_rx_pages;
> +	u16 tx_num_queues, rx_num_queues;
> +	u64 max_pages, tx_pages;
> +
> +	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
> +		rx_alloc_cfg->pages_per_qpl = rx_alloc_cfg->ring_size;
> +	} else if (priv->queue_format == GVE_DQO_QPL_FORMAT) {
> +		/*
> +		 * We want 2 pages per RX descriptor and half a page per TX
> +		 * descriptor, which means the fraction ideal_tx_pages /
> +		 * (ideal_tx_pages + ideal_rx_pages) of the pages we allocate
> +		 * should be for TX. Shrink proportionally as necessary to avoid
> +		 * allocating more than max_registered_pages total pages.
> +		 */
> +		tx_num_queues = tx_alloc_cfg->qcfg->num_queues;
> +		rx_num_queues = rx_alloc_cfg->qcfg_rx->num_queues;
> +
> +		ideal_tx_pages = tx_alloc_cfg->ring_size * tx_num_queues / 2;
> +		ideal_rx_pages = rx_alloc_cfg->ring_size * rx_num_queues * 2;
> +		max_pages = min(priv->max_registered_pages,
> +				ideal_tx_pages + ideal_rx_pages);
> +
> +		tx_pages = (max_pages * ideal_tx_pages) /
> +			   (ideal_tx_pages + ideal_rx_pages);
> +		tx_alloc_cfg->pages_per_qpl = tx_pages / tx_num_queues;
> +		rx_alloc_cfg->pages_per_qpl = (max_pages - tx_pages) /
> +					      rx_num_queues;

Does not build on 32 bits systems:

RROR: modpost: "__udivdi3" [drivers/net/ethernet/google/gve/gve.ko]
undefined!
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
make[2]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:2005: modpost] Error 2
make[1]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:248: __sub-make]
Error 2
make: *** [Makefile:248: __sub-make] Error 2

AFAICS because above 'rx_num_queues' is implicitly promoted to u64, and
the statement yield a 64 bits division. You need to use a div64* variant
here (and possibly somewhere else, too).

/P


