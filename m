Return-Path: <netdev+bounces-272873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDqjDNb/yGn1tAUAu9opvQ
	(envelope-from <netdev+bounces-272873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98398351964
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 853B9300D9E7
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EC30C63B;
	Sun, 29 Mar 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNBGtbCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DE302163
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774780371; cv=none; b=aPeLrD0RWxVPYHFdU/3H9X6NET4MANoUz+MeIJpBPhsFfR2dZPrnghsSLNojaHgLG+3DIozY8HM8ruyxYynorV1VqjHeXkcI1StoEp0MTOhyfXsoOO7s7uGVeBhhFm9/Iv9Cg/LGk+k7OorKaBzNEzyKNF3xAcHN7loxIsRWwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774780371; c=relaxed/simple;
	bh=H5kTsfBqoaymzwtE0f4kGO+QKpbjF0HlaDUOV/uNet4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=curUiewA9qe4TXof99QGfFrRjlDRC56BXv7PlJKFEpjQLCIwaPxN+idkgo6mojiAcBgtFs8bE+aiDfLKATGMU53uxtmYGctSn+KL5vYYrDUZ2+ydAAg6M+pLQGAO1/TrUdR2WWA9yAEi/aPLkcQk5ZpIeoBKGH+un4IxggJcSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNBGtbCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA82C116C6;
	Sun, 29 Mar 2026 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774780371;
	bh=H5kTsfBqoaymzwtE0f4kGO+QKpbjF0HlaDUOV/uNet4=;
	h=From:Date:Subject:To:Cc:From;
	b=QNBGtbCZnr0gu12JO1gWqdp4bWA8J7HoSjvT1LVvQbCnbMFE3C9T4UYIEw4wukuwQ
	 jZimwY98STVOauxRL20o9HbKie2RcSdFoMidfjwtReYd4C7qQttMw0eylELXZTbMvB
	 NuVW8Kn+vlA+AwEw0DpgIx+XBcbq+PZAdotca542CkUOmWBNLmGWZEYcvu0B+U3Iut
	 QoMROxGrjptruN+VkxtTPLYCO5d7XjfnJjDVx1iRaC6z9xrsAAvbkAZ+RmRPzG22Ee
	 5PcOCrxRFIztWmUQNWarcbBUDnKal4PyE7VsfkzIsUOFiAk+z8CdW+ln0pYNUH0IYf
	 crygs3pG88P1w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 29 Mar 2026 12:32:27 +0200
Subject: [PATCH net-next v2] net: airoha: Delay offloading until all
 net_devices are fully registered
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-airoha-regiser-race-fix-v2-1-f4ebb139277b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf0X23C1Jqqn01P8oHlLd6NKSyEbEI
 vn3Bum1x5nhvdkhkTAluFU7CK2cOIYSzKmCfnJhJOShZDDKWHUxGh1LnBwKjVxQFNcTet7QU9v
 U3urhahUUehYq9WF+QKAFA20LdGWZOC1RPsflqo/9Z6//2leNGq3S9eCbpm3t8/4iCfQ+Rxmhy
 zl/AW1cTiHJAAAA
X-Change-ID: 20260321-airoha-regiser-race-fix-fe854f61d760
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272873-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98398351964
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Netfilter flowtable can theoretically try to offload flower rules as soon
as a net_device is registered while all the other ones are not
registered or initialized, triggering a possible NULL pointer dereferencing
of qdma pointer in airoha_ppe_set_cpu_port routine. Moreover, if
register_netdev() fails for a particular net_device, there is a small
race if Netfilter tries to offload flowtable rules before all the
net_devices are properly unregistered in airoha_probe() error patch,
triggering a NULL pointer dereferencing in airoha_ppe_set_cpu_port
routine. In order to avoid any possible race, delay offloading until
all net_devices are registered in the networking subsystem.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Do not grab flow_offload_mutex in airoha_register_gdm_devices() since
  it can trigger a deadlock. Add DEV_STATE_REGISTERED flag instead to
  mark when all net_devices are fully registered.
- Link to v1: https://lore.kernel.org/r/20260324-airoha-regiser-race-fix-v1-1-6014df55886b@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 ++
 drivers/net/ethernet/airoha/airoha_eth.h | 1 +
 drivers/net/ethernet/airoha/airoha_ppe.c | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 82e53c60f561f6314fbf201ba8bc8711e40edc68..743ef0db30980ce74059dfb63553030ef3bf735f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2957,6 +2957,8 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 			return err;
 	}
 
+	set_bit(DEV_STATE_REGISTERED, &eth->state);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 7df4dbcd8861856c54c2a38bc89c69180ac2f6dc..af29fc74165b8fffb59f45b4725dbd963f1b876d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -88,6 +88,7 @@ enum {
 
 enum {
 	DEV_STATE_INITIALIZED,
+	DEV_STATE_REGISTERED,
 };
 
 enum {
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 58b14aea7c2f33ebce11c51d892eefff692378ca..c057bb2d105d92947bb8c421d89ee94fc0c10f2f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1389,6 +1389,13 @@ int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data)
 	struct airoha_eth *eth = ppe->eth;
 	int err = 0;
 
+	/* Netfilter flowtable can try to offload flower rules while not all
+	 * the net_devices are registered or initialized. Delay offloading
+	 * until all net_devices are registered in the system.
+	 */
+	if (!test_bit(DEV_STATE_REGISTERED, &eth->state))
+		return -EBUSY;
+
 	mutex_lock(&flow_offload_mutex);
 
 	if (!eth->npu)

---
base-commit: ced629dc8e5c51ff2b5d847adeeb1035cd655d58
change-id: 20260321-airoha-regiser-race-fix-fe854f61d760

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


