Return-Path: <netdev+bounces-292570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ5wHvTqF2osVQgAu9opvQ
	(envelope-from <netdev+bounces-292570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:12:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FA5ED8D6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197E93174188
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1450340A46;
	Thu, 28 May 2026 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NupAQkSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08462F691F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952158; cv=none; b=RS5K37e1bWK2g0HIh7aZ277K7To+/dSw4miP9NAKxHu9gZELqjL8njSUnep8obHFaasHZ89VwJxjeIlY9Ri2U8Uks4c7IhbgLm8fyE3X+UuLzqmJegFfynkOSrpU6/N653da5hHxf0rXza1A2F3E3QWFlHK7/UnP/UbGohrH9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952158; c=relaxed/simple;
	bh=Lp2Ydd/vhQzgxvdtJ+PaO4rkfpJ1qSAj7X4wYdE5Rj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXzKkVkFEBG909XkB052O5XDP4fWzPw+aofmRESnu9tDt3MI/m5LlGRWFc0HiKX7sE8bXBxikdvQkwhBu3Ai5Ci3f2kH1zqOzuG7rI5OM1U9iGtmQHZVrDmaefQ5KSNFDH3HLBCNGBM67foI5hRN6uCT+ind4BY0MaEjilerxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NupAQkSK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so7662390f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779952155; x=1780556955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AyhxEIcTaJ0tE2zF05eMkIwg9pnZjsy1bH02V+XNbGM=;
        b=NupAQkSKEzA0m2qsXXhFuz8Okjwzejoaz4ydIbB/bq3rv+A+V62RibeV/0eOWmSPgw
         EXhTRitsxrcyr+ZAGsyL7GWzyNBRhqXQucn28/glp2E18IvYYy3Y5OAI694/LpK74MOT
         QQO31oS0vF67DCMVNoE8xBj2L/7QoT5veFOA+ZvR4qO00qfoguRTT9BBPMRvxFKzv9aN
         w0TxZUYpH6DcYMnJd8KtDfhQ92LXqHpEgJS83jiTX/GGwGXJV6qrI2zjBtYOtYWI6Lxj
         d9CmxENw5x3wm2roPJN2GhpLcMwL19BiKvLebVlqlfNK7+OO45B+YLENrtTJcVeQDZMQ
         hveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779952155; x=1780556955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyhxEIcTaJ0tE2zF05eMkIwg9pnZjsy1bH02V+XNbGM=;
        b=bElULy7wOnBHSBw5+1xiKx7JSZqXmNiYneb9an+0Doq50PHXntlW4jFeOHBKEQiZiW
         8N3UCgVg8vMAK4V3tB70p96i9tyZ9vsz6pKMojFeu3vZ95npj1fa8S9FgyoH53GT6KKM
         3oBG0l/bh5uzvMEiRt2V4ZNOkmxagiKhTBWqHv9bGQTG6FC6i2OMdzYIPA1uhvpwzjTG
         GUu70i3q0G94FImIAl/PYTalOHbSOu+nuBQBH2iQNgrUDouci6BymE1R2qZ6JOPjRczy
         N2S45vTv0XY7CYIzWsPudZVRWR1+widXex7PrSfrK0TzFQCfOsZ2LQFJrRhydG6hLXdH
         14uA==
X-Forwarded-Encrypted: i=1; AFNElJ8hp1w1XcXAeqm+aStTSVnOQsZuqaMndnzUm/pPaVPePYUWs7kR6yPXmJLWs95jJ1XX4bseAfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYpxDrRIglgbgBhwDJ0pUCHd3upNVrv99O64zihjbsZ937b5l
	XqJIdHFG+fjP0uJo+ERTBmiYY4rCvcTkpQN/oJxcvjVpIEm5CDDdWjZh
X-Gm-Gg: Acq92OEW1wu4ydURsMpwHEpPZ5TwEGkum4POnJh2vaEFcQ8jLStcQ4IYsKqug4A1NKe
	A2Teud43bbT338IiBhAiRNIizhB6fwk20KwFKsELmw0ZV+Tq3iL0V7Hg4ia1nsw9TPdEes0ISpn
	OH/UPMk7i1mU8b5vXFXO81FKrmfpsotEJgi6o3wRl1sIZELB8+FTkoSWWYD38B0gReEl+OEmRCM
	cF1PzfSH5v/Su4adE/YFaNEUJZR7JGaMx0it+KHnCDGbQBzyXnl/3WFbOLGqI80x99S19GlNcEg
	8isG3kJLY2NDJ1VJuCiBnZKmvpzLuudrH1uIXCjfThJEYuHztJ/rHNq3F44YDADWJkDzFeUmpu/
	8CzMuuuuahu3pWfw+yOTGNnzzWbg93thXkVzSHMWc7sGYzcBLv5nowFO7sh+5L15mXbf4Cu650e
	N6bohIiruyvuhEdWDNehFMJNdOAUUOtHJC+ICXKjJuBCjHlMs8HTqcfc0ZJe8jE9VrPrcF4b85v
	ChhKDBeAGAa5mFLodtgJcta9Yh+
X-Received: by 2002:a5d:5846:0:b0:45e:e5d1:8a74 with SMTP id ffacd0b85a97d-45ee5d18b41mr2471256f8f.14.1779952155005;
        Thu, 28 May 2026 00:09:15 -0700 (PDT)
Received: from localhost.localdomain ([188.27.64.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee91c34bfsm2722402f8f.2.2026.05.28.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:09:14 -0700 (PDT)
From: Adrian Bente <adibente@gmail.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Adrian Bente <adibente@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net] netfilter: flowtable: fix offloaded ct timeout never being extended
Date: Thu, 28 May 2026 10:08:51 +0300
Message-ID: <20260528070851.3913-1-adibente@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,mediatek.com,lunn.ch,gmail.com,collabora.com,makrotopia.org,netfilter.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-292570-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adibente@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email]
X-Rspamd-Queue-Id: D63FA5ED8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OpenWrt has recently migrated many platforms to kernel 6.18. On the
MediaTek platform, which supports hardware network offloading, WiFi
connections accelerated via the WED path were observed to drop after
roughly 300 seconds.

After several debugging sessions, assisted by the Claude LLM, the
problem was narrowed down as follows:

nf_flow_table_extend_ct_timeout() extends ct->timeout for offloaded
flows using:

	cmpxchg(&ct->timeout, expires, new_timeout);

'expires' comes from nf_ct_expires(ct) and is a relative value, while
ct->timeout holds an absolute timestamp. The two are never equal, so
the cmpxchg always fails and the timeout is never extended.

This goes unnoticed for most flows, but a long-lived hardware (WED)
offloaded flow on MediaTek MT7986 eventually has ct->timeout decay to
zero, the conntrack entry is reaped and the connection breaks.

Open-code the relative value from a single READ_ONCE(ct->timeout)
snapshot and compare against that same absolute snapshot in the
cmpxchg, so the timeout extension actually takes effect while the
datapath remains authoritative if it updates ct->timeout concurrently.

Suggested-by: Florian Westphal <fw@strlen.de>
Fixes: 03428ca5cee9 ("netfilter: conntrack: rework offload nf_conn timeout extension logic")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Bente <adibente@gmail.com>
---
v2:
  - open-code expires from an absolute READ_ONCE(ct->timeout) snapshot
    instead of the relative nf_ct_expires() value (Florian Westphal)
  - change min_timeout to s32 to keep the comparison signed
  - initialise new_timeout to 1 instead of true

 net/netfilter/nf_flow_table_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 3313f82..a2d08e5 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -500,8 +500,13 @@
  */
 static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 {
-	static const u32 min_timeout = 5 * 60 * HZ;
-	u32 expires = nf_ct_expires(ct);
+	static const s32 min_timeout = 5 * 60 * HZ;
+	u32 ct_timeout = READ_ONCE(ct->timeout);
+	s32 expires;
+
+	expires = ct_timeout - nfct_time_stamp;
+	if (expires <= 0) /* already expired */
+		return;
 
 	/* normal case: large enough timeout, nothing to do. */
 	if (likely(expires >= min_timeout))
@@ -519,7 +524,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	if (nf_ct_is_confirmed(ct) &&
 	    test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
 		u8 l4proto = nf_ct_protonum(ct);
-		u32 new_timeout = true;
+		u32 new_timeout = 1;
 
 		switch (l4proto) {
 		case IPPROTO_UDP:
@@ -544,7 +549,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 		 */
 		if (new_timeout) {
 			new_timeout += nfct_time_stamp;
-			cmpxchg(&ct->timeout, expires, new_timeout);
+			cmpxchg(&ct->timeout, ct_timeout, new_timeout);
 		}
 	}
 
-- 
2.43.0


