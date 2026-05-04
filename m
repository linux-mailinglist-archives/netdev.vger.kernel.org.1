Return-Path: <netdev+bounces-283857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKSQA7mm+GkExgIAu9opvQ
	(envelope-from <netdev+bounces-283857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE24BE580
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CEDF301D324
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD093DEAD1;
	Mon,  4 May 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE3hD8wx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD63DE43B
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903103; cv=none; b=olfEfcT6z7TeiOV6KDlBXUczjHoaw44PI0RVv7/lUc/6Irqywnqnk5HmWuwU+pNmBPhUNr6EY9wzw+sN/jbGD9RznAYX8Ha4XWOatYWV0H6S7wDp5OimjVlQgqp/4vK0zzFj+7czrKslmMtAY0kIczHJ/BQKW6HtJOxjvnZj520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903103; c=relaxed/simple;
	bh=zQP8odavyv/r1PaNAVRRd+rSYxP8yZJJFzPjfrZtPAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVNNApRxNtC2sE7POfTHqSLzkdUiCR7Dbo8fuLUGHMC0vqz/mNFeaUQI6tqGeNGMzW+5PeIl978jYa+mLVM0mRhAueOGgWROQgOJqjXij6Cbtcsycsco1PE+BfnT/yT5oXMN8paPXjAA2D5TpqRP99WGjnG3LBERzx03FllgzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE3hD8wx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ee63e91acfso313992985a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903101; x=1778507901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r323mEYZ+RPIpmsRGgRnwpYWGnkGIyjDWiXj2+LZkxk=;
        b=NE3hD8wxJOrjJh/GJIY84Io/FpnIQuLCQAhbfxMwhihumtR+hi5PepRQO/hQOpGPpf
         COsEYy2wgsxGQzKv3By7tWZQjnDWm9RZxOsuP/SWn7xIQOoXZ1RLMj7pwr+dzc91Qcru
         BCwA/oJVIKZoT0Mtk3DSmyLlftFS7xm/14F3Yg1hgQkFszMqMLm7A/8CDVMd4iJ2rjCQ
         /KPngR7LpZQi5vXDsyIUeGUKigynILhEUPIDx5Fdcxr6lB8JE9O+843QOKA3ljm/0tnT
         +w0eTMy6XbNzPwBQac5Vx8rNYU4K+NxWGAcQ6xgayLffwx2LfhZNwDx9JxWet337ertK
         GA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903101; x=1778507901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r323mEYZ+RPIpmsRGgRnwpYWGnkGIyjDWiXj2+LZkxk=;
        b=Y0SM9JXO5PsIiA+GkO3Ucmzv1g7PHH9W7dJ48xjSgdm5/ZFrYhXb3b8BTojqeU4aFr
         j5ZhKZGarQyiFWtgsgAnI2q7C3t9bbLeKiT0zK2GFege2aKG53b7q6jsO7e9pCKmK5BD
         TN8YvmE9iInQ8ISXzeeuKlzeZpO2oXDlUauZEEAmb218f8s/Y6vk8+/598q7pJzoY2f8
         6Rdxh3b3XZi/SUmkw8vPYTMZ9wpFI/cpwWnU/q9hJ7lYXjHDUdk/PnSw+GaawyAuL7Yb
         jVNJ2x9rw9ELuUnzvZq/bnvRnKvWWuQl/jFwbg63Xd4XG30wyTT6BRYTQDHQN6XxVGi9
         TM7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/TWdiTKXg6nZFIY8ff8tXFe7ylo+7F3/S/OMkRGum7/VMSbAXX/39A5t7S9MNaXyjZXpCp33o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvVwXxgFPg6UmjpkhiN1YTjRyEsZLZhV+//RE4WSk4W3JPHxR
	UMf/+z6hh8fGvGfB5y6a/GV46ShzYiwSkZxJ4co2MbK8JaYXz0pQWAJx
X-Gm-Gg: AeBDievB2zF7LjXtKmqlunCr/Hei0q/bN9cDtTGm0fLwH4mrtv3cwFLAxURkbOdrbmM
	2QOYWKrggM4qFgEYETZLbunrr8xV/uinOuHV8prgSkZMWdYw+aao1OgYaDsHHS0wYLHmZ7A17Re
	x2MrXOgMaJBahNfj3CYtFAIbDRyxnntpLAc1g7KN8icHJeMx9fpiuzRMEOuCENOddYHbagEKJdG
	ByJQWpF8T+i6fkYDZeFkyHiVtw2ua3BH4q4/QQb3I5RG23XT63rJqh6WTGBMB8d3NYXYrMU2zQ+
	PcvIfsP8h0Pj1XMXXRTpl7Ojj9m/Y/9f/yPYcuogNd99zm59Kt1+eyeBrVeuqn8llbd/jlxdqpS
	WSIsSfUlrtq9ZU88IQQJWdIrMJ7CU1rQjp19uohkZ1cKLWmkc3soGwVLWANpWCnCyZdEZPIPB6b
	4NZirr18ksU4gaErwK4lNME/MLQiqLlVxp5YbTy4Wmta3+Tsrs+yZLbpEUx/VZr1OBlF8=
X-Received: by 2002:a05:620a:4054:b0:8d1:d0db:392e with SMTP id af79cd13be357-8fd18137d02mr1499591185a.32.1777903100476;
        Mon, 04 May 2026 06:58:20 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm1062878585a.35.2026.05.04.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:19 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] net: mdio: Add support for RSFEC Control register for PMA
Date: Mon,  4 May 2026 09:58:13 -0400
Message-ID: <20260504135815.44226-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ABE24BE580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283857-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[andrew.lunn.ch:query timed out];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Add the constants associated with RS-FEC configuration
and status as well as the indicated separated bits for
DEVS1 to convey a separated PMA.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - no changes
v2:https://lore.kernel.org/all/20260430150802.3521-2-mike.marciniszyn@gmail.com/
  - Added Reviewed-by
v1: https://lore.kernel.org/all/20260428172810.175077-3-mike.marciniszyn@gmail.com/
  - initial revision

 include/uapi/linux/mdio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 8d769f100de6..b2541c948fc1 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -23,6 +23,10 @@
 #define MDIO_MMD_DTEXS		5	/* DTE Extender Sublayer */
 #define MDIO_MMD_TC		6	/* Transmission Convergence */
 #define MDIO_MMD_AN		7	/* Auto-Negotiation */
+#define MDIO_MMD_SEP_PMA1	8	/* Separated PMA (1) */
+#define MDIO_MMD_SEP_PMA2	9	/* Separated PMA (2) */
+#define MDIO_MMD_SEP_PMA3	10	/* Separated PMA (3) */
+#define MDIO_MMD_SEP_PMA4	11	/* Separated PMA (4) */
 #define MDIO_MMD_POWER_UNIT	13	/* PHY Power Unit */
 #define MDIO_MMD_C22EXT		29	/* Clause 22 extension */
 #define MDIO_MMD_VEND1		30	/* Vendor specific 1 */
@@ -63,6 +67,8 @@
 					 * Lanes B-D are numbered 134-136. */
 #define MDIO_PMA_10GBR_FSRT_CSR	147	/* 10GBASE-R fast retrain status and control */
 #define MDIO_PMA_10GBR_FECABLE	170	/* 10GBASE-R FEC ability */
+#define MDIO_PMA_RSFEC_CTRL	200	/* RSFEC control */
+#define MDIO_PMA_RSFEC_LANE_MAP	206	/* RSFEC lane mapping */
 #define MDIO_PCS_10GBX_STAT1	24	/* 10GBASE-X PCS status 1 */
 #define MDIO_PCS_10GBRT_STAT1	32	/* 10GBASE-R/-T PCS status 1 */
 #define MDIO_PCS_10GBRT_STAT2	33	/* 10GBASE-R/-T PCS status 2 */
@@ -175,6 +181,10 @@
 #define MDIO_DEVS_DTEXS			MDIO_DEVS_PRESENT(MDIO_MMD_DTEXS)
 #define MDIO_DEVS_TC			MDIO_DEVS_PRESENT(MDIO_MMD_TC)
 #define MDIO_DEVS_AN			MDIO_DEVS_PRESENT(MDIO_MMD_AN)
+#define MDIO_DEVS_SEP_PMA1		MDIO_DEVS_PRESENT(MDIO_MMD_SEP_PMA1)
+#define MDIO_DEVS_SEP_PMA2		MDIO_DEVS_PRESENT(MDIO_MMD_SEP_PMA2)
+#define MDIO_DEVS_SEP_PMA3		MDIO_DEVS_PRESENT(MDIO_MMD_SEP_PMA3)
+#define MDIO_DEVS_SEP_PMA4		MDIO_DEVS_PRESENT(MDIO_MMD_SEP_PMA4)
 #define MDIO_DEVS_C22EXT		MDIO_DEVS_PRESENT(MDIO_MMD_C22EXT)
 #define MDIO_DEVS_VEND1			MDIO_DEVS_PRESENT(MDIO_MMD_VEND1)
 #define MDIO_DEVS_VEND2			MDIO_DEVS_PRESENT(MDIO_MMD_VEND2)
-- 
2.43.0


