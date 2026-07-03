Return-Path: <netdev+bounces-304495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j5RbCjWWR2qrbgAAu9opvQ
	(envelope-from <netdev+bounces-304495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:00:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23962701893
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:00:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=PjaGuWCM;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304495-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304495-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2415630EA807
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB843DB30C;
	Fri,  3 Jul 2026 10:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037DA3BCD20
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:42:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075351; cv=none; b=G7X29ZatlTJDMJXmNvl225O+LL4Ck+jFLnQ76rwX2PP47PNbnLeyrEW0HgKkLcSNy+8Ok9Keld/RtuQLuyHvA8aM5Z++byUqkq7rDRxTEeew0VBSW4QlhpwcZUQNwRTtUP+vnM2JM0U8wGMmwE65Nw9qUj5atHEHxELWNkfte7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075351; c=relaxed/simple;
	bh=y9TZypuTsViLurUr/O/LLHu+C57FU2NtKKg023NLEV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EudEuOQVdlHtsJ0AaAUhB2qF045JFpgrN7vXBTNixKly6jFUtCXNB9APcSYdQXyD2dxV5iKKy4LNlTJvkUNfe28mL4gjGlfyuuynbzseVpYiaz5g4XGPPEi1I2zxz2fyeaxwopYZvNEoFASAbL0vmWL6tcRuTB4i1cIx5e6pqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PjaGuWCM; arc=none smtp.client-ip=91.218.175.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783075346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IErgOCnY357EdDsvHsbdxH5kQFV9ptIXeCqdksR3JFQ=;
	b=PjaGuWCMQ5Z9bxU5aLGaW9YuAYEwMv2+XTf5jLNkAnKtiVt2M05n4pfTPpWg4lh8nwh68r
	kPNDSgJAi1otYtU9xhPo28qnPfFUE1TMa+xGmibjw4u0Ao8eTyDx9VvOBm1VyBLxEaopr5
	5BMUt6NVSBv/4YMoo5eo6bjwp2isaYw=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v1] idpf: fix lan_regs leak on core init failure
Date: Fri,  3 Jul 2026 18:41:32 +0800
Message-ID: <20260703104132.47419-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304495-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:joshua.a.hay@intel.com,m:tatyana.e.nikolova@intel.com,m:luoxuanqiang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23962701893

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

idpf_vc_core_init() gets the LAN memory region layout before mapping the
regions and allocating vport resources. Both layout paths allocate
hw->lan_regs, but later error paths return without freeing it.

idpf_vc_core_deinit() does not cover these paths because it returns unless
IDPF_VC_CORE_INIT is set, and that bit is set only after core init
succeeds.

Free hw->lan_regs on the post-allocation error paths and clear the
pointer and region count.

Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101c..da49bb7b7e671 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3479,6 +3479,7 @@ static int idpf_vport_params_buf_alloc(struct idpf_adapter *adapter)
  */
 int idpf_vc_core_init(struct idpf_adapter *adapter)
 {
+	struct idpf_hw *hw = &adapter->hw;
 	int task_delay = 30;
 	u16 num_max_vports;
 	int err = 0;
@@ -3550,15 +3551,18 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map BAR0 region(s): %d\n",
 			err);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_lan_regs;
 	}
 
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
 	adapter->max_vports = num_max_vports;
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
-	if (!adapter->vports)
-		return -ENOMEM;
+	if (!adapter->vports) {
+		err = -ENOMEM;
+		goto err_lan_regs;
+	}
 
 	if (!adapter->netdevs) {
 		adapter->netdevs = kzalloc_objs(struct net_device *,
@@ -3624,6 +3628,10 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 err_netdev_alloc:
 	kfree(adapter->vports);
 	adapter->vports = NULL;
+err_lan_regs:
+	kfree(hw->lan_regs);
+	hw->lan_regs = NULL;
+	hw->num_lan_regs = 0;
 	return err;
 
 init_failed:
-- 
2.43.0


