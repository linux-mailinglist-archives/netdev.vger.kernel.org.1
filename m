Return-Path: <netdev+bounces-184028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC29A92F8C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A483B632A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7C25FA2A;
	Fri, 18 Apr 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duNgOfnK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD325FA24
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941200; cv=none; b=XvKE5gZp3XYr2JvylIkp9fan/7hRouXrruMXGrWWUWq4Z7nOKtba5gDIS+cLB/rRY21EgpjBFlDTvGOduYQ1FB2SBk9Sx2s55uWmhJqOMtx1t/At8bYUkRB3goutU+SYAO4+GIoMo4ic4zG1dSHbkSijXnjByJn1o540D24zRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941200; c=relaxed/simple;
	bh=kHFJGZSoA/pEqc8+qx4T/eJMDwWm/hkeoF0ARFpfpck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQZibf4zdO3Ei3cmpHXssPmZH2xHA2dcjGi/Z2XIDbCuc/3ERhL4d+LuTsRlzerkMtxczXs0ZB0GxYaqJ1ugv6XizPBYX6lZ13Q/XDhquLH22JZHCwEwdGIj99AlfqfkcIq8T6F7WnxTmVUkPTZ2qEDPNS8CZ/UNbAqnznQmKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duNgOfnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B3C4CEE4;
	Fri, 18 Apr 2025 01:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744941199;
	bh=kHFJGZSoA/pEqc8+qx4T/eJMDwWm/hkeoF0ARFpfpck=;
	h=From:To:Cc:Subject:Date:From;
	b=duNgOfnKa19FUJKfgMgcjeW0HLB4mlUmYyo546UpPwFfrXZ45NyUUzpPVMPOHqMC5
	 gb4wbekgP0tFYjvB+YQAapjjAr5egTXb0VXWnD47MKsq65IGhCu2SXFpAjUMwFkN3p
	 JfdVf4i/A2wrZUZj2nd8Aj9B4q9lGCUvS4dpVZVsgmCyZkaqLxCdBqpY7d5xaWn2ys
	 Qw2amCoVp6xf7mOOx8gKBIPrRb7tjPcU2KgWT7hx/jxOE2HSsq8woiMxaFcZwjblwF
	 qxc9y3+4PcYxQyl8TAoa802udjFwDe4+LFFjr0H+5gqR87JjvGJw/FPN800+PNTDwb
	 dPZBhJBY//0Ng==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	ap420073@gmail.com
Subject: [PATCH net] net: fix the missing unlock for detached devices
Date: Thu, 17 Apr 2025 18:53:17 -0700
Message-ID: <20250418015317.1954107-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The combined condition was left as is when we converted
from __dev_get_by_index() to netdev_get_by_index_lock().
There was no need to undo anything with the former, for
the latter we need an unlock.

Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: sdf@fomichev.me
CC: ap420073@gmail.com
---
 net/core/netdev-genl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 5d7af50fe702..230743bdbb14 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -861,14 +861,17 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&priv->lock);
 
+	err = 0;
 	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
-	if (!netdev || !netif_device_present(netdev)) {
+	if (!netdev) {
 		err = -ENODEV;
 		goto err_unlock_sock;
 	}
-
-	if (!netdev_need_ops_lock(netdev)) {
+	if (!netif_device_present(netdev))
+		err = -ENODEV;
+	else if (!netdev_need_ops_lock(netdev))
 		err = -EOPNOTSUPP;
+	if (err) {
 		NL_SET_BAD_ATTR(info->extack,
 				info->attrs[NETDEV_A_DEV_IFINDEX]);
 		goto err_unlock;
-- 
2.49.0


