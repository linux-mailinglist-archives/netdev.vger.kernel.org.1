Return-Path: <netdev+bounces-111279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B871B930771
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8115B20CB9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C538178CC0;
	Sat, 13 Jul 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9SfZn0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAD178386;
	Sat, 13 Jul 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905431; cv=none; b=MnHsiu1KBXiSGtgbHAcmxm8hk3SW4JE77VTuK2g7OIGL+13JUV/ccb8q0rnsUAafXAYKS+pOeizYGScw5PGGlT606AxtJGM4bLZ/U4AkGSJTJpaf0hFdSa5JIdc2qjNstiEP47hBEbmP6HVuqVuoVB2fujIlwqLFKDGoN/lLE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905431; c=relaxed/simple;
	bh=4JGVEthUO/9/JGyzV/xSN/50/6+D88uFUZ67OyzkPfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgqqpxQdS037aHh8e1KGdeaac5f893rN+qu5OKI93XOdHz4xnErmBuV/hkMTPqTfKHTZnEWcd28EEgkwUQFrdpZ/3/en4p1IfIBPwWfcakZn6CYQwLuGU/FdylGjLO3Nm4dtTAAWPGCC4pOADreHPuSWV6E1n7ljIWX+p8hI8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9SfZn0k; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so48282561fa.0;
        Sat, 13 Jul 2024 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905428; x=1721510228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7E/9qsW4s25NpSrBKRqdhwhFtq7oMnQgr3sY+zQz70=;
        b=Z9SfZn0k13vRfa9nXFsUXIpKVEjwZgpurEfMeAaMxtprTHNX25JeykZBkq0R5BkVG1
         93PVDQoCnwiIG/8aLjjijM3QulhNmrt8Je80AvSmE8gIsJBxN5h+eFi/6lhIdHIzDRs1
         jOKmE2Ynt6DaEl2dK3jHP4Un3gVa64V++uvUTxU6G/gGTcwvixnKf6skOpO+EyM69+Cl
         QhinXJeYS9YUyovhpPFW/XibokOvuNzUjC3H1mciLeybo9yZ4qlnykxt72xZwM1c9N0z
         R1g53S1IkG/TkhFek5mACboQQNqzR902om4D0H+mGWwGavvNj2BRyaz+mmzrsqq7RP9h
         nUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905428; x=1721510228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7E/9qsW4s25NpSrBKRqdhwhFtq7oMnQgr3sY+zQz70=;
        b=pinn9UW15++yLawZCPZEsYhc3n7DZvtAqhLY9w0k2JnhX7/SbfUGGxnmROfNEvqwF/
         BlBjwz1ExkGAD9I3vyopZhzOjuzAStjOH4fat7QI4OhYedP9kIOIZxKHuisrNDDqG0iy
         SrGcbCliX8XQnFwvL9pbyUpLCaHuw/7iDzMEyDv1E7dqJI+LzlRbkz7k5Eu6jkjd2lF7
         dLr83H71DAuUepspK1rjvfCPyyzq2NkQNGP9kGSBqArfi8xgsYF3JpCcLA1of8Tk9q7o
         FrtS8QxEH4Iom7RIc/CtrNX2At4P9UYIsRFWUfUv9gOBgMuw+nBCrhQO3QTDdZWhCekn
         m8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWqyJ9MZ9smcYdc4yxGufip0J95ViQYN11VEau4/ypJWGzbG6Eb5N9xJXXjOeCFEeszdJrRTRISDcJT8jWBJxG0jSHUg4ORxm2jiPB8
X-Gm-Message-State: AOJu0Yyi24jkUdBxFiIkgcpkzHXOD5KkHjhWKflqrgXBGX+13Mz55Hbq
	usRgbjCA4+F+5j0LscKDxB9rZuzhOrldceuDXku9n1IARKBEg3K83gcQMkyL
X-Google-Smtp-Source: AGHT+IGnLD8NfLHaxlQlwBJChqsHQyqOuQcrvJiZ7wL5RvoAK+IpALurSf7sX4Ge8mYxtnu37ORYtA==
X-Received: by 2002:a2e:830c:0:b0:2ea:e74c:40a2 with SMTP id 38308e7fff4ca-2eeb30e5025mr112992081fa.20.1720905427882;
        Sat, 13 Jul 2024 14:17:07 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:17:07 -0700 (PDT)
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
Subject: [PATCH net-next v4 11/12] net: dsa: vsc73xx: Add bridge support
Date: Sat, 13 Jul 2024 23:16:17 +0200
Message-Id: <20240713211620.1125910-12-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
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
v4:
  - resend only
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
index 25c3cd661b30..d0e501bbd57d 100644
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
@@ -1716,6 +1719,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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


