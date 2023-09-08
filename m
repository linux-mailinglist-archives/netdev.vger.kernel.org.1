Return-Path: <netdev+bounces-32642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E72798DE1
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5042D1C20DAA
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0815AE0;
	Fri,  8 Sep 2023 18:18:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BC15ADF
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A11C116AC;
	Fri,  8 Sep 2023 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197093;
	bh=2moswtduosVbZCi0XcHr4sw4xQU3JElaiZvKOBG6Qis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fudkfAr0b7UQ2bclaDvffGKVpw8ztgqx0DEhp3x0BQDhpFDZB1iga4yj7SaQA9rXp
	 MO7x4aaPHhOaVEQcprPXnEx+WEiRwkdJoLCoC5hfG6oJ07tGgUlrpp5qbw2r/zElcQ
	 X9H8JPtTUVyWRZO7KVaCNXhTPdslRiXTI/az1ywY9yj0BBjIm8Xw2TssHf4PCdygtL
	 p1mDTT5+OHfEQNxgqphqXUVaKeLeUVIZG9h7zo4tCYC09wCfoGjcqJ35J7hhBcSoS7
	 c/uxZ7qlwzTveS2kjP/OnU7BaIxY0GEpnfN+73YP1EUsw6+GLe8JUhKNW6PtFWuVop
	 fiO97IIN7ovdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <simon.horman@corigine.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/26] ice: Don't tx before switchdev is fully configured
Date: Fri,  8 Sep 2023 14:17:41 -0400
Message-Id: <20230908181806.3460164-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

[ Upstream commit 7aa529a69e92b9aff585e569d5003f7c15d8d60b ]

There is possibility that ice_eswitch_port_start_xmit might be
called while some resources are still not allocated which might
cause NULL pointer dereference. Fix this by checking if switchdev
configuration was finished.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2ffe5708a045b..7de4a8a4b563c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -361,6 +361,9 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	np = netdev_priv(netdev);
 	vsi = np->vsi;
 
+	if (!vsi || !ice_is_switchdev_running(vsi->back))
+		return NETDEV_TX_BUSY;
+
 	if (ice_is_reset_in_progress(vsi->back->state) ||
 	    test_bit(ICE_VF_DIS, vsi->back->state))
 		return NETDEV_TX_BUSY;
-- 
2.40.1


