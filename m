Return-Path: <netdev+bounces-200946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4377AE76F6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1671517A239
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DBB1E32BE;
	Wed, 25 Jun 2025 06:30:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F61E22E9;
	Wed, 25 Jun 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833054; cv=none; b=c5ZNFdmuuCQO7ezdU0bkObfUpFHSyvznpxkr8GgMkDjWK7E3HIw0zRBy0qHzn/Ob8Q8pZQ/A8yhXzT4IexbdaEiosdixr9WsL4Bj95ZXa9j6D33wpVzVOgW2Aj/cIJti2C3TNN66Hte7vDofLIdB1pO9RcH5IEKCdhIMlndDQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833054; c=relaxed/simple;
	bh=0DmpiE86b3h6Tk6TDyy+aBf1mLPeANuLJfPvqq+zFXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NpS5H2HpiuYPM4E7+OsyS9ojlAwoSE6KB/Etyqs6b5wleFqE+ywv0a+j6fSaMW88KXc5SNkwpcIlNKHn/4Q4lDHI0FiepvMkaXV/ajtMMTzIALhJbqEz17nJtPL96pI1RMIDRx61PoPIy/4Ms4KsUCmpElVfdjM4Ec9T0ewUsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bRsNS35Zjz2TSr7;
	Wed, 25 Jun 2025 14:29:12 +0800 (CST)
Received: from kwepemk100010.china.huawei.com (unknown [7.202.194.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 89E1C1A016C;
	Wed, 25 Jun 2025 14:30:49 +0800 (CST)
Received: from workspace-z00536909-5022804397323726849.huawei.com
 (7.151.123.135) by kwepemk100010.china.huawei.com (7.202.194.58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 14:30:48 +0800
From: zhangjianrong <zhangjianrong5@huawei.com>
To: <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <guhengsheng@hisilicon.com>, <caiyadong@huawei.com>,
	<xuetao09@huawei.com>, <lixinghang1@huawei.com>
Subject: [PATCH] [net] net: thunderbolt: Use correct request type in login/logout request packets
Date: Wed, 25 Jun 2025 14:30:48 +0800
Message-ID: <20250625063048.1602018-1-zhangjianrong5@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100010.china.huawei.com (7.202.194.58)

It doesn't make sense to use TB_CFG_PKG_XDOMAIN_RESP as the request
type of xdomain request packets.

Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
---
 drivers/net/thunderbolt/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 0a53ec293d04..439d1b21f3b7 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -269,7 +269,7 @@ static int tbnet_login_request(struct tbnet *net, u8 sequence)
 	request.transmit_path = net->local_transmit_path;
 
 	return tb_xdomain_request(xd, &request, sizeof(request),
-				  TB_CFG_PKG_XDOMAIN_RESP, &reply,
+				  TB_CFG_PKG_XDOMAIN_REQ, &reply,
 				  sizeof(reply), TB_CFG_PKG_XDOMAIN_RESP,
 				  TBNET_LOGIN_TIMEOUT);
 }
@@ -300,7 +300,7 @@ static int tbnet_logout_request(struct tbnet *net)
 			  atomic_inc_return(&net->command_id));
 
 	return tb_xdomain_request(xd, &request, sizeof(request),
-				  TB_CFG_PKG_XDOMAIN_RESP, &reply,
+				  TB_CFG_PKG_XDOMAIN_REQ, &reply,
 				  sizeof(reply), TB_CFG_PKG_XDOMAIN_RESP,
 				  TBNET_LOGOUT_TIMEOUT);
 }
-- 
2.34.1


