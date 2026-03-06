Return-Path: <netdev+bounces-264925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAODEi9Gq2k0bwEAu9opvQ
	(envelope-from <netdev+bounces-264925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBC227EDA
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E117330338AB
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1A364E81;
	Fri,  6 Mar 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNNVqQXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D027F4F5
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832300; cv=none; b=WIeoiYYhjycKUn+P1gybn7T1L9LXit82LG/9e+hubKlVymamiOvlTfT1cOI3h4xKGpGMX/Imp8gXaOLhm7Gh0qck8H+cZ9sv+eWcKCh1IgZi84zLvpEOoY14EPWt3wTfhaoyPiyxvhlOJAA64zjePV+VNpN+veOhtC2oV9FMicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832300; c=relaxed/simple;
	bh=Y6RGphcVtA+APhhUbk0LT8VeW+w+PVifx2fiF68iiYk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bZK6zaJZ7JwSMk+XiONPdxQ18fxetjKUWFUqyLe26kHW0iOS2Ntxs86lFi+7TeCi1eoh4naxz47EvXf2P3HAETf4bUcnMSvP2xUSUyJhVSZFppHesBTXdVa1vxMHDGmSFcE2XyNrDGWypDYr2agiORqsn+r3J8mwu7TqzwAJz3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNNVqQXK; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79827d28fc4so91157347b3.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772832298; x=1773437098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaxC0nT6LYOMfaYhHMEfJLwXiJYQia1/w34rNOqAry8=;
        b=nNNVqQXKjhtYofPuLNwBJQdYgHFc8QAIoLHX9pcWT9GyED5+jFffsZBcuYQ85sYufj
         pD4KleCk5BmYHbVSOXnFLe0SKLmi0X1/2b4tB1G0Wh+4ektSC+6OTYp6vrbXP4qe1A2i
         RcDWAsCe5TGo+iocZ3gMUJiR+V3vU5RU1siuLQXOD5svh6r4Yp435citlMLMEAFN4e7G
         T4CQqpcBymz4DrkawpIfJUFipIbPxQM46Dmljr7n38RFg2DvVg9knj5+BpS8ftRPMkeO
         Fug0gw4HvepQusXpnT+3U2jxh/8ORYCpbUjhmphpRJ9ojCtK9+3ItTasPfN82+/Yru7H
         7l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772832298; x=1773437098;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaxC0nT6LYOMfaYhHMEfJLwXiJYQia1/w34rNOqAry8=;
        b=f0WpU5uO98YI29z1G+8+dn1WBEzIU7DG2RdpuV54DetvRkmWbjxh7CjfhIyQyXyBsO
         dLLe6iIPdEuiEar/tcWSKzaq7Km1qeUotEclSo1fWbuKCHn5XOJfUW9k/6J1w6UIEANM
         u6RAGYoNrnI8i7ZGi+Xfw4mLwUfnzEiiOCypg2zNmzIlSoKEQ1CGfjQbUekMZvR+j5Dy
         4WeAEkPs3eAqeO99hz/E60MZ+4254oJIMpnsVcvTyPlPhLbW7Mp0d3orO3wkPfzzlPzH
         lmxPfxp11QDxvaRaklTDHQm6q3t+wyRfrOuwVfopgF7hhg2gnEEhyOBXZAOfvGV2feOj
         Ftog==
X-Forwarded-Encrypted: i=1; AJvYcCXuz4cUI62oDwzvDpDQEsvF2W9H4iz4MdRxPOSH8TFo5a98m4kDvOSPzLUv6jzTB80kZMaWR/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3arbBySWUhL7fZcnuGiQvmJLUksu1waXzIheETBxmsQNdzlH
	Ci5X2VvSJZlu2JzxuP2ZjVwu/BRxcltfeYwFs5ESscaV5IW8ggfQaHdJ
X-Gm-Gg: ATEYQzzu35+4vO1TpKrBRx4StZfMuyDZuToCwq1kAUnwymL66tmxEeXyRAuP8AfS0Jk
	V8+R0DAdyPb32PnvZuV1nzdJRHiDhF37glEDVVCmJnyJcT1yGESVbkMMd1R3UoSujcDdNJmDjjd
	DVS+JEEG22SrnQx2l5/gHgGJdEX9fY3esitbhplmyZhkCIjlGeCbU0C+oyNs7CQ7LWlybPs6ED3
	y4cO3MSVH4IQaZaBybTSDEKNFM4Oq/Ul1BqDJ7S3S3ag9wDy9a3to4mHxGePTRLkyGpq5IbhF+I
	ctshIfq3mGMpyZqVkJZt1WTPt1deeL1szd+OMw20DNaRrlIrNNFqEfP1lG3BLk6l2bX45UT0Rje
	D5EF81alosfFd/vpMFBrHDsqlDPfum9DwEeNjUGFJYY0ihzpksA3IPgzMM8MklVy/qCMeFdqaFA
	9usS6JGZjk/hyM2kOdbhC3rdF6PrE8KjLjUBYFmazcbj9zn0dbJWuUEdobfbWiTkX52bAkchg=
X-Received: by 2002:a05:690c:62ca:b0:798:5951:f42b with SMTP id 00721157ae682-798dd74191bmr34449327b3.42.1772832298060;
        Fri, 06 Mar 2026 13:24:58 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-798dee4a717sm12259207b3.25.2026.03.06.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:24:57 -0800 (PST)
Date: Fri, 06 Mar 2026 16:24:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.5d7aebff68af@gmail.com>
In-Reply-To: <20260226201600.222044-7-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-7-alice.kernel@fastmail.im>
Subject: Re: [PATCH net-next v2 06/12] udp: Support gro_ipv4_max_size > 65536
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74CBC227EDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264925-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.970];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Currently, gro_max_size and gro_ipv4_max_size can be set to values
> bigger than 65536, and GRO will happily aggregate UDP to the configured
> size (for example, with TCP traffic in VXLAN tunnels). However,
> udp_gro_complete uses the 16-bit length field in the UDP header to store
> the length of the aggregated packet. It leads to the packet truncation
> later in __udp4_lib_rcv.
> 
> Fix this by storing 0 to the UDP length field and by restoring the real
> length from skb->len in __udp4_lib_rcv.
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  net/ipv4/udp.c         | 5 ++++-
>  net/ipv4/udp_offload.c | 4 ++--
>  net/ipv6/udp_offload.c | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 345ef93001fc..870b35107ede 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2690,7 +2690,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  {
>  	struct sock *sk = NULL;
>  	struct udphdr *uh;
> -	unsigned short ulen;
> +	unsigned int ulen;
>  	struct rtable *rt = skb_rtable(skb);
>  	__be32 saddr, daddr;
>  	struct net *net = dev_net(skb->dev);
> @@ -2714,6 +2714,9 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  		goto short_packet;
>  
>  	if (proto == IPPROTO_UDP) {
> +		if (!ulen)
> +			ulen = skb->len;
> +

For normal packets, ip_rcv_core truncates skbs to their IP length.

I don't immediate see the GRO layer taking care of this. Which is fine
if it can be done later, but not if these protocol fields are zeroed.

Should we validate that packets have no padding before we coalesce?

>  		/* UDP validates ulen. */
>  		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
>  			goto short_packet;

