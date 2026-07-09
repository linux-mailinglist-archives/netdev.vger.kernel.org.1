Return-Path: <netdev+bounces-306019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8gnYEmX4TmoiYAIAu9opvQ
	(envelope-from <netdev+bounces-306019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D472BACA
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:24:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y6BrfKTt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306019-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306019-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24B33048914
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983C38F236;
	Thu,  9 Jul 2026 01:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C488389DF0
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:24:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560254; cv=none; b=liTEWZSgiz7SXSx+PXfjy8HlPRD/d6K8PdKliMIBPS+ARaUsLLDuOoWD9sdnMxb6GqRpNJNgCn6qC9HuKuoBMJValOVc2q7k4TsRTsDsjyxFVCU8ZHbQWvfVXUgmz7ZaXOjogWu6+CF29FGFFTKPDimI0rahez2080n6KncGgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560254; c=relaxed/simple;
	bh=RfF1dKAqM2zfQSr+my3zTNccGaaz2PPMX7X5gTI7438=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V1z6w0lN8c3dRcSijiI41vBB1qO3Ml1o+BeJQUXmHQJKKihcP+IGF+5mSPWH40cG0Cq6m4qE5yugoTQmv1PyZWDf1Qqi0X4P/2Yge0j64OAOCyRSRlMt8zr1Ui2OnPmRbjIOO5uQpFzzwdEMoSMQ7ck7f/3a+fnX8a1zh/airlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6BrfKTt; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-804e46366d7so7519137b3.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783560252; x=1784165052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RAF6gSZL5EYthmH74Z0dkKFhTxVvkytNqNQGquUdHyE=;
        b=Y6BrfKTt5BgaGPNoFfGA2wp450jMu+DHBX+Fm8q5hvbaywwemdqK+xhRTMbvEipk6k
         TUWsgLCxqdt5Z1ziewEg1dav3fX/AmjtrL+g8sFPBYyFnvqttPdRw+dyNzXFoh3xZTES
         CAKhiiarrYXOBFfCMTfVhcHp3EEPCdWtuQtStxWASaTrdIWstgzN8j87faKmGoWEZ/GJ
         ciVZZVWB/Wg66060Jwz3WTYJ4H3avLt28WkIy003DHa2/WcBfg/ZfcySBWuAKvz035Ax
         WHTZLaKN7762pwPhZkIHAhNF8btpi9CL1T6gWfyRjdxylsY98g4IAcLr80yCWmQQCK8g
         XKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783560252; x=1784165052;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAF6gSZL5EYthmH74Z0dkKFhTxVvkytNqNQGquUdHyE=;
        b=srp8d5BIk2Ui6CCVbO+ZFEpMSBX15I0QDhAsIa9ig+qtyNiDg6SeckuBmGbRvDEXFz
         7ZNfSSNvOZ4xJhABpcUsTnTkJmfwmSYFlayiXXcmlolYFxLneNdfhXhEgxV0GpcpxA6O
         whJt+62uOp2vWVe812EBxL7OthnRmOOM666QKadVWSQxIzcLBhNYEWz5+BYnM9w4t8Hu
         S/N6HG2JtoxLY0xBh1OEuDtNhSE8hqQHDLWK3CTkkbA6H5JCc1H4w9bX8Rv3Pl+Xuh3t
         PhQjLeSTXW8uQaPk73OGYl9uKeQZJ1yfB0K4G0+7nNB6umSZsUwAxV/0Iz+l6pesIJi1
         r0Rw==
X-Forwarded-Encrypted: i=1; AHgh+RrWU/yYzaTFZO85ElBRAgZAOUjaOSmEqn2oyefZGxWzK5QFQ+uI2kJfvq9HfhaGCZubPYOTvlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxePPfcMY6w4oNTSXKdVkgHQoTAdphqivb6fbE52xIx2gIVJA7/
	ne003WIx/Ql0WI7coHcbL1lgFy0GW3oazPVQs80og2qbNYSKdyb8WFB9lYeRrQ==
X-Gm-Gg: AfdE7cnYTj8/72VBWKAxRtXatfEVXi5fkbcXnEZlUDnUEIoX2EaxR+f0rXv8+liCaes
	4bp4yR/6sdVQ/FIDoeojzbzyjB3fixtke4Trg3ET2UgZo2QNeq5itGBfApSsPwgEbZ6+U2mHkbA
	OGzNhVJU/yPYepu2i8MBmZ3nHpqTGKiCIuAeZOG/RP3J58udelY1A+loElKEfVfpY8b7EdXY5jc
	fVy9bqV5bqSDITZvxspZUbY8xAuw9suyOu+e0rt7PeTG1HCMpsCQRYWgpbl7tn+gOnRjsquzrOu
	f6OS0fS65ysfLWFG/evoFUq7YAi8K/tagHzBMbthBN0puj0vrr+GudpkQ15x6bA8tl2P3TGqX1E
	xJistRlNvewBfqM87yZNRL3o42eb28GLfU/GDybtiU+5KdzyFNXQTskYQG3Klyb68mqb8ZLCJIi
	u4PkhsUav0Dwn9lKp2+pYQxCX6rwHSA/7zlt1MLpN1a60sWbA2VnW0XGKsHtWsuy0EC+Zk4jpVZ
	zOG
X-Received: by 2002:a05:690c:6a82:b0:80c:3848:bde6 with SMTP id 00721157ae682-81dbed5a6f5mr42887607b3.30.1783560251840;
        Wed, 08 Jul 2026 18:24:11 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1e1d12sm5858607b3.33.2026.07.08.18.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:24:11 -0700 (PDT)
Date: Wed, 08 Jul 2026 21:24:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2a3e532d3c28f@gmail.com>
In-Reply-To: <5372ccac062193147e02b991d5328a5c3fa3a85a.1783372173.git.littlesmilingcloud@gmail.com>
References: <cover.1783372173.git.littlesmilingcloud@gmail.com>
 <5372ccac062193147e02b991d5328a5c3fa3a85a.1783372173.git.littlesmilingcloud@gmail.com>
Subject: Re: [PATCH net-next v6 1/2] udp: fix encapsulation packet resubmit in
 multicast deliver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306019-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D57D472BACA

Anton Danilov wrote:
> When a UDP encapsulation socket (e.g., FOU) receives a multicast
> packet, __udp4_lib_mcast_deliver() and __udp6_lib_mcast_deliver()
> call consume_skb() when udp_queue_rcv_skb() returns a positive value.
> A positive return value from udp_queue_rcv_skb() indicates that the
> encap_rcv handler (e.g., fou_udp_recv) has consumed the UDP header
> and wants the packet to be resubmitted to the IP protocol handler
> for further processing (e.g., as a GRE packet).
> 
> The unicast paths handle this correctly by propagating the return
> value up to ip_protocol_deliver_rcu() / ip6_protocol_deliver_rcu()
> for resubmission. However, the multicast paths destroy the packet
> via consume_skb() instead of resubmitting it, causing silent packet
> loss.
> 
> This affects any UDP encapsulation (FOU, GUE) combined with multicast
> destination addresses.
> 
> Fix this by returning the value from udp_queue_rcv_skb() when it is
> positive, matching the behavior of the corresponding unicast paths.
> Note the sign difference between IPv4 and IPv6:
> 
>   - IPv4: udp_unicast_rcv_skb() returns -ret, and
>     ip_protocol_deliver_rcu() resubmits when ret < 0
>     (using -ret as the protocol number).
>   - IPv6: udp6_unicast_rcv_skb() returns ret, and
>     ip6_protocol_deliver_rcu() resubmits when ret > 0
>     (using ret as the nexthdr).
> 
> Both mcast paths now follow the same convention as their respective
> unicast paths.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/ipv4/udp.c | 6 ++++--
>  net/ipv6/udp.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 59248a59358c..d3ddcbfc8477 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2476,6 +2476,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	struct udp_hslot *hslot;
>  	struct sk_buff *nskb;
>  	bool use_hash2;
> +	int ret;
>  
>  	hash2_any = 0;
>  	hash2 = 0;
> @@ -2520,8 +2521,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	}
>  
>  	if (first) {
> -		if (udp_queue_rcv_skb(first, skb) > 0)
> -			consume_skb(skb);
> +		ret = udp_queue_rcv_skb(first, skb);
> +		if (ret > 0)
> +			return -ret;

This helps the case of one encap_rcv socket in the multicast receiver
group, so is a useful fix on its own.

But is Sashiko correct that this would still leave the same issue for
other sockets in the group? If so, something to address in this series
or leave for later?

Might be worthwhile to extend the test to capture that case too.

