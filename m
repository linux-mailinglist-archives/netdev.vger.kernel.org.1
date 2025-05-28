Return-Path: <netdev+bounces-193851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41BAC6094
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B11BA0C4F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C71B87C0;
	Wed, 28 May 2025 04:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BFBA53;
	Wed, 28 May 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405756; cv=none; b=tSl/Fm0Nidkwgzgoe4vm4MvcQgtwjSQuyohyoXtUy+xNem1urdiXKpjQCf0mtIEoYTtRP7HA/Np6p6Vd4GSZl/wcsuBat+bm6K3SyAln4wh2LBgefAD3FQ2QtNaI8pkQdlnaLYqyF+wAnVo4GXHqepqlrzH0K4MSaBlr8o3Dnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405756; c=relaxed/simple;
	bh=/I/sCH3HYYMfI7pUcDNfIom6DhGMCZFJGmPYmZ2Jix4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XC2mO5sibFPbQOoldLQZ6DVKEYWJRcCxES/mOg8Q4A/Zeb4tA/+EBJHQ4FX5tX5564j3/zVG/OSXoVTvag+7ckPOR3lGY5x632XhUG13pk4s6tR5DF+9EOAST5EbjD10OQgrlpP6nHUg2Dk+g4Hkz6N6PQ4eyF6frsNQnSphcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182DT.eswin.cn (unknown [10.12.97.162])
	by app1 (Coremail) with SMTP id TAJkCgD3DQ_DjTZoOQuVAA--.6922S2;
	Wed, 28 May 2025 12:15:04 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com,
	jan.petrous@oss.nxp.com,
	jszhang@kernel.org,
	p.zabel@pengutronix.de,
	0x1207@gmail.com,
	boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v2 0/2] Add driver support for Eswin eic7700 SoC ethernet controller
Date: Wed, 28 May 2025 12:14:42 +0800
Message-ID: <20250528041455.878-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgD3DQ_DjTZoOQuVAA--.6922S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4UZFy3KFy5ZFykGF4DArb_yoW8tr1kpa
	yDGFy5trn5Jr1xXws3Aa18KF95Xa97Kr43KFyfJwn3Xan8A34ktwn8KFyY9F97Cr48X3Wa
	qF1Yk343CFyqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRifHU3UUUUU==
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Updates:

  dt-bindings: ethernet: eswin: Document for EIC7700 SoC
  v1 -> v2:
    1. Remove the code related to PHY LED configuration from the MAC driver.
    2. Use phylib instead of the GPIO API in the driver to implement the PHY reset function.
    3. Align with the latest stmmac API, use the API provided by stmmac helper to refactor the driver,
       and replace or remove duplicate code.
    4. Adjust the code format and driver interfaces, such as replacing kzalloc with devm_kzalloc, etc.

  ethernet: eswin: Add eic7700 ethernet driver
  v1 -> v2:
    1. Significant errors have been corrected in the email reply for version v1.
    2. Add snps,dwmac.
    3. Chang the names of reset-names and phy-mode.
    4. Add descriptions of eswin, hsp_sp_csr, eswin, syscrg.csr, eswin, dly_hsp.reg.

  Regarding the question about delay parameters in the previous email reply, the explanation is as follows:
    Dly_hsp_reg: Configure the delay compensation register between MAC/PHY;
    Dly_param_ *: The value written to the dly_hsp_reg register at a rate of 1000/100/10, which varies due 
                  to the routing of the board;

  In addition, your bot found errors running 'make dt_binding_check' on our patch about yamllint warnings/errors,
  it looks like the validation failure is because missing eswin entry in vendor-prefixes.yaml. 
  When we run "make dt_binding_check", we get the same error. We have already added 'eswin' in the vendor-prefixes.yaml 
  file before, and the code has mentioned the community, but you have not yet integrated it.

Shangjuan Wei (2):
  dt-bindings: ethernet: eswin: Document for EIC7700 SoC
  ethernet: eswin: Add eic7700 ethernet driver

 .../bindings/net/eswin,eic7700-eth.yaml       | 200 +++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 410 ++++++++++++++++++
 4 files changed, 622 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

-- 
2.17.1


