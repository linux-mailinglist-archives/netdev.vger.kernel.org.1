Return-Path: <netdev+bounces-138238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F59ACAD5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D63C1C20E38
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82581B4F2D;
	Wed, 23 Oct 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYZNZtIq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B311B4F15;
	Wed, 23 Oct 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689210; cv=none; b=LLmb0ITVC2SK708omfNo5oMSEFdMehvZHoTcjAw8WZQYzQWRecP5klmEx8RQXZqTC5dGDuyYkF4914gUexEyd3JTGy6bm7ZYTUso/O80IzU2VIbMe02zUG2CEqYnNIlriWvVRmztvMMWPOdEQkeEl/TUaaxGTXCM+K1yauQA+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689210; c=relaxed/simple;
	bh=7EmwuiM3f/QMecNc5zEFCtkKNTUIFtSE0tIsB2pTxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtsopKEqsMisOpzSC6ui/X6/OIcW9/LoD3dHKaDbQUmps4d8h+OVDzYbIwPGMvTzFPaifw2eR9iFZMiAseRq7D3Paett7YEN1AzvJiWPkxGf5bS91NM8gzZdpCv4WBrqGv1s4Eq+4UIiLY6fCz23oAzwlgTztWCnBc3PuczccoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYZNZtIq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689209; x=1761225209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7EmwuiM3f/QMecNc5zEFCtkKNTUIFtSE0tIsB2pTxRs=;
  b=OYZNZtIqpri7ZC7+ziy287rMjYaH838Exss/JKV611debX/ppLbjKlIn
   6ZIGnxFa5H77T2KUHS7g6kTZbcYVE9oxTv4xbI33WQRnxFFMnmJBpajBe
   RPYO7jvV73RfsI/3ziyQ4QqvxkbvdeRmn0k3llSEAm7XHsKqAPIWghdmt
   jxTXQxoBbK6fApuE5NOTxwgdrlOh+bzE126ORwCPCOoTUL40/pOR5miU2
   T4HIBw8/5a+IoywLehWgoC6kn+55jg7/X/LpTIFwch1dKWnHqE52o0fVe
   Fo20H2Xb3xyABh994KFs3OS0Wh7xvYgZNvoohDJ8r2D03/JdqKnILhqH9
   g==;
X-CSE-ConnectionGUID: gETGohGAQcaBrLgXjJsj7g==
X-CSE-MsgGUID: 9Cim0ptjRv6dq8OaMe2OdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758548"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:26 -0700
X-CSE-ConnectionGUID: +XL2ZYzpSJe8sV3NvOlogA==
X-CSE-MsgGUID: FtFcw6sVSA6JbzXd52HDxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820106"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:23 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 765D92877D;
	Wed, 23 Oct 2024 14:13:20 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 1/7] devlink: introduce devlink_nl_put_u64()
Date: Wed, 23 Oct 2024 15:09:01 +0200
Message-ID: <20241023131248.27192-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
References: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
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


