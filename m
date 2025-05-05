Return-Path: <netdev+bounces-187683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C86CAA8E40
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312B4188D8D8
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E571F3FC3;
	Mon,  5 May 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5C6l1JJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5B1D63CF
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433735; cv=none; b=e6A9NKlnr6XU8bIVabj+Qz2clS4Pf5oKowcUL3Jz2I0LISS4zQUfF4JEPQYeybz5oxQw1ijiHp1xHCB2i5f5V/if+x1ndNtq2+GPPBHIgggfBGl99+PveMTkUgjWG9DHt9xzL0pQJ5B//PPGuAI70j0pQYnW7yjZlQAoN05zZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433735; c=relaxed/simple;
	bh=XX2GLy7M69SyjpKH6D50B0FbBqeW874P3U/byTPKH4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO6gl+J/1NjiGt2CSr009Rnqvau0wMcZ3rpPmBsz31z/0yiR/5QUY+lYcfABWtYxV3V9ctE6a38T5eEguSJxnAOHGK2AETUL/fRwwzFaZ5sUPSeRLvmNd75k8Cv1EPwiZuAguZ+XKTCf0kUd5UZ5/+3BX33VeSlPgwjgV5a9O5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5C6l1JJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746433732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcdgmM9hhmqmoQj3mRT3moQ2aAyMiniR8OXULWzEh0U=;
	b=G5C6l1JJK8nnDhwFRSDxqJlU4DI+ZUO4IBFi8G31xigJe6TMZ6BGMJysXLtqwEkJF1tIhC
	qSSBlab98wOJqZzURpiqwAm8d0iZp80qE0KOVWzCBrGaGVI23p+vsUhvhXiPebDQGvJi8W
	d3aWoRiz4Zwx5Z27vd3Vn1Jlo7BdhT4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Uxouk0GhMlyAPv00Ej16lw-1; Mon, 05 May 2025 04:28:51 -0400
X-MC-Unique: Uxouk0GhMlyAPv00Ej16lw-1
X-Mimecast-MFC-AGG-ID: Uxouk0GhMlyAPv00Ej16lw_1746433730
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so22143125e9.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 01:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746433730; x=1747038530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcdgmM9hhmqmoQj3mRT3moQ2aAyMiniR8OXULWzEh0U=;
        b=NhnGaMOEfvxbG0p5rSKwuyo/uIyhL8O+PnWQruNDaAvdPe1UYE9LS1A2aZDW53b6aL
         1LDV3ij85rYuL5Yh/y1rW5jOaiGYDICkzl4uSve1D1Bu2Vv2G4I52UD4nHUZj42qeyDo
         Xf2L7KmI1Ilsqiyx0f1CPAQLjJUiyX3ju1rDl2uoh2jxOmi3t2pVKzYL4iD/+YrRu/Gi
         rsT/c7aB/CgNHrrCJHL1zflRnUGT44/CryxL+90DnauXJtG5qhojcnoQwr1DGfgWBRRA
         hQbGGZukeA4U49LovA4evXiWWzwOL6582RZZFC3iRhKJiWOnibSv0zs/qIGQ5IDJmuXT
         Onmw==
X-Forwarded-Encrypted: i=1; AJvYcCUpXv1og0fpA5We9Ku19beH5wPVGofXIqGgkcUJnGwTLypRG8GiKTN4Ej6QZUVp5wJ9+xRU99k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0KRbHlXLf0KL/Ug5O63mnZi+VtDVOubdbBn63klW67bpBO5i
	wcUwHqM4Ld2mnf223LgYhLPnP1jYh56fnAykwvxVrkxFpSxcqK8RdVgDALEKUVAfOMxH0LbpszW
	u5qbaeZo9NJuoKPfGGEj64MT9+dhfXOuZaTIOwRnDNSEjKyLmxSCkk1BmodEU545PPPM=
X-Gm-Gg: ASbGncthsqeYBFEURMOJcsTX7zFxjvKIt8Dk80Oc/ZzWSHY+ya64yWb070s8MuBsVZK
	ydZG1LLjveeyWyFJtCZP9E40Zv1+oozlZj8IIphh58oHyDHB7RThUo0+JE5MhbsmzeWX7ePU/ag
	qGdcs9/SYxe2HjB6AemBRUGrKnx6J68RYg9ruASPSVr/DJhYN/8NQL/TnlUG8CvJ9GkuLThk17z
	zrRkxZ91k4A93e1Gfz1NvwlfIlWMJX9cqR7xEOdw9UgMu+wOymKDWKbi0SuSgcJFP0NXhO0JzeG
	SbQRjLANXFq/JEJ03w72j7g/8NreLJuxH9AMj83vYyaudwD+UCToOyZfqxk=
X-Received: by 2002:a05:6000:1ac9:b0:3a0:7a8f:fc73 with SMTP id ffacd0b85a97d-3a09fd72e95mr4933793f8f.14.1746433729937;
        Mon, 05 May 2025 01:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEpnrS8LLunlYEmjzbbhBhPi8LfSfQDUYsRi9armU69qn7iXQkq+5O8/A0fV+sLFEgLylDeg==
X-Received: by 2002:a05:6000:1ac9:b0:3a0:7a8f:fc73 with SMTP id ffacd0b85a97d-3a09fd72e95mr4933772f8f.14.1746433729475;
        Mon, 05 May 2025 01:28:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0cafsm9755381f8f.19.2025.05.05.01.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 01:28:49 -0700 (PDT)
Message-ID: <835b43b9-b9c4-4f09-9ce3-9157e1d9fea6@redhat.com>
Date: Mon, 5 May 2025 10:28:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 02/15] net: homa: create homa_wire.h
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-3-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-3-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
> diff --git a/net/homa/homa_wire.h b/net/homa/homa_wire.h
> new file mode 100644
> index 000000000000..47693244c3ec
> --- /dev/null
> +++ b/net/homa/homa_wire.h

I'm wondering why you keep the wire-struct definition outside the uAPI -
the opposite of what other protocols do.

> @@ -0,0 +1,362 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +
> +/* This file defines the on-the-wire format of Homa packets. */
> +
> +#ifndef _HOMA_WIRE_H
> +#define _HOMA_WIRE_H
> +
> +#include <linux/skbuff.h>
> +
> +/* Defines the possible types of Homa packets.
> + *
> + * See the xxx_header structs below for more information about each type.
> + */
> +enum homa_packet_type {
> +	DATA               = 0x10,
> +	RESEND             = 0x12,
> +	RPC_UNKNOWN        = 0x13,
> +	BUSY               = 0x14,
> +	NEED_ACK           = 0x17,
> +	ACK                = 0x18,
> +	BOGUS              = 0x19,      /* Used only in unit tests. */
> +	/* If you add a new type here, you must also do the following:
> +	 * 1. Change BOGUS so it is the highest opcode

If you instead define 'MAX' value, the required update policy would be
self-explained and you will not need to expose tests details.

> +	 * 2. Add support for the new opcode in homa_print_packet,
> +	 *    homa_print_packet_short, homa_symbol_for_type, and mock_skb_new.
> +	 * 3. Add the header length to header_lengths in homa_plumbing.c.
> +	 */
> +};
> +
> +/** define HOMA_IPV6_HEADER_LENGTH - Size of IP header (V6). */
> +#define HOMA_IPV6_HEADER_LENGTH 40
> +
> +/** define HOMA_IPV4_HEADER_LENGTH - Size of IP header (V4). */
> +#define HOMA_IPV4_HEADER_LENGTH 20

I suspect you will be better off using sizeof(<relevant struct>). Making
protocol-specific definition for common/global constants is somewhat
confusing and unexpected

> +
> +/**
> + * define HOMA_SKB_EXTRA - How many bytes of additional space to allow at the
> + * beginning of each sk_buff, before the IP header. This includes room for a
> + * VLAN header and also includes some extra space, "just to be safe" (not
> + * really sure if this is needed).
> + */
> +#define HOMA_SKB_EXTRA 40

You could use:

#define MAX_HOME_HEADER MAX_TCP_HEADER

to leverage a consolidated value covering most use-cases and kernel configs.

> +
> +/**
> + * define HOMA_ETH_OVERHEAD - Number of bytes per Ethernet packet for Ethernet
> + * header, CRC, preamble, and inter-packet gap.
> + */
> +#define HOMA_ETH_OVERHEAD 42

It's not clear why the protocol should be interested in MAC-specific
details. What if the the MAC is not ethernet?

[...]
> +	/**
> +	 * @type: Homa packet type (one of the values of the homa_packet_type
> +	 * enum). Corresponds to the low-order byte of the ack in TCP.
> +	 */
> +	__u8 type;

If you keep this outside uAPI you should use 'u8'

[...]
> +_Static_assert(sizeof(struct homa_data_hdr) <= HOMA_MAX_HEADER,
> +	       "homa_data_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
> +_Static_assert(sizeof(struct homa_data_hdr) >= HOMA_MIN_PKT_LENGTH,
> +	       "homa_data_hdr too small: Homa doesn't currently have code to pad data packets");
> +_Static_assert(((sizeof(struct homa_data_hdr) - sizeof(struct homa_seg_hdr)) &
> +		0x3) == 0,
> +	       " homa_data_hdr length not a multiple of 4 bytes (required for TCP/TSO compatibility");

Please use BUILD_BUG_ON() in a .c file instead. Many other cases below.

/P


