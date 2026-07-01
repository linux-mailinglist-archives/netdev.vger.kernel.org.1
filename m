Return-Path: <netdev+bounces-303573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bVrjGtPnRGqT2woAu9opvQ
	(envelope-from <netdev+bounces-303573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:11:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA96EBF12
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:11:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VLnGmvdY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303573-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B56E3001029
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18F3F44FC;
	Wed,  1 Jul 2026 10:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A443EAC74
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900624; cv=none; b=s8lcMZ0ELLcK0M2yRX6Lv46tBiRVRLiJXIWrj4D1Di8IbAeqTtQbH3EOhmX6rVeoyC9k77pKFT/VpMsSMfsr3QEhP52rqmB5ImT8g7nRIxSaJKnwJcPbcp3468kbWedLm4sGjSEytfBZd72OWXzrMaIQTSsLhZ8EotjT4N3tIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900624; c=relaxed/simple;
	bh=jmfvhgrtNdU3m6gyAhjUPNDiaPo9cS3sSJZSuYijSs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFGjp97art7Zu1caWNX9ZQ6hqBmrBtORo5ffCbOPqYeeI85yCrW8w29me52C+U3nlxWD+FDQA8wItdILhg0oKyxZfy3vUG1+I8KQI677Gi/cT0G0gAXls+GEul/kk8jl5EQVXHQAhYmmK7WFXJfQzuRdl6mvI01mGrxP3psiMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLnGmvdY; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37defb2f231so209763a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782900622; x=1783505422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGOpzjLwG2qHNqnpr9AH3FOmYtQjFdDLV2ovZbwXKfA=;
        b=VLnGmvdY198P6jHJUGoQJ6UdHfJYYYnLBt1fjR6fM7rHc+t0flxxszs0kJ8I4/q8lP
         P6nRGq/HcbdHD0l04gDtyU7sLifMcnUWY585ONlowNmyshqjRa0Sb+yEHhPeCQKTkEnY
         hDIBC1N0zihbE3zNHJrh0m2Vc91Z4Pg8llO1IPJrXu85ryRRuLQsBkJhmWn0+IeN0Rcx
         Cp9kU4OTQBPWT2JgxoHFdHb/9qMSSl/gokBJVR4KzKXh+jbumZl2O8wIf7AX8560mg71
         1cxvpqj/YExQtFGYvK+oAvz2c7N7LM5323aF5+/dFioylcX9O5dZzsmdXZyzCVaeZCIA
         iLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900622; x=1783505422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGOpzjLwG2qHNqnpr9AH3FOmYtQjFdDLV2ovZbwXKfA=;
        b=F9be706DuvsIvnU44Mci2If35cNT5v+dzn7T/LO8lnQXbQN6Sl8BfOc5+KiXfeun5u
         DVRBkIin+T0lTv2p7QbkIj1op+DAK3y0pB9t57VKMoQF4Dpxso7bOwPnXVV09efbNpyn
         1Or+IsNW8poD0EhTdOfrpeFtJQKaWtvoTQUcH+N9AtAkuUd6yj6wfokWxML6JBunBLyH
         ar1cV7yBPXn54vw72UgBGyg730Z17zdcu34AN8wklVwynMGxSqCiXiJahumbJ1/plHPo
         DV2QDZyOo+LVwysDuE37k9I/KVIGToXmKcnRiaMRtuLWQR+Y9Op3AIU8/H99PsQlY9rL
         sbgw==
X-Forwarded-Encrypted: i=1; AHgh+RrjtvfIgZPv9Hx6UvVnWoHw9l8Ve034M04ovooFloKb07MkhIxY5Kkz/22PegPPlyZMPooCrUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/IFHezuH5JLw6XieI+G+RgTC/YI4nsuDYBwO8XkJuOmcmAfP
	UnY5bRH5bF3yNUCv0wrXvgIw9s5axAL9MpbxHpWcaoAGCdVQkNutngwn
X-Gm-Gg: AfdE7cmHQRKwzj154cTw6uq+tJ/yVSbINplfUzg1jG9Kf6y71Sy9f1kVIIUuoi3+0WR
	+OD6nfOTBKRBAH/c+umj8QR72caobNqDoeD3xttRv6ZaKSxyXU7LkrU4tIMt9qxREkGDzqohW5O
	2KxPRAVm5fqc3VsNzKk+NZ2FMagD80ZmJzHVNgqXYPbg37CCowyt/f+LABZ6JKpFybs0lrj6eb3
	/GTjGWHPA3FNHJu/H/HWvgWQBP0Psapex+MzTu5NH6LhCuQqd+lhc2ynDEs6Yj+CkhRUNE/gKY9
	fKqzHGtj+6G+hsteCRnV07IIpns5UMS1lFpUmE3721Y/ite8HlCN/eLLGWSNyEhssRDarOyn3TM
	+YMd7keUJOLJiAqP/XHIWGLFL/VYeF845ddAk9OwU634hc8k0MTe4bW0QnfkH7yHM7Tocqcgaps
	DHY7Y/WXi2355ce8wrbLAd
X-Received: by 2002:a17:90a:d44b:b0:37c:7090:821b with SMTP id 98e67ed59e1d1-380aa0f436amr880037a91.10.1782900622075;
        Wed, 01 Jul 2026 03:10:22 -0700 (PDT)
Received: from c79ofce.localdomain ([204.3.140.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d6666esm1559442a91.6.2026.07.01.03.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:10:21 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH nf v2] netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop
Date: Wed,  1 Jul 2026 18:09:30 +0800
Message-Id: <20260701100930.2855-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,netfilter.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303573-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:running910@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0DA96EBF12

The ah, hbh and rt matches check that the fixed extension header is
present, then use the header length field to derive the advertised
extension header length for matching.

For the ah match, add the missing advertised-length check. For hbh
and rt, update the existing advertised-length checks. In all three
cases, set hotdrop to true before returning false when the advertised
extension header length exceeds the available skb data.

Returning false treats the packet as a rule mismatch. Set hotdrop to
true and drop malformed packets so they cannot bypass rules intended
to drop packets with these IPv6 extension headers.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

Changes in v2:
- Set hotdrop to true before returning false for malformed packets.
- Apply the same handling to hbh and rt matches.

v1: https://lore.kernel.org/netfilter-devel/20260618125848.93550-1-running910@gmail.com/T/

---
 net/ipv6/netfilter/ip6t_ah.c  | 5 +++++
 net/ipv6/netfilter/ip6t_hbh.c | 1 +
 net/ipv6/netfilter/ip6t_rt.c  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/net/ipv6/netfilter/ip6t_ah.c b/net/ipv6/netfilter/ip6t_ah.c
index 70da2f2ce064..1258783ed876 100644
--- a/net/ipv6/netfilter/ip6t_ah.c
+++ b/net/ipv6/netfilter/ip6t_ah.c
@@ -56,6 +56,11 @@ static bool ah_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	}
 
 	hdrlen = ipv6_authlen(ah);
+	if (skb->len - ptr < hdrlen) {
+		/* Packet smaller than its length field */
+		par->hotdrop = true;
+		return false;
+	}
 
 	pr_debug("IPv6 AH LEN %u %u ", hdrlen, ah->hdrlen);
 	pr_debug("RES %04X ", ah->reserved);
diff --git a/net/ipv6/netfilter/ip6t_hbh.c b/net/ipv6/netfilter/ip6t_hbh.c
index 450dd53846a2..6d1a5d2026a6 100644
--- a/net/ipv6/netfilter/ip6t_hbh.c
+++ b/net/ipv6/netfilter/ip6t_hbh.c
@@ -75,6 +75,7 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	hdrlen = ipv6_optlen(oh);
 	if (skb->len - ptr < hdrlen) {
 		/* Packet smaller than it's length field */
+		par->hotdrop = true;
 		return false;
 	}
 
diff --git a/net/ipv6/netfilter/ip6t_rt.c b/net/ipv6/netfilter/ip6t_rt.c
index 5561bd9cea81..e28caca759f3 100644
--- a/net/ipv6/netfilter/ip6t_rt.c
+++ b/net/ipv6/netfilter/ip6t_rt.c
@@ -57,6 +57,7 @@ static bool rt_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	hdrlen = ipv6_optlen(rh);
 	if (skb->len - ptr < hdrlen) {
 		/* Pcket smaller than its length field */
+		par->hotdrop = true;
 		return false;
 	}
 
-- 
2.34.1


