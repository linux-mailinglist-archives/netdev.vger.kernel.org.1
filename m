Return-Path: <netdev+bounces-282025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNnSMkv48GkpbgEAu9opvQ
	(envelope-from <netdev+bounces-282025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:11:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FE48A795
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECD66305FA3D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2773144B69F;
	Tue, 28 Apr 2026 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKsSebhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DF439007
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397297; cv=none; b=OgMBDTp7xFyVj77e5/h5w2AJ/7MypUhrLqkHx/T4aETc8IgbhVCHKWQvkFm9wWvdRBFAajBSA1yjuohRbNCqn3MK3YzCGeX78AcN27HCrilpAdHqq5JtzA4mCoFai88d4NcMMLTVpz0d2PgkU/i7jstoxaGIaL+hCtqRUghLrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397297; c=relaxed/simple;
	bh=oRo8lYiexVQYFpTqUUCpIsXoemo9zhUnZ2iQPRYQAZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bedwI6YfztNUpIsDZwuJjtlSv8k3PoezhBQskSKyFcOfVIDHWOyZui19JRdj304M24W4J3owciwHx+wu8N+6HEoHPXcAZ4+qVancNzAZcPaOqDhtfNW6ryg7n8N0zLDqC2JzoT5IMIK2zUaZTIvl1wMwsTlWuANoSX9exgr3baY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKsSebhl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ef2118b478so771030085a.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397295; x=1778002095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZFwwzc6Rwzn/axLVMxm0QG6iMTYTwsLo/ohS20J9GI=;
        b=KKsSebhlSNcPLUV7A7IDUruie/HgPpSgT0u8HGtvsPw3vvpnSEoR6fW2IJJM9c9AqX
         tTcCF/NSzisFjb5w/SZ5ypoG3TFuRgMF8QAIGyN/plBjLaoXDI9p7TFFXKf1VYMbsExk
         aiEZW5MMQG9nEIryaworD3Jukhl3kf0KkW+oFAuOntG0tix5MYP8cGeUH44KmXUOXmJ1
         HOlc0Sbx6v+NIG8HbasnEReHPLaBKU1jiAm6laX52eE5U0YYpF33UDoWRTAP0e1pCEpr
         vngneYzWpZ6PVJ7fIuxpP9SLtpMOh+lIlzww5B6ETVIEgdnnWd2posXa5f1w2taKPqHb
         FCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397295; x=1778002095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZFwwzc6Rwzn/axLVMxm0QG6iMTYTwsLo/ohS20J9GI=;
        b=sJXLJHANDG8Jr9Nd55usA/kO+hPVvJ+os4ROHxN6iloj9JupcvSVyMTFF++jAmrm8q
         gt6PaYNgE2yQMVlgnSdgW7aUWaZAb2NksF7u8Vhl4bqbgkf0Ou8EJkMvY8BMXZG3ev7L
         /gK3F+4WkvoGghhFzfZEDx8jtcG76GxOZ1VU9dy5ZkpDG4iCRbdoDxTok9Dv4xJ1nKl1
         QBRlyWFlaRjYTLAiBztozT3YSKu/lTyvnoBCGnpkCDz8gtfl0/kf40rmPJdjF9yIfx8u
         /sOv+/OwVk5Qu0J2lQudRTOR4vMfy+auDToc4nCQ0j++os0ONp2z3J+UOeQjVrPCWmdt
         n83w==
X-Forwarded-Encrypted: i=1; AFNElJ9rdz2uRHlObqBPifw4vkV6OH5kuGFTGBEv6S0mXRv2Vm43v9XAaBtFrErXQFyAFuSkvQzOlOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGCYQXTgd5BH6Ulj3FGDVtCZnU0//LXFvkoV6UfCSg518IKYb
	IBNjkHuQdbG74qxgAlzfOPrWWLeom7jHK0at5Gs6lil2FLplbtBXe9aV
X-Gm-Gg: AeBDiesxq84YzoPoqvhZJz65eexWE9cyetYiYZrlWaD4AoKaY7uFUS7r2/FD4vceyp4
	iGPcH65AYesbES9p0lm2Y9sl4CyqBqJyvzSzMAB5MPQs1LqSC/tB/DIy+Tg81ZpVTLELDP3iRyo
	sicdmzZ3RuwBgZp9IBeJGkRZkLlLszOkO1+DN29xx46qPaRDbVhREEOqLls9jC+2foFQsyU3bnE
	Xk9QPc0/VFkTEZlI9Ms7NezSpqcbhwNC9zCBuoHON+AZX+1C3HUwVDIAI3qC5LdQ191b8q5iHQL
	0JlL43k2ZN/M00gEprpkOmX0IqRXAQisowo1TCrn9EWI8bPtcNN8eEPcqp3F8YZLNaslMHRCvxS
	FyFK8MA5oLeVVHb6SgYW2vuxYJ26smK2hw82sgDgGdd/+ARhMFvL70iMZJkXIzQAkcpYGqdi6sP
	rVz1stt0sW+zJVF3nqsvDxRMWoOvefLBSGEg04gzCTpKnefAl03ohWLzmLXIigwM9tmBM=
X-Received: by 2002:a05:620a:4590:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-8f8f6777defmr69990485a.53.1777397294632;
        Tue, 28 Apr 2026 10:28:14 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e299d76asm26253676d6.48.2026.04.28.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:28:14 -0700 (PDT)
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
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: mdio: Add support for RSFEC Control register for PMA
Date: Tue, 28 Apr 2026 13:28:08 -0400
Message-ID: <20260428172810.175077-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E10FE48A795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com];
	TAGGED_FROM(0.00)[bounces-282025-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Add the constants associated with RS-FEC configuration
and status as well as the indicated separated bits for
DEVS1 to convey a separated PMA.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
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


