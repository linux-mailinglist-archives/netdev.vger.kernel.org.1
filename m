Return-Path: <netdev+bounces-222712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D14B55784
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371233B0DA0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AB532CF6C;
	Fri, 12 Sep 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZFv9TcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FC32A817
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708082; cv=none; b=gkwHdXwlcpQYbDg8ghJJ/bpQEKn5SHPNHQzHYmquiLn7yMtN4PhOi3J5EO4SomLpVXo/83Ps3I4skdPksSM4ZW4eiuhAzfXmy0LE6HEUVKoecjQXMs+orDNByxnc+aNBAA+EFqrl6Zs93h3IpTa19bdB3geWdQa5wj1nzSKpkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708082; c=relaxed/simple;
	bh=26fBa6GuojM89wygUW2JC55uok9Oscu26OSD4YmN9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruiIWX8VCXTTBh01z0BXKzQSB4pP9cgKTNqvB0K51YYyqJ8NZo/7wxRZLQl/AXZYP6+ACrfdrz8Ml/pYh5beHDgG9AnEcoHJrkdifk66CdeEFjyq0nX8flZxI1ZLoePsWgC6l82ZBmhZYmMQHZvuYQRKpEp+Dowpjlff0/EHm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZFv9TcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8AC4CEF4;
	Fri, 12 Sep 2025 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708082;
	bh=26fBa6GuojM89wygUW2JC55uok9Oscu26OSD4YmN9h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZFv9TcDMu+Tf3fjrRGsscPK75npenXExuIj7qsmFhFhH/5TIgM86h0QNn5VrKvwi
	 msLEzJ64t3t1NuSykEz00YUNM7gQ+z1Ivrz30CDw1Py3ijBThIHZ33nj+1R9mnuZfF
	 2rQoQnvJKuPyOBi5Wtt4xjD0ylhBrThTXDecQ9/o1KYuEWoX16QhGtkLgvQDvuNPXa
	 ey3By7t1lU6NaKge2A4n37cfEEqKDsfmPqcZpVUL5i5RzThrq51VR5zLJNK0xm8ETF
	 I8suRhwfAXbZbdn/0A6y9ocDB0LHXaCGO+lD9GDLXt+hwnK8NXWwAmkJyiModK48yk
	 3A/ZeaBKpEzqQ==
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
Subject: [PATCH net-next 8/9] eth: fbnic: report FW uptime in health diagnose
Date: Fri, 12 Sep 2025 13:14:27 -0700
Message-ID: <20250912201428.566190-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912201428.566190-1-kuba@kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
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


