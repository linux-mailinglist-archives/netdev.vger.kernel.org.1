Return-Path: <netdev+bounces-118899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0595373A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5430B1F24490
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695641B14E9;
	Thu, 15 Aug 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q88A0Fgs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A81AD9E8
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735676; cv=none; b=KdYMGEnoQ0/a1IFyBxprbVWj3g1HK9NyG/NE/35mAore/9g6ydwynLyvDJfkFgYfnIsgKcX0ebmxKZqIqWteJ+mrVi0zVUgv8qjaj4pYGrCNd7H9CndDeXqCc5lcOa9Dk+Rk9LhHDebH571lI06/h+7LuUee2+6WtmWtemtFgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735676; c=relaxed/simple;
	bh=nlfVceDfn+eu/v+US8ia0FM8XRpZEZXt52viuNdEtO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CC5uwuenwAMum1xJXW23pzb59w/t9KCVfaLa09zpjwEEK6eEkrEd7lzFW4COqYYELVxZhOtIsJx6weojsps3PWG1ouurcNYgrTkyQeumtCI8DCxxDdz48F4ONz3ITSXHAq0CyZUZiprpywuigYycIw98Sb02dbB1V1YFB49MwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q88A0Fgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B115C32786;
	Thu, 15 Aug 2024 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735675;
	bh=nlfVceDfn+eu/v+US8ia0FM8XRpZEZXt52viuNdEtO4=;
	h=From:Date:Subject:To:Cc:From;
	b=Q88A0Fgs4Eye72AUmr8wbfsYk2JqWlq+kt0BMvRMNSXOcM5SDRWO/Use9lZCR4Tse
	 IfHqh1aZJsjHfDCon3DhncYv3F+Rj1u97zWq6VmCRRwg3mEnuzmeEvKAIXjYk45t/+
	 stgbXyfoHW7L3mXq7V2exGTHM8gGNFQK24D+ju8Mayd9/nQXsuebb1aRVOKi+0uzj9
	 Y26P4Tq/WiuHmoGnieA1kIGmUtMGDVL2FmH31/ThUpzxQYfZe1svHPf6VF/HUZYWQt
	 5/LFqSfASKEi7U+u0yjFeSG3UoS9qb2H7eOFkfRFK6ydUMgiQjniMY1Kk4Ctbvfdgd
	 xuYtQRPOKZQRA==
From: Simon Horman <horms@kernel.org>
Date: Thu, 15 Aug 2024 16:27:46 +0100
Subject: [PATCH net-next] bnx2x: Set ivi->vlan field as an integer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-bnx2x-int-vlan-v1-1-5940b76e37ad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHEevmYC/x3MQQqDMBBG4avIrDsQo4L1KqWLaf3VAZmWJEgge
 HeDy2/xXqGIoIg0NYUCDo36s4r20dB3E1vBOleTd753Yzvwx7LPrJb42MUYz7GbRboFXqhG/4B
 F8z18kSGxISd6n+cF8vNUgWoAAAA=
To: Sudarsana Kalluru <skalluru@marvell.com>, 
 Manish Chopra <manishc@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

In bnx2x_get_vf_config():
* The vlan field of ivi is a 32-bit integer, it is used to store a vlan ID.
* The vlan field of bulletin is a 16-bit integer, it is also used to store
  a vlan ID.

In the current code, ivi->vlan is set using memset. But in the case of
setting it to the value of bulletin->vlan, this involves reading
32 bits from a 16bit source. This is likely safe, as the following
6 bytes are padding in the same structure, but none the less, it seems
undesirable.

However, it is entirely unclear to me how this scheme works on
big-endian systems.

Resolve this by simply assigning integer values to ivi->vlan.

Flagged by W=1 builds.
f.e. gcc-14 reports:

In function 'fortify_memcpy_chk',
    inlined from 'bnx2x_get_vf_config' at .../bnx2x_sriov.c:2655:4:
.../fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 77d4cb4ad782..12198fc3ab22 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2652,10 +2652,10 @@ int bnx2x_get_vf_config(struct net_device *dev, int vfidx,
 		/* vlan */
 		if (bulletin->valid_bitmap & (1 << VLAN_VALID))
 			/* vlan configured by ndo so its in bulletin board */
-			memcpy(&ivi->vlan, &bulletin->vlan, VLAN_HLEN);
+			ivi->vlan = bulletin->vlan;
 		else
 			/* function has not been loaded yet. Show vlans as 0s */
-			memset(&ivi->vlan, 0, VLAN_HLEN);
+			ivi->vlan = 0;
 
 		mutex_unlock(&bp->vfdb->bulletin_mutex);
 	}


