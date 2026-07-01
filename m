Return-Path: <netdev+bounces-303627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ex9gIqkLRWoV5woAu9opvQ
	(envelope-from <netdev+bounces-303627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D46486ED7FE
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Qo9yoAV+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303627-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC0A3302BFC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F249253D;
	Wed,  1 Jul 2026 12:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D798481FCA
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:23:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908613; cv=none; b=RrKW+PF7beN5/c5LqWWuXu+Llsc7mWThNhEHviqAXS2Mw7uLvnm1kjJDHCzXw7W+W8O4qm33WouuctZDoPMgI36uNOUABaa84y3EUckn0TV8JXDRJd2f79U+a7WP5/Z9eic+vQ09qLTNGZNEvsPptYr3NX9GdFsEo5t4JM1br3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908613; c=relaxed/simple;
	bh=gDSZ4JvPHsTCArlEa6WDtlmVYfchqp11YjSecea5bJA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ffs4H4RDjkG11KxGA8PocnugCCVVtBYiMC9X33SiTKM92isl/TgzUQ/+Tmt+cvN0Px6dUhcZ0JqC9ndsaGiVZhM7zrEu1SFlsXG0DH4GOHTN1+XbQ7gWKitPZPL9ACCRfmNUJi+VoR8dBcOhBrGIBc37liotTiexWYXOjoRGrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qo9yoAV+; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f08f19552aso8114936d6.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782908612; x=1783513412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OWIro5Mkasq3Tgryjf3Cec/0jIRwCqWOpgFwh6SPwZw=;
        b=Qo9yoAV+nTgjWBPsahvSz3hOQGNJhp5uxtLCTp3sp6UB0PBm9iyTAUW6bL0sw+kHLw
         0+AfLbvzgg/h+4GzFiPkI/5eu0OoZmHpCR4/q7KN8rKOm47ISRz+FMmgkbxawobGJ6jN
         Q+RDTlS4gmJvMK9CJCgAS9LeOt4vmCvVbHqwbU4W8CMDllRioM7CPgvUcikMdTttP89B
         IR8cb4MrTxeF0LdaaiokUB70lCwYWpcHUTvFxPP1BfMsjZw3TLtg5y1+vVUl04pFgsRl
         QF4Cf78zjaDmnXZyai8cD6J+Tmd8oW49TwOX1n0k5LMyVHMkR9pau7CYYeMRAIS683IU
         v8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908612; x=1783513412;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWIro5Mkasq3Tgryjf3Cec/0jIRwCqWOpgFwh6SPwZw=;
        b=eqzaFq6LTF9PBAm07H88DLLt62H4oM6jAS2OaLPS5OyXDXQB1n4R76uWIyXgJ47t8o
         FF/WREFmS+BqQvyiRYn2BiOhzCOUYEeKXRbXRIs3ujHfzdXHPofvWkoF7JdEvbhfcoAi
         D/JBLYZCiZRvZCVUexXvl+QOTkQfzgXb/AUUYS240Gfn8PJhBhb9c/+vPXgZwyPtUrYg
         VxIHkCeIi+Vk//QJOoEgXIee4uPQcmn4m9mRrGqoWHiMDz69LJ0vW/NbAdYOqaW+FGJM
         hCLUAmDApv9daozY2x7UNAmldNNfml4OpiTxy7hJsJU5MFSEphEXh/k7Itt3JXihr3fL
         qDIw==
X-Forwarded-Encrypted: i=1; AHgh+RpVqJts97930XlTZ4t+A0gnmgX54O+nvzLTRfUoGmL/Taq+DXNgQZD2AuB7q8JZjamX0p9I2sY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfe/suUfhoUi7aBcgisqz03PZJOOLSBPzCZjSCKJUsCwmD/QcJ
	thtmZrTWbSBYLRsNz79hgqsa/btCu4JOPLUMj5lUI1FMDOjkhzK52zkyH/Yep3IrqenBacVUTni
	lE834E+HM+M4gDA==
X-Received: from qvbkd25.prod.google.com ([2002:a05:6214:4019:b0:8dd:5d13:dfee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2b97:b0:8e9:f62b:8f9f with SMTP id 6a1803df08f44-8f425674c14mr5204436d6.52.1782908611489;
 Wed, 01 Jul 2026 05:23:31 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:23:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701122329.3562825-1-edumazet@google.com>
Subject: [PATCH net] amt: fix size calculation in amt_get_size()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D46486ED7FE

amt_get_size() incorrectly used sizeof(struct iphdr) for the sizes of
IFLA_AMT_DISCOVERY_IP, IFLA_AMT_REMOTE_IP, and IFLA_AMT_LOCAL_IP.
These attributes contain IPv4 addresses (__be32), not full IP headers.

Replace sizeof(struct iphdr) with sizeof(__be32) to avoid over-allocating
netlink message space.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/amt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 724a8163a5142a6835950abb63d80f29417b2654..951dd10e192b7924f9d3f05065a298ddcf8f4b25 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3301,9 +3301,9 @@ static size_t amt_get_size(const struct net_device *dev)
 	       nla_total_size(sizeof(__u16)) + /* IFLA_AMT_GATEWAY_PORT */
 	       nla_total_size(sizeof(__u32)) + /* IFLA_AMT_LINK */
 	       nla_total_size(sizeof(__u32)) + /* IFLA_MAX_TUNNELS */
-	       nla_total_size(sizeof(struct iphdr)) + /* IFLA_AMT_DISCOVERY_IP */
-	       nla_total_size(sizeof(struct iphdr)) + /* IFLA_AMT_REMOTE_IP */
-	       nla_total_size(sizeof(struct iphdr)); /* IFLA_AMT_LOCAL_IP */
+	       nla_total_size(sizeof(__be32)) + /* IFLA_AMT_DISCOVERY_IP */
+	       nla_total_size(sizeof(__be32)) + /* IFLA_AMT_REMOTE_IP */
+	       nla_total_size(sizeof(__be32)); /* IFLA_AMT_LOCAL_IP */
 }
 
 static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


