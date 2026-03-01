Return-Path: <netdev+bounces-262416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5rDadmpGlcfgUAu9opvQ
	(envelope-from <netdev+bounces-262416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:17:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF81D0914
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D91BF300644C
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4030FF33;
	Sun,  1 Mar 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX2bclaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2522773D3
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381860; cv=none; b=ZxKGqwrwRyMay85IBChgMPJYWmLqw+t5yhh/IZjTiqGkRCOme2X3ywEMaNhoMCH+1LUXd/5/4HRyig94YAvbYBPX3YwBSI81KuxHvC8KB9YnuQFRnSZdspqdw6KGpS1dyGPk69D16+ZWsRr7Z2yftvc7BRrgkDz1fHlXooCu5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381860; c=relaxed/simple;
	bh=DsCvTnRonbBjO2JlO28mIxQ6YAbIlpWMICrRxDHCp3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XN06XNkBqQkQWCE1FmvbyTajedsweQ/vmvU/+NRqswiN/uSPx+6c+gR2y/NOG1pdAv0AzEk/f108nrjoFBunX+2uxuz58xE9cWeuwxkF+t4OrqQkQ2nRYTfQJ1tyeMKnKIVQsTE7HY3y/vMcwHhxWta8fKKpHerVdxc0+Dg6vtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX2bclaf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so309121a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772381852; x=1772986652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=nX2bclafZqOMOVtfrKaGWpB+5rIGGpw/NsTGWk/jpJ/Uz2DT1pPIyLd27GmZianEB8
         UpqpmsgWkhP9E2eBiq5Nxss5vnTH2MdpTkhRI/YNOWFCGS6/NBKy6dDtliuAhoyOEEjq
         ksOi21fJB/TiMoKPQxbGmhcG1U4wjh7X8f8qUYpaG604OfaTPrrSVS4IChFzOfn/o9FD
         5PQOdyzKBIlj5h0orc7bD/RuB4aocbNEeaRAvByxOajDR5wiUJ53bC3zOOtwDfGcdbDl
         zd6Q8/nHDBT0KAyqbF+JjernTFheYy7XKIaf9L4uWndsvBsk3F891pOcfZUmMx03gVxn
         hTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772381852; x=1772986652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=bvm8OOudTsAl+EswT2wM0WptKQ91V6/49K6oM01cxjlT7+CxqSxZaU2a9imr0VWxoG
         2hafYaRyGVDdetUDzlQ7YmFDyeUi+aHHYP8Uayn5cPkMd8lYoljCAuBu9wytfmjX4/AQ
         MG2dtV6lsAFoK00lBKJ0TCn9kJEQRYieqLrigjI+WBmo98BRKjqzT5nbH+m1K16bEyXh
         zD7Vyt10TzcImzPv6qqJSOzgo3WBMT5PtOuMUmBSaSypnSapvPAXgb3yBnl/VAAUclAS
         QTHrWmi+ZN2wNbseA73x8nFX1eq4g4E/VgiQxN63mOmX7SD/IJACfmlbhuSXFL8AOOPH
         399A==
X-Gm-Message-State: AOJu0YwOWNk3MDfWvLKUd6Iylth5yqAJZiGF+qsYj9fz+zYY33+5DmUU
	LGCHOXN/l/aGlxkmFItMJHd2TuIgoowTWDAmvWLxNmtnPb5jSyhoiyS6
X-Gm-Gg: ATEYQzypSwKnFKyXj0Le9pzZjqNO7n1GLM7b/Q9/mAamVITM12i41Dg5hcoQKOKEnx6
	GjPJx4L2VI8yx9AiLyuaxsYDrXXvumQDayCmlwdBOaIU0e6fZJtzjGThGGfKlUtPcNR6s2ALqJN
	HdzWaPBXVReDR0Sv1vrHiMUE7MCkUUJJiuh1KKLcimZSZoyDhF7Y2NxEMyKwFNX/QCBkeBEhSaD
	eAD+6jUSUSngNDuQFZBms2blN8p/SA7Ur5jZ/tyGtJQB44At1jH6yG8KSG2HOnW5ZanroyjX3Om
	tXY+aPDDJgyDg1hH3CMZNL+Me3XMO3NS4NuSjjbidS6hqgjGJUmz4OrTCXgEmbBi6vF2xH9R2ne
	gPrd6QaWlILNm147ym30aUU/Sp/VFB6Psfcv3Z3T6kBAxqKrqY+T37bd1VXsUUHnECQYd5BJHZD
	DHYxCHgoRgrYHWeC8H1h8YwoCwdW6/dSOKvTGDLbZ2Jik0l++LWEtklKg/CUGFVA3ryto4
X-Received: by 2002:a05:6a20:7f9f:b0:394:8455:d1a8 with SMTP id adf61e73a8af0-395c39eebb0mr11167907637.13.1772381851706;
        Sun, 01 Mar 2026 08:17:31 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm8651456a12.11.2026.03.01.08.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:17:31 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v6 2/2] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Mon,  2 Mar 2026 00:17:09 +0800
Message-Id: <20260301161709.1365975-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260301161709.1365975-1-seanwascoding@gmail.com>
References: <20260301161709.1365975-1-seanwascoding@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262416-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: C5EF81D0914
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd..79ca19097b2d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3145,7 +3145,6 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 
 static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 {
-	char stat_string[ETH_GSTRING_LEN];
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int i;
@@ -3158,10 +3157,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 			       ETH_GSTRING_LEN);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
-				memcpy(p, stat_string, ETH_GSTRING_LEN);
+			for (i = 0; i < QUEUE_STATS_LEN; i++) {
+				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 			}
 		}
 		break;
-- 
2.34.1


