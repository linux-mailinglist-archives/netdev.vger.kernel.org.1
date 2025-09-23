Return-Path: <netdev+bounces-225575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B2B959DF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7873E168EAF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D7321299;
	Tue, 23 Sep 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHahVRyX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E6145B3F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626501; cv=none; b=W/fQ2h5shz0EdvI2FWDnyUNYNS6FNiqC420++/uReXsX2Gx51k5olQybAoRvAeuWX93a8nRyl0451EPVuGi8Uo9ue0mj/2TK2o2gbTcNn0Lc+t1SNVzK8zB9ZGuMNXQySEaK1nqydu+v0cBd5bBkirgnXuSgYj3jqyp01lo5A8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626501; c=relaxed/simple;
	bh=t+QZDhTto1uLLFwLELmutlOR0nLBR5O3CYGMg93yR9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEebCTkgJ8uxPoFXAUclOi3BG2h40BDMF9oYEZ+byJGtJk6yTb/pNcMq8+faweRy/fOFufA4BYGFgfLS287gtXDQ2V3C0ecf/zG+AdwMmIUp5wsmvSFMrR9k4dC/V/tVOD8dXVxXLXjauviKsNtOI1wFYoDKjQekHwvU5y8s7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHahVRyX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758626499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRiwAmUD+4/mMUYIIKXqkLb49gsCM2cGlAg51GqgPDQ=;
	b=XHahVRyXxa1ur/96lz9oUCwMiWbLZiP77AJ3Ic1BsOiULYjIRvQfwJDNqYyJAmTM2WmuFa
	ZtF0vJBe+T0u5Tr+A7jNjBgJ7qLoHdk6D7JGhMUxnx9qLAm/9RF7SYd+FCM85qZSv4NUV/
	np/xVQCdVsWhW/pjFYQfojKz1PB3WJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-kS30CTpoMN6kTuyX77IYVw-1; Tue, 23 Sep 2025 07:21:38 -0400
X-MC-Unique: kS30CTpoMN6kTuyX77IYVw-1
X-Mimecast-MFC-AGG-ID: kS30CTpoMN6kTuyX77IYVw_1758626497
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e1ce52196so7735495e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 04:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626497; x=1759231297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRiwAmUD+4/mMUYIIKXqkLb49gsCM2cGlAg51GqgPDQ=;
        b=G79OC+bHm3N2RGeNiQo6VfJ89/RFBboy/tj+c6OrXC+8F1dKG05XHtnE4bNsfDfyAi
         R6iasQD5F8ZMBFymXUpbZIW9GqsqSJVyI2ZY8mcaGPddN2Etc4CUFb3T4vhO7VUFjmWL
         mJyX/u5oniZJBGOQJXyVHpJYwk5U/wR4Wv7w1L4NhoPxktE0GXLp1nHE/zypiA0m8Pw5
         fhYidsgggqcwSuCNpTCBBGW8TWYHD4xkC1/7VmJHIkYCGWYMtH2AEDS9l62/srBW3ZnK
         d2w+CTHmbC5Vxowh/hwsyDGbyCbq6XzR5RgUpmj/Ge8+kLlDVHYQt674ddmwJr8OqwhE
         BoEA==
X-Forwarded-Encrypted: i=1; AJvYcCXgGssYur4kyZq7CO9aPJePNQbOfPqopzxE/MMLzcz4rsy42y10W8u+Cg1oTCqfjlxoVzhwoLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0T7oVUKzvieuLCJqpTCMCVhZ8Zf1+1uBrqZWqXPyk4wV53N8
	3f1+GaMIdRaLDub2z/YKhyPTH6Oeur1vRRLRUhchIFZe6mpqxnLZWLW3UdlFyQZVl+6bUxn44V6
	RJj+E3lqItdUceAy02CDAsFovcN1VCgbHSjMHwjoxqigD4Lor8xvisTigAw==
X-Gm-Gg: ASbGnct538hKDF4IZSSiqQDVMHQZptx+5mODDqfWPHyeEa6JRh1V7tMslcPrj6u8p27
	hAYjYMm/pftjcET5YNv01CLWfdyHWq/pQoeMnFWRDFaGO+qcMpiOx14Ncsm57EkZDLtHETXPJPK
	sFuiKL68LpNlqAFBMspS+QXW263Lftf4TRj9si38A0UG8FE3Z0iegonsLG6D8n7oQQ/dXgy+Xv3
	tT4GIoBvJ/+mkp0Q+OiLLkR7tN2IckW3rjBNmqF/eLqyoijdycqcbxNCE1xGdrx13EEgXwqmjGS
	IuRaeCUduuUqd3yJlRVSkjzo724WG4CGEv5O+CRO7ZIjXDmJ4ijPaMgIJShyCZTVTLQYHJe0fde
	3Q3s0SIE3f8sL
X-Received: by 2002:a05:600c:468a:b0:45b:5f3d:aa3d with SMTP id 5b1f17b1804b1-46e1dad1bc0mr17677925e9.21.1758626496744;
        Tue, 23 Sep 2025 04:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVl5LwJCSoJe18fqUI2zrrluC6snkXwQxOKaMoTUidlB/HP/Iah2lrSfVasHGUh0FtzoWWMQ==
X-Received: by 2002:a05:600c:468a:b0:45b:5f3d:aa3d with SMTP id 5b1f17b1804b1-46e1dad1bc0mr17677575e9.21.1758626496239;
        Tue, 23 Sep 2025 04:21:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1dab52d7sm13706445e9.2.2025.09.23.04.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 04:21:35 -0700 (PDT)
Message-ID: <871ed254-c3d8-49aa-9aac-eeb72e82f55d@redhat.com>
Date: Tue, 23 Sep 2025 13:21:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/15] quic: provide common utilities and data
 structures
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1758234904.git.lucien.xin@gmail.com>
 <a7fb75136c7c2e51b7081d3bff421e01b435288f.1758234904.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a7fb75136c7c2e51b7081d3bff421e01b435288f.1758234904.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 12:34 AM, Xin Long wrote:
> This patch provides foundational data structures and utilities used
> throughout the QUIC stack.
> 
> It introduces packet header types, connection ID support, and address
> handling. Hash tables are added to manage socket lookup and connection
> ID mapping.
> 
> A flexible binary data type is provided, along with helpers for parsing,
> matching, and memory management. Helpers for encoding and decoding
> transport parameters and frames are also included.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
> v3:
>   - Rework hashtables: split into two types and size them based on
>     totalram_pages(), similar to SCTP (reported by Paolo).
>   - struct quic_shash_table: use rwlock instead of spinlock.

Why? rwlock usage should be avoided in networking (as it's unfair, see
the many refactors replacing rwlock with rcu/plain spinlock)

[...]
> +
> +static int quic_uhash_table_init(struct quic_uhash_table *ht, u32 max_size, int order)
> +{
> +	int i, max_order, size;
> +
> +	/* Same sizing logic as in quic_shash_table_init(). */
> +	max_order = get_order(max_size * sizeof(struct quic_uhash_head));
> +	order = min(order, max_order);
> +	do {
> +		ht->hash = (struct quic_uhash_head *)
> +			__get_free_pages(GFP_KERNEL | __GFP_NOWARN, order);
> +	} while (!ht->hash && --order > 0);

You can avoid a little complexity, and see more consistent behaviour,
using plain vmalloc() or alloc_large_system_hash() with no fallback.


> +/* rfc9000#section-a.3: DecodePacketNumber()
> + *
> + * Reconstructs the full packet number from a truncated one.
> + */
> +s64 quic_get_num(s64 max_pkt_num, s64 pkt_num, u32 n)
> +{
> +	s64 expected = max_pkt_num + 1;
> +	s64 win = BIT_ULL(n * 8);
> +	s64 hwin = win / 2;
> +	s64 mask = win - 1;
> +	s64 cand;
> +
> +	cand = (expected & ~mask) | pkt_num;
> +	if (cand <= expected - hwin && cand < (1ULL << 62) - win)
> +		return cand + win;
> +	if (cand > expected + hwin && cand >= win)
> +		return cand - win;
> +	return cand;

The above is a bit obscure to me; replacing magic nubers (62) with macro
could help. Some more comments also would do.

/P


