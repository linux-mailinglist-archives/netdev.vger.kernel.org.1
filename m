Return-Path: <netdev+bounces-254845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLMUKz+Ke2mlFQIAu9opvQ
	(envelope-from <netdev+bounces-254845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:26:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B6B2272
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1695D3002F50
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9233ADBE;
	Thu, 29 Jan 2026 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaTDNYf+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lwszMLZN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89333D6D4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703995; cv=none; b=lCfIeB+ncY4LJxwT3NkUi27YmLevH07J8z27ZJgM6UXF04K3WdEX6oGJOGkPXq9YOBd9sO9fFlc6Jc53JD2MAGtT07ph0L+iR0hi/BE4uWqDFdmz0AOS9t8uvlwTDA3+B/2tiL8MsoRM9y0ThtV0EqS3t+PXW51tJOyE98xXUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703995; c=relaxed/simple;
	bh=l86OLD8ANrV0mU8pNoPBa0/YPrKD248BWDWu+9LLv88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3eklh5sUwn5BIFjYWdeRwofya5T3xZZ1TTppso1e+H3gTcrhiPb07cpLVX/3flCiCANppPCDoVFQhamLbyBMBFU8vnixUvGJ9lTqwRmvZkM+P3YZBuKaX9SvAtfdnwRZj+SJ9M33cv1Ca2kT6kDNblLnlnp/EC162k/6g7oQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaTDNYf+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lwszMLZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smuqHJFpRj+j2xYajnlqs/VsDNhOWtBkZ67qclJoWoE=;
	b=GaTDNYf+HOrIGOckqVcAVsuisY99z6A0USUP2h9ygs9ZQIu4O8/yVPNx7UvDzvJ+Fe+za5
	CRKAkVXAlUMc827mO+ePphGzUJgFlOawDYQJpNxRw4GWPVTgyDX6L+DjdHtV4i0JGPzO9t
	eOyyObGdYCKT0o27iSZo2sasOJIT23c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-8GGF-RfRMGChPvmeGifjeQ-1; Thu, 29 Jan 2026 11:26:30 -0500
X-MC-Unique: 8GGF-RfRMGChPvmeGifjeQ-1
X-Mimecast-MFC-AGG-ID: 8GGF-RfRMGChPvmeGifjeQ_1769703989
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435ab907109so611653f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769703989; x=1770308789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smuqHJFpRj+j2xYajnlqs/VsDNhOWtBkZ67qclJoWoE=;
        b=lwszMLZNs0uY6Ze1d9sLX4JgzRX93miaHkilgOrGHmpDJ61G0hy5JX9H1ama2Mwhb2
         j1hUFI9rK6SBC//wTkmy0qnCEuzRCGJn8+0mBXuslwiOX8o5c4YJSrKSGre/9nEg4qXT
         vnai37+CtSPf4Yv+h0zApOJlw6WCdrVYPxsOPJkJkz7ypKg7KbzA9fmztGqh+Kizr75S
         yWVUjKbP0KQOBDeHxDlSRWlBA4Age5kzkRMeCzgULuUlk76Y25PH2Dh7Ow0wtRVvp2Yr
         ZIU8Tk2YFiOzA59VE4S81ZghkIKC1WSue8bWUj+i24ge0anGpYrs+QI+gYNSBxO9UdAC
         WuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769703989; x=1770308789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smuqHJFpRj+j2xYajnlqs/VsDNhOWtBkZ67qclJoWoE=;
        b=vM42E6WIZ598E0S7d8Q528CeRgEQWDpWKHmiRoSecMwB/41qfW8hHCiu7woJGCPszZ
         RFYXNtG3ExSZPk4b5H57Ul39Z6gBL/5SabpvOG0SwywDbFxMpBtfKvMhZwlH/77t5Cm0
         aWJ2oVXYjm53/7ADgS2t5UwWB9FtYwujoTwFw6JP1XnjFYcMzSzpqwXl6wqrt05MbXA5
         Syxil/lgjVElalAxOcc6/RX5InlQQUlZs77Dv9Gy7ZZNAvLKJfBomOQ53tCzYU3q9Yor
         8eWkUvpAFF+M0XIPDhTd21boB1TDguFE7H+m1mVZ5jT9oncCDGrXy42eSYaXvOU2W4HV
         q5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXUwPlzFSvAW2PHVPSpm9MyZ7dOb9b7FfBzyCTQ4QBajpjE68llyUJ1fE74uDXwWMZagvxeNgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTySDJnC0IqSLqTDZD3ETQu8C5Y35MJOWowpSl8ykjM2dO9aHK
	pjb65wNIpqtHA1ZpnfMp1f8vDMaO9yEQ3V4w+ot/ZHMJVp3pe9BTwKsrKMMeCB97o6thSVwjGXO
	3vFT7EbhLz0HblK4b3qiFNQH4GzIxYXpgjjyn/g2G+wwlToeNA3jHeHeLiw==
X-Gm-Gg: AZuq6aJKv5SOJNr6rHQqV+5PoCV/hSEqUgKI3bMTVOa5BuZkfOWmzWaUUIewY7d6r/d
	8vfGIjPzQPyTlvX2idJ/tSweVrc7uNB+xNdiUgjhCnIzTm71oMwIDr1V5OBAwc1nrBj2CoN+FRw
	90bkx1OQWHiDuEMXbZ8/vD6fiwtutssPVzKxraJ8UN5Xxjhb1xziw/g/5rFfZZCiMARot0YdN5s
	Um9IX9z7qi4kL8abZScVMRvEl+1BBCMgeR/OF0PjrkhlvS9cb68tdvwm3dmVEfLe5KlWq1LXS9M
	G87ZbStjzdJKQkk88m+QtNyok9zuVrKaDgh1QAGgS/ntrArzpGiV7kt/BAYeuHj7OrMTPxOWc76
	d+kemtrCLlVK7
X-Received: by 2002:a05:6000:18a7:b0:430:fdc8:8be3 with SMTP id ffacd0b85a97d-435f3aafd25mr246918f8f.29.1769703988802;
        Thu, 29 Jan 2026 08:26:28 -0800 (PST)
X-Received: by 2002:a05:6000:18a7:b0:430:fdc8:8be3 with SMTP id ffacd0b85a97d-435f3aafd25mr246869f8f.29.1769703988173;
        Thu, 29 Jan 2026 08:26:28 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee562sm15878577f8f.18.2026.01.29.08.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:26:27 -0800 (PST)
Message-ID: <9c17e0f5-0a07-4800-9356-0ee9445e3922@redhat.com>
Date: Thu, 29 Jan 2026 17:26:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/15] quic: provide common utilities and data
 structures
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
References: <cover.1769439073.git.lucien.xin@gmail.com>
 <1cbfbd45fda48c82f629b000fc102ee011515e12.1769439073.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1cbfbd45fda48c82f629b000fc102ee011515e12.1769439073.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254845-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C16B6B2272
X-Rspamd-Action: no action

On 1/26/26 3:51 PM, Xin Long wrote:
> +struct quic_skb_cb {
> +	/* Callback and temporary context when encryption/decryption completes in async mode */
> +	void (*crypto_done)(struct sk_buff *skb, int err);
> +	void *crypto_ctx;
> +	union {
> +		struct sk_buff *last;	/* Last packet in bundle on TX */
> +		u64 time;		/* Arrival timestamp in UDP tunnel on RX */
> +	};
> +	s64 number;		/* Parsed packet number, or the largest previously seen */
> +	u32 seqno;		/* Dest connection ID number on RX */
> +	u16 errcode;		/* Error code if encryption/decryption fails */
> +	u16 length;		/* Payload length + packet number length */
> +
> +	u16 number_offset;	/* Offset of packet number field */
> +	u8 number_len;		/* Length of the packet number field */
> +	u8 level;		/* Encryption level: Initial, Handshake, App, or Early */
> +
> +	u8 key_update:1;	/* Key update triggered by this packet */
> +	u8 key_phase:1;		/* Key phase used (0 or 1) */
> +	u8 backlog:1;		/* Enqueued into backlog list */
> +	u8 resume:1;		/* Crypto already processed (encrypted or decrypted) */
> +	u8 path:1;		/* Packet arrived from a new or migrating path */
> +	u8 ecn:2;		/* ECN marking used on TX */
> +};
> +
> +#define QUIC_SKB_CB(skb)	((struct quic_skb_cb *)&((skb)->cb[0]))

Please add a build time check on quic_skb_cb size.

Thanks,

Paolo


