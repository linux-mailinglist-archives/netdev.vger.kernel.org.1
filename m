Return-Path: <netdev+bounces-210315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F6B12BED
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588C7189F354
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E378420125F;
	Sat, 26 Jul 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVTcbokK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE241F4CBE
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555317; cv=none; b=uk2kNVrpOu98hvy0fMziO65CoaqJg+GDLxoM5Ps/YUzGue2PHkLPNVpgO82pRzXDxFfI/HwUDpCWKobbDu+ENd48qZnOn42fymLj6HLkBA/nUFaA1ZxxxlJIQr7jESVpcREERlzpHoYaXn9kCdS+oq2/KCPRPfZQlfDHa4g6BTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555317; c=relaxed/simple;
	bh=X5SNU6mZpfGJ0uSyCXcVbhVyIzG+8ZB193dZJ72Pxno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urlzxeRhgjMTSkc2r/Uv9LkgmbU0wRZGpXOh9CXLQIbEqPDX87JUWTK9jdAD0cyiHLWgKkQV/auRZ/PMEAND9afCwWuWHde/XCAGqqXDhNbBEgefPEC7OahZYXOn8J/XNclKLEmtLp6EDRRQrhp0xPm6VPwpSFt74pCD+NOXoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVTcbokK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753555313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AOhWlntOPTxRL5Vgqd2NjgBziUWiXpKafE0U7ewS1Kc=;
	b=ZVTcbokKlYAoI8nd26peNLqMuMy7N7jU+ILFDac0ijEsGPQ+vC6KEIA/Qrygcnq15vnd2M
	r0c6QIKiZqpuXqw8asF9UR6pl5X0VuAYmzyUEuKJ2DHH2nFBn+n9Ud6/2iL3iX3SgAYyql
	bOVlQ8WS86dwIs+RpTeu3ul7NG3ifyM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-OelhwYqoP6KmGmRg8Wqdnw-1; Sat,
 26 Jul 2025 14:41:50 -0400
X-MC-Unique: OelhwYqoP6KmGmRg8Wqdnw-1
X-Mimecast-MFC-AGG-ID: OelhwYqoP6KmGmRg8Wqdnw_1753555309
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2E971956089;
	Sat, 26 Jul 2025 18:41:48 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E798F1800242;
	Sat, 26 Jul 2025 18:41:46 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org (open list:MICROCHIP ZL3073X DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] dpll: zl3073x: Fix build failure
Date: Sat, 26 Jul 2025 20:41:45 +0200
Message-ID: <20250726184145.25769-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If CONFIG_ZL3073X is enabled but both CONFIG_ZL3073X_I2C and
CONFIG_ZL3073X_SPI are disabled, the compilation may fail because
CONFIG_REGMAP is not enabled.

Fix the issue by selecting CONFIG_REGMAP when CONFIG_ZL3073X is enabled.

Fixes: 2df8e64e01c10 ("dpll: Add basic Microchip ZL3073x support")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
index 41fa6a8f96ab9..7db262ab84582 100644
--- a/drivers/dpll/zl3073x/Kconfig
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -5,6 +5,7 @@ config ZL3073X
 	depends on NET
 	select DPLL
 	select NET_DEVLINK
+	select REGMAP
 	help
 	  This driver supports Microchip Azurite family DPLL/PTP/SyncE
 	  devices that support up to 5 independent DPLL channels,
-- 
2.49.1


