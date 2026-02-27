Return-Path: <netdev+bounces-261640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F2HGrjmoGnDnwQAu9opvQ
	(envelope-from <netdev+bounces-261640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:35:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45101B13FB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66856309A626
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609825FA05;
	Fri, 27 Feb 2026 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6s8c8x/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52126561A
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152462; cv=none; b=F/hsOE112xmjy+HeSY78Kle42UwPJQgMG1chLFO6jsbL9CWr+ZJzJTrLyBg/iHOIucKQOVFvD5RqqDSE342IS2jKIbnA8q99HaJK8Wazhz/pcdm1N8MUHUMskKxapvup1w9dzmziZogLFYu4Z1nmB2U9RzICky95f7XleQ0QyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152462; c=relaxed/simple;
	bh=N4yPuuy9dEd0lz84y4EEkyW2ZpsNmv9NH115pXJEsVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzR96u+Gi8s5hzF97sVzrvUtcS/DV9tN6dZpa5F/okAchUB+1vQCCPIgtdCm+68sYcpNQSk5hF7iB3QngW/mpGhot3tFt/xNwqnR7D4tfG+AYooO0MKXoOe/342uvGOQOlvp/SLE2Ygo7RLj3lyZ+iaYW2ESppHItHvQD+2Y0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6s8c8x/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8273eb7798eso573989b3a.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772152459; x=1772757259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmb/RhvOUXEmhKFmHKG9s2hKAsWxrk4L3SCy9KlUiRk=;
        b=O6s8c8x/UnhgDz08hT10oZmbVZ3c93TrMLndrDK43sI0QpMVIVs600yJhNYnZRraEV
         Al4rbJidsLVf4SmbLTN/ZYuCAQp0XwFBF+bNHgxxt9b4OxVPXFSmf0SHRlWka4388f//
         91Cdc4/O/nqaNjHGme9tnAn/hbN2jcDhuFVvJcLhoate8PEdHwB1jKTkc3XKzeVDsHJ7
         XuU79dlIpb5RTfxd8OQxoaj5guoE2p0rBHZw9wmiDgbHoW54BVbvtm4Jrs01bas3wlw7
         hKa+AHaSzgUHd4LeIaJnLQm6ibKezmxffmER4psKNm6CcsPwDPTq2ZCvv7C55dqDBMS3
         erEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772152459; x=1772757259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmb/RhvOUXEmhKFmHKG9s2hKAsWxrk4L3SCy9KlUiRk=;
        b=xJ/z7efOB9m6W7cw4jMl9OU6KrbwRMOwTw/4JSY6SlqBV+vyOMF4LVbZarTbyWd//E
         Y8Jr996f4KvGZ8CR+G7ZawMpShTo/ZFNOoQG+Vaojl4NE0iYI1oGrRW3fESBiNd5kSnH
         4kmbSwZBd9WCVhs9j3CrtXOBeqOU6sCLfGEvjXkmOEWtT1Q22KJzvNPA6g8FxcmC4oqJ
         PLjlhCh+urYjUhQIaGgApVnBGbVimkpy/KcAMNjMcQypEbr39PTA0KPpc6nrkCZSO5MU
         4+0H5qs6j5NGZpn9nOinXNxLF9LYdbCUneSilQO3YSzUAVMoMkkKFYOqxPy8FUbeGSwp
         pyGA==
X-Forwarded-Encrypted: i=1; AJvYcCVF6GIgeoIQ5eaEWN9wDexA/qqU0fhRfR4qCc7iWTnJaqmS8HWbHWUWTtuqv40GQAIRljO9eBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJRrHcSQ1hmYpJSHRokLgMJnKujHSEpVcz6UJtD+4Nvcl+MM5
	mkUNbMeAhdjChubsXqXSdeWRzrr3K3J4z3x1XZkiO+qEe7g3HflZh7p6
X-Gm-Gg: ATEYQzwqS/+MNuc+RgEncp2gffalB1xpG00Tgy9cgK5OswO1QMaIsJA7WLzEAcp0mT8
	dH0wub2dWTqwvKg7sv41H06p9SLOfGfXPaLmyJ3u6CK8zVevVXg4h/MThC2coqgTdMF4hdGbT2J
	2iXvWliPJW6VZHGM4PJ5UH3wmCTyC8O9SmxzHSbALnFaHZzyV+INs+uuwXkVhk/laCW08QED/TM
	z2kEPSeNgB64rPFXKGtvtX4kY+Bj+r5Uulq9qKI0S0/fUSv+LF6KTyGDSYNjucaqQ3CuV/lnGXE
	Vx3yCDoRZDwAcOLzfyHs8uNC3uynMiOJIeORfKf/hX1ftSAoMVx5G43W9RCH4poBL3vhW9Xntm8
	2oy0ARTC6UR7RSftf/x+CMYAACTa0Y8ImXs2VA9K+fPOq1qiRaWKELR10V53KWcXWvaG8bLswXf
	p9zSbgW9Kwm9dTvRiUWHCxQg==
X-Received: by 2002:a05:6a00:b47:b0:81f:52d9:5fe with SMTP id d2e1a72fcca58-8274d9f53f3mr950956b3a.33.1772152459422;
        Thu, 26 Feb 2026 16:34:19 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8bcb2sm3328360b3a.22.2026.02.26.16.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:34:19 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 1/2] net: ethernet: litex: use devm_register_netdev() to register netdev
Date: Fri, 27 Feb 2026 08:33:47 +0800
Message-ID: <20260227003351.752934-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227003351.752934-1-inochiama@gmail.com>
References: <20260227003351.752934-1-inochiama@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,antmicro.com,gmail.com,jms.id.au];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,lunn.ch:server fail];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261640-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C45101B13FB
X-Rspamd-Action: no action

Use devm_register_netdev to avoid unnecessary remove() callback in
platform_driver structure.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 829a4b828f8e..67ad1058c2ab 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -232,6 +232,7 @@ static void liteeth_setup_slots(struct liteeth *priv)

 static int liteeth_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct net_device *netdev;
 	void __iomem *buf_base;
 	struct liteeth *priv;
@@ -282,7 +283,7 @@ static int liteeth_probe(struct platform_device *pdev)

 	netdev->netdev_ops = &liteeth_netdev_ops;

-	err = register_netdev(netdev);
+	err = devm_register_netdev(dev, netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register netdev %d\n", err);
 		return err;
@@ -294,13 +295,6 @@ static int liteeth_probe(struct platform_device *pdev)
 	return 0;
 }

-static void liteeth_remove(struct platform_device *pdev)
-{
-	struct net_device *netdev = platform_get_drvdata(pdev);
-
-	unregister_netdev(netdev);
-}
-
 static const struct of_device_id liteeth_of_match[] = {
 	{ .compatible = "litex,liteeth" },
 	{ }
@@ -309,7 +303,6 @@ MODULE_DEVICE_TABLE(of, liteeth_of_match);

 static struct platform_driver liteeth_driver = {
 	.probe = liteeth_probe,
-	.remove = liteeth_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = liteeth_of_match,
--
2.53.0


