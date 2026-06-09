Return-Path: <netdev+bounces-297220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9L1JCUxWKGqVCQMAu9opvQ
	(envelope-from <netdev+bounces-297220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F716632CD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bWk98bSH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297220-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297220-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB210302E7BD
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381783C1082;
	Tue,  9 Jun 2026 17:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4C331EB9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027824; cv=none; b=ZHDcNnhC9mMWYGnR7OSeZ5eMg60BK28H5pXzzXgjAorARF9egGJ+fSy+4leFlLJmJOWspIMHQ6iOhJzntSf2X1hbd5CdgD4oyzu7eHn7MyA2wz2h29qkFrNUAZjUleeN5Zx1EZ3ohlpVpzpKfdJRbdjnHqc0pgCU2l+oOcju+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027824; c=relaxed/simple;
	bh=ceuTWt9w9LeDldUkLP4ll59iRFDfgMsttokwznfdTfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLaId400DGtxLJxkVac4T8idrDptIQKAnFDcktfvCmKUGdzEEXcQPhlPkbTAXUk2N+YJfOPO8QLDl2B0X06xMBkh6bcmUh3J8lMXYc48IHEASb1hTbblEvyoJU982mv3XR3cofQ+aFObALRSGWljAav1oWeBRnbE54IfOY4cbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWk98bSH; arc=none smtp.client-ip=74.125.82.195
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-3078e0dcd67so3746405eec.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781027821; x=1781632621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kYpmhyNww2KkDuIdQFfU1ShKFDFbnvwHvNOiifQ3XM=;
        b=bWk98bSH0oj5UeUoCMcm2pVuWjU4YZF/vQ6QsbLIDKa+8fwNdNurR0s6+VVznxmPRF
         CgTZTrWVNoTeNiyHvcj7nwhjA19nFkQSwIBIe+fTx+XeTkFarpWt77xcsI7obG5l908n
         1PbVgO1X+uBKJZ/EFdk7VboTYaqshBHbXLxKOy+moPzbglGFCw2jLotRBdbX+0792lo5
         D2O5wGYSdBWrADfC3wHCn9UN379dexaQVOKnpVdP0lLf5fRDSq53rAO9qTrh+70gvDoG
         Kj1ppCVBTw5sll9S4gPVPNP0y8Crj64VNa6tGIXwlrG3E8ebvySLeapjlK1/hG0I4zzt
         N2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027821; x=1781632621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kYpmhyNww2KkDuIdQFfU1ShKFDFbnvwHvNOiifQ3XM=;
        b=hvZH3u351iEMEZi0mCxMtrLmJhkjfkxs5YMgQf9+5ly2SRePtYJrkTW8PfMMUApsHS
         +0aM8nKEvJHSBGHoZJcU2j0WVf8Fd9sx7By96u9o9HJKCcc/WVeqG1DJYdHOJHra/JBd
         HbgWTc4Gilaltxgi5ly2gzllqwpkGFXRSRsbMpZy4wW+CefipeNVav7TL68OdReIY50V
         dyLx/YAtVHpgf1uLULHZY5WWzHiZGKmz/QsvLJlMKlkCUg5aUzCuk2Z86TGweZ3/ri5f
         wBPRZl1aV4V2J33wrjCYxtBoMOVBLmiLdVNN6sA0I086P36VgeFl6sIEOh1SQXg50/eh
         /y7Q==
X-Gm-Message-State: AOJu0Yx+qbc5qHt/+/tLmpLwAhpomX6C/iPgaZOyZnN9sFGDMJXXJ7lw
	lGhj2N0l3alW+usD4aGdNiV7J0bETdlNPn0FiRG8BaTvJa1fZ6k4KTyUrYKXD15l
X-Gm-Gg: Acq92OFkU52s630IzVrJCRzQsoYAwoTaaabjCGqijT+a9HrpLOj9sdhijxaNjf+Np4A
	VpwzB1LavIlutX9iFh8z1GytsDc1Wvkj5nTYrtUdTdy/ZsxUfJX0y69K+uRqzlXw+yqaRNYBgWr
	G3aoYhAQIoCVHb50Tft0ZkAHvMAJpJMbKZcediRBpVvX2UWM3kZOcIEhhqXrlY6EqXp50+xc1oq
	Vdh6NrVAWcFulUrCzmwiNi6JrmzaAl+CfIHvUsUdPahpQ5vgwW1HMNOBmkpcTotbJvOqfqRJf2s
	Ns40Ck6FbUWQ7hvq4cbj1hysuXi4nmT+xB4dv7EE8Twfj496nAEkWd3U/TF58u5jPigOTZpXeG6
	X8h5w07DL1zq07C9NmWC1ZC14H0KMAOHTezQP6Ev1V/15Or611pp1wR7d1Pp+fynnxjJVu4zozy
	DYqyaDIJRxWNvOh9AU9VemESPhYseL8JWUmxYTBQh4r1cYoFCVbU54hBTxd0Y2aPfZJ+Uu+W0dS
	XoA6NLb4eewAssE8Mu8MxkCrlwZqvxIWUE5qTVewQPQeLjgUS0ZFwoes61v0AwySaJyZBD7pppZ
	8K6y+NhPN0L0lUrJ+uJdUZaFyupePM2N5f3Of9A=
X-Received: by 2002:a05:7301:2b07:b0:307:43ff:f32e with SMTP id 5a478bee46e88-3077b36f7b6mr12416256eec.32.1781027820557;
        Tue, 09 Jun 2026 10:57:00 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm23586953eec.27.2026.06.09.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:57:00 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Daniele Venzano <venza@brownhat.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: ethernet: sis900: correct CONFIG_VLAN_8021Q macro name in comment
Date: Tue,  9 Jun 2026 10:56:55 -0700
Message-ID: <20260609175656.20574-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,brownhat.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297220-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:enelsonmoore@gmail.com,m:venza@brownhat.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69F716632CD

A comment in drivers/net/ethernet/sis/sis900.h incorrectly refers to
CONFIG_VLAN_802_1Q instead of CONFIG_VLAN_8021Q. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/sis/sis900.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sis/sis900.h b/drivers/net/ethernet/sis/sis900.h
index 66e4bf38770f..b20665fc37f9 100644
--- a/drivers/net/ethernet/sis/sis900.h
+++ b/drivers/net/ethernet/sis/sis900.h
@@ -315,7 +315,7 @@ enum sis630_revision_id {
 #define MAX_FRAME_SIZE  (1518 + 4)
 #else
 #define MAX_FRAME_SIZE  1518
-#endif /* CONFIG_VLAN_802_1Q */
+#endif /* CONFIG_VLAN_8021Q */
 
 #define TX_BUF_SIZE     (MAX_FRAME_SIZE+18)
 #define RX_BUF_SIZE     (MAX_FRAME_SIZE+18)
-- 
2.43.0


