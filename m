Return-Path: <netdev+bounces-248129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E37D048F5
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F847354ECA0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D533E37A;
	Thu,  8 Jan 2026 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duboADyy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n+tlCPK1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C926E175
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886565; cv=none; b=FtUsn7OPzXoJuTpQiFLTeWNv1uqYfP5G+ITd9wgLlLA+G3HRbJKHk3N8aVg+IBpJnEzIqZnCKAIPcHECdXq7ohG/FxEdhWMfC1cvJQd7SlXewHj8uEn82x7NnjdYFjz6L2g47aHaNNQkVoeBa5Wb7BsH7A4hMzbI3nAl/MIEQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886565; c=relaxed/simple;
	bh=NKOwiPZMksNsVlmICgHUyde/kre1yGZPZIKBPuvUi8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt42/0iPHJOSwOWiqbZfG+nHyROptwWZJEfK2kZNt+PNFVBRVnlK/c/Op1La9V4/H0RnXaqIrzX1NbNJIvOsNkJmUsY1wrLRL6L90M/7taUrLS94pHmBRGUEEZgkRbnCiw/h+wAxV/e1qZVdjBH3MZ+DnpLXq0ggyg3PpuJlbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duboADyy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n+tlCPK1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767886561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKOA6bIG5gqeJG8Qpb8f66GiNtAZiz2HEDO5SYzczYQ=;
	b=duboADyytAa26cN39qiVa/k4oLWwtziie0CjrB+xRpJglMMfbFZsQ7GcZV5/sxnoXM8kJT
	LJqbLjPNdneA54+ulXKnaFIcxuu6uB1Pu26Ri696iU1RYEGWrAE6jIUlZBDEaTh4Yh0TF6
	u3XqdKCBLJVJyvviPdi6K20rOeRaRM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-05xabkKMNmaJUkXsWRU1GA-1; Thu, 08 Jan 2026 10:36:00 -0500
X-MC-Unique: 05xabkKMNmaJUkXsWRU1GA-1
X-Mimecast-MFC-AGG-ID: 05xabkKMNmaJUkXsWRU1GA_1767886559
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so23484735e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767886559; x=1768491359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKOA6bIG5gqeJG8Qpb8f66GiNtAZiz2HEDO5SYzczYQ=;
        b=n+tlCPK1n+RLM/tr0oDyBHdgwpfvaFLrzprbkfJ/+4Inv82+ZzLg0XuQAIxNnr2I0/
         zG3ymDBG0kYLfwfxT9SjYIaJpaHQmQxZT3W8z4na/Vcq++vx6a6D59oGDpMi4gYhKbDw
         QlokbqGmg474GoCWCifUZTsDenEcDi8NX9cvb/ceHgrx9yrb493BeaB+Wvuwnohhi2rg
         burcEho0MMziegxXSCx1kAAmRMPP3H1qoa/P+GHq/FcK1E6QuKKUdVquthxGU26xeERB
         KJPsNNY2CBDCs0NkO2sHS+S3w77rFNMTlDdzI+8+hmqzHjEfrU2TVp5cwDXS2wrLsKS0
         m60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886559; x=1768491359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKOA6bIG5gqeJG8Qpb8f66GiNtAZiz2HEDO5SYzczYQ=;
        b=l8AqOJCjwu+3KcethYcitYnyz6F489PibeCnQhpcdi3Fvq+xIaQSGTxA/sZQMpA0He
         mG68g7LV/TIW3pIWPDpkbKdk3oFiq7KHG23yfYXdP9ezwrN5Jcp5k2DN1ObuG7lmzR6z
         26QpADGuXCYxJX6akZXqNygWZCsIVVTwibbdiHaPo2BgUsZfy4JALwbS/n4pVva9Z2fk
         GbQl4jJVT24erdr0Pa6iG3UZ+5rrzfH0EcBd7gBjsOoWoft8Z2VDIjEOZQ5ecHDQN13/
         PIUkB78Ju3doCIPWH0cCQzus0T84ynjyjZbk7MrIZavUJI2M74//2Yfoy+sHx9KY/C26
         bAGA==
X-Forwarded-Encrypted: i=1; AJvYcCVshbOMdGMyGdlOKVTQO0fiB5HkWSIHAwpbEC2yWSwCzlq/mairoPO9SkoHGs+bvzb400C1VD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75x6Qq+8ZDR9v+5Yw2f0I0koGJhC8rrfFZQWdtHx09zMTjQp2
	HM7+WuVAiwFPx/9NniXKeFReFeChdcTDV0kLgSuN53MJhACxcAcLIUXc295y5mP0DS1LvJjQkA4
	c6MjBv96Ufc3sjUzJ9qHpDTGK35UnrkvDg/qiaISQZj9iyaqBz5QZ5uuhWg==
X-Gm-Gg: AY/fxX4hIOlGDK/LA6/SvD8mWO6GmdYKXhZQ9yC1MP918seFDGfjfNN2tL3ndlzrqJg
	IzGykt6YBFMpVX6+IAvVQzp8CHTx0t/RLtlyvgT2+OCWD4qvUK7YTF/8v29/AVK1UNAlrI9P3Yx
	tht5k5WXPIP+B0XMse0pTze9lxdT8bJDdmPu88ZF+nnObI98jTxmyHNkIm9tNdlfccJhfUg+/6P
	5QnNGXd/BjJdxtUGhJocnPlMEz+wvhAQVtE4STUzsFWZ25oOam5jXw/sJprVuJ0p5fne/IzJeFC
	X3dmGd5ZR0cD7s0ogeIauJ/qumCE/XIwltHy5hpOb85ADFpr5mAvckQPYFc3W6wWKuUAftlApgS
	Tg7TRUxanF58/7A==
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47d84b4a815mr83106405e9.32.1767886558981;
        Thu, 08 Jan 2026 07:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfuJjGcbYUc5IlncqaTXsISNS90Og1zJ6QRlJFr7XbIoCIfy/sOMJ3agGVfwayDL7K8CC5eg==
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47d84b4a815mr83105905e9.32.1767886558466;
        Thu, 08 Jan 2026 07:35:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edb7esm16557435f8f.30.2026.01.08.07.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:35:58 -0800 (PST)
Message-ID: <5cb27e9f-ec01-4b50-b22c-dc8b027827bc@redhat.com>
Date: Thu, 8 Jan 2026 16:35:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 06/16] quic: add stream management
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1767621882.git.lucien.xin@gmail.com>
 <1e642f7c65ec53934bb05f95c5cf206648c7de9f.1767621882.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1e642f7c65ec53934bb05f95c5cf206648c7de9f.1767621882.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 3:04 PM, Xin Long wrote:
> +/* Create and register new streams for sending or receiving. */
> +static struct quic_stream *quic_stream_create(struct quic_stream_table *streams,
> +					      s64 max_stream_id, bool send, bool is_serv)
> +{
> +	struct quic_stream_limits *limits = &streams->send;
> +	struct quic_stream *stream = NULL;
> +	gfp_t gfp = GFP_KERNEL_ACCOUNT;
> +	s64 stream_id;
> +
> +	if (!send) {
> +		limits = &streams->recv;
> +		gfp = GFP_ATOMIC | __GFP_ACCOUNT;
> +	}
> +	stream_id = limits->next_bidi_stream_id;
> +	if (quic_stream_id_uni(max_stream_id))
> +		stream_id = limits->next_uni_stream_id;
> +
> +	/* rfc9000#section-2.1: A stream ID that is used out of order results in all streams
> +	 * of that type with lower-numbered stream IDs also being opened.
> +	 */
> +	while (stream_id <= max_stream_id) {
> +		stream = kzalloc(sizeof(*stream), gfp);
> +		if (!stream)
> +			return NULL;

Do you need to release the allocated ids in case of failure? It would be
sourprising to find some ids allocated when this call fails/returns NULL.

> +
> +		stream->id = stream_id;
> +		if (quic_stream_id_uni(stream_id)) {
> +			if (send) {
> +				stream->send.max_bytes = limits->max_stream_data_uni;
> +			} else {
> +				stream->recv.max_bytes = limits->max_stream_data_uni;
> +				stream->recv.window = stream->recv.max_bytes;
> +			}
> +			/* Streams must be opened sequentially. Update the next stream ID so the
> +			 * correct starting point is known if an out-of-order open is requested.
> +			 */
> +			limits->next_uni_stream_id = stream_id + QUIC_STREAM_ID_STEP;
> +			limits->streams_uni++;
> +
> +			quic_stream_add(streams, stream);
> +			stream_id += QUIC_STREAM_ID_STEP;
> +			continue;
> +		}
> +
> +		if (quic_stream_id_local(stream_id, is_serv)) {
> +			stream->send.max_bytes = streams->send.max_stream_data_bidi_remote;
> +			stream->recv.max_bytes = streams->recv.max_stream_data_bidi_local;
> +		} else {
> +			stream->send.max_bytes = streams->send.max_stream_data_bidi_local;
> +			stream->recv.max_bytes = streams->recv.max_stream_data_bidi_remote;
> +		}
> +		stream->recv.window = stream->recv.max_bytes;
> +
> +		limits->next_bidi_stream_id = stream_id + QUIC_STREAM_ID_STEP;
> +		limits->streams_bidi++;
> +
> +		quic_stream_add(streams, stream);
> +		stream_id += QUIC_STREAM_ID_STEP;
> +	}
> +	return stream;
> +}
> +
> +/* Check if a send or receive stream ID is already closed. */
> +static bool quic_stream_id_closed(struct quic_stream_table *streams, s64 stream_id, bool send)
> +{
> +	struct quic_stream_limits *limits = send ? &streams->send : &streams->recv;
> +
> +	if (quic_stream_id_uni(stream_id))
> +		return stream_id < limits->next_uni_stream_id;
> +	return stream_id < limits->next_bidi_stream_id;

I can't recall if I mentioned the following in a past review... it looks
like the above assumes wrap around are not possible, which is realistic
given the u64 counters - it would require > 100y on a server allocating
4G ids per second.

But it would be nice to explcitly document such assumption somewhere.

> +}
> +
> +/* Check if a stream ID would exceed local (recv) or peer (send) limits. */
> +bool quic_stream_id_exceeds(struct quic_stream_table *streams, s64 stream_id, bool send)
> +{
> +	u64 nstreams;
> +
> +	if (!send) {
> +		if (quic_stream_id_uni(stream_id))
> +			return stream_id > streams->recv.max_uni_stream_id;
> +		return stream_id > streams->recv.max_bidi_stream_id;
> +	}
> +
> +	if (quic_stream_id_uni(stream_id)) {
> +		if (stream_id > streams->send.max_uni_stream_id)
> +			return true;
> +		stream_id -= streams->send.next_uni_stream_id;
> +		nstreams = quic_stream_id_to_streams(stream_id);

It's not clear to me why send streams only have this additional check.

> +		return nstreams + streams->send.streams_uni > streams->send.max_streams_uni;

Possibly it would be more consistent

max_uni_stream_id -> max_stream_ids_uni

(no strong preferences)

> +	}
> +
> +	if (stream_id > streams->send.max_bidi_stream_id)
> +		return true;
> +	stream_id -= streams->send.next_bidi_stream_id;
> +	nstreams = quic_stream_id_to_streams(stream_id);
> +	return nstreams + streams->send.streams_bidi > streams->send.max_streams_bidi;
> +}

[...]
> +/* Get or create a receive stream by ID. Requires sock lock held. */
> +struct quic_stream *quic_stream_recv_get(struct quic_stream_table *streams, s64 stream_id,
> +					 bool is_serv)
> +{
> +	struct quic_stream *stream;
> +
> +	if (!quic_stream_id_valid(stream_id, is_serv, false))
> +		return ERR_PTR(-EINVAL);
> +
> +	stream = quic_stream_find(streams, stream_id);
> +	if (stream)
> +		return stream;
> +
> +	if (quic_stream_id_local(stream_id, is_serv)) {
> +		if (quic_stream_id_closed(streams, stream_id, true))
> +			return ERR_PTR(-ENOSTR);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (quic_stream_id_closed(streams, stream_id, false))
> +		return ERR_PTR(-ENOSTR);
> +
> +	if (quic_stream_id_exceeds(streams, stream_id, false))
> +		return ERR_PTR(-EAGAIN);
> +
> +	stream = quic_stream_create(streams, stream_id, false, is_serv);
> +	if (!stream)
> +		return ERR_PTR(-ENOSTR);
> +	if (quic_stream_id_valid(stream_id, is_serv, true))
> +		streams->send.active_stream_id = stream_id;

This function is really similar to quic_stream_send_get(), I think it
should be easy factor out a common helper (and possibly use directly
such helper with no send/recv wrapper).

/P


