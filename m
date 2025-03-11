Return-Path: <netdev+bounces-173946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DAA5C740
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE36F1884A28
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365325DD08;
	Tue, 11 Mar 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPdcg8Gl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6A15820C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706924; cv=none; b=OHGBe1NnYAoVcqG6F7858kGOySDpAdy9emvWMQPqI9Pqkcyrrif3jn7lbANAu7d40LbDtIbPfeSPIpFz0hAdalpGTRnsv/r5j8i5iIMTfNJmOvztwBAuYIDyVWmZSQ8bMFbGRSDb6BfFi0HtPE4bCJYE5Ca7/kYm5LlKkJ0tUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706924; c=relaxed/simple;
	bh=HUuhRZMDSac0gs9Pj9dvQIwL1QqFRoLFTK1kjKyykGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nj9MLpKuP50v7zR7AYtpODnJ/F8vIDfoxHmJUeZmZlEeHjypDJw9NwnLk7KRbRfeQ3bB/FYjMdoePpDsblP6Z4kYrXEhRBIDTV9p7RTmJTD18LLf102GHStUMCKOabl/dqq63TSmKc9MQaAY/gySpvsdYNDt2coY/HHB9AA4TRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPdcg8Gl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741706921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lh0ElixOQcM752ztNtq4uB4mX4z/xgnwJOU9R+tFvIA=;
	b=BPdcg8Gl2COb3/Y4Ju3tXjSIxYkqCIz+EK46oFYeg51R3PeGjoQBsjr157SvZyhpWu0Xc0
	LeJ4AIZu8pC8KYHyp3T9gv60a9bDfccMXXWSvqtvyNiU130ZPz/fqTNAQeBcz2hGIF4yDy
	CZmdyRm8ka8zDTPZqLWysgkCVk/Dr3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-l5WiF12HMR-LB9JFpki15Q-1; Tue, 11 Mar 2025 11:28:40 -0400
X-MC-Unique: l5WiF12HMR-LB9JFpki15Q-1
X-Mimecast-MFC-AGG-ID: l5WiF12HMR-LB9JFpki15Q_1741706918
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so28287055e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706918; x=1742311718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh0ElixOQcM752ztNtq4uB4mX4z/xgnwJOU9R+tFvIA=;
        b=j7XFC1kCBJJKFWoZh2jenZRs7rWaIRJQsSsaftxzdukP3ruHKhmu8iqUbhxr4RGsvY
         /1MuwJcQDtJWS/ls+fB7NW+8g+mxyN0GoTtheSH9HU+mP9EifIE/a3qSG5f1tfO+rzIH
         LVzES7MaHXlMcAAGOACot4rqpsLR16xICpsdVVqAX9CcMYaPmko1TO7OpPEUfwC+pbsm
         8/4bnDxJbL+MuPo2fjfOfdJidNw3r11im9nciUcfQi6PnMgosiEBYrTTF1j2Cmm7dvIx
         EiRUKiDDMywyYG+ZiS3v4nwWCjXIHf+Mn/gjKJtoM7Z9ZZv4P5VapBeVvQzb2X1vQtbc
         CmOw==
X-Forwarded-Encrypted: i=1; AJvYcCUMP7USYMQlxdeYGWdI68pDer8OvA5NAqQYNB2R8ohddZ+JA0lDeuC3czWrIau0+IyAqmDOFL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7N6spLOafEH7/TPjk3rn8xZ8WnrYkYIiwuPLWo1JaqPL3UhMC
	NVSJcwdGBQfyLkklxv8SNS0NGoEnH0Dwao04NIUVS/wL3/09TbR74RWiQGuol8Mi6v+A0+ZKB9R
	/kUFGqoPGyaE0A2stod1HIBTyJv9Y5mdPKSTOabDgpooiEHidpTKDfw==
X-Gm-Gg: ASbGncuRiCJFeUZAUMkgFCAwvKlozGbxfRLVr0KtN/ClMKZ64Tku3A4QhgrDZ7QIjI/
	R6GoR8SmenhZIHwnQ6J+SC/IRguYDBd1SpcK+wp1i3u8Q0DbnD3TBvqO/dr2J6SaHVN6WQ5itaK
	nT7xwWOuVFQf4UtJQp7+EfUtHokxYq9p/vnURXy4bvhGDr1Pw/XywDwdPEkWRnA8pUVSF4F0CZc
	bLkMH8Ia9P4UeVGq4IkOVHGScAShBDt3JGPOz3t7ac6WMg8LezdNsWqi+zYbPlF/lofqkc48jKB
	M7bEwCBmQsz9dE3+yc+mdKhXUjmfPHvi5aMlA2NMyX6dww==
X-Received: by 2002:a05:600c:3510:b0:43b:cf12:2ca5 with SMTP id 5b1f17b1804b1-43c601d9145mr140068145e9.8.1741706918275;
        Tue, 11 Mar 2025 08:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFlZLiiYbgqbmcVUFJXH09bt/QrC1tz5cTElUrcP1d+/C3HI3kWS97AOHnKYkVmnXtko/Itg==
X-Received: by 2002:a05:600c:3510:b0:43b:cf12:2ca5 with SMTP id 5b1f17b1804b1-43c601d9145mr140067855e9.8.1741706917873;
        Tue, 11 Mar 2025 08:28:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf0c42eb6sm94668545e9.16.2025.03.11.08.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:28:36 -0700 (PDT)
Message-ID: <c6d1c981-7a5a-4d63-baeb-1d81c388f526@redhat.com>
Date: Tue, 11 Mar 2025 16:28:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 14/14] xsc: add ndo_get_stats64
To: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org
Cc: leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com,
 masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 geert+renesas@glider.be
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100858.555320-15-tianx@yunsilicon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250307100858.555320-15-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 11:08 AM, Xin Tian wrote:
> +void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter,
> +			     struct rtnl_link_stats64 *s)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < xsc_get_netdev_max_channels(adapter); i++) {
> +		struct xsc_channel_stats *channel_stats;
> +		struct xsc_rq_stats *rq_stats;
> +
> +		channel_stats = &adapter->stats->channel_stats[i];
> +		rq_stats = &channel_stats->rq;
> +
> +		s->rx_packets   += rq_stats->packets;
> +		s->rx_bytes     += rq_stats->bytes;

This likely needs a u64_stats_fetch_begin/u64_stats_fetch_retry() pair,
and u64_stats_update_begin()/end() on the write side.

/P


