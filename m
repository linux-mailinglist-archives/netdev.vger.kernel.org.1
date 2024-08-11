Return-Path: <netdev+bounces-117463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46694E096
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DAE1F21419
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4B28DCB;
	Sun, 11 Aug 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7ew8lgn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704891CAB3
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723366616; cv=none; b=DFelI9W1zvmBwONke4s4HGJm1s/NUYnYQBxDLvoEe0c9joJLkKdLXAVBPF+hI6i8/dMQo6Mc+ZxKLRUAHzRCkQ3X4Ai8smpGVSPWdCltO02qTFO4ZCa1NfnDukcOy/nJYA61WEVnKD9NSsa2iKMsAdnjXT+Qda+eOFlp9ZRecp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723366616; c=relaxed/simple;
	bh=W84gLqiCE9VS6xNfchhRQmqgpUv7AmgL7LwhjXEkAr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLb8lAwShPqawpq01yk313LwPyV9apG+49jFi6WBAE0lFWtrmL4VyTiECwrA/kznTf3p1z+Uech9im92LVac1ku5K8lQYBBKxwbgwjyxQr/P0tsmrswlMi4dqGzPIHX/KKJ0TU8aVU4jZ0TIGbtfOwbB7sczhj4MzKcpjn6rnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7ew8lgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A03C32786;
	Sun, 11 Aug 2024 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723366615;
	bh=W84gLqiCE9VS6xNfchhRQmqgpUv7AmgL7LwhjXEkAr0=;
	h=From:To:Cc:Subject:Date:From;
	b=S7ew8lgnceHEEM9nB1YV6M/aMOfhI1GYpO55UMZVQZUWMZi6g3bv2nSHhkrpXjkbk
	 SbOxVh4s484rWRs6OKerIy6kaqT8IhRRT8Npni3biRo3EoA1jpAP8eWFD1mK0+Fc3x
	 UnSutcED8qeo/1oJQhQTW0erbyra6C9cKltRBD2Si2aFOQefCml2i7ZMK4v9PcVWZF
	 mDIYUvGCx+MI8KP3Xw2q2be2iZ9iVFW7w5PRgQZt7yTLxQ/SigQ5+HEXAbDtShs2PW
	 iVZWwMuxkIiDK2zYu9/1bORj7ChBs6a+izjxJ0xD36ydGMZWpLJ3pG7mNYUH9guuJW
	 gigwSuoB8Jurg==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH xfrm-next] xfrm: Remove documentation WARN_ON to limit return values for offloaded SA
Date: Sun, 11 Aug 2024 11:56:42 +0300
Message-ID: <e81448c34721aaf49faa904a5ffc2a18b598b3d0.1723366546.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

The original idea to put WARN_ON() on return value from driver code was
to make sure that packet offload doesn't have silent fallback to
SW implementation, like crypto offload has.

In reality, this is not needed as all *swan implementations followed
this request and used explicit configuration style to make sure that
"users will get what they ask".
So instead of forcing drivers to make sure that even their internal flows
don't return -EOPNOTSUPP, let's remove this WARN_ON.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 9a44d363ba62..f123b7c9ec82 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -328,12 +328,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		/* User explicitly requested packet offload mode and configured
 		 * policy in addition to the XFRM state. So be civil to users,
 		 * and return an error instead of taking fallback path.
-		 *
-		 * This WARN_ON() can be seen as a documentation for driver
-		 * authors to do not return -EOPNOTSUPP in packet offload mode.
 		 */
-		WARN_ON(err == -EOPNOTSUPP && is_packet_offload);
-		if (err != -EOPNOTSUPP || is_packet_offload) {
+		if ((err != -EOPNOTSUPP && !is_packet_offload) || is_packet_offload) {
 			NL_SET_ERR_MSG_WEAK(extack, "Device failed to offload this state");
 			return err;
 		}
-- 
2.46.0


