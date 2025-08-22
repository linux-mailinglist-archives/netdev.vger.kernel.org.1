Return-Path: <netdev+bounces-216103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A213B320BF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8656EAE0D14
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0C30AADA;
	Fri, 22 Aug 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN5gtqXd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530A3090C1
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881266; cv=none; b=qNha4mUDEkRPwsIjue9hsk/HkAnglaK2vn0buoMpVJxgOlkEcXQ+V2UpKTa0PlNk+4FN9dj9nQernPF6ClAMuyqeA535bJLL/dQh+tZvFUbLXiqqfdarvRA3O9Wo8CHvO6825VzS5xeItzkMe6rUFgKJRrsTG/OPB3WO6SRUbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881266; c=relaxed/simple;
	bh=2ymVpICysMBbgA/xiODAMv3y9zb88YGUYwk9GsNpXoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyoG3y25ngHe327mZtxg/tC/2CbzJ8FI8Kl86CcLU9t4BUjj6e7nX+XhWtFIbL9U3+3Hq7RTX7CPucLw/niqWMucwwzbjNdNLCECaVTr7O/WlVh04NKF9YjPhPKvlmUL291ER23u/B5BjnJayA2eaOmTXmXQZUQXLCr7v0sMHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN5gtqXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C12C116B1;
	Fri, 22 Aug 2025 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881266;
	bh=2ymVpICysMBbgA/xiODAMv3y9zb88YGUYwk9GsNpXoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN5gtqXdavWatqXDYKZIZDYjn/TBXkUMdousVVDynt1V4YBANi2SNdXeUpXP0r9JI
	 KbQ7USCMb1jwwpAjd/4QfABGyaxhBvRPEOFfptWh5sH9es3Z3heUQGW9s36Uc9hALY
	 dwmqc+8Y/6xLTFnbw0YCBlrsWqpuD9rZwhszhrJGJbu74C95RINq0TvejsHGi71akc
	 xGAGQr9tjyKR/bJ9qj8+V5MDMXTNzhqK6q/HVFo7smJh/g6XENIh8DmrCp46jn4y4W
	 kBiRxDuHP9K+FnostRDlG6jAq2aW+F4rknth7qYessjZVkMEtzOpF9vvyYJA7qekML
	 zCSRx7qn5YGBA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/6] eth: fbnic: Reset hw stats upon PCI error
Date: Fri, 22 Aug 2025 09:47:27 -0700
Message-ID: <20250822164731.1461754-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822164731.1461754-1-kuba@kernel.org>
References: <20250822164731.1461754-1-kuba@kernel.org>
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
2.50.1


