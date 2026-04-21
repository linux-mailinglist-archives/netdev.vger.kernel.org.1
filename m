Return-Path: <netdev+bounces-280008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OPVHkcI52kw3AEAu9opvQ
	(envelope-from <netdev+bounces-280008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:16:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B21F8436606
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26F93017272
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59F32BF52;
	Tue, 21 Apr 2026 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSZNSXG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C81329C71
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776748612; cv=none; b=R5jfFLOrltyMhgl4sx6Qm/LoT9dewDuVufPLjbxLm6FySBo8pkvh/uSoJLOWP7eSnE8MkZaS8u82+MHh4RFffEnOUvADIjUHIAmWRywMafK3z9qvs1AizMf8XRba4xozw+BUZPsBrQd9WUbjKryfrDJ6LSYoFKqUT4lSYdLor3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776748612; c=relaxed/simple;
	bh=AsbnMpFONbIDo5pyXn8vuz90ne6udRW4bcDZJjEvjK0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A+MNyfBKQhQSmEIRnzJNTLP8U374eOPDjBccu8hgngOmkc49l+N2ye6og5XJPAAXkel/1lE8JICFIS3+hMydOyhMECaQ0yx7pgGE50+MrC8Pj5yvIQwan5CbFdilfOmFNiptqnfISB2EveSf1HBc7sB9ZVehFaz23K0faWP5YhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSZNSXG+; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12db218e265so1841155c88.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 22:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776748610; x=1777353410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7D53xtOFZWTTNmBFly2sMy6Aan/RQNTrroS2iD/6/Xo=;
        b=JSZNSXG+qAKeNErBN8yODLAhWR5fjEM1z0GMtdWPMSn4LKaqwozZabVOJAlenXSUGH
         6w1zGqUsQ/Ew2JAzznZL1EMf96JprNGxN5cJTh/mIcCD/jTkQF34SvM5HgtudjwfzagE
         wHAQEqlVYP2oq8/LnLi+hqDXHs7w26P9va+VW4JzvDTzX1QZ38eITvX3PwO3rMn1NQXB
         Nr5vwG1QYmWa0bydsDV75KT1PgNO4KutA7/iNknvGuiBZ9cDgaIMuK+4Fup8tRFMLW28
         Mj/PjcoQorcziPVIc9tYREJrnOeRdx3sKz3gOi+5lxFCQIrwb+VwCuCdbxDps4e6Xqyc
         a40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776748610; x=1777353410;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7D53xtOFZWTTNmBFly2sMy6Aan/RQNTrroS2iD/6/Xo=;
        b=Ql9AxEvYIJjWXfrLaFDAtGVJP9BPUb2ZdKc8Wqfh3fd7iR1ugCald7/skxa8w1krzq
         AjfzfmV3UgTlYr/jD5sDcxk7ZZW8kgeyg/KDCmaRHdvB2Xu2NEf0iOdBmcV5BU9MOQBc
         PEYqGJR8OX4I3pWIJ8XbjG7ONZSEPjS1LemoGaLwzF7Ph4yr2UuiA7qrxKnqGz85FJFU
         qxyyqWYN6l2lHVTMxuShbP25QVuErbsIjk2aXXqXnzwvuGfJ+yLLIK+ThK6bCcaJKc9J
         idn+NrTI53tiDncwg9AqDVZJtVdEvYv5kBFjZiGqq1Fy3xGyfIQV3kGVjxtZe9C9C62N
         xmzQ==
X-Gm-Message-State: AOJu0Yy7P63mJmfk8cyVpdn6GjpJPMZmfVBBMrx4fsJ9E6kAfMJQxfvZ
	RLZDHxWO8tmymfIgRg49UcnVAUd9Kgx0BkY1QwYb+cW6VgbDDfmntFCRNGmUtaw9pPzne+yLL6m
	o/WeIHw==
X-Received: from dlbsn12.prod.google.com ([2002:a05:7022:b90c:b0:12d:b26a:1571])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6290:b0:12c:8f92:c6ba
 with SMTP id a92af1059eb24-12c8f92c9damr3936024c88.34.1776748609630; Mon, 20
 Apr 2026 22:16:49 -0700 (PDT)
Date: Tue, 21 Apr 2026 05:16:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421051641.370436-1-boolli@google.com>
Subject: [PATCH iwl-net v2] idpf: do not perform flow ops when netdev is detached
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280008-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B21F8436606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
handling a reset") prevents ethtool -N/-n operations to operate on
detached netdevs, we found that out-of-tree workflows like OpenOnload
can bypass ethtool core locks and call idpf_set_rxnfc directly during
an idpf HW reset. When this happens, we could get kernel crashes like
the following:

[ 4045.787439] BUG: kernel NULL pointer dereference, address: 0000000000000070
[ 4045.794420] #PF: supervisor read access in kernel mode
[ 4045.799580] #PF: error_code(0x0000) - not-present page
[ 4045.804739] PGD 0
[ 4045.806772] Oops: Oops: 0000 [#1] SMP NOPTI
...
[ 4045.836425] Workqueue: onload-wqueue oof_do_deferred_work_fn [onload]
[ 4045.842926] RIP: 0010:idpf_del_flow_steer+0x24/0x170 [idpf]
...
[ 4045.946323] Call Trace:
[ 4045.948796]  <TASK>
[ 4045.950915]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 4045.955293]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 4045.959672]  ? idpf_set_rxnfc+0x6f/0x80 [idpf]
[ 4046.063613]  </TASK>

To prevent this, we need to add checks in idpf_set_rxnfc and
idpf_get_rxnfc to error out if the netdev is already detached.

Tested: synthetically forced idpf into a HW reset by introducing module
parameters to simulate a Tx timeout and force virtual channel
initialization failure. This was done by skipping completion cleaning for
specific queues and returning -EIO during core initialization.
The failure was then triggered by writing 1 to the corresponding sysfs
parameters and calling idpf_get_rxnfc() during the reset process.

Without the patch: encountered NULL pointer and kernel crash.

With the patch: no crashes.

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Cc: stable@vger.kernel.org
Signed-off-by: Li Li <boolli@google.com>
---
v2:
- Removed the raw code block from the commit message and replaced it with
  a textual description of the test modifications.

 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index bb99d9e7c65d..8368a7e6a754 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	unsigned int cnt = 0;
 	int err = 0;
 
+	if (!netdev || !netif_device_present(netdev))
+		return -ENODEV;
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 	vport_config = np->adapter->vport_config[np->vport_idx];
@@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 {
 	int ret = -EOPNOTSUPP;
 
+	if (!netdev || !netif_device_present(netdev))
+		return -ENODEV;
+
 	idpf_vport_ctrl_lock(netdev);
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-- 
2.54.0.rc1.555.g9c883467ad-goog


