Return-Path: <netdev+bounces-250936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0CED39C05
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F90D3006A7B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDF1F4176;
	Mon, 19 Jan 2026 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRDBGIjg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A02C86D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787056; cv=none; b=h8n3gTxiT8ikS6kBFIeHL2jYi2ReGa3Yz6WDzL4R6lPVOfM+NdeWo6wRp962nUvBQsJzKmHs9UWe+5RZr3h9kn6djP3avf+oszvUayIPlNMUUoECznZfmMeHuUgVPeWr4MNda6Q52pTYxsmE/E5JyD673RmlsJAbZAVsGpGMXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787056; c=relaxed/simple;
	bh=7q+R2/RHzVQW5cjTjhhJh8W9Bo5v5oSb7JGW/NI6s5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyBaYv26c7kD6rSGWNewd+37edHDfuc75OHncOuwBFrddSr3KgDrwOt5uUExAyIX1xXBF3LIpfvVqGPdHfd+KSrxiRqBHENJWgQEvsYXEjs2BRhfU4AH/i4YTH3Xb1LIP2ZctXFNHHP9XPowtygH0HBZkL5/g/pBBUXCXlQ2h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRDBGIjg; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1220154725fso2856797c88.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787054; x=1769391854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNXKzv0XBaJNo8dt2IzChTr0sf06VY1ICo1CXdPMe5M=;
        b=nRDBGIjghN28alxm0XHzyA758qyhFhrd/ByzhPn7e7/EPuhNCi5UopjWOsZI8WtqtU
         23dmXIAMJSlZ6q97JLkvY04sc9jVNQoNq8ytJ66L4fAJDBEoFPWdF2KAvXqbDR1CyEfi
         mmINX7UjGW97BHHSaG1k9NaCdPnpFWu9VCKNTC8ObOlcxVBqiYIJGyWOhGv1HY4XH0LV
         EP+bhCMKznL8oRWMYa4BAdbAXyYqowWDk8RYBOrsVT1tNs94b2cTTTr3aI18Nq/WeLWc
         9u1sSZ99IHEravffjWcn6+cd5IOR/Doww4LL5NbnqUZajNijawtfJXtN6EmJvq2S0O4e
         F0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787054; x=1769391854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNXKzv0XBaJNo8dt2IzChTr0sf06VY1ICo1CXdPMe5M=;
        b=UWH41SPGCA2evYlqitYN5HwVAYnE8qH3/X9eBBQOFMmkaGmuPjzWpegIQbo2s7m9KP
         cmEY00V7AtpKnmQ894H8Vm2A3dcFUKRgq+gcd5sVZ8gSIZj2j7j5Yq0KOadRuztzkd9s
         s7XeYoHyceBFO0mfzb8ljP2VsGfooF5vzjMDou/WV/BXYYoKdZOmtvy++mk5O8dp1eC1
         CwKzbX8ZnR3L3Wjf94jA50tLH5OOuUEpw8K7xN/yyT+YzJBuj1G7+TFnNE9UUs1P6SkA
         9o0HLuu/b2pomY+ufS5hwmpXK6b0evPip/UNHfvRuDRBsOoBxhhnpgx/JEQ9vXbVPpEY
         d4zQ==
X-Gm-Message-State: AOJu0Yx3nXlMwLbM3Xc8tcJkXg7lCoFgTmg9rwY2iZJcAiux46ynqZ+8
	HijTyLco9a+b9snS9fJG90GQlRKk1omp4uzoGov1FKeyUeIq98C7G9w=
X-Gm-Gg: AY/fxX7oiTQOOAgqI5eep9IAcEGP247hfBFU7kbYC+rIzZOnz0uiXshD8CRrENPnmlv
	mYWGi/BCXyDPV/0vcmWs23ac4iDM/+/X9LjW3doXql3x/AWXgfA468pC5oKGIxVPC12iB7yhtu4
	pIZ6l+2UQ/A4dvxRqhQwdjKfhbpafK4HjqfpsXtf1UufeG3mOs/LrUkm68jLffQBIlN4fhZ7hVy
	4wGZq4JtdRa15MYGQOH0ws3RU9aWWprEJnr6aVCpOTT1EpNOkiSqmvOFE7YdBPi33KWCNwvXZH3
	fR/CAvor/oAKbxyg2MwQRBTgdOCWsNCp0ssmx1X8rLkyyMN2YC8PODk7CYHQO2UreC/uKQCW3iK
	AoUl4+zwfh9z7AZzxUS20rFgqzc23md4NYKcU9FSaMZO1W4960OpAle9WmKJugWnq8faAS0zTY3
	0lRINiloDDir7LvAxXOGDvuJwNNsYuhNeTvtFS9hbJISFLtIhJPBF9tbNDMAHu8wE9TjZBWtgsw
	OvDSQ==
X-Received: by 2002:a05:7022:3b89:b0:11b:9b9f:427c with SMTP id a92af1059eb24-1233d0add9fmr10454242c88.13.1768787054432;
        Sun, 18 Jan 2026 17:44:14 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac585a9sm12174458c88.2.2026.01.18.17.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:14 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 02/16] net: Implement
 netdev_nl_queue_create_doit
Message-ID: <aW2MbURmxRBKVvEC@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-3-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-create \
>       --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>   {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

