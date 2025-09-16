Return-Path: <netdev+bounces-223767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA68B7D17A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75887A6AB3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731442ED845;
	Tue, 16 Sep 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8Zhvcx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6372ED168
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064491; cv=none; b=KArkQlKYeP0vim0MXKDWxUMApLJQhDsWQI4KwfwlUxPGBqzHsF0AN6PC6HjPoW7HSwWRqHsMkFYVwCimPHaRXsdnULYJV+Ta5k2HC22JMJR9I0RwNSrXaTiUVP70dKE9i63GMnmUaBtt1Y/hu4JcQ68AXzCaE720+jSgnARLpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064491; c=relaxed/simple;
	bh=KuxOHYYztsKTzc2BiH5aZIx+z205HXIEYgTaf7Kveok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehPkr5pFqt48+HO1Eqk93C3G6uf/sysyjrY3grVD2msKQggVRlqQVliMEa40Gh3c/mR2RaY3uq4c3KM5/xpswWS10fUWq/agJtIs9340S69jiTyon+6KMLc8HlneL7LINKHjH9oUb19UIhirpUuwPb1CRz0ahipG4g8sS28FwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8Zhvcx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0E0C4AF09;
	Tue, 16 Sep 2025 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064490;
	bh=KuxOHYYztsKTzc2BiH5aZIx+z205HXIEYgTaf7Kveok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8Zhvcx5xzoSR9xDNGnfvQwO0eaCaTMTOM1ykqHBIG2zsh2zKqgGUhZXC1E51Kcii
	 KCTr40rfVBGWL4d8/2p+q3UgPO6fg0Q+0FNxiivsyTf1seTwKmhlAiJiwZITu+HVl7
	 5kflbyXhR1K7JNTLjHXNdjOSkhEGD4bC/isIfIfkGf+pjrUSqUlz4a2fOq6TFnZJKg
	 Z4wLC5Jbs2WQ4jX7MlroR9XL1LgKNBx0uNnL/0moJPKlrpoHs6fzqKXEtebAiPb/X1
	 nQNgaJ1PM0HiTzPrTx8fjpS4PxGlpVJ1ekAu5qXlnYwyq88Q/uh8Ln6+paMBHG59Hq
	 GBbuX4Vbn7W0g==
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
Subject: [PATCH net-next v3 1/9] eth: fbnic: make fbnic_fw_log_write() parameter const
Date: Tue, 16 Sep 2025 16:14:12 -0700
Message-ID: <20250916231420.1693955-2-kuba@kernel.org>
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

Make the log message parameter const, it's not modified
and this lets us pass in strings which are const for the caller.

Reviewed-by: Simon Horman <horms@kernel.org>
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


