Return-Path: <netdev+bounces-145585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86969CFFEA
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 17:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D812873FC
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAD1822E5;
	Sat, 16 Nov 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="hWMY7GY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24DCA5A;
	Sat, 16 Nov 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775365; cv=none; b=ReKpwki1NOP7Ef+hRzaeLwLKbsyra92L6xxonmlaCf4fmATZO1KP2EVqEB22mVzIrZGzR8Kiusy4JIcLHfSXzE75dQ9/ZpG6muLQHq1zfTGvyCTWWUMKWUx8VRGPri+9wz6jQHbL9uR5lUJ72LggdIdfgKDAPcQ3crMMkhoVd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775365; c=relaxed/simple;
	bh=7KlQXJDSnq6UZG/g5wZE+JoWIyEThx8Hk9jMplRgsvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUa6bo5zOFFOVxjzOByjFvvuB1R6oVWbjFi9RbDFwtolzTkvozdgfzoWdFXAd9Chv47MkvReAxpLJP5cGFq2IOR8CZmfhxbWLI/XbCk9RJpgbH6p4xpz0uIZ2hzHuEWAJEoBkQOIK1R3T9k3sEQU1pLLwE1exbYxqJvzIJspTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=hWMY7GY/; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 057E824055E;
	Sat, 16 Nov 2024 17:33:54 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 4D165240854;
	Sat, 16 Nov 2024 17:33:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1731774832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yX/tfev9RCOdJL+DgImlUqoC55tOefzCrfQvDNqxuVs=;
	b=hWMY7GY/KI0Cm2qNDc9MajtYSx97NNGhRPCievxqLYQxTcO/pdkgf75/BWE2QQQAWDh52L
	91FVrnLrlZWrttR3swdKn1ChUau7kh++pOX8lrgWGnJWUAb06jSKRF2+yWCuwu5vYZITxB
	TTsdh3WceIItCzPQj6Ql8SV0xq4O4+y7lN5al2yQ3nT5N1Lu+SCNe2ZtWcjmiz3MtL3ttN
	BrOaGT2vNWwr8xY7gq8xD+KqAyq6jT7M4JbWBwkPWWVy0H1dG/7/nnES2RNOmCccWWl/+G
	Mpavu61KdHPjgTNGJWAajbofZ65udfnxzJRcJ4FZoZuRhQ9zVjvavepjiynvKg==
Received: from Til-Desktop.lan (unknown [IPv6:2a00:1f:5742:5f00::754])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 15B1C240827;
	Sat, 16 Nov 2024 17:33:52 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next v2] net: sysfs: also pass network device driver to uevent
Date: Sat, 16 Nov 2024 17:30:30 +0100
Message-ID: <20241116163206.7585-2-mail@tk154.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116163206.7585-1-mail@tk154.de>
References: <20241115140621.45c39269@kernel.org>
 <20241116163206.7585-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: d0e07a
X-Rspamd-UID: 09227a

Currently, for uevent, the interface name and
index are passed via shell variables.

This commit also passes the network device
driver as a shell variable to uevent.

One way to retrieve a network interface's driver
name is to resolve its sysfs device/driver symlink
and then substitute leading directory components.

You could implement this yourself (e.g., like udev from
systemd does) or with Linux tools by using a combination
of readlink and shell substitution or basename.

The advantages of passing the driver directly through uevent are:
 - Linux distributions don't need to implement additional code
   to retrieve the driver when, e.g., interface events happen.
 - There is no need to create additional process forks in shell
   scripts for readlink or basename.
 - If a user wants to check his network interface's driver on the
   command line, he can directly read it from the sysfs uevent file.

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 net/core/net-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 05cf5347f25e..67aad5ca82f8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2000,6 +2000,7 @@ EXPORT_SYMBOL_GPL(net_ns_type_operations);
 static int netdev_uevent(const struct device *d, struct kobj_uevent_env *env)
 {
 	const struct net_device *dev = to_net_dev(d);
+	const char *driver = netdev_drivername(dev);
 	int retval;
 
 	/* pass interface to uevent. */
@@ -2012,6 +2013,12 @@ static int netdev_uevent(const struct device *d, struct kobj_uevent_env *env)
 	 * and is what RtNetlink uses natively.
 	 */
 	retval = add_uevent_var(env, "IFINDEX=%d", dev->ifindex);
+	if (retval)
+		goto exit;
+
+	if (driver[0])
+		/* pass driver to uevent. */
+		retval = add_uevent_var(env, "DRIVER=%s", driver);
 
 exit:
 	return retval;
-- 
2.47.0


