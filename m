Return-Path: <netdev+bounces-105048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9F90F7DB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ECD1F21472
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBEE1607B3;
	Wed, 19 Jun 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTKI+36Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89C1607A1;
	Wed, 19 Jun 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830395; cv=none; b=Fim/p2lqIRfLIC3Jm4RhuWrOK/+qr5R9a7t/Kn+1hZBn87INgxeJAN1uWtGtJXIf4x2ukVorOnncCYeFWlulQos6L385BQJ63S2GC9kgOADTrt7wpDcoP+4zhotfvdTukyr/HMtGLdBdIeWzPSSpidrEN9+EJ3YslLXmKOmgYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830395; c=relaxed/simple;
	bh=piMpn80KOshkTU6/pXdrulYsKtq3xcP8k+hICu88tb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpvtCyKSea96Qx1NKn5s31fIbMeIvN4N6hDRSY6EVmiWHzgd3pAHufiG2/OcLu0RZzOMtdXDjdRRQ9Xs1C8Ha110bEbPh/HNgShnTuDNPhR43g4CGhqdw1uuthr0ItqRzndG4v41dlfsAUrSsUBAVIKEOJbEDbAOyZOjQHzmUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTKI+36Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso37706766b.1;
        Wed, 19 Jun 2024 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830392; x=1719435192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G3r/gAHZsDuNNRJGl63lYwVrSC99qfQAkGfOCSEZGk=;
        b=WTKI+36Z+bbCc2j7ZknyndWPZK78NcDqMpZ+ENRt1C8rcqHGgexcxzfYG0uHX1jsct
         fk1gMnyGNLj/Peqe2iWPB/G3YNmd36lMpUiRYxE+7PzMwkC7M2CnYFmZ4gF1/SQR/ZGH
         bcOBfIOZ3gJMhUlco3krzAboeVSBN9k/ApsJ/VYRaHTBdZwxPoiK5ekTz8od6FXzPj16
         +NBtPhDHZEpXoXede5DiU1C7KENf3SPjUWDzETQLlIwuRcimHSd2cK5qdfK51sPdnUEn
         AEtZg8FK1Tu/T/qDzJ1/cbXqogRlIVA8JgQv/mhf1GPYiucK94nng/J2wXYLhtVwOHTu
         dyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830392; x=1719435192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G3r/gAHZsDuNNRJGl63lYwVrSC99qfQAkGfOCSEZGk=;
        b=ddgp3UyqoX78Bm0pIwTUHIhF63+dV6bT0SN1UOBjEdQQcsAHEov8S0Qg8x4Jwx78GO
         QF+e0rY1eUn5CB025KGwGGHNcu7D5aOCzzIe07+f8xKJ7r178bWSx1sywvniEiYVykAW
         H9Gkkq+AoagZco2Db/4a6bUbe4tvlXE1bZD4JLdfy1o5+pBhZT97AASuOotrQtqcHefe
         Ty+7hzPda6esIJx4PLs+7qMoZxaYvGFdg1FeYsh4mf1c8OXE5ttCjrwKDWoupj/5f2TM
         cq/mefqaxTEqER3Qz4GpHcF5KeYnzJWMJrs43ZBEFKm9Ig8CGYVcuCEvKvw0QBAurXiU
         0usQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD99Tl5JhQDBgnc12JLbyON1jv+NaS+AoVO3cKewqfLgTGrYEW/vMzwV72Cl1wRT6LSkbwFRGDlExtlQqzWxNlkTZTdfugiuKpmOAb
X-Gm-Message-State: AOJu0YyxLsFdHyWDPgOgGAJFX13En6YJFc7mF5WohzCUYt9DOjHVQHon
	FXPLLubB0cG4oqeKB6OYkti+jm0hvwDB5UgKCqJOrVSNfiXgAmvNZrz87dskhCI=
X-Google-Smtp-Source: AGHT+IGUPflVBKiioRn7NCbi+ksHCFCblZZMd+3xYS5+hMd2cERA+NoS3AuQsfqFRBMj9j1itZQ3hg==
X-Received: by 2002:a17:906:1803:b0:a6f:1c58:754a with SMTP id a640c23a62f3a-a6f9506f70amr344655966b.24.1718830392088;
        Wed, 19 Jun 2024 13:53:12 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:53:11 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 11/12] net: dsa: vsc73xx: Add bridge support
Date: Wed, 19 Jun 2024 22:52:17 +0200
Message-Id: <20240619205220.965844-12-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205220.965844-1-paweldembicki@gmail.com>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for vsc73xx driver.

Vsc73xx require minimal operations and generic
dsa_tag_8021q_bridge_* api is sufficient.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2, v1:
  - Use generic functions instead unnecessary intermediary shims
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - remove forward configuration after stp patch refactoring
  - implement new define with max num of bridges for tag8021q devices
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 5134a3344324..6606bfdf58b0 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -691,6 +691,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1690,6 +1693,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = dsa_tag_8021q_bridge_join,
+	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


