Return-Path: <netdev+bounces-278993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKSSMfu74GlXlQAAu9opvQ
	(envelope-from <netdev+bounces-278993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:37:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E62540CFEF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C22301C5B2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D23A5445;
	Thu, 16 Apr 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgxpBpcj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB77386564
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335710; cv=none; b=joIuIr7k9pIxir41F79DA4st735382OMxukk4Na2ucmwvfA/fiB7V3bJHMGFbpN2psIzuoA3S//XBtEvh2z5tyY9Kd2dtmQBAz4a90NkUBPw5jjV3YfDJKLt4DkK4QzodkhofDO8JB+cpQVmT0uJ5aNQN45xVYACWg+wiLwjSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335710; c=relaxed/simple;
	bh=EXNMw0HSZecs5aR97l8OuW+waOl4Uk2lUn8fu7c6IQw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FpXol5WJg95ott7quMwEFs/EqdzrgacvKvQlz7mdPvMt9GA+HsCV/b/oSJZqrD8S63PNbjDX2qNzqpdRPqquah3XkVE7F1BsXF7FWSk+YlcUVfdL+4PBFM4ag3fLnPX3i2UJqDw+oijjcEIRIM7mXVOt/4qsFwAU+utjUPzwEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgxpBpcj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7986c067508so217882897b3.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776335708; x=1776940508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4bselSbtWCFVwv2HV9rtGtzcog/A2R/lACnbLxTSYp0=;
        b=MgxpBpcjlH4XJyXjnHbSo2AjPrPqGYOqDJis693vCkDyCj3yBi+qMXtQ4GqSHw+rkG
         3NWFm0xkjnlngFraTRLZp6r2BIP4O/lQJH7iHQyDJ8LBo8K4zBxKZhWGXKmUu5U+VWOk
         ERb8Qy7yA79i5P6Md4d8SxErQyqveXt2X0j9qibuXvfXhaNcgdt1QlD7/lJXSqUOr7ty
         uKt3h7BLM6qCgtJlYsUWIEPV7iqmJw99vFeJKruTKl4jgZLE9UuwoKwvbAvbE2n7lqgl
         ZHL7/kmAjBpfkb4Ig+83adyfZXUJuQ7mNX+UhtsuuTLrBbVHsRvTOyHOdxzddljXjTzJ
         hz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335708; x=1776940508;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bselSbtWCFVwv2HV9rtGtzcog/A2R/lACnbLxTSYp0=;
        b=dzO8zNi8f6RxI1xHYMS5P4alM2lgMdnhn0jZ1U1/y/5ZWDBzIoVRK1/lGGIVqJh85M
         pV8RoGHg2PTmP5anHjpdAcn11BNVebe2PI113R9CJZ2tJAD/tJe8YbIlfl76CCSVGWdA
         3YxOqAZfTJhHvZFGbU0BgzQPnsYm8NmTxj5c44l0mfqWq5cA6zxqUOpOrkkWCKWsDeob
         C5L2LTk7Dy4WT+WOxpfw1WrqHP1+z5kD+Hs1uJ+43pcTlqmj8WVANSnbx8HqxV6e2w4P
         vFPLs/L1NHOpz+VMja5y4MaUQhHXHq204sT8A1fEWqntXW20boqxL90cUoXjidDC4Oq4
         +PIg==
X-Forwarded-Encrypted: i=1; AFNElJ+LOlHdufPDNqNDIMRzgLzhW0uimEdo66Yk72bFO/TPJSF9Jd+q6Ph9SAqUiaxeMpWLpHR/EyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfv0JMXVkwwPo6GoBJZkKlJcZvcNb8RWOhcJDd+pDchE9LrEib
	c8kEPdNPsJKbiR3KwpeYn8g6x0e6Cp3C2X2PlRQmddca0YsaZ2buFI7lSdgj/QHWL1+qQ9mo2C8
	aYiNJMDGZI8w3mg==
X-Received: from yxac24.prod.google.com ([2002:a05:690e:15d8:b0:651:be12:1fda])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1448:b0:64e:e380:c83f with SMTP id 956f58d0204a3-65198b9712cmr22086197d50.46.1776335707971;
 Thu, 16 Apr 2026 03:35:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:35:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416103505.2380753-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix possible UAF in icmpv6_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278993-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E62540CFEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Caching saddr and daddr before pskb_pull() is problematic
since skb->head can change.

Remove these temporary variables:

- We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
  when net_dbg_ratelimited() is called in the slow path.

- Avoid potential future misuse after pskb_pull() call.

Fixes: 4b3418fba0fe ("ipv6: icmp: include addresses in debug messages")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/icmp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 799d9e9ac45d11f7b460da7d8a7aeeaf0eb50f2f..efb23807a0262e8d68aa1afc8d96ee94eab89d50 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1104,7 +1104,6 @@ static int icmpv6_rcv(struct sk_buff *skb)
 	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
-	const struct in6_addr *saddr, *daddr;
 	struct icmp6hdr *hdr;
 	u8 type;
 
@@ -1135,12 +1134,10 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INMSGS);
 
-	saddr = &ipv6_hdr(skb)->saddr;
-	daddr = &ipv6_hdr(skb)->daddr;
-
 	if (skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo)) {
 		net_dbg_ratelimited("ICMPv6 checksum failed [%pI6c > %pI6c]\n",
-				    saddr, daddr);
+				    &ipv6_hdr(skb)->saddr,
+				    &ipv6_hdr(skb)->daddr);
 		goto csum_error;
 	}
 
@@ -1220,7 +1217,8 @@ static int icmpv6_rcv(struct sk_buff *skb)
 			break;
 
 		net_dbg_ratelimited("icmpv6: msg of unknown type [%pI6c > %pI6c]\n",
-				    saddr, daddr);
+				    &ipv6_hdr(skb)->saddr,
+				    &ipv6_hdr(skb)->daddr);
 
 		/*
 		 * error of unknown type.
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


