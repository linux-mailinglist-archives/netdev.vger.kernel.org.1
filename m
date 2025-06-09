Return-Path: <netdev+bounces-195670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9521AD1C90
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A114A188DCE6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040D2561CC;
	Mon,  9 Jun 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHL5Cmxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718221DE2C9;
	Mon,  9 Jun 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469491; cv=none; b=O10NLH98IuG0wE4WGrGIWjweaq8Eqfz+f9yWXbKKhSCAD/bOkjAHwRmZHbAlTFcbRwdiTt3fGj0bynDb1hvMHGGHjkaf688b7jVvpN+w1EhJE2yR8U2zjzA0QnMLaTRjXrmR+seYNlC7SQnsow7A6ay/unw/VeDyZPnRy/iQjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469491; c=relaxed/simple;
	bh=8Y2htiPy5meWxzHXQzhyzo1AQtbeIgcyev3Yn6FKh6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpQ85tZf1QPoiwBrr0ka/LvUsT/PfDc2x20skq2XwPAxy0HfibiYsA/1pAZp1a/EFEr/R7ZyncZJqrdlqha6OgnZaOs+xv16CeIdva22JK17haUmXqAbUGjYlKrLkKBXVvpXzI06Rzv5cpWVGZiX0DUn3xUsBCnQdeWrAYKpa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHL5Cmxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF4B3C4CEF0;
	Mon,  9 Jun 2025 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749469491;
	bh=8Y2htiPy5meWxzHXQzhyzo1AQtbeIgcyev3Yn6FKh6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EHL5CmxtaHj9eaBIvpAan7U9VI9QpRemElus2TExsBOzUgvhWb8aPS4l8jsUHFp/g
	 ySW+s64kUFfXY51xpTuEjKukh9fEc7wjDEJ5mupTokNA0BxJ0F5YUs+x2CTmvOeI8x
	 jMP7kLFA3KEkELk0Y9ykS/cmbQQB/lizDvKwBgAVk2vFUTW3n5xbFtI38QRAe6Mkrs
	 CtpD2zRbIGQ90OOrpdqFDTmrsqHglwBsHrr7lNoDehw/XfsfuhYY+3DoPFKBDGAHtU
	 3bOtZqA1dTQ7gawZL1oTzuRl/SQ/0/VK9wKTfkFMYFfg1t5xvqtbEgmH3amRge/aDl
	 W2/erjSN+0s0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC450C5B552;
	Mon,  9 Jun 2025 11:44:50 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 09 Jun 2025 15:44:34 +0400
Subject: [PATCH v4 1/5] clk: qcom: gcc-ipq5018: fix GE PHY reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ipq5018-ge-phy-v4-1-1d3a125282c3@outlook.com>
References: <20250609-ipq5018-ge-phy-v4-0-1d3a125282c3@outlook.com>
In-Reply-To: <20250609-ipq5018-ge-phy-v4-0-1d3a125282c3@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749469488; l=1220;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=y65n0Od6u+x9wP3HKotpTyPdgu84le/dyFb7G8W0t/E=;
 b=iqyq5gPzQjTMnelCKjEogpgJFAIR28CmKlbLhc57efrm41jxWqqcHutcDxschjx2rqzA16f0F
 GJaFZU+8idmCcpfvyvrRD9Cbj6EK0VXPXh7bShEtPSeO55gEI4+QDOV
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The MISC reset is supposed to trigger a resets across the MDC, DSP, and
RX & TX clocks of the IPQ5018 internal GE PHY. So let's set the bitmask
of the reset definition accordingly in the GCC as per the downstream
driver.

Link: https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/00743c3e82fa87cba4460e7a2ba32f473a9ce932

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 70f5dcb96700f55da1fb19fc893d22350a7e63bf..6eb86c034fda18c38dcd9726f0903841252381da 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -3660,7 +3660,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
 	[GCC_WCSS_AXI_S_ARES] = { 0x59008, 6 },
 	[GCC_WCSS_Q6_BCR] = { 0x18004, 0 },
 	[GCC_WCSSAON_RESET] = { 0x59010, 0},
-	[GCC_GEPHY_MISC_ARES] = { 0x56004, 0 },
+	[GCC_GEPHY_MISC_ARES] = { 0x56004, .bitmask = GENMASK(3, 0) },
 };
 
 static const struct of_device_id gcc_ipq5018_match_table[] = {

-- 
2.49.0



