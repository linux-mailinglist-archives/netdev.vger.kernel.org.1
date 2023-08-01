Return-Path: <netdev+bounces-23152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB7976B2F4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21DE1C208E9
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9046820F8E;
	Tue,  1 Aug 2023 11:19:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866631ED3C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:19:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD5101
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690888791; x=1722424791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p38RNBiodPsGTUvHHthqRsdKcc6ICIQY2cU2NRQTHwM=;
  b=BQCXsbhOxhOLc9VOHx7twMDeifDETjZx0aO0SauagXfABRLni9IsJmeB
   R2h7WrTnv7CTjms7+9FprXfiQTDD5eGoD8XRIocu1UTlt4PNKKKvcsv+3
   RILjd4zPv3J06a4FhoYuH3chVUCfv+PRbrEZaMWx1o10GteKlW1yFJEJ9
   FmBQXGKr0rBbQ4+XTovDvzDA6Nv6uObaroo8ZywXXZj/m3Col5bcPelpo
   YfugucjH9tDCudXrEwUgThkJqTwNCUUfBwpfFlnbLIziGW0OtCz+OxkHW
   Z+SJYzaj54dQJuvjEpXwML4VnfENnB84cnwAh8sanzL7OetTHWTCfZpIB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455644606"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="455644606"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852415984"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="852415984"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 04:19:48 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.255.193.236])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AA00033BFB;
	Tue,  1 Aug 2023 12:19:46 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next 0/2] introduce DECLARE_FLEX() macro
Date: Tue,  1 Aug 2023 13:19:21 +0200
Message-Id: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add DECLARE_FLEX() macro that lets us declare structures with flexible
array members on stack (patch 1).

Show how it could be used by ice example (note that post-RFC version will
cover whole driver, here is just one file) (patch 2).

Two open questions:
Any better macro name?
Especially given it's valid only for on stack allocations,
(ie. could not be placed into struct definitions).

More sugar?
It's tempting to introduce yet another macro that would avoid
repetition of flex array field name and count, eg to apply:
-struct_size(sw_buf, elem, 1)
+flex_sizeof(sw_buf)

With simple definition:
+#define flex_sizeof(var) \
+	sizeof(var##_buf)

Yet I'm unsure if usage it's not too magical then?

Przemek Kitszel (2):
  overflow: add DECLARE_FLEX() for on-stack allocs
  ice: make use of DECLARE_FLEX() in ice_switch.c

 drivers/net/ethernet/intel/ice/ice_switch.c | 53 +++++----------------
 include/linux/overflow.h                    | 14 ++++++
 2 files changed, 26 insertions(+), 41 deletions(-)


base-commit: 9d1505d88ad0f6970015a06a475b9d67b21f20fa
-- 
2.38.1


