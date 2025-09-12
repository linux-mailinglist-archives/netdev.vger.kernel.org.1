Return-Path: <netdev+bounces-222705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B6B5577C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAEB625E2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C12C0F6E;
	Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeYP5QTc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C72C027B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708079; cv=none; b=g53TyBY8+TlWc8oMb4ZdWsHFycDokGE6nG+3cGatAjHP8RBfgA03yVvgKDR68HGvG1PxqYNe+Qnj+auXwdmwEUHqVM8JAR8SApNJnhT5Wu9VXCf32tM72kVu0QPgYpMGmqUCknbJ7iN68Fg8xhPNI3r7hvNaqBySN1btMGpsKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708079; c=relaxed/simple;
	bh=YMBxYZgHQyV7fMLr6O3z+nEi94eIBXTPTT+WDjmynOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTq8lkE7xSvUYmRgIfOYOqimrjE+mpdeHRWukkq1rAE4oI1rSLMNw7qzG8eSDX4uMywMw9vkjbSq8vBwUo2npNQq+6whRKpBfuYU17LPmaNRM+B+b8tjZeLOQ6pQCRgkUauikzQkz61R/v2eHcnEc02Wz36z6JsRt/cED2naxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeYP5QTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092A6C4CEF9;
	Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708079;
	bh=YMBxYZgHQyV7fMLr6O3z+nEi94eIBXTPTT+WDjmynOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeYP5QTcfAYzEzEaGzk6s6SftdO20NK6USbBMSzDRyL9908S8r030qZiIxITvxLw8
	 i0IOI5c4lFXELSy3J3wY39r+yUmQ3rNAcl3Sa6h3E/Ed7MWpadYoQxlsX/ddIw2SN7
	 bARdzthbzl+0G3/DjgQ0zLvHxyefJdSIdYSr5kJ1phNXGrAVTj6rXRsXO88ThHAM7+
	 Ap6h42+44iswlfcQZdVVvGFhl1Z5WUgYO4fQUwLJzZBgelhossrW6SXBcFkgdVYfAJ
	 F9PwPriO+xQ/YSGybd3WH42tHVmBbWGgtsT4zzDcgaXALFEmr/UzTT44CoMdpIWBZ0
	 8AKco3L+Dh1mg==
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
Subject: [PATCH net-next 1/9] eth: fbnic: make fbnic_fw_log_write() parameter const
Date: Fri, 12 Sep 2025 13:14:20 -0700
Message-ID: <20250912201428.566190-2-kuba@kernel.org>
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

Make the log message parameter const, it's not modified
and this lets us pass in strings which are const for the caller.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
index cb6555f40a24..50ec79003108 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
@@ -41,5 +41,5 @@ void fbnic_fw_log_disable(struct fbnic_dev *fbd);
 int fbnic_fw_log_init(struct fbnic_dev *fbd);
 void fbnic_fw_log_free(struct fbnic_dev *fbd);
 int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
-		       char *msg);
+		       const char *msg);
 #endif /* _FBNIC_FW_LOG_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
index c1663f042245..85a883dba385 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -72,7 +72,7 @@ void fbnic_fw_log_free(struct fbnic_dev *fbd)
 }
 
 int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
-		       char *msg)
+		       const char *msg)
 {
 	struct fbnic_fw_log_entry *entry, *head, *tail, *next;
 	struct fbnic_fw_log *log = &fbd->fw_log;
-- 
2.51.0


