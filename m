Return-Path: <netdev+bounces-142510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10319BF628
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27991C21D2F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267C20ADE4;
	Wed,  6 Nov 2024 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MlsD2rHj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD9209F30;
	Wed,  6 Nov 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920677; cv=none; b=Z5g3KJ210l/CnECLliMJJHH/Rjb/sG2eU4ghr0eVVjsYqfOy+dMrzPiDOniUT4Zk1B8iswJjOFzAKXV26+ogNiglb/3iE+d8YTtDUh5hGnqIUPtict5lrssTuIhNGeMGIZdDJ+EzXNppIBjr7uOWRhaGmBQQmJ07v6x0Xyu705I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920677; c=relaxed/simple;
	bh=H0j6iihOjF3M/leKroRbJnhBJAJf/+snyIuEVahUA0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Wii2X6t1aJ9vqRDC7rT7gjwHAN9OY14hm2xlGM/UjFFM0o8jUGVsjc9MjM2EgTVynSfwRPUtG/98nwRiFho6mk4pxkFRD1C7qIXgIuVfXxfyegiGosSBkS4nABhjrX6599DO9LiBS4TrwBzj52ger1gNF2XD5Y3Z9Ar4NBFguoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MlsD2rHj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730920675; x=1762456675;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=H0j6iihOjF3M/leKroRbJnhBJAJf/+snyIuEVahUA0o=;
  b=MlsD2rHjHMoxhJnxFD92HPv1xX+Na0WuPv/boOXO1PIVZOZ7cKaHRwEK
   ym9vb2c2kl3zNDMh26Nx6FgPw6hGevN2bJbcV+UnXT9cw6fVUL3R+11c3
   C87Ie9i2vbOb89IYc9AmryX17JB9bIU4VInXJq855T/6cLuqR+Lfmjm1l
   ljMaN8PEW0cgNqbcxqaGEeDk0E51aAuGs+sKyoOJerkxrL2bkkT33YlDG
   W8x368oLAXqzbZpuFkba5QEzeYHSXJxwERHnWWwW/F/ndMSsw7m2Ws122
   NveQoTkrQcCVuiMui6xBjVQImrDZFHtSKV6mlU6riwTEEOXdnLDy0yG/8
   A==;
X-CSE-ConnectionGUID: R5B6jnU1TTWc0t0C0FxLpw==
X-CSE-MsgGUID: Y8lHa7noTOuZ6Oet0XHKlA==
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="37447984"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2024 12:17:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Nov 2024 12:17:16 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Nov 2024 12:17:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 Nov 2024 20:16:43 +0100
Subject: [PATCH net-next 5/7] net: sparx5: verify RGMII speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241106-sparx5-lan969x-switch-driver-4-v1-5-f7f7316436bd@microchip.com>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
In-Reply-To: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

When doing a port config, we verify the port speed against the PHY mode
and supported speeds of that PHY mode.

Add checks for the four RGMII phy modes: RGMII, RGMII_ID, RGMII_TXID and
RGMII_RXID.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index fc1ca0cc4bb7..bd1fa5da47d7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -254,6 +254,15 @@ static int sparx5_port_verify_speed(struct sparx5 *sparx5,
 		     conf->speed != SPEED_25000))
 			return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
 		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		if (conf->speed != SPEED_1000 &&
+		    conf->speed != SPEED_100 &&
+		    conf->speed != SPEED_10)
+			return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
+		break;
 	default:
 		return sparx5_port_error(port, conf, SPX5_PERR_IFTYPE);
 	}

-- 
2.34.1


