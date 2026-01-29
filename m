Return-Path: <netdev+bounces-254856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGuzDJ6Ne2kKGAIAu9opvQ
	(envelope-from <netdev+bounces-254856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B86B251B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 349AE3006142
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C2F331A68;
	Thu, 29 Jan 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioslu35z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWdbRHZI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135133EAE9
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704858; cv=none; b=I1Ai4N4Ja8FhTZpcLDJVP9I+yGZ1UVSsceS9Z98ZxoBrP45E19FMNRkCv9M9pPxIenMUoEK+Vhc+fpfhirVfI6wkENeWUuDqM5ckjadJugRcNt4P7zMKnka9H9cqU29QK7ag/kW/qLjCohyDXBsuOV+gsD++hjeRTGSdbWAuSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704858; c=relaxed/simple;
	bh=tAGcf2qHYt65xo/mPlZWfHpD6g4PeOJZ15QDP/sjPeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtNejjBpGlvtVKZtuGmTrP58dyjWZSUHIAFrpoLSeWLNFJZfgIXracT7/mcrqqCmNJUrAIum1WLIHIAWwWGDt7E0O018xKNqzzTPEF1x34/Eyh4MWcZjS4mxwmizlgFsF32NGBhBalZf7h6MhOKO7CSegvNLkDO4Zz/+57g53Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioslu35z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWdbRHZI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769704855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmP+ZaocLWbsQYSfK1kgq3CFYftfiEuO4FH3b4mkBqg=;
	b=ioslu35zlYCS4YcWn+lNjeV6SVCAzIw8UmfwnmfLPFrXYl58THELPsKisH1PQ4N85DA1Uy
	aatqig7vtNhCswndjOh92bTqC60SerFoueP61rJHjgFCPoVlZ4jeRKJn00lYzkA1YLuzpK
	KUV50OCgd1C7msJr+3y9rASCqCzI3/o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Qje5YT8_ORSsDhDAtDuQaA-1; Thu, 29 Jan 2026 11:40:54 -0500
X-MC-Unique: Qje5YT8_ORSsDhDAtDuQaA-1
X-Mimecast-MFC-AGG-ID: Qje5YT8_ORSsDhDAtDuQaA_1769704853
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so15558545e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769704853; x=1770309653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmP+ZaocLWbsQYSfK1kgq3CFYftfiEuO4FH3b4mkBqg=;
        b=VWdbRHZIx69iisJuR3kKnCUnv3yOraE+Jb82+KUDkMB5O5kG52rIh1h7uyzBCNtKfO
         nEytYvvKc+aaurX1G8dIEsESoT8hZe6GTO5fu2mCnLpSj6sfYR0gUhjsDn6wXFsFimND
         lgBwqBfCSylNWT1cvTYw9j7ySQMxSfaEH6l8FNmy0ZRV/YwHfwZ89DKUYF3Vc9paUbYd
         EAasHMGKKZ8xkeX1SEMC+cpdUTRJz/OfIKx02l7Q0qysHN1xKJBeuNSYXVOD/3oUy18A
         yuMSyuMn1QPH4jKII/RnyKT5Lkm6oRhM/UvvBEM3UWTaU2LXbAy4ZVRdEGU2HiJXs6t6
         Xtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769704853; x=1770309653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmP+ZaocLWbsQYSfK1kgq3CFYftfiEuO4FH3b4mkBqg=;
        b=XeXgQG/NxlO7m8ZaiFZmISAxIwAvSWYmROmWatxJJjLwCXnUxdnLjBQivtanWehpBA
         9UcYPHL6YwSd/ERAX5QQsbRKg8Tc1PQe1yLQbqG94/qnwOtG8hpFFcmt5/RwbijHF80K
         wX40zx2SkTjePOtNn/fSj+zuQxcbNDUuC1w2Zu4K7k7cUJ9RIaIyXDqCKC6h7hQ3RScP
         mJvXR/b2mCOS1BvXLp0go7eRsqBQcI8uNb1Z066PYFn0TUO4COhtOHRjzfg6f5VHQGH0
         9zl8lThucuWLQOcJqxhHUFMsEr0ZGocdqyrke/2kwVBsX/seInmIz6QqACfTF9zN/9IE
         6QkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg+ka3/QcM6ZnxqFl0uB9dT+mzVx/p/sNWrvrRh0skbRJSc1T3rY4i4PXfCvYxnaILjXqq75Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDFvcG0j+e3Tt8BHbAm3aKaYk8i0Y2awO9KqyalVa/SegxxGp
	oIecNcjBipAD1Ia4HnomKnmG4wxxgK+pDsecXdfPvy6cmqEqar/NjW/EzkrqzO5PIucXurWepcz
	P+Rlt7gVx5av/x0BakKs49TTA13yNxgaVD0+sdkEDALwTwa6WYg7yUi2diw==
X-Gm-Gg: AZuq6aJqle+iXlHn82OmCAi+3QpDyliLD0B536lu0Oje6KbtZS0IJ4ucaQYWIcM7VIm
	Qk+BtMqFuxSJLEI+tgZjrzVnjy92biRwmGMxdhr4weLfTlSwHawPdx9hIaBJjprt1OLEhwiQiIC
	mYNwO0ritgdGXZt7//KnqPIznjh16UFAuX5oOrb0a/S2P3owcrvCpc2B6rODTKcQjyKEymfftbq
	OiPfZVM/1/2mLhBdhzWNmkcLFRZRUM6HZy1E2FC+5ZNNtskOWMjh555wXeWViabX3J4/hLfzxgr
	oHPueLEsvW2vqka9FLtEJO7y/4nAZ9EK3m5LrT4nWs1L76wm0g5BiJCoTVOgLhnehphQ6SVzm1P
	TQ1WeNU4SepTd
X-Received: by 2002:a05:600c:1e85:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-48069c89792mr113973095e9.30.1769704852868;
        Thu, 29 Jan 2026 08:40:52 -0800 (PST)
X-Received: by 2002:a05:600c:1e85:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-48069c89792mr113972655e9.30.1769704852398;
        Thu, 29 Jan 2026 08:40:52 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e46cesm15195228f8f.7.2026.01.29.08.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:40:52 -0800 (PST)
Message-ID: <b0045978-ea65-422b-8260-d079b43eb553@redhat.com>
Date: Thu, 29 Jan 2026 17:40:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 14/15] quic: add packet builder base
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
 <4ec3ade7dfc709658a2b1839dbe29c9467b25fdf.1769439073.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4ec3ade7dfc709658a2b1839dbe29c9467b25fdf.1769439073.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254856-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7B86B251B
X-Rspamd-Action: no action

On 1/26/26 3:51 PM, Xin Long wrote:
> +/* Configure the QUIC packet header and routing based on encryption level and path. */
> +int quic_packet_config(struct sock *sk, u8 level, u8 path)
> +{
> +	struct quic_conn_id_set *dest = quic_dest(sk), *source = quic_source(sk);
> +	struct quic_packet *packet = quic_packet(sk);
> +	struct quic_config *c = quic_config(sk);
> +	u32 hlen = QUIC_HLEN;
> +
> +	/* If packet already has data, no need to reconfigure. */
> +	if (!quic_packet_empty(packet))
> +		return 0;
> +
> +	packet->ack_eliciting = 0;
> +	packet->frame_len = 0;
> +	packet->ipfragok = 0;
> +	packet->padding = 0;
> +	packet->frames = 0;
> +	hlen += QUIC_PACKET_NUMBER_LEN; /* Packet number length. */
> +	hlen += quic_conn_id_choose(dest, path)->len; /* DCID length. */
> +	if (level) {
> +		hlen += 1; /* Length byte for DCID. */
> +		hlen += 1 + quic_conn_id_active(source)->len; /* Length byte + SCID length. */
> +		if (level == QUIC_CRYPTO_INITIAL) /* Include token for Initial packets. */
> +			hlen += quic_var_len(quic_token(sk)->len) + quic_token(sk)->len;
> +		hlen += QUIC_VERSION_LEN; /* Version length. */
> +		hlen += QUIC_PACKET_LENGTH_LEN; /* Packet length field length. */
> +		/* Allow fragmentation if PLPMTUD is enabled, as it no longer relies on ICMP
> +		 * Toobig messages to discover the path MTU.
> +		 */
> +		packet->ipfragok = !!c->plpmtud_probe_interval;
> +	}
> +	packet->level = level;
> +	packet->len = (u16)hlen;
> +	packet->overhead = (u8)hlen;

Given the above math, it looks like hlen can never be > 255, but
possibly a DEBUG_NET_WARN_ON_ONCE() could save from future bug and make
the code more clear?

> +
> +	if (packet->path != path) { /* If the path changed, update and reset routing cache. */
> +		packet->path = path;
> +		__sk_dst_reset(sk);
> +	}
> +
> +	/* Perform routing and MSS update for the configured packet. */
> +	if (quic_packet_route(sk) < 0)
> +		return -1;
> +	return 0;
> +}
> +
> +static void quic_packet_encrypt_done(struct sk_buff *skb, int err)
> +{
> +	/* Free it for now, future patches will implement the actual deferred transmission logic. */
> +	kfree_skb(skb);
> +}
> +
> +/* Coalescing Packets. */
> +static int quic_packet_bundle(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct quic_skb_cb *head_cb, *cb = QUIC_SKB_CB(skb);
> +	struct quic_packet *packet = quic_packet(sk);
> +	struct sk_buff *p;
> +
> +	if (!packet->head) { /* First packet to bundle: initialize the head. */
> +		packet->head = skb;
> +		cb->last = skb;
> +		goto out;
> +	}
> +
> +	/* If bundling would exceed MSS, flush the current bundle. */
> +	if (packet->head->len + skb->len >= packet->mss[0]) {
> +		quic_packet_flush(sk);
> +		packet->head = skb;
> +		cb->last = skb;
> +		goto out;

The same code is duplicate a few lines above; you could reduce
duplication jumping to a common label.

/P


