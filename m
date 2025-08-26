Return-Path: <netdev+bounces-216893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17CB35C03
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2397868255A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604D345744;
	Tue, 26 Aug 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeZjYU/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5B343D83;
	Tue, 26 Aug 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207700; cv=none; b=jri1PsaTCLigplENKhSetT3AjsIT/Gzqrp/mqruNPkw5bFPwP2uvqrQ1dpj72Q5p0ETwkg8sz/X3rL0zGmoURcS8Rzddiy8Bj2KfHWWqYucmaLTV+0uWq3u59PuQatwZF+hR78RFaxlmoBacEa5V/Fsslwtb7EesyQM82vydHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207700; c=relaxed/simple;
	bh=Oa24s+s7jJoXe876BKzHjTk58p18VzSxBVg370DbOjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbLwu91J3Dby3X0hnookz04ylBBbmk4rfUly6yGTggXZ+AIsmq3YJRv/6T18r1uIomYjIXnhD1lBcyi5E7Bqq2u1W/dTHY0F34KO8qhZ+FG3SZcd3NqvE4OBjqYn5MJwWdIq9aRXY8IQ3nyjyn/9fdwoMhK1A1HQn7AT5zzv804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeZjYU/t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207699; x=1787743699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oa24s+s7jJoXe876BKzHjTk58p18VzSxBVg370DbOjg=;
  b=JeZjYU/t6Vc92/mUbJnNmImM22mnGOqbHZz/YB3g/yFidoarX+R7ZeeH
   QoVfAgLAN9AWkh0rPcH2vmPQ57seZQpLnm7pJAmJ8NXW4YSKt3Ztha3Xh
   s0zybxS+olVyApP2UWi2kXmIUMImv1rK1bbrgIexftH6/lxCbrHCtNCva
   g3w9UfLQOTRoXaoQjBCuVJmnjW8KZsI6jXvviMQpbpwoufmIp9tRvmYA+
   0Ldy9mezORJzdiAs7jzpkKPMq45crZkRAU0rUYcN2abtCLQDXHJUsVE3D
   eoPSrsPwiLlEMdVALLG/ITtPr7//ARLwlanBaJ1WtPousAXQKepAvI372
   Q==;
X-CSE-ConnectionGUID: Wk4veZptRnWmTfETqEMqyg==
X-CSE-MsgGUID: VTwVodxySMSabz9gXauefg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269276"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269276"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:19 -0700
X-CSE-ConnectionGUID: i5j4TA7RSQKkJniRvF4k+g==
X-CSE-MsgGUID: c7B/zIjUSWqgavPk9qkFYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725806"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:16 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 3/7] net: stmmac: check if interface is running before TC block setup
Date: Tue, 26 Aug 2025 13:32:43 +0200
Message-Id: <20250826113247.3481273-4-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Jurczenia <karol.jurczenia@intel.com>

If the interface is down before setting a TC block, the queues are already
disabled and setup cannot proceed.

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bda1a83607c0..9cf7f85c10b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6245,6 +6245,9 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 	struct stmmac_priv *priv = cb_priv;
 	int ret = -EOPNOTSUPP;
 
+	if (!netif_running(priv->dev))
+		return -EINVAL;
+
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
 		return ret;
 
-- 
2.34.1


