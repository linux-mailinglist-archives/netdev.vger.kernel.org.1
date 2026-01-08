Return-Path: <netdev+bounces-248046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80780D02730
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D53B30CBA2E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C321352C2C;
	Thu,  8 Jan 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC9MpLAp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKeyG9mK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC8486B99
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870996; cv=none; b=KsSStO5yghHzHQ9ku0qprV7kZOCDQZazAlhOPMdsZUWk/2ow6D/Kr6kUS/ZORMIvYrFZuOrn04U5oGLH1fjPsp1QO15lFTi/NSZZ6FDuMzdJiYl+DwyUs1bMAPlmG9EHwx6WX+GJh0LAht5vmIUV91KUEC34ztkcAJyf9VySTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870996; c=relaxed/simple;
	bh=f0uGCTSwPTYZJTNYDNMp/keoPX6ADIjnXIWpyV78Od8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sx2Yxjr0VWVs2LSR+ygYbfwxMXLKp0QsN93B/hhmle/yM4299UkxqSYgIqhHnFONt7tSeVAQRNF78ThVrUgGDdklahyVzZCqdpPLrtCWSW4v9Mi9ACyQo+KK9eTC8+3d4IjDXZM0fljJNpUxVI20Xx9n/RiAMgeuWMmNOyhDQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TC9MpLAp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKeyG9mK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767870992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJRtpdk3QL9oOI3hi+tsdde7GeB/zLo7cbRVz+hyZxc=;
	b=TC9MpLApIhH3ZuW7o49k8lPNhqvchc5973aJt/ClNEZU3qKKR8O1alVX7ybxFNR2Jjy60r
	eEs7ghD9mBOz0BbUpr9YCsLlR0U0m2HSzfOpZbIxoQyIe+jPkuyiwjtZ8MNan42MuarX68
	7VutmVSGd6YXs7xJAW7pybqvUL6Yb5g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-p2fl9jr7NL6ge81yTkAptg-1; Thu, 08 Jan 2026 06:16:31 -0500
X-MC-Unique: p2fl9jr7NL6ge81yTkAptg-1
X-Mimecast-MFC-AGG-ID: p2fl9jr7NL6ge81yTkAptg_1767870990
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso34598575e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767870990; x=1768475790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJRtpdk3QL9oOI3hi+tsdde7GeB/zLo7cbRVz+hyZxc=;
        b=jKeyG9mKx9MlNa2bH7L/YoED0fteGJurcjF8vcz9vthmrbZ80VuVpAxrjUTMLXQIJG
         m/8YvpsEWrBSVWkZpIUFYynlvs7nqqbM4NvcP+JEUr/x/3IxV17fdL8i/ObLUplrDx00
         m4eq8ipgl4rZ2bpp0+7slEfNsSA89WaHyZUqA8F+SytMMfvMyOznWTMCjj6BYDRtdvKp
         ZtVeUhaATEo3L+KiMrqjBHLRBHEgvRnEem+fQrMpRqqj2y8bXHNPuEqZQpXqDMEC4XVg
         /DKpFtj3Pugo+MBw995lCSTNiiMI5A2cYTQYdoTTnqOdySVixgr2J+W+0qCOE1RImiA8
         0Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767870990; x=1768475790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJRtpdk3QL9oOI3hi+tsdde7GeB/zLo7cbRVz+hyZxc=;
        b=cyVZvNlX+RNairUfnT4ZpcyLq2qRLQgHg0OxI3GnxMb4Ld98wLMTS/9Q37/OdbXCJe
         8j2Pv3rD6lGVFuAzTjnfL818Mjql/58KPHXajv6QbJN0zZDibwa+kHCB4jYg/MBltWQH
         QukUv4MGtJT5ynCOMmtVeXktMbG+N9ctyBLv6LZ6WEYxPuhTILg19E6b8qhrpluxeF93
         7Tawr2vvH+Zc6XYY5BO7kpAz5Hj316fcF5Tn3dI4NUnKrxZ+LRd3T964EVL/TUfV044/
         tyreZUEjyMISjBpd7f9LseTeHyMFlB3MqE1CAF4DfWFGkVwIB7VpU3zZ515E7g80n49A
         WpNg==
X-Forwarded-Encrypted: i=1; AJvYcCVVG0zD1JdXQEcbDGj0VBspvP+tgk65C7WsaOqy6HBPbAZ/aD7prbWe+VONXjQc8dOr0ryT/ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0EhZa344WZ0RBLa6PDN1292NiElLvkO2KTNdeCk+Js6Mj9RH
	JcS+QDuXkwGHYI/3+YwnIATpOirp0Xkv1poZihEhj/WRW2959mnCU1RH6Wz9Pvj7i8ajDv7A0O4
	auqj0kmgEQ7OmPoz7Gr/xC0yPLf8CckAiHU6ODsfmb6GB1g3mhAj+lYnslg==
X-Gm-Gg: AY/fxX4AWpi94wTzY/nh21Dxo2rHJ8vNSKjSPzfP1n5ni5eGV/4Eq32a+9a7iI+eIRz
	aoA0dY74zRjNP9Cz8E0gYOKjU5AwyxhFKVyOQbLoJ1ZJQ8Q+XE72oDx2FAIJuhf4BLims5NXmMI
	jbqVv1m54U4RR9YuUF1Xypu88JI86wkTvUyoenhj+IuXI+Qmc3tf+P0gJfyEIDtpHfWN3J4mRus
	p1i0nThJIc33pRUy8O9JBVIF9hIvcRjoeaeXdKkCUOjcIED//8uIpwwWPvhLH4kVhoBW9sP8Kf3
	yGegTdLSkm6dydcF5s2bRrspW7UxD7nHpDeEOpoOD+nfJICR2xJftQZaAJp3eVx6RpUdzq3kLrx
	HqM/L9St1YfDF3w==
X-Received: by 2002:a05:600c:1d0c:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47d84b1fcf9mr65378825e9.14.1767870990013;
        Thu, 08 Jan 2026 03:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECFAYMklkN8ocTu4Dz3mO638bkTteVgtAQQ9rUydv0hMcGqTqfp396cLkFjrtdp1r5gRDhPQ==
X-Received: by 2002:a05:600c:1d0c:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47d84b1fcf9mr65378425e9.14.1767870989533;
        Thu, 08 Jan 2026 03:16:29 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d870c73c0sm36623355e9.3.2026.01.08.03.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 03:16:29 -0800 (PST)
Message-ID: <40be3195-62e0-483a-9448-cf8a342d95f6@redhat.com>
Date: Thu, 8 Jan 2026 12:16:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/3] net: ti: icssm-prueth: Add helper
 functions to configure and maintain FDB
To: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 danishanwar@ti.com, rogerq@kernel.org, pmohan@couthit.com,
 basharath@couthit.com, afd@ti.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
References: <20260105122549.1808390-1-parvathi@couthit.com>
 <20260105122549.1808390-2-parvathi@couthit.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260105122549.1808390-2-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 1:23 PM, Parvathi Pudi wrote:
> +static void icssm_prueth_sw_fdb_update_index_tbl(struct prueth *prueth,
> +						 u16 left, u16 right)
> +{
> +	unsigned int hash, hash_prev;
> +	u8 mac[ETH_ALEN];
> +	unsigned int i;
> +
> +	/* To ensure we don't improperly update the
> +	 * bucket index, initialize with an invalid
> +	 * hash in case we are in leftmost slot
> +	 */
> +	hash_prev = 0xff;

Why 0xff is an invalid index if the hash table size is 256?

> +
> +	if (left > 0) {
> +		memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(left - 1)->mac, ETH_ALEN);
> +		hash_prev = icssm_prueth_sw_fdb_hash(mac);
> +	}
> +
> +	/* For each moved element, update the bucket index */
> +	for (i = left; i <= right; i++) {
> +		memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(i)->mac, ETH_ALEN);
> +		hash = icssm_prueth_sw_fdb_hash(mac);
> +
> +		/* Only need to update buckets once */
> +		if (hash != hash_prev)
> +			writew(i, &FDB_IDX_TBL_ENTRY(hash)->bucket_idx);
> +
> +		hash_prev = hash;
> +	}
> +}
> +
> +static struct fdb_mac_tbl_entry __iomem *
> +icssm_prueth_sw_find_free_mac(struct prueth *prueth, struct fdb_index_tbl_entry
> +			      __iomem *bucket_info, u8 suggested_mac_tbl_idx,
> +			      bool *update_indexes, const u8 *mac)
> +{
> +	s16 empty_slot_idx = 0, left = 0, right = 0;
> +	unsigned int mti = suggested_mac_tbl_idx;
> +	struct fdb_mac_tbl_array __iomem *mt;
> +	struct fdb_tbl *fdb;
> +	u8 flags;
> +
> +	fdb = prueth->fdb_tbl;
> +	mt = fdb->mac_tbl_a;
> +
> +	flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
> +	if (!(flags & FLAG_ACTIVE)) {
> +		/* Claim the entry */
> +		flags |= FLAG_ACTIVE;
> +		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
> +
> +		return FDB_MAC_TBL_ENTRY(mti);
> +	}
> +
> +	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
> +		return NULL;
> +
> +	empty_slot_idx = icssm_prueth_sw_fdb_empty_slot_left(mt, mti);
> +	if (empty_slot_idx == -1) {
> +		/* Nothing available on the left. But table isn't full
> +		 * so there must be space to the right,
> +		 */
> +		empty_slot_idx = icssm_prueth_sw_fdb_empty_slot_right(mt, mti);
> +
> +		/* Shift right */
> +		left = mti;
> +		right = empty_slot_idx;
> +		icssm_prueth_sw_fdb_move_range_right(prueth, left, right);
> +
> +		/* Claim the entry */
> +		flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
> +		flags |= FLAG_ACTIVE;
> +		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
> +
> +		memcpy_toio(FDB_MAC_TBL_ENTRY(mti)->mac, mac, ETH_ALEN);
> +
> +		/* There is a chance we moved something in a
> +		 * different bucket, update index table
> +		 */
> +		icssm_prueth_sw_fdb_update_index_tbl(prueth, left, right);
> +
> +		return FDB_MAC_TBL_ENTRY(mti);

AI review found what looks like a valid issue above:

"""
In this branch, FLAG_ACTIVE is set on FDB_MAC_TBL_ENTRY(mti) but the
function returns FDB_MAC_TBL_ENTRY(empty_slot_idx). The caller in
icssm_prueth_sw_insert_fdb_entry() then writes the MAC address to the
returned entry (empty_slot_idx), leaving entry mti marked active with
stale data.

Should FLAG_ACTIVE be set on empty_slot_idx instead? For comparison,
the other paths in this function (lines 270-277, 294-306, and 330-342)
all set FLAG_ACTIVE on the same entry they return and write MAC data to.
"""

Generally speaking the hash table handling looks complex and error
prone. Is keeping the collided entries sorted really a win? I guess that
always head-inserting would simplify the code a bit.

/P


