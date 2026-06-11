Return-Path: <netdev+bounces-298238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lBkyAlXoKmrDzAMAu9opvQ
	(envelope-from <netdev+bounces-298238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65853673BEA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:54:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JSC3wNNW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298238-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298238-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7086C3027327
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A240BCB3;
	Thu, 11 Jun 2026 16:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8CE377574
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:52:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196770; cv=none; b=TRIMhtMYpUm+ufis07Ikt9ffEDH1iLk/xP32pTUchSFUMG/RRPbmYy4mPY/17VB1PYVH1+SCVl5DMM+lQXYr3fHpZ1rAWRViK8c0aPCaiwTrKxBQyUZ8nRNVeUvvrb9Cr+9PFtuvATN7hAV7qxo70NReA5guyOiT+E5hywjaei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196770; c=relaxed/simple;
	bh=PljbtlMV0PxgV8WmxnGh8eH+H2eTTVSdELrNKYqe7uc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZdVE7x/ARCqa0vz/uTKakyks4Er2i860jzZBUPZ0VT1R8AEB3XF+4MgxFuSYwbL93drxGZhFMRPlOwbqa+iQeSAoiKHGmnJFBw/M5JdRDDNst/fU45tVDmjMzp5IrzageS3oaqLF3dJWr7H5CtUVPzggbAIL7bVGsrH7E2Qj/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSC3wNNW; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517615db531so209657131cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781196768; x=1781801568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7+SYFPrX06dNXHN4QC5CuvRliXsRDhq8JTa5eT8fXQ=;
        b=JSC3wNNWvr64vq/lk/wNqRvkxVACghZx6evIGdn/oBy0C88w1cOoHP79TF2EjNI3+d
         iNZgyyFJx22ww7F+7QRcd9eJvs6TKMyHYImudK4xgfADAyhgJmTWgFcsZshMtfOHIjTS
         aVIxHmJFP459TdjhgD/q7sLg3aMTY8DX85lgBW6vUkO7E4cnX0BsEda9Y4DZIIBvJaCd
         i+39Xz4lYLH+xq4LeWfXBB13UtxxRxNkrhWlasasMdQlrty+ZbqdB0Y0kXXrh7I7+j1Z
         EANeZxiM3yzz0Kq7wgBfOt0RtY8ofi9+yATzNQ+DtIFMqiYqETjJ3Cwm+U92uvlLoPnv
         5QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196768; x=1781801568;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7+SYFPrX06dNXHN4QC5CuvRliXsRDhq8JTa5eT8fXQ=;
        b=GWhUvA43h53MNNElbIGQ6d2WDUp7UkOUzfTfLgRt3Ib5oTqyjYsm0Ri2ospTXRJnx2
         /ZRv0gYF8FKIMNzb07cOwlKBI4Fb5mfYgsWN3en4/6Com9K/9HoYFQLLtyJUmY3SFSf+
         Jf5WrV7BFP66R5JmCu0hZ1OspnGi8F/MQICCSSWvYjqWU/ua0aZoedBhiVDoH7vawedn
         5KkO6LI6ZcJpzpdKdqTzTtoXVlmV5OFe3prEgAX8EHsNtpSBZhnVRTbKwcEWt/gaAjZz
         eAZRUIMpNUbtqFg8hifOy0/K7OKI9fIB6A+JBTduR5sdKD9PfCyXdi6RWyH41GprF7/J
         ON1A==
X-Forwarded-Encrypted: i=1; AFNElJ+NvrkBmQXRE/BYnhnHtZEJKWApuGkFIzBG9UyqgtAfqFiph/2J8RmbaoNEgIM7G3QWYED1Cjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfMAtbE4JlShVMehOokR+aOdiAJ3DD47XRb+xvFN0vLFaOhFU
	N1r2MyQptAqyXL77cAJqC8NJvL5nqduFURBMhhLcKeI1EUBstif9WK1XFOWvvTu/O8S5dLygH4G
	qPe1RxyGD/3Yxwg==
X-Received: from qvzm6.prod.google.com ([2002:ad4:4a06:0:b0:8cc:e8f7:c262])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6103:b0:517:7188:c47a with SMTP id d75a77b69052e-517edd3738cmr58751451cf.2.1781196768272;
 Thu, 11 Jun 2026 09:52:48 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:52:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611165247.2710257-1-edumazet@google.com>
Subject: [PATCH net] ip_tunnel: annotate data-races around t->err_count and t->err_time
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65853673BEA

ip_tunnel_xmit() runs locklessly (dev->lltx == true).

ipgre_err() and ipip_err() also run locklessly.

We need to add READ_ONCE() and WRITE_ONCE() annotations
around t->err_count and t->err_time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c    |  8 ++++----
 net/ipv4/ip_tunnel.c | 13 ++++++++-----
 net/ipv4/ipip.c      |  8 ++++----
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851d55bb67f5a7cf3f005ded1ed2655..208dd48012d963b9df0eddbdda73dd319930e48f 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -207,11 +207,11 @@ static int ipgre_err(struct sk_buff *skb, u32 info,
 	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
 		return 0;
 
-	if (time_before(jiffies, t->err_time + IPTUNNEL_ERR_TIMEO))
-		t->err_count++;
+	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
+		WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
 	else
-		t->err_count = 1;
-	t->err_time = jiffies;
+		WRITE_ONCE(t->err_count, 1);
+	WRITE_ONCE(t->err_time, jiffies);
 
 	return 0;
 }
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c6d83ef18cdea3ca25aed582839f0..9d114bd575f928b0ab46ef3007e456692d82b497 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -679,6 +679,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	struct flowi4 fl4;
 	bool md = false;
 	bool connected;
+	int err_count;
 	u8 tos, ttl;
 	__be32 dst;
 	__be16 df;
@@ -807,14 +808,16 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error;
 	}
 
-	if (tunnel->err_count > 0) {
+	err_count = READ_ONCE(tunnel->err_count);
+	if (err_count > 0) {
 		if (time_before(jiffies,
-				tunnel->err_time + IPTUNNEL_ERR_TIMEO)) {
-			tunnel->err_count--;
+				READ_ONCE(tunnel->err_time) + IPTUNNEL_ERR_TIMEO)) {
+			WRITE_ONCE(tunnel->err_count, err_count - 1);
 
 			dst_link_failure(skb);
-		} else
-			tunnel->err_count = 0;
+		} else {
+			WRITE_ONCE(tunnel->err_count, 0);
+		}
 	}
 
 	tos = ip_tunnel_ecn_encap(tos, inner_iph, skb);
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e9f4ba4bff207a5bd2c5d5670215a..4f89a03e0b49b8fb328077a68fb72d7e4f5768ca 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -190,11 +190,11 @@ static int ipip_err(struct sk_buff *skb, u32 info)
 	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
 		goto out;
 
-	if (time_before(jiffies, t->err_time + IPTUNNEL_ERR_TIMEO))
-		t->err_count++;
+	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
+		WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
 	else
-		t->err_count = 1;
-	t->err_time = jiffies;
+		WRITE_ONCE(t->err_count, 1);
+	WRITE_ONCE(t->err_time, jiffies);
 
 out:
 	return err;
-- 
2.54.0.1136.gdb2ca164c4-goog


