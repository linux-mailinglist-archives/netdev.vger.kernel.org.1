Return-Path: <netdev+bounces-268173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LVZFvAPuGmIYgEAu9opvQ
	(envelope-from <netdev+bounces-268173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:13:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647129B1FD
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2502E307BEE3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3539A047;
	Mon, 16 Mar 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSC339Y7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E43932E4;
	Mon, 16 Mar 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669967; cv=none; b=AqQEyKxdyTHQck4fDsfEu6kx2SZQ1DI49bk2B8bvL6/oBPGenJYWYlHvB9D1WhB0Th3+k9W193m6xLJAzgHalFVF/yJCRp/0bIhBtdNldklpnuD9JM8g3IJXUipQt2I7vRWe/PHwqZbkVLzQRHocyv7IoqjDCuPJZR8R5b6IeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669967; c=relaxed/simple;
	bh=tP7Fube0d7HkUTB6sd7wafZGMdXfrYYWaOxavgk+TLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWAksjBDNbaRL0Jr5TVyisA2YpxK8fjyNkYehmATt5As2S3KuYAyiw03bEUpH/RZXmppJ/1F5axJpHLXTdjGf6xVnVFpSiT9USyknikbXS0loc83vmqg8fQc18aHvXQ1p8oE5vbWNfw1PHeu4Fn6spZ2/ZXJjyKsT8z3vTNdhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSC339Y7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773669965; x=1805205965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tP7Fube0d7HkUTB6sd7wafZGMdXfrYYWaOxavgk+TLQ=;
  b=fSC339Y71oYwpLay2ygr4m1ijCdEwJfxQZpB7B8U92eoGcWEtZn9AKqs
   cG/rf06VAnWvXkjyGbFdrJocng8m2dpHL8H7lOVJ80avdTHFbDXyrNEjs
   U3UsSRUj9tggBG7mQRKWcCQv9VfkEp+M5usEZLY7gci+k7mUcONVnDlgU
   SS5ZEX0ZOtxXdtLFRV+TI0vTc5PBOZqZYBASWdYx5a7X4Y2Ip3g+3WiXm
   OiV6CrH5uUuNsERjdGwvMXQJ5kynHz4uuqZlM1frzCJ7uvVMYFpLahZ+L
   8tZ3lXurJLd9226LMJKbulDi/K//79xPSafiHAwqULrRVzjMqXvToC+Wj
   A==;
X-CSE-ConnectionGUID: R/I30fj/Qj25cejPJUk/Cg==
X-CSE-MsgGUID: p/kYaDkmSJShrKB+kmS9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74602792"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74602792"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:06:05 -0700
X-CSE-ConnectionGUID: Jo1VdOIGQE+h5G3HgDPY4Q==
X-CSE-MsgGUID: OSoRvGYcRFmK6kgE+TBa8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252448320"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 16 Mar 2026 07:06:01 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer Rx processing
Date: Mon, 16 Mar 2026 15:05:57 +0100
Message-Id: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268173-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,iogearbox.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5647129B1FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f620af11c27b ("xsk: avoid double checking against rx queue being
full") addressed a case in copy mode, when working with multi-buffer
xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
there is a space to produce descriptors.

Adjust ZC path to follow the same principle.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2: route patch via bpf-next, not net-next
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ef265e45810c..cdf93728fcba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -196,13 +196,13 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		goto err;
 	}
 
-	__xsk_rcv_zc(xs, xskb, len, contd);
+	__xsk_rcv_zc_safe(xs, xskb, len, contd);
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		__xsk_rcv_zc(xs, pos, len, contd);
+		__xsk_rcv_zc_safe(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
-- 
2.43.0


