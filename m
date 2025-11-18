Return-Path: <netdev+bounces-239512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC8C69045
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FE164EF6FB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46334E743;
	Tue, 18 Nov 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvSb8UDo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o/9BGXin"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F117D2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464450; cv=none; b=HLSpfJL79TfYyC/uHN1q+m5T8AhozimMsREOHVlArqa7wuEDH5lDva+oiE/EdtXSQ5orZZ5B9EsyNKp3DbH9L6s5OUQUxnDGy5ujB2vjgx8C1lv/Sz1bzyMX/sfKcABWT1v1y5GnkFv3YSgkFyI/zbkeMrbYbn2xSbb4VTi1IBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464450; c=relaxed/simple;
	bh=efPQ2GPZbHcaqb72drqznM/5StEztAnU+Hpr+cWM44Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgrjIr1x+pBtcpN+bCQmphdO1Mo5o1J8SbDXV8CgP+RoCGl1mlN66u8OTtSPDZDoPjNwEqzQmw055Y4mRsdODZY6CC//DEg0NNL31s65quxvIxXW4AKhSnJCy5Z5A/HVv9qZgOlciqWhUEfrMoBdpL9cenAr+E5b2GRXVqQpAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvSb8UDo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o/9BGXin; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763464447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqkT1JLVNyQbg4BrxPkFqafZU2u0WZ3cQXfon57AYzk=;
	b=OvSb8UDoXsH7Px8nmNLTlf+xyRf2dfLZwhpO6NQ7v7kZDNdYnyPEkgm3WZPEBzhs/N3GeB
	7pYkGOVZYQ/xFP7CLwbKpmwL+uF0GJG476ifSTExOU/GjehlzjKM1sgTEuu2EnPhXjNPii
	7qkbbp4CfcSt8W32Ex+rIWy9U78YQF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-0DZwmzyJMDmG8aHXzjFmnA-1; Tue, 18 Nov 2025 06:14:06 -0500
X-MC-Unique: 0DZwmzyJMDmG8aHXzjFmnA-1
X-Mimecast-MFC-AGG-ID: 0DZwmzyJMDmG8aHXzjFmnA_1763464445
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b56125e77so2477530f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763464445; x=1764069245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqkT1JLVNyQbg4BrxPkFqafZU2u0WZ3cQXfon57AYzk=;
        b=o/9BGXintNtSswLgCifDatfM1HOGndN4jo5CnZx0ZeX8yQ7/zwtpI1ok/v7BjpvF0b
         0cd8kjGfYYlTzKaYxjpI1G0N9/HSGabYMNnWsKco6Qok2uu1MzRF4Ww9L9hx8BIXu2i8
         RYBH7W58izmqWJVrc5lYZfZ0jKhZAfEraVlqlrZCwrNBWTrpjcctfOXzY+b6RIsn5Mz7
         JfLSkxd80ZGOIm6OY/RmG85i4/L+6AAVy6jS6M+uPlPkFVH0pJMjirWArkT+vr6QOsqc
         6bX6uj1uj/6sbY7zONPcuQZBAwEYzWyvR90cka8mL9OG6k0L6PoLI48R5wmMjk4Bg97R
         BUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763464445; x=1764069245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqkT1JLVNyQbg4BrxPkFqafZU2u0WZ3cQXfon57AYzk=;
        b=NyHWOKaQ2N3q35Emdfc0txSLrJvVXOFmytS9qoYpM/RvTxk1uZsGBd9BPNR3doFqxq
         ILUtufyDgIXepsjaiXtQ9Gv2QPY0sjCWtZI+ogr6zOxH/xPg/EsDaC3s5EVH2KWpqigH
         ZUjsIUwOgs2BbSZxRKqhLWd9hQ2zyMtVys4RhRWcg7Igq9fQlKj0KZQE256UcZFl5OFG
         qFJF3lOLj82NeWr5wVC2ihbNMGjvrnknP+ZD8Qa/hLauQzj8HEi83XTYiY7q8iolSbZd
         xCJJZJHBHYNsB3oQKjVn7mw0yEGg9VJY+u0VKQFtxaDZRSUxvlELxTZ3xSaIQXNfByTU
         7Pyw==
X-Forwarded-Encrypted: i=1; AJvYcCU4kLJKWhR10wDmPhjDeu6+lXNxDL3w4au7tV4D4diwWIl08TwMH+Z3OGUdjjTReQ2j5Vr2Ygw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+Ihij3Z2P3i92pxqjx3rxpakW1kjbUdfpbXy6ihTTvatemzn
	rm15Z6ibTOfDge8FZNEtdTgszUnAvqN2l7SM8uWCdTZ4CswHfYMmW5ayaBZNJJPo0NkZAnzXn2V
	V4BE7mTg9o6RzsqPXKuUfM/QSeGU93SWx7c8cpVzjsh3XIRItCruejcr/9w==
X-Gm-Gg: ASbGncvwxBCrUY+g3tNqz2i9fYJH2uHeluD+0IksYATluTFHI+/z776cfAm+b2hbQcU
	olVH/NRuBT49beRjYNG9xeq7qB9ba4eo1t346Zuob/6UuiRuEeq9rNLDYh91gjnmaDkRIG2Bupz
	WElhJceUAXPJUfUSBsZdjoTFVpTQ0RBKdiu7eg+CLHBCMb1NmfZCvZRkX4kxrYGEQYEGyMQZLlD
	dQ0fZtm1r1/rC/zb0BuZwgqw0wZfE/xFnzlpaglKDtp3Kt7x/qQD3MWWLrGgWQfGhJQHnCnikwO
	jtGZHedEVweWZlaI172Cl8bg7cJmngOvul1iuAG4DsSDhc+8xntPw6lfFDwvQ+wW+gZLha8adHb
	MQewOvjZxNfVW
X-Received: by 2002:a05:6000:2f81:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-42b593458a4mr14427881f8f.10.1763464444900;
        Tue, 18 Nov 2025 03:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzI+1MwV9bFISPAATDFoDz9OoaedqGDtda9aKCi5TBmtlwLrNaG/SQuA88H8MF5h5hv2Phbw==
X-Received: by 2002:a05:6000:2f81:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-42b593458a4mr14427863f8f.10.1763464444522;
        Tue, 18 Nov 2025 03:14:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f1fd50sm31415428f8f.38.2025.11.18.03.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 03:14:04 -0800 (PST)
Message-ID: <bb2b027c-27c6-4b6b-bcda-c10b71c30cea@redhat.com>
Date: Tue, 18 Nov 2025 12:14:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 09/10] fbnic: Add SW shim for MDIO interface
 to PMA/PMD and PCS
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net
References: <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
 <176305163578.3573217.12146311945675271827.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176305163578.3573217.12146311945675271827.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 5:33 PM, Alexander Duyck wrote:
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
> new file mode 100644
> index 000000000000..7eeaeb03529b
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/mdio.h>
> +#include <linux/pcs/pcs-xpcs.h>
> +
> +#include "fbnic.h"
> +#include "fbnic_netdev.h"
> +
> +#define DW_VENDOR		BIT(15)
> +#define FBNIC_PCS_VENDOR	BIT(9)
> +#define FBNIC_PCS_ZERO_MASK	(DW_VENDOR - FBNIC_PCS_VENDOR)
> +
> +static int
> +fbnic_mdio_read_pmapmd(struct fbnic_dev *fbd, int addr, int regnum)
> +{
> +	u16 ctrl1[__FBNIC_AUI_MAX__][2] = {
> +		{ MDIO_PMA_CTRL1_SPEED25G, MDIO_PMA_CTRL1_SPEED50G },
> +		{ MDIO_PMA_CTRL1_SPEED50G, MDIO_PMA_CTRL1_SPEED50G },
> +		{ MDIO_PMA_CTRL1_SPEED50G, MDIO_PMA_CTRL1_SPEED100G },
> +		{ MDIO_PMA_CTRL1_SPEED100G, MDIO_PMA_CTRL1_SPEED100G },
> +		{ 0, 0 }};

I guess the above could/should be `const`.

/P


