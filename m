Return-Path: <netdev+bounces-261084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLvmCPBmn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:17:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A535819DC18
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ADEB30A8E5B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BFE314A77;
	Wed, 25 Feb 2026 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbKnwxx3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D439311C33
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054159; cv=none; b=QY+yqq1k0UuLn2mz6E0Z14JVUrZ3JTIj6DNzKVY8Rims6gCQWcMhqfXOzdQ2BWpH1XGAAdg5ff0O0CpoArhBlAcn2xs9lh6xEnT/BP31Jg9NlHs0/OGuU05HbwsR93G17brd0F0HnA8OcnmLH4au3zdX79cFQ1QOBA5xo69JeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054159; c=relaxed/simple;
	bh=pB8B+KtdnPJUz+lsnXATs/26XzETnrdZQD9rBj5oCGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAJArz1OawdXvOgIEA+tjYu0yeMF7ICmfwmfd2IPkuBcQCDrSRObWj5OuMlqvjGQHIaGbVjpka1/Ada+oLcU+u7PSW2iaqg6hW+7Qj2z0eESfDnvX3KmXKQVwlprRdt62scCVnWrdVBT2Qk/TKVsYgM6bDE3ZmFG30UomiPCwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbKnwxx3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054158; x=1803590158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pB8B+KtdnPJUz+lsnXATs/26XzETnrdZQD9rBj5oCGU=;
  b=UbKnwxx3D3+e6FwkUcE2CkbLYBGNKJ/lF5+awfaBaGjh8j9ya6TYHx40
   6Zm09t4EZzIfWVaSu59T2jo6kqegKb4nhX1ojr8br7yWIik3py3u0bQ8p
   C5b10qmsEeKRCE+AMvDd2QJb2o+yPE3ah1xpdU8dd1q1Qobikx2NSEeJf
   zMz7jXdfamw67WxrYOUguL4fqJDRRL+fx0jyZDxyYYevK7hvNeBJG3G1n
   VlI+zTX+OBafE3m/i5HS/VpvI5eG4RLXpJVimu9vMeyC2UzXweEz0OGzv
   8tbpRjNI30dHd3eEKR2YiI8fl1IOykNJ8DF7eyyzhcx14aDxqaRT3ygwY
   w==;
X-CSE-ConnectionGUID: YT1cIhcSRdm/xCPt8o5B5w==
X-CSE-MsgGUID: KLE5a5/JQE2/m5E84Z7vlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013793"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:56 -0800
X-CSE-ConnectionGUID: 4N7YMlcfSNucEAXJhHpOAg==
X-CSE-MsgGUID: v+uPw+PAS1ebb7dx1Ckswg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349696"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
	anthony.l.nguyen@intel.com,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net v2 06/12] idpf: Fix flow rule delete failure due to invalid validation
Date: Wed, 25 Feb 2026 13:15:37 -0800
Message-ID: <20260225211546.1949260-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261084-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A535819DC18
X-Rspamd-Action: no action

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

When deleting a flow rule using "ethtool -N <dev> delete <location>",
idpf_sideband_action_ena() incorrectly validates fsp->ring_cookie even
though ethtool doesn't populate this field for delete operations. The
uninitialized ring_cookie may randomly match RX_CLS_FLOW_DISC or
RX_CLS_FLOW_WAKE, causing validation to fail and preventing legitimate
rule deletions. Remove the unnecessary sideband action enable check and
ring_cookie validation during delete operations since action validation
is not required when removing existing rules.

Fixes: ada3e24b84a0 ("idpf: add flow steering support")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 1d78a621d65b..3275b0215655 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -307,9 +307,6 @@ static int idpf_del_flow_steer(struct net_device *netdev,
 	vport_config = vport->adapter->vport_config[np->vport_idx];
 	user_config = &vport_config->user_config;
 
-	if (!idpf_sideband_action_ena(vport, fsp))
-		return -EOPNOTSUPP;
-
 	rule = kzalloc(struct_size(rule, rule_info, 1), GFP_KERNEL);
 	if (!rule)
 		return -ENOMEM;
-- 
2.47.1


