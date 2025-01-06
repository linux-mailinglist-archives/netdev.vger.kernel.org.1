Return-Path: <netdev+bounces-155618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F38A0329C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6DA7A055C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0A1E00A7;
	Mon,  6 Jan 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISAcpEE3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5621E3769
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201987; cv=none; b=YY6BUcOqyNm3Wb/Y94ifMd210mwb8ks7ZaK73JdYdQzeieKAyxuwvW56rvX91bWUFeJDxOEutFrj5QPPeYPqNgGcaB7rnjHvi6KM1V6lpElE4obKyJasahFlpH708ASCeQVW7G+T2PEiOO32vlKdOLeNnPP97uwYxuAPiUez9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201987; c=relaxed/simple;
	bh=KdL5Jsp8Kxxz5t5oQ2ugO5KqzEEdZq3Q9NaNAO+sWjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJiOtwXluH5TsYrEPtzJ4p/JCSDte2qvPf6lwzX7P7AOI9liZXnUEN4rki1SSizupt/fWSpKoGmlxH21KIO+FQ4Dc5jPTz/653qm1ZRuenUM6B4sgP8AJjhiGiCJvo+skBACMZbH20sEAo97sa1W07whvwMgskOpb4KvIV/1FwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISAcpEE3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201986; x=1767737986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdL5Jsp8Kxxz5t5oQ2ugO5KqzEEdZq3Q9NaNAO+sWjs=;
  b=ISAcpEE3otdp5rgG7P5sOYqbL2DV80toESZb91RcGFnRyHpXuCLBrl93
   XbISKoXGNo6Gq3w6P5W6GIpCdKMjv7Toepm8Whf1QnnuBRhH85bKEtVFm
   /9vy67fwsyLz6M+AYh7KKHkSy5ZZe7ghkLscLRWbSKMm58DayTaM9cFJu
   NoR4X7AoyM9OlYWYm/oypMNCkrwNq0o8p/HpUbAPNYxl/jp7oI/gM1/w4
   hIkpoMhcWFXqyjBOyffSGmNIKrcklOOUNEqCGPiknEk4naaOcHN+IP4gb
   g5175NernGNWb1aYMGF1rYhB435d5KzetfUMIZGlSq/3gA3bX929aqvl4
   w==;
X-CSE-ConnectionGUID: MctZ88XuTLCVZyUo8PmzqQ==
X-CSE-MsgGUID: QZYA+g8ERi+wv1vlFJlj2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858770"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:42 -0800
X-CSE-ConnectionGUID: zPOk4VkwQiiMP04oEWrLbg==
X-CSE-MsgGUID: FJFsL46LSJihYKwH9m2iXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368491"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	vinicius.gomes@intel.com,
	przemyslaw.kitszel@intel.com,
	kurt@linutronix.de,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 13/15] igc: Link IRQs to NAPI instances
Date: Mon,  6 Jan 2025 14:19:21 -0800
Message-ID: <20250106221929.956999-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 128 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 128
 129
 130
 131
 132

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 128 is absent as it is the "other" IRQ):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'

[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8196,
  'ifindex': 2,
  'irq': 132},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8195,
  'ifindex': 2,
  'irq': 131},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8194,
  'ifindex': 2,
  'irq': 130},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8193,
  'ifindex': 2,
  'irq': 129}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d6626761ed41..11f83e43e633 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5570,6 +5570,9 @@ static int igc_request_msix(struct igc_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igc_configure_msix(adapter);
-- 
2.47.1


