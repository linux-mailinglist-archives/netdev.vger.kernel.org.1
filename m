Return-Path: <netdev+bounces-111219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFFA9303E7
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D02281B03
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC2137769;
	Sat, 13 Jul 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeZlbaIv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D313774C;
	Sat, 13 Jul 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850131; cv=none; b=e2gc15sX1aMVSUt3df4J2k8bloVPimCCkMFqHnIKpDo2+sj4FZGBCH6g7lT0pPT1vX/Q44Otvyjct65UtKByKaiuK4a5cqkOLXzpJtUJo3EQrJ/r+TUUkDM5JRdocBIY3cK464xYl3M/dHwqUh+1HDKofz1CYJBlMg1kn4L2dU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850131; c=relaxed/simple;
	bh=Tn5iSYglhZtXTG+V7gPq7wzrm75FHFu4BGHykn1Yk0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eF68O/y7+5+0RKcy6kR2GB2YEXljOpSsRo9Qv8PDCpQMH19JO7mT5M5ba5cKYFkLfo54pRjQv0J1hzDOVHg4m3hNUANo/DCWiwO0F2FaFxhz/GHlc5WvEcnDUBG5MnN9HOmthsMG0b3Cj19L2yMvYmkJLzapEPyQp0wcdQ1+uMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeZlbaIv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso3536675a12.3;
        Fri, 12 Jul 2024 22:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850128; x=1721454928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89QJeNVLQDkmc2B+6tcM2WBPPc8pRRTlrLPa+MuYhlQ=;
        b=GeZlbaIvQg2YvXcNw0zBx1R/NgJO1IhLUfDqpEeL2HfRnUTkctRj4k6eLEyu8Mp6QM
         5xrfV241/HzCzuaU94cZS14UWKZu12g2axs+Lvtwdzf4NbCJILNuIBmHt90dHmVuXW0x
         AdRtfc6XiX52Lihzx96v+TvecuTXVCg/DjbVUFiENRbxP03UOm6Iv9c67vMp1mFxuo+O
         Ah7mizSvsAeSCjJhMCvYBTyLFQm9HLHoXNTmFxCdotmQZce+plJifi3SOJXSsdMoVVyv
         +6WWKR6aJgWI4GwKRPfraRL6DLI3ryhQ9I4dptzVAPXlIUIRO9dmkAlkqstNcJmqTa4y
         wjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850128; x=1721454928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89QJeNVLQDkmc2B+6tcM2WBPPc8pRRTlrLPa+MuYhlQ=;
        b=nTPBuMEZSCwoFtL8gkM8HR4M5Z0aSfzh2WZLz0W+Vo+PElV1/RLH7gT7BlS/+poXSk
         zROitdqrp3M7WLcsJRpBg4CniS3fhSWPA0/Ft8e9WAdmsWI1J1hartE0bJDWsWaWzoc4
         KkH5LDNH9dQxjF34i9aj96mcahYID5qami+VtE3jW3/234jAMwuHs6/TSRr0TPAhA3ox
         dyjcpMpsFdLAIt4s0JCkJLUv01mDmPVmyShDRTlV89nGf9uuQEljFGoAKQzuzAyP1RzF
         LMjytuJic4100/LYyWFov1osUbTDXEWknazDUetYhmhOUEq3HB6jPuPBDoj7AVUKn1AK
         dckg==
X-Forwarded-Encrypted: i=1; AJvYcCW1YXjcExzXkwTHJA7WHOfppSWe9NVAHhhermblPF8wlMNpD72g7YLGOLPN+8XLlJfNe3Y0QkA+G6JlTCStCnEk7xkVv0nWlhGDSOWK
X-Gm-Message-State: AOJu0YxnQF9BlrE6F+CuC9HYUU1kBqN0Hpam1SScCd7sz2NM4pNsHV3l
	ruvhgeh+LDtapnTyOldCqGTpTDtfCWGRY9TM95TMGfu00mB0WSt/DHoNcJnJ
X-Google-Smtp-Source: AGHT+IFGgnA+t54HANbyOXm/4GGjfvzmO+co5MVkRKRDiZcbLGgpHvO4ZWtcbYZ7NP2H5lOlkUzcNA==
X-Received: by 2002:a17:906:2401:b0:a6f:5815:f5e6 with SMTP id a640c23a62f3a-a780b68a736mr856655766b.8.1720850128449;
        Fri, 12 Jul 2024 22:55:28 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:28 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 11/12] net: dsa: vsc73xx: Add bridge support
Date: Sat, 13 Jul 2024 07:54:39 +0200
Message-Id: <20240713055443.1112925-12-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055443.1112925-1-paweldembicki@gmail.com>
References: <20240713055443.1112925-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for the vsc73xx driver.

The vsc73xx requires minimal operations and ithe generic
dsa_tag_8021q_bridge_* API is sufficient.
The forwarding matrix is managed by vsc73xx_port_stp_state_set() ->
vsc73xx_refresh_fwd_map()i routine, which is called immediately after
.port_bridge_join() and .port_bridge_leave().

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - improved commit description
  - added 'Reviewed-by'
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
index 71be5acb291b..07115a9d1869 100644
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
@@ -1707,6 +1710,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_sset_count = vsc73xx_get_sset_count,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = dsa_tag_8021q_bridge_join,
+	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


