Return-Path: <netdev+bounces-267596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCa6Jyl5tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 002CD289E9F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C813189236
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFEA37F8A5;
	Fri, 13 Mar 2026 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ObrFgOlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50E37FF53
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435115; cv=none; b=TeQmONX0QVBwwjVc3iRLqXxX3JE/SnYy/B/9fp1XyyCUhSdCNSI2FJJ6G8NlVaBocMqp6aSVSU8gcarDMoqiGhZJ6AMRzqtonX7uLnkEwIvpiwoBp/IUiEEbS/gB9olfCoCt+zGIsI0Xr4bE3mvcIqgabCQKVbiWU8Wi+GGcF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435115; c=relaxed/simple;
	bh=rQhY7+1bOmJ74YZGAz74eZLwgNNakdU85i/zbOlXZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Zu7Tjns9DfTH3S9a9dARbO09O5hQsWChD3i/u+J2jafynEoDv33UXQNbpvombM0AxNfaNzrFC7oGo51AhA4tvhp/RKJNnHDCGNtJXjDWKTvKi8pxjvC/Wcv9zTARy8we8+BABGl+P7oLS7iEyU/2OuwY4fE3hXauJMMg65TME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ObrFgOlQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso1936366f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435111; x=1774039911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=ObrFgOlQNE6K8ZC+iVQ2Ig8+iaK77sVrsZP7jxTMtbPJ+IQakGx6yltH5uMOOcSlFr
         l+D1sDTfalqsxbGLtKOac0csIJWaueTsBwIH+Z4sv69+QYh8onxMp3g8WyC8i8MfRAmx
         26xGfbJyS4JJc2qWYnKfRdfEeYObeXtvWcGdY4MHoxaAj33D9mx6DPrFPkrO25H2oGeY
         FOSiduxFnsZ0PQVJfJoqqG+N0hBt2fF2seBEyvxM2ehaKDIQ0yzrwog83j298yrcgITb
         FdKcdBe3mLbaBwcaxMIO499ycT8h5SZeAgP+c+kK4+d3ibuP7q4Bg9OHo0KbxEENa5ka
         Binw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435111; x=1774039911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=pU1R1V3JBv0fQ+p418MDPlxUFbsWH+DsNX0Z3XVfX0bNyiIU5aZeTAKY4Up/WQ9wEd
         k7Rzbad/OQMEk/Bg/JYW5GL4M4nF8RTE8mYnLHMk3/hP1wpYctb02wLiyecbvHFuE8/5
         FF6G0kz0J6esXshnlTzeh5voZhZB7x9PxGhP4Vie6n3VdIiOsaDYfABmOkdkSBPg4TGM
         VPXQbrMHmV719QlZ1Q99F2myKngV0y8Bq3Cl8wydKtapSIcWZ6GEe7od2im7Dh7zJjC9
         d4hcEYvf/5UkigQYoHpK/9B8jqLi7FQ6ERTxP6Swkv0xI1tvejPKmc3XJpC5V5jygIEc
         hVzQ==
X-Gm-Message-State: AOJu0Yzz0ihlatSV8QSoZKHOo9ww83e8QRXaAIPGILOpagBl+zqsITB5
	NlsAKOXjYisqei444ZK6G0yhDsOeZSir5pUQ2XupMZooFoWHdE3dvK7gRJIl/V0cFD0+4ZlnPZE
	LlgOoYiWyANywoGORLiOZJtaJFKiClRufx8XxykCOQ5kpRMsAuERUFQp6RsZ4R/1B
X-Gm-Gg: ATEYQzzfKtfDoiQNPuu4zJfIDgp2zNVMjaETA/jHKTyJ/av9QFw+hHI/Jr9RNlMfMIF
	4RV1kGRyAn75RbWzuwrAMvo9JdpUDssIzFBYaVkbD1hZwJpCFpqfrQrCQtbcs7hhmkKJRkBqSpq
	0sQ0Aren6Xl68e0vpq3lf4fqQdKAxVvl6sEU8B9cnU2g14BQS5PpD0wEkzUG3eTh24O9WeJCBfa
	86Fd1vS+4DiYgyVMPhWoJjsiYr2ex6XDzrLDXRgv+SPPrKdafWnwdVpShcQjKqKRcV8qN+KRKKX
	i05UqiYmNCU0lBDnA7Us1dzjeYFMCvnGYHH6UgzgLKH8t9GSqLhSmtva94m/HeJ7f4xvylgu5WK
	Jmu73/9rw4JCCOlLK1lDi8AIkkV6IGFayuogLyzdJ2Oc5ihO6HW9bI/79dDiOIBlqsv+pqd/LHa
	t5AWknBUzuKGa6h+NqO5GcyKYExcescoTVzsl4
X-Received: by 2002:a5d:5f83:0:b0:439:de1d:74c6 with SMTP id ffacd0b85a97d-43a04d863a9mr9007006f8f.19.1773435111388;
        Fri, 13 Mar 2026 13:51:51 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Qingfang Deng <dqfext@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/9] ovpn: pktid: use bitops.h API
Date: Fri, 13 Mar 2026 21:51:33 +0100
Message-ID: <20260313205139.2950-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mandelbit.com,gmail.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267596-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: 002CD289E9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Qingfang Deng <dqfext@gmail.com>

Use bitops.h for replay window to simplify code.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
[antonio@openvpn.net: extended commit message]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ovpn/pktid.c | 11 ++++-------
 drivers/net/ovpn/pktid.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
index 2f29049897e3..f1c243b84463 100644
--- a/drivers/net/ovpn/pktid.c
+++ b/drivers/net/ovpn/pktid.c
@@ -65,7 +65,7 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 	if (likely(pkt_id == pr->id + 1)) {
 		/* well-formed ID sequence (incremented by 1) */
 		pr->base = REPLAY_INDEX(pr->base, -1);
-		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+		__set_bit(pr->base, pr->history);
 		if (pr->extent < REPLAY_WINDOW_SIZE)
 			++pr->extent;
 		pr->id = pkt_id;
@@ -77,14 +77,14 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			unsigned int i;
 
 			pr->base = REPLAY_INDEX(pr->base, -delta);
-			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+			__set_bit(pr->base, pr->history);
 			pr->extent += delta;
 			if (pr->extent > REPLAY_WINDOW_SIZE)
 				pr->extent = REPLAY_WINDOW_SIZE;
 			for (i = 1; i < delta; ++i) {
 				unsigned int newb = REPLAY_INDEX(pr->base, i);
 
-				pr->history[newb / 8] &= ~BIT(newb % 8);
+				__clear_bit(newb, pr->history);
 			}
 		} else {
 			pr->base = 0;
@@ -103,14 +103,11 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			if (pkt_id > pr->id_floor) {
 				const unsigned int ri = REPLAY_INDEX(pr->base,
 								     delta);
-				u8 *p = &pr->history[ri / 8];
-				const u8 mask = (1 << (ri % 8));
 
-				if (*p & mask) {
+				if (__test_and_set_bit(ri, pr->history)) {
 					ret = -EINVAL;
 					goto out;
 				}
-				*p |= mask;
 			} else {
 				ret = -EINVAL;
 				goto out;
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 0262d026d15e..21845f353bc8 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -34,7 +34,7 @@ struct ovpn_pktid_xmit {
  */
 struct ovpn_pktid_recv {
 	/* "sliding window" bitmask of recent packet IDs received */
-	u8 history[REPLAY_WINDOW_BYTES];
+	DECLARE_BITMAP(history, REPLAY_WINDOW_SIZE);
 	/* bit position of deque base in history */
 	unsigned int base;
 	/* extent (in bits) of deque in history */
-- 
2.52.0


