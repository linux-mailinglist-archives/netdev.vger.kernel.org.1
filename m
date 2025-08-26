Return-Path: <netdev+bounces-216903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65AB35E28
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FC13A9474
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB02BE7DD;
	Tue, 26 Aug 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZZOf4w5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877A28000C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209192; cv=none; b=lLUom49WyrwIbi+oQMD1xTy/aRXCD+KcVhn5e5c64awyMcrjXno5SwN/Djz9bCYCEBeokNlM+Mx7snhZ3cxTAhz2LDwDXuRRnWHX/SjmchQqzBQxtkqTNEXx7ifIX3R1l4VQXFE8kE2L5I99ngXWecDDLIywMfSs37qrlPMw5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209192; c=relaxed/simple;
	bh=vD1HsfvmNBu3KWk96FoOHr0dQjOj+6IRh6pF6NG05lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIqdmJvXh2BtFQGDu1OAXc3qB39aTZm6cbi5k70ehRkL/3262jiMq1Asu9ZNGz+L0fQ7kUWvB+V1RF4nhH32C+YqOpyU1GiNa15wdC6h3DcpctZIU7h8XBeWvq9ia/qUwWjJK0eltV/Q0AnYI6pS/1Yll/awWWj0HZ9Ri+KWHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZZOf4w5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756209189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ke5YzKGW4E65WfZ+M+Y1rEcE3JkNJ9nEklPLfTRZK6Y=;
	b=MZZOf4w5fKYMSvxPn9K+vZ2JhtuGtqv6z1VC5aR+dLnqF97ExTIemisKoMp5TXW/lF5H/b
	Hbp730dXHzZAjAubI55TkuVlP5vxPtzydlGW16p7rMEXOPVe7BxBoZwQxXA+RTOW7eaPbU
	s1Sip8mF+CYlP0hgpBpoPqEVtF5XrQI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-g97VQzCqNFOSLSJZnRWacg-1; Tue, 26 Aug 2025 07:50:14 -0400
X-MC-Unique: g97VQzCqNFOSLSJZnRWacg-1
X-Mimecast-MFC-AGG-ID: g97VQzCqNFOSLSJZnRWacg_1756209014
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2bf285aa5so66478451cf.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209014; x=1756813814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ke5YzKGW4E65WfZ+M+Y1rEcE3JkNJ9nEklPLfTRZK6Y=;
        b=FXge77VgxJxteR3onCdHeWSPKZty0Gwf+tmZ1+yEzFYqhZb4iskvGzSllpTSIf73i8
         yadpZb5UN8YqDCqXQHzm4iwTheCrebbk/CqV6b/xnv3Q1TEC9Icx1HQYXr5PDshqk8Jk
         uT8JlXcJfKYAUkA9GsqdYNnCYIb0K1JYmZ3x9LhRLk7AgMUQ3qlQ8tw4015H0tBCrdbE
         wVc5cvcD6yNABf8tTTRvi7S9MwRymlNKtjxzPywSpDDkQy9k209LuoGCQF4p3bCUvaK6
         O6sLqqztFkCCiNmTdav01GipDE88BgNO0LE5tyX8Ht7EyD6/lpz7G7vjpub5RS38Sm9h
         AF6A==
X-Forwarded-Encrypted: i=1; AJvYcCVLpo8T4ZYT8EhMiQ1Gqzyl8YLQHa6ZIv+RT2MBuZAcP9egJbiqzeN/LsPW8ENszFidvFUq3lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsCZfOhfGAjzk757CTscL5HC71GJ00b5KZtwpTj+du/JUi2cO
	2w3saQfD6T2QuoCd33iH/k6Fh8seT4ddHvecF+HqLaIyz0i7uoW3ImerTCTsgOd6ppm6ZIQa72/
	PSZPNOV3fKMCfy5rRzzfWBMmnLZlOxdK1NvWh0l4oq+hhCNKY+r7YlHXRpw==
X-Gm-Gg: ASbGncvP+RFNV9CRWtVBUAELMubpzCcsfYfUs0Dr3KEmXxBQVkoZnAUOqb/VM/J+7df
	H9f8RYV5uzCXrAehBsVLTvScXLNgEhZFqb0LXOq/n774eskDdnVObRwdj7PXKqdPauK6yEiZtng
	DOGz+iVfZYXC4YxGG8C4urgdKIH4M8surmI8K1YuEDmZLU1qZPM5fNlqxa8d/aXKCM7cMcidcAw
	wJQLhu4AU1Db1r6y8TSqUqoMRSSCz9gWazgO9CTTvYru/5HQlsNXeCb4WmSzugKz/pseA1YVE/y
	7QZZqfwSi7YRWxz9BGPv8349muQ4xtlcJqQOQfUpKd7UyZgi2aITY00N6iflMNzMjuzI+C57sU7
	kOwGRAjjS6ZQ=
X-Received: by 2002:ac8:5c91:0:b0:4b2:d5bf:2095 with SMTP id d75a77b69052e-4b2d5bf2489mr41458731cf.33.1756209014186;
        Tue, 26 Aug 2025 04:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJEfOeRLo7cj6PzXZ5aMbcWAtQUNhgOqKfA1N4+07vfw1rIRC5Q9FI1mzarhYYMD1nykmyjw==
X-Received: by 2002:ac8:5c91:0:b0:4b2:d5bf:2095 with SMTP id d75a77b69052e-4b2d5bf2489mr41458491cf.33.1756209013489;
        Tue, 26 Aug 2025 04:50:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c62701sm71533321cf.4.2025.08.26.04.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:50:12 -0700 (PDT)
Message-ID: <31aab5bd-7775-4fec-90a1-59e3120d500b@redhat.com>
Date: Tue, 26 Aug 2025 13:50:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 10/15] net: homa: create homa_outgoing.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-11-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-11-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * homa_message_out_fill() - Initializes information for sending a message
> + * for an RPC (either request or response); copies the message data from
> + * user space and (possibly) begins transmitting the message.
> + * @rpc:     RPC for which to send message; this function must not
> + *           previously have been called for the RPC. Must be locked. The RPC
> + *           will be unlocked while copying data, but will be locked again
> + *           before returning.
> + * @iter:    Describes location(s) of message data in user space.
> + * @xmit:    Nonzero means this method should start transmitting packets;
> + *           transmission will be overlapped with copying from user space.
> + *           Zero means the caller will initiate transmission after this
> + *           function returns.
> + *
> + * Return:   0 for success, or a negative errno for failure. It is possible
> + *           for the RPC to be freed while this function is active. If that
> + *           happens, copying will cease, -EINVAL will be returned, and
> + *           rpc->state will be RPC_DEAD.
> + */
> +int homa_message_out_fill(struct homa_rpc *rpc, struct iov_iter *iter, int xmit)
> +	__must_hold(rpc->bucket->lock)
> +{
> +	/* Geometry information for packets:
> +	 * mtu:              largest size for an on-the-wire packet (including
> +	 *                   all headers through IP header, but not Ethernet
> +	 *                   header).
> +	 * max_seg_data:     largest amount of Homa message data that fits
> +	 *                   in an on-the-wire packet (after segmentation).
> +	 * max_gso_data:     largest amount of Homa message data that fits
> +	 *                   in a GSO packet (before segmentation).
> +	 */
> +	int mtu, max_seg_data, max_gso_data;
> +
> +	struct sk_buff **last_link;
> +	struct dst_entry *dst;
> +	u64 segs_per_gso;
> +	int overlap_xmit;
> +
> +	/* Bytes of the message that haven't yet been copied into skbs. */
> +	int bytes_left;
> +
> +	int gso_size;
> +	int err;

Please, no empty lines in the variable declaration section.


> +/**
> + * __homa_xmit_control() - Lower-level version of homa_xmit_control: sends
> + * a control packet.
> + * @contents:  Address of buffer containing the contents of the packet.
> + *             The caller must have filled in all of the information,
> + *             including the common header.
> + * @length:    Length of @contents.
> + * @peer:      Destination to which the packet will be sent.
> + * @hsk:       Socket via which the packet will be sent.
> + *
> + * Return:     Either zero (for success), or a negative errno value if there
> + *             was a problem.
> + */
> +int __homa_xmit_control(void *contents, size_t length, struct homa_peer *peer,
> +			struct homa_sock *hsk)
> +{
> +	struct homa_common_hdr *h;
> +	struct sk_buff *skb;
> +	int extra_bytes;
> +	int result;
> +
> +	skb = homa_skb_alloc_tx(HOMA_MAX_HEADER);
> +	if (unlikely(!skb))
> +		return -ENOBUFS;
> +	skb_dst_set(skb, homa_get_dst(peer, hsk));
> +
> +	h = skb_put(skb, length);
> +	memcpy(h, contents, length);
> +	extra_bytes = HOMA_MIN_PKT_LENGTH - length;
> +	if (extra_bytes > 0)
> +		memset(skb_put(skb, extra_bytes), 0, extra_bytes);
> +	skb->ooo_okay = 1;
> +	skb_get(skb);
> +	if (hsk->inet.sk.sk_family == AF_INET6)
> +		result = ip6_xmit(&hsk->inet.sk, skb, &peer->flow.u.ip6, 0,
> +				  NULL, 0, 0);
> +	else
> +		result = ip_queue_xmit(&hsk->inet.sk, skb, &peer->flow);
> +	if (unlikely(result != 0)) {
> +		/* It appears that ip*_xmit frees skbuffs after
> +		 * errors; the following code is to raise an alert if
> +		 * this isn't actually the case. The extra skb_get above
> +		 * and kfree_skb call below are needed to do the check
> +		 * accurately (otherwise the buffer could be freed and
> +		 * its memory used for some other purpose, resulting in
> +		 * a bogus "reference count").
> +		 */
> +		if (refcount_read(&skb->users) > 1) {
> +			if (hsk->inet.sk.sk_family == AF_INET6)
> +				pr_notice("ip6_xmit didn't free Homa control packet (type %d) after error %d\n",
> +					  h->type, result);
> +			else
> +				pr_notice("ip_queue_xmit didn't free Homa control packet (type %d) after error %d\n",
> +					  h->type, result);
> +		}

Please remove the above check and related refcounting.

> +	}
> +	kfree_skb(skb);
> +	return result;
> +}
> +
> +/**
> + * homa_xmit_unknown() - Send an RPC_UNKNOWN packet to a peer.
> + * @skb:         Buffer containing an incoming packet; identifies the peer to
> + *               which the RPC_UNKNOWN packet should be sent.
> + * @hsk:         Socket that should be used to send the RPC_UNKNOWN packet.
> + */
> +void homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk)
> +{
> +	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
> +	struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	struct homa_rpc_unknown_hdr unknown;
> +	struct homa_peer *peer;
> +
> +	unknown.common.sport = h->dport;
> +	unknown.common.dport = h->sport;
> +	unknown.common.type = RPC_UNKNOWN;
> +	unknown.common.sender_id = cpu_to_be64(homa_local_id(h->sender_id));
> +	peer = homa_peer_get(hsk, &saddr);
> +	if (!IS_ERR(peer))
> +		__homa_xmit_control(&unknown, sizeof(unknown), peer, hsk);
> +	homa_peer_release(peer);
> +}
> +
> +/**
> + * homa_xmit_data() - If an RPC has outbound data packets that are permitted
> + * to be transmitted according to the scheduling mechanism, arrange for
> + * them to be sent (some may be sent immediately; others may be sent
> + * later by the pacer thread).
> + * @rpc:       RPC to check for transmittable packets. Must be locked by
> + *             caller. Note: this function will release the RPC lock while
> + *             passing packets through the RPC stack, then reacquire it
> + *             before returning. It is possible that the RPC gets freed
> + *             when the lock isn't held, in which case the state will
> + *             be RPC_DEAD on return.
> + * @force:     True means send at least one packet, even if the NIC queue
> + *             is too long. False means that zero packets may be sent, if
> + *             the NIC queue is sufficiently long.
> + */
> +void homa_xmit_data(struct homa_rpc *rpc, bool force)
> +	__must_hold(rpc->bucket->lock)
> +{
> +	struct homa *homa = rpc->hsk->homa;
> +	int length;
> +
> +	while (*rpc->msgout.next_xmit && rpc->state != RPC_DEAD) {
> +		struct sk_buff *skb = *rpc->msgout.next_xmit;
> +
> +		if (rpc->msgout.length - rpc->msgout.next_xmit_offset >
> +		    homa->pacer->throttle_min_bytes) {
> +			if (!homa_pacer_check_nic_q(homa->pacer, skb, force)) {
> +				homa_pacer_manage_rpc(rpc);
> +				break;
> +			}
> +		}
> +
> +		rpc->msgout.next_xmit = &(homa_get_skb_info(skb)->next_skb);
> +		length = homa_get_skb_info(skb)->data_bytes;
> +		rpc->msgout.next_xmit_offset += length;
> +
> +		homa_rpc_unlock(rpc);
> +		skb_get(skb);
> +		__homa_xmit_data(skb, rpc);
> +		force = false;
> +		homa_rpc_lock(rpc);
> +	}
> +}
> +
> +/**
> + * __homa_xmit_data() - Handles packet transmission stuff that is common
> + * to homa_xmit_data and homa_resend_data.
> + * @skb:      Packet to be sent. The packet will be freed after transmission
> + *            (and also if errors prevented transmission).
> + * @rpc:      Information about the RPC that the packet belongs to.
> + */
> +void __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc)
> +{
> +	skb_dst_set(skb, homa_get_dst(rpc->peer, rpc->hsk));
> +
> +	skb->ooo_okay = 1;
> +	skb->ip_summed = CHECKSUM_PARTIAL;
> +	skb->csum_start = skb_transport_header(skb) - skb->head;
> +	skb->csum_offset = offsetof(struct homa_common_hdr, checksum);
> +	if (rpc->hsk->inet.sk.sk_family == AF_INET6)
> +		ip6_xmit(&rpc->hsk->inet.sk, skb, &rpc->peer->flow.u.ip6,
> +			 0, NULL, 0, 0);
> +	else
> +		ip_queue_xmit(&rpc->hsk->inet.sk, skb, &rpc->peer->flow);
> +}
> +
> +/**
> + * homa_resend_data() - This function is invoked as part of handling RESEND
> + * requests. It retransmits the packet(s) containing a given range of bytes
> + * from a message.
> + * @rpc:      RPC for which data should be resent.
> + * @start:    Offset within @rpc->msgout of the first byte to retransmit.
> + * @end:      Offset within @rpc->msgout of the byte just after the last one
> + *            to retransmit.
> + */
> +void homa_resend_data(struct homa_rpc *rpc, int start, int end)
> +	__must_hold(rpc->bucket->lock)
> +{
> +	struct homa_skb_info *homa_info;
> +	struct sk_buff *skb;
> +
> +	if (end <= start)
> +		return;
> +
> +	/* Each iteration of this loop checks one packet in the message
> +	 * to see if it contains segments that need to be retransmitted.
> +	 */
> +	for (skb = rpc->msgout.packets; skb; skb = homa_info->next_skb) {
> +		int seg_offset, offset, seg_length, data_left;
> +		struct homa_data_hdr *h;
> +
> +		homa_info = homa_get_skb_info(skb);
> +		offset = homa_info->offset;
> +		if (offset >= end)
> +			break;
> +		if (start >= (offset + homa_info->data_bytes))
> +			continue;
> +
> +		offset = homa_info->offset;
> +		seg_offset = sizeof(struct homa_data_hdr);
> +		data_left = homa_info->data_bytes;
> +		if (skb_shinfo(skb)->gso_segs <= 1) {
> +			seg_length = data_left;
> +		} else {
> +			seg_length = homa_info->seg_length;
> +			h = (struct homa_data_hdr *)skb_transport_header(skb);
> +		}
> +		for ( ; data_left > 0; data_left -= seg_length,
> +		     offset += seg_length,
> +		     seg_offset += skb_shinfo(skb)->gso_size) {
> +			struct homa_skb_info *new_homa_info;
> +			struct sk_buff *new_skb;
> +			int err;
> +
> +			if (seg_length > data_left)
> +				seg_length = data_left;
> +
> +			if (end <= offset)
> +				goto resend_done;
> +			if ((offset + seg_length) <= start)
> +				continue;
> +
> +			/* This segment must be retransmitted. */
> +			new_skb = homa_skb_alloc_tx(sizeof(struct homa_data_hdr)
> +					+ seg_length);

Please fix the alignment above

[...]
> +/**
> + * homa_rpc_tx_end() - Return the offset of the first byte in an
> + * RPC's outgoing message that has not yet been fully transmitted.
> + * "Fully transmitted" means the message has been transmitted by the
> + * NIC and the skb has been released by the driver. This is different from
> + * rpc->msgout.next_xmit_offset, which computes the first offset that
> + * hasn't yet been passed to the IP stack.
> + * @rpc:    RPC to check
> + * Return:  See above. If the message has been fully transmitted then
> + *          rpc->msgout.length is returned.
> + */
> +int homa_rpc_tx_end(struct homa_rpc *rpc)
> +{
> +	struct sk_buff *skb = rpc->msgout.first_not_tx;
> +
> +	while (skb) {
> +		struct homa_skb_info *homa_info = homa_get_skb_info(skb);
> +
> +		/* next_xmit_offset tells us whether the packet has been
> +		 * passed to the IP stack. Checking the reference count tells
> +		 * us whether the packet has been released by the driver
> +		 * (which only happens after notification from the NIC that
> +		 * transmission is complete).
> +		 */
> +		if (homa_info->offset >= rpc->msgout.next_xmit_offset ||
> +		    refcount_read(&skb->users) > 1)
> +			return homa_info->offset;

Pushing skbs with refcount > 1 into the tx stack calls for trouble. You
should instead likely clone the tx skb.

/P


