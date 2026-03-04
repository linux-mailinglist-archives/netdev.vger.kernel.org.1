Return-Path: <netdev+bounces-264080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGXVJNG7qGlbwwAAu9opvQ
	(envelope-from <netdev+bounces-264080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:10:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA007208DF3
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4E330E82E8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E49C37F8CD;
	Wed,  4 Mar 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fyKTz2Wb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43CA3806BD
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665625; cv=none; b=mspoH8X7KTIO2jH74LjEHeqGUC9tVMgND42Wj4mztNsZ2uIVHUELJfFMPMCBkaosXjQ/wLBdqCbuTujHOI5I7HTnakVJQi5FDWKoZrDEqj9DDOkCzhqGQpwXYcvLPt/v2czwnH/O7cgvrVpb7f4ZpiVW3q2rQSZ0Fq5U36BYkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665625; c=relaxed/simple;
	bh=rQhY7+1bOmJ74YZGAz74eZLwgNNakdU85i/zbOlXZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXZ0ZDEOXzLXXF3pmNRurCal+zNlFEkEG6l6b7oHxiK4C5rle6xW+FwW4eDpiPhNQJrd+78YUmF0Bxf653vs7SylBgANsfENXNPHkWediL54J7C5BwlcGVh53XcEeFoDz8UrjWzxQZD9a0X5Z/3sDs4cPGHsummpqI5pIMEDNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fyKTz2Wb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso65260835e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772665622; x=1773270422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=fyKTz2Wbon3J9Nm74Dvmla2OhhA9un8KjmjT+W1uT1bCp7gQxz2fuC+KIMZgkJHDvq
         ahA+gi5xd8+wS9Y8pDoGMMND9g9pJA3ijPfl+hMpQImBicYEQwgXCetNeGLpBNOzQ86R
         G9Wk0J1k0jnKUPr4CEnHKmS/6fRt6+FuP7aFJeLvW0kQLBjgqWX4quGl13Rjh6V14nAo
         Ns5SkxfDCeW7l70Sk6cPI8SsUn3Ip9GuTROIMrwLykraHiFwmzETP+AHacYX4FHJ8CzR
         JqpoMiaQnBLgAfuEOyZpakHTM72dQ84zHWV9/ufyLh736gu15Zdbv24MWUVmKKiWl3ls
         8XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665622; x=1773270422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=TKqD5QQ69ugXe9xzUbDKSsdNfSMaozhjIDfG7tKxHELT1MRNnqrwkAwupOFbMUok5f
         DjnMcGMw031ecoUzzAOQ/wlriO77lwrnDuz5N2OEc2QPPhbTfiUeibYQkQRj7LDCrzxR
         mFsRO6rMUveMewuYbwk49RSc8NfvmoeMJce5WgTJrEfG7kXkraAM3R3cKEy2ksPFsqRH
         CBpXoxHPSXPDY2W+dr28iHE3tan9vAbe9z8bDtLJ0Sin7jupVMWW/d9nadOCZ09V1njS
         9hBGSIuTR7zX6UtKWVclDlcUZMPOEXvtRV/rceJRKH/x6f3vnIG0MkKk2nvKIzINcjt+
         o2BQ==
X-Gm-Message-State: AOJu0YyHm1Mc6ebtPC+WpTpRyzOWKd45Qi8oU/pnkcyCRXbIA8ok17KJ
	fH744oLCwC5p/84d4WNOFztFpWuMRw3+rSqY3gPGKrh8SWcgDEFgKQhpKA8R5VjgFaXdIimohNc
	SRdeUWTpxSfzdQIP0S6C7jnc07MdxQEP53bRVYYIdIIVydIYpyCG9Sp/1Pu8sOWny
X-Gm-Gg: ATEYQzwuMe/CDAlLo7Ug8GC7CyYu99VtQNnvHUi+RNaNmJqnC3ts2zCBnMkm/82shNe
	zmeiZ3wD/2GfBgz7cb+2eOQP72Q2yG8/pxvEMzDdHRHsaS860LSpx+yF6pYhrXY9DQHO5c4rw8u
	KNj8ruHS23K27bi1WWsQ7VjIkwNV+P0+1UaoZxBhglmNPPyJRcUVIPWJxaMdOHqyPMpm45AWBtA
	HW03Aagcb66alxc+m8Hg9pInqAbegNDVfO7sqasY87k4iA9XUEQBAtE1x/ssWZciXnxkUZ1cHBO
	MoZytRUlgZSEXbaDmyF2IBvLgvrCwa5//qc0dvCIbWKpNu0tP9lEzFhyK4Qc84B4cFTjjKOTjc9
	hdzF4zb1/0bkj/Xte1hr/hLZPSn5/7t2LOxzJ3hEVRUy7rjsiaUGj9KEa0RPGS/FjqGvItKRoMW
	zBVRPL73YBjl3GeoWvOt59Xzi/F+FuuNCFZBJ7dANcmaKoBQ==
X-Received: by 2002:a05:600c:6291:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-48519837bbdmr54442965e9.6.1772665621244;
        Wed, 04 Mar 2026 15:07:01 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:880:4d86:fc53:5d46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187caf9fsm87713475e9.7.2026.03.04.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:07:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/9] ovpn: pktid: use bitops.h API
Date: Thu,  5 Mar 2026 00:06:21 +0100
Message-ID: <20260304230643.1014-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304230643.1014-1-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA007208DF3
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264080-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,queasysnail.net:email]
X-Rspamd-Action: no action

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


