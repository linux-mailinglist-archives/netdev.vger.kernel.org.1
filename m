Return-Path: <netdev+bounces-157923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC0BA0F560
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FB2164C2B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9EF9D9;
	Tue, 14 Jan 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdwrA5Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F429B0;
	Tue, 14 Jan 2025 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813231; cv=none; b=G/vkdMkOF7uOWbY4yN+RA1h7dxGxEcktpRWLgVXbnH+DvWQM9jM0VGdg+uNOz8yXqGK3ZK7qYhyoOfZNcdJgEWPC8J0DRVET29IQABwg3EMr6t6D+Kanok3a3btA/wc8j/CFTIE4louXIM6jmIb+q8kISBscxhQgIgCsjmJrXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813231; c=relaxed/simple;
	bh=jDz1AqHy9kVmzlLThGksZio6MPDBnKohThpfVT77dtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGFzfHzEvYd8zXWwQlOCTdKaKi/cYY/jhJLXywhuuF30GtbHAuUGnfGquKud2C5hG7YQahfYayrtwSbD/fMH870Oxh6ZNEl9v4QtOh1MsXX4jeI0HaBicIy1qpqEX5BG2YQz4Tv5bAHteFZvsjzbTc3XP+/7txGb9K7xNwrm2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdwrA5Ix; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21669fd5c7cso87870725ad.3;
        Mon, 13 Jan 2025 16:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736813228; x=1737418028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqinG5bc4R8mduD4J0r80sXRxbkZhRD0K6VLj/i18Zs=;
        b=RdwrA5Ix7Rv7l59ohC5fyKyxPAtWSHWREjFuAkX/eagi8SbVLt+S5aAtGJZDPGZY/5
         NX7JnShYpdKg49jyYdo/3hlNa0wfUbAKkHN/kBD5CDa1fW8SrCuu5ginzYLqu/f++0Dm
         Vfwv8WlSOgyRo0amZCjyyrNeizN7IOgElnMM9j6qoPj8zieNG0pj/ocDJgFcCfQ7poS6
         ZPaK417ExkZAz+0gAOw49v4BQX3eQ51kbFYoGXkJCQ+kdhXd6Cji7AzyxKjEbs4z/nL7
         5PLsQHOIr4YoGbM5kg37nKPW77iBlAjwN/ouVWkOTbItkILH6Fpyg4WxR8W2lrZ1BXxY
         G4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736813228; x=1737418028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqinG5bc4R8mduD4J0r80sXRxbkZhRD0K6VLj/i18Zs=;
        b=mSLBMin0UqtSW13lnOKdAkPpDMXi++ac0TRMGhS7TdssaMG0vXsT5B1u50LuCr7qzr
         SAJgW9keeVYYBGOCQx17ALGkQ4SNe2gbGLnL32zGLwdTTrwdcSOinAqNJfhDjkMHTZes
         Rm6mQeDv3wGnBCPR2Vv5CZ/osVUHQUlYJzOcD86ltOgv3RHGGyVP5m0esoiVM1t+pOoc
         pDQP9RXWHKJR8yKaoBrA5KB3ffjbDS75bsktzk0+vX0SE7z7nZGMx46VMQ6JXMd0OYM8
         mwcc+LXr2FKfrQ9mFMcjretNdqCXPVUd7uO8q8LiaFXpFOqdyF9vkmQa2Yg8ZRkApK/G
         0DMw==
X-Forwarded-Encrypted: i=1; AJvYcCUZM28IfgveX5o/z1Xuk7CdDeAc6eVVvioD4YiZe1ot5yiy0/5b5TgC81b6LlUulzOn6mHN+YXu0JGhCQ==@vger.kernel.org, AJvYcCXfUDtP7XywF0XB7ByrBu1oODL/2SHreeRk0uP9dDeOuPjP48xMuVgC2JkOOBgXrOJ+In7BrLoNJm+oV87D@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbFO3qrrFUu4Vn7Qkd9y6sgEPdMM8cc6ngfU6lLCWaov+4hkq
	RZ0SGEcpCqErrwoQ0rXU6SlGxtpzaJIhYOy/aulECWWaXXGW8z0hWBh2QeN6F50=
X-Gm-Gg: ASbGncsqblLj0MoGR7eyKGMs68dV+2w+I+Tn3ugSb6Y1g8/Sejd1xEeNxFzZFCG5gni
	WYBhYGCYl3NSo97h7q90B8zJcOBrCCtHATrGVdNM/ntlNyvWqmRtL4hhuta0dtbaGfEzHPZh9rm
	kN/79n1undBa/fFEL4l6nh8nkLLg+z20Jlsmn/khfvhlWOr7p8xR6UbxFPBz3PsVUKIyOWSgW01
	V5uLbhzQa+2Cui5lNjs57CDunkQW6T1UA6GjCipZ4nfKWy6z9n2JuU=
X-Google-Smtp-Source: AGHT+IH9zalTXeJ5JjdVaMZ5kxZTumblylYHR0fnxBZeWPJquezB/aW+7gRC0IReJeHb2JcssgwZ2g==
X-Received: by 2002:a05:6a20:2453:b0:1e1:9662:a6f2 with SMTP id adf61e73a8af0-1e88d0bffe4mr41203169637.35.1736813227661;
        Mon, 13 Jan 2025 16:07:07 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm6717682b3a.173.2025.01.13.16.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:07:07 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com,
	linux@roeck-us.net,
	mohsin.bashr@gmail.com,
	jdelvare@suse.com,
	horms@kernel.org,
	suhui@nfschina.com,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next 1/3] eth: fbnic: hwmon: Add completion infrastructure for firmware requests
Date: Mon, 13 Jan 2025 16:07:03 -0800
Message-ID: <20250114000705.2081288-2-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114000705.2081288-1-sanman.p211993@gmail.com>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add infrastructure to support firmware request/response handling with
completions. Add a completion structure to track message state including
message type for matching, completion for waiting for response, and
result for error propagation. Use existing spinlock to protect the writes.
The data from the various response types will be added to the "union u"
by subsequent commits.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h    |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 79 ++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h | 13 ++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 50f97f5399ff..ad8ac5ac7be9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -41,6 +41,7 @@ struct fbnic_dev {

 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
 	struct fbnic_fw_cap fw_cap;
+	struct fbnic_fw_completion *cmpl_data;
 	/* Lock protecting Tx Mailbox queue to prevent possible races */
 	spinlock_t fw_tx_lock;

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 8f7a2a19ddf8..320615a122e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -228,6 +228,63 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 	tx_mbx->head = head;
 }

+static __maybe_unused int fbnic_mbx_map_req_w_cmpl(struct fbnic_dev *fbd,
+						   struct fbnic_tlv_msg *msg,
+						   struct fbnic_fw_completion *cmpl_data)
+{
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+
+	/* If we are already waiting on a completion then abort */
+	if (cmpl_data && fbd->cmpl_data) {
+		err = -EBUSY;
+		goto unlock_mbx;
+	}
+
+	/* Record completion location and submit request */
+	if (cmpl_data)
+		fbd->cmpl_data = cmpl_data;
+
+	err = fbnic_mbx_map_msg(fbd, FBNIC_IPC_MBX_TX_IDX, msg,
+				le16_to_cpu(msg->hdr.len) * sizeof(u32), 1);
+
+	/* If msg failed then clear completion data for next caller */
+	if (err && cmpl_data)
+		fbd->cmpl_data = NULL;
+
+unlock_mbx:
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+
+	return err;
+}
+
+static void fbnic_fw_release_cmpl_data(struct kref *kref)
+{
+	struct fbnic_fw_completion *cmpl_data;
+
+	cmpl_data = container_of(kref, struct fbnic_fw_completion,
+				 ref_count);
+	kfree(cmpl_data);
+}
+
+static __maybe_unused struct fbnic_fw_completion *
+fbnic_fw_get_cmpl_by_type(struct fbnic_dev *fbd, u32 msg_type)
+{
+	struct fbnic_fw_completion *cmpl_data = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+	if (fbd->cmpl_data && fbd->cmpl_data->msg_type == msg_type) {
+		cmpl_data = fbd->cmpl_data;
+		kref_get(&fbd->cmpl_data->ref_count);
+	}
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+
+	return cmpl_data;
+}
+
 /**
  * fbnic_fw_xmit_simple_msg - Transmit a simple single TLV message w/o data
  * @fbd: FBNIC device structure
@@ -802,3 +859,25 @@ void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 	fbnic_mk_full_fw_ver_str(mgmt->version, delim, mgmt->commit,
 				 fw_version, str_sz);
 }
+
+void fbnic_fw_init_cmpl(struct fbnic_fw_completion *fw_cmpl,
+			u32 msg_type)
+{
+	fw_cmpl->msg_type = msg_type;
+	init_completion(&fw_cmpl->done);
+	kref_init(&fw_cmpl->ref_count);
+}
+
+void fbnic_fw_clear_compl(struct fbnic_dev *fbd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fbd->fw_tx_lock, flags);
+	fbd->cmpl_data = NULL;
+	spin_unlock_irqrestore(&fbd->fw_tx_lock, flags);
+}
+
+void fbnic_fw_put_cmpl(struct fbnic_fw_completion *fw_cmpl)
+{
+	kref_put(&fw_cmpl->ref_count, fbnic_fw_release_cmpl_data);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 221faf8c6756..ff304baade91 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -44,6 +44,15 @@ struct fbnic_fw_cap {
 	u8	link_fec;
 };

+struct fbnic_fw_completion {
+	u32 msg_type;
+	struct completion done;
+	struct kref ref_count;
+	int result;
+	union {
+	} u;
+};
+
 void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
@@ -52,6 +61,10 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
+			u32 msg_type);
+void fbnic_fw_clear_compl(struct fbnic_dev *fbd);
+void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);

 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
 do {									\
--
2.43.5

