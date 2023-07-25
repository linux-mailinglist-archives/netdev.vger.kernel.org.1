Return-Path: <netdev+bounces-20799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3EE761079
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B3A1C208BC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932A18C01;
	Tue, 25 Jul 2023 10:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8A13AEB
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:19:11 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AF10DC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690280348; x=1721816348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+m2ct5rpwpUh+zqOL0zNDxQ60zs6+gxxIKY8sDTWVlA=;
  b=PkYlwOfqlB3pKjccBkmz1E8y4ugb3aQczIF3uyeg8ng4ew2jtR8cXkxf
   4JeiVz5vTYLoKuGk3Mlsb7yZH2Z9feyW434ZMRI1O8ee6+D69a+KSe71M
   poQpqvD9KeMbn6GHIDJ2MdGJzN07iqLeDSlLvRw+8+KTC8gPk1DVZDyQS
   2wvIzgdi81ivrE9se4UL4sWSnsmYnhMZJHiJIpsO54v2syHDkvp3sf60K
   uddvYjHvL6XMPRzPMCJ96EDohB8BzJsmStasivjsHVryrjeYoFhbO6ZgV
   1Rze7BHcKRgbcowz03HszYBwUmT7YZZPR6R/CNRmFb7XcEtmKfQp1H0FG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367706000"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367706000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869429687"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2023 03:19:07 -0700
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
Date: Tue, 25 Jul 2023 12:16:40 +0200
Message-Id: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the issues with parsing enums in ynl.py script.

v4->v5:
- fix indent issue in _decode_binary()

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

*** BLURB HERE ***

Arkadiusz Kubalewski (2):
  tools: ynl-gen: fix enum index in _decode_enum(..)
  tools: ynl-gen: fix parse multi-attr enum attribute

 tools/net/ynl/lib/ynl.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.38.1


