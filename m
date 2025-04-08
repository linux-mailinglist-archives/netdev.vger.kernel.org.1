Return-Path: <netdev+bounces-180469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6BEA8163B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C26883B0A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FD2550A4;
	Tue,  8 Apr 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZmbKEyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4F254B17
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142412; cv=none; b=XX9njj8qdbn4QSlQtG/1v6VbdOf145F8hFEMJCOhlIHpj6/D2fG4NiyRZ6cCBn2qYpZFK3sEbKCnaTu39ozTeZzWZkJhc07jrWfZPs4Ebq8xkw4KIGd7wACqeS7w6P6EmVao6K6iDufehjk8TZgziaJ6Lxxs0m6ScUIWQP98+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142412; c=relaxed/simple;
	bh=g0iJcCskv5zOPmxrq5NBPh6+KSUkjkkfCTkI4jqNpG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2BiB/WdYmcKdDfGtYvqspjttOlzo5igytHLJJ+QGJLMWD114bsoGuFLFHjcy99KvDadAHb9jZC++40LPA2AZp0WQpZUfI6YswX6dHEK021er37B/OKnolyA+xgWR5Sp7Ts2fkT9m+cVTbOJyfbXacaoONAMsYg6EoX5c+qam1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZmbKEyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEDEC4CEE8;
	Tue,  8 Apr 2025 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142411;
	bh=g0iJcCskv5zOPmxrq5NBPh6+KSUkjkkfCTkI4jqNpG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZmbKEyPI0h9nIcolw1FFQA8p9N39jTExZ9RNvkMW4uVBkTuaOWJ2KyQqph3xdXKE
	 19IY9QV/8v2VVSOFyIXx8sYckndcOLpDdOdnp1lsCei6yu1lPU+peokdb+BDda/evQ
	 iZpmOIRIWXDw6vQTkmpeTfpgiDR3qqWvZoaROtlcnZwmYfd6DZYjOUquEbB9Ky8FG3
	 XbjoKIG74m1Zsd/L7BgF3hkz1CWDne3X2qcVACSS9gcKT0CQ5uKmcPQKgX3kFW7DBo
	 Gw4ySDiXQ0qCz+oeg7V7jmfqb+ObI9g5zdOcvujC1CvtZ5aAH58kNS6OuW6m/Ib35u
	 RUk2sskwGWQJQ==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 7/8] docs: netdev: break down the instance locking info per ops struct
Date: Tue,  8 Apr 2025 12:59:54 -0700
Message-ID: <20250408195956.412733-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408195956.412733-1-kuba@kernel.org>
References: <20250408195956.412733-1-kuba@kernel.org>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - an exception -> exceptions
v1: https://lore.kernel.org/20250407190117.16528-8-kuba@kernel.org
---
 Documentation/networking/netdevices.rst | 54 +++++++++++++++++++------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index d6357472d3f1..7ae28c5fb835 100644
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
+For "ops locked" drivers all ethtool ops without exceptions should
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


