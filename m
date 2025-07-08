Return-Path: <netdev+bounces-204911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EFBAFC7B7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7AF189A134
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4152080C4;
	Tue,  8 Jul 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6LkYvGT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A281E25FA
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969015; cv=none; b=IUc1oXfpuY/8D7be28AI5p+U5fGDFpJtSMKvh/RpxWiAA/YhBOhKLCscZzrmzDXeh+td2e9/NYorQCi1Z5YwO8o4Z/nL952dhuDo2E6yGUCso0hbC8U06yyeq0Wo+xeaUux1oJFa1ufg1OlQ/NsW18bxqWYg5ilQhqVrQOgZ3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969015; c=relaxed/simple;
	bh=J8x/CPUWA0HL/cid4XRRf2yJGc3d9K5BSR2KvtLBWhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/bd73cd3hPam/MxjNg8FYwHx+nufAS027QFho/FMupaKoaQeWfuFhHmZjOlN0xWoaEkeZlCpa719OCFP81R1VDZiRViM1zEikpb13t/jRN4OqfG8R3f3BUKWCAha4BgOwRc1pYRgJSUNm6ItJDnQLyNS25eUrVr/NcqrbCwiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6LkYvGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751969013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YHab4xqAP2Akdg2G04m0t1Le3rHcVZpLaQPZJUOZ1g=;
	b=V6LkYvGTE6pn07RAvUL5Fx1HtVgO77Fgo8kv8Rm78GVrhQ1PwpBMKi7zNb+f6d+Q4WXarM
	01re35gRccT+vnASoZrum+Hqtbxd8pVS7yDNXvU3HRj8DEYah9Zi87uMc9mJ28wfFpvYTx
	loza9DCppkRwI43MvZze3S/NhmdQXco=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-23ZL1iA6OnCs32RymlKynw-1; Tue, 08 Jul 2025 06:03:31 -0400
X-MC-Unique: 23ZL1iA6OnCs32RymlKynw-1
X-Mimecast-MFC-AGG-ID: 23ZL1iA6OnCs32RymlKynw_1751969011
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so1775141f8f.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969011; x=1752573811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YHab4xqAP2Akdg2G04m0t1Le3rHcVZpLaQPZJUOZ1g=;
        b=rozOs9xVf777gr4awVkNlXNvgBYASCFNdShooeHB1DCaAoLduF/iAkrs3HLIz29pbg
         KBr7Vedbmw6EqTcYF/FdlZfyn2n77uxbGLMisB1Npiy8wVgjCq3/kgxxydLhpZL3l03E
         wSVgth1pjivtMcZh9bLJDe2Ev8OHZxsJco3ngvcHrNMisIT1g8vnpkbuLHBckgUjl0yP
         P8gvQLXVfiXR8C/WlAIt6Zn7WWeSx8GzopWsenzsOKXG+8oZabNDdyOhEdcxHiE5pnUX
         ESC5Dc9mAWneK0xAe0lPZmScXrHEdUcegH5Yc867oC7KBzyo7KXu+kvaP/y6iaN0QtDn
         mHXg==
X-Forwarded-Encrypted: i=1; AJvYcCUArg4qobdylovY/i8aD7D7PqvOZ8Lqgbsq4qtzkBVbJbC7Qhagzt5mjXSKcMSW2BsYTXLqr0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8HGnd04ArDvYxk9vfC7eW/1OZNzjnLPjMPPD9EIq4tDeV6wN
	i1uh6psHULfgpdUpyPAk6ymHFsFNwutljeghT2HA41fCqXofN0FpXJ8oF8xLp8kAyoK+00eCa7V
	Xn7/TkimgloSG/yGJkZNZXj/mob0MDlnW09a6Xq8mpc1s8ew/LtdD68c4nQ==
X-Gm-Gg: ASbGnctjarWB9yPxYUrPahGc2LKIv9KOnLKsck3UcsOqVklSyRJg5G76WrhWCJmSjw8
	wqSxjDSEyem/CXEfPjxY6nUsZvKhywtYmZu4PG+zd7A2gp6titI++CMrJVjmvgWlAegcxBeVdJ+
	V0njwj+NFArTP9u5Z/gY3tiVs6L1hhbLHr9HT6om5BDU7Hok0VXJxzrCG1Ot+ADNRD1fFLY+2L0
	S1gYHc9eIBT9jc1pIMjoYaCWT8wtZoAnBLbFt4krKaDnUCpaKgGAuGocIRZtnAbhXci2jbrtXY9
	rch9TaC839doVp9rHnFVq4rBZoTwl9RWt77+jUdj0uTKYYzm2o5xriIzQJI8JMQKOwvmEg==
X-Received: by 2002:a05:6000:1787:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3b49701198dmr10216089f8f.8.1751969010548;
        Tue, 08 Jul 2025 03:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1SvwWcO9VGXYTPULjJBC0m6vJeUr2jVKEuOXwryHw29XUGkc++r6gFKLLfQS8l/e7j3Mcpw==
X-Received: by 2002:a05:6000:1787:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3b49701198dmr10216057f8f.8.1751969010016;
        Tue, 08 Jul 2025 03:03:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba48sm12695745f8f.13.2025.07.08.03.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:03:29 -0700 (PDT)
Message-ID: <ea22a546-9381-48c3-8bb6-258fdd784ca3@redhat.com>
Date: Tue, 8 Jul 2025 12:03:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-7-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-7-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct cbd_t *bdp;
> +	void *bufaddr;
> +
> +	spin_lock(&fep->hw_lock);

mtip_start_xmit_port() runs with BH disabled. The above lock variant is
inconsistent with what you use in patch 4. Please be sure to run tests
vs the next iteration with CONFIG_PROVE_LOCKING enabled.

/P


