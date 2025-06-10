Return-Path: <netdev+bounces-196053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B593AAD3529
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5093A8414
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3632857FB;
	Tue, 10 Jun 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZSqOzO9j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ff3VuJZh"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7A170A23;
	Tue, 10 Jun 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555675; cv=none; b=tlCcK1a4Jg5zUflBB3cvORaKcvoq5iG0GA/Qo+RhcD6Cj+8Xl1Gt9EEkOBIRmRMpTy2TH2rnOd5Kqfvg6fno6EUWJUn+7eHBNvUHJqd7jLggDgXjwmXfKJuVGvJVztMy2jlwqDfzOKndCL+J+uMWxoyyrJtx2mjkBaIa8EjxaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555675; c=relaxed/simple;
	bh=n0ML7zRSEOuaaURpftI7CAfQ7mwr7h1bbhbOBwd5Elg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JO/eTa9BmvXYRYhErJnmeXBLaUctTgVObp5/VSAxreSlbxO6Ic2IqmkqdrfnCEREkvyjH7DljiRFIeJ6OcvUgY/p4MtjX8Wx0dG0gDqqrSIYOgjjWn1Wb2f1TTRArU1B1DQL7chs3urNlSgSOQP0c0tsM7tpVzIw/WyUV9azb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZSqOzO9j; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ff3VuJZh reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1749555672; x=1781091672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T0hn3QlUDDx93aZ+2OLzS2n7KSVRomyjHzy0XcJuNHM=;
  b=ZSqOzO9jHjXbs9xfDDn2d7FAEcFOsjGWn4jTbExm13l65/cL2i1xqvzA
   NFYosRPONpRWO5HoG2HGpnnqL2A50F+UF1h6JqrGxIee+pMTWx/apbM0Y
   Hic95jRKd5ZxjzwoIbwCDj6DAx25Vqgc6A8TsfCy9HTYUVVq0bFblW2UE
   VeowG+DIBOzhvkEGaWIurNIlhGG5FZPXyrPVDwcf/apEtthuReJftydM5
   moja8nEvEIhzufbwx8bLrq/vG26rExP190FXk1vEb499GSRI9vzw5uC59
   Agd1YSMigMoJQv8iZ7DFWrVJgcCrtjofr+PCvHjx018l2G3OV0TVbiOvR
   g==;
X-CSE-ConnectionGUID: vsjij+9nQ2uFUS1Pg5iwLw==
X-CSE-MsgGUID: I3JfwE03TIS1nmD1YgaJPA==
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="44544268"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Jun 2025 13:41:09 +0200
X-CheckPoint: {684819D4-36-28ACC837-DD1065DB}
X-MAIL-CPID: 9A11648A6B4940251418317FFD709A70_2
X-Control-Analysis: str=0001.0A006374.684819DB.001E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB09B167453;
	Tue, 10 Jun 2025 13:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1749555664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T0hn3QlUDDx93aZ+2OLzS2n7KSVRomyjHzy0XcJuNHM=;
	b=ff3VuJZhBQBkP0NPYqsWcI1Cj4BdXMCFheJYKRJMr/DdM/sHlvydBcZevz4h1l4pN+xWPF
	TPqbVO5J08m3MAMdd95L+Du1JEvt5NwCnxB2wwmkFSQX3hm15SA50BeBr47Uajed6VHoLP
	ajrrbIodbM2iIKQOtSCg8/oXYI0avq1R8aSIBRhjYKLAoZK/hP9DXkqfYPdCCMm8pL+MMa
	B6t1rcH/B63Frg9fBunsc+bPVgYMFlKqDRW6b8Y9DUx4KS+ukyLVwF6hfvIFyeO4pGQ8s8
	/HKKOCKYm8bV6+MbjonBtMActakK0mRJwJ94DEtFsGD3epCln8bwBX+lZUW9eA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] net: fman_memac: Don't use of_property_read_bool on non-boolean property managed
Date: Tue, 10 Jun 2025 13:40:56 +0200
Message-ID: <20250610114057.414791-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

'managed' is a non-boolean property specified in ethernet-controller.yaml.
Since commit c141ecc3cecd7 ("of: Warn when of_property_read_bool() is
used on non-boolean properties") this raises a warning. Use the
replacement of_property_present() instead.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 3925441143fac..0291093f2e4e4 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1225,7 +1225,7 @@ int memac_initialization(struct mac_device *mac_dev,
 	 * be careful and not enable this if we are using MII or RGMII, since
 	 * those configurations modes don't use in-band autonegotiation.
 	 */
-	if (!of_property_read_bool(mac_node, "managed") &&
+	if (!of_property_present(mac_node, "managed") &&
 	    mac_dev->phy_if != PHY_INTERFACE_MODE_MII &&
 	    !phy_interface_mode_is_rgmii(mac_dev->phy_if))
 		mac_dev->phylink_config.default_an_inband = true;
-- 
2.43.0


