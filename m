Return-Path: <netdev+bounces-18644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023575820B
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1F281161
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2B13AE9;
	Tue, 18 Jul 2023 16:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38B125D8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 16:24:34 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC32D3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689697473; x=1721233473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HYFkBQRPAvQUej9y9Hm7umXPZxSSTYHwEdTL0EQotmI=;
  b=nvuzhLtVQP+aL3VdBJPmI55etDZg3QAALSjp5+0myul0mJJwpVxdYpxe
   IkqZRCH3SwF8SlXQzGfa9R180ISkfdQRe90CMMwA0X8ppNugleCjtaiq1
   bbsYaEiAeQhk6aonV4oytF3gR1N+ypMCq4MgPvhM1DuFHGnYG53uZo3xx
   M9ZEp64+UDG4+3JpuyJeicM5yABY833F0HC7vpJ+BQvMib06Y60JkAiVL
   mqsmA9ynXOkWI4Zl+fsmw837cCsALZIlmZkbfCfnf6WBaWV5z/+HXi+Qn
   Q8gRmFqFLqtYxA9PjUMUflF+OsBgBDBwZ3EZXTJt3bRk6b6w6oB9ToBlp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368894190"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368894190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753388363"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753388363"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 09:24:28 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v3 0/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date: Tue, 18 Jul 2023 18:22:23 +0200
Message-Id: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the issues with parsing enums in ynl.py script.

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

 tools/net/ynl/lib/ynl.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.38.1


