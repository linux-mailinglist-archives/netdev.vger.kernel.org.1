Return-Path: <netdev+bounces-254325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLVgHMwxemlp4gEAu9opvQ
	(envelope-from <netdev+bounces-254325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:57:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 189EAA4C81
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D50D3080D0A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5933043B2;
	Wed, 28 Jan 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="EcmPzKZp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8083033D0;
	Wed, 28 Jan 2026 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615096; cv=none; b=iA67kkzqJmeCqF3SDjEgGDRy7yuVXcQjFFdZ8IUT2pBhTl6/26IPDO9DzEyCk5IYq6gEeV417QBuqtnvrO1R8sGDyx7uDg38A2BNDsG2gJeRHVsA3vtMml3P70OfDF+w6DtDoviAYlbUsU9NV7LFUp5AzCSDEESDMmpqGMkQtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615096; c=relaxed/simple;
	bh=NityzUWCelBGk63VrsL8Az3jeSVaZ0dayuzmlGS9nJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWY4jab7ph5QUfH/69AZ2JYpA9iVbjLnjUZVMGp1Wpua9eX3Y2lBreqDbikydRkyPC597AstjOVLskBT8HtztqypXnFJylKnSY3xAD55+lm7+RUtTi1ig2sjifOKDGtiRX23S7nHzQbXP2p5cHnqat+xWy08sUEzj3IcZXTKDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=EcmPzKZp; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.215.202.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id 324da1fd5;
	Wed, 28 Jan 2026 23:44:43 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kory.maincent@bootlin.com,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v4 0/3] net: liquidio: Fix memory leaks in setup_nic_devices()
Date: Wed, 28 Jan 2026 15:44:37 +0000
Message-Id: <20260128154440.278369-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0547464b03a1kunm1b02b57ddb3d7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkJIVh8aTE9ITR4YQklOTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJSk5VSUtJVUlLSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=EcmPzKZpqgA2w/JQBfUd+qOY22r6gI9dpr4dJphCkiuuJqz3KH+OkSDJNIFm+8Kuzg+0mHlVBfEMvyk15qlg9Y1qnt28DQbysVbMhL/A6ytW6zFYj700+y0FwpN3XhecmYtvuNYxGNLNIPox+DTw+ByOh1aYc71nheR4zN3kOQc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9e2r8TX4Ee46DNnsYZy10PdzqGVSjVdn1n6GPKWYFBI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 189EAA4C81
X-Rspamd-Action: no action

This series fixes memory leaks in the initialization paths of the 
NIC devices.

Patch 1 moves the initialization of oct->props[i].netdev before queue 
setup calls. This ensures that if queue setup fails, the cleanup function 
can find and free the allocated netdev. It also initializes lio->oct_dev 
early to prevent a crash in the cleanup path.

Patch 2 fixes an off-by-one error in the PF cleanup loop. It ensures
the current device index is cleaned up and correctly handles the 
post-loop devlink_alloc failure case.

Patch 3 fixes the same off-by-one error in the VF cleanup loop.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Changes in v4:
- Move the netdev initialization fix to patch 1, as it is a 
  prerequisite for the cleanup fixes.
- Change the cleanup loop to 'do { ... } while (i >= 0)' in PF and VF 
  setup_nic_devices(), as the caller guarantees octeon_dev->ifcount > 0,
  ensuring i is never decremented below 0.

Changes in v3:
- Split the off-by-one fix into separate patches for PF and VF.
- Patch 2: Decrement i in the devlink_alloc error path before jumping
  to cleanup to avoid accessing an invalid index.
- Patch 1: Initialize lio->oct_dev alongside props->netdev to prevent 
  NULL pointer dereference in cleanup_rx_oom_poll_fn().

Changes in v2:
- Add patch 2 to fix an off-by-one error in the error handling loop logic.

Zilin Guan (3):
  net: liquidio: Initialize netdev pointer before queue setup
  net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
  net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup

 .../net/ethernet/cavium/liquidio/lio_main.c   | 39 ++++++++++---------
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  4 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.34.1


