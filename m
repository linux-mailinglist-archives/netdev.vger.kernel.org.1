Return-Path: <netdev+bounces-304295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zqJhEyX5RmppgAsAu9opvQ
	(envelope-from <netdev+bounces-304295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:49:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D56FD7EE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:49:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T3W+L1OI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304295-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F92E30376BE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 23:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFFB3C5552;
	Thu,  2 Jul 2026 23:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603B3D6690
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 23:49:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036167; cv=none; b=sEKyFzobEu1s6idrudaqFjTnM6BaAmaa54EZzsnh/Hc0bem/wYPoZPCyaf18zCzekpKRkoDFFMYz9LNma4SEjAzUPKgqhxSF3AiKxAJu68BqxmeD+Gx6wfS4P+vNdcpu2779FtTKoAev5rG3Ddnz0aCI3c5dP+xcJPDFC92swfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036167; c=relaxed/simple;
	bh=doX389n8K7+EKbtxiaaYl/YtDW572qKPo/iB6zo1yFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwgFnpzeDH15X/0ywX8eid6F7hP3zMHDIqjYfg2Ll3T7l22HRc9MkNf4Bd5ZsWaE2O0TcJ6cvELjbmE6dfOJcroZUJrKsxZ8yOKbpaCwF4WQ0s6ApjJHhUX7yrqgaVtnaCMJ/LIyRAiFDvVpVswyUs1x7oCE/Sw7CPjuE7/+4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3W+L1OI; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84783bce476so2551833b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783036165; x=1783640965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdBBLcrrIx3KkU6UD7Sbw0NALh7R1GJW/BFDUTsfhE8=;
        b=T3W+L1OIz/D5phUwzO7Ux8kRAWsQUtRk8hJnsgGxx0jcfgiCBsfrl72yMKSuoMiIOl
         zBxq4KoPk7+vWnhaB/Nb3yt9A6cSLZ1jL942FTwmkbZe29iJLxTyPfARUOQzexzxJStZ
         lG3zKMT16LTrDV6EXJdxCMkWQbdZ4Nsp/VXhhupnqGReRu/wRLW+z1C3P/fKOuTNmyQ3
         9NlmtCGSscbtL1O3Y3wBI0MDvp5fclS+IrFJaL/LceeYBwWHyQZYh8aYXq7+Kg3/9Vcw
         NPVwAzXMqk3LLxNA4P1YryToPkwCqQrIvuo2MMsG7OX/QJj3Z9Lrlp8yHN+XuSt8ztlH
         EWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036165; x=1783640965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdBBLcrrIx3KkU6UD7Sbw0NALh7R1GJW/BFDUTsfhE8=;
        b=P5KK2iHQEVfAHrJ1q8gqkorbtGm3Fk1BwBbSx3DNLiuX0GOsJbEb+mYsRzr69cTFEX
         nvIGjprraBeuceB2k0KyNMnm3aU1UCFIESnWakExGb7kMVS8SkHTZNf6FftYc6CJNhDW
         xPdWsZbBtb9Z9GPSJtCyVpWMb8oNcuczcYeaRY1kAltaLC3bFr81Fm/dCUrdcIfP8hB6
         whK6pu2xCROaMJKBUlGsU6JYHDP0bmY9nO6gT74bVHccgkXiWjGIYNixdIW1Kchxv2uZ
         VjbtwV7FAagh/RN0jpxlfE4lEWHcKrPTORPCu7ETS4O0z7JhBM0cTWkjpa4/KVazYav0
         Uldw==
X-Gm-Message-State: AOJu0Yxsds4gbwJimhwqna9Sl5kMO5+ntvVz+8gfG26+vLtcxTPxEtPh
	C6HyUt49lliYtgpHXW5CYs/6kWQaVXpqcud9bfw6olSh5Umj91VmNUw6Y44rtg==
X-Gm-Gg: AfdE7cl7XWbFnSXrQiz4jF/eI/FlaHzzJYeWFb8I2iQw+6FfhY6Jb2/oIw1qfbo8H8a
	ErImZOeQG0i+EWxjQSPXcmCtNHW2Yltm4zZ/zIBG2CBHaZpSOy687nomYY/k9AhkKX5lXXaGckk
	Iti0RririAktrFIJHhAufR0fSAmn9Zt2CtDVJq5sd2re9xgV+zlTtZnN5F45JZDqisTVHFN/qI4
	5UeKKztISiC0ASCiV8E7CRHSOF7aqD1y0DXUHhvzk5+wSUvQDMJ3Th+dL8kqkfK3aDBXaZvNSFy
	hlnBVkzfDQh+jNzWqbW0M+uemgwBvRg+G9WnTvjPbvplco0isnmivJXfB15NIvUR5WVLOTfZ1hu
	ooN9BNhgTCNnEQoRjCJ3DTJ68N62YipsGf/mXDA1WUO6eOi/6T6EEApZmDGymo8Z+9dHZjcxLPf
	cf+/mM2JAVvl5yRtEnSDGVNPAPN12JM29ZWltDWrPh/n123M2CPgCjjnRgxfQKrdjr+RZaZPZgu
	863Z+JVPg==
X-Received: by 2002:a05:6a00:a383:b0:847:8203:f530 with SMTP id d2e1a72fcca58-847c0795447mr8846973b3a.14.1783036164974;
        Thu, 02 Jul 2026 16:49:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0ec6bsm1849384a12.7.2026.07.02.16.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:49:24 -0700 (PDT)
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
Subject: [PATCH net] net: emac: mal: fix W1C write race in ICINTSTAT clearing
Date: Thu,  2 Jul 2026 16:49:23 -0700
Message-ID: <20260702234923.1320412-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:david@gibson.dropbear.id.au,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304295-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A31D56FD7EE

The ICINTSTAT register is write-1-to-clear (W1C).  The read-modify-write
pattern in both mal_txeob() and mal_rxeob() can lose interrupts: if a bit
that should not be cleared is already asserted when mfdcri() reads the
register, it is included in the read value, retained by the bitwise OR, and
then written back as 1 - inadvertently clearing a pending but unhandled
interrupt.

Fix by writing only the specific bit to clear (ICINTSTAT_ICTX for TXEOB,
ICINTSTAT_ICRX for RXEOB).  W1C semantics guarantee that writing 0 to the
other bits has no effect.

Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 4025bc36ae16..eab7a487bf08 100644
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


