Return-Path: <netdev+bounces-133323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77D995A07
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AE8283429
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42166215005;
	Tue,  8 Oct 2024 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1JHCNHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBC2139A8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426148; cv=none; b=AZGwwLWuGiLMrQIQfvN2V/OTrz/wQVyT5OXGdCdWWXsXakdLq3WQy9UZammF/KrQlor3hdSF69JgimmHySxl2IOfYkkhV5flWDMqEKOtoSKSarnZr8HhF4TTEHbBxAIBbAjzJO9Pbd79lL3vYpk+vHv6flkpJjr/MCIGBUn9aCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426148; c=relaxed/simple;
	bh=MccBu7KW7dTQw0QT8KNJWntrJS4ZIEa0v6xwKmeKxb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i8yxV2ZEFRTIxgjrmhH6qlRq3ihrFoswPtIhsYCV8tiT2jOqK2O5oiNs299bb8KhMeFtofTybesLvJFco1GVpZFmD6zaBUzPN+IxiKRMQ1CFNkpaM/MX1e7CrrXl3siCz3O+LuivY0ZIuc5JBrqTqkNmDgnev+El2S6sBRqA7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1JHCNHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC52C4CECD;
	Tue,  8 Oct 2024 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728426146;
	bh=MccBu7KW7dTQw0QT8KNJWntrJS4ZIEa0v6xwKmeKxb0=;
	h=From:Date:Subject:To:Cc:From;
	b=V1JHCNHMAWZlI32H7SWOFNxGbaXRPEPegtkHpt5JHInfFurbF2AgEM71jSxZfx6lc
	 LX0XaXGpFZUsPRWRkR7bdPF8KdizYUQVL29v9L2cErouCYP93/n9rgvDcCf5jeZbfb
	 K4uqjt2eMtLKSrsRNsouGZ9tNMsG33rdUGLK3v2A/yh3PK0n0oxTL9r417K0jVG5lf
	 6Npe1UhwWlve7lxE7GQu1AtwanalPJItIiDvBwbAOp3Piyavp7nJqYCX1UavzrDoUL
	 SegwDV8jGI+J0Wb9+X9vMMX7yui4LGEO+RNDcNjshUxcGSyD48Wnidterm6NhEfNUO
	 Dv3uv5Ekiy4LA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 09 Oct 2024 00:21:47 +0200
Subject: [PATCH net-next v2] net: airoha: Fix EGRESS_RATE_METER_EN_MASK
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-airoha-fixes-v2-1-18af63ec19bf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHqwBWcC/3WMQQrCMBBFr1Jm7UgSAymuvId0Ma3TZlAamUhQS
 u5u7N7l+5/3NsiswhnO3QbKRbKktYE7dDBFWhdGuTUGZ5y3xngk0RQJZ3lzxp6IehvC6E4emvJ
 U3o9mXIfGUfIr6WevF/tb/4SKRYtuDGQsz1Nw4XJnXflxTLrAUGv9AtFxLQCpAAAA
X-Change-ID: 20241004-airoha-fixes-8aaa8177b234
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

Fix typo in EGRESS_RATE_METER_EN_MASK mask definition. This bus in not
introducing any user visible problem since, even if we are setting
EGRESS_RATE_METER_EN_MASK bit in REG_EGRESS_RATE_METER_CFG register,
egress QoS metering is not supported yet since we are missing some other
hw configurations (e.g token bucket rate, token bucket size).

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
for EN7581 SoC")

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- improve commit log
- Link to v1: https://lore.kernel.org/r/20241004-airoha-fixes-v1-1-2b7a01efc727@kernel.org
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 942fcfc5b79972e1bbda06e6e5c07302cab0affa..b3601a56bda3ec63500e0df4809102f3f0ec940f 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -554,7 +554,7 @@
 #define FWD_DSCP_LOW_THR_MASK		GENMASK(17, 0)
 
 #define REG_EGRESS_RATE_METER_CFG		0x100c
-#define EGRESS_RATE_METER_EN_MASK		BIT(29)
+#define EGRESS_RATE_METER_EN_MASK		BIT(31)
 #define EGRESS_RATE_METER_EQ_RATE_EN_MASK	BIT(17)
 #define EGRESS_RATE_METER_WINDOW_SZ_MASK	GENMASK(16, 12)
 #define EGRESS_RATE_METER_TIMESLICE_MASK	GENMASK(10, 0)

---
base-commit: 42b2331081178785d50d116c85ca40d728b48291
change-id: 20241004-airoha-fixes-8aaa8177b234

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


