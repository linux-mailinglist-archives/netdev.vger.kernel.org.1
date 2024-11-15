Return-Path: <netdev+bounces-145363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F579CF427
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD161287ED4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE11D90CB;
	Fri, 15 Nov 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="jKCUZPxn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B31D90A5;
	Fri, 15 Nov 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696072; cv=none; b=kOrarhlFfE4ogScGntEWRvRR0fig1qBsEW1KNeLb8iolo8Pse3VrbjSO2T94GXJ7f8E73+Vwu04STUBb7RxA6u5tfdQd1u0FuZkE4TP1KfmFMFh2f3mGNQYc0R1bfXTdCVEEyJVYx37ZqKFTxQTALHPLmNnnyNniOFtNjxbVFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696072; c=relaxed/simple;
	bh=OBPrvQaPcar7MS8LqlU9mzk5qR9eZBNCOKDdcvghSXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2+eAAKTRbWSLAvzQ/5a/Lo8tG5tuIklZsnKh5fLHjKXh+8P5adsQHxYAKsib7pQEd248ZqUqPCOe67h3oFPEyW2Mn97EsThpqiV41H0XTVv5KsrRDZaRw8rjHIjul8/QnbYn3EZcU3aVlYlQ7+6mmDM8J/Kryc3pdA3hbpj2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=jKCUZPxn; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 3B346240127;
	Fri, 15 Nov 2024 19:33:51 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 90403240239;
	Fri, 15 Nov 2024 19:33:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1731695629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CLEjcCfwVCSaZMP2cJOPRIQuUntKjUDmrMW+O9uBkF4=;
	b=jKCUZPxnXk8nPslhnK93h9eeE+wRKQ34jqEcCXo2t0bfIyA2xmXdbm94aNGsTM6mv0Jjri
	uSGOO9dYCsLBLL4oG9VWLDNtbZYoxDlwaCy9BxpTs+TCJSUfTMCLSyxr92Ci+/WoCs2w8w
	j4yVaz6RfFH1fSDOdojGYwHW8oAbbTxlA9qIz5aI8SF2qYwMTOh4GN124bI2kS1YY2IL86
	R7OUeSvC1dKdXIrMwRZzAt3t4YPm4+j/mZ7wF+1ofjmfQFd++x1XKAaHQz5pTnuaGYMS6I
	/GMTg5AW2uNXPPO2Wn7IirYrhuCohyOQykmKuSx0gP5rt6U/V1tON/DRqfsDfA==
Received: from Til-Notebook.hs-nordhausen.de (unknown [195.37.89.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 0CE5E240565;
	Fri, 15 Nov 2024 19:33:48 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next] net: uevent: also pass network device driver
Date: Fri, 15 Nov 2024 19:33:46 +0100
Message-ID: <20241115183346.597503-1-mail@tk154.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: ecce65
X-Rspamd-UID: 3adc96

Currently, for uevent, the interface name and
index are passed via shell variables.

This commit also passes the network device
driver as a shell variable to uevent.

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


