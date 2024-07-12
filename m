Return-Path: <netdev+bounces-111144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B193009E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173F51F247D4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EA1D554;
	Fri, 12 Jul 2024 18:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB21DA21;
	Fri, 12 Jul 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810501; cv=none; b=Koi52zOvNkprXeHY6K6aEYopAmXCzEkTzlBM26rf3YnXyUNby9ybbhiN3nPix/appnFUBqjjQWIYgYt6Yiq3S1EeUNNnKln1ySOUWz7NjM//FZOl9lUe2UtnLRU2pmO7L2H4ta9pqT/OciYauHm9aNKx7hM6HhBY3qfbUji2fto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810501; c=relaxed/simple;
	bh=EfrYKP/JO+F/p9IArrs8s8ePFtOhpBOMdprKxw03jGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8JnpU+ob0HNwq0Rbgs5CCAhX1lYnM2U8M8/re+aVmYIuaiblWjSnjOIrdNXrI712Ivu0308OAodZWd5hPkrz6v5SDnztKF1aJRWSbP7NHlAUT8MeLpSdEcZsdxZmxt92jiTMXJArlUXREsNSTGM5332nu12jRICyv2BwK1okfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=28700 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sSLPs-0002cJ-6d;
	Fri, 12 Jul 2024 21:54:48 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1sSLPr-001O2p-33;
	Fri, 12 Jul 2024 21:54:48 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Sudarsana Kalluru <skalluru@marvell.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net-next] bnx2x: remove redundant NULL-pointer check
Date: Fri, 12 Jul 2024 21:54:31 +0300
Message-Id: <20240712185431.81805-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

bnx2x_get_vf_config() contains NULL-pointer checks for
mac_obj and vlan_obj.

The fields checked are assigned to (after macro expansions):

mac_obj = &((vf)->vfqs[0].mac_obj);
vlan_obj = &((vf)->vfqs[0].vlan_obj);

It is impossible to get NULL for those (and (vf)->vfqs was
checked earlier in bnx2x_vf_op_prep).

Remove superfluous NULL-pointer check and associated
unreachable code to improve readability.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 77d4cb4ad782..3415bbe722a8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2619,10 +2619,6 @@ int bnx2x_get_vf_config(struct net_device *dev, int vfidx,
 
 	mac_obj = &bnx2x_leading_vfq(vf, mac_obj);
 	vlan_obj = &bnx2x_leading_vfq(vf, vlan_obj);
-	if (!mac_obj || !vlan_obj) {
-		BNX2X_ERR("VF partially initialized\n");
-		return -EINVAL;
-	}
 
 	ivi->vf = vfidx;
 	ivi->qos = 0;
-- 
2.34.1


