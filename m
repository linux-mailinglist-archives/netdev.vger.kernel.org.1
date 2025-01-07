Return-Path: <netdev+bounces-155916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05AA0459A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4614518854BE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013C1F6673;
	Tue,  7 Jan 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzh5ph+j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6391F3D26
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266135; cv=none; b=K+RVHz3QugB9hbwUT65YfyqFiXcOf5F4DZ5/bKQ1qgLFBZo4XS/a23F6m8YHq1NWlP4bf04FBmO/yUyEMWgLIPz0gozEnlo7vF89l5RX5bIgSO+/0r4pUTBEpE0ps+RgRPhoaahZL0BfJ/T7fZ9X9geFzMfTAcp9S+kG6JOIsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266135; c=relaxed/simple;
	bh=vni924yxR/p/IXUISPX/AhtAzCJrI4NkGIh3Ys1WXV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsAcv5ROS+d93w/MRE0GrwpUd4AaiMd3Gpd1l8Qq9FLgs7MqGDqioPQkea8y6/A0gLPiy2PwHEiFBo/fNrCOiTUue3EnVdGmsPEh7xj9WUHrRLXZU5VG2F1vJvkebLXyUlZHArEzDdpycSH5FtcxamrL8E7l6MSYrUEGQuke/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzh5ph+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905BDC4CEDD;
	Tue,  7 Jan 2025 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266135;
	bh=vni924yxR/p/IXUISPX/AhtAzCJrI4NkGIh3Ys1WXV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lzh5ph+jI+Cq2lmQMRyXihoXi6zMaR7PDy0td7ANVSsqsNbI6TvAP7zyaAzWiPVkG
	 L16+Nd1jGKmqY+kcjtu8ER9T0Kr1nc5+QDeAu+6NuibjE2yC179vLAbmJpkn06Lk23
	 G3SGR+fR/yZDXkgHZ8+l+Bd72YUad2InHQNYeGlLPgcvdkVXQbssiHGqV16FaiUzVQ
	 NXMlaTUtSitVuCs2BRKCTmUkVfYfumhOHqqEydD4X3G6H/pEkHXPwKP01wKwhfIAfS
	 9MoZjfsN1zXBohA0zIy/QtaydA/WR5JkzyoqpbnS8pIhqqFogIefEAFVj19g5zQJIP
	 ivMi6Vci+Qabg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/8] netdev: define NETDEV_INTERNAL
Date: Tue,  7 Jan 2025 08:08:40 -0800
Message-ID: <20250107160846.2223263-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
References: <20250107160846.2223263-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


