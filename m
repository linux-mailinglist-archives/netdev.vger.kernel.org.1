Return-Path: <netdev+bounces-242870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B93C95958
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EB3426FB
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7841B4156;
	Mon,  1 Dec 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mfMgJGUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656619C54F
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556143; cv=none; b=N3PlQY+B64iGute5m1g1ToeBKxfc/+1mqumIm2kFRYyZWLUstZqCR1UUaXlrNv1xqBntCJEdszfNwckFRSIoYR9i+EPSvcPtfYJ830EUC62L1YTRxsY5fo90epjKtbW7ipNgp5WpHdN/JCws4GD0JMMcq4L4aSt4BujpzS2j6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556143; c=relaxed/simple;
	bh=KIO/ZocBCZFVqjHi1zhFY3gMF0QZCosfUCAuo+pEVCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnVts4Ul5o+4XjvqfzUzQpN5ee9mRUiBQSEY8rAXC54y+CHLWzxKqu3rXNkmed9Sg3fa/Pp7DrxYyCcgHQvhJs+K42wdYiR8pnWLw3Od1Lrzu1Eo8a+fz1PGigCnPTsV0zuIO3dldTMTXMjswiseD0dLfvoEDn/xAi8c3rSainw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mfMgJGUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CECC116B1;
	Mon,  1 Dec 2025 02:29:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mfMgJGUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LILA1MdlwO1Sgm8i345I56BHmaS+DQD0sptKY0Wtzi4=;
	b=mfMgJGUdVKmFacwZhR3JzbPaWC1/tCkAdbkuodUxkH2JkO+2dAKwvukZQNYPaCJF8OQ77t
	fnIWu2rDFMZRg2deuDyKxozAjyi1KwxTepAaAKctk94br3D9HNVMZFONWEI8f4NePzWeZN
	PF1GAt/C0DhOB/LM0toogIauUEJW/Q4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c45b1d9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:28:59 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 03/11] wireguard: netlink: use WG_KEY_LEN in policies
Date: Mon,  1 Dec 2025 03:28:41 +0100
Message-ID: <20251201022849.418666-4-Jason@zx2c4.com>
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

When converting the netlink policies to YNL, the constants used
in the policy have to be visible to userspace.

As NOISE_*_KEY_LEN isn't visible to userspace, change the policy
to use WG_KEY_LEN, as also documented in the UAPI header:

$ grep WG_KEY_LEN include/uapi/linux/wireguard.h
 *    WGDEVICE_A_PRIVATE_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 *            WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 *            WGPEER_A_PRESHARED_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 [...]

Add a couple of BUILD_BUG_ON() to ensure that they stay in sync.

No behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 97723f9c7998..682678d24a9f 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -24,8 +24,8 @@ static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1];
 static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFINDEX]		= { .type = NLA_U32 },
 	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
-	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
+	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
+	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
@@ -33,8 +33,8 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 };
 
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
-	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
+	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
+	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGPEER_A_FLAGS]				= NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL),
 	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
@@ -643,6 +643,9 @@ static struct genl_family genl_family __ro_after_init = {
 
 int __init wg_genetlink_init(void)
 {
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_PUBLIC_KEY_LEN);
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_SYMMETRIC_KEY_LEN);
+
 	return genl_register_family(&genl_family);
 }
 
-- 
2.52.0


