Return-Path: <netdev+bounces-271665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL0BIEcaxGkPwgQAu9opvQ
	(envelope-from <netdev+bounces-271665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:24:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B13329BF6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC617311FA67
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34322401498;
	Wed, 25 Mar 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajY4ZCU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10233401499
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458871; cv=none; b=RjdfBuael5JGRmZ5JCoid8BeH1fcjg7QXafr9HPwwRgJgDibxCYlhzTa9bPuzVUOYAZpBEi20R6zNtlPzko+TOrG4gR7CNRzlAfXaHa2GAH39cKkkQG9O/9CFRz720n8I3D8fjF9tYGw2lf4I3L8P5S4hoaQDkqIr4itjlVx3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458871; c=relaxed/simple;
	bh=LLyymZIMfRKmZkgYEOo8ux+5+r6WmWR/Azjh6ed+MpE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rlMvtEzfmwtiVzxWVfH0gmyCDaiuWF51Lk8aRFgvTJxX2Jx/HLzfXcdAl09idUK4Be+nsoRC6R6aRlCS1Xh0R7LLr/LkxjkIrU6RSA0jT0S0EIOyT28dZDygSZkRsEpuBoSYEa5BDsnjJIei/MLSdl4f8BqeFV7UI3q5CEhN+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajY4ZCU9; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cd7de0e161so46028785a.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774458867; x=1775063667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B7BTZE0TnTJ3zAa3XvH4+aR30FTe1TSAo+Mvl5lfMwI=;
        b=ajY4ZCU9RI3lsIJFTcgD7UWaqf6sKUZkD0xK4w/Ie+4Jd47W9cOmRbGJ+by4j7iBTJ
         ZmpX286GEJ0IxZA5CxNq1Z4K0sgHOoQED3hmdE/2AFIQ1tFElJNFtjLKzU0ZaqzUS1ft
         EdkQ2kMSpu2z91e48Jqh0XDwxQKXxPM8S7Bx2KrP+7c7IrHJFabSrdDCE5XmAO99q4cY
         ICuAN9A9c5Dzvrk1KswyUCKXrAphuLN2Ioa3Do1ZNj2iFqeQlGqweBNXZEPkq0jElyFS
         qTu45PjtGshOoyuG01JY0qKloOKrJ+dCI5Lsj482y8N+auhcqyHpfULAsxO7B/tn6thO
         jAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774458867; x=1775063667;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7BTZE0TnTJ3zAa3XvH4+aR30FTe1TSAo+Mvl5lfMwI=;
        b=RxdK9IZyAihh/eNnRorAS8+CmHxfHwNhqQ4VNGvJc2E44vAWduAVKwYLGkz2gOoW8M
         YRvxM+9h08rWREwCctgAyQtpdjYpI5ddjeNQ+AstDn5JTlSHjoCYql5BlVS24Ac5PjXE
         IyBfP1gYyC2dzA93TK6oo/wGNbDzMJzwoGnFz2NfpBbSvNrwNJhXF6awv+vY4W/NYGvu
         DZXX7/ZVzs9FHe98Tn8YIgWHE4dUXIAnBmzGcvI1waMlu9bn8bbuzO2jADPvilhEk9Nr
         JWb0NAkfB2eeeKjZJ2dYQpO+8W4x07iI1okeba9EbsnLb0EEYXSoX4uLhbk+ITOlUVSS
         qqYA==
X-Forwarded-Encrypted: i=1; AJvYcCU2lzveWADcowowFjMBFJrvgy1HjFDXPbRZWUdOsmD3muE8W/whHrPSWScvVvVmsZOgxV0LC7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJYCR0Tn32nyHqCqVBARxSpbdJ03Uoi38lyo6O1GQzJo4RABQ
	SQD4CYQs/8Vs9C35FvzpOpEQijXz2tb96eJqfGfUrhUeH9A+LdRm7xaGxRu1PFMYBiZlEJyUK52
	2eYPCwEcT//yUmA==
X-Received: from qknty11.prod.google.com ([2002:a05:620a:3f4b:b0:8cd:7d21:ea78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44d4:b0:8cb:3a1d:79f5 with SMTP id af79cd13be357-8d000f53929mr613571485a.26.1774458866404;
 Wed, 25 Mar 2026 10:14:26 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:14:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325171425.3920372-1-edumazet@google.com>
Subject: [PATCH net] ip6_tunnel: validate ipv4 header in ip4ip6_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Oskar Kjos <oskar.kjos@hotmail.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,hotmail.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: A3B13329BF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Oskar Kjos reported the following problem.

ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhoff
at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
value. __ip_options_echo() then reads optlen from attacker-controlled
packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).

To fix this we could simply clear skb2->cb[].

In this patch I chose to validate the inner IPv4 header and
recompute options if any were included.

Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 tunnel.")
Reported-by: Oskar Kjos <oskar.kjos@hotmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/ip6_tunnel.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 4c29aa94e86eb9439458e4b23426bfda8b3b8922..1901348617f0a4f48358c1c8135068f4b861059f 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -561,6 +561,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	   u8 type, u8 code, int offset, __be32 info)
 {
 	__u32 rel_info = ntohl(info);
+	struct inet_skb_parm parm;
 	const struct iphdr *eiph;
 	struct sk_buff *skb2;
 	int err, rel_msg = 0;
@@ -606,6 +607,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	skb_pull(skb2, offset);
 	skb_reset_network_header(skb2);
 	eiph = ip_hdr(skb2);
+	if (eiph->version != 4 || eiph->ihl < 5)
+		goto out;
 
 	/* Try to guess incoming interface */
 	rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL, eiph->saddr,
@@ -617,6 +620,18 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	skb2->dev = rt->dst.dev;
 	ip_rt_put(rt);
 
+	memset(&parm, 0, sizeof(parm));
+	if (eiph->ihl > 5) {
+		if (!pskb_network_may_pull(skb2, eiph->ihl * 4))
+			goto out;
+		eiph = ip_hdr(skb2);
+		parm.opt.optlen = eiph->ihl * 4 - sizeof(struct iphdr);
+
+		err = __ip_options_compile(dev_net(skb->dev), &parm.opt, skb2, NULL);
+
+		if (err)
+			goto out;
+	}
 	/* route "incoming" packet */
 	if (rt->rt_flags & RTCF_LOCAL) {
 		rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
@@ -644,7 +659,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
 	}
 
-	icmp_send(skb2, rel_type, rel_code, htonl(rel_info));
+	__icmp_send(skb2, rel_type, rel_code, htonl(rel_info), &parm);
 
 out:
 	kfree_skb(skb2);
-- 
2.53.0.1018.g2bb0e51243-goog


