Return-Path: <netdev+bounces-298912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gbduE6sJLWrdZQQAu9opvQ
	(envelope-from <netdev+bounces-298912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B311167E00D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=X7mhG1qB;
	dkim=pass header.d=redhat.com header.s=google header.b=VU4DFyM6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298912-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298912-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D539E3048F3D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B8395240;
	Sat, 13 Jun 2026 07:41:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3F358D32
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 07:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336474; cv=none; b=S9PYC0dMX9M6dyRmCfajowNTLmvEax8MM2jkMse6TeTdk0U4laK4wrgg4moXMQnlX7jzN0VB9TDSt3DeotcBUzb31MsT1PsUf4FyxXC4SdqKanIINIyl91XYmL9TaFnrI5ToZjJs27tFFOV2fobiZJs3AH9aalmQSy8cvDfepe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336474; c=relaxed/simple;
	bh=W/N+tw1LxpgvVpwvbWlWKp/WUMBhf8WS2wtHORfwQAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAchky6XXcLyBObtUUdNOfm6Ul8dvttGdbqkwGaUnhM6fRq2t4CzEBd9mmcQxaAmxAxF/Enpe5UKms50U3TGp5MJoG0ysh3XaEe/jIeECJtVHC2o7/2aQgk+PTQ9HDYkk77WsMUBgvLSmAyC5/PPUaM9F0K52tOctydxYSBpbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7mhG1qB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU4DFyM6; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781336472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2c8kiVJHUhhKHp0g0/L8bPiJTp/p1OcNdLSuFPcX3k=;
	b=X7mhG1qBQcr+UnNkQihGCqBeXXygvFp4XZ/thiQy0IdO6+gseGfX7A6TqzIzLzK9cpXRFG
	SwMZ8miCREBW8Qft1YPhhznCS1pveTRuxsSDaqAGndB/ZKt7xWPpU4iKmG6fo8j0JuNXYP
	7/pdIjy4dDC5XYaJrHAE/1vXe87PbBg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4Qx_zHV4PgeQ2cRkE_ksQw-1; Sat, 13 Jun 2026 03:41:10 -0400
X-MC-Unique: 4Qx_zHV4PgeQ2cRkE_ksQw-1
X-Mimecast-MFC-AGG-ID: 4Qx_zHV4PgeQ2cRkE_ksQw_1781336470
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5176d949c58so38792611cf.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781336470; x=1781941270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2c8kiVJHUhhKHp0g0/L8bPiJTp/p1OcNdLSuFPcX3k=;
        b=VU4DFyM6FqmEUvtnU4Sbq7016ZFM6NenOY1P+pUmXGzkAd+WmaFvu73HRij4086CL9
         NvqnEXhJ31QOuWJCIZJWH7tZ0fgx9U5yBYxtM0rk28vCOkB2Dkrzxm+zhYW+QvKuy6ex
         7n/zIwWJugsxeS74zhLS76+i3dPQx/lm34drde+MDUwXF9ytKPTxrN5qjkTvDutOAYAQ
         Th/b8l03D62VtJPbA5Qk45DlxInLBplUQ7cNIlCUe7NbF37Gsn1N8lK/IO5srbN+7jy/
         jWbNz4WXezSt0CK6mvPO8RUSo96vFBhFp4Z0OENq4NvJigZtF8jzjQhcok7wZRQotgOK
         sfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781336470; x=1781941270;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2c8kiVJHUhhKHp0g0/L8bPiJTp/p1OcNdLSuFPcX3k=;
        b=S1HrAfRgOiAactvb5d6ZwOQjwnurrPa68b4OoQaESpgw27kbeeLEaPyBb3OLzqwpjc
         vX7JUYpBurR6Wy9rS7xw+Sf+Q+tnaUDkuMdIql+qH6zj3yZV3EHg4/T6bYLFGjSn3x6Y
         GurH65NfQ6qDEumfLxF96mBo+QiGiWteUSU6YNijoi4rW50QEUe49sqsFyR8mmX7v06P
         y7SJqBO/H5qLO/R5qAsnxlgCJPHb5xhQjKZI1YMqXwwMAz1Gd2bDxVqBEuj+/ZSDH7Db
         4KWmCL6XEcAz5bZH4ATJcrHDTma3mX7m+4AwV5L6trZlQ/mw8Lg99ENT4YZf8Q1SPekJ
         8cKQ==
X-Gm-Message-State: AOJu0YxlTwGlAU5eeO22y/zBk50oFnANr1kKDkV5fEuHikgidBa+cd/c
	Qo1EjReiy7/p7LWJ2BRXvNMwgH3lDiW3h5NryNJasBEemsD6VliAcqp4cumLH0BlACZzRbRiVR5
	HZC9tfEjPZS1zpxaS7YWf6nb5ZG8cmlzVPVKX/T7MO37F7+TWVHdjUXaMXw7LdSSwAg==
X-Gm-Gg: Acq92OGOcOR4e1znLXHDYBcbASemUn34YEP/1QMn6o0KZ8i+j/aZpo/xJhIBeSrvKaa
	YxQBjjIC4OqM/B4C0aFcbSOrLuEmZbsoheTccFoDJYhniGDvepbCxYbTRNnJuhBN1+e7izSWa7J
	rXidXrzTThrrUrIcY2G6Q8Uv2uv4cAqMCRXIVh5PdBrIOZSo6jbGdmYky5FimQ5DV6NdbO/rF1a
	Zz5NcqgpOkVXykcwd7uXvRqfoDI4rtXmEWjpSRsLCP1EGLOXOlfEsQbq8plSeSiLDJfyhlgbkMf
	erjxx3AYwjVUm3lTInOXzb6w0ZIBMDXQhep24AY6YD9LtHeL0QSNpdwelMM5qYwhFdf95+NJjop
	lK/RY7AT848b/NTJ9+exp9R11+wDDcyRR0isqXPxM6NaJ9dvlgHhbn6A=
X-Received: by 2002:a05:620a:6cce:b0:915:efa6:d704 with SMTP id af79cd13be357-9161bd4eb21mr946492285a.49.1781336470215;
        Sat, 13 Jun 2026 00:41:10 -0700 (PDT)
X-Received: by 2002:a05:620a:6cce:b0:915:efa6:d704 with SMTP id af79cd13be357-9161bd4eb21mr946491085a.49.1781336469810;
        Sat, 13 Jun 2026 00:41:09 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a00ad75sm441913885a.25.2026.06.13.00.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:41:09 -0700 (PDT)
Message-ID: <6bf63337-9382-4dc3-8940-3cfea00c5193@redhat.com>
Date: Sat, 13 Jun 2026 09:41:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pch_gbe: handle TX skb allocation failure
To: Ruoyu Wang <ruoyuw560@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608163005.6-1-ruoyuw560@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608163005.6-1-ruoyuw560@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-298912-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B311167E00D

On 6/8/26 6:30 PM, Ruoyu Wang wrote:
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index 62f05f4569b10..a426243a5fa34 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -1420,13 +1420,23 @@ pch_gbe_alloc_rx_buffers_pool(struct pch_gbe_adapter *adapter,
>  	return 0;
>  }
>  
> +static void pch_gbe_free_rx_buffers_pool(struct pch_gbe_adapter *adapter,
> +					 struct pch_gbe_rx_ring *rx_ring)
> +{
> +	dma_free_coherent(&adapter->pdev->dev, rx_ring->rx_buff_pool_size,
> +			  rx_ring->rx_buff_pool, rx_ring->rx_buff_pool_logic);
> +	rx_ring->rx_buff_pool_logic = 0;
> +	rx_ring->rx_buff_pool_size = 0;
> +	rx_ring->rx_buff_pool = NULL;
> +}
> +
>  /**
>   * pch_gbe_alloc_tx_buffers - Allocate transmit buffers
>   * @adapter:   Board private structure
>   * @tx_ring:   Tx descriptor ring
>   */
> -static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
> -					struct pch_gbe_tx_ring *tx_ring)
> +static int pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
> +				    struct pch_gbe_tx_ring *tx_ring)

With this change you should update accordingly the kdoc above
documenting the return value, to avoid this warning:

Warning: drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:1439 No
description found for return value of 'pch_gbe_alloc_tx_buffers'

/P


