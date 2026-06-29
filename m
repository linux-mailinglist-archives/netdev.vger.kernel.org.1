Return-Path: <netdev+bounces-302812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FUqWBc/DQmoNBAoAu9opvQ
	(envelope-from <netdev+bounces-302812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:13:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857C6DE3AC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:13:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Mufrl/pu";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302812-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B89B30125C3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862139768D;
	Mon, 29 Jun 2026 19:13:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F9388860;
	Mon, 29 Jun 2026 19:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760396; cv=none; b=m8bBmXkMty4GSSIPQCJbrhooB9ArtbD1HIIHh00UDOsArcF0z6bvwbMwil+tAxpJSIHN4auFR9fftR1nUSXJgvIHEXAllOwKeW/k2BaS3BoGyPlMn+p6dMWZeGZI8RHlMgTzyDgO8EIKuefjJK34A3bVHMKBXRg1t1Hrxg80zeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760396; c=relaxed/simple;
	bh=c0y7Ew+PvG0Oeg+XBYMEeRsYFREdBeoCETk97Xte2V8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVarhlLO/zKI9K8cijUfomJGcJq56/3LtKGSI0sELD3CFnNxzeAU1urvYpJVkPbKGY4rCv52hceDAxZod/zD8xixfWk9S6EZUy/VXwL6rGJ5dUxGzs0mWY49NzXITz7nVMgXQikmoRPoz8uRItlpu6E9g4KHkakCFYcf8ZgI69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mufrl/pu; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782760394; x=1814296394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c0y7Ew+PvG0Oeg+XBYMEeRsYFREdBeoCETk97Xte2V8=;
  b=Mufrl/puEgRp4f3IT1rCInTe1hq5sI87GKwyCyHKRL5+HiJo/nxxSERE
   f0RcNmAeP84qjeW0cdinnx6Z3J7VJIvOoloXsof12lDpo87Nmf76yKE2U
   dHDLkKJhRwxmPFdwY7310NMegGj5i5S3ezSBljc9G48UQdlUzkcBxVfCQ
   pjFmiD+49jyMb8jyWfZYfGycK1zfeN+ssPDpSxM2nzo09wOMajQKVCohA
   hAB5JgtQoagNgfZkxe8Es9le/LeZuG1lFFA7aeXS4u+iRewW+rVS7Tw3+
   OI6Kcn3+NaII00mxtDdnAMKJrKtGJ4/4VnsYDzD8BmitqmfpQ61pPFHl9
   A==;
X-CSE-ConnectionGUID: Jllih6iASHy4CUVg1cxsGQ==
X-CSE-MsgGUID: P/myDc7fQ9a0AGULhWtuig==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94119869"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94119869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 12:12:53 -0700
X-CSE-ConnectionGUID: Kns7fM1fT+ew7qjupBSp+w==
X-CSE-MsgGUID: ukhby1NTRN2OWgB6mpYoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250986913"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 29 Jun 2026 12:12:48 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net-next] selftests/xsk: Preserve UMEM view in BIDIRECTIONAL test
Date: Mon, 29 Jun 2026 21:12:21 +0200
Message-Id: <20260629191221.2700-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302812-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6857C6DE3AC

The UMEM state refactor made __send_pkts() use xsk->umem for Tx
address generation. At the same time, the shared-UMEM Tx setup copies the
Rx UMEM state into a Tx-local state object and resets base_addr and
next_buffer before configuring the Tx socket.

Passing that Tx-local object to xsk_configure() makes xsk->umem point to
the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test once
the roles are switched: the same socket is then used for Rx validation, but
received descriptors from the other logical UMEM half are checked against
base_addr == 0. With the new UMEM bounds check, a valid address such as
base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
window.

Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
and Rx validation. Use the ifobject-local UMEM copy only for Tx descriptor
address generation, preserving the BIDIRECTIONAL test's intent of using
the proper logical UMEM half after the direction switch.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Tested-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v3:
- target net-next
- remove fixes tag
- rebase
- add Jason's tag
v2:
- fix SoB line
- rebase
- add tags from Tushar
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 6eb9096d084c..477aedbb01ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1164,8 +1164,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 		       bool test_timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
+	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem_real;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
-	struct xsk_umem_info *umem = xsk->umem;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
 	int ret;
@@ -1514,7 +1514,7 @@ static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobjec
 	umem_tx->base_addr = 0;
 	umem_tx->next_buffer = 0;
 
-	ret = xsk_configure(test, ifobject, umem_tx, true);
+	ret = xsk_configure(test, ifobject, umem_rx, true);
 	if (ret)
 		return ret;
 	ifobject->xsk = &ifobject->xsk_arr[0];
-- 
2.43.0


