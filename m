Return-Path: <netdev+bounces-151369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD39EE6D4
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19C01886D1B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A973213E97;
	Thu, 12 Dec 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPBRfZ5y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FB2135BA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006861; cv=none; b=lE663R5nhYL78BZ7SOJ4J9Qii5tacCZgEiNS1GyyWPIUDrteBC74hUYqUDnarpCsBSvQj9ycALfmpIvX5jSElllVW+4qVbSXNHjADvu8ai7nqA6y4QNmy8X3B7Ze8OPc/O+VmYf2p5UfsI2o4IBcD/kdee4N5oPTn08cNRr2hUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006861; c=relaxed/simple;
	bh=QTYKzYJ8P+wrIWjw5+2v+V/VMSZt0G/32Y+VhjQeVfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHBw7jbbvGAnvPEMqYwp7qW7J/wC738tdQ0oEFgg6I61jAKZynjoMvd437bfuEvcEEUdJB1f+ty/GMzx17D+JxHx8Rwj6ErmCTwtbuPLiKgOBBZocsu4BDpW+iLrFOPu2d+tAe6eKDpFyjU5aDj2iDLoMjAlxR6m+vwvohQMu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPBRfZ5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734006856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mLtBgl+SysbS0Ef+Lb9W/oT5PrJbHCBzJ6l7870h3U=;
	b=QPBRfZ5y6Cq4Nb47niGJENyQ1jlmxmN5DKIRl3qYzY98fV7maoi9bfqTtNtMvQIeIhSAYt
	W0tayblSdJn004qVL7dR8yJgxrf4ZzvlevoblNp0lLVTVViJpa1ZiSTws+n1eTfQojywDj
	D/Gc9QCyEcjEcztP1SQ6Nu/4FPtl4Z0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-OAO3fx7SMbeiQtVjc2RVsw-1; Thu, 12 Dec 2024 07:34:15 -0500
X-MC-Unique: OAO3fx7SMbeiQtVjc2RVsw-1
X-Mimecast-MFC-AGG-ID: OAO3fx7SMbeiQtVjc2RVsw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d6ee042eso389201f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734006854; x=1734611654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mLtBgl+SysbS0Ef+Lb9W/oT5PrJbHCBzJ6l7870h3U=;
        b=Ul36PHWDfEz2538sl8PoW4NNuyMje2qzh8ah7Afk1Ovd90LcI2dCD0DSgsWfuTRE5w
         BtWqKNh/RA1S3LXHdmaJH0ARKyp1r2s28tiKapk/LSpsiCVcZzuuBUxv3HLTHUpKFMz3
         gSsV49wuLaUkz695IgUXbZE8CXrY/b27K5j++hIa30CUW+zDotgWvdprqhQlImnD2OZL
         qqEvq1IizZaoKJ2nfTf24d3aSOT9/OjjLNtrJ3lC0hQLovz2xRpHqDrbzaampO2iy/Ec
         cO+ArOJnB1hH0AxJcMZNvWTqo3PjWPrGgsbD+ppSWMaGB/0k9aybZUhY6KNthIRglCyJ
         dzBA==
X-Gm-Message-State: AOJu0YzuHjZ8pAPbmzQRvCSc1mZxNe2jWWpSwhm5jI6z6ME9mDJc8ZhH
	WPQX5JsExNMc44oHs1ah3YLQWHj5cB8XZDjoAKUISQJZAhkRHBK+f/6kujPwGaXQdYb+kbCcGqR
	qj0tt7gcBNEiiYPRRivseC8oeFZc4W1hSLBBZm7dHuVdxxP03vUYMGA==
X-Gm-Gg: ASbGnctPW5x0Og+Z5FPgqa/V3cuU4XiE7OlkGZm7qUvLPgkuVKohoH2JM91bgrBcDZa
	sViBwZdcdaQqhBD358DghHALmSLYwFeSgofy/dG2Y41Ql0ubqpX+UVJMj6oMCKJGcx9SIARFKeX
	XmuVgbL/tTU/jXNIYYfyFa2zpfPZgjNqwkfhKfM3oEBQ/oWdp/mauchjooxqrTC4LKIDM4Wz+3u
	F4zYrBvEeTrBpi8u1yINH+3MzKk6PSWejC/U3IfgXQfc/PwqB2Fs1wQlujY6/KTdv9jCyvTW6TS
	MmFv1Q0=
X-Received: by 2002:a05:6000:690:b0:385:df63:4c49 with SMTP id ffacd0b85a97d-38787694b8cmr2634868f8f.25.1734006854182;
        Thu, 12 Dec 2024 04:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKFIpvvO5FrMIj/gxwwY6P2EQZk9s6t4ubf9XmCYU+KxF0w2ZUetS2tCf4WKIM4VXCQK3BPQ==
X-Received: by 2002:a05:6000:690:b0:385:df63:4c49 with SMTP id ffacd0b85a97d-38787694b8cmr2634848f8f.25.1734006853814;
        Thu, 12 Dec 2024 04:34:13 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f440sm3888634f8f.17.2024.12.12.04.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:34:13 -0800 (PST)
Message-ID: <b7bfd346-71d2-481f-bb9f-e3bc1d6d53f0@redhat.com>
Date: Thu, 12 Dec 2024 13:34:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
To: Uday Shankar <ushankar@purestorage.com>, Breno Leitao
 <leitao@debian.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20241211021851.1442842-1-ushankar@purestorage.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211021851.1442842-1-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 03:18, Uday Shankar wrote:
> +static ssize_t local_mac_store(struct config_item *item, const char *buf,
> +			       size_t count)
> +{
> +	struct netconsole_target *nt = to_target(item);
> +	u8 local_mac[ETH_ALEN];
> +	ssize_t ret = -EINVAL;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);
> +	if (nt->enabled) {
> +		pr_err("target (%s) is enabled, disable to update parameters\n",
> +		       config_item_name(&nt->group.cg_item));
> +		goto out_unlock;
> +	}
> +
> +	if (!mac_pton(buf, local_mac))
> +		goto out_unlock;
> +	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
> +		goto out_unlock;

I think you should instead check 'count >= 3 * ETH_ALEN', and do such
check before calling 'mac_pton'.

Thanks,

Paolo


