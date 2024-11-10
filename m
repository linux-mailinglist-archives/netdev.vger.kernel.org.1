Return-Path: <netdev+bounces-143605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02A9C3423
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB3A281297
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF91E495;
	Sun, 10 Nov 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ryWB8uHz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A93F9CC
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731261619; cv=none; b=jYKldjap/K8AhoznTHgzXkYKwtalaX8PrFqjsqZ12Dlzd70J+CH0tADU+hgGWVMI1Bq/hpjyahplxrQlvDFYA7vrYmrWINpb2JfAR5QMadg6molRVmymDNOjzHzimrrfPZqw0Wf4c8ub7pt4Mnb/exbH+ICJvTCx+3fS6XqxULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731261619; c=relaxed/simple;
	bh=rJjtuFbjE9Fik8w8AnJc4zI1CCg0TPssFb3we/D9ZhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QaFkalKt1LD++3QrouDIqQrsdbwFlSDa4LGLaQplIM3tW0FiSLJ3xAxg92mZ4CCf+TyLI2hkO+YijmHqiwhIjScJ6zfi9Rq7I4OHR5mYdd6zlWjAj4JE7U3v/Vu9kWXSKrfkd1RGNPUTmnV8HKRPXgjleZHtzVC8gpCp2wVkplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ryWB8uHz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=GWDxk1jkYVtL2gUBbt0kS/Okb9uAQtTviSjSmf+zv/A=; b=ryWB8uHzfCxpJfaZe9EsDnPKow
	bDSMQR/qY68RUaNn0A/yV/ueoPwDdXlTlZHZdGjSgAsrsCbgL+85h0XGDtkRTDcMCAHbTwlkJbleC
	RFyEiI7pJT+QzTAlogMYqQkiDdEt7RTdIjXBchFJjNCnRPyVD87k2dQt2B9SWR3V1vWk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tACEA-00CoOt-Fs; Sun, 10 Nov 2024 18:59:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: <edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
	ansuelsmth@gmail.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v1] dsa: qca8k: Use nested lock to avoid splat
Date: Sun, 10 Nov 2024 18:59:55 +0100
Message-Id: <20241110175955.3053664-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qca8k_phy_eth_command() is used to probe the child MDIO bus while the
parent MDIO is locked. This causes lockdep splat, reporting a possible
deadlock. It is not an actually deadlock, because different locks are
used. By making use of mutex_lock_nested() we can avoid this false
positive.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f8d8c70642c4..59b4a7240b58 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -673,7 +673,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 * We therefore need to lock the MDIO bus onto which the switch is
 	 * connected.
 	 */
-	mutex_lock(&priv->bus->mdio_lock);
+	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
 
 	/* Actually start the request:
 	 * 1. Send mdio master packet
-- 
2.45.2


