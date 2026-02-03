Return-Path: <netdev+bounces-256209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJpXG9C5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:03:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD5D68AF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E40D3043AC6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15A38E5E3;
	Tue,  3 Feb 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoknCRS2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw8NSo1E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752534C155
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109386; cv=none; b=hcMzyFdIr2d8x8iDPa7CR8Hf/jbxFIU8Kq1Qt/lkwqVRQqPsf1PrtgXkEvLuzmleHd6Gnn7Wky/4PDktf10sFu7X8XfICUrFaIRo0LTFHlyuZj4muAnYdcxzq8it2PUEvuXzEtUGHWzXGybCPSUVHSL4JeB7L8/L84ms7VM9wWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109386; c=relaxed/simple;
	bh=ey7g09tmHjrHthyWzQN5oKiXS3ZjDFHwb12bh0pLlOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNZiARgohvcO0G4j8Laf5SBmG/ZkSt7upaC5hDSIZOK2PnL9L46LtRSuvryk0NygR8B1FmK0kKmCFZdUvp5mlJlMU8xudcynpJ2Y7pf1QMWpKqAy+1uQrgXbjyOyt+Ukzdl9TXuhm2d6Gi0q1ciuEWzLZ6vVrfC86LZyFfpFj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoknCRS2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw8NSo1E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770109384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omsa6WLS8Wo1EZoK0PAaA8UmJG221+tHcswjEXaWc9c=;
	b=OoknCRS24bxhUDEvQuot4JtvFHxXAkDla1uSHjfVTDtdZeqkPS8okRYbWeBZeJIIDcqOyY
	pyKV+u4HDgiTMUSZ3pvdivt62qqQedv5ow1x11qNKmtIqKTuZ/HzbNaiqCp9ZpkeWzPtnj
	TrJBERjxm0Y3UZyfFxzUF9nK5ma6Zpo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-Q1lPwpi_PRWgFJoUQgdYvQ-1; Tue, 03 Feb 2026 04:03:01 -0500
X-MC-Unique: Q1lPwpi_PRWgFJoUQgdYvQ-1
X-Mimecast-MFC-AGG-ID: Q1lPwpi_PRWgFJoUQgdYvQ_1770109380
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so52806215e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770109380; x=1770714180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omsa6WLS8Wo1EZoK0PAaA8UmJG221+tHcswjEXaWc9c=;
        b=Fw8NSo1Er7yfE7D3Ia82MCbNYyQ/BtdM6aiaseEkXBT4C5A7nj5zifDfBSae2mNTEa
         gZC9cTwCnrb6ROMQ5Hwf6acraMbKQ/atdydI0TKkiTymIgJ/rLLCUX//HJCyRw2SwC19
         cYV3cwEbqVdqjgopCT1lP6NQlxiRnOBNNWjmgOZZWeZYYm+QXku8C7Mi6mSRGs1y7ApH
         SlzXPbi14G32JkADtQNuzD0iPUSVjHSX5eMECwBo6/CgBI7AQ3LaaQjVKeELxAXR0Q3o
         Ur4UWknkv1U9oXYngt0w4Eu++8pCP5XPscZPddhJ/rTFAiLkGWD+795UeD2ZqWd8tEwV
         OdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109380; x=1770714180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omsa6WLS8Wo1EZoK0PAaA8UmJG221+tHcswjEXaWc9c=;
        b=ofMqGzeZSFR56YHy0zcKeNSkbAcz7YXGgUfy1XLSb/1DrWjsoa6N+pEurATXbpnA7N
         uS2joyA8loyha6OnSksYNNDMT9nrCq1aAo7k5HbmC1bSCplHimN7Aj6vxd8o6BQz3H00
         Ftfo41bTf/hvyndYIgaR/NtzV1ubZtF74BXyaHz1yOM7WCz8iSFNgPmWxL9gbZlvGyAM
         tW7u5C6PdJ1sH9QbWxArgWYxu1UhWdtQqJx3G5oMRSqoScrsH2OouDQRiRz9UqSB9Uyt
         SlPfG/KK58T/EcQmAiAiT7eC7ih1JfCOwIAe8Vd5k2bG08ybFJlhPtC8V0vTWue3k6wd
         bN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVQC4hOY1f5KXGfVzhpr2+0zWcfJjlDMZ72ZdQu21OA0sANYWxgbwlW8jH6vF93FtMG6kE/K/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGRl7ayw3D6XW1e/YTPz8sCcXefOShiHGYLZZVzISSDvowW+4
	qrGQVPV3DfjIAkITRqqGOav0FEg70Kkru+BCRY8srqIBYV1whK/W6qV4bfNrYhlaNS+2UJeGMpM
	SMRNvu1rm7Fspc6Y1pveIxvwQGN2wmUiwZySO5/nqbNniEz2RbQF8jpRz5A==
X-Gm-Gg: AZuq6aLms/1fL+gpetWYL/7E4mLN09Evt7wJBqjmFIS5cv1yqy8R/mFkAyvRryFlcXA
	ryLGf79OEUu6DRGTa4tbgaKT5K4Bb2d6LEPSK5z+AbHnkmnXNRDdUHIZyZ6fTAwhde4LrEWyj+x
	Zy19hRVZmh6nq6mrLXLqUpl62jaurdQkjZKs61y5M96hkPW3bXAYJAv04e1tWEHvYmFEvRVYEmO
	lb6jGUOH0w5Pgp24xMyCAmMzkE99o4BZvCeifTnhzsHLqwv7jymBGEB7p44BfuR20OCeR0JqI3+
	SQ0YBpg50r24aXUpcg8XKMUj9lzThM6Zwutbe04Pz7wDquI7nOtyFl3p3ofT64zBZx4ZAIVb3Zf
	p6mp9X9wkRN0=
X-Received: by 2002:a05:600d:8449:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-482ef7258admr100181225e9.8.1770109379860;
        Tue, 03 Feb 2026 01:02:59 -0800 (PST)
X-Received: by 2002:a05:600d:8449:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-482ef7258admr100180885e9.8.1770109379457;
        Tue, 03 Feb 2026 01:02:59 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512e0edsm51945985e9.7.2026.02.03.01.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:02:58 -0800 (PST)
Message-ID: <51ea0ddd-07d0-4995-8c0c-faf526c2a8b2@redhat.com>
Date: Tue, 3 Feb 2026 10:02:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 05/12] virtio_net: Query and set flow filter
 caps
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-6-danielj@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260202170518.9076-6-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256209-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8FD5D68AF
X-Rspamd-Action: no action

On 2/2/26 6:05 PM, Daniel Jurgens wrote:
> +/**
> + * struct virtio_net_ff_selector - Selector mask descriptor
> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @length: size in bytes of @mask
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @mask: variable-length mask payload for @type, length given by @length
> + *
> + * A selector describes a header mask that a classifier can apply. The format
> + * of @mask depends on @type.
> + */
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[];

Is a `__counted_by(length)` annotation relevant above?

> +};
> +
> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
> +
> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: packed array of struct virtio_net_ff_selectors.
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];

Similar point here for `selectors[] __counted_by(count)` and `actions[]
__counted_by(count)` below.

/P


