Return-Path: <netdev+bounces-260302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFLEBB4FnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:55:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43B180C2F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82926303461A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3550245012;
	Tue, 24 Feb 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSVfdsA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D823C8AE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898137; cv=none; b=WbljhV69kfYCkhObv1mUSh53jFsEc7qNzxBDMvp7TtOPWUHATy9cO867F78JDxil1cO79d88/G59XiTIHvZXa+/r4EXIfmUOZfXFoeUk2zB/DNZmJUa0XlV1Lz3MYPUBL2BAQ7n+ignLkoPbpFh1THkm2s0JMQ0gkxPUe6sVBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898137; c=relaxed/simple;
	bh=VHzmMmTXp5/YhvAfzzY+RiV+86HXQKgpT1Q1V4NjOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LruXcKL/+vbYgU93TsckRKtkaDddg7MaA/18Xmqm4qZCvSD6/zimVEOlQyjLym5tUgWTyiZE67wltoIEFzG5q62gqDSa6/04NhL8+D89Rii5zMf2OoKfyJPI+LfUIOvUQcdkpjXxBESIR07ntC1P1MpaatNJoF9UP2w52lzRAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSVfdsA6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824a829f9bbso2592138b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771898136; x=1772502936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/kkp9/hv/NUeBmN5Ot4cYQ7fdbIXd84ugK0aulpqaQ=;
        b=fSVfdsA6whYyc4H9JGaQK/4Cggx0blAV1sqLF8UCxoP0cXCkMHUfUsUf3y6FRjxodZ
         cJHW41D38BheJU1WqrwrByR1Q/8GdXGl8E5jNrUIP+rlN1B5aLkxMI+yjfdvsO0LbvSy
         mJY76OesdO8cmpLizr+NVYZNvU6ujIUKZwhqLSuezo7POAX0j2nrZKzIQDmNkgf3rb8v
         XSIqUyzJnNROgL4fiknvw8PafFQGmspVSFu5RweCPTWMUrn8l5hLuAr1lNchHDVAI7Ka
         17NhSsq9k9ByFsSJXj/7bjJExGLDmFqNUgM/iUZ1NWW/lyOQ/pbTtpGmQkMvRg46NtU4
         mceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771898136; x=1772502936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/kkp9/hv/NUeBmN5Ot4cYQ7fdbIXd84ugK0aulpqaQ=;
        b=VryB+fVs6ASYurImBRAodQM822pzqxs0FIYoPozbJum3Ts9EgBz1FU1lj3YRFKkTNs
         eLdZaRYnFKZJzV/4aDgkpRPnQ95FBmNKj0zQnGAicmwQivLozpR4y38gnkuhZVltLrK3
         ITzbQ71Ynr0UEtdG3ElqvJcPcZT+e63kkE+xfshvxU1vCMdkV8e2q7zWOFzZ/J6c+KYu
         /exgFENvalv4N8pa5L5xzenkrYxLM0k89nbhCh/ekKfVbizE6hqQbUYtpvorJRiI70n+
         kcIHsPMM3/PTBMCR9JC9S+nPNL79X4XXi4YG6ASA2AE/C1VlP53ZI8J4VI/WjYE/sub+
         r0Wg==
X-Gm-Message-State: AOJu0YyBeangkmG1k49a6hYjeduHe6nc9/yrv6zmYxQQEq6CABtVdwvS
	U/atff5ApJKU/xbkfz/Qqagt9BxnR1sIDLrACNgIlsBfhWeoXYTrAxEPpaeWe/RU
X-Gm-Gg: AZuq6aLFhBwysHndB5ZYoR0VwFKNA0wsGdVS9+danxt/p5tj2dp1SFjLpa7NK6gtZTb
	5IVrfnJ6xRrKt1YFn8JZ98HaAFwYhEY4sfy63jYNTzE5xuBhJK3eOP9nhKO4D/GsEyV9HcosTty
	g/BLy3jA6e3zrDq+5PTqBWKcG3OsqctgXH/f9TFBHmi8ojOhnuS8GTClqRXFHfoZZ3buJbS/EFY
	cl/kCMmkwQdnQcABrSy+lHivDURD6uwmtbkhnBdTmw3Xzamx9WhuJ2qL2Gc6K/OdKUioeCd4B/n
	yKt9EVMd4PR0jAPNEXUkYDbE2g4uxcqlJt0eqG9xIDv6RzHXjZF9DIsgd6p2j4DntytFFRvvMCO
	KWKUXdVuJA4RJ7uomXTGSiM1hbLDaei3dIgq2hOEdg8uXejxHJzFhqHDVJhqR+8ALCY3/RQhpr2
	xS9+lXlmhD/PU/KMlquBrDw0/SFzWE1bcV9RE9TiFF1pocMU3tTSL36A==
X-Received: by 2002:a05:6a21:b8f:b0:36a:d3c9:efa5 with SMTP id adf61e73a8af0-39545f887c1mr9078001637.52.1771898135815;
        Mon, 23 Feb 2026 17:55:35 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b726ac30sm9278832a12.32.2026.02.23.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:55:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC FS_ENET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: fs_enet: add missing kfree in _remove
Date: Mon, 23 Feb 2026 17:55:17 -0800
Message-ID: <20260224015517.354145-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260302-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF43B180C2F
X-Rspamd-Action: no action

The kfree is present in _probe on failure but not in remove.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index d3c772ed5fc9..ee2b7e8866ee 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1008,6 +1008,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
 	dev_set_drvdata(fep->dev, NULL);
 	phylink_destroy(fep->phylink);
 	free_netdev(ndev);
+	kfree(fep);
 }

 static const struct of_device_id fs_enet_match[] = {
--
2.53.0


