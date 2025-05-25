Return-Path: <netdev+bounces-193247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D2AC335B
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 11:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154C2188579C
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864081DE8B4;
	Sun, 25 May 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CsMrV82e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94819E7D0;
	Sun, 25 May 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748164904; cv=none; b=phgyNKSbZbkpDeUlLh4dpdkxlahEBLa2CMOckuIr5AtQCwhevW8PbgwDMOiSQgm2ZVDujkC/rRKHJb+CPmacUx6tjf89jnKjPomeoIfmoAFmHCyb/ey95MBAHv/X5Mi1X8YGiDKObi5ZtIjxF6Wl3L0QaPutM7IhnAzgWbRfbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748164904; c=relaxed/simple;
	bh=B5TYa235QjGjGA0jvQWxFhge6fgSHXnJT4Mm9/At1wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMjmzCBxSpY0Kcq9MdjAUk/EZBfkjXGJWmcLznQq67AfSnp/+JI3Pfb2PURdQKz8NsqwmLcwwvmcFvXgcR9AayZrkD1B7+Ee1OJIH8tLlly+9/DlBW3j5omCH1wYQoO8I1lHD7xbqbVe3cNycQmh51WC/mo2RVgSy0UCud/8tPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CsMrV82e; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id J7XzuBofDAivmJ7Xzu2vOD; Sun, 25 May 2025 11:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748164897;
	bh=nCEcBW70wZPmmN7YfoE/rJZEP5QvDv9rswbda3k7KEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CsMrV82ebeye7DC5o4tWvdcLaYGaBzCNx/7SlhLa/cg6iUCwS1X2rGmxeMQIyoBxA
	 t0lnHFUdTJeAnOe1Cenb0xVVTVZE38CohStP94W3mofmzKjqyfcK0h9PhlYc4E1T7g
	 OJ2uv/WPjhYCd4yAPTxJei2hyDxNK3zkvNBbxGGeKO01aaign0mIAsl/vSXSM8NYdA
	 +ythZWnSkC//6lHCAbKCrRE3+9LEJmMCUh7xhCdtxePLM4tAcv9R9MVM2YJKnHYJ/7
	 p2ll7M0jkwQm/EShb+FM2CZHdTFuFdIdNI9TOWJUBENDNwDXW5XFDmzhTz+xrm04NM
	 EVquUNMPsBEeg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 May 2025 11:21:37 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] cxgb4: Constify struct thermal_zone_device_ops
Date: Sun, 25 May 2025 11:21:24 +0200
Message-ID: <e6416e0d15ea27a55fe1fb4e349928ac7bae1b95.1748164843.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct thermal_zone_device_ops' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   2912	   1064	      0	   3976	    f88	drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   3040	    936	      0	   3976	    f88	drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
index b08356060fb4..7bab8da8f6e6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -29,7 +29,7 @@ static int cxgb4_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_device_ops cxgb4_thermal_ops = {
+static const struct thermal_zone_device_ops cxgb4_thermal_ops = {
 	.get_temp = cxgb4_thermal_get_temp,
 };
 
-- 
2.49.0


