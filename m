Return-Path: <netdev+bounces-139187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7679B0CAE
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 20:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ADF1C221DC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B8189F45;
	Fri, 25 Oct 2024 18:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F63524F;
	Fri, 25 Oct 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879710; cv=none; b=lxXeRGuZp88j0WLH3WePEQNxMQIFa/Xmzt08VycBgam+oJLkdJHPfEa9y1Jr7Ea9HWT5lUTy1itNb3rSNSx+ZEGf7UGucWxj/DCU1crPyAGvAWXnWGupVlpgFkftZ4yc/EwDySpdTK1U7aiyYHbax7RlYnnAV8XynRkhb0v3NXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879710; c=relaxed/simple;
	bh=C58FuUNaOUL1vyt3RYD5GSs3VU2MrYiAmSNxI09uajw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eo2vCMpz45hsjy5T5vWjGqCPa6xfRImhOBeju2/pW23IkmAm15SBWtRQ6/p93d55oOAgmruQ1+m4OJ5+cQ1B6GUTpFKJEBu1dj9Uu/b/u0ZFd/LpA9LTZvDB0zBBiL3tfjmZOmAsA2N5FyFJqK6VrOG6lTahVdvezUTo7U1Yy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.19] (port=24734 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1t4OKQ-000000001Nl-6STd;
	Fri, 25 Oct 2024 20:42:26 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1106.mail.hosting.nic.ru (Exim 5.55)
	with id 1t4OKP-00FwYI-37;
	Fri, 25 Oct 2024 20:42:26 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Sudarsana Kalluru <skalluru@marvell.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net-next v2] bnx2x: remove redundant NULL-pointer check
Date: Fri, 25 Oct 2024 20:42:03 +0300
Message-ID: <20241025174209.500712-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.43.0
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

It is impossible to get NULL for those.

Remove superfluous NULL-pointer check and associated
unreachable code to improve readability.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
v2:
  - remove confusing part of commit message as Simon Horman <horms@kernel.org>
  suggested in https://lore.kernel.org/lkml/20240715181029.GD249423@kernel.org/
v1: https://lore.kernel.org/lkml/20240712185431.81805-1-kiryushin@ancud.ru/
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 12198fc3ab22..0f121b15f5d7 100644
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
2.43.0


