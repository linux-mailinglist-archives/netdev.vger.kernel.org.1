Return-Path: <netdev+bounces-17492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC699751CB3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77293281431
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE04F9F1;
	Thu, 13 Jul 2023 09:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044CF9E9
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:07:51 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08841BDA;
	Thu, 13 Jul 2023 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689239269; x=1720775269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4FbaeI4tBhOKW8/Jmri85jlOT3p1bcaXOdawC1bIvcs=;
  b=lf98nuVMnt7wwC1UgYjPAde9JzqTRktpPQ1o2DmvHuap4/hbmAtr//ht
   0BCGevC7CgncaamV/CyqW+z/w94gbcOgKWLKoKygJ7/x74SXO4A6lj/PG
   RaG/9PqlKzbJAb6qGCXAG0DS3KJz+khc/trBpAcF8rjXXeC+2FKerM+qO
   4v1xVM+knhNv7/2G4vfwqjSVpkNuZWgJ/iYLx3fcfpOFr+sYMGnODqv1J
   KmZsmaRThP2KfhEkDxc6TIi5Z6/iwTUfrU74M0gC4UjtpduM/nKIrCfAm
   Nk1i7XdFeqAp81AroadQnCyoeMpMuQOMN1yo/iEX6j3jrS4ww0OZhF5gx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367760118"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367760118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 02:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866481051"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866481051"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2023 02:07:46 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	chuck.lever@oracle.com
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next 0/2] tools: ynl-gen: fix parse multi-attr enum attribute
Date: Thu, 13 Jul 2023 11:05:48 +0200
Message-Id: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the issues with parsing enums in ynl.py script.

v1->v2:
Initially this was one patch, but review shown there is need to fix also
leftover issues with indexing in _decode_enum(..) function
("tools: ynl-gen: fix enum index in _decode_enum(..)").

Arkadiusz Kubalewski (2):
  tools: ynl-gen: fix enum index in _decode_enum(..)
  tools: ynl-gen: fix parse multi-attr enum attribute

 tools/net/ynl/lib/ynl.py | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.37.3


