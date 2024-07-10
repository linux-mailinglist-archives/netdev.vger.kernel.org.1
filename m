Return-Path: <netdev+bounces-110686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695CA92DC21
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 00:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21D9B25935
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D61494BB;
	Wed, 10 Jul 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ8B4Pyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EEF1411ED
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652142; cv=none; b=Lns9x7UJX0y7HumqE0dDh0t1t3lc38e5GAm8qGTY9zyLz9J3aQwaQpdonHPLIZ7MPS1lTyNGFxO61OGIgD6fChOhymeyzR+XEm78eb7NedsFCumqsvh25+SafA1bowP2S0iirkWgEzbnqw/VNjEg/MocJTWUyE4fHnaYJGM77Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652142; c=relaxed/simple;
	bh=hnZ6YRlP8dYE9NLmUqOpeSTTVgarH7eYZaAmM9n+fW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjnARE7YZAUWyyclHyFKr+3i5AWPyxLGRTPNqEkBWuma7YkLMx+AOp1s7jIHINOOQVF96MsMJKm3uBD+hYGWOvuoztKQkEEkGA8o4rS2li89C4i/Q93PWbFqtZornQeAeis0dd2g1DkwqmbZpBCp3gPcFkrdUt4OcqykHh5rY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ8B4Pyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB6AC32781;
	Wed, 10 Jul 2024 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720652141;
	bh=hnZ6YRlP8dYE9NLmUqOpeSTTVgarH7eYZaAmM9n+fW8=;
	h=From:To:Cc:Subject:Date:From;
	b=RJ8B4PydXRjiespj/4Ac4yoXhI/HZbXlTDBy0Fz4RIqgR0aeOfc32wU8JFSTIZOGs
	 AHNGqMAIZGw5rn5dYmIpILlT4emR4y3e9Wq+qNXIvcTl/qPi1C5yGTIQ/rgsTFq9B/
	 3fAZnb68bRyxkhb2sc4WDNv6UdIxXKrbFLS4IrOWxyp7fgN27EIeVVVNsXcF5i3dgh
	 p+FTERY4XsOz11N+98GUrjiLqXeiF5kV8bPjAOZ++RotMp98FAgYzTMt8ZZzjSzxqy
	 IBu4tEnzwLMPGi2lhcZb/r5a+Q6iYGck1q2Ubn51wfAY2Ree0JCQ3ERybV/iBTYn/u
	 QJCrIxN7ysfGA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	David Wei <dw@davidwei.uk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net] net: ethtool: Fix RSS setting
Date: Wed, 10 Jul 2024 15:55:38 -0700
Message-ID: <20240710225538.43368-1-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

When user submits a rxfh set command without touching XFRM_SYM_XOR,
rxfh.input_xfrm is set to RXH_XFRM_NO_CHANGE, which is equal to 0xff.

Testing if (rxfh.input_xfrm & RXH_XFRM_SYM_XOR &&
	    !ops->cap_rss_sym_xor_supported)
		return -EOPNOTSUPP;

Will always be true on devices that don't set cap_rss_sym_xor_supported,
since rxfh.input_xfrm & RXH_XFRM_SYM_XOR is always true, if input_xfrm
was not set, i.e RXH_XFRM_NO_CHANGE=0xff, which will result in failure
of any command that doesn't require any change of XFRM, e.g RSS context
or hash function changes.

To avoid this breakage, test if rxfh.input_xfrm != RXH_XFRM_NO_CHANGE
before testing other conditions.

Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
CC: Ahmed Zaki <ahmed.zaki@intel.com>
CC: David Wei <dw@davidwei.uk>,
CC: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 net/ethtool/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e645d751a5e8..223dcd25d88a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1306,7 +1306,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
 	    rxfh.input_xfrm != RXH_XFRM_NO_CHANGE)
 		return -EINVAL;
-	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+	if (rxfh.input_xfrm != RXH_XFRM_NO_CHANGE &&
+	    (rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
 	    !ops->cap_rss_sym_xor_supported)
 		return -EOPNOTSUPP;
 
-- 
2.45.2


