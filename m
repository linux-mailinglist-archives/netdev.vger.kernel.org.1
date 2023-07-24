Return-Path: <netdev+bounces-20371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BD75F318
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E194281102
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C78824;
	Mon, 24 Jul 2023 10:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5A7479
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:28:30 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC5A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690194488; x=1721730488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bp4BAQvM2ZaTjG0Z5UYMV1HFh+5LLv9ayqG+vWA/B14=;
  b=QY3SfF+qFgyLP+OA2Ohan85OhCHLDJ0y9h6fGNIh7d0ftcgUpd1wIYGL
   Kd8FIYunR0k2j4q2fdvjyeZSzJ4WxUKjp3BQigYQ7JdFKL3FSMtwa7VdZ
   /59RHExMxl76fGK/ar3UAITyeZNRn0aroLKFD37B15m9lQ3R7BLL+dsS4
   rxanOzlORgML4svIeegd6HuxOANtfcR+PVmzsuopDE5OrmTvAAyZTkish
   ZSF7JGgS29dSvc92twKpZq6UM3PWMDBBgQmYO0k8D+t0HXp3/uAxOk6Lw
   m3jrjj+aCHCH0Bkv6bhAM4HToST4Abu2T2s599iiX52iVB8CPdG/91+Gv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="431200797"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="431200797"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719630836"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719630836"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 03:27:35 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: simon.horman@corigine.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 0/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date: Mon, 24 Jul 2023 12:25:19 +0200
Message-Id: <20230724102521.259545-1-arkadiusz.kubalewski@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the issues with parsing enums in ynl.py script.

v3->v4:
- decoding 'enum-as-flag' starts from 0 instead of enum's start-value
- move back usage of _decode_enum() back to _decode_binary()
- fix typo in commit message

v2->v3:
- Restore i iterator helper for decoding 'enum-as-flag' attributes in
_decode_enum(..) function.
- Fix _decode_enum(..) usage in case of binary & struct type attributes
by moving it to as_struct() funtion while calling _decode_enum(..) for
individual struct members.

v1->v2:
Initially this was one patch, but review shown there is need to fix also
leftover issues with indexing in _decode_enum(..) function
("tools: ynl-gen: fix enum index in _decode_enum(..)").

Arkadiusz Kubalewski (2):
  tools: ynl-gen: fix enum index in _decode_enum(..)
  tools: ynl-gen: fix parse multi-attr enum attribute

 tools/net/ynl/lib/ynl.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.38.1


