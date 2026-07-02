Return-Path: <netdev+bounces-304296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nstjF1T5RmpygAsAu9opvQ
	(envelope-from <netdev+bounces-304296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E67FF6FD801
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lX93cbx4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304296-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9737302C371
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F81F3CD8B8;
	Thu,  2 Jul 2026 23:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AD38E5DE
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 23:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036240; cv=none; b=YYy/7H/iLknboamM6LPVSD9G0X+sgWATPkkFopeJxTXlcEht1+6AdsyaOrvhSj5QVznNNY/jX+Db4d/IKMHu7CSCPuPUYlM9XpYYU/wQtH7GOJTiWWQlzro5COybr2ohmKe2UemW6IToLscLfuft/aOf0iTxMOkNAWVZuc8nU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036240; c=relaxed/simple;
	bh=qxVC+PhAdInHEFda3IbTj5Vu/foDrosmc8KQKtJ9tv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQ31vEQ2MDM5SRHCd+I04V2UreHGrl25DtBTXK5jINml9qtOHO0wBT5WjPA6Abh4twrJxHEIq8zF6KM2bc3JNuqrnl4gEDpwzq6MkxyMBCAdajTv38FMNPglFjDT2WZzRA7agjnvyKy3N6EG7V3cju1thGD1nXsB96ZQiyde8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX93cbx4; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cac59f8b64so7712735ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783036238; x=1783641038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fw5m2ZAAuYdtnFzlSxNxzYWs1oA4+6H1+UmVCec80cA=;
        b=lX93cbx4Vfy77WIVaOfnXNBZKsECaEIEw/DB4/WAtbuxO09+nCLwpJR6rU+IwefZ8g
         FkBAigWY+zelwEEc20NTg3/NrN4RCmggcaMqR6fBhi3ttcex6pr5veYvf1vYJHSX0eYR
         QRTvnCwSbCinWyqeUxHVU3bMs2WdkObn+iDvV4HLMnhxJbjiHktP60N3m4Eaw9PcVBx5
         8tjyj26Q/jZnHp4TGcZPJmlvOXL32V03rN9v1v60fRPV5zUB7FdiVM7Rk0uMGa93n+Pl
         hBmzH31Pew5ILXA0i1sPnByLZ0f0mpMXLegV1yk6d0ZeKx/L57FZGTvrMDNy9dFsnMPM
         HZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036238; x=1783641038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw5m2ZAAuYdtnFzlSxNxzYWs1oA4+6H1+UmVCec80cA=;
        b=R+s1n5nNAaPAedPU+lubT9xSZuIDT6Cnwrl3zuA8YD1SXbSNxHpqyyDVbpfNTF1mdf
         KRLAS2dlFlKqxYQ17Ojn9Z5KB5axaYmkrR10T11ePF34ZLjWJZLOz6YQQcHdusdKhNIh
         Hui7rJAlv1f4aiquAq7gyON5julrqSwHj5Md2vd+QwCVWC/S5r0P5++LQkt+DGRFl5sc
         6bAT0uv7mTo7xc96HSH0//WF5KEgh/rTYu9mrNb0ft6Eg/t1LNo8UDBLQ+iXfuo9c984
         f36kAf/n6H22nKunQ7Ibhso2TEV+qx02Pb7fbmiLj4R16FT7pYDjaqYFmeBfHc2J8Ps9
         enxw==
X-Gm-Message-State: AOJu0YzetQtNZ5Q3CVGucDWYBikVKOK1HWzJDEkrjocD2dp6ZqJGMDxh
	3+tfBU7QoealGZ4ArulP86Max2afFXay7QM6YTCpj4jCp1pmlQdooHdZ/9YToA==
X-Gm-Gg: AfdE7ckff0tpD9kVdujee8OzCx0AtP0/1OC6EPjCpnIseYhI5NCrPRVYoN7YHYdFaUc
	LpXwXoQms9Ulre4wLduUwUt0hyXD/LsJK3VmwP01ZGsZPIgYZNRzE5EN3lNvmHVSJ321aAyKthq
	vs3EfBrHlqz6SGySfHqsXXXTuYAg51t6SgjZc0g0Sal9ygQJ3JQnU2gnQs1gnaRV7tYzVfC1YJq
	vAHBckxMylpZi6lCUTG6Osz5r8fdLwaKbmGwEl8vWKGDl8blZSlYAKNrKj9Ztxv1fl5CGHbuZOW
	HnWWeBo2+WwPjNInVRIAtG4QWU2ma/hEdpQKtE7z6ubG2pC+nFg7sD8gv23DHTDTQ5O/+Cz4MXz
	Xo5TLN/enqJoqt+HAUd4S+bgXHj/M8OyUQqiSvJh/ys6yI9A1ntlUl8gFT8SDEcVLsYPjISbCCB
	FRSezDH/dmQsgVOaFhPAqAhNiFHYo46K1gGgmJ5jB/TCIGnDbMtK66B6GM23EUoKQSqYbYHHv6m
	PWZLVhfGg==
X-Received: by 2002:a17:903:1b63:b0:2ca:c84b:c4a4 with SMTP id d9443c01a7336-2cac84bc83amr25332065ad.28.1783036237960;
        Thu, 02 Jul 2026 16:50:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71328d8sm254825ad.29.2026.07.02.16.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:50:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: emac: mal: replace devm_request_irq with request_irq to fix probe error race
Date: Thu,  2 Jul 2026 16:50:36 -0700
Message-ID: <20260702235036.1325731-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304296-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rosenp@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E67FF6FD801

devm_request_irq() is a managed resource: the IRQ is not freed until
devres_release_all() runs after the probe function returns.  In the
probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
while the IRQ is still live.  If the shared IRQ fires during cleanup,
the handler accesses unmapped DCR registers (crash) or the already-
freed dummy_dev (use-after-free).

Switch to plain request_irq() with per-IRQ error labels that tear down
only the IRQs that were successfully registered, and add the matching
free_irq() calls in mal_remove().

Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 43 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index eab7a487bf08..5c3bf05ca6a5 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -656,26 +656,26 @@ static int mal_probe(struct platform_device *ofdev)
 		hdlr_rxde = mal_rxde;
 	}
 
-	err = devm_request_irq(&ofdev->dev, mal->serr_irq, hdlr_serr, irqflags,
-			       "MAL SERR", mal);
+	err = request_irq(mal->serr_irq, hdlr_serr, irqflags,
+			  "MAL SERR", mal);
 	if (err)
 		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->txde_irq, hdlr_txde, irqflags,
-			       "MAL TX DE", mal);
+	err = request_irq(mal->txde_irq, hdlr_txde, irqflags,
+			  "MAL TX DE", mal);
 	if (err)
-		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->txeob_irq, mal_txeob, 0,
-			       "MAL TX EOB", mal);
+		goto fail_serr_irq;
+	err = request_irq(mal->txeob_irq, mal_txeob, 0,
+			  "MAL TX EOB", mal);
 	if (err)
-		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
-			       "MAL RX DE", mal);
+		goto fail_txde_irq;
+	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags,
+			  "MAL RX DE", mal);
 	if (err)
-		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->rxeob_irq, mal_rxeob, 0,
-			       "MAL RX EOB", mal);
+		goto fail_txeob_irq;
+	err = request_irq(mal->rxeob_irq, mal_rxeob, 0,
+			  "MAL RX EOB", mal);
 	if (err)
-		goto fail_dummy;
+		goto fail_rxde_irq;
 
 	/* Enable all MAL SERR interrupt sources */
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
@@ -694,6 +694,14 @@ static int mal_probe(struct platform_device *ofdev)
 
 	return 0;
 
+ fail_rxde_irq:
+	free_irq(mal->rxde_irq, mal);
+ fail_txeob_irq:
+	free_irq(mal->txeob_irq, mal);
+ fail_txde_irq:
+	free_irq(mal->txde_irq, mal);
+ fail_serr_irq:
+	free_irq(mal->serr_irq, mal);
  fail_dummy:
 	free_netdev(mal->dummy_dev);
  fail_unmap:
@@ -718,6 +726,13 @@ static void mal_remove(struct platform_device *ofdev)
 
 	mal_reset(mal);
 
+	/* Free IRQs before freeing resources they access */
+	free_irq(mal->serr_irq, mal);
+	free_irq(mal->txde_irq, mal);
+	free_irq(mal->txeob_irq, mal);
+	free_irq(mal->rxde_irq, mal);
+	free_irq(mal->rxeob_irq, mal);
+
 	free_netdev(mal->dummy_dev);
 
 	dcr_unmap(mal->dcr_host, 0x100);
-- 
2.55.0


