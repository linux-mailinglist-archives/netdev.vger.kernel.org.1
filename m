Return-Path: <netdev+bounces-223774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517DCB7CF14
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE041BC0CCE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D92F28E7;
	Tue, 16 Sep 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkiQW7sZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1332F066D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064494; cv=none; b=qA5oh+hsiNyCI3rmNetkUjaflfvtcf2CDggsgy42ojNToCncMpR9UkFta0lQge+D+Gzfe3g70U5Hh2ZXM8kSM6sIh9BDOjV6vcKZvh9OYPaWNs2ySGdFdX1vx8DEOzgVCpb1icHSjBYQeg1vs0X6eW4c58qOS7WNjUCE8uzJdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064494; c=relaxed/simple;
	bh=VYlJhZa5hvN9ketB+9Dd4uhBxYsHEZxYRZmGXLQA+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQpMBndiXr8KBdlOu7hVuU/UKSAn0GyS8Oejddlg2RGDnp0kz/4WYmjJMijNCeagI7JuvoYpUhMM0YJwz6k/xeCzQ9qQPYjcqXX2QQKP2imVJ9BffPYkW0oiVybAP4DVjf0AX4xmviQ6cI8D06Y2QNoggOFAPUb3jsNwn/7HUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkiQW7sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B5C4CEFC;
	Tue, 16 Sep 2025 23:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064494;
	bh=VYlJhZa5hvN9ketB+9Dd4uhBxYsHEZxYRZmGXLQA+ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkiQW7sZG/M/a3Mj+wl5TSO1rXvg0PS17t00OLS8bj4zCmhht+Xwr0ZZqLclG/mLm
	 DU3Y+nkr/lp5PVjloIUBffol1C+bJz9lIUa7IJFNVl+x75l0Qw6jihW3zHH81PZuBm
	 V50I3uHH9VHU9ML7uFO0RLUFfD/xIS8vOnfvCs2HkUh3Sd6OBnHYQ7nb2+MAI/G4fB
	 DyCEGvq52zPFYkCi5muyPu89FH56ooLbMVS2eyZXg8sErZouQC6ACklEaeUnt3FNWo
	 CQAKpeIgeQUDhKgKn9FSFO7ddi+F0D6k8e+WQiUsdSu3kU90um5ayalpwJg0TtD5E7
	 PwmOEbfPdSjnw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	lee@trager.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 8/9] eth: fbnic: report FW uptime in health diagnose
Date: Tue, 16 Sep 2025 16:14:19 -0700
Message-ID: <20250916231420.1693955-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916231420.1693955-1-kuba@kernel.org>
References: <20250916231420.1693955-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FW crashes are detected based on uptime going back, expose the uptime
via devlink health diagnose.

 $ devlink -j health diagnose pci/0000:01:00.0 reporter fw
 {"last_heartbeat":{"fw_uptime":{"sec":201,"msec":76}}}
 $ devlink -j health diagnose pci/0000:01:00.0 reporter fw
 last_heartbeat:
    fw_uptime:
      sec: 201 msec: 76

Reviewed-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - split time into sec and msec
 - don't report when admin down, the time will not be refreshing
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  4 ++-
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 29 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 62693566ff1f..8b7ae9975bf7 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -77,7 +77,9 @@ fw reporter
 
 The ``fw`` health reporter tracks FW crashes. Dumping the reporter will
 show the core dump of the most recent FW crash, and if no FW crash has
-happened since power cycle - a snapshot of the FW memory.
+happened since power cycle - a snapshot of the FW memory. Diagnose callback
+shows FW uptime based on the most recently received heartbeat message
+(the crashes are detected by checking if uptime goes down).
 
 Statistics
 ----------
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 195245fb1a96..fd7df44ae7a4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -485,6 +485,34 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
 	return err;
 }
 
+static int
+fbnic_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
+			   struct devlink_fmsg *fmsg,
+			   struct netlink_ext_ack *extack)
+{
+	struct fbnic_dev *fbd = devlink_health_reporter_priv(reporter);
+	u32 sec, msec;
+
+	/* Device is most likely down, we're not exchanging heartbeats */
+	if (!fbd->prev_firmware_time)
+		return 0;
+
+	sec = div_u64_rem(fbd->firmware_time, MSEC_PER_SEC, &msec);
+
+	devlink_fmsg_pair_nest_start(fmsg, "last_heartbeat");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_pair_nest_start(fmsg, "fw_uptime");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_u32_pair_put(fmsg, "sec", sec);
+	devlink_fmsg_u32_pair_put(fmsg, "msec", msec);
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+
+	return 0;
+}
+
 void __printf(2, 3)
 fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...)
 {
@@ -503,6 +531,7 @@ fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...)
 static const struct devlink_health_reporter_ops fbnic_fw_ops = {
 	.name = "fw",
 	.dump = fbnic_fw_reporter_dump,
+	.diagnose = fbnic_fw_reporter_diagnose,
 };
 
 int fbnic_devlink_health_create(struct fbnic_dev *fbd)
-- 
2.51.0


