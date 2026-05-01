Return-Path: <netdev+bounces-283120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HxuKqFK9GlSAQIAu9opvQ
	(envelope-from <netdev+bounces-283120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FFB4AAAE5
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BA283006822
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305F373BF3;
	Fri,  1 May 2026 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKtgxbBg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4136EA80;
	Fri,  1 May 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617524; cv=none; b=Q9xe1PfN3vw4Q4WC6PlkgyMojpbCPBO7OYhFgrDeG5z14v7e2B7I/+I80ajwfTUGOzNg2W8wXYuVBC60PVZ3CZlmEWXbWeM92ZPaX0QGtMEAHW1l6/GIC9RuZx6fC85kGIQvhQsC4KZ+CIe3R2uGwLNofhyyr2tbgZA275AM6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617524; c=relaxed/simple;
	bh=QOCm2sopwgNpl+EKxsL6rGh0AzlEggXHpYnJl0//k3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4A5dsk7dDmS9L8pcJMeIYOSPeEzaE2Gs8/OqqJ7oj0tLMrVAUeDrRu1hzZ67CTdkRrW4UNRDo5L8jjCxUWQu60bpC62Hk/xRbTj2mg3hosodeBpqqzn5otOaWLB9DV+PWq8YhN1IFMqTeADjbSBm8gEopTlmCMr2FLUYFT/Nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKtgxbBg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617519; x=1809153519;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QOCm2sopwgNpl+EKxsL6rGh0AzlEggXHpYnJl0//k3I=;
  b=hKtgxbBgj+aqhw1cib1Iwc7RZD7K6XMijgLrvXIh1migjvhCafRZFjDG
   dxdwTMXEOUhTPaNHbEefPjzWRWjgUBuKo8k6SRWjpq9LZazpqcvKTbAR/
   bkeizyfd0KFUc7DcDhdE3JKBnjK2G79UzC4fVSrKzEuAHGZjJ2dYi1qHN
   40JFgLvjiiccQz7/r/D+qV603i+8OwDXAZvhuYn++R+oCcla95hju62K8
   C//58AkGpaJHCXNxll8iqZHQucZwjn2VbDgmH8YU/80wpZ30ZH316MXHU
   2F8ydyVU/man02nnEDAKnAlp2Ku++zfcZijRQJrC/2a8EHQEHSossq6VM
   A==;
X-CSE-ConnectionGUID: ecWPT3rhR4S45iLgn3fn3A==
X-CSE-MsgGUID: jBgX2CVXThiOqG+7MB8ZVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271910"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271910"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: pVfQznXiSr2BYVQoaq/6GQ==
X-CSE-MsgGUID: /gxstvVKQiWYcH9CuEmKOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752861"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:19 -0700
Subject: [PATCH net-next 08/15] ixgbe: E610: remove redundant assignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-8-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=W/40c8BFZkNJ6uVOUp9nRUCH9K3Lx1uOG5OO7H/Jis0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXil7GA7xrZ548MXCsBhBuaL4uXs8LU9wLvh69mK9/
 ZorsryxHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEyEfRIjw+4ODflzdumfSiJ/
 fQ89/3J+nlTLD/dELmXmoJKjO8WdfBn+V582b3qXvWH1/KwlcXo1yh3C1l7aNmt2WpSXsM6Qdf7
 NCQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 47FFB4AAAE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283120-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Remove unnecessary code. No functional impact.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index b686636beb93..831cfe9a4697 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -226,19 +226,15 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 
 	/* Read sync Admin Command response */
 	if ((hicr & IXGBE_PF_HICR_SV)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
-		}
 		ixgbe_aci_debug(hw, raw_desc, NULL, 0);
 	}
 
 	/* Read async Admin Command response */
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
-		}
 		ixgbe_aci_debug(hw, raw_desc, NULL, 0);
 	}
 

-- 
2.54.0.rc2.531.gaf818d63126a


