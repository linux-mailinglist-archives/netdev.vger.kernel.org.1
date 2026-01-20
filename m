Return-Path: <netdev+bounces-251478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGsGBldGcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:21:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AE3505BC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC05D688463
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E83ACA4F;
	Tue, 20 Jan 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hacCEu4s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kjTJZQhI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF03644CD
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912323; cv=none; b=miHVAShNN3qDFCdcs88LWXxgWFef2wlbacXgbU2I2CWSJz0AaNVqXhg2axhNh773KVlggLt0mnNUwgmVQHp/n5D5pnTmFzpDNU1bVUFGNZjwGTZ0AqKCcDqhgFMGUdr16+aCnkaIQHeFQ0cJc3biMwgiikqtvfdBMGGpPx1NaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912323; c=relaxed/simple;
	bh=ybwnOstUjbTzU+WNVQkpG7oSIktyn6VBM0meydYghk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKXYhUg38RiiRKFk3ITd5P8X7URgEDb9ruri/crtZM+TI5H9FTYp7Fo3ElQbOy+bgtB83AvrP3YSIDKAH5kU0vhv2XuJg5gXEfg32LOOcIf0sCQMx1lNUC5WT1mq6l9cnsarEJ+gzI5HwKqV2+GyN7ByIcxdCH+2gFAVwoD1OQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hacCEu4s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kjTJZQhI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768912320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVch8b9/GI7xCZGgBVtwu4LokFmMKHsdozmzzKNxN0A=;
	b=hacCEu4sgWKALO50RQxlihNkrz3A1Yl71t5wddA0AZqTvkoss1NWEU6XR9hKtrhN+qzFNJ
	WIk1+sO0vpYa4m6pepin2b+VBJ3pc3p7CPzTe20JcxU4lcIyxNOPqacN8EXTRxHe/hmN76
	maESj7DGlF7D+uXOfd3u60lrxI+O6Wk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-w0-l9UkVPgmODp6djnmvtg-1; Tue, 20 Jan 2026 07:31:58 -0500
X-MC-Unique: w0-l9UkVPgmODp6djnmvtg-1
X-Mimecast-MFC-AGG-ID: w0-l9UkVPgmODp6djnmvtg_1768912318
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso27294335e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768912317; x=1769517117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVch8b9/GI7xCZGgBVtwu4LokFmMKHsdozmzzKNxN0A=;
        b=kjTJZQhIJcq5Xm3R5qWYSnGn0BkP5gqBu59wG78uUyrppPUuZZpIviXH5yuREVMH0/
         kwFkHUhocE4I307LnEuwYaBvvgL2zTuYbUBA3XQp5xcv8WbsXOgO1jXg81+7lcRcl5Fu
         7DRWc5qzkBqQySCaI1NrTZ1G8fl9YRjbxlU2EzcvTUFBXqJZ/r4w9UjhGJZp8iGETQfB
         pH97SzNPJQ1GiGJE5TxJzdA0tVxwSPV1HGZsSFIQDYEXQBYNdW0+M9B8FG4fSEHbDueJ
         71eItYEyazS8I3nVG+IAUkN7F/KqZc57+RIBXPXgbued2H8SOLizzYq6rRUPKlaMUkyx
         A+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912317; x=1769517117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVch8b9/GI7xCZGgBVtwu4LokFmMKHsdozmzzKNxN0A=;
        b=EaRNvXOB4e0Nez/hLwn+HgKcVaKYZpewpWsWNa8uLXBu/63dJswcmYEwT8v9k0JsiJ
         diiyG/8qVnkZN3ENT9xoKYyQj3x2Orr2J1Umz4DB1a0jxZ6M61nK0PleIVt08r5dQgF8
         a8MmWjNQth/dRFZo25SAoNE31bFf6N3PTMSktYQCRiwl4ncvQAbdY6Pu/Y1fxtKDYEg2
         fTuHJoFHSbTLbXF8ubsggWZvGnF7SfMcjaQ+X3LaR7BhwDMUy39LgiQNhRqMQfRpHqVC
         gGQoDNELv5hyvRngb+JMWhgKf0w7KAUfHVosjpRWCMGkoG6Rd01gcbImn/OzTEiGcuSl
         dpvg==
X-Forwarded-Encrypted: i=1; AJvYcCUU3dx40EK/2F7bdvEicYEkBUGyNBAVQuuMC5AJ/jZiPtjf36cGH6kYLokYbL+6t4HJMgB2EF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBCXDIZ+qtvFnhjPFisUkWw7Hvs3MY9NVcXlTDI/3ZtMkKrAV
	6o5+EvjgByj3IOlvJWU0HNGR/k/MHE0DS3guFadPiNDzf6fyK8A3c+daxdebxXj0t/xPOKafXKc
	sz72L/gE48XzLB/E5xrwfrduurq+Gq1k398PqXXe0vDwRaOhECDYSveeNdA==
X-Gm-Gg: AY/fxX7ScytaRQ0UqdUzD2vZ2//2krDOIMLl7gI4cybRC7cY6wXx6FcpXvmlvLmfoDF
	8TlZBrFiF7xIVYOLBH4a6jj3bRva20uKZ+viZMUpTrDgpU5CHgYDGak/IvxFTtauJs5fzVswSje
	psTHung61wNa+gfqEFcaUrLlHBNiIHxRa0p8/L9Oaqet2LRNfa5FNdLAusZFtDZ/EqHB5Xe0C3e
	onpPf2EAaWN4w3djOdUnKawybqWQCceKDNL1rbRtRmS9kFGuKuMmP+7wezIWTOikKTrr7PCFlCw
	5Z4ZQCdy/pC8xWC4ioiayjolxWNchuWTrwdht3tx0Njo8F0ykMrB5y0Le3SrAeRzQbZR6EC4qO4
	8zxmoeex8uCw5
X-Received: by 2002:a05:600d:2388:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-47f44d4ca19mr138284965e9.16.1768912317555;
        Tue, 20 Jan 2026 04:31:57 -0800 (PST)
X-Received: by 2002:a05:600d:2388:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-47f44d4ca19mr138284545e9.16.1768912317054;
        Tue, 20 Jan 2026 04:31:57 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b7aasm306886765e9.2.2026.01.20.04.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:31:56 -0800 (PST)
Message-ID: <6c6d5644-3354-46ba-bbc9-e76789648abf@redhat.com>
Date: Tue, 20 Jan 2026 13:31:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 06/16] quic: add stream management
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
References: <cover.1768489876.git.lucien.xin@gmail.com>
 <e3f770ef8d9aba101e1f5dc2f2f72bb0d2a30b94.1768489876.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e3f770ef8d9aba101e1f5dc2f2f72bb0d2a30b94.1768489876.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-251478-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B7AE3505BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/15/26 4:11 PM, Xin Long wrote:
> +struct quic_stream {
> +	struct hlist_node node;
> +	s64 id;				/* Stream ID as defined in RFC 9000 Section 2.1 */
> +	struct {
> +		/* Sending-side stream level flow control */
> +		u64 last_max_bytes;	/* Maximum send offset advertised by peer at last update */
> +		u64 max_bytes;		/* Current maximum offset we are allowed to send to */
> +		u64 bytes;		/* Bytes already sent to peer */
> +
> +		u32 errcode;		/* Application error code to send in RESET_STREAM */
> +		u32 frags;		/* Number of sent STREAM frames not yet acknowledged */
> +		u8 state;		/* Send stream state, per rfc9000#section-3.1 */
> +
> +		u8 data_blocked:1;	/* True if flow control blocks sending more data */
> +		u8 done:1;		/* True if application indicated end of stream (FIN sent) */

Minor nit: AFAICS with the current struct layout the bitfield above does
not save any space, compared to plain u8 and will lead to worse code.

> +	} send;
> +	struct {
> +		/* Receiving-side stream level flow control */
> +		u64 max_bytes;		/* Maximum offset peer is allowed to send to */
> +		u64 window;		/* Remaining receive window before advertise a new limit */
> +		u64 bytes;		/* Bytes consumed by application from the stream */
> +
> +		u64 highest;		/* Highest received offset */
> +		u64 offset;		/* Offset up to which data is in buffer or consumed */
> +		u64 finalsz;		/* Final size of the stream if FIN received */
> +
> +		u32 frags;		/* Number of received STREAM frames pending reassembly */
> +		u8 state;		/* Receive stream state, per rfc9000#section-3.2 */
> +
> +		u8 stop_sent:1;		/* True if STOP_SENDING has been sent */
> +		u8 done:1;		/* True if FIN received and final size validated */

... same here...

> +	} recv;
> +};
> +
> +struct quic_stream_limits {
> +	/* Stream limit parameters defined in rfc9000#section-18.2 */
> +	u64 max_stream_data_bidi_remote;	/* initial_max_stream_data_bidi_remote */
> +	u64 max_stream_data_bidi_local;		/* initial_max_stream_data_bidi_local */
> +	u64 max_stream_data_uni;		/* initial_max_stream_data_uni */
> +	u64 max_streams_bidi;			/* initial_max_streams_bidi */
> +	u64 max_streams_uni;			/* initial_max_streams_uni */
> +
> +	s64 next_bidi_stream_id;	/* Next bidi stream ID to open or accept */
> +	s64 next_uni_stream_id;		/* Next uni stream ID to open or accept */
> +	s64 max_bidi_stream_id;		/* Highest allowed bidi stream ID */
> +	s64 max_uni_stream_id;		/* Highest allowed uni stream ID */
> +	s64 active_stream_id;		/* Most recently opened stream ID */
> +
> +	u8 bidi_blocked:1;	/* STREAMS_BLOCKED_BIDI sent, awaiting ACK */
> +	u8 uni_blocked:1;	/* STREAMS_BLOCKED_UNI sent, awaiting ACK */
> +	u8 bidi_pending:1;	/* MAX_STREAMS_BIDI needs to be sent */
> +	u8 uni_pending:1;	/* MAX_STREAMS_UNI needs to be sent */

... and here.

Other than that LGTM. With the bitfield replaced with plain u8 feel free
to add my

Acked-by: Paolo Abeni <pabeni@redhat.com>


