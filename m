Return-Path: <netdev+bounces-283889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKeJFjmy+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31424C012C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08D773050E8C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E83DFC77;
	Mon,  4 May 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZkLxFBD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD933DBD65;
	Mon,  4 May 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905845; cv=none; b=i4JULHFJjngSxY4Y7h3gYf2M2HMsQuXuJ7OD6QQyHvusqt9OiL0MiI9ZhGl5xiqLtuBRG1lr76xjjb001Ka7ql1VSo7LuS7qk1mC8EdyBhS7LiolarlMbOh8xbcbpno4KHt/mdbQevBlh/NgbMWbl60gCl0KxCaQOIE7L6xWxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905845; c=relaxed/simple;
	bh=YvBSeEFqbbJHPGpcBG9RqC3NXahLfq7pQptie9Q7N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkHRzM4RaS4g2qkKgg97EgzrkQiL+c9b7qxbXYEcJrQcwMJFXRKHrPMf7UItXFC+COXlJAbXVBpMOf5uelw3aFgoau+eGxEpBM10gGEmisv4iUemDtdpeWlbXpMvzYgebSEoRRWV8xYITu67nxCNng3flo7XgpjTGns39IDIN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZkLxFBD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777905843; x=1809441843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YvBSeEFqbbJHPGpcBG9RqC3NXahLfq7pQptie9Q7N2Q=;
  b=HZkLxFBDk3wpE9CEkRc/O/Z5lY6kMyqk+JlueniUOABcUYNLKNBDryyQ
   I6L/CU4A3TyO1N80+mMg1pSqfqXc4B7SOIrlVE9xT0U2syMP6agcRJSrO
   m6O4E0cU4UA3RiYK+vl89k+MXiUcFgIeMZoP1OyJzFKKED+W/Mfll/Eup
   6P7DZPzu+6RcmoL0+lCH8O6rUmrKsbMTraSzcsWXCajZRIq6mg7kGRlis
   u2LcUYVa+rMqEbKZA6RtoYM6P7QUA8pAuGLeBbC4UgXNHgTn4cOgJMNXK
   GRiOqMwRYJWcbboI+l2CZ9AJf1PKES9a0kk9TVXP3h70VoefQLihyLqBS
   A==;
X-CSE-ConnectionGUID: Fc70YtvASrCW7RTHQimKjQ==
X-CSE-MsgGUID: qdQHEE2YTHGfgVZtRxAVow==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="104211931"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="104211931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:44:02 -0700
X-CSE-ConnectionGUID: oj3o4ySlTKuiwaDDHYKuVQ==
X-CSE-MsgGUID: dV99omDhT2OF7cZLzXNe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239830499"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 04 May 2026 07:44:00 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C17812FC54;
	Mon,  4 May 2026 15:43:57 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2] idpf: fix RSS LUT memcpy size
Date: Mon,  4 May 2026 16:43:43 +0200
Message-ID: <20260504144345.293219-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A31424C012C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283889-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Based on the following feedback from Sashiko (received for iXD phase 1
patchset, but valid for the net tree):

 "Is the bounds check xn_params.recv_mem.iov_len < lut_buf_size sufficient?
  Since lut_buf_size only represents the size of the array elements, should
  this check instead verify that the payload is at least
  sizeof(struct virtchnl2_rss_lut) + lut_buf_size?

  [...]

  Does memcpy copy the correct amount of data here? rss_lut_size stores the
  number of 32-bit entries, not the size in bytes. Should it use
  lut_buf_size or rss_data->rss_lut_size * sizeof(u32) instead?"

After inspecting the code, it was concluded that RSS memcpy size is in fact
4 times smaller than it has to be, since a single array entry in a u32, and
rss_data->rss_lut_size is clearly used as an array size. Required Rx buffer
size is also too small, but this is a common issue in the idpf code.

Use a full buffer size (lut_buf_size) instead of the array length
(rss_data->rss_lut_size) when doing memcpy of RSS lookup table.
While at it, increase required Rx buffer size to a whole flex-array
containing structure instead of just the array.

Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8
Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
v1 -> v2: replace manual array size calculation with flex_array_size()

v1: https://lore.kernel.org/netdev/20260429074232.180528-1-larysa.zaremba@intel.com/

 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101..0fc7c68447f8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2915,8 +2915,9 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 	if (reply_sz < sizeof(struct virtchnl2_rss_lut))
 		return -EIO;
 
-	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
-	if (reply_sz < lut_buf_size)
+	lut_buf_size = flex_array_size(recv_rl, lut,
+				       le16_to_cpu(recv_rl->lut_entries));
+	if (reply_sz < lut_buf_size + sizeof(struct virtchnl2_rss_lut))
 		return -EIO;
 
 	/* size didn't change, we can reuse existing lut buf */
@@ -2933,7 +2934,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 	}
 
 do_memcpy:
-	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
+	memcpy(rss_data->rss_lut, recv_rl->lut, lut_buf_size);
 
 	return 0;
 }
-- 
2.47.0


