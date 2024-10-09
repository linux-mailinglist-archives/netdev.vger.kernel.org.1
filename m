Return-Path: <netdev+bounces-133912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF199776A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03831F234E3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5E1E2312;
	Wed,  9 Oct 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="TukQrfPB"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D922119
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509088; cv=none; b=XNlGbMJ3rRC+4ItGN5z/PZogb19+1+gSgFFif6p9gff5UJytGaxUKqngZjfFqKvG3CN1EL9YqZuMBMQsF9jf40WUZ66cgw55cdLGbhzB8Hm3Ttg+odUgTRMFjqgMvOL3/y2MemIrA4ua5NHzoqpi9VCBm5V9/CmKRbthlsQNHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509088; c=relaxed/simple;
	bh=XkHTIL5ybZufqNUnm8IrxZ7npMRbQ/hDL0sjfcRz70o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmxHybAvn6DGdihbqX43NisFXR6EUPDrsGB7H0wO9DeMZEme4bIGIqbjeqAwir938ASq40LSfkaIRQoTkflKgFPBmeNmoFmBHtmYEVqAqI9iLnjFx6224vn9JiLASVsjdDwdp+0qKXaKADlwLxsX8t+6OAepTcIf/a42nLlVrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=TukQrfPB; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8DB862C011D;
	Thu, 10 Oct 2024 10:24:37 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728509077;
	bh=a9DXvHVrOAXnUtvjBlxwLT7e72jk38nPPA7GGqjeS98=;
	h=From:To:Cc:Subject:Date:From;
	b=TukQrfPBQlLFwizFZA/1XVtyavcxoZSGqVwIt1b1TxmLP5iaWKOYAMlFxHd15lclm
	 vYps7ONsDoTBMVRas/XJx+yluLwtfXYPVEo+98HMAPtVZK860q3+hQSMNoi1sdJuLb
	 RhXNiISTZ3mF6xZrXpgP21/A3x5/sWCdyK/8XOb3ZlxVkODThe8AITrE800aIT8PZq
	 dcam3poP6NeJZhyPOZpQhR/lbyUi8CMQdJTLSdiVjrniFBNN+zYcZTV2Xx9ypEQ0jl
	 aLORveE0C0NRAsPau3a42qjtD1RsSlJ5ZuLxC4G3k7HlYkR2t7gJ+l9c2oWBmB/mxO
	 XKNnnrbbeBG7g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6706f4950000>; Thu, 10 Oct 2024 10:24:37 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 4BB9013ED7B;
	Thu, 10 Oct 2024 10:24:37 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 476672A0BF8; Thu, 10 Oct 2024 10:24:37 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v0] net: dsa: mv88e6xxx: Fix uninitialised err value
Date: Thu, 10 Oct 2024 10:23:19 +1300
Message-ID: <20241009212319.1045176-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=6706f495 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=1RBs_uGY3QX_kSjkThsA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The err value in mv88e6xxx_region_atu_snapshot is now potentially
uninitialised on return. Initialise err as 0.

Fixes: ada5c3229b32 ("net: dsa: mv88e6xxx: Add FID map cache")
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6=
xxx/devlink.c
index ef3643bc43db..795c8df7b6a7 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -376,7 +376,7 @@ static int mv88e6xxx_region_atu_snapshot(struct devli=
nk *dl,
 	struct dsa_switch *ds =3D dsa_devlink_to_ds(dl);
 	struct mv88e6xxx_devlink_atu_entry *table;
 	struct mv88e6xxx_chip *chip =3D ds->priv;
-	int fid =3D -1, count, err;
+	int fid =3D -1, err =3D 0, count;
=20
 	table =3D kmalloc_array(mv88e6xxx_num_databases(chip),
 			      sizeof(struct mv88e6xxx_devlink_atu_entry),
--=20
2.46.0


