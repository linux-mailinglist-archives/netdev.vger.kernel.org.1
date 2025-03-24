Return-Path: <netdev+bounces-177257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3783A6E6BD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A499B3B2F19
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A031EFFB4;
	Mon, 24 Mar 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO2tZ4h8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7361EF368
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856361; cv=none; b=hKJpbxrj+hMXVdY9M1zD8OJQjNM//ekW2MA3dr66pwBoaL4IB66EVcegKa6OZ1uIA0GEuFuj6hNr//lImyWVehkMNVdt7bzr4+BgL+RNP6CqQPLw5eyU+WYH59JpkGmxrG1zMBwmtKcLQ+CmvsfdN6q9J9JDmGWhzD/o3rJw374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856361; c=relaxed/simple;
	bh=UJ1uMqcSjyYNXPVP+PPJN42NXmEZo49Xg9gS0iblTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5+DFFMHW7mkRymOmTGUl+PWjSfdqQUkAfJqToEyArg1DinTsoMqjDOJe7E4depXYPy+tqCvDIPb2ueb2MkiFfy8Xn1f0cq30v/6/T6Ypz8eZPpChmpPoZwp5Tu9p/giIanc4oBMyE49cDdIHWeWT76GddkARxb9c/i/x0VH7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO2tZ4h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3D1C4CEE4;
	Mon, 24 Mar 2025 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856360;
	bh=UJ1uMqcSjyYNXPVP+PPJN42NXmEZo49Xg9gS0iblTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LO2tZ4h8ul0HENj2eajtOVrMlvnlZoTyUmJZC26AF+qxq4eHfoyyw6bv6mJmkk1Zv
	 YBdnYfmYXxdwS8nzNEXNQ7sczLRYZgg9eZDzhNtO17NOE9iVNalJJAmnVsWeW1GXwD
	 EJyb+JXMUI5hr0RgKwMDCDo2ok+l60ZxVcin4dTO9bVmc16yXbIpO6sYgpBo4u0DG4
	 TFKW7mRGKuJqQ6UHhTMzB6h3ialaB56tlXav6gSqDbExtpNqjPRyCvZll2rDZX4an3
	 tgWIg1FvQge3Yjug08PoOJpbrcqxS4fm8mpsa2NS22oVnFSxymHIseMWvoWwb3/NyT
	 /cwYDVzo4gJtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/11] net: constify dev pointer in misc instance lock helpers
Date: Mon, 24 Mar 2025 15:45:29 -0700
Message-ID: <20250324224537.248800-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
References: <20250324224537.248800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep asserts and predicates can operate on const pointers.
In the future this will let us add asserts in functions
which operate on const pointers like dev_get_min_mp_channel_count().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_lock.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 99631fbd7f54..689ffdfae50d 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -11,19 +11,20 @@ static inline bool netdev_trylock(struct net_device *dev)
 	return mutex_trylock(&dev->lock);
 }
 
-static inline void netdev_assert_locked(struct net_device *dev)
+static inline void netdev_assert_locked(const struct net_device *dev)
 {
 	lockdep_assert_held(&dev->lock);
 }
 
-static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
+static inline void
+netdev_assert_locked_or_invisible(const struct net_device *dev)
 {
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING)
 		netdev_assert_locked(dev);
 }
 
-static inline bool netdev_need_ops_lock(struct net_device *dev)
+static inline bool netdev_need_ops_lock(const struct net_device *dev)
 {
 	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
@@ -46,7 +47,7 @@ static inline void netdev_unlock_ops(struct net_device *dev)
 		netdev_unlock(dev);
 }
 
-static inline void netdev_ops_assert_locked(struct net_device *dev)
+static inline void netdev_ops_assert_locked(const struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
 		lockdep_assert_held(&dev->lock);
-- 
2.49.0


