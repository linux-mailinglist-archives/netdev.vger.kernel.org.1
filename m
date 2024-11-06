Return-Path: <netdev+bounces-142298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B219BE263
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AE8287E5E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0A1DA10A;
	Wed,  6 Nov 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxIeFxGM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF81D90DF;
	Wed,  6 Nov 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885077; cv=none; b=skfryro6bhsDaaCl4c0pGF8sglPbsPXtiO9ReZJVLjO5/Q1TnDf1gxZnTd1tkvwGjhFd3pr31Wf9JbY9Hl+T2ttsIELhCyoZRRSwW5w2LuL83a8EZuM/9r0AamGUbO5ObrVSaJZPQpY/mz5Eo23lFTguTkDcYSbeW0lT/GUBUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885077; c=relaxed/simple;
	bh=ibB34upNPaMe3UDhelcOR3ajnDBu48bMZyShEq/38q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4rkT9FjM2+EL8tye5qnMa3tj+aFhMgi1QrlqcylaWdNnzBIRo+BvGL2k0qczgXifWdMv3UT8PW2Bo0Pay8HCbB9yWCQVwCz2QunhCrO/mSmX43RJWirdXEcS0RUVZpw3gDbAnBhU42nXnGCWBGgA1ck+BKbpkxJWOYOxeNT2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxIeFxGM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730885075; x=1762421075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ibB34upNPaMe3UDhelcOR3ajnDBu48bMZyShEq/38q0=;
  b=MxIeFxGMSNhwflfMS/MkOTaBSxx2Z1LihUa7zZkogURfNMBaE+QplLhC
   3uW2MaMYqBkGhu9Ie4NN4Oh+IUKuN0mqlBzK0ZrS1MmCRjqh0Nr/jEdTw
   mls0C94V4s240/zUctxFT6Bhcs/2Hpd+o6SxeZh0t0U0Wop5mjxFBqpd3
   wK2lOMeYLgRiSAZ/tjh17D71ymZKLoeHRm1dLWVVx6PI/fNGYXbymu4h3
   se7wxOKvrvW4n0vKOayc1d0rdJ3YLRHMPq6X++xnEt6+wT7tOxb2x+oLg
   +p/+WpFa4APiieGG7b5L3b8iVmCG33OFV82ubUuWoHQu5nqUkr5esnU4x
   g==;
X-CSE-ConnectionGUID: 9OY2emJYRNCyjzYbJrQgZQ==
X-CSE-MsgGUID: NLJ9oEvlSrONcUXJcnqOHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34368393"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34368393"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:24:34 -0800
X-CSE-ConnectionGUID: 1ViBVHDaTkm430X0JbgsGw==
X-CSE-MsgGUID: OAlCwL+QTiGN/1Sor3lA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="115221982"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2024 01:24:13 -0800
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C87DA2877D;
	Wed,  6 Nov 2024 09:24:10 +0000 (GMT)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH iwl-next v2 1/3] pldmfw: enable selected component update
Date: Wed,  6 Nov 2024 10:36:41 +0100
Message-Id: <20241106093643.106476-2-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106093643.106476-1-konrad.knitter@intel.com>
References: <20241106093643.106476-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables to update a selected component from PLDM image
containing multiple components.

Example usage:

struct pldmfw;
data.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
data.compontent_identifier = DRIVER_FW_MGMT_COMPONENT_ID;

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
---
 include/linux/pldmfw.h | 8 ++++++++
 lib/pldmfw/pldmfw.c    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..f5047983004f 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -125,9 +125,17 @@ struct pldmfw_ops;
  * a pointer to their own data, used to implement the device specific
  * operations.
  */
+
+enum pldmfw_update_mode {
+	PLDMFW_UPDATE_MODE_FULL,
+	PLDMFW_UPDATE_MODE_SINGLE_COMPONENT,
+};
+
 struct pldmfw {
 	const struct pldmfw_ops *ops;
 	struct device *dev;
+	u16 component_identifier;
+	enum pldmfw_update_mode mode;
 };
 
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6e1581b9a616..6264e2013f25 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -481,9 +481,17 @@ static int pldm_parse_components(struct pldmfw_priv *data)
 		component->component_data = data->fw->data + offset;
 		component->component_size = size;
 
+		if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+		    data->context->component_identifier != component->identifier)
+			continue;
+
 		list_add_tail(&component->entry, &data->components);
 	}
 
+	if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+	    list_empty(&data->components))
+		return -ENOENT;
+
 	header_crc_ptr = data->fw->data + data->offset;
 
 	err = pldm_move_fw_offset(data, sizeof(data->header_crc));
-- 
2.38.1


