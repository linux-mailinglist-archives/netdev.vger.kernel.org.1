Return-Path: <netdev+bounces-265983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iADtG8Tyr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:30:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC807249669
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6815630C16BD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F53C3BF4;
	Tue, 10 Mar 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9DpMo3q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434543C06A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138375; cv=none; b=C8yimp9J6SayyHh07tWVNamnyn5CQO0Q8tloG+HCcBBd8FCHdQfgDazc+/x6ByfXck/l2b1J4hov0+KwRpPamMZI+SK/5L4e9gj/UiyOuZRZLYKS1eK13ajNBH+RxToI7bZTcG51tKa0G2b+cSUPJw8b+gPFGwpwZSMMz8yVJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138375; c=relaxed/simple;
	bh=GRDbizvGMpNke/p0WUm/41qICMJyjoWyNcAmFCgdDAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrxwrikwODyWS4xEa+UeCVHNFk2h7CaXsY45OWfM+merr4JcYLN2Mg/4NqzKzKOL5hB3CxUU2vzn3SVZBM3KGDlxlRTjJBlE+NbHXoBdU0dEO6OLQMfSE53HGtCoQEQKyJuBGj09xjluUKb5lvz6gORNTK6YM0hjks5kN3ymGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9DpMo3q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773138372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtVLt2ML1J1ffuBphSH/gYIYlcPTeexrkhKaWI0sd/g=;
	b=a9DpMo3qFYuxywGPaZsm1K6GTA3Uef9j6LqYu3e7ry+gfsalVz1nIgdD0thM0nMLatCY0R
	JGHe4Yd9MCFK6RX2IOXi3HNulPE2P86MROtXi9HNR98G/V1rdwDizlB+AcjDscNK/m9I1Y
	wZhUTX2xmFPIY+ZY/hWIKQz6bvdOl5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-8_4XBOMhNSWhs261kyTL4A-1; Tue,
 10 Mar 2026 06:26:09 -0400
X-MC-Unique: 8_4XBOMhNSWhs261kyTL4A-1
X-Mimecast-MFC-AGG-ID: 8_4XBOMhNSWhs261kyTL4A_1773138366
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D728E19560B7;
	Tue, 10 Mar 2026 10:26:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CCAF19560A6;
	Tue, 10 Mar 2026 10:25:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: kuniyu@google.com
Cc: willemb@google.com,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	jmorris@namei.org,
	casey@schaufler-ca.com,
	paul@paul-moore.com,
	kuni1840@gmail.com,
	fw@strlen.de,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [v2,net-next,07/15] udp: Remove partial csum code in RX.
Date: Tue, 10 Mar 2026 11:25:55 +0100
Message-ID: <20260310102555.147680-1-pabeni@redhat.com>
In-Reply-To: <20260305215013.2984628-8-kuniyu@google.com>
References: <20260305215013.2984628-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: DC807249669
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265983-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,hallyn.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,namei.org,schaufler-ca.com,paul-moore.com,gmail.com,strlen.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
udp: Remove partial csum code in RX.

This commit removes UDP-Lite specific partial checksum handling from UDP
receive paths, including removal of UDP_SKB_CB fields, simplification of
checksum initialization functions, and elimination of UDP-Lite guards.

Link: https://lore.kernel.org/netdev/20260305215013.2984628-8-kuniyu@google.com/

> diff --git a/include/net/udp.h b/include/net/udp.h
> --- a/include/net/udp.h
> +++ b/include/net/udp.h

[ ... ]

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

[ ... ]

> @@ -2703,14 +2647,15 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	if (ulen > skb->len)
>  		goto short_packet;
>
> -	if (proto == IPPROTO_UDP) {
> -		/* UDP validates ulen. */
> -		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
> +	/* UDP validates ulen. */
> +	if (ulen < sizeof(*uh)) {
> +		if (pskb_trim_rcsum(skb, ulen))
>  			goto short_packet;
> +
>  		uh = udp_hdr(skb);
>  	}
>
> -	if (udp4_csum_init(skb, uh, proto))
> +	if (udp4_csum_init(skb, uh))
>  		goto csum_error;
>

Does this refactoring introduce two bugs?

The old code checked both conditions with short-circuit OR:
  if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
      goto short_packet;

This correctly (1) rejected packets where ulen < 8, and (2) trimmed the
SKB to the declared UDP length when ulen < skb->len.

The new code changes the logic structure:
  if (ulen < sizeof(*uh)) {
      if (pskb_trim_rcsum(skb, ulen))
          goto short_packet;
      uh = udp_hdr(skb);
  }

First potential bug: When sizeof(*uh) <= ulen < skb->len, the entire block
is skipped. This means pskb_trim_rcsum() is never called, so the SKB
retains trailing data beyond the declared UDP length. Won't this cause
checksum calculations to include extraneous bytes, leading to valid packets
being incorrectly rejected?

This scenario occurs when UDP length < IP payload length, which can happen
with malformed or crafted packets.

Second potential bug: When ulen < sizeof(*uh), the old code would
immediately goto short_packet via the || short-circuit. The new code enters
the block and tries to trim the SKB to a sub-header-size length. If
pskb_trim_rcsum() succeeds, processing continues with skb->len <
sizeof(struct udphdr). Is this safe?

Looking at the IPv6 counterpart __udp6_lib_rcv(), it handles this
differently:

  if (ulen < sizeof(*uh))
      goto short_packet;

  if (ulen < skb->len) {
      if (pskb_trim_rcsum(skb, ulen))
          goto short_packet;
      saddr = &ipv6_hdr(skb)->saddr;
      daddr = &ipv6_hdr(skb)->daddr;
      uh = udp_hdr(skb);
  }

Should the IPv4 code follow the same pattern, or should it preserve the
original short-circuit logic:

  if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
      goto short_packet;
  uh = udp_hdr(skb);


