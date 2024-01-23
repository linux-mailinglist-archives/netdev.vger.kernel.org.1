Return-Path: <netdev+bounces-65211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E577C839A46
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247891C20B60
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31D1FB2;
	Tue, 23 Jan 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="RB0Dk8De"
X-Original-To: netdev@vger.kernel.org
Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB21846
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041852; cv=none; b=fN2y9t78Z5OQET/ZOA52k/UeYG2WKryJ3OOQg2MQiZ+2cn89Sf8gzOdrA61lx1IwV83/y03NfDiIhw7QL6YJzTZ/n7XIK+po35O9pX00moNMcGdeCY08SYrWtDmYZNc+8WF59+SB+62pl32ElsWu5Bia+BgoiOSpEDRp72/EpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041852; c=relaxed/simple;
	bh=hPcQ7UVUklJaKSH4XRz88q+EkLvpdqbuf2WB9hE2LK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMqbkW5sZ2ABv72bXIQ+XVLPDdKqGo3g7IylYg286iAs8Cy1dPgU9U+Ogwwo1B40HWFQETdg91Px99EO0I6oPzl7xQuLUBqJszqBgUdMT8YLw1PI/PemuMLbByR54XZIF42RNwBJ8a06ClQx7x6InR8tigSbWfAfxMLoFDoizzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=RB0Dk8De; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sxje/we5wMTDkxQNhrs/IkD3722ScLh2AuYF3kJWl1M=; b=RB0Dk8Del3rC0dZReaFuTaA2yI
	xnAIAQIEfwD5ibxAuzXCaK8cqXsovo6i7NnQnYpcg6T9zsHYnhpQhpHGMpYM+F982Hf6JW/6sTiME
	1858Zq/c0e2i03iIrm8LMRaorLHjCnzfclpXsqJkihhv+ZSzsCrMhikVF3WORRT2SAjk=;
Received: from [88.117.59.234] (helo=hornet.engleder.at)
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rSMy5-0005Fp-0p;
	Tue, 23 Jan 2024 21:01:57 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next] tsnep: Add link down PHY loopback support
Date: Tue, 23 Jan 2024 21:01:51 +0100
Message-Id: <20240123200151.60848-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

PHY loopback turns off link state change signalling. Therefore, the
loopback only works if the link is already up before the PHY loopback is
activated.

Ensure that PHY loopback works even if the link is not already up during
activation by calling netif_carrier_on() explicitly.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index df40c720e7b2..0462834cf6e1 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -229,8 +229,10 @@ static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
 	 * would delay a working loopback anyway, let's ensure that loopback
 	 * is working immediately by setting link mode directly
 	 */
-	if (!retval && enable)
+	if (!retval && enable) {
+		netif_carrier_on(adapter->netdev);
 		tsnep_set_link_mode(adapter);
+	}
 
 	return retval;
 }
-- 
2.39.2


