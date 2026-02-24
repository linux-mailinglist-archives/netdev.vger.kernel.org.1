Return-Path: <netdev+bounces-260297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I+/MvIDnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:50:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C8180BD7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18A43061614
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF04239E6C;
	Tue, 24 Feb 2026 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFkEPnws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E31A073F
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897587; cv=none; b=Tn9gcRFNWsaKzE5BKczdtPSR0GDI+7imlnqMrbslbuD1q/mXxXZc4i9NSp0mMQp48w3FUQtRHjMVexD0v+kjF/USg6I2Q5//DJVqy5Qm1pRjzOHOFCaQQsdaftPGfbPckbvoqALrGjhsaBNErKK18MgVrwyvgQahr+FmYpWsq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897587; c=relaxed/simple;
	bh=iaMUOYTA7AnCj61OEsak2kNSEQKk14QC/a2KWq5udzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTSf/+AF0rm55bJzav+0acMR3MGLugUAwfZAN0/w2Zyu7mSs+Phw662Wk3b6CEo9f2YSDl7igAar+zl7z3Og3NPcZRSvUjTigSGtVHvkKvUSiJ8uELkrfU2vt+AzmFVTKBvgmy3jP0RgiOXt+w2owVazwd+LR8C2Gxq+InJ0Wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFkEPnws; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aad1bb5058so51634465ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771897585; x=1772502385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyCuepEEE5VZwezz+EwCnELSbh3qvdwdxfgg+cxEJD8=;
        b=nFkEPnwsTUq5ewKuYGelc+lI5N7gqp2QWnD2Vkp9qmS3oE6c1KzuEVwBMrVGnjYGH0
         EbzkMMrl/g5sJQxpWFiIX+tGSRYABweVL7RfcqWZGsVgOEsXRD05PFY7Vsv0PE0ghfOW
         fBkmfaNoUioN+L5KeXbFzK693kF5nJLt2GGWEgUBC6c5QrICYpE9hRpb5RQ9JTpH7mcJ
         sBe9DE+J8LCS2/Tosu0fKQy/mj3jetetQP5PVzSB4W20fV4p3xBMdCt3zKLQ90iQlEcC
         sxnxa5jHWACyiMuJshz+2eaRSQ8YppLqJSNXtnjU705Lxm6FYEMQWDyucp5J/Kx3GRVt
         R73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771897585; x=1772502385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyCuepEEE5VZwezz+EwCnELSbh3qvdwdxfgg+cxEJD8=;
        b=BJU33ddspUb5L5k17I+n3+ioX0IkhDTKvut0TUW3T17NhEcQj91IDotwTQ5JY8Kv9G
         3k3RJwlm7oF3bp7WtwD4l5gzwzEl3fUn0nR82PH3k/dl+KFiiBZxhmK1pwKS3lX8luck
         75NNh3lcWJdNEcrr1xydUxzipgwk46poH/sFDu7ubyTFRUFBsPMTQnUg+Bi7E5WdIFeh
         Tz6ZxCwCIyZmsghi81Z8K9XEAQ20adWBN74RJ74GctXcrrpvFQ8izWPo/D+1q6mYKhaw
         lTmCaNpXVmnonGVZYmwphfxbuv2yG9kTktOeDggdPvAAWgKP1+uiDTUTLooppCCUydIr
         6BBg==
X-Gm-Message-State: AOJu0YwUmRPJntIH+zW+80QdP5AfpxAH9xfHhSd+SlX5UdiHRQEOMpWz
	V3PQAC/wlKs7JLto1LHEnzryhVEDp97B16TQBhNf3cqlvhwTlqz5ISWbC9U1ExHD
X-Gm-Gg: ATEYQzztsdQNcO8DcDDH43TOObwXdW9/4QM+HgOJVhKlxITAiOvs4vrbM3b/xQQSVIo
	D8K114Vv09jsu6DFRAlDbCyIj5FHN9CSOmYx40woE1pJmLvNdXA8MPbAPs6QgbsofZWFwOgMzIc
	y5QEc99KBHkGBmWxA5TPMv1QioHMvlhyCRRRIQPYaKmIw/zJ44gZZ5La8TPRaWEugk6VjnU5m76
	BTvARIfuAw2mF3iqGoll8bLUNnDolzSvXEEKosmM/822QKQ5ck0wLTikoRQ/MmUM1kiW7oBApKX
	C7LZL1FOExL4gNOJsr8A7cw4+DRmAsBsTKB0eZsoLGO7g/KIsrnHUd+Pz7Uj4yBXF6Gza0YMwZC
	YB8Mb72vCJqPf4Q0UaxrMopuIufcOYqWc86W/3VPnckVqfou6PBzzu401BBoJfBTRWTQyjamWO1
	Fh9M8eMrkyTUJyYGpKpeEKLPwxEjqvTIIRxFrAQ2BwL49utjFMFMWpzg==
X-Received: by 2002:a17:903:32c7:b0:2aa:d320:e969 with SMTP id d9443c01a7336-2ad743fb337mr101422045ad.8.1771897585096;
        Mon, 23 Feb 2026 17:46:25 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75044c72sm88143715ad.86.2026.02.23.17.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:46:24 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC FS_ENET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: fs_enet: allow nvmem to override MAC address
Date: Mon, 23 Feb 2026 17:46:06 -0800
Message-ID: <20260224014607.353378-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260297-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A3C8180BD7
X-Rspamd-Action: no action

NVMEM typically loads after the ethernet driver and
of_get_ethdev_address returns -EPROBE_DEFER. return in such a case to
allow NVMEM to work.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 2cbcc29408e3..d3c772ed5fc9 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -951,7 +951,9 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	spin_lock_init(&fep->lock);
 	spin_lock_init(&fep->tx_lock);

-	of_get_ethdev_address(ofdev->dev.of_node, ndev);
+	ret = of_get_ethdev_address(ofdev->dev.of_node, ndev);
+	if (ret == -EPROBE_DEFER)
+		goto out_cleanup_data;

 	ret = fep->ops->allocate_bd(ndev);
 	if (ret)
--
2.53.0


