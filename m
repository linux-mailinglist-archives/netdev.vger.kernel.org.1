Return-Path: <netdev+bounces-155062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02AA00E27
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A491884B5B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441B1FC7E8;
	Fri,  3 Jan 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5dF5NOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21B1FC7DF
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930800; cv=none; b=WuOZCK4qnHerOVljv/qr/rZ0NDN/u/4kQBj3CfAJmgWRfy4Pl1+L6jsWOW641tWZP7IA+jn1m86/8Fjj6P6NzFnZ31UgiVvfrkUubNDQQ8ze4IEytjpurRABPkFpcDmSRNOzmqNGxPi2UZj/h9kC2UxsVKATlLrmvXdXiIDUSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930800; c=relaxed/simple;
	bh=sOmE9/sMV0g5Q2kmkrnlKjdUKpmYLt+d0ahRY+RFwi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWKhdkwQ7Y6Rz+hgl5jQSyYgXX8qAMy3bJMyZ8p8qeJwsp/JnqmEpJYBegDCNOjGj7hHIkjgi1rxcrH2md4mrIxNhBzpWmsH92s0GKRhCBdYLqYqEBA4n7A+0i31cDBVy1CPEuhMBW3aRQDXOA7V2w8r3+jaAMPPb0x9VL3pR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5dF5NOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB36CC4CEDE;
	Fri,  3 Jan 2025 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930800;
	bh=sOmE9/sMV0g5Q2kmkrnlKjdUKpmYLt+d0ahRY+RFwi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5dF5NOzHkVQ3t8b6JOnVa76IqpnBdcb5ScdE15DX0vSBDejxjqpRH6t5amEbp1tW
	 2wttXiwNf8vI1wl2MwRoftYbBz14UHtaPqUaU0rou5RR1C/6GfhmGuAdJbzU/nlqk2
	 fgMxlkZSE9QGReS8JBj8Vpw/P55E+H6+RxIzJeIftoheuQR6iN0teTqlaj5aUTiQXI
	 b3C7osc+KkvQrXjtfnt2AncQrskdUX6XxR1HcY/U9LgfDbdOHh4jarkxTpGgy35mKz
	 LkFdg1IbPszYfIryW8XFf6ykIDR7x4dNpMtDY70YDACUHneMmxu+AlqsTYhLD5MC4d
	 NDycvhc20C6rA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/8] netdev: define NETDEV_INTERNAL
Date: Fri,  3 Jan 2025 10:59:47 -0800
Message-ID: <20250103185954.1236510-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus suggested during one of past maintainer summits (in context of
a DMA_BUF discussion) that symbol namespaces can be used to prevent
unwelcome but in-tree code from using all exported functions.
Create a namespace for netdev.

Export netdev_rx_queue_restart(), drivers may want to use it since
it gives them a simple and safe way to restart a queue to apply
config changes. But it's both too low level and too actively developed
to be used outside netdev.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdevices.rst | 10 ++++++++++
 net/core/netdev_rx_queue.c              |  1 +
 2 files changed, 11 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 857c9784f87e..1d37038e9fbe 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -297,3 +297,13 @@ struct napi_struct synchronization rules
 	Context:
 		 softirq
 		 will be called with interrupts disabled by netconsole.
+
+NETDEV_INTERNAL symbol namespace
+================================
+
+Symbols exported as NETDEV_INTERNAL can only be used in networking
+core and drivers which exclusively flow via the main networking list and trees.
+Note that the inverse is not true, most symbols outside of NETDEV_INTERNAL
+are not expected to be used by random code outside netdev either.
+Symbols may lack the designation because they predate the namespaces,
+or simply due to an oversight.
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index e217a5838c87..db82786fa0c4 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -79,3 +79,4 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
-- 
2.47.1


