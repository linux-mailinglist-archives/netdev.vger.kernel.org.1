Return-Path: <netdev+bounces-270695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIEqIg2ZwWlNUAQAu9opvQ
	(envelope-from <netdev+bounces-270695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:48:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345D2FC9B5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B30324658E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ADE3BC689;
	Mon, 23 Mar 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq2AYQyF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89796388E4F;
	Mon, 23 Mar 2026 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293929; cv=none; b=tF0peKMAp/ncI4tlR6VRiy91tCD3Kbdp9ar4QNUjixMUIu8J0q9niNvEIoiL70JU9EDNQPxPeUYIuuHG9XMh1+kEbFf6fZiPggGEmpOsjFyGVb47m7VVb5ZyGxnUmfrK7bvJymNUsB3VIZZeumqwcX2LgtDk6dzQbQXSk6WUKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293929; c=relaxed/simple;
	bh=FaWQTqp6l2AkN18SDD7RryzwFhKgM6MciHDFXpG1hd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vc5+oNjFAwUPM9qfKHZ/6I/Lu7JdWNiZXHS77gQ6dZUBf7OC2gE+VWxAvS/Tj96OVozdEUAdjsbAdzv0Zv7E3GbnDg0og6j5VbqWWMD6rAbq3V74BYEgonQJLkocNAd89is0pcjawQRp9n3wDGQUMD8jZeOCgTzqO0D5K/7aNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq2AYQyF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293928; x=1805829928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaWQTqp6l2AkN18SDD7RryzwFhKgM6MciHDFXpG1hd8=;
  b=Vq2AYQyFijl7x/CteXn079/eW5A9UiulIyMOtyWHfpiSngSWwiE3UC9Y
   RIzUkzupt0du2dU1PyNzVYmpxVCKUMZ8Ajk2TNeGD12YP/s8UgRIbQGmf
   fV8Mh0X9Sf56Kc48z+EqcI9GM7Ql7rcrpOyk1m6JJDWz9/8a2/blFyT/F
   28OiHEjBvWHfa5rhy/D9beS1v+BNDe060+aI+7+Azl1E8v26iqih8yMmE
   NNOxVPxlDXO0sSBTLmpJE9lxyMUwjh+88nO2tHm0g0lrqiUoPUHAQCwHx
   I/LB/sF8oQ7gEbe/eGAama2dWS2JeqVEboAXxA/Zbr9E1pxpkEhT5QJKb
   w==;
X-CSE-ConnectionGUID: d1Aw6KL+Tu2HW0G4t05yOQ==
X-CSE-MsgGUID: 0HgDCAi3RfmP230/kXqDXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013346"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013346"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:28 -0700
X-CSE-ConnectionGUID: cPGzuQMBSwKooDyE99XWWQ==
X-CSE-MsgGUID: AA81w8gOQAWJI8vEnp6sNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187916"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:25 -0700
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
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 6/8] selftests: bpf: have a separate variable for drop test
Date: Mon, 23 Mar 2026 20:24:55 +0100
Message-Id: <20260323192457.504631-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270695-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 1345D2FC9B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently two different XDP programs share a static variable for
different purposes (picking where to redirect on shared umem test &
whether to drop a packet). This can be a problem when running full test
suite - idx can be written by shared umem test and this value can cause
a false behavior within XDP drop half test.

Introduce a dedicated variable for drop half test so that these two
don't step on each other toes. There is no real need for using
__sync_fetch_and_add here as XSK tests are executed on single CPU.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 683306db8594..023d8befd4ca 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -26,8 +26,10 @@ SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 
 SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
+	static unsigned int drop_idx;
+
 	/* Drop every other packet */
-	if (idx++ % 2)
+	if (drop_idx++ % 2)
 		return XDP_DROP;
 
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
-- 
2.43.0


