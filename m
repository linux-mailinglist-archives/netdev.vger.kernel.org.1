Return-Path: <netdev+bounces-169528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD13A4465B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDB4864ECE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1000B191F88;
	Tue, 25 Feb 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2BOy44o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BC18CC13;
	Tue, 25 Feb 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501234; cv=none; b=XnppoNEuBdp+X7GODUO88fzZziWLLTXfgw0+nQ2yjdyZQJKXrVcut//mhwLRb9hy01dSzEZFW2Oob4jrmk+H0zYuuPZHY7zuss9NnDayup/skDGgdkZFWm4l4gpqt6R5bgWjh3ez91j5Nv1TLY2zpZkHwJx05Qfy+Hmxc47vL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501234; c=relaxed/simple;
	bh=9tGh2HWyNv6c7Vy8Mx5KhC6FT6KWx47BEFMdAXgxZeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4jX24uggD9TBJfrjBCP/DDSpleS82yUTKBVNU6vsHJTizc7RlJo7qnpenHeQc4w1KyVd58QM1DebVugYh3gKIKsRkHBv/BzGqDOZuv5CkNbGKaZryqhiiBwEnH+4CEDQJgW8Vo1BoeWMRnrC54QD27T8A8v81uUfr5k6He3BFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2BOy44o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAB5C4CEE6;
	Tue, 25 Feb 2025 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501232;
	bh=9tGh2HWyNv6c7Vy8Mx5KhC6FT6KWx47BEFMdAXgxZeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2BOy44oLSkCmx5VkvR2s2oNRPoSJIImi2S5WPhVxvt4zkZY9QMB9NF/rhyLoP6Uy
	 w3V7h2sAjacF8NMvuoZRoAi9Yt84d5So2FsfbrSKviBMr9ADr+l4EoHnPlfhjtXSU7
	 8EWchKXBXH2H87dIO+Dh2nPVpSkr+Z8O3pck/4DrmsTteEEvgHQN9a1Z1norsKbdBB
	 1ERAZ1CXkHYl5nPKCD7pqoY93Hw3wMFIn/6Y8svvVvQuti23a+YPBnd1euoVQlsphA
	 mcmZp1HAPUvT5doKj1WVEVMxX4fZEyIgAgGV9I83dvKmSb7MbRKuYaxEh8uKRWz2xT
	 2xby/q5kEFdIQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Tue, 25 Feb 2025 17:33:33 +0100
Message-Id: <20250225163341.4168238-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225163341.4168238-1-arnd@kernel.org>
References: <20250225163341.4168238-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about xge_acpi_match being unused when
CONFIG_ACPI is disabled:

drivers/net/ethernet/apm/xgene-v2/main.c:723:36: error: unused variable 'xge_acpi_match' [-Werror,-Wunused-const-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/apm/xgene-v2/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 2a91c84aebdb..d7ca847d44c7 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -9,8 +9,6 @@
 
 #include "main.h"
 
-static const struct acpi_device_id xge_acpi_match[];
-
 static int xge_get_resources(struct xge_pdata *pdata)
 {
 	struct platform_device *pdev;
@@ -731,7 +729,7 @@ MODULE_DEVICE_TABLE(acpi, xge_acpi_match);
 static struct platform_driver xge_driver = {
 	.driver = {
 		   .name = "xgene-enet-v2",
-		   .acpi_match_table = ACPI_PTR(xge_acpi_match),
+		   .acpi_match_table = xge_acpi_match,
 	},
 	.probe = xge_probe,
 	.remove = xge_remove,
-- 
2.39.5


