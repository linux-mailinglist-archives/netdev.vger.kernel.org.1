Return-Path: <netdev+bounces-260296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHGvHRQCnWnhMQQAu9opvQ
	(envelope-from <netdev+bounces-260296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:42:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212021809F0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E860A3055950
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3861238C3B;
	Tue, 24 Feb 2026 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/hdayXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537D23C8C7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897322; cv=none; b=S+SjB9EDgRarQr9+A9DwIVZ3rYbMBQKrb5/Muu1MsQbRcwg3g8X0X4AfysGQieiW+z4UE+FBpC07fJHV+np5nzL8c8mueysWe7GoyvIx0qOZGOFvW5z/vqdLXChQsNqslBvyb2WzPlW5sJP8GX9yTy4V9TPPn4TOpJuBV0j7hKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897322; c=relaxed/simple;
	bh=hBkdywxtsFUPUM7u6umnLq05H3CSwtqVcD2QPcX5qEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5qMmufHCQN+am/lsE7X39mLTbzh2S6RyCfp2Qz91QsiXBIqDIzy12Vl/EEcd8xPYEEUzt895RAwNmt1QK/38KoWYSv4VLoJ9oRjHcUIv9LrU3KNcjbPgU6fKhlJSD7Dat8iApdQR0FZv2x9+xFNBr5Zn6khTbHGxYnTDyzshLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/hdayXl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aaecf9c325so31055635ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771897320; x=1772502120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6P7RESrYIJDhZprgcR69A/7lKYelhyEQG3ywd9xm4QQ=;
        b=C/hdayXlq0ywcPHiSnYom9B0i9e+Ysh/6r7tn7C7GytqU+JLLI2Wxxt5ibvj/cipwM
         jC6im0F5GwHBHhjaSGXuSarO8MP8kTLL9mL/HBH30xywQoTPjjNrxBx/bZuhrDIKBfPG
         +2XRd+R3XKbby0OLpKqMcmKGeivVcZ06JljTGM/2D2K13f06GowfNyVlWpn3H2SsMDBc
         wMHc/REq2c6OcXSC2IVs0t7I5EP8W4eP0aM3wtL8LC1I5Jk1xj4C9T4TpR8z1pCc1m1n
         mxVXT6brHXjz1gZcpmpu2TkgkwBb88FMvtDc5upJBKLmhx2lLnbN9Dyu+B1/hHFKcOOL
         mgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771897320; x=1772502120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P7RESrYIJDhZprgcR69A/7lKYelhyEQG3ywd9xm4QQ=;
        b=ek46tRLQn1C8trgK1vaGoUR5nDX6vnEWAzZE+RbMx3wZ/dpnk2+v5FVJa+9Q7pOXni
         hO926jgTD1Oyricleey3el5vWf9W4c45cZ3+Vjiq04XndBTyfz2xY3ezFRWGu07uJWWN
         i+VQiYhmmCROqgqTZLf8VRi3xlW/ZXNM8gJeokR0Anr93vWt34RgzzL9dAwegeonTrfh
         t3xchP0Puer9NMIXvZ/aMTsY25CbifEPfXc8F33GfZJqz+livI2upWBalpryWEFpdm4e
         pf8X0s9pp9a8/VPXrP+yQVzwijSYQGI9jXsty23tOg+A5HHbQdQ1YX2eTd+asnJkGAPV
         mRhA==
X-Gm-Message-State: AOJu0YwjoJGqSu+MeY2VhxppnMWESROcoTZObTCiG0Oi0UAPKbo2LOi7
	rUjpiWeXtssWCq7BDtU5GUah9THX0ml+7qxI6E71tl+e0z2K4SlUWYZoHF3e3Adt
X-Gm-Gg: ATEYQzxLZ0npEQlLVUHTICvZT7WVFZlwSJ2IBoxKTrCWe8IL00hCtZwYNc2CqEBxIGL
	ge33xubY+2NF3cqunNylyz7I+ID+jVDFr2d6a3ECd2C9Q2ar725dzESBVglIh65dlxCk3JcQZs/
	oCzCqYGL19bTlOmvHJlyhNPU2BiQxY70AOsYV5NL0yhcv8eFUP0zuTQm+OBgMikq9kKIWp0CkmJ
	eGzbZV8BeqAXX9dMDihlbimLYr4MZTEYhR4aaQf68K9ZC9J9Il58hGKEe/uGPnlAj06hJFm4TZz
	OS0gxNn+yl22dtqITTq10IWOcZlKTsh6KU7zAFybg+tIHsLrnPChxaMqHee/F2v3UYhmSlYfWhL
	HMD3FzFZ5NumUYqcH2dV9whXVe5IVT5mAdimiti2PcDL2lrUHZNEVO8w68M83Rtl7sx0v8wigJL
	GVUiGuxB5t+kcVNiBRwzP/jHewjnVLeiXbKoanNwaT6NFuSiXLi6YtlA==
X-Received: by 2002:a17:903:2390:b0:2aa:d327:beff with SMTP id d9443c01a7336-2ad5f701d04mr164763405ad.6.1771897319835;
        Mon, 23 Feb 2026 17:41:59 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d79bf6d8sm367577a91.2.2026.02.23.17.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:41:59 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: freescale: ucc_geth: call of_node_put once
Date: Mon, 23 Feb 2026 17:41:41 -0800
Message-ID: <20260224014141.352642-1-rosenp@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260296-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 212021809F0
X-Rspamd-Action: no action

Move it up to avoid placing it in both the error and success paths.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 78d72409b6e0..4d598693d7a6 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3470,14 +3470,13 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
 	if (phy_node) {
 		prop = of_get_property(phy_node, "interface", NULL);
+		of_node_put(phy_node);
 		if (prop) {
 			dev_err(&ofdev->dev,
 				"Device-tree property 'interface' is no longer supported. Please use 'phy-connection-type' instead.");
-			of_node_put(phy_node);
 			err = -EINVAL;
 			goto err_put_tbi;
 		}
-		of_node_put(phy_node);
 	}

 	err = of_get_phy_mode(np, &phy_interface);
--
2.53.0


