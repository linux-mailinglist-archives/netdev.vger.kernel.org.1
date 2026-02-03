Return-Path: <netdev+bounces-256257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOEMJN/agWlBLQMAu9opvQ
	(envelope-from <netdev+bounces-256257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:24:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5BD842D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB660304BC3C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1E33F8D8;
	Tue,  3 Feb 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrVl0dLD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46D33F8D2;
	Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117721; cv=none; b=WICMKyPv7lfvzo4rJhl37O3yUVP79FL96VrNkpnHl66qMgQ3chu+gYxl+4lRjKQn48d4I+yKByZuqmA0/F4gxq+6yXC1TIGDFOF3luqR6VeFrWOz5L2NkO/ni3X3wqsFCGr678p75k7l5dW+DQOOCPhM1XM7+fvsoj5/xgNo5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117721; c=relaxed/simple;
	bh=I/ds7VPivI7MC56xPmzXpkEugesnbH4oVfiwGT7GqoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzyKMiv/VUmlTJ7Ffvb4T4z3tXrE78sPSrVzVrhMbY/cQjqLfi+Lo797eX/So/blAIblKzV7XgJXoSwntR2dcfSBWrWet/2jkSgvP0VR//NZCRvN4cLvoDT1TKeSCt+OmMSwKOFiEvCLrFDNwVsizqox/nRqr0ed4rw9Zh5aGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrVl0dLD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770117720; x=1801653720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/ds7VPivI7MC56xPmzXpkEugesnbH4oVfiwGT7GqoU=;
  b=BrVl0dLD4kqwsgvqpoZz3qYb4hv2yG+JNIPmh/I/7dZIsQ4B7zryN709
   2pJ6lsVPiBjTQ67GTmw7GKFE084c+0KyvG7eWeJbDhq7J10AWgYtIB6/E
   1sAFNxWjSMJh71zSjoJOHyX+3ENlwHXB6hnM04STndIES+F14py34DZSj
   6O2HvCgu28ozEDF/6dFgM4EQ1lhAl4IYB+rx5+KxnEuMr0m6QeqkhjFfU
   6B9Hmd100GtDFSU1FC9g9zi4R0mRZz3oPe7aYzOifsQKDhti0a8Fxcsk9
   Zh//dGFOwObFLvjorrN5kpknDGFtRd6ndsBItyIhvY5Qj1W3PAZJqxl2U
   w==;
X-CSE-ConnectionGUID: jRBuh3qSS+GMFfmJQEVgnA==
X-CSE-MsgGUID: vYKnBqrwT/6ELgR8r5ZdXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71185937"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71185937"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:22:00 -0800
X-CSE-ConnectionGUID: DM+ZiF5ZTyS1qURgMAkgVw==
X-CSE-MsgGUID: otFw1S5dQteqm3gH1/y13Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209913299"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 03 Feb 2026 03:21:51 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DC38E28196;
	Tue,  3 Feb 2026 11:21:47 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info frag_size
Date: Tue,  3 Feb 2026 11:53:34 +0100
Message-ID: <20260203105417.2302672-7-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256257-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33A5BD842D
X-Rspamd-Action: no action

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects truesize instead of DMA
write size. Different assumptions in enetc driver configuration lead to
negative tailroom.

Set frag_size to the same value as frame_sz.

Fixes: 2768b2e2f7d2 ("net: enetc: register XDP RX queues with frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 53b26cece16a..389331571d9e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3465,7 +3465,7 @@ static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
 	priv->rx_ring[i] = bdr;
 
 	err = __xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0,
-				 ENETC_RXB_DMA_SIZE_XDP);
+				 ENETC_RXB_TRUESIZE);
 	if (err)
 		goto free_vector;
 
-- 
2.52.0


