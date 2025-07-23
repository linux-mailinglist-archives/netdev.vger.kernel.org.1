Return-Path: <netdev+bounces-209233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C50B0EC6E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A8C3A82D8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFBA277C9F;
	Wed, 23 Jul 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QzqC2Yx9"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9350277C8D
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257272; cv=none; b=C1DtZiNJ5FTM+cMTmgB6S2AnS5DOJW7tPG3Cni6stiVNSjtGBTQCkC2clKQj02yHSmWfBUMWCKO/bRkKaF+tqwfrzjtHLb/MlISh4HFbccM3+12fHIhXPe60hjhgEKWF0/38KzkLDi7+NYmDMYLVI4XNqh119vE31Hc5jQ6w7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257272; c=relaxed/simple;
	bh=q0XqIPmIXN6sQ4Wk4G1BCEgTX2MVQ4xrWRo9v5xi4tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHEdb1cGQsq7iJ7PPZOC41YJmTvXM/cXrs8mD9UH6rcojYL6dmRJbhEYnJRqjqwpNHwEG4yGXDlXDTY6NueFSMc0HrGEfjW01xU9ya7KzQ5VU32ZPbRVmiQPflKCgBGqaYVsFD/ixlRqXzKd+06KGb7k/HqfTZxkqTH8PSVZ4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QzqC2Yx9; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C2D24201A1;
	Wed, 23 Jul 2025 09:54:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RqzGReai_oyI; Wed, 23 Jul 2025 09:54:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DC6BB20897;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DC6BB20897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257260;
	bh=jf7CVEfCX/hkAmQTN1RDcLnhnatxfeI/1juKZnde7Fc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QzqC2Yx9OP+6YMft4XUffH36HjbkCBI0h61XHywoErru6R/auml941zm7qLoDII8/
	 15mKk3Z9RbNilQLZ1caJhd12pv40HbH4HTmWuRoeE1fnTpQfGubUa6R2AYlM9eH6zt
	 w+8TExJlkTix/yOn3kVfpj25gyQFsgELl+5Gmyy96iKdA2KocQhGnFD1TKYCRwYEr/
	 AsaVrp6pzKy7PBH+sdw8w0slEI1GFdm8191iGk6kGUHX39JyNqRe9R4Z8U9GVgMVxd
	 B5fNDt0Ev5/XEtu1xuavQfcRuBncFwhYw6LUHXjAqf3fTEsR/YlmlMvDgFrQUZ8NJH
	 RolQBFMMX09hw==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A9CB43184230; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/8] xfrm: interface: fix use-after-free after changing collect_md xfrm interface
Date: Wed, 23 Jul 2025 09:53:58 +0200
Message-ID: <20250723075417.3432644-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Eyal Birger <eyal.birger@gmail.com>

collect_md property on xfrm interfaces can only be set on device creation,
thus xfrmi_changelink() should fail when called on such interfaces.

The check to enforce this was done only in the case where the xi was
returned from xfrmi_locate() which doesn't look for the collect_md
interface, and thus the validation was never reached.

Calling changelink would thus errornously place the special interface xi
in the xfrmi_net->xfrmi hash, but since it also exists in the
xfrmi_net->collect_md_xfrmi pointer it would lead to a double free when
the net namespace was taken down [1].

Change the check to use the xi from netdev_priv which is available earlier
in the function to prevent changes in xfrm collect_md interfaces.

[1] resulting oops:
[    8.516540] kernel BUG at net/core/dev.c:12029!
[    8.516552] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    8.516559] CPU: 0 UID: 0 PID: 12 Comm: kworker/u80:0 Not tainted 6.15.0-virtme #5 PREEMPT(voluntary)
[    8.516565] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    8.516569] Workqueue: netns cleanup_net
[    8.516579] RIP: 0010:unregister_netdevice_many_notify+0x101/0xab0
[    8.516590] Code: 90 0f 0b 90 48 8b b0 78 01 00 00 48 8b 90 80 01 00 00 48 89 56 08 48 89 32 4c 89 80 78 01 00 00 48 89 b8 80 01 00 00 eb ac 90 <0f> 0b 48 8b 45 00 4c 8d a0 88 fe ff ff 48 39 c5 74 5c 41 80 bc 24
[    8.516593] RSP: 0018:ffffa93b8006bd30 EFLAGS: 00010206
[    8.516598] RAX: ffff98fe4226e000 RBX: ffffa93b8006bd58 RCX: ffffa93b8006bc60
[    8.516601] RDX: 0000000000000004 RSI: 0000000000000000 RDI: dead000000000122
[    8.516603] RBP: ffffa93b8006bdd8 R08: dead000000000100 R09: ffff98fe4133c100
[    8.516605] R10: 0000000000000000 R11: 00000000000003d2 R12: ffffa93b8006be00
[    8.516608] R13: ffffffff96c1a510 R14: ffffffff96c1a510 R15: ffffa93b8006be00
[    8.516615] FS:  0000000000000000(0000) GS:ffff98fee73b7000(0000) knlGS:0000000000000000
[    8.516619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.516622] CR2: 00007fcd2abd0700 CR3: 000000003aa40000 CR4: 0000000000752ef0
[    8.516625] PKRU: 55555554
[    8.516627] Call Trace:
[    8.516632]  <TASK>
[    8.516635]  ? rtnl_is_locked+0x15/0x20
[    8.516641]  ? unregister_netdevice_queue+0x29/0xf0
[    8.516650]  ops_undo_list+0x1f2/0x220
[    8.516659]  cleanup_net+0x1ad/0x2e0
[    8.516664]  process_one_work+0x160/0x380
[    8.516673]  worker_thread+0x2aa/0x3c0
[    8.516679]  ? __pfx_worker_thread+0x10/0x10
[    8.516686]  kthread+0xfb/0x200
[    8.516690]  ? __pfx_kthread+0x10/0x10
[    8.516693]  ? __pfx_kthread+0x10/0x10
[    8.516697]  ret_from_fork+0x82/0xf0
[    8.516705]  ? __pfx_kthread+0x10/0x10
[    8.516709]  ret_from_fork_asm+0x1a/0x30
[    8.516718]  </TASK>

Fixes: abc340b38ba2 ("xfrm: interface: support collect metadata mode")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_interface_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index cb1e12740c87..330a05286a56 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -875,7 +875,7 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
-	if (p.collect_md) {
+	if (p.collect_md || xi->p.collect_md) {
 		NL_SET_ERR_MSG(extack, "collect_md can't be changed");
 		return -EINVAL;
 	}
@@ -886,11 +886,6 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	} else {
 		if (xi->dev != dev)
 			return -EEXIST;
-		if (xi->p.collect_md) {
-			NL_SET_ERR_MSG(extack,
-				       "device can't be changed to collect_md");
-			return -EINVAL;
-		}
 	}
 
 	return xfrmi_update(xi, &p);
-- 
2.43.0


