Return-Path: <netdev+bounces-296258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxEpLhOgJWo5JwIAu9opvQ
	(envelope-from <netdev+bounces-296258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:45:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA7650FF8
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:45:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bvIYkBYy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 385FE30073D3
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09D30E84E;
	Sun,  7 Jun 2026 16:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177922F7F12
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 16:45:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850705; cv=none; b=dfGFqbR3bgghPbU76oWz/brgZIM1FE6WVlNcPt+IA3K6GlPOKUOIG4hNXYbLrg8BnowuGno0Vt/5pmcGfI/Mwx2tg2lLWj0JD+TWBxP3z43FIis05z98NmKbTD3qhhHOstcYV0OqWdpicNKXbkXR2P/dMLAt+zGQlO9P8h02oO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850705; c=relaxed/simple;
	bh=kcY0A0ZCZkSIBoy0QINHGFg4/K+Rysr1zHdY+wr2gYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDAhJz6Nzw+iXm0zIgC1lwgYjoPsGIaZEJKg0Jt5Nt1Z5f753cC/B1kpXgPOSeHgEf9QnIJBc5xXnHdBx58jTg1Z0LJ8Oic1aERA+bL8wPw62GwsXb2py6Ap+VDWdHKNXXfDwR1OzEbU9YU9ZTatkX9Kyksp2VUpmqhD140exwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvIYkBYy; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so28356755ad.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780850702; x=1781455502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uu7Azb1TRudnvaVj8+H6IwLowhewkHpcM86CR0fcYo=;
        b=bvIYkBYyUDc5GFIE55mv4LvDio7I1p1cwi53yRGr3oK9iXc/hafLFIo2OECjbOtw88
         169c0HQDYRaDncmKikez8rZvsHZHpllxtupGJMHu+N4KIwFlASKqtFmM98BOJzMrnMOL
         1Wmu6LEc5oGWhq/j+nKzrQ7RoypFzbJ2ywlEp9W4qnBbe3cpkuxCH6dotUdY3BhlCGsn
         rmYyqiZKvOvBg8w4Z1TMjpQGjIGvDE7dFKtgSQtlpvAR2q3kcwxZx+9m47YblY72Vomn
         BRcOZGxJGdj7u2bPDo8paSzWf+WXtuWf/BJLKE5FeHxZIZUZG8OZ4opcqsVq840ic2mu
         20dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780850702; x=1781455502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Uu7Azb1TRudnvaVj8+H6IwLowhewkHpcM86CR0fcYo=;
        b=f7kvlw6LcO2yIzJtZgK5x5QlMKKOaDVVoivt1EO3fCtPDpM0VHQqMBTHMzrmmRhRxZ
         dWMvnX0MPD/bSTIQDYVFM+jiv2qpDw1JmQY+mEuebW/FSPQcp0LQyQTQyRgUD9T2ZhXy
         /F9xZ3vPlIvRenr90DRT6MeqTOxdSHw8fU2Iy4WS589Nl2wj+RK/LeZ38Xk7Owm6e26w
         8RVQae6620paUzsYHZ+DS8D2yzi9/IBJnofGTr8/qBvwpYuHcir8J/Vl/caGbWaBcLTT
         1iY0KbKY6CDDlsfF4nvXRu9X5ufdD5VBqhA00zEiG1n5YrRpQPcjgzTe35557SOuPh9F
         UoCg==
X-Forwarded-Encrypted: i=1; AFNElJ+EMVoK5PNKRuCnMx+UnGE836s0p8DyjaLFH524zmu7rT4QQ58Hg344BEw3vEES/nBylNxTfiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXF9AHOHDy1FBAaQrNpIZuEhcPycCrFOucXrHGgqdY5N8sipn
	mPh8/cHT+0yjakoI9u88EKEvuJIl2HFdgSEJH742X7WIA9qWJwMEXGB46dlIww==
X-Gm-Gg: Acq92OHa+/yYN0R86p65Cxaks0AynsQ860NB1Lm5YqinomX+s6DJfxhKv18WZDO46ey
	Y6o11QzXeUqs5ePft76Loq+EdD8b9p7rKQoP8L+Lsawv2KUhzmelOse76SDaiX8zYxvWnNXvcC2
	m8R/SybqNcjjJ5s5G5hVg+weRoFJ6Jwv+cpglJA1jKsLFIQwSp4OSh4uZT51siKAjcc5GcN84O8
	gbko5mFRv1zVNm6JG+VB5RJgeZiqpTzLa+GLktcP3NjNtNdw4nq/xd5ScyqzyUmdxDHGaG8gLzg
	7BXfIFbl0TR1LiQG/H/PAUdUBlWBqFK6gP2E4ARcJ/YRP+IZjSR6VMHAUHFqojUqIacs2U69m+e
	UgQ9hJA0l4KDsbTpxE1hAoIzx7mHqG+X45/DOMLSjKVFhUO/qCAQ3pkaRc2sMeHgHDY1pAevdzN
	W4MsJeK08ezCJBw1n69gedMTLgXr8ph9rrvTt5K6IR8BNZxuW+vz2pPFZIAYJqqstk6ijVIN/qG
	ogG+Z+K8BU6W+ea+Qpdu8FyL2MYMlWtcXOOQ/eBIIeUoA==
X-Received: by 2002:a17:903:28e:b0:2c2:5446:30e8 with SMTP id d9443c01a7336-2c254463524mr28709825ad.18.1780850702257;
        Sun, 07 Jun 2026 09:45:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9f358sm152466765ad.30.2026.06.07.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:45:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org (open list:NETFILTER),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] netfilter: synproxy: fix unaligned access to TCP timestamp option
Date: Sun,  7 Jun 2026 09:44:47 -0700
Message-ID: <20260607164447.39700-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-296258-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EDA7650FF8

synproxy_tstamp_adjust() reads and writes the TSval and TSecr fields of
the TCP Timestamp option via direct __be32 pointer dereferences. These
fields are at byte offsets 2 and 6 within the option, which are only
2-byte aligned — not 4-byte aligned for __be32 access.

Replace with get_unaligned_be32() / put_unaligned_be32() to safely
handle the unaligned access on strict-alignment architectures.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 net/netfilter/nf_synproxy_core.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index ed00114f65f3..0a038b9b5169 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -191,7 +191,7 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 		       const struct nf_conn_synproxy *synproxy)
 {
 	unsigned int optoff, optend;
-	__be32 *ptr, old;
+	__be32 old;
 
 	if (synproxy->tsoff == 0)
 		return 1;
@@ -221,18 +221,22 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 			if (op[0] == TCPOPT_TIMESTAMP &&
 			    op[1] == TCPOLEN_TIMESTAMP) {
 				if (CTINFO2DIR(ctinfo) == IP_CT_DIR_REPLY) {
-					ptr = (__be32 *)&op[2];
-					old = *ptr;
-					*ptr = htonl(ntohl(*ptr) -
-						     synproxy->tsoff);
+					u32 tsval = get_unaligned_be32(&op[2]);
+					u32 new_tsval = tsval - synproxy->tsoff;
+
+					old = cpu_to_be32(tsval);
+					put_unaligned_be32(new_tsval, &op[2]);
+					inet_proto_csum_replace4(&th->check, skb,
+								 old, cpu_to_be32(new_tsval), false);
 				} else {
-					ptr = (__be32 *)&op[6];
-					old = *ptr;
-					*ptr = htonl(ntohl(*ptr) +
-						     synproxy->tsoff);
+					u32 tsecr = get_unaligned_be32(&op[6]);
+					u32 new_tsecr = tsecr + synproxy->tsoff;
+
+					old = cpu_to_be32(tsecr);
+					put_unaligned_be32(new_tsecr, &op[6]);
+					inet_proto_csum_replace4(&th->check, skb,
+								 old, cpu_to_be32(new_tsecr), false);
 				}
-				inet_proto_csum_replace4(&th->check, skb,
-							 old, *ptr, false);
 				return 1;
 			}
 			optoff += op[1];
-- 
2.54.0


