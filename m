Return-Path: <netdev+bounces-287593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBBJMQZ4BGqpKAIAu9opvQ
	(envelope-from <netdev+bounces-287593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB81533A49
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09E15308C89F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235AF426689;
	Wed, 13 May 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MozZsnhO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC46423141
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677184; cv=none; b=gVEFdmUwv5Ga5SDounfjOpldm3jiylt4pw3iw0+hR/SqA7vXdyFWo562N2MIdSCwqOblW8+4MsUtNmXT0RQVs3xBbciX7l1J7CnVeijzOXQ8AHLR+S133bN6DNFOGcrgPe4fLphOFqOvXL22COd8Di7wjdei/uZVGVDF9sjFXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677184; c=relaxed/simple;
	bh=mCCve/XWxpjDAvshnWGhRzGeWPn5vE5uTNjG4Th9yoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dkq5/h0zE/W472K+u2HUVPuqkbsxwvHM88ieWUDNHe05wKetYP8Lu08OKR8kOQnM80bzTce7MOn9q/d70NAdm7BhUbW5NWRBw4lnzB7G678UqL1589xUXT5llurOdbLHrczeelrRFuQGVvI/V6IGDyA3O0U1kTFFFg9+UgH+rB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MozZsnhO; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-404254ffe8aso5441513fac.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677182; x=1779281982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+AwLwaO4ONCHasEnZUf3l3ifse+yp4aIXtzs6brKIM=;
        b=MozZsnhOCEb+YijyIYuPE99HZ13njpivCvQM6LvInjil8AEaTM8XvLgY7u7BBccK9y
         0pYF/QnfHLsn3JuL2SaGrMnRZH4CHDTF6AOSOAe0bqVV6omaMAI1almMy4EtzZJvn1S1
         qEduinkS7SrVjVNE54JCzQ9dA/RBt7ub5v0FI+8k/uOPmj1PyeeAjORiY1HQnpLlOWpr
         osQfz7Xt9hiMnBeDMoeNBjjDbqqZ5dX3QS3NwY1ehdanW1PeQZagIBlKF3uPUYpPkKhp
         0fpxD63ZBoQ+CEkbkmt1Pb2ZX4+RnJCshiiB1MWzX+m3Re8xw1MEgRrURWXYXfz6CyA7
         LhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677182; x=1779281982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U+AwLwaO4ONCHasEnZUf3l3ifse+yp4aIXtzs6brKIM=;
        b=pia826LVWabM/3lJ6GActb3DxQvEPU/9vxd9jbKfsH+7qjbeNhGQnd2W9IdZtNVX8L
         J8LkKHUFeX4rk/E6syY850fnunT17LOnGEfgTZAHsOCtgxP35pIVxjjRj9JDq+Dvh6P8
         A/W0FNFoBUa1N7Bnl3i+WaIW5SzwSxEJsNB1jhkGeDBzaoi9YFc8dERnn8WHNp1GBp3i
         qsuPrJ4KY3SdJ7ePq/wlsuw7e9M2QKmImvpXvm902b2gOfu0wGfg/ran9QyhW+IrsEoU
         rCqvhevMsw9yaAh0JwW9kIFVaiDLUGoZo9eZbIkujjoY2sSvLP+rtoGmcfsBbNBlHXMP
         4xxA==
X-Gm-Message-State: AOJu0YwvEYJuYVQ4iiyFY8a01WJTpdOoF0GKJCZIBXzQcA7twrGUvRGs
	0En+/LKBWlF0uJGRL230uLo6RCdvkv3DXCYHzVGsN9g40cu6Sf438TB5
X-Gm-Gg: Acq92OGyP4DnG1eSMnY03OLxgYWLqb4lersa/cUSZyFjAzB2GioD76KDWIzTCqb6ayZ
	dByZXLbYBQmWJiwiyAzQ7Hp1hp9cMj/nevIt0+QLQsQ/mbGh1qQ07b/mv3C/LV0f5HpXesIref2
	dfE1Nn0jMYJt81KEjRej86BLaRxrYT3CngonTY0tbj00EJq/5/ioS2YztSQ7TdhlY3ivDsDSU4l
	Iag9WEJ1a2458C5jazuZtOe+Pp7nC5BRVRqAM4fGfjts3IutDWBCsekOsP3N0eWZcvLKWD8gVh9
	cfmwvBSFNmrSWovO8o3ZwEn79wjdOu8/W2H+MdDV1aqFIelvIarasnsC8WB2VYORgiTJzXY1BEw
	3EQUjQ0PKYcCt5UmXd7zDbohtFOsFYMitSaQYZF1L0bO4GFnTf1rOT2zQzXDIjO7USy3AK7Lglq
	A+euhOoj4rEhwrNBxkqKWlWrHabpqoZg==
X-Received: by 2002:a05:6870:71c1:b0:417:43c8:a58e with SMTP id 586e51a60fabf-439ca86fe06mr1686595fac.3.1778677181707;
        Wed, 13 May 2026 05:59:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439a9054cd3sm4042051fac.7.2026.05.13.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:59:41 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 13 May 2026 05:59:37 -0700
Subject: [PATCH net 2/3] netdevsim: psp: update rx stats on the peer
 netdevsim
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fix-psp-stats-v1-2-cdb3174f252f@gmail.com>
References: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
In-Reply-To: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: BBB81533A49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

nsim_do_psp() handles both tx and rx psp processing in the sending
device's nsim_start_xmit() path. The existing code has a logical bug,
where we erroneously increment rx_bytes and rx_packets on the sending
devices stats, instead of the peer device.

Additionally, compute psp_len after psp_dev_encapsulate() and before
psp_dev_rcv(), which modifies the header region of the skb. The
existing calculation was actually correct, because psp_dev_rcv()
leaves skb_inner_transport_header pointing at the tcp header, but this
is fragile and confusing as there is no actual inner transport header
after psp_dev_rcv has removed udp encapsulation.

Fixes: 178f0763c5f3 ("netdevsim: implement psp device stats")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/psp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 92a2ed770a36..5ff91da24539 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -22,6 +22,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	struct psp_dev *peer_psd;
 	struct psp_assoc *pas;
 	struct net *net;
+	int psp_len;
 	void **ptr;
 
 	rcu_read_lock();
@@ -48,6 +49,12 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		goto out_unlock;
 	}
 
+	psp_len = skb->len - skb_inner_transport_offset(skb);
+	u64_stats_update_begin(&ns->psp.syncp);
+	u64_stats_inc(&ns->psp.tx_packets);
+	u64_stats_add(&ns->psp.tx_bytes, psp_len);
+	u64_stats_update_end(&ns->psp.syncp);
+
 	/* Now pretend we just received this frame */
 	peer_psd = rcu_dereference(peer_ns->psp.dev);
 	if (peer_psd && peer_psd->config.versions & (1 << pas->version)) {
@@ -72,14 +79,10 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
 
-		u64_stats_update_begin(&ns->psp.syncp);
-		u64_stats_inc(&ns->psp.tx_packets);
-		u64_stats_inc(&ns->psp.rx_packets);
-		u64_stats_add(&ns->psp.tx_bytes,
-			      skb->len - skb_inner_transport_offset(skb));
-		u64_stats_add(&ns->psp.rx_bytes,
-			      skb->len - skb_inner_transport_offset(skb));
-		u64_stats_update_end(&ns->psp.syncp);
+		u64_stats_update_begin(&peer_ns->psp.syncp);
+		u64_stats_inc(&peer_ns->psp.rx_packets);
+		u64_stats_add(&peer_ns->psp.rx_bytes, psp_len);
+		u64_stats_update_end(&peer_ns->psp.syncp);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;

-- 
2.52.0


