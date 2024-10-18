Return-Path: <netdev+bounces-136942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5729A3B56
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E84285152
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EF201269;
	Fri, 18 Oct 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnSmKr6a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA21FF7C2
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246836; cv=none; b=c4QSbCLPz1eSfd1AaZo2mpYAyaSlj1dLMQHxVyHF9+FnGtMRpsUqORFw4eHS0z8NRwk54bnCwC3+Xsk3wqwT21IMejAEZKcBGldHs093Iun8W9JBBeMDPHmZFMuiUczf9B5XiS7jp3sPiM5FNveFTeJdxjcjK7MUPXutDCfSj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246836; c=relaxed/simple;
	bh=nbnliCsTZoCLLscuzndBbxa4315Oxu+nhDo0BWJN4jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDfRulVx+pNzxswR3k+JuyYK7GdvIGlOPmEC0sSCR1ft08aDbWqWNwrOrukdlixmmzWtJzDqf2aiKl33uChRnzO2W1c/IbuL6UH93NVHb2SG9o+n5w1yu+YfT3rbK+XxRkoTOjiM+3jtQFqqxX6tNoswEbRqlhr9P1fu7xmBvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnSmKr6a; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246835; x=1760782835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbnliCsTZoCLLscuzndBbxa4315Oxu+nhDo0BWJN4jw=;
  b=RnSmKr6aaU5V2IzhwVycsqUCmC3CoR++PP5SAEo1paF+kjtaGYK23ozW
   G6t9BnxNovhVCrwnSTWP7FJVewrBOjdE19LEk88dOHWGuviWIaOW8XfJU
   n9Ku3RRHiy+zIWPFZPUzqR1Efzj3Xg7tBF+c7eGtyIDVwKH7ZQyqerD4o
   bgj09rIFQdh81618AgD+q7kiO1l3VX9cmwdK1hRba2+Iju//Fn5iQrNh7
   cRAO1d8zr1zB/40ijBSnqV36v90w8KECszo6kR4tOp5ZaWHObJ8W9VoN1
   qU+po1NDgFwoIgY+Nd7LDtmJMLAbD+COMkXIqP+gM8X3oDMgLn9Xs296k
   Q==;
X-CSE-ConnectionGUID: +cxWUju4SDKS0z1Vh6VhYw==
X-CSE-MsgGUID: Y0Jrx7DnRLSLRALH5MymMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401219"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401219"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:34 -0700
X-CSE-ConnectionGUID: c/waX+aiSqW4h9PwldiKrA==
X-CSE-MsgGUID: Z5bNS1BNRBCsD3Rj+PPtcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789303"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:32 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A7D0C27BD1;
	Fri, 18 Oct 2024 11:20:30 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 1/7] devlink: introduce devlink_nl_put_u64()
Date: Fri, 18 Oct 2024 12:18:30 +0200
Message-ID: <20241018102009.10124-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devlink_nl_put_u64() that abstracts padding for u64 values.
All u64 values are passed with the very same padding option.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/devl_internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index a9f064ab9ed9..14eaad9cfe35 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -181,6 +181,11 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 	return 0;
 }
 
+static inline int devlink_nl_put_u64(struct sk_buff *msg, int attrtype, u64 val)
+{
+	return nla_put_u64_64bit(msg, attrtype, val, DEVLINK_ATTR_PAD);
+}
+
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype);
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
-- 
2.46.0


