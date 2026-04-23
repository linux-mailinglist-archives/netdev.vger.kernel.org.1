Return-Path: <netdev+bounces-280563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG5vBrtk6WnLYQIAu9opvQ
	(envelope-from <netdev+bounces-280563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD444BE70
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F18C304044E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99B7081E;
	Thu, 23 Apr 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="z0aqwLsD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847732D7BF
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776903323; cv=none; b=Okzu8qj+UozqbXA8gi2TryVICOEnrP9xo9pCZ/v1tiIhQDnmO4jipy/rMFB5WK/ViDcqDXdb82Qvi0eh5iLX8VNE8jJubPSgKMVoaP3T4MC/EOVupGTTMej75u6crnkE7CUIMxUQ0GDqm6E8Sj5T5Ulss7SZsvOQ67XhHH9N8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776903323; c=relaxed/simple;
	bh=jp9CEU89ZmdSMHOWmRuDngKDB51xhhKtL0O6EGKdmGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqaQau4ic/c6437MY49l8O1IIMoLYiwXHD7CZRl/Wde79FeyZGdymuyQYtqXO3uU6dwzUY6FVoa6CD5aCPbzj3+EtVJpuGVApmloumiqdYd+/Er9IIG8bOcTVuH1YxbdxDaU4cl8kMEbFS6aI1IxlhYrxR6rHrPxLfCv5pGoJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=z0aqwLsD; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d868d014a5so5904366eec.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 17:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1776903321; x=1777508121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh15s1AFnKOilgQy5qcHn4N2o/PIT2Eni/ByWpA0f/8=;
        b=z0aqwLsD0KEIgExUHFNpkIWNMSka1ShlnCMm29Cmmb1e/qY+KxSkR9A50AZL+SGclj
         XPw565dGIahIINR/5zHNRD7mNQUk5sDIVgkIOob5WP/WWksPXplyApwTojIqOYXkGBKW
         DEXx1Sb3xUzqxWCFBZxzHLNg5qOR4BvTmreqrF2olm5gxRF7172adie6ZQGPq62nV7e5
         1uGhx53btsXtiXTIcajgnyB+7aa8Y5wbQOBjwJm5lyhwZqIChnZpxV5jBogPGtD6QDpg
         X7HKHsYD103EIAHO2pX6U8TzwwrBnEZJdRsv93N3pAG+OKURzSw4bJ5FWMC3GKKYvBje
         MGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776903321; x=1777508121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh15s1AFnKOilgQy5qcHn4N2o/PIT2Eni/ByWpA0f/8=;
        b=rKIecmeJswcKG/SyR+QliltmXBH+RPTpfnjxhf3WwRiz2bYzVuUP6tM1nK9EOxZpII
         Mia6UFqDc+H6rttxp9c5cRykr1mLs9i30fGbqtExzAkhRZcCIZzNowwRuX5pZFuUDkfz
         apqInooxUT4JEmWuN0x0sgDMNPD1vr6DsY92vTgCvi6yw2aC5NxY3+mlTzk7qAlY3IXS
         VRCbcIBj7vxnKghxHWQ1E3gLM/n0UNS1vr45g90KbeDSICeRBLQUKkSAscYxwkhO3BNF
         wyswPjMvFycd3IQBbR1xl187+2NcUwzMNGigzj0VkwIBoDmCZFhVoDLzrUpDT91j7Twj
         Gg6A==
X-Forwarded-Encrypted: i=1; AFNElJ/ifTCEGfF2vYP3QgngMQxXBZq69Xt6gsJbF4DXuD/GnuCbKT2yhtF2YOyr/kj3Z7NTO1ZRTV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmRi+pUs3WV/1+D4qnnYrqqiufMFnLhsCKfcvhsUVHC8KLdQe
	deFfU+kEBXs065jl68HeMH5uI+Be/DlaTT4PztfEtg1VvxFOG7EvUEuoJyeoLyHjUS4=
X-Gm-Gg: AeBDievlTY+ZsqtL+fz/dkxXwIdTGJLQSnqZJyi+iAU6GXIGFzK8bf6nxRc+VDsNC1e
	Ibo/FfWMLyk1MFUa2O+18XK5G694ZFmtTyBET8RL19awF2Y4vb8d+XG1Txu34ACa/ILLk3mr+eM
	nHC8ojPsnnHYAGMOUtP3DcYX31d+S3uSJi2t388ZnX6i9XeUcMhq84SAMY3pTC81ybHHYkmnOHI
	YQ4096y4u9AN+JYaTk9ul9SBeKgv4+YFHjjyPjjpNDyMpZ6Yyz7o2u9ZJ3gXa3SFJSb6RwNY5nZ
	LA6QCL41pUiFg2y1ipjuzXoEa6za9DJ57mkhwVlwBRJ4MGkqpnSvS8BEC0uJyxKht+IY9SxcaGn
	fXmGhEZ1fLwLqJqrN60Yji+9Wrt/XQ6/+rDTmXyc94mdgAExm8xODjsO8jKfK897r0yla+BYHsZ
	3Klpe8fm5zHpKtokB6+OHO8AYGmKCLnIVu9jC8O87h5oqyMIXrpPrPfd/DwYQAL4eKT+Yf9w3XF
	h7dkStnN5n7uVqShw7VC63CEA==
X-Received: by 2002:a05:7301:2b07:b0:2cf:3de7:22ad with SMTP id 5a478bee46e88-2e47901764fmr13702340eec.27.1776903321251;
        Wed, 22 Apr 2026 17:15:21 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2a00:79e0:2ed2:c:c318:833d:66c6:43a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm25628068eec.28.2026.04.22.17.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:15:20 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: "William A. Kennington III" <william@wkennington.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mctp i2c: check packet length before marking flow active
Date: Wed, 22 Apr 2026 17:15:15 -0700
Message-ID: <20260423001517.79219-1-william@wkennington.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wkennington-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280563-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[wkennington.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[william@wkennington.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[wkennington-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wkennington.com:mid,wkennington.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EBD444BE70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, mctp_i2c_get_tx_flow_state() is called before the packet length
sanity check. This function marks a new flow as active in the MCTP core.

If the sanity check fails, mctp_i2c_xmit() returns early without calling
mctp_i2c_lock_nest(). This results in a mismatched locking state: the
flow is active, but the I2C bus lock was never acquired for it.

When the flow is later released, mctp_i2c_release_flow() will see the
active state and queue an unlock marker. The TX thread will then
decrement midev->i2c_lock_count from 0, causing it to underflow to -1.

This underflow permanently breaks the driver's locking logic, allowing
future transmissions to occur without holding the I2C bus lock, leading
to bus collisions and potential hardware hangs.

Move the mctp_i2c_get_tx_flow_state() call to after the length sanity
check to ensure we only transition the flow state if we are actually
going to proceed with the transmission and locking.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/net/mctp/mctp-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 15fe4d1163c1..ee2913758e54 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -496,8 +496,6 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 	u8 *pecp;
 	int rc;
 
-	fs = mctp_i2c_get_tx_flow_state(midev, skb);
-
 	hdr = (void *)skb_mac_header(skb);
 	/* Sanity check that packet contents matches skb length,
 	 * and can't exceed MCTP_I2C_BUFSZ
@@ -509,6 +507,8 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		return;
 	}
 
+	fs = mctp_i2c_get_tx_flow_state(midev, skb);
+
 	if (skb_tailroom(skb) >= 1) {
 		/* Linear case with space, we can just append the PEC */
 		skb_put(skb, 1);
-- 
2.54.0.rc2.533.g4f5dca5207-goog


