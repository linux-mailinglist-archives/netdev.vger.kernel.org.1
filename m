Return-Path: <netdev+bounces-268541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJkaMqgvuWkYuAEAu9opvQ
	(envelope-from <netdev+bounces-268541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:40:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1822A81A5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B49F4303E496
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314123A6F0A;
	Tue, 17 Mar 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="L3Ld6vh8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAD3A4F29
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744035; cv=none; b=WAbehYhUmx8UyL/3ePg2aXz8Hyi4cor9qFw+kDMIacNgMysfvGR+RvRTCMccuHDELGc1wrwev0+BHC0gnuI29rPTtFV0NSuxQ1iI1ocGS8HEXEctexvOH1P3Hy34qcr+QtXNGQr0H23z5HFMjDz29Sjj9h19vn1/cG96fYsO9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744035; c=relaxed/simple;
	bh=rQhY7+1bOmJ74YZGAz74eZLwgNNakdU85i/zbOlXZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKZ8Jnq0djyTwNcJkF100YV5YuY1hveRir80me7C+Mns/I4dBosf8mcScjWkXNhMxaUE+cYT4NKUeqS6Frsr19Qpy981zezsimXZMzzCy8sp5bHyddIcFgv0zcMiEhG56+kaagpCdQsi3tesJBe/cz3el/189Nfd2A0WCcONrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=L3Ld6vh8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b7c2788dso3415349f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773744032; x=1774348832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=L3Ld6vh8hK9M0PR37ZJzwNgfuxOgsuK4rofY/GFxvjSte+vONUY1lArxsR74bJMxdo
         MXQpUOzs74ImnA1xoIegC8DlMG+/pldAQDhgl0xr9+AB4w2T98rMacCr+m10OgE0Grby
         SH4hSYmbSUyovPX3WssdLXaUV/ANxrDx84nLFdINVbb6g+0W/C9yL1yeY9CHTaKfGRYu
         TKKHivXqB8nCid7Lb5engrWcXmrdJA5ctOBF4qFKVRBdZmk6LGHTNNbYyB6ep1j+fJpd
         vyLkgcENtdbHTlwYYI1MMT9gT0u7IV5plsUCEQ0w618EHj8L4UwUi+lYK0wZdUXBcF5/
         Tp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744032; x=1774348832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=l9MVTGtvQYFYoVn78+9aOZjm/VqIYMmj6lvrBTL9LX86K/CQbheV1hskI2icOWM5hL
         7yiLBG0iJevfJ2H6i3tSueENOQPhbmDp3ujQDyOwE5cSoE8bu5zkm0H9VI/i/GEuTMRD
         SEiUomwf0aTC0WMy9r3i/7D4BGDR1nj/dc0XHxYVh9ibxqb2bLGKn9cmPrlgGRoIjnqv
         dIrvbML3Pq2TqQhHTT8n0K0Ud2S/PvvavGMt8coRiEBUPKPV/7ViBkPzrcRxMKEgEWUe
         mUM1onibdP6M/31e/BASBvITZYkvN0wT3a6NpKYTW4QioUiGt+QvM1ezYAGmcyBaNpEO
         1W8A==
X-Gm-Message-State: AOJu0Yw4TgHbsQHUDuoToJs0JBlp3Po4rDjgX23u0e3wKHfiA/ejbU2Y
	2TjyxO3FHIVRpvd65Q0DJt3Y1IXVA840a5JPRmrA6Iukq/g+bX8B2gJ2r0XUOXzgUZ0iPTPurU4
	vsW96D1hJ+7m7KxdgCPu5dHC3NgCNW9v3L9RcYK2Ob6t5OTb5gV1hZVPCyrgMFdLt
X-Gm-Gg: ATEYQzyrNX/9tKmVXduagiojjdWCZZbfeRWHTqY9woDpVLu7MuDGjSKcPfbyFAGIdf2
	LCrYaPXc7gWuLd5Wu+ic22pqSGkcQ+G+Er2x5rvVY5nhDKMYDW7b1dIIkbX8kJgfHJM0p15g3IK
	gnWbbReNFdhBdt52P/IoAFvCGN1kqSkvgI+r+qmKO0rNt7h1dKAee8TOaS/Rt5CVe9j51bW8jAT
	BVA6+vkC8dDRN5Sd3lXkKYNI6UPB/sN2V5A/JybUfe/YHYuhMOyw3e1W7067qop4oU9zR5OYJ3s
	j4jbxKuOhaoNrN/WQmkG5Ik6wr3OqnhPj5wAVBFj3cFYib6MlNdmZOggj9ELjHc4XT7Ok5jwUKz
	pPYgd01dIS/z2e1QDZA+9bfSLI3iO8lxLOWFb19e3LSCsCkROleMuijUvQTXpXJlHpVOkuaUgH1
	xIzXZ99sYK4VnCUHKMrExtfoQmdsRIKnphqAHVlHo1A+8CmA==
X-Received: by 2002:a05:600c:c162:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-485566c94a6mr271877395e9.2.1773744031641;
        Tue, 17 Mar 2026 03:40:31 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4f22:3f9:13dd:cf23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49948215f8f.31.2026.03.17.03.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:31 -0700 (PDT)
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
Date: Tue, 17 Mar 2026 11:40:17 +0100
Message-ID: <20260317104023.192548-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317104023.192548-1-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mandelbit.com,gmail.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268541-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: 4C1822A81A5
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


