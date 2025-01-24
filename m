Return-Path: <netdev+bounces-160741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241D2A1B0FA
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 08:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656A3167450
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C51990AE;
	Fri, 24 Jan 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9eFQMPT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B53156991
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704046; cv=none; b=KJ1ayLB9e06i0sIEfiqvIXOaGdY58pIr59K3Dh4CQNjQLoQIb3BSnE1rdCbydcwbWMUlSSXv/fLMcal866LSflK5DXvhCF6ycegYCE+0w8QIEu7eZwhvZmNn3VSeSn4z/fwGrUubz7VZFi5xH8xYOmBN5jwyghUcoQztCHHhPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704046; c=relaxed/simple;
	bh=OIrCpY6gY1d6lq9XqdCVn+ZCYvGU6r0h96YsfV4FBUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNPE9qDdAaPvVIrjqojMZ78dgERtRp8vBVFE3W8w5W+Q25p6j/3E698+seRz/M452IklgtY+Y7+Q9FrB1A/I8uWJTBuy/URA0CDWj4EvWpEyXfNCZ6U8gPZMEx+rZJM5PIeejT4VsVhsPFr2E9VTfdZiKL0slNqXjJk9OuIhHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9eFQMPT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737704043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dnvkiyq+wfjDu5xMpTGYDVS6IRtFTjRJx5Qz4TzjUGg=;
	b=f9eFQMPTONt69dDYLH1KBdz8j9YfFS1ToZjVGNsAf2esNydsFNNd6ZoOl+WnT9GpZKXs38
	xli78KwvRrm+fLZ8cXv2O0PbL4Z++BwX+zgrT4cd7PewBN/1o/4bENrSetS7QJCmlaKm0Q
	vORMcAfmljkP13HLqYRUIoJKXwHd5WY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Yeo3X-4hOC2BkeOviZzW_g-1; Fri, 24 Jan 2025 02:34:01 -0500
X-MC-Unique: Yeo3X-4hOC2BkeOviZzW_g-1
X-Mimecast-MFC-AGG-ID: Yeo3X-4hOC2BkeOviZzW_g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362552ce62so8227585e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 23:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704040; x=1738308840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnvkiyq+wfjDu5xMpTGYDVS6IRtFTjRJx5Qz4TzjUGg=;
        b=Nj0mx+7Fsl6LEx+1h9hCtF6pSflewJnqX49jKlYhI9ynw17ZMR4Ny7fngzq1JwhrqL
         QY1kt4moJ9cJT7lmjN4EdBk5+gwsdmDUtktH1kQdcygCuT8RaGuqacBaTpMxv9DM1c7g
         noK2hNGerZ4y0P61FGtO/Kn3zfEK7k1qgWtyXklskkOLTPo6HW08H8Q/+OaAlSxLxVxw
         Oz6lkzFx4FUfb7LVjfhpn5CNz2AcMaob6cafLIgbn/yFJEBF+AMuLyAj1XHUP2GRvrWd
         4V3aDsrjlRlbKCHpqeQWWk8J1EIVJUvzczHYZDDHkD22sQ7XHsbUDXlke22sC46KD34z
         ejZA==
X-Forwarded-Encrypted: i=1; AJvYcCUerMBrmhYde5YngG9r5ByQBZj3UM/3bHHjc23lFDNmKfhoJz3VjNjog2BJnyZzB8wf/x5mQjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsP6eauJQq+dlx/9r+Pv3f4J5hSrUgX9a7MwBB1z+/BPZbvTY+
	HdbGJ4BYQ7JWEQhX7jFdH1qgvMt5aQJku8LyZPR9HGnEjvJ3T/51vpzRlpuGMBPSAa9OOCKBRWK
	I/Zus7quaLTesCOEH4KpJtZga1Z7kUsBPk46W+MziOocFj4xxNEU/2ZwrTuQeSA==
X-Gm-Gg: ASbGncsGVd21Vh9YIa6COgCt/5R05v2OUGlMP3qt6tmepPLUVYB3llOnpTc3H2IZ1jR
	xRbfs95YOQ1MpjFrtn7n9Ay5iAoJFyhz+G+1QHfUs0fWajuPn0VcD1ByK3XJ70TrOajN+4EHrCq
	zxoda9xZHKzGq0WRZXefB6Vlp28r9G/yBeA9felEaVUR3C9gIAu864uQCfq7DgRhKH7E4A0iRYs
	gdeLLjOEyuc0ZO99pAdcbUzdVbZ0nPYidKFHkrC7MVJ2cAy79d3LCzKZEmEWkc1eqI1Q8jjpiyD
	mmS6CepOh5JmI1soJMl0qb1w
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr320379455e9.14.1737704040144;
        Thu, 23 Jan 2025 23:34:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJYIeWaPKnHZudnlTsqBm9/6r+nALS5MlxAa0O6+Lva5Qyy1GIk8nruQMror/SyjVUmuj/6g==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr320379135e9.14.1737704039743;
        Thu, 23 Jan 2025 23:33:59 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-186.dyn.eolo.it. [146.241.89.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb057sm1861954f8f.62.2025.01.23.23.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 23:33:58 -0800 (PST)
Message-ID: <afad8fa2-344f-4253-b929-a888b99e90a9@redhat.com>
Date: Fri, 24 Jan 2025 08:33:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and
 homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-8-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-8-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> +/**
> + * homa_sock_init() - Constructor for homa_sock objects. This function
> + * initializes only the parts of the socket that are owned by Homa.
> + * @hsk:    Object to initialize.
> + * @homa:   Homa implementation that will manage the socket.
> + *
> + * Return: 0 for success, otherwise a negative errno.
> + */
> +int homa_sock_init(struct homa_sock *hsk, struct homa *homa)
> +{
> +	struct homa_socktab *socktab = homa->port_map;
> +	int starting_port;
> +	int result = 0;
> +	int i;
> +
> +	spin_lock_bh(&socktab->write_lock);
> +	atomic_set(&hsk->protect_count, 0);
> +	spin_lock_init(&hsk->lock);
> +	hsk->last_locker = "none";
> +	atomic_set(&hsk->protect_count, 0);
> +	hsk->homa = homa;
> +	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET)
> +			? HOMA_IPV4_HEADER_LENGTH : HOMA_IPV6_HEADER_LENGTH;
> +	hsk->shutdown = false;
> +	starting_port = homa->prev_default_port;
> +	while (1) {
> +		homa->prev_default_port++;
> +		if (homa->prev_default_port < HOMA_MIN_DEFAULT_PORT)
> +			homa->prev_default_port = HOMA_MIN_DEFAULT_PORT;
> +		if (!homa_sock_find(socktab, homa->prev_default_port))
> +			break;
> +		if (homa->prev_default_port == starting_port) {
> +			spin_unlock_bh(&socktab->write_lock);
> +			hsk->shutdown = true;
> +			return -EADDRNOTAVAIL;
> +		}
> +	}
> +	hsk->port = homa->prev_default_port;
> +	hsk->inet.inet_num = hsk->port;
> +	hsk->inet.inet_sport = htons(hsk->port);
> +	hsk->socktab_links.sock = hsk;
> +	hlist_add_head_rcu(&hsk->socktab_links.hash_links,
> +			   &socktab->buckets[homa_port_hash(hsk->port)]);

At this point the socket is apparently exposed to lookup from incoming
packets, but it's only partially initialized: bad things could happen.

> +/**
> + * homa_sock_find() - Returns the socket associated with a given port.
> + * @socktab:    Hash table in which to perform lookup.
> + * @port:       The port of interest.
> + * Return:      The socket that owns @port, or NULL if none.
> + *
> + * Note: this function uses RCU list-searching facilities, but it doesn't
> + * call rcu_read_lock. The caller should do that, if the caller cares (this
> + * way, the caller's use of the socket will also be protected).
> + */
> +struct homa_sock *homa_sock_find(struct homa_socktab *socktab,  __u16 port)

It would help the review if you reorder the code defining first the
basic helpers like this one and after the functions using them

> +{
> +	struct homa_socktab_links *link;
> +	struct homa_sock *result = NULL;
> +
> +	hlist_for_each_entry_rcu(link, &socktab->buckets[homa_port_hash(port)],
> +				 hash_links) {

This require the caller owing the rcu read lock, which is not always the
case in this patchset.

> +		struct homa_sock *hsk = link->sock;
> +
> +		if (hsk->port == port) {
> +			result = hsk;

The local port is the full key of the socket lookup? not even the
address? This simplify the code a bit, but is quite against user
expectation.

/P


