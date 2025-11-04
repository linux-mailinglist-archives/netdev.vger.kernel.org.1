Return-Path: <netdev+bounces-235444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25468C30A81
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 12:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A9B188E730
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81C2DAFC8;
	Tue,  4 Nov 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apwJZ6PC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtAox43Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE922773C6
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254355; cv=none; b=pk8/wR0hXsCRlOt43xoZHtXsiDneW2qrekbiRlswzP8dnataFbZQe/rTJ4vej4Gtj0A2PYNbyfLITHCYgd6MDxepIOZO2zMZ9ZC75ZK7PjHZvZE1UfSn4a5qEhyBOpjB4XBQ/I2Ju8TidSIjV3VK5YQFZGryqg8nolpoveG+PqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254355; c=relaxed/simple;
	bh=6rkuhGsUq+FMshFBuGH4UBuujI5+HFmkSrNJPWLxEDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkkYNdIEO7xmqB0JwX88Lv+jculyntCEG3f/uLOgOXd4kiSsyRhQ3oQVwtHfAP3G5i1JIIwm2n5coMWmFgOqPXp8njnNJiFZgcb4Q/uNopTXPwcFbgi9fMAI4H51OTyGKABMsIbvvjIW3JXod061nFthsx56iolTSAfWe8MfciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apwJZ6PC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtAox43Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762254352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxmghJIcjc3tJC2DIG8MaqzZFBLXh5fxewma9fsdqXU=;
	b=apwJZ6PC1qBS75zy3RvwIHRoL63GixP1t9G6QHjYgUksW8kssbSxmSa+5/Ao5v/VQ59gjT
	x9wg7t2X3+t5j5lgWklzLATHrJJWR3L41ucOZ6b7NFBn60+MwjHtui8U+VHDSaLyxMk238
	ZM8kYlNayewsTIr+c9FJw+UC3UZIri8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-iaUCXQrvN2yLHETiTj0v4g-1; Tue, 04 Nov 2025 06:05:51 -0500
X-MC-Unique: iaUCXQrvN2yLHETiTj0v4g-1
X-Mimecast-MFC-AGG-ID: iaUCXQrvN2yLHETiTj0v4g_1762254350
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c9024a1dso1293246f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762254350; x=1762859150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxmghJIcjc3tJC2DIG8MaqzZFBLXh5fxewma9fsdqXU=;
        b=DtAox43Y5w70OHUi0G3BPXvZ2ZaEsdARx4De11HsJzrj0ZQSyFCG/kOfcy3oBEpAU4
         L9LWUTUB5autDnsNvuvG/WsKWv4zpI+g4W19tp/9eHeOzidn4wGKiok+GxN9IRYH3WwV
         IEpwRb2Zsa/xs0xxFfVyF/9BiwnNKLmH/RD+gO2qKWCpkfHyQGd3Uf/rHREySkg7QOMe
         fBlLXaZg8VYQ1tv0SGJvIa13m/RTPnjiNkPclYK6USGkbRxVfVDb5eSyXmNuAhqOo1jn
         5POK+OhAtOT3sEEwO1RZGoo3e0qpFQHaAvEZjGHfiY2aeclZfjNqnkAZ0x01XN7SjFAe
         xrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254350; x=1762859150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxmghJIcjc3tJC2DIG8MaqzZFBLXh5fxewma9fsdqXU=;
        b=InbsZeuNtrLFC+x+tRTfk/qMs0t4M4aXuqCkXL7hwxVPoYxgPeXjC2p1eYBGZ3t/9+
         DjquL0wezFHgUH3ALqXJFcCIqhgNPjF7VY529oZtak2RhCc/dnJH3VLmNY+lBGgrCUlI
         7kHTYOyqDIJhJBCMbimgWPue0pquo40nLUsRsk4WuJcBRLIaxzOdH7PDsKHbT7v0Q13p
         bJ+Jwgidam5+dxkm6JqdBPM8XTxLnbPPV2d0yNjZMlsTLsbaVfJ5kvhKM+cwxi5wTFEt
         UVmFpZPp7H3Su6DQcfqt5iQl3Ib/X1g6Y8s+TW9HCVYrS+MIFXvENA9u+yRu77pC+lPw
         rAiA==
X-Forwarded-Encrypted: i=1; AJvYcCXm6pmH0RtbTdd9UThR673ItwjzKZgVw79vhu13f4ty2Mybi2RzKGukHPuApn0TnNj/yvXrC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHcp9dvjyE7kQMXf3EtiIjywMMFXJmlnRH2ll1l5uIU4YY4Du
	Q1S9FXqvbbvI4fAOGXLTVnXIYzEwQfJwdfF6Rlcf5djUnk+2lOypuqHdW4jIERgPwB9hjSsR1/F
	MZua2LEkNMo6QvzbaspbkKRG8tkp+J9SUR+4YOvHrid5j5yV3qRmeDoA0QA==
X-Gm-Gg: ASbGncu3A2BX7r+w5ZWVghNlELR9d49i7lkZcx5XV+1y+CG77YXVwBrO/bAuT3hXEqE
	nhSy+t4Nkzg5lOdblwn0HzE6MwQPal+9/+JDefgMH6fvqodZYUQDcWRl9bITbzfyLERPfIJO8vb
	ZwTlcDHZDekfUDfRXI5XYjWLo1uf24h8XUpjkoGw1QKJKlJxzM2x6DMbkNoA3gGMzMPAX+srxZ/
	6HNtLPtQa1fGL+v2RsPrTn8k09WmCwRFrtBZq5aKyEC3vrGATgVMH2KH1MD2BFag+KzGP99BZjz
	rFfhKEz5GUxD67VDYu8pSK1YitP0ba1EGWDyXFYr2XWppIS5q56PqFs6uML4EHkxY3UhbB0NuAT
	aowx1OPFI488ejT1qnEJL1/oAv/gEs+a+rcGcDBsPR7iw
X-Received: by 2002:a5d:584b:0:b0:429:dc4a:4094 with SMTP id ffacd0b85a97d-429dc4a41c5mr2036057f8f.30.1762254349823;
        Tue, 04 Nov 2025 03:05:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRTcLyJarL+HzJIicet1BC+SA9mI8/liFB8LEEp4cpSbdxEDl917ajaG6JsdKZcXmSqC73zQ==
X-Received: by 2002:a5d:584b:0:b0:429:dc4a:4094 with SMTP id ffacd0b85a97d-429dc4a41c5mr2036004f8f.30.1762254349252;
        Tue, 04 Nov 2025 03:05:49 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5af7sm4174267f8f.28.2025.11.04.03.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:05:48 -0800 (PST)
Message-ID: <ad38f56b-5c53-408e-abcc-4b061c2097a3@redhat.com>
Date: Tue, 4 Nov 2025 12:05:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/15] quic: add stream management
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
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <6b527b669fe05f9743e37d9f584f7cd492a7649b.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6b527b669fe05f9743e37d9f584f7cd492a7649b.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
+/* Create and register new streams for sending. */
> +static struct quic_stream *quic_stream_send_create(struct quic_stream_table *streams,
> +						   s64 max_stream_id, u8 is_serv)
> +{
> +	struct quic_stream *stream = NULL;
> +	s64 stream_id;
> +
> +	stream_id = streams->send.next_bidi_stream_id;
> +	if (quic_stream_id_uni(max_stream_id))
> +		stream_id = streams->send.next_uni_stream_id;
> +
> +	/* rfc9000#section-2.1: A stream ID that is used out of order results in all streams
> +	 * of that type with lower-numbered stream IDs also being opened.
> +	 */
> +	while (stream_id <= max_stream_id) {
> +		stream = kzalloc(sizeof(*stream), GFP_KERNEL_ACCOUNT);
> +		if (!stream)
> +			return NULL;
> +
> +		stream->id = stream_id;
> +		if (quic_stream_id_uni(stream_id)) {
> +			stream->send.max_bytes = streams->send.max_stream_data_uni;
> +
> +			if (streams->send.next_uni_stream_id < stream_id + QUIC_STREAM_ID_STEP)
> +				streams->send.next_uni_stream_id = stream_id + QUIC_STREAM_ID_STEP;

It's unclear to me the goal the above 2 statements. Dealing with id
wrap-arounds? If 'streams->send.next_uni_stream_id < stream_id +
QUIC_STREAM_ID_STEP' is not true the next quic_stream_send_create() will
reuse the same stream_id.

I moving the above in a separate helper with some comments would help.


> +			streams->send.streams_uni++;
> +
> +			quic_stream_add(streams, stream);
> +			stream_id += QUIC_STREAM_ID_STEP;
> +			continue;
> +		}
> +
> +		if (streams->send.next_bidi_stream_id < stream_id + QUIC_STREAM_ID_STEP)
> +			streams->send.next_bidi_stream_id = stream_id + QUIC_STREAM_ID_STEP;
> +		streams->send.streams_bidi++;
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
> +		quic_stream_add(streams, stream);
> +		stream_id += QUIC_STREAM_ID_STEP;
> +	}
> +	return stream;
> +}
> +
> +/* Create and register new streams for receiving. */
> +static struct quic_stream *quic_stream_recv_create(struct quic_stream_table *streams,
> +						   s64 max_stream_id, u8 is_serv)
> +{
> +	struct quic_stream *stream = NULL;
> +	s64 stream_id;
> +
> +	stream_id = streams->recv.next_bidi_stream_id;
> +	if (quic_stream_id_uni(max_stream_id))
> +		stream_id = streams->recv.next_uni_stream_id;
> +
> +	/* rfc9000#section-2.1: A stream ID that is used out of order results in all streams
> +	 * of that type with lower-numbered stream IDs also being opened.
> +	 */
> +	while (stream_id <= max_stream_id) {
> +		stream = kzalloc(sizeof(*stream), GFP_ATOMIC | __GFP_ACCOUNT);
> +		if (!stream)
> +			return NULL;
> +
> +		stream->id = stream_id;
> +		if (quic_stream_id_uni(stream_id)) {
> +			stream->recv.window = streams->recv.max_stream_data_uni;
> +			stream->recv.max_bytes = stream->recv.window;
> +
> +			if (streams->recv.next_uni_stream_id < stream_id + QUIC_STREAM_ID_STEP)
> +				streams->recv.next_uni_stream_id = stream_id + QUIC_STREAM_ID_STEP;
> +			streams->recv.streams_uni++;
> +
> +			quic_stream_add(streams, stream);
> +			stream_id += QUIC_STREAM_ID_STEP;
> +			continue;
> +		}
> +
> +		if (streams->recv.next_bidi_stream_id < stream_id + QUIC_STREAM_ID_STEP)
> +			streams->recv.next_bidi_stream_id = stream_id + QUIC_STREAM_ID_STEP;
> +		streams->recv.streams_bidi++;
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
> +		quic_stream_add(streams, stream);
> +		stream_id += QUIC_STREAM_ID_STEP;
> +	}
> +	return stream;
> +}

The above 2 functions has a lot of code in common. I think you could
deduplicate it by:
- defining a named type for quic_stream_table.{send,recv}
- define a generic quic_stream_create() helper using an additonal
argument for the relevant table.{send,recv}
- replace the above 2 functions with a single invocation to such helper.

It looks like there are more de-dup opportunity below.

> +
> +/* Check if a send or receive stream ID is already closed. */
> +static bool quic_stream_id_closed(struct quic_stream_table *streams, s64 stream_id, bool send)
> +{
> +	if (quic_stream_id_uni(stream_id)) {
> +		if (send)
> +			return stream_id < streams->send.next_uni_stream_id;
> +		return stream_id < streams->recv.next_uni_stream_id;
> +	}
> +	if (send)
> +		return stream_id < streams->send.next_bidi_stream_id;
> +	return stream_id < streams->recv.next_bidi_stream_id;
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
> +		return nstreams + streams->send.streams_uni > streams->send.max_streams_uni;
> +	}
> +
> +	if (stream_id > streams->send.max_bidi_stream_id)
> +		return true;
> +	stream_id -= streams->send.next_bidi_stream_id;
> +	nstreams = quic_stream_id_to_streams(stream_id);
> +	return nstreams + streams->send.streams_bidi > streams->send.max_streams_bidi;
> +}
> +
> +/* Get or create a send stream by ID. */
> +struct quic_stream *quic_stream_send_get(struct quic_stream_table *streams, s64 stream_id,
> +					 u32 flags, bool is_serv)
> +{
> +	struct quic_stream *stream;
> +
> +	if (!quic_stream_id_valid(stream_id, is_serv, true))
> +		return ERR_PTR(-EINVAL);
> +
> +	stream = quic_stream_find(streams, stream_id);
> +	if (stream) {

You should add some comments and possibly lockdep annotation/static
check about the expected locking for the whole stream lifecycle.

/P


