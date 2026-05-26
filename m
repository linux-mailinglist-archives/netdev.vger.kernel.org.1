Return-Path: <netdev+bounces-291758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOCIA3DBFWoiaQcAu9opvQ
	(envelope-from <netdev+bounces-291758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:51:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD35D90FB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 590A7308C622
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B936CDEB;
	Tue, 26 May 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv04Lf+O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBB36D51F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809814; cv=none; b=LDbjOGSgGD1TwCuKNPcvoIRFWPAhgnxK6MYCrmfyR16YtktSOyhZM9eFUa229b/F19T0J04zTwoSj37oQIIDzDoNwIMwvPxEgz6QK0oTT2fvcSMRd5XN/1XsbN6rv8tL/wDhHQKIuG4aRN7BDJ8pSOWV6orS59D9z+zCyI0xttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809814; c=relaxed/simple;
	bh=u1f/lv9a5xvNrucLd88LEela/WKBYg78P2SybSb6mnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6J80Dv063nfUdj9WYsKYN+9EIBbX2Gmoq+6jG4dGgaCynxJ9xookK1YD2EEw8A90cZGXquhheDJBcTK83dLRIsWD379LWC8VbPPywcw6PgSJ7pSA/s77EeaKwouVT5x6mDsWdgSpfDr2QK6nCVfvJYJBvda7qqN5UDrRTNtVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv04Lf+O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86A01F000E9;
	Tue, 26 May 2026 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809813;
	bh=D8n1nR/VDie/PvMcsuGWihw70M+/oasU5gFzLqGnmYk=;
	h=From:To:Cc:Subject:Date;
	b=Dv04Lf+Ohpusg0QDUSLMbJ+3JRDrHU2+9LTPMOb6qZ8L1ESF0kte+fKMKkY/sTySD
	 bCUKpA+odjaLXMhBtwvp/FDTkv7DhfYUXuuxUamCmjyPGTGKl2uq4bnhuVXWVldhYw
	 0Utp33CxfV0gPRzndNkP40aZg3EvhI5j/GtUMNBWOEI78gOVKIoJQpwss4TQz8ySob
	 QBIjuM1y0onoZ3+ig8ox94Zj4m0ncaXb5ViTYo212bwPW3or6O6HQjzPuiQi0Ox7sp
	 eCx3nvOZmZkqSHIh1OYp0igT1Er25YChVgfva0vt7fxS+TIyrLpazNdEpj3bnoIyb8
	 NA/DEFiGVBWIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	richardcochran@gmail.com,
	yangbo.lu@nxp.com,
	kuniyu@google.com,
	willemb@google.com
Subject: [PATCH net] ethtool: vclock: propagate errors from ptp_get_vclocks_index()
Date: Tue, 26 May 2026 08:36:50 -0700
Message-ID: <20260526153650.2779821-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291758-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B9AD35D90FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ptp_get_vclocks_index() was written with sock_timestamping_bind_phc()
in mind. Any return <= 0 will get converted to EINVAL by the virtue
of sock_timestamping_bind_phc() not finding a matching vclock.

ethtool's phc_vclocks_prepare_data(), however, should not be silently
returning empty messages on allocation errors or when PHC does not
exist at all.

Commit c156174a6707 ("ethtool: add a new command for getting PHC virtual
clocks") added phc_vclocks_prepare_data(), but let's not treat this
as a fix in case some user space app now depends on the failures being
silent.

The check in sock_timestamping_bind_phc() is not strickly necessary,
but include it just for clarity.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: richardcochran@gmail.com
CC: yangbo.lu@nxp.com
CC: kuniyu@google.com
CC: willemb@google.com
---
 include/linux/ptp_clock_kernel.h |  4 ++--
 drivers/ptp/ptp_vclock.c         | 23 +++++++++++++----------
 net/core/sock.c                  |  2 ++
 net/ethtool/phc_vclocks.c        |  2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 884364596dd3..a245989e13c1 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -485,7 +485,7 @@ static inline void ptp_cancel_worker_sync(struct ptp_clock *ptp)
  * @pclock_index: phc index of ptp pclock.
  * @vclock_index: pointer to pointer of vclock index.
  *
- * return number of vclocks.
+ * Returns: number of vclocks on success, or negative errno.
  */
 int ptp_get_vclocks_index(int pclock_index, int **vclock_index);
 
@@ -500,7 +500,7 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index);
 ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index);
 #else
 static inline int ptp_get_vclocks_index(int pclock_index, int **vclock_index)
-{ return 0; }
+{ return -ENODEV; }
 static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 					    int vclock_index)
 { return 0; }
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 915a4f6defc9..062860756640 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -242,33 +242,36 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index)
 	char name[PTP_CLOCK_NAME_LEN] = "";
 	struct ptp_clock *ptp;
 	struct device *dev;
-	int num = 0;
+	int ret;
 
 	if (pclock_index < 0)
-		return num;
+		return -ENODEV;
 
 	snprintf(name, PTP_CLOCK_NAME_LEN, "ptp%d", pclock_index);
 	dev = class_find_device_by_name(&ptp_class, name);
 	if (!dev)
-		return num;
+		return -ENODEV;
 
 	ptp = dev_get_drvdata(dev);
 
 	if (mutex_lock_interruptible(&ptp->n_vclocks_mux)) {
-		put_device(dev);
-		return num;
+		ret = -EINTR;
+		goto exit_put_dev;
 	}
 
 	*vclock_index = kzalloc(sizeof(int) * ptp->n_vclocks, GFP_KERNEL);
-	if (!(*vclock_index))
-		goto out;
+	if (!(*vclock_index)) {
+		ret = -ENOMEM;
+		goto exit_unlock;
+	}
 
 	memcpy(*vclock_index, ptp->vclock_index, sizeof(int) * ptp->n_vclocks);
-	num = ptp->n_vclocks;
-out:
+	ret = ptp->n_vclocks;
+exit_unlock:
 	mutex_unlock(&ptp->n_vclocks_mux);
+exit_put_dev:
 	put_device(dev);
-	return num;
+	return ret;
 }
 EXPORT_SYMBOL(ptp_get_vclocks_index);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index b37b664b6eb9..9e33e979a283 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -870,6 +870,8 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
 
 	num = ethtool_get_phc_vclocks(dev, &vclock_index);
 	dev_put(dev);
+	if (num < 0)
+		return num;
 
 	for (i = 0; i < num; i++) {
 		if (*(vclock_index + i) == phc_index) {
diff --git a/net/ethtool/phc_vclocks.c b/net/ethtool/phc_vclocks.c
index 15146e38ab27..eec5a08f950b 100644
--- a/net/ethtool/phc_vclocks.c
+++ b/net/ethtool/phc_vclocks.c
@@ -36,7 +36,7 @@ static int phc_vclocks_prepare_data(const struct ethnl_req_info *req_base,
 	data->num = ethtool_get_phc_vclocks(dev, &data->index);
 	ethnl_ops_complete(dev);
 
-	return ret;
+	return data->num < 0 ? data->num : 0;
 }
 
 static int phc_vclocks_reply_size(const struct ethnl_req_info *req_base,
-- 
2.54.0


