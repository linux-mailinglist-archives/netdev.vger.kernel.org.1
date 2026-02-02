Return-Path: <netdev+bounces-256012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLM4AFgbgWm0EAMAu9opvQ
	(envelope-from <netdev+bounces-256012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:47:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA499D1C2F
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9B8F302514B
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1C3148A6;
	Mon,  2 Feb 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok4fXGkm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85DC26FDAC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068813; cv=none; b=pkxgEsuIDLULKEE07HZGnQ7H9WkzAWnnKV+SUPA52ND/VE9uM15df8oCL7L0NPCgoH0Eu8AUM671womiHIHmIUYUHRtgJlwF/2vHMabYuPIZMc5RczUDUGSjQI8b2cXTiVrvQiDTyZ0vtCIwnQcPcbNaoglVe4rTZJqYVVwB/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068813; c=relaxed/simple;
	bh=PvR9mbxmebsyutzDsgx45mPp0Bq/IZWz1fRx5B7Uctc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKWxA1G/ENjnIqGEq09EASrEQlVZ1dtH5K1bMJ/BAUlMlIPUx2GIUYKw69iib6vZSpdZ3yJfT6Hl9JxUc+xms0rYYrF5WKOmLyOy74LAeT+Q+n8DGGBl04NORreL2WwVRnDvEyxUo5Mj/Ct/bD7v9pdKxsFsXrd7WS1QyrTC0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok4fXGkm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c708702dfso2608761a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068812; x=1770673612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DPWS7e1LxZgNO8RMl5aIfS7AvZ3NEcgmapRLKdI8d0=;
        b=Ok4fXGkmAY9rQ9Iip1cXvzcrqmHwxCIYDUH0K23Oi1UaF+Xy9bOBDFtoCS6D6qIcZf
         B8ps1tv9Mq6hq0IYR+hjAMnubtVcmJEGGaZdbh+/X/j0UQEvLcC2HMN3Xb1Kx/+PIxa/
         JoATphuMbr/b1x8bMUbTzuFTfr9FyQAj2XyrbBaLxHsmuOOd0FFBli4sQe0cmx9gSF8d
         rQ4e9q+sRYuxoJuHR/Ch8EMviuDCtFQQSUz9o+cSwqhl12oh8ow+TruZjoQ9chIYOdXi
         nKtjKAmDw5xkvJ/kaP4jYlpmM5ftbvXT0F/6IhPRwrXYbmEiqXDx5IX3FK/RA75eu3BP
         DRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068812; x=1770673612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DPWS7e1LxZgNO8RMl5aIfS7AvZ3NEcgmapRLKdI8d0=;
        b=Y2mQcldrF0kYLGqno0hr6k/gyJSyTGQx1fYXOOrqrTKUsgfig0RDhBmBdXaoqnk4OT
         VU6C9sk4m94w6d/mBqFhYBh+LdOY8EuS0Y1K7qmPdvzt2JU2fOB/2GCF0h2aCIgqk/aj
         Lkd8zx44+UPBiDFX7O9nJ0825PNLZZNvWvuuNMuYET3NaGjlUE4xx3V6K1PU04cGhh7Q
         TX8AHMSAk/6VMh4lWlt2LsM7fGwy2JwXFLmFkTwJqGLtZM35vn5HVlX2nXkqzw9uuhcW
         wo44ICG+pTiiH8tB5oLMeRloM/btnf0z8IjbJfQQL4X8ByH20oTyl+shyCq0gECurJcB
         A1KA==
X-Gm-Message-State: AOJu0YxKnwl8CTxJvDuLBfDDm6w+6o8gfPkzCyT39yVZPXj6pvm9GusV
	Ht8czG+dudahVQl4ejxW2x5jMr1URE0Ynx+a/3D7f9iD5To4hSYpVGTZ8ifjOg==
X-Gm-Gg: AZuq6aIVjBCOJWcJGq0YpKRU5dZHzjUihuwmlaZ0PrXwTnCul3+hH0MMaOJf95Pt/zo
	yORLJ8zIv/47q1xj3Fkogm5hssbzcyzz71JgmOupKNtZzAXemqLJelaPDF0ZZS0RPBYF8xO45QS
	iz3lLhtmnBLd2kRuFl8sgVNS+qPA3qJ9EAmb+O6GNCmUClpnvzJhWmA8D7YsVT2sdwPLyn+KORt
	O/FvRWhCSUGMdrUc3L/a7gOX0pMPpbhJN7hvtpLSJEdJu5XlcWBeHhsyaiaRbSgd2hEhV5CyYHD
	09kxTT8mqAJdps2HuQa3mhAbfXNs2T+riquC7PuIVv39LzKhARKcptUnuTQctlDPZ1+Or4tLY2t
	Iya2dSfJgnLXrE1uYiLlQXlfJx0hAmYlqYCX1nSUcJGx8HO/eIDtkalnhQA==
X-Received: by 2002:a17:90b:2244:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-3543b33884cmr11754715a91.13.1770068811512;
        Mon, 02 Feb 2026 13:46:51 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547767cf29sm391215a91.10.2026.02.02.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:46:51 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 1/3] Revert "net: ag71xx: use devm for register_netdev"
Date: Mon,  2 Feb 2026 13:46:32 -0800
Message-ID: <20260202214634.72738-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256012-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA499D1C2F
X-Rspamd-Action: no action

This reverts commit cc20a4791641a1cbd1525695fac0d4725dd72509.

register_netdev gets called after phylink_create which has no devm
equivalent. phylink_destroy must be called after unregister_netdev and
not before.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index cbc730c7cff2..f2f12642529e 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1926,7 +1926,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to setup phylink");
 
-	err = devm_register_netdev(&pdev->dev, ndev);
+	err = register_netdev(ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
 		return err;
@@ -1939,6 +1939,17 @@ static int ag71xx_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void ag71xx_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+
+	if (!ndev)
+		return;
+
+	unregister_netdev(ndev);
+	platform_set_drvdata(pdev, NULL);
+}
+
 static const u32 ar71xx_fifo_ar7100[] = {
 	0x0fff0000, 0x00001fff, 0x00780fff,
 };
@@ -2024,6 +2035,7 @@ MODULE_DEVICE_TABLE(of, ag71xx_match);
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
+	.remove_new	= ag71xx_remove,
 	.driver = {
 		.name	= "ag71xx",
 		.of_match_table = ag71xx_match,
-- 
2.52.0


