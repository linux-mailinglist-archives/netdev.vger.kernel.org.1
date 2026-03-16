Return-Path: <netdev+bounces-268236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHVJBF1DuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E929E912
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C2873099680
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D8D33A9F8;
	Mon, 16 Mar 2026 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoqNhiVd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C552332ED3;
	Mon, 16 Mar 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683208; cv=none; b=hjEpjVlwEhZqcz6jw3xNDd7pWY/Z2KRCCnppkjax4RrmljmCPqfjsidJopN7m5cc/ergVyAu08KHTwcd29AqCJ0XIIxZf3iQqJ+lxLrhhAlIJzYeDlEuoAPm3jKL1BrBS8FU2sWaPnqDThFZr6HUgmz3p1YDpZDwB5u9TU59Jc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683208; c=relaxed/simple;
	bh=oUdqkprAKNLqdy+Z9DsSiRaGN2K4IDbzQNUWqrM2lm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akt0qKHGAXNRs2jZ93Wf8V9MnWqeXbKX7ZDGy8yqTKzqd1OQEMJd+pJFxrntBRkibhtqFLgJqcSDN7jqLGZ0d7RkeXp7GAd3RjBk1BJMsQgZkSankkExtuIGsMxYN5hzdhB4CjhiJvfma8DJFYNPlXtssHke/XW6SwKj3+/Ghiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoqNhiVd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683208; x=1805219208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUdqkprAKNLqdy+Z9DsSiRaGN2K4IDbzQNUWqrM2lm4=;
  b=WoqNhiVdC8/jsazxTgK3nb+8397y/2rvdJ+gJJ71TJlqp16Hnm2i3ToC
   Xjw8HnkJixIzIMPO1eUvXpxFXjfHsEAVGRqtztoPHriCUBro5dE9hqy9p
   zJvCJ8G80oVqbZz2pIqNfsVysoF1UGW6b5pVUwIZUlbTc9TdrjKFgPGVo
   QdxSqFG+a+/a0gVOpkyCPbILiCCzdNyCG8dvjrB/YUhPpgNaLGQkgUGAk
   H/MNYXj8tJpqJNTYrOsT7LU+ZsZckIALOkJNio2fRjSHpQutjP2nNQ2Y3
   tQeEx67it0Py6pxMqtAsFEF0x4ZuY7rckdEPNIH3LMXK+nztd8WiGXsqs
   A==;
X-CSE-ConnectionGUID: NW2cB2yBQYW3cr8iykJI0g==
X-CSE-MsgGUID: TG03JD1CT2uhsH9SjYq+Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275742"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275742"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:47 -0700
X-CSE-ConnectionGUID: TLKOM8CPSlmSJSaVJypwyA==
X-CSE-MsgGUID: a72xo32NTpy8WRvQmEsDXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075763"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:45 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 6/6] selftests: bpf: have a separate variable for drop test
Date: Mon, 16 Mar 2026 18:45:50 +0100
Message-Id: <20260316174550.462177-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268236-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 7D1E929E912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently two different XDP programs share a static variable for
different purposes (picking where to redirect on shared umem test &
whether to drop a packet). This can be a problem when running full test
suite - idx can be written by shared umem test and this value can cause
a false behavior within XDP drop half test.

Introduce a dedicated variable for drop half test so that these two
don't step on each other toes.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 683306db8594..40609d8c2471 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -15,6 +15,7 @@ struct {
 	__uint(value_size, sizeof(int));
 } xsk SEC(".maps");
 
+static unsigned int drop_idx;
 static unsigned int idx;
 int adjust_value = 0;
 int count = 0;
@@ -27,7 +28,7 @@ SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
 	/* Drop every other packet */
-	if (idx++ % 2)
+	if (drop_idx++ % 2)
 		return XDP_DROP;
 
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
-- 
2.43.0


