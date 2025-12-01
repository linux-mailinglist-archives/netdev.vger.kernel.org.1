Return-Path: <netdev+bounces-242867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9062AC9594D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776F33A1DCD
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C221A23A4;
	Mon,  1 Dec 2025 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pfoTTXxp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DF19D065
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556137; cv=none; b=r73jRm6u3LoPm6hkH5uWT7LjJzgUdjN4hnt3ktxSrwsTO90S/895S1/v9ddVbZKE5Wx7DTrDEWhd+1hDU+LJ4L7p8ziU7g+umZZzLGTDcVNrOyN2fzmH4XgJ3+6Ud10/DBX0nPD5DUdbf64QqC6bvZXzQrs/FoPvB65EZEazVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556137; c=relaxed/simple;
	bh=P8tYPjYN2Pi1HxVZdjSdk77vOgf/mwWXjKRBvDKZx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEc8vbiPxWFX7aRPj0pVLYPCaEhnMbaxLJFTutvUp4+gIGw5CbKDiQSB2F4D/UmUR0+HH8gMJl5jgOcVURNSsS/lzjPMAwPp6s4iyvgUVIU6F3dv6PfKX4IncY2CNTEDxbDQL7XrC7XEw63gG+KGai2LI2nnrQArxwVwaPOavO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pfoTTXxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B98C16AAE;
	Mon,  1 Dec 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pfoTTXxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI/+fUm4wAxs4WvuW+ngxrXB8wjUaAQ07n8uWBUeXfQ=;
	b=pfoTTXxpy3G2wYNW2YYcsJMmjMwUQkp+eK83wonppJETnf97ct9ICnN9Mm1jTGA9mSg2I6
	0pXso9870BvTE3lUy/anPxYI9TJcG0W2mT5M3pvUJc+cAxJqe1B6wlNF1UcL2BaM/hEFnV
	nomB9BcEs3I//MuHUwKvSxlhB5S/tkA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 65f4f156 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:28:54 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 01/11] wireguard: netlink: enable strict genetlink validation
Date: Mon,  1 Dec 2025 03:28:39 +0100
Message-ID: <20251201022849.418666-2-Jason@zx2c4.com>
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

WireGuard is a modern enough genetlink family, that it doesn't need
resv_start_op. It already had policies in place when it was first
merged, it has also never used the reserved field, or other things
toggled by resv_start_op.

wireguard-tools have always used zero initialized memory, and have never
touched the reserved field, neither have any other clients I have
checked. Closed-source clients are much more likely to use the
embeddedable library from wireguard-tools, than a DIY implementation
using uninitialized memory.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 67f962eb8b46..8adeec6f9440 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -631,7 +631,6 @@ static const struct genl_ops genl_ops[] = {
 static struct genl_family genl_family __ro_after_init = {
 	.ops = genl_ops,
 	.n_ops = ARRAY_SIZE(genl_ops),
-	.resv_start_op = WG_CMD_SET_DEVICE + 1,
 	.name = WG_GENL_NAME,
 	.version = WG_GENL_VERSION,
 	.maxattr = WGDEVICE_A_MAX,
-- 
2.52.0


