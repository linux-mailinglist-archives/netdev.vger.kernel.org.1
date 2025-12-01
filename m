Return-Path: <netdev+bounces-242871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DFC95961
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A6634E151E
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F51A9FB0;
	Mon,  1 Dec 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WCfwj2jg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172951A3166
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556149; cv=none; b=kQS4OsPCJDS12BX9bjtFlJWLmJzRW7A82j5aMMloqOaifold9uA5SkFj9tqCs6aKtduAa2kWQ5ZzheFEtiLdr3iopiSRbWNPaEPzwHTWSo/qG3b9SFrVZx6phbENy6PyFQ7WgEuQgKv+IBK4qCORttvwn58fPJIi65mSWttMig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556149; c=relaxed/simple;
	bh=Vt0MJ5oM0Nhl6sMoITbeXpIkwPURFtI2kT5kyR+KBoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1CQIzlICpvmgyX6cVSCmk+BqLrZ4xFgz496Fn7rASFG1JlDvOhzvXtHUfhc+Wbzu6XAvQCLeGO3+/x4wYJ2e74JNp/TMijLeWC+DRFQbU/wj8unr3Fg+dVto3quhKEAmTrvjKjFDxCr3djA9vgay/scl8URf+HTy2zT8qCxC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WCfwj2jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2B0C16AAE;
	Mon,  1 Dec 2025 02:29:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WCfwj2jg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqzRaWYReYKNiIQxDPGlXBoA5Pn5VEJYLOXXxd7mDnc=;
	b=WCfwj2jgeGUqAyGjewF4djPMIIi9HEsl2FOd9w7gol51S1ZyaFewwOPOgEmM8SWjQ0WR/K
	w0rEeBNavxCrzhH5DegqvCZgf2PVl0/E5WPb5PXBbQHFsz6No9u30UZ4/S3V6I7YI84fom
	Q9xYApxdPI+Dy7HQku7FwNyq5L3rN48=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d41ab872 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:29:03 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 05/11] wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
Date: Mon,  1 Dec 2025 03:28:43 +0100
Message-ID: <20251201022849.418666-6-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Previously .maxattr was shared for both WG_CMD_GET_DEVICE and
WG_CMD_SET_DEVICE. Now that it is split, then we can lower it
for WG_CMD_GET_DEVICE to follow the documentation which defines
.maxattr as WGDEVICE_A_IFNAME for WG_CMD_GET_DEVICE.

$ grep -hC5 'one but not both of:' include/uapi/linux/wireguard.h
 * WG_CMD_GET_DEVICE
 * -----------------
 *
 * May only be called via NLM_F_REQUEST | NLM_F_DUMP. The command
 * should contain one but not both of:
 *
 *    WGDEVICE_A_IFINDEX: NLA_U32
 *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMSIZ - 1
 *
 * The kernel will then return several messages [...]

While other attributes weren't rejected previously, the consensus
is that nobody sends those attributes, so nothing should break.

Link: https://lore.kernel.org/r/aRyLoy2iqbkUipZW@zx2c4.com/
Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index e7efe5f8465d..c2d0576e96f5 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -623,7 +623,7 @@ static const struct genl_split_ops wireguard_nl_ops[] = {
 		.dumpit = wg_get_device_dump,
 		.done = wg_get_device_done,
 		.policy = device_policy,
-		.maxattr = WGDEVICE_A_PEERS,
+		.maxattr = WGDEVICE_A_IFNAME,
 		.flags = GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	}, {
 		.cmd = WG_CMD_SET_DEVICE,
-- 
2.52.0


