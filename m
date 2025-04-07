Return-Path: <netdev+bounces-179882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7BA7ECBE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29ED01890D93
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161025D1E4;
	Mon,  7 Apr 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKJSp5DH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD325C71F
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052481; cv=none; b=LWuvgy3sgOWGmUrSRd8Iy7CRShW4huxSdwwlH+Gx0uSM0rrgQgrZkRcVo7JE1axPXI1Qx0oAo0TR9ZnM757in6JyhzsU0JjRg24gxxCy4zOBLYQXm6APvlH849nKtMOtdLAPlcMu4O303pdStoS5OgWwopeeXxY/stkE9RGxFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052481; c=relaxed/simple;
	bh=MTerOXBwlfPdrpMfMLV4IMxJf8zcYyqKG0YVeEs0Lbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXodpj9MAdMZieIyG2c5qvvsxcN1DJz9wEQENVxJy1y2weJhOnxSiqCcTwm0fRG9sh5MBr7BoIViTtndWIB2H/oDAKHcWWoZEhk7++/JyQmlL5Ov7v+KESwwdtj/7RmwcblwO4K8YgPF/4YtLtuwj72otNPedtWGVveyBrKRtpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKJSp5DH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD36BC4CEDD;
	Mon,  7 Apr 2025 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052481;
	bh=MTerOXBwlfPdrpMfMLV4IMxJf8zcYyqKG0YVeEs0Lbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKJSp5DHQReZiG5h2yo/7r2b6NpN2kg9/ezfIF/zNIR7qrWzewdWacmg+x8SclWQG
	 C1JHLt2Ti5AoZSKAoo1NeZjQqeMsWOHFIrzb7wfpDxcXKbJXS6rPEh9kgu9eiNldXq
	 ajhFMT+/m709q8/0f/PA+yHqVgBVQo6O+oO7ytbnvRGQJREc6CuQFrUh2rnDLT9Gry
	 X45aGyDlkJrN/RzdxOD/UvvZsjVXce8hg56xjhm16XupBo/FcYOS7zmtoSw+2/DdTi
	 UDu0EoswJVopULTc9aCu/RWT75O81bzBCwmJwk7qJkNv+qe0USUJHc9Z7nIE/1ifBa
	 JUZrNeIbmpyZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	hramamurthy@google.com,
	kuniyu@amazon.com,
	jdamato@fastly.com
Subject: [PATCH net-next 7/8] docs: netdev: break down the instance locking info per ops struct
Date: Mon,  7 Apr 2025 12:01:16 -0700
Message-ID: <20250407190117.16528-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407190117.16528-1-kuba@kernel.org>
References: <20250407190117.16528-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly list all the ops structs and what locking they provide.
Use "ops locked" as a term for drivers which have ops called under
the instance lock.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdevices.rst | 54 +++++++++++++++++++------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index d6357472d3f1..0cfff56b436e 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -314,13 +314,8 @@ struct napi_struct synchronization rules
 		 softirq
 		 will be called with interrupts disabled by netconsole.
 
-struct netdev_queue_mgmt_ops synchronization rules
-==================================================
-
-All queue management ndo callbacks are holding netdev instance lock.
-
-RTNL and netdev instance lock
-=============================
+netdev instance lock
+====================
 
 Historically, all networking control operations were protected by a single
 global lock known as ``rtnl_lock``. There is an ongoing effort to replace this
@@ -328,10 +323,13 @@ global lock with separate locks for each network namespace. Additionally,
 properties of individual netdev are increasingly protected by per-netdev locks.
 
 For device drivers that implement shaping or queue management APIs, all control
-operations will be performed under the netdev instance lock. Currently, this
-instance lock is acquired within the context of ``rtnl_lock``. The drivers
-can also explicitly request instance lock to be acquired via
-``request_ops_lock``. In the future, there will be an option for individual
+operations will be performed under the netdev instance lock.
+Drivers can also explicitly request instance lock to be held during ops
+by setting ``request_ops_lock`` to true. Code comments and docs refer
+to drivers which have ops called under the instance lock as "ops locked".
+See also the documentation of the ``lock`` member of struct net_device.
+
+In the future, there will be an option for individual
 drivers to opt out of using ``rtnl_lock`` and instead perform their control
 operations directly under the netdev instance lock.
 
@@ -343,8 +341,40 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
 acquiring the instance lock themselves, while the ``netif_xxx`` functions
 assume that the driver has already acquired the instance lock.
 
+struct net_device_ops
+---------------------
+
+``ndos`` are called without holding the instance lock for most drivers.
+
+"Ops locked" drivers will have most of the ``ndos`` invoked under
+the instance lock.
+
+struct ethtool_ops
+------------------
+
+Similarly to ``ndos`` the instance lock is only held for select drivers.
+For "ops locked" drivers all ethtool ops without an exception should
+be called under the instance lock.
+
+struct net_shaper_ops
+---------------------
+
+All net shaper callbacks are invoked while holding the netdev instance
+lock. ``rtnl_lock`` may or may not be held.
+
+Note that supporting net shapers automatically enables "ops locking".
+
+struct netdev_queue_mgmt_ops
+----------------------------
+
+All queue management callbacks are invoked while holding the netdev instance
+lock. ``rtnl_lock`` may or may not be held.
+
+Note that supporting struct netdev_queue_mgmt_ops automatically enables
+"ops locking".
+
 Notifiers and netdev instance lock
-==================================
+----------------------------------
 
 For device drivers that implement shaping or queue management APIs,
 some of the notifiers (``enum netdev_cmd``) are running under the netdev
-- 
2.49.0


