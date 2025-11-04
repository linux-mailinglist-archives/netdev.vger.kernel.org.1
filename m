Return-Path: <netdev+bounces-235630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2EC335F1
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9201834C271
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D92DEA61;
	Tue,  4 Nov 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxGBByuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532572DE6E1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298636; cv=none; b=L4iSuzoY2pCWKTz9id5OFIxTGhhdYng5IP6dclHnhJ2BcZZHac+23BRi+OqxyweoCkTxylth3khPU3iepoUXBNCbqmG3IazXhIAco/zXiJ7Vo39fzcctO9eqOMA+KYEatcUzdrGCSFRJzv1x8zlBlLjtuYrK/0g+q3I9B4/Zkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298636; c=relaxed/simple;
	bh=sOzI8Yb1Z4jNb5soTjkO/fj6rL9zn6F3kx6ZJxKCono=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7IkEBTEw78Bao8rgJ88D6k1p8erDmYXDHI1QHg7qPJ0QU3aL0HRRwzmysvOEjk323WnQVeGdA/Xvic5WRABPcG2w5lN2GCHmB3CQ7DzttPCNTHDDWcffzsyXWPoW4LQmFzuEEH/YvsXqP/GyBidWSWhyQc636AFHS16vAU3xFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxGBByuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBD2C116B1;
	Tue,  4 Nov 2025 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762298636;
	bh=sOzI8Yb1Z4jNb5soTjkO/fj6rL9zn6F3kx6ZJxKCono=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxGBByuA4oXvEq+bcUrJDd8NVI9axc3axttVbLC0J6BExzSB+UlYMbMUyGgkPZgXr
	 hta57ZLNL45GRDGe1+z/10m7swIN/ehuY2LdDb6G6RD4lDrfoD3AFsHq4yMIH/nJ1m
	 n/cpbM9vxPkrxv7Dz62G/3ggEeyNn/Q/OZXQjXFXcQU5DTHzW8EtbRIaCIF4YCNvD6
	 CN6TWG36HwymWJXT4GeE1PPVOz0X6iHJZZOP8kbdd6VOYVgKdOiBsr42wlcsLeVo+s
	 QmJfbs9mdbiT3IjIdapW7Y+IynPrUUlOPWaBnwNaty0EGnfPxL8CAMOjRQf8fSvzXQ
	 +gNV41jJb784g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	joe@dama.to,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] netlink: specs: netdev add missing stats to qstat-get
Date: Tue,  4 Nov 2025 15:23:44 -0800
Message-ID: <20251104232348.1954349-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104232348.1954349-1-kuba@kernel.org>
References: <20251104232348.1954349-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing entries in C attribute list.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 10c412b7433f..82bf5cb2617d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -733,6 +733,29 @@ doc: >-
             - rx-bytes
             - tx-packets
             - tx-bytes
+            - rx-alloc-fail
+            - rx-hw-drops
+            - rx-hw-drop-overruns
+            - rx-csum-complete
+            - rx-csum-unnecessary
+            - rx-csum-none
+            - rx-csum-bad
+            - rx-hw-gro-packets
+            - rx-hw-gro-bytes
+            - rx-hw-gro-wire-packets
+            - rx-hw-gro-wire-bytes
+            - rx-hw-drop-ratelimits
+            - tx-hw-drops
+            - tx-hw-drop-errors
+            - tx-csum-none
+            - tx-needs-csum
+            - tx-hw-gso-packets
+            - tx-hw-gso-bytes
+            - tx-hw-gso-wire-packets
+            - tx-hw-gso-wire-bytes
+            - tx-hw-drop-ratelimits
+            - tx-stop
+            - tx-wake
     -
       name: bind-rx
       doc: Bind dmabuf to netdev
-- 
2.51.1


