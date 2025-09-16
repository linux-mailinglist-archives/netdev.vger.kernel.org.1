Return-Path: <netdev+bounces-223771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55048B7E0F9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75693A1F73
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E422F068B;
	Tue, 16 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwMa2/3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CE2F066D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064493; cv=none; b=Ifbj2p4VfYhL391sAiCQLy5C5r2s79nhyKoSrCzfPWuYONwNSM68h0IXG3DARgGLJzFcawrY4EcMu/EVDsNN/FndL4Vfon0UMVXTRDRgpcI+vgWPYX2bApqUhex+m3k5gdmoJqpjSPFrCPQ5KSQCc8Abid+7wPOMS7cIrMxPK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064493; c=relaxed/simple;
	bh=kSTvhfCT+F/AFdWqPRMMn8Q9lZzol5f1+Q6Pzi7Xu7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pERIc+L+zWNBugugyn1yASGpns/Cf4F4XGoxvdQNXik6dfRlOlw+KUB0GPccevZpD/4v7cBD4wpz1i56ZE1rVXU4ejIccd5eXn4Aqs/gozUYXA3j370812quaNKw8Y/HOj4e6HEHRpSqPqtxQW4pkeBe0A8KdWoJ4SZv69GD2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwMa2/3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED9FC4CEFB;
	Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064493;
	bh=kSTvhfCT+F/AFdWqPRMMn8Q9lZzol5f1+Q6Pzi7Xu7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwMa2/3xN90Hu6cJgHfM2194RjS8f3KeCipseJOekyiHSGklcsrLrjUH+WHc17/Uz
	 CaGhhPsH0ivXsZFpmHyc5q2H8A8zo/ZFISWYtODyIB6+ZQNtzaF92ozh/h8qKABict
	 DNgF+OpXE7pTrOEfObEL+0Bx3fzu0Z2/EBqIt+t0VI/MoY7r5uliJvrFfrY4jCWA0+
	 ZjHnFAt7WtvRV7kjTgdNTJRIEEkAZWWOHywCvkovDjK+Vtb0oyoi/GgYvOUlOmPWm2
	 dWWEcNiBtuyYW67S9WF2PsK5hHrHvDVh5D+Oa7R5/zI0BZVhYzT8MdZw386nDbg+7H
	 P3Is3bfR3kNgg==
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
Subject: [PATCH net-next v3 5/9] eth: fbnic: support allocating FW completions with extra space
Date: Tue, 16 Sep 2025 16:14:16 -0700
Message-ID: <20250916231420.1693955-6-kuba@kernel.org>
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

Support allocating extra space after the FW completion.
This makes it easy to pass extra variable size buffer space
to FW response handlers without worrying about synchronization
(completion itself is already refcounted).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index be7f2dc88698..d4c0fb4c94cc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -100,6 +100,8 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 int fbnic_fw_xmit_send_logs(struct fbnic_dev *fbd, bool enable,
 			    bool send_log_history);
 int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd);
+struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
+						  size_t priv_size);
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 9b39a73e4c35..198922a942b2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1544,11 +1544,12 @@ void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 fw_version, str_sz);
 }
 
-struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
+struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
+						  size_t priv_size)
 {
 	struct fbnic_fw_completion *cmpl;
 
-	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	cmpl = kzalloc(sizeof(*cmpl) + priv_size, GFP_KERNEL);
 	if (!cmpl)
 		return NULL;
 
@@ -1559,6 +1560,11 @@ struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
 	return cmpl;
 }
 
+struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
+{
+	return __fbnic_fw_alloc_cmpl(msg_type, 0);
+}
+
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *fw_cmpl)
 {
 	kref_put(&fw_cmpl->ref_count, fbnic_fw_release_cmpl_data);
-- 
2.51.0


