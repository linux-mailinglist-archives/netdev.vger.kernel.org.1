Return-Path: <netdev+bounces-126425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B528971231
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020FC283BD1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8A1B1422;
	Mon,  9 Sep 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FkyWeOfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430415B995
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870923; cv=none; b=uvmnWcPXG+49Q4UBkYyS+QsUpUiF8oopXzHtwE1A/UzmS6Q24JBzntle0zc+cJdpXRU9ZQaZJfmrNdSEtEZXsQ5qfof7jBkwT5jkRnNMNT4o763r5+033LA+jCpGVgyln/b+4EGRzduThiTFmKRmxDGJ+x4RELwBS4lMcnaLrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870923; c=relaxed/simple;
	bh=usgHYvOGBI8nWwwD88o6wnYxu0WwhYnaC1+CGGzeAHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRxvXV2/nL0Rub0RCMpqvFUf8Fe5VcMD0Gr8O/fAsdmyyNF1aEEG2ExwKGhs7qGdaQUqu05BjH1+dPVsJ7lggOeFGN1r7y55VxdrlFuoGkwiyxwEiluzJFhp0ysM74a/c5BeIF24owva/ZsBtMXfyD5U2yQgFVrhlfyc7v0bC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FkyWeOfO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso344193566b.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725870920; x=1726475720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=woMoJ19rKsd29kbeEr9fBz/R26OA2nfXngk9BT0VkzI=;
        b=FkyWeOfOhIt/8jtJY6dAAbxl9C12a/I3TAu7Ro15iqkcuZ3ITIRYgoY5++7hajdJO+
         QQdhNvud0ruXG/Jj7N1BiupUKUZyavCzl6Y14qI57gVFdPtYRdWOkjn0orEsdt1YFvpU
         +DQi7kHdssKdCoyZ9VjdMIb8M1evoq2P5zBQzYmASH+XI4748kY4N4tQNTq35iEMdcQE
         WswnoCXzGgX7NfAtsRQPU7PoThM7/gvabc7ceS6SVOVrRTAa9hMjNWNGghxoqZY676is
         r0NLTpQ5cWfhPHigswjgXT1DsLFYSdLSuJ6tKnO5EshbKEoOtk6tnevwKRas9+a2y7bf
         LKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870920; x=1726475720;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woMoJ19rKsd29kbeEr9fBz/R26OA2nfXngk9BT0VkzI=;
        b=heLMF4FY9bOeC4kmIs3Lw9MiQIaX521nt9lvWVVkefeb9e5JY7ewVIgGM3yVJRDhPe
         JaiD26Vww1e9gq+Aw7hxfJezZetBxjwlo6fvpsGqRQXG5ine+cyC5LFEQt/KqNebIb+r
         hRCB9XqiV9010hgK2W+YPXLX5oAB8er9mPauUCDUxTYqZ/W6f2yq8kNafjpotTUCuMnZ
         p2kp2OjFkvtUuivj3sZjJBi/BXl6YskHew/S5GS4okAQFm2KETBVmh5eB3pw8or3hHRa
         AGZnZf6i3w1VNeyqsgXjHG2UBUsOZYCtJxGvUA3WeX/z04qYy+Bgu93/4/VS1zUcUJGH
         qnbw==
X-Gm-Message-State: AOJu0YzhzvAxMz04Zyb5eJdqAqoflsBXmR/922B4cwgLdKsTD6jF+tWa
	2+bj5h5c2lbx3piI/hmlJiPO26+fbLsd6AAzTC44t+4ZES5CEFSrTWwQrQi6jk8=
X-Google-Smtp-Source: AGHT+IEma6UQYqRqu7RYQeM70GndJ8sK7SkdPhvvcR2qx9l3NiAHKKlFya5hEprmcUOYO/Bir/aWZA==
X-Received: by 2002:a17:906:d553:b0:a80:bf95:7743 with SMTP id a640c23a62f3a-a8a885bdddamr722692666b.13.1725870919828;
        Mon, 09 Sep 2024 01:35:19 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:105f:6dd9:35c9:a9e8? ([2001:67c:2fbc:1:105f:6dd9:35c9:a9e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced17asm311574066b.170.2024.09.09.01.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:35:19 -0700 (PDT)
Message-ID: <07fab8c7-fc86-4f65-835b-9bdbafa140e2@openvpn.net>
Date: Mon, 9 Sep 2024 10:37:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/25] ovpn: implement basic RX path (UDP)
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-12-antonio@openvpn.net>
 <20240906191809.GM2097826@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240906191809.GM2097826@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 21:18, Simon Horman wrote:
> On Tue, Aug 27, 2024 at 02:07:51PM +0200, Antonio Quartulli wrote:
>> Packets received over the socket are forwarded to the user device.
>>
>> Implementation is UDP only. TCP will be added by a later patch.
>>
>> Note: no decryption/decapsulation exists yet, packets are forwarded as
>> they arrive without much processing.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> +/**
>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>> + * @sk: socket over which the packet was received
>> + * @skb: the received packet
>> + *
>> + * If the first byte of the payload is DATA_V2, the packet is further processed,
>> + * otherwise it is forwarded to the UDP stack for delivery to user space.
>> + *
>> + * Return:
>> + *  0 if skb was consumed or dropped
>> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>> + */
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct ovpn_peer *peer = NULL;
>> +	struct ovpn_struct *ovpn;
>> +	u32 peer_id;
>> +	u8 opcode;
>> +
>> +	ovpn = ovpn_from_udp_sock(sk);
>> +	if (unlikely(!ovpn)) {
>> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
>> +				    __func__);
>> +		goto drop;
> 
> Hi Antonio,
> 
> Here ovpn is NULL. But jumping to drop will result in ovpn being dereferenced.
> 
> Flagged by Smatch.

You are correct, thanks for the report.
Will fix it in the next version.

Cheers,

> 
> 
>> +	}
>> +
>> +	/* Make sure the first 4 bytes of the skb data buffer after the UDP
>> +	 * header are accessible.
>> +	 * They are required to fetch the OP code, the key ID and the peer ID.
>> +	 */
>> +	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
>> +				    OVPN_OP_SIZE_V2))) {
>> +		net_dbg_ratelimited("%s: packet too small\n", __func__);
>> +		goto drop;
>> +	}
>> +
>> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>> +	if (unlikely(opcode != OVPN_DATA_V2)) {
>> +		/* DATA_V1 is not supported */
>> +		if (opcode == OVPN_DATA_V1)
>> +			goto drop;
>> +
>> +		/* unknown or control packet: let it bubble up to userspace */
>> +		return 1;
>> +	}
>> +
>> +	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
>> +	/* some OpenVPN server implementations send data packets with the
>> +	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
>> +	 * and we try with the transport address
>> +	 */
>> +	if (peer_id != OVPN_PEER_ID_UNDEF) {
>> +		peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +		if (!peer) {
>> +			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
>> +					    __func__, peer_id);
>> +			goto drop;
>> +		}
>> +	}
>> +
>> +	if (!peer) {
>> +		/* data packet with undef peer-id */
>> +		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
>> +		if (unlikely(!peer)) {
>> +			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
>> +					    __func__);
>> +			goto drop;
>> +		}
>> +	}
>> +
>> +	/* pop off outer UDP header */
>> +	__skb_pull(skb, sizeof(struct udphdr));
>> +	ovpn_recv(peer, skb);
>> +	return 0;
>> +
>> +drop:
>> +	if (peer)
>> +		ovpn_peer_put(peer);
>> +	dev_core_stats_rx_dropped_inc(ovpn->dev);
>> +	kfree_skb(skb);
>> +	return 0;
>> +}
>> +
> 
> ...

-- 
Antonio Quartulli
OpenVPN Inc.

