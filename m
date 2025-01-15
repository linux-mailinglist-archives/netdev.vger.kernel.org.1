Return-Path: <netdev+bounces-158478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A0A11F77
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B241169F1A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6724384B;
	Wed, 15 Jan 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lR0fSQdi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB5242251
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937005; cv=none; b=BvfZ2rGv56G6B+rWuHYpwpOdVwj3P3Fjvud+FeYaN8Zt0go1/IvKNS0wb6/N1QiN20tr1eiI73wG5sty6/NrCga3P/5L6gqBGTazOcp1sL+37EincY4kDPP34X6iUgN9t+k2zY2skqphCVCHlY2G2pwZjXEilbKtBXrp4k0JbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937005; c=relaxed/simple;
	bh=AuS/iv6kct3xwW/JT6RfpDdtL/kYEb8lhYq9bZGCAcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+/fXRT0qGOaRrG7erJvQS4KxQ/NEMv1nfxsqmg0DiW7q8MH1MiMG8DH0Hg59NRhKrr35rnEcrxlK3GYurO7FHmduCV69RM9+dSxk5NsZSBvhHioZeowftQmSzgZTybtcLx9mYL9MCcMaY4Mth6BdwbMDzZF++bxngLqVGZ9UCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lR0fSQdi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21680814d42so96952635ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736937001; x=1737541801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhgcFiioBCTJrsBu7R7SWfvrloYa7MHsggVE4kmGhcU=;
        b=lR0fSQdiE04ikti+5xq8WaDFxzwVQeHg00rN11k+au+7HPHtKuWQWs9Thgfz8tmALw
         5vfNFj8uLCMz2/Ok7bzr6zbU4Am+zfIpirMWAuu3ZDrCMaoMmN+dQzeF1BMXQD+k+wsJ
         gsj0vAL3byHY9P59YTMwJtwOK8brJh897vO3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736937001; x=1737541801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhgcFiioBCTJrsBu7R7SWfvrloYa7MHsggVE4kmGhcU=;
        b=KViA4OL87p4dYQCZCFxuJO0IxUEZO8MIA/Gkv/J5GX+FuZ0iBvuHojLYl8uBlU1KFw
         aosTnGDhdorQ99/HxAXVhCBmjUDujkF58pNOWVLLsZAyrJdIZHPSM4Hdktf8O+ry8fQi
         XhKFo1VLIr56HetTELlrQMZxrDXGUbpe20s31bOuZ1d9MGx2TYAl7kHa6REF4xbTzhzk
         SNjikJQT75zV7A32lQljsfcUgbeBAh5H2OpmThL6hRYBJhSSEPMyBEuOhqrb7/fwl57U
         46OiilGBKOqA/waep6Hc5HeerbInhlUP7PUOj7zwnwH0MrX1YOKSQdFdK40UMKIh7aAT
         ecVA==
X-Forwarded-Encrypted: i=1; AJvYcCU1lP4uYMqOTNvXkSrRkjHg15QemlqNGdncK7xiAti8hFQP+a7k28gqjj7V7ig9yUBj7LB8FDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80qNBe0R3eJ6XqjN7xy6Eegfl6gAUodlhKX/CJv0Aw5IuoJ6Z
	OSO+ILQ+Pbb6w8F1dUDUdvTL9m7+yT1bUbCrEkInJPFz5CYOOdSkosTb0ZZaqQ==
X-Gm-Gg: ASbGncso71z6CS7uhWiKKk12FbM5UmzQjWuh4DWR+6s6ogZ1OPAXEtmXkGg97j/ir/L
	McpnUwCGOvlQfPdwH50FlWSxGXzS13tRwuniw2qQk96As9W05sie5+DgU8ln2nGkEUrwqaFBawV
	q1bRnLSAe4Iepah0SSGAciLrNshEjpckhZDXl1wbubd6rrQ0ficn8u8MOFNaGOWprumNptbWIPp
	FOzkIWah1Z2wtzotbFfjXP1QEYi+OQJ4vTjHtJvQkQccFBo+EWOfRj/n9ZkvMEtUaRrP/wpLkl7
	LjbLZa+HqECXY277Kfzik6kdKEny9iWem7LipTeJ9LYXxg==
X-Google-Smtp-Source: AGHT+IHLfLGJgEZ5SLuPyAwiMbZYFQ09flUH9NUqIb9U6+ujP8obt/r8pocQNQyqRrN/HC41+DPhzg==
X-Received: by 2002:a05:6a00:9a7:b0:725:ebab:bb2e with SMTP id d2e1a72fcca58-72d21f64e2amr37892682b3a.11.1736937001568;
        Wed, 15 Jan 2025 02:30:01 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e591sm8835195b3a.126.2025.01.15.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 02:30:01 -0800 (PST)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH v13 2/3] netdev-genl: run ynl-regen to fix CFI failure
Date: Wed, 15 Jan 2025 02:29:49 -0800
Message-ID: <20250115102950.563615-3-dualli@chromium.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115102950.563615-1-dualli@chromium.org>
References: <20250115102950.563615-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

The ynl-gen tool has been updated to generate trampolines for sock-priv
to fix the CFI failure. Run ynl-regen to apply the fix to netdev-genl.

Signed-off-by: Li Li <dualli@google.com>
---
 net/core/netdev-genl-gen.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index a89cbd8d87c3..996ac6a449eb 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -197,6 +197,16 @@ static const struct genl_multicast_group netdev_nl_mcgrps[] = {
 	[NETDEV_NLGRP_PAGE_POOL] = { "page-pool", },
 };
 
+static void __netdev_nl_sock_priv_init(void *priv)
+{
+	netdev_nl_sock_priv_init(priv);
+}
+
+static void __netdev_nl_sock_priv_destroy(void *priv)
+{
+	netdev_nl_sock_priv_destroy(priv);
+}
+
 struct genl_family netdev_nl_family __ro_after_init = {
 	.name		= NETDEV_FAMILY_NAME,
 	.version	= NETDEV_FAMILY_VERSION,
@@ -208,6 +218,6 @@ struct genl_family netdev_nl_family __ro_after_init = {
 	.mcgrps		= netdev_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(netdev_nl_mcgrps),
 	.sock_priv_size	= sizeof(struct list_head),
-	.sock_priv_init	= (void *)netdev_nl_sock_priv_init,
-	.sock_priv_destroy = (void *)netdev_nl_sock_priv_destroy,
+	.sock_priv_init	= __netdev_nl_sock_priv_init,
+	.sock_priv_destroy = __netdev_nl_sock_priv_destroy,
 };
-- 
2.48.0.rc2.279.g1de40edade-goog


