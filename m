Return-Path: <netdev+bounces-216635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB68DB34B6A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106412421FE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785112989B7;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP2PEF7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEE28F948
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152156; cv=none; b=SbwyVd+qYghmf7IGSiCnEoBKBN+js7vXb9pkHuw1DGIZbu3SFZoI1qOe4RvrGEkVY5C7AZbPglzJsYpp/BtIgiw00pDnYByikG3jMYa66gMUoB35dlcOlR6LCZr6bX7RN/PObqVrbLu9xRDxntjYvCc+vPnwj43h9/xDUKqze0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152156; c=relaxed/simple;
	bh=3k7UeT4IbCxDiP+OuntyRVrkJjhlPNiuVztCIJg1vfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMrQ6xZJ2H8xMyQmle/kck7LGdk+mF9fjRLF/AdJ7AP8IFTD9uixr3V05rpbpEyZs9dJzbsyNlfPlQqBNgMf0hs/B7klw/AOyZqkaJrZL1F0mIh4ymOMBBj7FAgQwyY+AgPr8HsY5InJNdar98fLhT8EzSmzJr0JBTnjtZU2v3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP2PEF7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18328C116C6;
	Mon, 25 Aug 2025 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152155;
	bh=3k7UeT4IbCxDiP+OuntyRVrkJjhlPNiuVztCIJg1vfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DP2PEF7dgYw2onYIVMPqv+pLCkhuR4fseNNRY6Q6uOdpS6vVGINvfrk++eC8IiHrl
	 IMFlL80BampmyEGD2e7ie7Dx75UzkwQn78nyaUX7q4Q4PUBxwS8xCGmO8dICAAOtCn
	 sj69QZ6338CiNNMq8MuLU6E/4kxYk0XhS2AhxgqFQnevuaHCYpSkBKdT3b5UXjAv66
	 js/aWu4qcjnXbDiVGteMkSFKRgqbIMEA09OO4dw5rBKy8OoFd0TvkCzCYYAKqLvEso
	 Eq4eNudLBVu10eI95SZKuzX0432Liw8V8+BwCqExxDYfU4D8SLE53Kh3vfy6uLUZTe
	 pqGUIVHEmDagw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/6] eth: fbnic: Reset hw stats upon PCI error
Date: Mon, 25 Aug 2025 13:02:02 -0700
Message-ID: <20250825200206.2357713-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825200206.2357713-1-kuba@kernel.org>
References: <20250825200206.2357713-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <mohsin.bashr@gmail.com>

Upon experiencing a PCI error, fbnic reset the device to recover from
the failure. Reset the hardware stats as part of the device reset to
ensure accurate stats reporting.

Note that the reset is not really resetting the aggregate value to 0,
which may result in a spike for a system collecting deltas in stats.
Rather, the reset re-latches the current value as previous, in case HW
got reset.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 8190f49e1426..953297f667a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -491,6 +491,8 @@ static void __fbnic_pm_attach(struct device *dev)
 	struct net_device *netdev = fbd->netdev;
 	struct fbnic_net *fbn;
 
+	fbnic_reset_hw_stats(fbd);
+
 	if (fbnic_init_failure(fbd))
 		return;
 
-- 
2.51.0


