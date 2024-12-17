Return-Path: <netdev+bounces-152450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E99F3FEF
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132AF7A20FD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08338DD1;
	Tue, 17 Dec 2024 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5rR89w9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F7171A7;
	Tue, 17 Dec 2024 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398695; cv=none; b=LLhnavoDu5GC0Z1Vb/FS5JQLMZF7o6UxH9pDt5JyFzmM0hLmjvAWTCM1B2go2iaIX3qYrCXCUt7OjcGEURQYHaXuPUnQi/smg8KlRb8RzTOi1GdyAz76V9VNI7ibqFGxJRWv0jgS4F6kbJHjfpgqJcyIcDVUfBLJNEHfPfCgQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398695; c=relaxed/simple;
	bh=/8pQZsrhe/NRtSDNL1A34UI9DFxsHWPVy1QhOc2qgsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=McUwxOdQPYrIFYLdGJ1ff/vr8HWJkIomfi2wlkYlUM5+8vqQegZGxxMdes0n0vP0S+iYp7H5c0sBFkUfCBBOdBuXG7WbPwqW7c145ryIZ3llLov0vLCGeYPhPj2RLO6AqSXuOwTrjj/3FRc6PIwIBWX0zLNV2V+rr3lx5rGRuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5rR89w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E67C4CED0;
	Tue, 17 Dec 2024 01:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734398694;
	bh=/8pQZsrhe/NRtSDNL1A34UI9DFxsHWPVy1QhOc2qgsA=;
	h=From:To:Cc:Subject:Date:From;
	b=d5rR89w9B+iZ8E+JVC76hYE/CJnkt1GMcnaHCX9RjCuoNrtCKTekwzVI2ARqFnpHI
	 e31WDaJYRSNNlSNVV6AP+iH3Za7KPo9RKow338wXbBHwC30bSaWt/lUYxZnuhia5m9
	 iFeGJs3dCf8EzhmE5AVwc0qyyERXxEcISkjFatJa/Hxy3Un0Mr2hOlWqL8lu1BXonn
	 HFxvkEEbPIv7UwqeZ/eDrL6a7GUlsl3zriTJn3ibluVS5mNCTAEVGAA3o7oiKoDcSt
	 jBvGRtK4chWHNlcOJ3PiKbrCfbuAaTicZU37UZMZPSVvrEgcZx11TgJkxswTiBxdAj
	 fMVqfl4gbbNXA==
From: Kees Cook <kees@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net: core: dev.c confirmed to use classic sockaddr
Date: Mon, 16 Dec 2024 17:24:49 -0800
Message-Id: <20241217012445.work.979-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=kees@kernel.org; h=from:subject:message-id; bh=/8pQZsrhe/NRtSDNL1A34UI9DFxsHWPVy1QhOc2qgsA=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkJlx7euhF+cQr7FcfpHUXblH6+P3o85VGKorjOFKn5s u8z9BLCO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACai7szIcDW6d5NVw83i+tKW 2H17HcWesS13ya662v0o48auc/qGRQw/GZu+fP52wSTF3oRxlyPLvmvTfmo+e6fMfyNw3YSGL6d kuAE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As part of trying to clean up struct sock_addr, add comments about the
sockaddr arguments of dev_[gs]et_mac_address() being actual classic "max
14 bytes in sa_data" sockaddr instances and not struct sockaddr_storage.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 45a8c3dd4a64..5abfd29a35bf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9183,7 +9183,8 @@ EXPORT_SYMBOL(dev_pre_changeaddr_notify);
 /**
  *	dev_set_mac_address - Change Media Access Control Address
  *	@dev: device
- *	@sa: new address
+ *	@sa: new address in a classic "struct sockaddr", which will never
+ *	     have more than 14 bytes in @sa::sa_data
  *	@extack: netlink extended ack
  *
  *	Change the hardware (MAC) address of the device
@@ -9217,6 +9218,7 @@ EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
+/* "sa" is a classic sockaddr: it will only ever use 14 bytes from sa_data. */
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack)
 {
@@ -9229,6 +9231,7 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 }
 EXPORT_SYMBOL(dev_set_mac_address_user);
 
+/* "sa" is a classic sockaddr: it will only ever use 14 bytes from sa_data. */
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
-- 
2.34.1


