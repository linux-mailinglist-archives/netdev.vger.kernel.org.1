Return-Path: <netdev+bounces-174396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F0A5E784
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC767ABB3B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11E1EF397;
	Wed, 12 Mar 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNPZ7OHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B501DFD95
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818925; cv=none; b=GeZjbOuL3O5WNilS2dPEtNS5VPE1XWWEr3kwxIMMtklXL58etChatJW8QzOIzL0xTxnnQWAhbSYnpirzTamiAIr0fFFsFrkw0NOycMUa+TmZjaIz4ii/Qki1AFkUeUoaFRC6XNPwrY0w8lGThgB6dhwhmKnywfOV8bJySl8JpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818925; c=relaxed/simple;
	bh=CfUwrM2V/e72+UB4UGgtb91j5B0Cx+t37H2hoW+n3II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP8SMWCmzuZh7ZnL0MX2OEKKdYw9ZsH1csm1sBLeyuCMSsIVvffawdEoVCf+48sRmXZefUAhdD3P/dDOsH16HXOX0zgelzBIcYiiGUiz+qFXcZuOuO2JHhFSoxiLJ8PibtKVhsF5y5VxmvzY6ieL/QVSjjj4g5A/O2yKtaA6KZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNPZ7OHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3901CC4CEED;
	Wed, 12 Mar 2025 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818925;
	bh=CfUwrM2V/e72+UB4UGgtb91j5B0Cx+t37H2hoW+n3II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNPZ7OHa1rmHNi1DmCsWSzMkTKRF6wSsgH4Jo2TLsGMcyfq2SXS1Kq64s6qUVc0R0
	 EumJCi2UWjgY4tnrz7B7eLixMplnszJuTIyuDsuNnVWIjP1dxw1u/zoPdGpCIcFvUD
	 g/7WM0aO7eAKXNNFzL0OY0fr+NGl0rukyH+zZh5TgLTRlDs4PoNrAyAQ6BRJF56ltm
	 0gHqwahrXOdFPlKn7lZLML92XFeh6NPpAuzRsiBVhJLvpkZiZMPnWTlaplzfSHWVXi
	 EEEbZV/6M43PH6TmHWcbfjVXjoI7iHymgW+TSLoHhgXFqEM+SD1kD44H5MziRdKpyT
	 hg7WpY36rWlFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/11] net: constify dev pointer in misc instance lock helpers
Date: Wed, 12 Mar 2025 23:34:59 +0100
Message-ID: <20250312223507.805719-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312223507.805719-1-kuba@kernel.org>
References: <20250312223507.805719-1-kuba@kernel.org>
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
2.48.1


