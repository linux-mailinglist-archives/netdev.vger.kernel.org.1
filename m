Return-Path: <netdev+bounces-213348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E5B24AA6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A00B1BC5D2E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE62EA491;
	Wed, 13 Aug 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="zts5AfOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957F2C9A
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092060; cv=none; b=c44cW9GzL0364B5HzD4E/cJw8CVnhGIhAOYOhDEJ5RKDLPl+opfVyjYQgCFfipYPgaXZBHqhHqqjeQQ1PHM1z3He8A3KgtJhJuulHLdiLNDX9U4DDeKxRv+pNj8NfF8oEt51vp8Welan3XX5o2NK9X7NdO+Kb0ZHxEHyJLd7ocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092060; c=relaxed/simple;
	bh=fNSC8w8HU0S89hQRnFJWFWREK6fXZjS72GfrRn4HArw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWjgvfSjifPv7l2o2N/S0n4QIuJrBTFLfY7/8/3cT3LyLtby51eITDU7sdbjW1HygULkVv9lNjTVyFoRa4pCfljT3EZZfv3vAwtRUsxHIQ1uKQmuC8tBf8V3jFIDAt15VAwABSMeVGkKDgK8P9dIJVizE3R6UIDqdS29UPnS1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=zts5AfOi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b792b0b829so6607151f8f.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755092056; x=1755696856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNSC8w8HU0S89hQRnFJWFWREK6fXZjS72GfrRn4HArw=;
        b=zts5AfOieDGtIpBk2bnNnf3iiJNQg6K8rn3kUC9fc4ndoyX9jnBrcU6x6iHb7qUO3B
         8Glfm88viDrW9fYLImCF3awDhsXQR5j/9Tnspf/hNTi9a7Mxgbvk9/N9uSpofAZXJUes
         duIyApbZ6pD6Jiz4KTsHNefl2uEGh8nOzy/3YVUIWQAXYq18DdXxZh8vt48lfG0IEhLJ
         ZiOztvyokuujAtESWcStkFuHzqrErEhVYgbCK02GiOjp30kScY/UGyJ/baxuuqSFjY/h
         KLqSDClYxOULDu3kFVDRMsf5tILszqYQawDpI7xnlW7MpiZFyoDFCCF85NNB7YfKQiBj
         IN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092056; x=1755696856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNSC8w8HU0S89hQRnFJWFWREK6fXZjS72GfrRn4HArw=;
        b=d1Ubd2jMQNCw93G0vcUPf6+hd3HTs97s9tCgdIZaP7AK6uCeCOcimZa92vix1FQBJw
         k/93m5S/quxPpa2bGwE54BiZ8M0AKdH9lixc3zTMyfJk19HrsfDi6f67wOVVTMVNHHhH
         ggWv5X7+ykSxIfl11P/RRLCTq5mddxC8Oj4+K1hPvSkjtF0cvX2/GXaq6Q/CPEkzH9Pm
         AHCZgAsOX2gZZTjU6PurUvulFdBkGb5yKfMP8xsWJpyDRuLJajXe8EbCnk4oLU+/zgSm
         jVtixgcuokfnaLm3qAq0Sxotc3+IfkCoNZ77WAvg8nsnpKrNRT2UTPZBbFE5fIXMKNXE
         vUOA==
X-Forwarded-Encrypted: i=1; AJvYcCUUhpyjhoyfpaa+A3SUCZvjxm3kerMWh1+bzrh6RGzItlZjEuQQ53iKLOer5zg9yiRqypLVCRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXRarzA95e3n7ZaXsGnZd6U8lgzbBkaGzLqmyjXCXOFcBXRr/
	Rv9/XiIwNVFlPIMnTrozcfXNP6PM47gG1f25et8Gm50uIM3kYqKl9qRqt7g5rJu9oaU=
X-Gm-Gg: ASbGncuUvXST6rE0/DLZyen7jzMhR1P3E4w67SPahrRgR5xRE0vlJYHf8FIYHsFNx/2
	EKHsVwkXTqufobDcUJhrLGUHzTEz68pysQtswycIQbQ6I14aXGHIJiLEVi+yp46kp/4GwqFOH2h
	LDWY7E3w4O26nPQXWUG7ifUT0JkA5JFTAfykZg9BmxuA8V52lICj/yTmAqJvZC2vvQR/F1TJ81U
	K80u1XgIgKgCq3euk85vR8dAJzlIKoe4cJ6xZxF1ntxhwZ5tCUPY6h5IevovNiPQBoP9QW/Q7nB
	v8kObUeDW9mHSAF5RoJN0ZxBYZAehP/YllSPbFdcX5UaGMaNe9DYaQKosldIEQpY2HX+K7R6epq
	rs9hgnF2rXj0/EvpNy706garlBuFTV0FbSjTMIwGiveVJUSAlm/uSkP3SwZzffCrm3zw0jGsv76
	52S9lvxUWdmpTH+IOTxD0z
X-Google-Smtp-Source: AGHT+IGyWBRLcYyjmPdaFJ7RJMvGFJChrNnUkFexYqA+15BorH+hR4bUKBZZRC1EER2gmnrpcLdyVA==
X-Received: by 2002:a05:6000:26c9:b0:3b8:ff3b:6437 with SMTP id ffacd0b85a97d-3b917c85890mr2243633f8f.0.1755092055765;
        Wed, 13 Aug 2025 06:34:15 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:388a:2f48:ed4:7e0e? ([2a02:1807:2a00:3400:388a:2f48:ed4:7e0e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0846777sm37944948f8f.48.2025.08.13.06.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:34:15 -0700 (PDT)
Message-ID: <463dcfa3-152e-4a48-9821-debdc29c89b2@hammernet.be>
Date: Wed, 13 Aug 2025 15:34:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] riscv: dts: spacemit: Add Ethernet
 support for BPI-F3
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn>
 <20250812-net-k1-emac-v5-4-dd17c4905f49@iscas.ac.cn>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250812-net-k1-emac-v5-4-dd17c4905f49@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 04:02, Vivian Wang wrote:
> Banana Pi BPI-F3 uses an RGMII PHY for each port and uses GPIO for PHY
> reset.
>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>
Tested on Banana Pi BPI-F3 and Orange Pi RV2. Verified SSH shell over eth0
and eth1 interfaces, and basic UDP connectivity using iperf3. Thank you!

Tested-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>

Kind regards,
Hendrik

