Return-Path: <netdev+bounces-288134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EsR7FwJwBmp9jwIAu9opvQ
	(envelope-from <netdev+bounces-288134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA5B5483D2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27B22300651D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86F3242B1;
	Fri, 15 May 2026 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYtUDnmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6C237180
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806783; cv=none; b=hPSmx2lmiTCwwWbn2u3JFrrSZKNHMTI2IvUNnTy4UShmBkCNYJgpHW7nJ0pnNRqsSQRplfuK+mbTIkvOUPiBUZjXKbxA+1j0SxGSzlsu3UzLu8qdQtG8ZhoGJEGYy/MXdOL+s3tbZqw5ylO1NwUL6zTkUtc2GDj8PJueN0Cmiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806783; c=relaxed/simple;
	bh=rm2HA3x4dqd2vGRdxVqOiSzuUJe3RlxpzHV81yHGxMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtSSez/CvdcpahBuejsjFHrKVSSYBz30aCDyrTGNx4FwcNkZ4oZbUDV7GGI2EtxyzXJi7pqxROa1wiUVh3fBR+CnIKUS9dh8vM7jq2Sybe42hRcsTx8Hpkyu7fm3ePwR5F6DlRgMhtKWyxNH1U2AJt1Yw2jDdVNt5leMkottCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYtUDnmv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so1372909a91.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778806781; x=1779411581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3gOPeipVOxDLwg2pN+k6r+Ha0dLMsKEUboNPSsSA9Q=;
        b=cYtUDnmv/QI9v1ExENVTN/xVzPx+TiPfzfxZIsgkwGcV5dxvlzXH75imIQVQ7JaZuf
         MRAPwYpVHWP0OqR/amG5kYfbd03TFqIoA3IsTqsgf6FTN0xb83RrYzgkmgTVlcNompen
         IZ7aiMkkz1Zivycs0CLnHwrCnEeZ35qIPGjOnKPcWtkUS7ZmWlYH61dEP8umDaPsm46v
         qP8/g9IAkMGWzEtZ3w43+t8/+TqoZhqO0N47FK5HKZZj3Hna2GBZipSAmuUpBLahlEvP
         oFiQaPYSF69xUAPWt88BxBd5e/W/j8WwUazdo4jtz7RUJizhYjzJDTMvURWLrTN0+9w6
         G9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778806781; x=1779411581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3gOPeipVOxDLwg2pN+k6r+Ha0dLMsKEUboNPSsSA9Q=;
        b=JP+/Mvz4mTHWoc7F7MENLGGwWkDhfgVd141f06+O6AzbCsGwPZ8DmmElLgfGja6Wgf
         PMabEVoCM782VPveHX/PufnBchIxY/29aOJ49Xk64s5uG1Ti0zPUiogSbgm3sk3YLsu8
         8+kImwcmeRjV/lgu4PkNcKmWIJR1VMTtiAhUmpMB4On/KRwJy/e4eu49Rd000K3IACSF
         qavbOWwxoBSIGXA1IFzYo8wIdqll83amTK5z0uTNqjoWGMNIMm84/tAnasK5aIqSkE+P
         IyLf2VrQdIt8N/PCKeOFBtEFd/jV3As4DIyt0UO3+deUTDuj/6VxhbOBTYtgECphfKea
         VEoA==
X-Gm-Message-State: AOJu0Yzp6lu9xrmL6Am3Ys5KDlaQyF3Z5ThNHEbIuwStgW2PvHM3nl8Z
	968jNI0H93b8/qI/fBTebgXtEVG1lwpjjcFmhv79EwGd/7kIwdSRQzs2duRlSw==
X-Gm-Gg: Acq92OFllgOsJHcN3pAK8sMBmeI3h7UGnXg4A7MezL3giI7ncGcbZSys9dQplzD6q8A
	aVohGNOib1objePafK7WKN7YOjpSmvzYaw8nL4ClP+rVb5xLT7cONYZRSBfk6hJY+L15Mumcsx7
	yjWZir//HY9GVRUIvkYskRj6sm3q+EhAZlKv2wmLt4ZzMqBHT19eN4N5ZKm3pAWviEkC/tEy0Sh
	bfourP0sCf502VYu0D9L9Jx5wg4HqMK5H995C6xJ+tr5zBDr+V33lCQDFsvEy0G8A/TIYDuvvi/
	vumeLsufH+aOmU5UfnuSk/Xe+CUmkG1MxFvNGaDGk7kJrRkjrVJ5czD+LzVrTYXPDdFEulgi6Gc
	fifnq0OOUK+31k8EVMUguBKUcA0LoCGy84i1A9ZdH19AXcBt4oTnOJ66T1ONz4Y6s/BgTs/cQsX
	5n9JAq9eW+CB+PuagxhjSmDcWQy8J3o6KqCJdp0+57FN099n37RLI20nhiCHintjjw385swQnQl
	Z6wrdSF511JxMOCIT2E65T+J4Y7hP4qGD0=
X-Received: by 2002:a17:90b:260b:b0:35f:bb33:d728 with SMTP id 98e67ed59e1d1-369519f37damr1774252a91.11.1778806780987;
        Thu, 14 May 2026 17:59:40 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f30bsm45736545ad.16.2026.05.14.17.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:59:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ag71xx: check error for platform_get_irq
Date: Thu, 14 May 2026 17:59:23 -0700
Message-ID: <20260515005923.14644-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BAA5B5483D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288134-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Exit probe if the proper IRQ cannot be found.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index a5ab99474179..4e4794c4dfdc 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1856,6 +1856,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ag71xx_int_disable(ag, AG71XX_INT_POLL);
 
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0)
+		return ndev->irq;
+
 	err = devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
 			       0x0, dev_name(&pdev->dev), ndev);
 	if (err) {
-- 
2.54.0


