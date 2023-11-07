Return-Path: <netdev+bounces-46402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDC7E3B8D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93441F218A6
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D62DF8E;
	Tue,  7 Nov 2023 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHjGqbzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416982DF65
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8236FC433C7;
	Tue,  7 Nov 2023 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699358852;
	bh=FAWCFLcUr/wF8J1ZlkDOwgRRgSOhuDGORbWhEjATuZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHjGqbzQPgcPpsPVWiQEz4aAWXw9Hr/ORq5/UBa84ASXDcV+Lcvl10/eiPG5fj2wL
	 7NkwZmUfzHvnMGXfD4nj9KQIL5BQDszPXByXi/kKF2LDKM5OFMAZm0uiSmnMGg6sos
	 75zxdIktWQkZvR1FDc9YYxrR1v8Z15uV9msOE9yUoYFp3WG1VLylSQR+PzalD/JaYL
	 sjgivuf8HWsjH5emHW9Emhn/EQI3P0Xl6g+JrRDow0/IPXPGcJU8hAJny6Z87GnzPD
	 UnfS+hGwmCKKyV/EGRvXFk2xdegnSh/c1YDfqrs0jqduKA+27pFx4kWFlhEUD6wWOQ
	 zNyhMivJRSyzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/31] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
Date: Tue,  7 Nov 2023 07:05:59 -0500
Message-ID: <20231107120704.3756327-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit d387e34fec407f881fdf165b5d7ec128ebff362f ]

Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
NRZ in their EEPROM.

The module also require the ignore tx fault fixup similar to Huawei MA5671A
as it gets disabled on error messages with serial redirection enabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20230919124720.8210-1-ansuelsmth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4ecfac2278651..a50038a452507 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -452,6 +452,11 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Rollball protocol to talk to the PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
+	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
+	// NRZ in their EEPROM
+	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
-- 
2.42.0


