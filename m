Return-Path: <netdev+bounces-180622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C19A81E59
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986F47A5D26
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9325A2C5;
	Wed,  9 Apr 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F53d+bI9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C61DB122
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183933; cv=none; b=gnzd9Qkn75pLiOYS4jUi4pns7xS6yFvuI2zUJUn38GYYgf6RQ44URhm/RlH7IfQZpAv+ZN5L+q2tFZT6cc+fJRytAN1REnbqL7v060DT4XrFwBhU7yLDHKbOq0xtXwJRP7FAj8ljkmVKZkuscFykdIAxbU0O8yNSKmIIpI3UU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183933; c=relaxed/simple;
	bh=sghke2wTh/FVNvg8pfbLJx6eA1Do09KTsI4oj5JZIzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIOKGtrC5tDxS8wJOQXVsMOZaiQMOpDVOP1aIs8aByKlv+nqTetINTGg9TEbuk22U/cCnltg81NAtgjNJ170hkRfCIc4czVGAji1aIudtx3vFpg9Qk/KoLOPmoezVaOWDihy8yOCxdB4zPrNX0TUwvTjKPsI8v8XV3h8swTuj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F53d+bI9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744183930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15XMg9uMFcGvaxDTX0fVMBlGv3B/qZKa6F1fNknaxhY=;
	b=F53d+bI9nF7LTOo/1Ve8uGh8FToCxHeIa5AnGVKAAQzxnTsvQGTOexM7uOloZ5gehake4y
	Y4SYcbGAiOSRy06b8lls1GcSqfouBzStunu4XUWe4XagOT3gJUF6svoBp/uDPVXG7V2cL7
	INgfH4XsiHnmrr35UOgr5NuppFtohjo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-qWADGFpzOrCRW4Y_A2fa1Q-1; Wed, 09 Apr 2025 03:32:08 -0400
X-MC-Unique: qWADGFpzOrCRW4Y_A2fa1Q-1
X-Mimecast-MFC-AGG-ID: qWADGFpzOrCRW4Y_A2fa1Q_1744183927
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912539665cso215123f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 00:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183927; x=1744788727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15XMg9uMFcGvaxDTX0fVMBlGv3B/qZKa6F1fNknaxhY=;
        b=gxH0CsYcjEqZPyBuIKtlokfj318vgNFW0cS65ofXvD9YN07R2Lb7CHSXm6MScb2fz3
         t2jFMuxpA8QvYr1UvP9292TtAQ1a6KWTWvmQ2rQX5u2ep6BPY8TjB3DjBnWLM1mweznr
         TUtDh4bRTNxGu01DY/iPC6fdkG4Uwhfy9QfVdldFTmvW/Innbya1t8yIBCdh/03kL1o3
         UdAR2k9SfxV/ZCAoVYJM4FTmW0DZMlXDwBxPC3jo3DU1UujVUrW5JSLJK/F602zpt3/U
         4avykvM6Mmr9GKJo4vHD4z97QVBEK9K2sQOSJjz5Y0uMVUtAAjg0VfinRo4ItwyHA1mD
         rBJA==
X-Forwarded-Encrypted: i=1; AJvYcCVPIiEZP5OTE7DC04xfH3UsLiRqF9OHLpp2EeQANa83qmivdTTrFpc/q84/fyhunhvChUbi9EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkh874iqEagvrzOVX/zEAv6Vs9q7+RnSqhBF5FuBgNh0xEmw7Z
	xGeTRsV5nQy6gOGcAIfho0dicB/5QU+8ISQkNUu8X4AzYsvfpf1mgUp9XPRroB4O30lDB+6wxoZ
	LQhgMYIeTn4BfAdvzpP0dwCCzLyYYXIodSPkWCRTqCfwGyahO5HbLdQ==
X-Gm-Gg: ASbGncupRR8e3XiVEp4j3I9ygYtuFTAAClrh98TI1bDye5GYwZpocsRaZ67XmjNvAVS
	HXOoGLJ7FlkA6EUq25SEm10YRup3IWfrhsx7DuiP+uV6yWB3muesvJYDJ7Z2+oMrPP2OWy3amAj
	ckO7rodw+NURhQYHItbf5kkuighsMd/t5eOUisM6credZQ7rAV+spIK/CWNfaWqvnGL5cSWsIUO
	Iq5I4wie/g52QQ1z8F5jpiRGJtlq0suIwstElfUmJg6BPFiLpz+X84yf2Jmmp7XOLJP9eG6k/lR
	ScEpwSV47VxbsKYdw+vnFZVe8DwolaSHvfRAhA4=
X-Received: by 2002:a05:6000:2283:b0:38f:4ffd:c757 with SMTP id ffacd0b85a97d-39d87e84b3fmr1340029f8f.2.1744183927443;
        Wed, 09 Apr 2025 00:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1PMwJ44PM7LbjW9qlmaMxkzVnUu1AIQlY9GTRrZoeakrYO1vlywPRAbPevQQr2y1XKuYxkw==
X-Received: by 2002:a05:6000:2283:b0:38f:4ffd:c757 with SMTP id ffacd0b85a97d-39d87e84b3fmr1340006f8f.2.1744183927137;
        Wed, 09 Apr 2025 00:32:07 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d892761fesm824803f8f.0.2025.04.09.00.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:32:06 -0700 (PDT)
Message-ID: <103301d3-4c38-428d-aa31-501654064183@redhat.com>
Date: Wed, 9 Apr 2025 09:32:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add coverage for hw queue stats
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, suhui@nfschina.com,
 sanman.p211993@gmail.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, kernel-team@meta.com
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-3-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250407172151.3802893-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 7:21 PM, Mohsin Bashir wrote:
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index 79a01fdd1dd1..e21a315ba694 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -403,11 +403,15 @@ static int fbnic_hwtstamp_set(struct net_device *netdev,
>  static void fbnic_get_stats64(struct net_device *dev,
>  			      struct rtnl_link_stats64 *stats64)
>  {
> +	u64 rx_bytes, rx_packets, rx_dropped = 0, rx_errors = 0;
>  	u64 tx_bytes, tx_packets, tx_dropped = 0;
> -	u64 rx_bytes, rx_packets, rx_dropped = 0;
>  	struct fbnic_net *fbn = netdev_priv(dev);
> +	struct fbnic_dev *fbd = fbn->fbd;
>  	struct fbnic_queue_stats *stats;
>  	unsigned int start, i;
> +	u64 rx_over = 0;
> +
> +	fbnic_get_hw_stats(fbd);
>  
>  	stats = &fbn->tx_stats;
>  
> @@ -444,9 +448,20 @@ static void fbnic_get_stats64(struct net_device *dev,
>  	rx_packets = stats->packets;
>  	rx_dropped = stats->dropped;
>  
> +	for (i = 0; i < fbd->max_num_queues; i++) {
> +		/* Report packets dropped due to CQ/BDQ being full/empty */
> +		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_cq_drop.value;
> +		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_bdq_drop.value;

I'm possibly missing something, but AFAICS the above statements can be
executed without any lock held. Another thread can concurrently call
fbnic_get_hw_stats() leading to an inconsistent snapshot.

Should fbnic_get_hw_stats() store the values in a local(ly allocated)
struct?

Cheers,

Paolo


