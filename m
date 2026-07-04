Return-Path: <netdev+bounces-304678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CCA9C1J8SGpAqwAAu9opvQ
	(envelope-from <netdev+bounces-304678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 05:21:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A5706862
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 05:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j29vmGRN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304678-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304678-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C972B301B930
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6A2472A2;
	Sat,  4 Jul 2026 03:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86018D636
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 03:21:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783135310; cv=none; b=ud80qJqmRvPwG+I6wbSFOVdlAu1XcLXamYWLUoC9mmc0TRTYRA1HzmHaC430VYJ+63ZTCddozd7DDVmA+jUdoGfcpQ1CCP6U+frBWn/JrlOKgmlaQC8yLNsiTsW1IOPt012rWjKbAtPj5Sq3ALy53Jsl661t57iUk1HuMstXhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783135310; c=relaxed/simple;
	bh=zqA+R6C35xRe5WUaFFo5OrPh/3HtwemsfU0ykzzGyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tN8UtuP980E3I87fZbo441SCb9EyRl54W8UW9jrGfrkzUlIXq49iX0xNe2VntgPtH15lFckf2cWC4PGeKioR242LDvqGr0nCFiq/JC+8ORPzXaNYR+Etm+QG6C3cWuw5Iwr8DaDpiyGww5p30csSHw02gWhQKHA7T0JlVgg3s3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j29vmGRN; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so73615ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783135309; x=1783740109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWCyJawTVqigS93YWuHxtbSx2n5DLCR1Rls5Ry7aECI=;
        b=j29vmGRN+2iVbF2yFW/R8ZZEVb8ihc00iU1pS7hoqwBFlF6mU3C77UCHb1zxL/UrJK
         vYR+l2zNx6ZM9xshWvbpU8ifIfS8HcvwN3ZBZRIl7NgEMu5/OeL06Y1jCn0N3gztDI0W
         5hCHDHUoMffNSAsVIE+uCorDRBoX4j6Jh89IzPZ+4cHNVt5wqQ7stTm+/iHAi1vphxf3
         4Vp7nti3PUPjjWidJKwCOXp85nEFyMHwLLHzrS5Ou/450vBtAi9A7PyiyBo3lW9rByR+
         lmVLbZxmQviMWfCDvp+k1sF+jZzaOToX13/BInXRDLPA4/p5yvHhtClJzO28GYRoXw9R
         TuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783135309; x=1783740109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWCyJawTVqigS93YWuHxtbSx2n5DLCR1Rls5Ry7aECI=;
        b=rikByonZYMtH66t4aYvdihl/yDb3dXfyW//QGtL7gtQC3l1FggmlwYnFeN17k2SNHO
         0m49wXCFuVsWhy4QNmHMJnPlrbyiQ1KGoa/pIkB7m+3HcnHnkluHphPUs3v7NBxuAa10
         AKdqoo8CCCw4Big+AkcEXRwLbqkauvd324PuSMLxV7uv0AE+MZx86IjYPnSYIr1YCNiy
         Cy3NqUhA1FR8flr2+fe2DoH2BWXSGoR3Br9X6sPrWclIeSHXYZkdG20nmrErpphPh6Ut
         7/XEgCvZtAzOJzLWSOvt/xTeq+ZxR+iL7ujL/IvTGrO+oG5l7pK14kFtFdUVbb46lO3O
         ko0Q==
X-Gm-Message-State: AOJu0YxhkpqqAwFdz1FfsDCc4bkvINp+sS5P4G9Xe/Pbj15Jv3ntDPPC
	a72A1Wo4pWOxp5dquLH0y+ufWvO/hFHCosPxanrt1qdYq+AFHd+Z27n7larNcw==
X-Gm-Gg: AfdE7cnr2P5R0MyLJTrS0EgFK/j1gQiL3IFAjYRCwiRP5/Pz3zM55JpXHsyCVWiJS/a
	8cQa8DHDfAxUtHns+IDrohZLUdHvVZ+XUlUPsn05YOkjPzPZSyihHqkj6KqVtxZBUrPu2PeJJof
	YKdx0161D3I12iZYaqKJ9g3IjMk0CFz1Ia08XgFOSlFjwLoUOfyF8KikySJJv60uSNyW47r3O9F
	Mc5U2p9WWUvBzyKs7o0PK6RiNTmr1H4vmvpQNI6G/tF4ewBMgKD4wLEW4+BNc3DUe9KLaaDphnq
	+iLgr7Lba4ZzjhaAgJ2VdF3bVvVCfPg4HrHuOrkhYqDge411t6KtG9oZjYg7c/OcNN98SPMvbyn
	vGfesxo9RNffGmhgoKT3+NT0OBtG/IrPY39yUWEAx/P+OgVll1bdtVEVWRYqQP9ccJp90w48Q0X
	NTOamXbDGUifwq9Ji1WhDfxI3gEAWHT7QkMH++XaApDHqrKxJxsg2Tht1ug4fFDtvSgZfussVL7
	puaKRe1BA==
X-Received: by 2002:a17:902:f78e:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2cbb9ebd193mr17055305ad.22.1783135308812;
        Fri, 03 Jul 2026 20:21:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25cffsm17467585ad.17.2026.07.03.20.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 20:21:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: emac: mal: fix W1C write race in ICINTSTAT clearing
Date: Fri,  3 Jul 2026 20:21:46 -0700
Message-ID: <20260704032146.2307296-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:david@gibson.dropbear.id.au,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304678-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C7A5706862

The ICINTSTAT register is write-1-to-clear (W1C).  The read-modify-write
pattern in both mal_txeob() and mal_rxeob() can lose interrupts: if a bit
that should not be cleared is already asserted when mfdcri() reads the
register, it is included in the read value, retained by the bitwise OR, and
then written back as 1 - inadvertently clearing a pending but unhandled
interrupt.

Fix by writing only the specific bit to clear (ICINTSTAT_ICTX for TXEOB,
ICINTSTAT_ICRX for RXEOB).  W1C semantics guarantee that writing 0 to the
other bits has no effect.

Tested on Cisco Meraki MX60. No issues seen.

Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: mention that this was tested.
 drivers/net/ethernet/ibm/emac/mal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 74526002d52b..e88e4a1ddcd4 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -282,8 +282,7 @@ static irqreturn_t mal_txeob(int irq, void *dev_instance)
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
-		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
-				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICTX));
+		mtdcri(SDR0, DCRN_SDR_ICINTSTAT, ICINTSTAT_ICTX);
 #endif
 
 	return IRQ_HANDLED;
@@ -302,8 +301,7 @@ static irqreturn_t mal_rxeob(int irq, void *dev_instance)
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
-		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
-				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICRX));
+		mtdcri(SDR0, DCRN_SDR_ICINTSTAT, ICINTSTAT_ICRX);
 #endif
 
 	return IRQ_HANDLED;
-- 
2.55.0


