Return-Path: <netdev+bounces-215619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F02B2F951
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E512E3B0D1C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7B4319844;
	Thu, 21 Aug 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6Od+pzD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35C31AF38
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781128; cv=none; b=RYbfRWpmKH9hb7ixvYIV88NG1tQTpFINKecfBbIfCWTgXYDCnY4CBuVtCLJKk4Hk1u7OQ7VifxM9+J5uCZ1wmlcw8E/eun9vuFmFXjiiGJ88Kk0zjCfZGYydkY33/s4gIArfxfqFDguoah/aH0KSh6EE5r7aowbw9kNMeSiVUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781128; c=relaxed/simple;
	bh=UmDrSVDQW61OlvQ/IGYxMAsgvIJ7POsZmxmcj0A/NJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kp/ZHtkHSD3dEY/UNElN/kli66k0phwdYGK+Tt7uRk2lNCqbS/0IGHYPKm1+8tK30G0pwXjSpoLtrLaNuzoDrmh7hf8PVpftceaLXCEMZkva7MKdm9QK9NwRxerZQEg86Hh4GiYOc19/B+ligZGXV0lUxFuuoCShyRRbBAr6DqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6Od+pzD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755781125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IN9LRocJtUUiNrQBqBO7to/5wjV3VgWDXDoteVLDx8=;
	b=B6Od+pzDkDblqz2w8lgKMHqdDmXj7usC1b6/hAit8d2XiqTZRvHD4C+Gs5nrTth7x4ekIW
	XVl33Gi1X1WNj4YSDUmz8GMPR7IeFmQqs1tPu0S/4QCeRZDXjFjXxCWbT4yyRriLuVd/73
	ifvLtJCL+8VvvehqKSXAC642gmql9Xk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-JE0-tz8bPHePeXFbol4wlg-1; Thu, 21 Aug 2025 08:58:43 -0400
X-MC-Unique: JE0-tz8bPHePeXFbol4wlg-1
X-Mimecast-MFC-AGG-ID: JE0-tz8bPHePeXFbol4wlg_1755781123
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e86f8f27e1so311930185a.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 05:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781123; x=1756385923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IN9LRocJtUUiNrQBqBO7to/5wjV3VgWDXDoteVLDx8=;
        b=LcKPA3Z/mMz7y7LmzKm+6pVZkvY5RBGtTv8g2QmuOrg6s4UjmUyeA2TJqEBMW1Jj56
         UyWVduUwdre+HQH8HiYLhJI9MfUsYP2RCZ3fmxIra+DMkhsYL8SUpuGguVfdN49cTkqi
         g7/18JvSL8Ut00GspXDH6hkePpH7j91XkGC4yy9o81F4ejjbM7nfNuvpgIZLMJyS7FBF
         WCR8Rd2s0gyYtQptvMk82sYmjGHDpVMT2FqUGt/Y2u/GPG0P6M+opX2a3iSO5xcIyKRi
         hS0R6Ti97Cz5jzh+mPkVVqeWy5rIKLtOSSO/ljgrJqwUa4xoeYp5mLvc0L4OT+oVQWUR
         Po+A==
X-Forwarded-Encrypted: i=1; AJvYcCWEJ8GDDq+xIDIkcZdlNl8frbcK5f7xBchB4osNQx1D+GQywaypeZtvFocOygxtJprOfz/E/7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6FbQaIlvGIRbwU22tDn3awkd6cftBKlOgXk6HYE/dVvKAoLq
	ezu/Rib8h91DbqFNIDYgTzxMcBgLXh6bl1smJaPmtpNBDVW9KwJ2O9FHX6vtdhFAaQeYQ+k4ydK
	TX3/R9rIvpIV0xkFjAzxxwJHKFpbdn7t4uQoS0ph+YXbXnjAXbYuXnb4rcQ==
X-Gm-Gg: ASbGnctKAOu64cfUG/KJpLCedvgCvmhpVSD+54715Yz/CBSIqI4uHgANGCK/YFw4sBc
	Xs1YtjjQiPic7dgs5ej24iCgctdvDLh7/4phi3pjkG4d+56XQHhpLIKET0Sb0a3nREpS6Jn5bn1
	h+FBzZR1arCG/moA6WnKqc24A7shipEp12ySpmSS+/qjMGntmRj2+tV6lNybDglmMmcbw8OY2bj
	RvrAyiTD4UCTaKT5sUyVc6/xiw3kyJr6/tioX17jc4sspiNsvKBGS2p/zB7w4vQArY9CU2r03Ki
	dFE/yS9Lu0rizSSDN6u+xHYhWC/Up1asThSitYAdXnRe9VaUNLQVp2pDlRbNZzitCoje8ezDQuX
	xvX3f6Qigaa0=
X-Received: by 2002:a05:620a:7101:b0:7e9:f820:2b2d with SMTP id af79cd13be357-7ea0972278cmr193924685a.34.1755781122858;
        Thu, 21 Aug 2025 05:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeLCUTHxEtHASKMXXKEyJ4YpoMztM3prkSUwTcVyjkV1jcsAE3AD3QhjWbx6EIt/TNb6CzQg==
X-Received: by 2002:a05:620a:7101:b0:7e9:f820:2b2d with SMTP id af79cd13be357-7ea0972278cmr193919585a.34.1755781122333;
        Thu, 21 Aug 2025 05:58:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e06ef54sm1114950585a.34.2025.08.21.05.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 05:58:41 -0700 (PDT)
Message-ID: <c06ff3eb-f69d-4bd8-b81a-a28b8b69ba52@redhat.com>
Date: Thu, 21 Aug 2025 14:58:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/15] quic: provide common utilities and data
 structures
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
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
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1755525878.git.lucien.xin@gmail.com>
 <7788ed89d491aa40183572a444b91dfdb28f20c4.1755525878.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7788ed89d491aa40183572a444b91dfdb28f20c4.1755525878.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 4:04 PM, Xin Long wrote:
[...]
> +void quic_hash_tables_destroy(void)
> +{
> +	struct quic_hash_table *ht;
> +	int table;
> +
> +	for (table = 0; table < QUIC_HT_MAX_TABLES; table++) {
> +		ht = &quic_hash_tables[table];
> +		ht->size = QUIC_HT_SIZE;

Why?

> +		kfree(ht->hash);
> +	}
> +}
> +
> +int quic_hash_tables_init(void)
> +{
> +	struct quic_hash_head *head;
> +	struct quic_hash_table *ht;
> +	int table, i;
> +
> +	for (table = 0; table < QUIC_HT_MAX_TABLES; table++) {
> +		ht = &quic_hash_tables[table];
> +		ht->size = QUIC_HT_SIZE;

AFAICS the hash table size is always QUIC_HT_SIZE, which feels like too
small for connection and possibly quick sockets.

Do yoi need to differentiate the size among the different hash types?

> +		head = kmalloc_array(ht->size, sizeof(*head), GFP_KERNEL);

If so, possibly you should resort to kvmalloc_array here.

> +		if (!head) {
> +			quic_hash_tables_destroy();
> +			return -ENOMEM;
> +		}
> +		for (i = 0; i < ht->size; i++) {
> +			INIT_HLIST_HEAD(&head[i].head);
> +			if (table == QUIC_HT_UDP_SOCK) {
> +				mutex_init(&head[i].m_lock);
> +				continue;
> +			}
> +			spin_lock_init(&head[i].s_lock);

Doh, I missed the union mutex/spinlock. IMHO it would be cleaner to use
separate hash types.

[...]
> +/* Parse a comma-separated string into a 'quic_data' list format.
> + *
> + * Each comma-separated token is turned into a length-prefixed element. The
> + * first byte of each element stores the length (minus one). Elements are
> + * stored in 'to->data', and 'to->len' is updated.
> + */
> +void quic_data_from_string(struct quic_data *to, u8 *from, u32 len)
> +{
> +	struct quic_data d;
> +	u8 *p = to->data;
> +
> +	to->len = 0;
> +	while (len) {
> +		d.data = p++;
> +		d.len  = 1;
> +		while (len && *from == ' ') {
> +			from++;
> +			len--;
> +		}
> +		while (len) {
> +			if (*from == ',') {
> +				from++;
> +				len--;
> +				break;
> +			}
> +			*p++ = *from++;
> +			len--;
> +			d.len++;
> +		}
> +		*d.data = (u8)(d.len - 1);
> +		to->len += d.len;
> +	}

The above does not perform any bound checking vs the destination buffer,
it feels fragile.

/P


