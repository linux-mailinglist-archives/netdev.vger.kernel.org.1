Return-Path: <netdev+bounces-252882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPAoE8mgc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:24:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2D7875A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 824693049A39
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9B31281B;
	Fri, 23 Jan 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXVB4cKV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53410310652
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185364; cv=none; b=KRxnoUptXr4n+nieGlB9jb6hRrfVbCCWSpD1yvYiJ4SqCxIc/jAO4+uGQ3Uv20B5HMUResRyZGGGybja2/vVdCDBTdL4A9yGccuArgr3E0lFX9vfsIP9RIUmMxx4PnQkYSsfCBmYBhfo3O8nlZT1f0cTVNBAHSME0w/qXkDGtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185364; c=relaxed/simple;
	bh=uC8RnDXJEyolwirjZwS1oaycN7CLJsgzdDtpCMvAGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at2j9Rg0FowBp3Ajds454VNqamTR0NX7JQWpH3vj0skizf6xUWWorDnBzNfxOt53CNwTO4Usdr0xhSHkEBnt2dJFx4598zdebA1fVH8z1aM0lwdkjLm2yYMg6WTmqHn/NZNMWz6x4q31IjxlnGzISOLT1FP7i8XvCgDjleSeiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXVB4cKV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c634c20be90so720248a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185363; x=1769790163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUm4PVJC35ODo4dBXeaCbuPGZ0/bE+N+0wlaMBGWiTc=;
        b=BXVB4cKVPVYymn7LqqwLhIF9Z/wP9uczM17Dgq+w9gzcHvAMP99E36R4n9iOCjN6C6
         N9nbKTvEXjn5lYFtewBA148o1m3SKP4M/ZymUWiL67fk3yahX+Xv8FmvEH/oCt16LqV0
         uBkmOeaDVun0Z+swzk6MFxKknv6bYM8sOCS0gQ6NFljewd0ks46/R7NP8R08IbFXlZxB
         S7iijDD/zbjEpGms70jDyv253AaHABH+3UphrKCyHJJdyP6bpun9b+tO4Gc+/F3mhUkf
         c+BQRT3JPePV2XGN7SEqL1OYNbqoXKyanyAjYlX9J32DEFL4P0/AW3mKcmcav1pz+IrI
         ELow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185363; x=1769790163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUm4PVJC35ODo4dBXeaCbuPGZ0/bE+N+0wlaMBGWiTc=;
        b=tQtSnSLN/j9iYpMu0eMkSkZSnHQnPXlgQMApO+x5RwXwzkQFoamaPj0vye0ic+8bW3
         tPBH3WHzDdzjUwpQz9Za/rCduJZ5tniY+rXqnGdUlrEkEnE1PaBOYtVtgOK39ii/fyWe
         AXbv+e+2iq7K6TCE0WL5t7Y/RUN0XrxV/xzNLRJDbrpxNBsoY/GYS8CuAXewEkOyV+2p
         GFITgoqKQsFGlmEZXNWaj0hc1zZP0d6u2cnBB66PPaHyJoi5amB++WAkdwdt7YhHuTn7
         PFncWNjDqBmXbdTGvW3MH1xIZ1JTeFIQYmoG48hWPGVBCE54w+BuRF15hZuo1ZnbtfXi
         WHIQ==
X-Gm-Message-State: AOJu0Ywef+HGIUS5az5FJVRj8Kkcm+xeYDHHDw6jboMJcUe4E3k3Xb7d
	a1Ky5L1xacxChkfG4Tq5fDr6iYJaIZYbKwwqE1g2xM+ZKOANn6+MCKxAc2UScA==
X-Gm-Gg: AZuq6aJkYT5X/jeG04I4YDtGQTDQAmWEOyZt2SmOGP1/MDfakW3QwRICbyn97BMEug1
	2exZ9pvzzrO7dtYSEq+ppBO0ONRPL638OKPb6IYdYCNgbuQ6oRk9l/sJIk8E2She+tkl6l57ZHr
	PXcjWOaxt8Fc7UOCJjQYyC7QIIJosjzG5dlymNRN7GW+8f06TKc1AE4fCZEFUrMnxBncOgqutTR
	kP2VN3+XDGgVxTWlL5Qp/kHhTAHbZolyQm8qdLicwzvVdRcUHdiGyq51JRj3iCCu29gYG8vt6JY
	UJMKo9tNEw9St/tbVorsFVOtRhXEz8ddhc04AIUXOw2tudyu1CdBCQECa8ZPtWsD9+785KnqRiR
	vWqw/aq2qhHMi9CVW/RqC3am+MWWG5zH36JP5zrK65qcjgfLww84FJgKABpeA1fTo6yRWI0xpyR
	3GA6z/YA0woXsYmQAzXRRa8HhScCBtoV11pNL+JIr2t1ZHE/VWczUIlA==
X-Received: by 2002:a17:90b:5690:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-35366feb391mr2267086a91.2.1769185362417;
        Fri, 23 Jan 2026 08:22:42 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:42 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/7] macsec: fix memcpy with u64_stats
Date: Sat, 24 Jan 2026 00:21:37 +0800
Message-ID: <20260123162159.2877941-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252882-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DB2D7875A
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered tear-free.
Use u64_stats_reads() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/macsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5200fd5a10e5..533a64713ea7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2806,7 +2806,7 @@ static void get_rx_sc_stats(struct net_device *dev,
 		stats = per_cpu_ptr(rx_sc->stats, cpu);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			memcpy(&tmp, &stats->stats, sizeof(tmp));
+			u64_stats_reads(&tmp, &stats->stats, sizeof(tmp));
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->InOctetsValidated += tmp.InOctetsValidated;
@@ -2887,7 +2887,7 @@ static void get_tx_sc_stats(struct net_device *dev,
 		stats = per_cpu_ptr(macsec_priv(dev)->secy.tx_sc.stats, cpu);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			memcpy(&tmp, &stats->stats, sizeof(tmp));
+			u64_stats_reads(&tmp, &stats->stats, sizeof(tmp));
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->OutPktsProtected   += tmp.OutPktsProtected;
@@ -2943,7 +2943,7 @@ static void get_secy_stats(struct net_device *dev, struct macsec_dev_stats *sum)
 		stats = per_cpu_ptr(macsec_priv(dev)->stats, cpu);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			memcpy(&tmp, &stats->stats, sizeof(tmp));
+			u64_stats_reads(&tmp, &stats->stats, sizeof(tmp));
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->OutPktsUntagged  += tmp.OutPktsUntagged;
-- 
2.51.0


