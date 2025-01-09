Return-Path: <netdev+bounces-156840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59348A07FB6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A6B3A3D02
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B6198A37;
	Thu,  9 Jan 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNGsz+Xn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72412B9BF;
	Thu,  9 Jan 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446905; cv=none; b=DfLUL+jwHRIH2I47tQBtlGiGepkyuxgf3LhPJqluH8BsTfZ7xBEgk4MQPxQp8BxyOXZ8UfrzD5F5Ip0raSmYkiaDNZsrojKHqP/5tTKjHlR3PigziviXhc9ZQVIwDbh0i/GX5SjLE3vdpFLNokgLHLvqeGzF+B32H0+NHc7URFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446905; c=relaxed/simple;
	bh=NYpQPAmxPFvCY70HNTIO8ZiAiJPOU+DNqmSdt2sETPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l43RJvP6ylMR6z84XUMhORKkU4NsCZMERcVLWa9NUKOZIQSNaAj+OJ5LR9jBcHqxCrpomNe+8QFyBfcT3IbDVMuaNTfVyNa/zs3+wnzlboRfHm01Uq7e1YNdlgXBpczMv8/RLb5CuwAPQGo1sXjpcSDNPJuSaKvgkxiX89SsE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNGsz+Xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D43C4CEDF;
	Thu,  9 Jan 2025 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736446905;
	bh=NYpQPAmxPFvCY70HNTIO8ZiAiJPOU+DNqmSdt2sETPg=;
	h=From:To:Cc:Subject:Date:From;
	b=fNGsz+XnY57SG8SQeT3pAtA7Rd60Aw+3RwrL05YZmpO2i0O6iCI+i7ai2c6WBvzF9
	 SdypvjivO19cXjpbyQKQAfEvyAYhO671eegANYvZyEoACuXLIeuP1NqBHK0o1VGHBH
	 Da3eJ35zjxGgyUrQ9jI/TTBnG/OaX6ByDJHfL2miRwqBwJiJ0HuZrkrMCL6peYm19N
	 VJ/qXE35GYmi2frkUrg+6A5hvW8I1on19PxCTSEV0cPMyOb6ai8DFSCsDc6cgj/UnQ
	 zZ5fy1DO0vr4W5y/kLR6RL88gAetsKpYqM2OJG4h1Z/PW868I5vPaFN8mUe5MRBkSs
	 igPIV7DC+nq7A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH] net: dsa: qca8k: Use of_property_present() for non-boolean properties
Date: Thu,  9 Jan 2025 12:21:17 -0600
Message-ID: <20250109182117.3971075-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 2d56a8152420..750fc76a6e11 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1019,7 +1019,7 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
 
 		of_get_phy_mode(port, &mode);
 
-		if (of_property_read_bool(port, "phy-handle") &&
+		if (of_property_present(port, "phy-handle") &&
 		    mode != PHY_INTERFACE_MODE_INTERNAL)
 			external_mdio_mask |= BIT(reg);
 		else
-- 
2.45.2


