Return-Path: <netdev+bounces-292080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL5JKlFcFmpTlwcAu9opvQ
	(envelope-from <netdev+bounces-292080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:52:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 288545DEBA0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069B4300B9B7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147B2E6116;
	Wed, 27 May 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goyeLwQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C517BEBF
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850318; cv=none; b=Few877KYDlmcsCI2459LK3MlCdnWvoQtic1aePg/z76FMLltFXvOJTe9YmWA5d6PcyJrf2+m6Jkt/jMewSDGeFMNMMzhnBZT4gWlp05ZZBqL1lOmVVE/AkqNkwtUSgFV1cpswcZT5cUAgMK1AWgpSvsfWYfSg5NmqYj9MsqLuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850318; c=relaxed/simple;
	bh=p5yCjBcaxijN8CV+DPtg2iaMb1pseRH3kv2bNayNKqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYi1Wjx0QBgwPelimyuUWOGmecFl+Q8W+Kt0ST/yezyOjw4awKAhe4IT4XprRgj3NpSYi3yJ0V87fhvHDkyzNQ8Lhdhj+OuN9+PqLhFe21rNKLXBuINKdmuam3I9mdd29rPSlBSH2h4ZyGRJd9BYF7osm8MKJopDBXBrRd8s4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goyeLwQ8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso5171743a91.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850317; x=1780455117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5yCjBcaxijN8CV+DPtg2iaMb1pseRH3kv2bNayNKqE=;
        b=goyeLwQ8TXneta6rnrCNcQOnVKlD0tG5q7UGqLhmdoZt1Zr3EfRNsFmRGWcRPrIXEh
         eeMFUlaA0CWzDxusIUKHpRHVZGWY8Wdta55CRHImULgeVo3Isa99LzxjrL6jjcadiNkJ
         9TD1DblJdcOFIFHrnb7SPRp//N3sPf6+UPVssoqu1R9CZHIf/+YeH0RTpePyCQmREWV4
         f1K1Otk09XD/Edahh4fGmUCRsvJZCCP7aQkSvnMRUxHVb0m6rzD0gZPVkpFWDomC5P/E
         8PhNJqkncDRTT0aCFacwZu5bGmgH4NIAmiG+rr50qLmeKj1QiKgN2aUUcKUYz4a5OCq3
         BYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850317; x=1780455117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5yCjBcaxijN8CV+DPtg2iaMb1pseRH3kv2bNayNKqE=;
        b=mqFsF60jeC8auyXv17qSIdEqrqQhojPMKIHDUe1L6J33F8p1X5SOXTiW8cjgiDuvTd
         VAtyBGR49HCVjl9mbTx2M4UuiN+yZNsbD6WWfc+aHhnE1BBlme0T/CWHAjcprK8mzU8i
         vdohUjxZhzhH5PItbefiF66absWmVdR/QRCX6elhSrdm3j0HcyGkaReLVss+RbpBe19y
         O8r9xnCAIRpYU3Q9dIX3aTMfzK5RwEXSImw1PBrs+4LwoFKXFF3ADoDRmrxnYCc+xr+H
         ud811J8wOCOH+2VnNDYawBAf9hfMt0vM/ZTYWrx/XgHNWkfaTHwb94DIDdkpF/TGWW04
         UTtw==
X-Gm-Message-State: AOJu0YzNlTKI83HxcuYiDANuJWXnKQjQKw7VBpdWhknIJ76S6GpRtp3s
	ck81XU3iZ5l8VWRUW4eGw4HECXJWDnLO4WdNsf/IodIzxuJ8q2lYotJtaeI1HQ==
X-Gm-Gg: Acq92OE745h5dytayxvDmQk7tzKk+ZOAWp7fznGCMzGd8C6NqQKsiglNTlbNlmPg4bk
	TXg7NAD3r8Gxd31LhL+mLLBvIRtkYJpebTVqkExyCIYMCJUZT5Zy+17fRnWShEOPnwtE8x6y2EY
	JGK+YuraWqxQUKpj/07tuLyzuljrr+PbvcMKtf9R5ZP7VRuz0VuSWeteoXD3BBBUCV3nYTqzXLj
	1CI+WyHNP1MEkvQg84eJIWR2e1O1/1qA5PIEX9QP8k8T6fdLOhuna15gMr3mYPSEg3ibLO8pAiI
	B4K4Lb2/uWou/Cb29vX/MiWFpPBb2rcagMFGOvQTQ+BwIxIo+dzKdlxRU+iBiBxlOzEdY6dEFvJ
	NRUuold7vBPmWpU6dHLCLaIUqg5M0EAakymY1ZUwy/lv5UKZ269oO1dCMH0pvWalAVp8zHAHR4A
	9lxKVDAFB+UU/Kecb1YIKQwtIYzCbeoEZpdns6og2Au9Eng60IfvZQPtqGxM92YygjOGlPEgllP
	MzaDoc25mos5uU+vXei0wp/X+FnslL3yhRyPvU3WlpNJ5Z39UO4xOzS
X-Received: by 2002:a05:6a21:38d:b0:3b2:86a4:acbe with SMTP id adf61e73a8af0-3b328f39aa5mr20702321637.51.1779850316654;
        Tue, 26 May 2026 19:51:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852057f9cdsm11634866a12.32.2026.05.26.19.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 19:51:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: fec_mpc52xx_phy: Add missing MODULE_DESCRIPTION()
Date: Tue, 26 May 2026 19:51:39 -0700
Message-ID: <20260527025139.10188-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292080-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 288545DEBA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes error during modpost:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/fec_mpc52xx_phy.o

Assisted-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: bus driver
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index d48a1c4d0431..fcead59b0c96 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -150,4 +150,5 @@ struct platform_driver mpc52xx_fec_mdio_driver = {
 /* let fec driver call it, since this has to be registered before it */
 EXPORT_SYMBOL_GPL(mpc52xx_fec_mdio_driver);

+MODULE_DESCRIPTION("MPC52xx FEC MDIO bus driver");
 MODULE_LICENSE("Dual BSD/GPL");
--
2.54.0


