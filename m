Return-Path: <netdev+bounces-282895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCe5Db1y82l52wEAu9opvQ
	(envelope-from <netdev+bounces-282895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7474A4969
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0983051153
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EB428490;
	Thu, 30 Apr 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrdHtGzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFDD31A07F
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561691; cv=none; b=hrT/ubi84kFaOoiXyrqiKNLRpsfXycyJMni14zeJhCSZoPEogXbHTP2ys5LgSPdmUi6EiKGVrmTDYZvSvwzFM2Buu+hLNtioGV83SW/xUNT24xrEt79iSGsAHONmZjvwD+nabr/FOfOydaNKMP2MZUUXEn5sW8VrTiV2IqXj/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561691; c=relaxed/simple;
	bh=7N60anyk7vTUNeKX3EaP5ZxqXVISZE0kv9CxvPy/Z9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdN/2ttvbktWnG7pssekoO6uSufiDmxNwCppmoR76Cb1bQuK4NhgfcyuVsU3rJ8O8x/TNRJD3GisuUpsdGXXzdswzZi0Bw+OISLZifXiBY6WceJ4qLRFFmbVUnpzgLfYmsee9WC7eIKYrEVG4UHzr3q3FY8m69l77MGJK7pLcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrdHtGzp; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50faeb8317bso6979001cf.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561687; x=1778166487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImH4ahwmrHT+su2dG25ToH0WN0C8iXg+vRobO5a6Jcg=;
        b=UrdHtGzp45bXh/U13Rm/YozBL1+EN4tYsB8J1r3BtXissoUlWIbSIMDPcsqIsn8Xmo
         aeTvitbOs3Njz8OsQhgKEnUR8QW+6dmJUr32jlqRP+lwVvIclU8t8ENqG1gv7OW9gI1F
         SuNEWz2mR8zIPhloup1h2dQg/xam99er6Kkxixrrnl6YgJzyaHDxINY5tV2mCSTI4Jsp
         vWTubQ0eyzQybN3cIabLZAHplOFLmilm7XzGKXU6SAQJ5vTs2zMId/cwaoDQlwnxdkDK
         PFoJDsNwS/HA8DoBgN0wAXonb3cadC7oNgNeJbovkImX48l2opaQjQXPDO+JCoy491YI
         R4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561687; x=1778166487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImH4ahwmrHT+su2dG25ToH0WN0C8iXg+vRobO5a6Jcg=;
        b=rE3rrFhbHpS4s2S3C48QKAD2bCcCGjWOwlzsDxYCJ+m963yFzMCxM3KQ4dQq8VjXN9
         ghHlfHUErOvwLUEZ497AJZQ5Jgt3N+b5EC9XLqCLmI/ocDGMX6RJcnd2k3a6tVfhdifl
         WvCkGv8NPpmatbMWWI+kw6uNs1bF/OyYnjFrWxZ6kdeEUxelxH/pLbVlPNUzrOON0SIK
         jQ8lEqC2+HH67bvDX7ZHsqk/qoOu/qnrMcJdCef8Qm5UUFnOJzN7DIi9lPDHJeRkZriB
         kMNMGK5uViMdV07DsSBfvUY0wCDGgeyCw2Wq+k8HcGLP8bRn6cXudUyEEhB+uhpoWwDa
         TRHg==
X-Forwarded-Encrypted: i=1; AFNElJ9FiIzWQ33yE4cgHB+bzBnKVnx1DvGEGRnb8NZ073ltCTNsTN8O3JKilKeAvxwBywJuc9HqAPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywdOFxGzRf411X/eH6OUpdNegxwvr6PFZjoV7//YjbF2D2tM5g
	DgOYyx6H/6V+QT8X22NAw9ONSRFXcsZOlLCYm4FtNJ2tu1jJH1TMcBfJ
X-Gm-Gg: AeBDietcAmnN+l6p0OFLzKto/7exSQUNhkY/j3BwvXSBpttANRZi4aIFpifXmaBpGnX
	NbXLr9ZjesxKp7vr/xlhQy6yuA/rdOnPp5ToydjdAbjysT0D8QoQf9tROLWqdHzk7NfrfP+JwJF
	CuUoWb6CoQgR/4qKy724ZeGs/4C7zT7fh+6jEkITZNZ5mIf+Dc88nZHIeG1uHRhc0XxhP4HwCjQ
	RUsYSr/rjGJJ91AgQAiHRJEL6zgFHmMeqm4ySN9rnUhE9IA2cLZXGwB+/xcQ0Q0ZGbzwJUd8dUJ
	uVXWpldBTvrYWtVaF7dBlHehTkAMsTxGszGOcNgT4YBipV7DoQh+9Qa28Gi/7+9pFMFzmVS3T9H
	q3x64C8Gv1+hIC61irSRAiFiPpJc/pgwQ9niCpAyeEBNCG9yWuL7XyVONc07pkh5Zw6spMg0nI8
	nqgzBlZ4JXvBI7trGr511bDd64D+X0t++Zhk5+FP1/Joa/Rpoj+wdT4Oq1QB7vBoU586M=
X-Received: by 2002:a05:622a:1195:b0:50f:b978:82e9 with SMTP id d75a77b69052e-5102ab12393mr47350921cf.14.1777561686925;
        Thu, 30 Apr 2026 08:08:06 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b397c38sm450731cf.7.2026.04.30.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:08:05 -0700 (PDT)
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
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: mdio: Add support for RSFEC Control register for PMA
Date: Thu, 30 Apr 2026 11:08:00 -0400
Message-ID: <20260430150802.3521-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
References: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C7474A4969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282895-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Add the constants associated with RS-FEC configuration
and status as well as the indicated separated bits for
DEVS1 to convey a separated PMA.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2:
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


