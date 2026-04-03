Return-Path: <netdev+bounces-274981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMqaESKVz2nmxQYAu9opvQ
	(envelope-from <netdev+bounces-274981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD71393445
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E306305844E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE451FF7C8;
	Fri,  3 Apr 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLI+SheF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F83246F0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211793; cv=none; b=OL5buaaJwu3kWg8QK8p1cpbDJlMEOT0WtyplxGKYYrRs3JRW4uHk4P7DX7mApI2FXEdDDw6k9R7GhGNqMO4Uwhy42gnzNoKP40LHtncb8ApS2pJJZLSAoJuaGq+uKBEz38Ugxp7voI8wfdNsp88yAblM7RejSJs9qlKCK+A44ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211793; c=relaxed/simple;
	bh=SF5e8bGYAXowFD/+VhdK4DM58MQMtLrlrvUNyGKNe4k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L85ThARVVqxh6p07guREeqpPRhzSP6quzWA/zf54TNzUjR/9XMJjqHEY1j7DGac+dMCj1zFRLNhRGM+PnGA5AysGpkvx98QlRzbYISMGAGEl3MXBS0lnbPzjFta6LYzSE1mPCF3NjUby3neE7y17wV1/LW6PZT7D1ClHev7mUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLI+SheF; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb706313beso260254285a.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775211791; x=1775816591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1FhIdsH+1FLba8pe8/MRmB4pgxCxQ/A0BCivEZ+vrCA=;
        b=pLI+SheFnv/xfv6C0vwvFpNqkeLE1Hr6AsfzLmRxCHijgm9u0dGTpmlaianCGaeay1
         unW4m9MZalwPQ+TDqC70AojTvGzul1wnrsIjD+sHD2Q2SI50LKrYqN58XYp8PYpCoh8g
         /JUQKI7bSipboIEsYao3NrHwOx8x7NeuxI/JPTSmu1y79zR1rML7CtgGOzOgSTkyeWCr
         nnkBNCIHOCMb4zpzgCer+ovACzyUdUHHQacTgXg1mH/fYJk1/E2XdCGwL7PIvMx5Q4d6
         m5Md0TKfrsyktiZo8uJvUFbA4ey1Vk6AO4H/GFMh5J9FAJZoerX0nxds5Z/jVPuIfvU2
         V18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775211791; x=1775816591;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FhIdsH+1FLba8pe8/MRmB4pgxCxQ/A0BCivEZ+vrCA=;
        b=BsYrvoWcv8XS4qqs8vEO/TiDfzH5oeTcv1vNnt13g7Xr2yDNtXQE6D09v4KzToXFWz
         t9707zHc/J3gygSkAdAa/3BRtEvvl2rmQv/2p/Qr1TObXp05/UU0GCgyxKDl7OvPD5bQ
         kY3/T8Ut//mp9Sm9KdCHAm93+3n+0Wsg8HBdp8o8wi2qTCtwnBbd8hHL2VkSyfjBzEuZ
         4IL1lhvLU+vqCEEBwXyaBq0hyR4WQpY+yuYwgB7+ilswK3kWWJ4ThOCfT+71uQaAXeTc
         9EQpFKI4Vg+0xDasoAnQb7CbVxk3hB2bF7wGMUmKKUaQropByQsH1m9Ro+0r/wxkNJfy
         xW8w==
X-Forwarded-Encrypted: i=1; AJvYcCV3jVW6eWH2+Zd9Xza1FGUKH05+MpHzem04DDffuepItrgk7DwR1ZAsENzHwMHuZMnQdxBCfJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSVVZgBChTXC/+pUmotieb0hRwjAdPB4BUZjW+XUlYoyBY+51
	3O01DnxnYX/n9Zw+H+wY/b1TjCBZbGT1sYabGxpb+wUv00dUzOVJ/wTYONAuJ5pW4MzcpH839mn
	won3fW8SKh7QKgQ==
X-Received: from qknqx2.prod.google.com ([2002:a05:620a:8b82:b0:8d3:fe74:5906])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4510:b0:8cd:b3ad:63ad with SMTP id af79cd13be357-8d41ab03af5mr342325985a.34.1775211791207;
 Fri, 03 Apr 2026 03:23:11 -0700 (PDT)
Date: Fri,  3 Apr 2026 10:23:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403102309.338648-1-edumazet@google.com>
Subject: [PATCH iproute2-next] ss: add support for TCP delack timers
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274981-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFD71393445
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kernel commit c698f5cc940d ("inet_diag: report delayed ack timer information")
added a new enum for idiag_timer values and support for delayed ack timers.

Change tcp_timer_print() to use the new enum and display "delack"
instead of "unknown":

tt -to
...
   ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:50438

        timer:(delack,003ms,0) ino:152178 sk:3004 cgroup:unreachable:189 <->

        skmem:(r1344,rb12780520,t0,tb262144,f2752,w0,o250,bl0,d0) ts usec_ts
        ...

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 misc/ss.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index b3566f6b6b81427609829720496e80bea7cfeef7..1ea804ad549e23f767633e07efdd9adf1277af18 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -2765,21 +2765,23 @@ static void tcp_stats_print(struct tcpstat *s)
 static void tcp_timer_print(struct tcpstat *s)
 {
 	static const char * const tmr_name[] = {
-		"off",
-		"on",
-		"keepalive",
-		"timewait",
-		"persist",
-		"unknown"
+		[IDIAG_TIMER_OFF]	= "off",
+		[IDIAG_TIMER_ON]	= "on",
+		[IDIAG_TIMER_KEEPALIVE]	= "keepalive",
+		[IDIAG_TIMER_TIMEWAIT]	= "timewait",
+		[IDIAG_TIMER_PROBE0]	= "persist",
+		[IDIAG_TIMER_DELACK]	= "delack",
 	};
 
 	if (s->timer) {
-		if (s->timer > 4)
-			s->timer = 5;
-		out(" timer:(%s,%s,%d)",
-			     tmr_name[s->timer],
-			     print_ms_timer(s->timeout),
-			     s->retrans);
+		const char *name;
+
+		if (s->timer >= ARRAY_SIZE(tmr_name))
+			name = "unknown";
+		else
+			name = tmr_name[s->timer];
+		out(" timer:(%s,%s,%d)", name,
+		    print_ms_timer(s->timeout), s->retrans);
 	}
 }
 
-- 
2.53.0.1213.gd9a14994de-goog


