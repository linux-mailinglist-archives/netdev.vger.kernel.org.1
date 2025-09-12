Return-Path: <netdev+bounces-222618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE83B55052
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA017C11BC
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01A310645;
	Fri, 12 Sep 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ZTWHkJ8m"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBAF30F7EB
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685836; cv=none; b=kqf56L8Hbl0sraGnAUOi7QsZk+uuZyoW1uS3jRIGAhNuel5fVfIGatz6Mi5WmrA+gsW2AMoXFK8dIdttKuLWECg64z5dw98XytZfkbVBFIoA0aSabBZH445GGnFSLKCUymxKDJr6ASUYWq7Q+rQxZw53K9lhbnrU6YrmnAN+TlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685836; c=relaxed/simple;
	bh=18MbLXzpcg88toBsGyeleYM1IOWWC8aBgWHkIekPACA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UU1rfTc/xUs6fIf4sfvl9maEZcUjVmr0+BPeOrVYNIN3tRzxXbqGGfJoMecL/BETxLV6Ga1XF76QUO6d9hjP1w5z+b//mIalIgRzQ8oBJKT17QIwBwmlEM1sJTgO/OIyln2/J3vdeiu/FE54oL8sHnRwG5sgB0t8sEhqmqCShLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ZTWHkJ8m; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1757685827; x=1758290627; i=wahrenst@gmx.net;
	bh=Tfks3ZAoNd4N6vNR0zKPjQteC1dazu1TTAxm/8EmIy0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZTWHkJ8mlKeMGpPNV6gGrZVdGgwPkzI/hXh4HSuT9KRSSh5rkgcwHfhiqKugvZd/
	 7Z8E2hj25+cJ48CJ9q1YdYEgb/waTILdsEYSRa6azBmofufT8UTz7rdVZou5gTuyw
	 5swMLS1+5THMSw3qK12yvvglJxsE9ZAj+NMUg45KMxxGHfiDb7nrxouDDh0AppD4j
	 3659iMWwIlYJVafv+BTrkfSBbFeieUN/JBkUhTWE75DAzGWBb17HUURGTgPmr9mfy
	 9jSM9gR7H5ib1C0NDVnqo+cELBxdCfy9nQGCJi9kO+W/3z3KJGIjOI5PwvZuBtjJw
	 we/SrAD8VW1OA9k2WA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1uU4gp2Tc6-00qbYA; Fri, 12
 Sep 2025 16:03:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 2/2 net-next] ethernet: Extend device_get_mac_address() to use NVMEM
Date: Fri, 12 Sep 2025 16:03:32 +0200
Message-Id: <20250912140332.35395-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912140332.35395-1-wahrenst@gmx.net>
References: <20250912140332.35395-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWvHeySpJZUpz7PzeXFLNgXCUjL5i8eZQXWIkEQISIhsWnK7BC9
 MZKwu+i5igXe84/U5kuaISxjFUM0uIO00MPhco7jd6w9cOxkldEIjDwwpO7hEsg0bOtaN0o
 uLW8Guh69tO8s1FPadG7jdW/nDVlokJSwqLQa7+4kn63o7jWjwoUYbhcla1DZ/9LtWgtaXu
 zzaH8ClRCkWiGNBmRMyXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jDk3+Sv+Zpg=;srwXutLzvT0JKPe4c7tlbgD9oVH
 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
 /BkEXsmx36

A lot of modern SoC have the ability to store MAC addresses in their
NVMEM. So extend the generic function device_get_mac_address() to
obtain the MAC address from an nvmem cell named 'mac-address' in
case there is no firmware node which contains the MAC address directly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 net/ethernet/eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 4e3651101b86..43e211e611b1 100644
=2D-- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -613,7 +613,10 @@ EXPORT_SYMBOL(fwnode_get_mac_address);
  */
 int device_get_mac_address(struct device *dev, char *addr)
 {
-	return fwnode_get_mac_address(dev_fwnode(dev), addr);
+	if (!fwnode_get_mac_address(dev_fwnode(dev), addr))
+		return 0;
+
+	return nvmem_get_mac_address(dev, addr);
 }
 EXPORT_SYMBOL(device_get_mac_address);
=20
=2D-=20
2.34.1


