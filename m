Return-Path: <netdev+bounces-282266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEqhLQSx8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438C49058A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92BE9306A8FC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4D3A450E;
	Wed, 29 Apr 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHr5PftI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D939E17D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446862; cv=none; b=PPh8jFU0XhwV4PuI25pb+ojYqCBW6TZz3owctmxTA7ap9Fn5Vjp3ak4tt5UglzuAENmR6RhF7aitdcm6hUG4lkGJk27dHeXP98nQB9TEzShJcj5aNoYzl2AcSb9da/8bqdqN7HrQPSvrgo4MEC+8rnTbfGxY1fJ7GykOVQDZ6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446862; c=relaxed/simple;
	bh=dW+ME8+T/cZdaRp0hgNE+NKFQ20WpKrwiMvExM21R9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qb5IT4PUWxWzb6SONHn0ZsPYShXfqgzY1tckkzq+8weU/1cZQCYBhWzDB2+MCLAzGV2ICyfGxk1mObO8yxBEXyHGkeW8AhfgKWWsjHMez+m8qDjhveNNJUHY1akebWah1SZZzkbY6D3tzMv2iR/0WtMhjHogGgmBv978MgeTTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHr5PftI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so15128209e87.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777446859; x=1778051659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayWJ8sM71wXdRAfLJ35+sbAWmIRBbaKRHeFJfEPXpOA=;
        b=mHr5PftIpRMib/QWarsk3ZlG/xbsPbk/64khaS7nvo6jGZYU9XDJL/uiBqUEnbR7J7
         JB8OdVreCnhMXOG2lufXPUL8Y7aA2iNgO3bAQCJZpzpGmhtaoIPktwTUFTDjuc5AooNQ
         7W6XTEVa6j0SR/OVX/aZNCBZTrx+znhim5adbx7h14v06sgFI1B5EudOmNg861Cf5A/O
         Kl5Jdv/c/4H0TFMBXW7XvrVVI++Yj7XGGSuY/tARpZjPqTVj+qXXYBPYBZSo+UntPfmP
         VL4IsHn6WMAzzOM44pGPiIp5wJ8pnuj1tA4J4kJCBV3ro4oIIyH0tH1uF85vfj2eCN4d
         h+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446859; x=1778051659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayWJ8sM71wXdRAfLJ35+sbAWmIRBbaKRHeFJfEPXpOA=;
        b=anq6siw2fjjIma0Z0pejihlAsjtZBEIuUecxJBAiHmuGpMeKBsUK9oIbbRQLIpHzxU
         WrQ88b++R06pQzCE3u1y5ht/+OgTRSJOrkzEpacbflTOj7Lny7nYJO8M+8lI9f3U0Mio
         vci0iHRAkTgC39jGec2LONQbCvg0HzKL8msqBSJaX/WCWd2ZR6cFMiQ/t1SqVgGhQmsg
         i1FcG64WUSpE1jIhEIVymQHuKmsWaUQYUq4S/0UJ273y0QpjxWGVvL3NYxVxylLTD2SO
         541EOp8DK4al9Q7EIsD8esFyZvU4cRukmHE067TMKH+nO7w/SXYkgWe6lOeSCxPqce9j
         39+A==
X-Forwarded-Encrypted: i=1; AFNElJ+GhLhzTlhVc71iqPvdzXJGyXII5/5QoKivalWEVPwnkxdrgdXryrBP6TH4pR90RfLLHCBHwIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCgx6akGEvZdOYIuJgkVsA8pEAu0Q9QDEe3Ef21juNxOe7r5d
	3v3MLUyeU9vyZp9TikMV9sEXDmpA/rWglngS6mAAS6OWlLKqO7AdNo1a
X-Gm-Gg: AeBDieu0TDnctoK1RGTyTn2+gPbUkR0WwzWeWVs0WwPYiQDUTstTPp8kUIhGI1DF6ZN
	S2vA1ixi1+fUiMdU92AWg43ydzsrois+q0Vgpybyplhi6ntnhD/9KvEqfRg7fYWNw6qyb9HYtI2
	GDlooZ9ceeThQ3cV4YMZbC8c75yWzhk39B1rIBbCgWRs27TcL48Dx5VdqV6Bc0Y9k22OZib7UCS
	RtI8+oDEtVMpvg6tNaD5lAuURQ+63KqId0uYyQBz8uQsxAR5v3HznH5ph2rdws3OUM5P3VNTy9I
	G+xlmjLKduKRLVe82rLjBzEOsN/ytPMbbNJ9sN8rPR5u+3rbd12uzZSnHxYVB1akcjzKXzvYdJq
	X5eO6wZ5YG0oLDHSpzeoN3H0JOOExSg3iUYQIQk/d7xXyH1GoD/J8fGOmLimpaEi1u5fETfXkAh
	OdjYP/J3sNfpN29Onbw15SXVzEuA8v0v4=
X-Received: by 2002:a05:6512:3a83:b0:5a4:19de:eb70 with SMTP id 2adb3069b0e04-5a749d21fabmr879609e87.28.1777446858957;
        Wed, 29 Apr 2026 00:14:18 -0700 (PDT)
Received: from thinkpad ([188.225.109.225])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3924fa7c93bsm2861151fa.23.2026.04.29.00.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:14:18 -0700 (PDT)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/2] mfd: rsmu: add 8a34002 support
Date: Wed, 29 Apr 2026 10:20:47 +0300
Message-ID: <20260429072047.1111427-3-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429072047.1111427-1-dev.mbstr@gmail.com>
References: <20260429072047.1111427-1-dev.mbstr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3438C49058A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282266-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devmbstr@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add compatible string, i2c_devcie_id and spi_devcie_id to support
8a34002.

Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
---
 drivers/mfd/rsmu_i2c.c | 2 ++
 drivers/mfd/rsmu_spi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 9e5fc8259eec..c57795ed20f4 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -330,6 +330,7 @@ static void rsmu_i2c_remove(struct i2c_client *client)
 static const struct i2c_device_id rsmu_i2c_id[] = {
 	{ "8a34000",  RSMU_CM },
 	{ "8a34001",  RSMU_CM },
+	{ "8a34002",  RSMU_CM },
 	{ "82p33810", RSMU_SABRE },
 	{ "82p33811", RSMU_SABRE },
 	{ "8v19n850", RSMU_SL },
@@ -341,6 +342,7 @@ MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
 static const struct of_device_id rsmu_i2c_of_match[] = {
 	{ .compatible = "idt,8a34000",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
+	{ .compatible = "idt,8a34002",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,8v19n850", .data = (void *)RSMU_SL },
diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index c931d8cea0a1..e07f21482439 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -241,6 +241,7 @@ static void rsmu_spi_remove(struct spi_device *client)
 static const struct spi_device_id rsmu_spi_id[] = {
 	{ "8a34000",  RSMU_CM },
 	{ "8a34001",  RSMU_CM },
+	{ "8a34002",  RSMU_CM },
 	{ "82p33810", RSMU_SABRE },
 	{ "82p33811", RSMU_SABRE },
 	{}
@@ -250,6 +251,7 @@ MODULE_DEVICE_TABLE(spi, rsmu_spi_id);
 static const struct of_device_id rsmu_spi_of_match[] = {
 	{ .compatible = "idt,8a34000",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
+	{ .compatible = "idt,8a34002",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
 	{}
-- 
2.53.0


