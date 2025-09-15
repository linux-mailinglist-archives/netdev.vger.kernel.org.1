Return-Path: <netdev+bounces-223166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3818B58154
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4205A7AB566
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E223C8AE;
	Mon, 15 Sep 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFd51EuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63223C4ED
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951599; cv=none; b=f8oEblK5PmM+6/GKqTIU5hDoA2x0OCrTZIOkHa9KY89ny8HWKDOvZ8Jytk8n8Zn6/02K0bo/NwfVa85XJyeO7KCcJY7JiDYF4Zfupidju8xPVgl1lA6TAYijE/H95n1qPukGRaLw38M4+BHNV5wG0Vheu6B/rRAPN93dO/aJz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951599; c=relaxed/simple;
	bh=26fBa6GuojM89wygUW2JC55uok9Oscu26OSD4YmN9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK4iS6Qq+iPK5vts8uMIOD5Fj+uCP9UNAUwyoZ8Q5IP7hfWJSa0uHYewE9Vrl1WHa+HvlBIlCv9hjOmrSW1VNiZXVtIAO3VXYOXKdXZfQlyjPNiFQSaje1ruy+BoAfBCiVt7skqhZTvWTvUuGSfXn12rc9xA5oRZYDfDflq461g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFd51EuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD9DC4CEFA;
	Mon, 15 Sep 2025 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951599;
	bh=26fBa6GuojM89wygUW2JC55uok9Oscu26OSD4YmN9h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFd51EuTJe5YsfgsFa2kWzO5LjWSxX+csHDlCT5x8+jNhGW2BDeHWhC1ZUmEgKiZD
	 RVUmCUt8U5mhYNMdy3kav9N+HG9htHuqUMIIJ2SFnQ8kdAKvmqA2Bxq+lqssHd52Nd
	 rKMpO6tDBOHP+N3Cc/ZmgfIbwsH/TqeeJwfHZXynPBewxVIZyAtHR8EzzeSHJRAYC9
	 y+JUTgSRe9Jkq0y8D3WEmiE2IFhVksQkWjZts9R2xm5pU25KTQCXoyjqagHqecIiI8
	 qdTrKyjXLO3fMIKkd6FqibWwhcqOBGw2ocHbABfHsF7sx0X0z9/d4NfRfkuRZLSfD9
	 Y/8wMynk+iXlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 8/9] eth: fbnic: report FW uptime in health diagnose
Date: Mon, 15 Sep 2025 08:53:11 -0700
Message-ID: <20250915155312.1083292-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FW crashes are detected based on uptime going back, expose the uptime
via devlink health diagnose.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../device_drivers/ethernet/meta/fbnic.rst          |  4 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c     | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 62693566ff1f..3c81b58d8292 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -77,7 +77,9 @@ fw reporter
 
 The ``fw`` health reporter tracks FW crashes. Dumping the reporter will
 show the core dump of the most recent FW crash, and if no FW crash has
-happened since power cycle - a snapshot of the FW memory.
+happened since power cycle - a snapshot of the FW memory. Diagnose callback
+shows current FW uptime (the crashes are detected by checking if uptime
+goes down).
 
 Statistics
 ----------
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 0e8920685da6..f3f3585c0aac 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -487,6 +487,18 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
 	return err;
 }
 
+static int
+fbnic_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
+			   struct devlink_fmsg *fmsg,
+			   struct netlink_ext_ack *extack)
+{
+	struct fbnic_dev *fbd = devlink_health_reporter_priv(reporter);
+
+	devlink_fmsg_u32_pair_put(fmsg, "FW uptime", fbd->firmware_time);
+
+	return 0;
+}
+
 void __printf(2, 3)
 fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...)
 {
@@ -505,6 +517,7 @@ fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...)
 static const struct devlink_health_reporter_ops fbnic_fw_ops = {
 	.name = "fw",
 	.dump = fbnic_fw_reporter_dump,
+	.diagnose = fbnic_fw_reporter_diagnose,
 };
 
 int fbnic_devlink_health_create(struct fbnic_dev *fbd)
-- 
2.51.0


