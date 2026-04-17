Return-Path: <netdev+bounces-279260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GFCI0vs4WmKzgAAu9opvQ
	(envelope-from <netdev+bounces-279260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458F418762
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DFFC30197CA
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100723A0B24;
	Fri, 17 Apr 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h21FMBUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE4305E32
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413758; cv=none; b=PRvT0ySqvJ4tjY0kJMZY6GuCG216q7OW2vFfRPvWbeND+wYv6VAnTQ8lZWknREWoHJ49FM5L+AfrivLv30Jx23l8WCOir0e7Dg0Dy1bQQ6NuqzmdVLlzJuPYmAskTsT4nbs8Q7tehdYcdhx/NT2Ft8Mj7bY2MQXUblG21YxQiLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413758; c=relaxed/simple;
	bh=PpnxVvmaPk2lWAwC6xj119Xc9DGyz+bgJI1ylHvv2c0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OAqhi/M9V0ATZLVcEeGoDX1DG6ftMwD/5E/i8zJ8FY7DVmGFiiqgHrXKFDNRQJeb2unXygs2CJPZfhxDiw4WIwMEAwOgzjkI5dtc4iKl3hzrZe6mHb87FKXIxVSJft8/AuoivNtpa3+NQeb3Gu2qhsLlPa7EMbsU7/BNM9aYX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h21FMBUK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a46ebe2beso3544847b3.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776413753; x=1777018553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UuvuW7iBRrydD3utAJKecskxjYEslQjKES/F5rD4dU=;
        b=h21FMBUKJOGMm90xqOA1C32OajYmIJud4IMPyrdxsJurPVsWwzlRV5BQ7UNhTto4+1
         ieSRg+AWWd4m5LmvGaYd92TTickUKkuxQlW60B2uhkz0moNcSJWvvskBa9Dy4QvFJIcS
         68iQif8Q9Rh8qbstZxCiPqTT3l/C9OubabDHds3QHIpBEg7vGYPYnOBcnX2pH0dXlBWg
         Y/yUI+Aft1a0ufVmbe8aVdDirjvmoU0Mr7UtSQ+I6DAP5NQikvktg0WEB+Er5dMXK0K8
         NaIiHXoaGyI9GnF6JI7TlCbIWAMm1E0MvhJifIkrLWvTxDHVmk9g/D8N6Uvd3TYf9LKF
         A6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413753; x=1777018553;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UuvuW7iBRrydD3utAJKecskxjYEslQjKES/F5rD4dU=;
        b=VvXtiLDXu6GLTC1GWePtKsgaC9ume0smIgd4X0lB7Dp2q8XpxNKCIxt2SJC2+q/550
         ZiE63FiVpUj/BeoMOdvYOMtEFt3YogAdwMc+r4H3nhYcFb/hXhbcm+vJHdKOx/sE54lF
         ZUZPo1erxQO0FrAOnzd2afOO+LSAHwaCoWRDn/wq3YyVeUyoIpgABhr110cRVE/tIW7D
         XQqCNSFsfQwrnWynRsC6oX/2UVHEkCEWBRJOZBcK3XHYBXPXgDoiihO3Awh98IJrIGzL
         aorKULxUnsdeTWtlFtTV579v2nUe1KHnf6VYe5BNzwhKnJVpaMjDvszYCSQRQ6Hi38Di
         SpsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2MaDAeBd6qwv5QfiridFECJRTjhkcB3sIFCJv8AY4vFz445TaRO/C8PycwQTQobMYqJFeLSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfSe1IOEXOxqFrTst6iTVJbNqpiyf8k4oBuntJ6IGNANt/Z1N
	3P9cZyfzZAFOGqqKWPQF2ynhewBguJI76Ym5p/he+6P6tEY+rpJSEU/eGYv8B2ZL
X-Gm-Gg: AeBDieuoQuarh8QH4IcxwiLBTSA7+GG9RiE/mCJKmXnNZw0PHv+nm9KeEZfjK9GoztL
	obq4lIyDAEGnXUCUR74h6IUzQwJTalOIjJymACaJvtNBTB0WOl6MRn6wMB8KODtJ3QYiYUaAFyx
	FhbrX3NAwn4tpwMWpDlaiZBX0RzbSRWHFYHvqPF+4+tFzxcpo4AQ5/qUmrqDejUwzS1I0wgJAaX
	JiniIQPkrG5wKdhK1Q8UOa4Z5NzqfPrxWbzV5SjVNNcD1c300/R09101oTyGsTVrhPmIATQIO8+
	DDKRFXBp3wBOFYTc212ludrWzauADqHcwZjE2IrRn8d/QjWV1Zx7UPhW+Z+vjNh0e9nB6PqtOiw
	75g4hUQ9jutv/NOD+toYW3YGk3tli1zR2tP694gRGW1YQpAKLbziPfzOR44ttL/t6f5SfkBl0ZM
	0DSS3enH8Uepj5GjdtEKbjyzwSDVwupN74cplK8rBo3TEw1DXZOd399gu77XmEr1Nj7lLLEkzha
	Y/pir6mIvXgmN0=
X-Received: by 2002:a05:690c:4b0b:b0:7b1:3579:2f00 with SMTP id 00721157ae682-7b9ecf8b675mr17420857b3.30.1776413753411;
        Fri, 17 Apr 2026 01:15:53 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b5254sm3595937b3.41.2026.04.17.01.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:15:52 -0700 (PDT)
Date: Fri, 17 Apr 2026 04:15:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zero Mark <patzilla007@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: security@kernel.org, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, 
 Zero Mark <patzilla007@gmail.com>
Message-ID: <willemdebruijn.kernel.1683671b10e8@gmail.com>
In-Reply-To: <20260417060714.35488-1-patzilla007@gmail.com>
References: <CAHOBGNBvZOXGzzMDuHWw1RrRvbg4TZVH34jVDhc1nkHbW_URXA@mail.gmail.com>
 <20260417060714.35488-1-patzilla007@gmail.com>
Subject: Re: [PATCH] net/packet: fix TOCTOU race on mmap'd vnet_hdr in
 tpacket_snd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4458F418762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zero Mark wrote:
> In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
> directly into the mmap'd TX ring buffer shared with userspace. The
> kernel validates the header via __packet_snd_vnet_parse() but then
> re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
> userspace thread can modify the vnet_hdr fields (gso_type, gso_size,
> flags, csum_start, csum_offset) between validation and use, bypassing
> all safety checks.
> 
> This can lead to:
>  - Out-of-bounds checksum writes via crafted csum_start/csum_offset
>  - Malicious GSO segmentation parameters
>  - Kernel memory corruption and potential local privilege escalation
> 
> The non-TPACKET path (packet_snd()) already correctly copies vnet_hdr
> to a stack-local variable. All other vnet_hdr consumers in the kernel
> (tun.c, tap.c, virtio_net.c) also use stack copies. The TPACKET TX
> path is the only caller of virtio_net_hdr_to_skb() that reads directly
> from user-controlled shared memory.
> 
> Fix this by copying vnet_hdr from the mmap'd ring buffer to a
> stack-local variable before validation and use, consistent with the
> approach used in packet_snd() and all other callers.
> 
> Exploitation requires CAP_NET_RAW, which can be obtained without
> special privileges via user namespaces.
> 
> Confirmed with a PoC on Linux 6.8.0 (Ubuntu): kprobe tracing on
> skb_partial_csum_set captured 77 race wins in 500,000 iterations.

No need to add such details on exploitability of bugs.

> Affects all kernels since PACKET_VNET_HDR support was added to the
> TPACKET TX path (~v3.14).
> 
> Fixes: 9ed988e5 ("packet: add vnet_hdr support for tpacket_snd")

This patch does not exist. Also 12-char SHA1.

I think this should be

Fixes: 1d036d25e560 ("packet: tpacket_snd gso and checksum offload")

> Signed-off-by: Zero Mark <patzilla007@gmail.com>

Thanks for the fix!

Only it does not apply cleanly. Please mark fixes [PATCH net] and
ensure that they apply to current netdev-net/main

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> ---
>  net/packet/af_packet.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index abcdef012345..fedcba654321 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2725,7 +2725,8 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
>  static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  {
>  	struct sk_buff *skb = NULL;
>  	struct net_device *dev;
> -	struct virtio_net_hdr *vnet_hdr = NULL;
> +	struct virtio_net_hdr vnet_hdr;
> +	bool has_vnet_hdr = false;
>  	struct sockcm_cookie sockc;
>  	__be16 proto;
>  	int err, reserve = 0;
> @@ -2828,16 +2829,17 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		if (po->has_vnet_hdr) {
> -			vnet_hdr = data;
> -			data += sizeof(*vnet_hdr);
> -			tp_len -= sizeof(*vnet_hdr);
> +			memcpy(&vnet_hdr, data, sizeof(vnet_hdr));

Move the tp_len < 0 check before memcpy

> +			data += sizeof(vnet_hdr);
> +			tp_len -= sizeof(vnet_hdr);
>  			if (tp_len < 0 ||
> -			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
> +			    __packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
>  				tp_len = -EINVAL;
>  				goto tpacket_error;
>  			}
>  			copylen = __virtio16_to_cpu(vio_le(),
> -						    vnet_hdr->hdr_len);
> +						    vnet_hdr.hdr_len);
> +			has_vnet_hdr = true;
>  		}
>  		copylen = max_t(int, copylen, dev->hard_header_len);
>  		skb = sock_alloc_send_skb(&po->sk,
> @@ -2875,11 +2877,11 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		}
> 
> -		if (po->has_vnet_hdr) {
> -			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
> +		if (has_vnet_hdr) {
> +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
>  				tp_len = -EINVAL;
>  				goto tpacket_error;
>  			}
> -			virtio_net_hdr_set_proto(skb, vnet_hdr);
> +			virtio_net_hdr_set_proto(skb, &vnet_hdr);
>  		}
> 
>  		skb->destructor = tpacket_destruct_skb;
> --
> 2.43.0
> 



