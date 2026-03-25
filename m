Return-Path: <netdev+bounces-271429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMeZKSmNw2nJrQQAu9opvQ
	(envelope-from <netdev+bounces-271429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A33209E9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0223039F7D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05963365A01;
	Wed, 25 Mar 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJcpoXV0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EB363096;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423299; cv=none; b=KdCe3J217swwN5rWKvjp++wbiqBdWuQJRsJvLlZW81/W/EYcPC/ptyXpIySj4Dw3PTxLqBner2Rs3eNSRAcLHlUqq1kJ5+FiOkU+20v3Ms7byRkievn850pyZHQd5T22tUa5QT7ZlTAcBXLabjtrRuDdfL9VanddYS5vjv4tbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423299; c=relaxed/simple;
	bh=8nzLFxeuDNYsf3IkWcj76Hg9mmDN27Zptu4KIN/CWj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R37ImRkyySyDGCYv7mvSnbtYVnvZZzf3kCrqKq+y3WcCs+jmuJBquIFR62SxjZhLuWftA3lnJwt+1fA5RbfPqqDUKIeYK7lGuwo2CUcqdJDj+nqpahC3HfGBdjixsW6JL09ahIz9yOrNYAkL4LGfN5xl+CKKATK4Ym9/oAxazWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJcpoXV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D4EC2BCB5;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423299;
	bh=8nzLFxeuDNYsf3IkWcj76Hg9mmDN27Zptu4KIN/CWj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MJcpoXV0ruIEoazELldF7zEiMNsRK2Bcdnf7AtpHKbhzRaC2fSNPcW96BuRa3JWUr
	 vSZBT+3Z/WrHmF7U6KkymkiV6JORe34gCt8f6qc5ws4NpNDu+aqqBQRZvYBRx4x+gj
	 r/TsStRQPfnWSbrr+3p9O9jw4FNlW/Jx4F2IpUMy0u3IP0zCb3OBIDxTk6884DKPr1
	 vfDVi6A8RQK5Z1eej0t1vHvr4oMcvrqTjHq6E2M7N1nb1QkY7DHgCusZJfIlL82nme
	 x999HhXjZGXTYp9QJ3G0YnJJQT0JUQIFveHAALaOizPEhTVe8W63vVMxFuEh8sLxFA
	 RNLkSZ+24ncJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74DAFEA81E;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 00:21:42 -0700
Subject: [PATCH net-next 4/6] enic: make enic_dev_enable/disable
 ref-counted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v1-4-48f04ce110cc@cisco.com>
References: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774423298; l=2385;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=UFxmA9CX8KV13iHlUmy26fUHGETjz4zvpBBpux+w9yI=;
 b=rw64LSAVKDU+d9rEkfxiLMhaDAlEJrSBY7/kjU9fKL9z5pe3gWK5QwiHGnu5P6DFX0QRFwjVw
 bh98qC5V2ewCs/xOa/+EIduHUitRIZ8BA9KYv0go1DeFHKEL6s9OkTm
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271429-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 235A33209E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Both the data path (ndo_open/ndo_stop) and the upcoming admin channel
need to enable and disable the vNIC device independently. Without
reference counting, closing the admin channel while the netdev is up
would inadvertently disable the entire device.

Add an enable_count to struct enic, protected by the existing
devcmd_lock. enic_dev_enable() issues CMD_ENABLE_WAIT only on the
first caller (0 -> 1 transition), and enic_dev_disable() issues
CMD_DISABLE only when the last caller releases (1 -> 0 transition).

No functional change for the current single-caller data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     |  1 +
 drivers/net/ethernet/cisco/enic/enic_dev.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 0fd9cd917132..67fd780b1fa1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -260,6 +260,7 @@ struct enic {
 	u16 num_vfs;
 #endif
 	enum enic_vf_type vf_type;
+	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
 	struct enic_port_profile *pp;
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
index 2cbae7c6cc3d..659787f73cf1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
@@ -131,10 +131,13 @@ int enic_dev_set_ig_vlan_rewrite_mode(struct enic *enic)
 
 int enic_dev_enable(struct enic *enic)
 {
-	int err;
+	int err = 0;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_enable_wait(enic->vdev);
+	if (enic->enable_count == 0)
+		err = vnic_dev_enable_wait(enic->vdev);
+	if (!err)
+		enic->enable_count++;
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;
@@ -142,10 +145,16 @@ int enic_dev_enable(struct enic *enic)
 
 int enic_dev_disable(struct enic *enic)
 {
-	int err;
+	int err = 0;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_disable(enic->vdev);
+	if (enic->enable_count == 0) {
+		spin_unlock_bh(&enic->devcmd_lock);
+		return 0;
+	}
+	enic->enable_count--;
+	if (enic->enable_count == 0)
+		err = vnic_dev_disable(enic->vdev);
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;

-- 
2.43.0



