Return-Path: <netdev+bounces-13132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E073A6BA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30A81C21023
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA73200AB;
	Thu, 22 Jun 2023 16:57:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D21EA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:57:55 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFA310D2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453063; x=1718989063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kk9UMPTpdLASuNYfdeXAI0dIKiEfmxHVHl0AKRezGNs=;
  b=VObUSnciokq2RJXnzKItnE+o5r3Tz6Cl/2Gf7ylzGSlC5NTJFGuS+WUi
   4VXfKc1lHIfNiGaN48aMynEtl9pPwTy66grmEivxTgkGO8fVwzX+iTxBX
   wJTtmgl63lackccjNJZnVllXRe1T48Daojl8obXBxBN1Vo6dLmL5cLsD9
   fW3YGfZFQ6bAtQGLr78VMEj6KqYuW9rtM8007I5BPJh0uh+Npeg7AAR/s
   /eB+E0sEtPNLlOyi/ko5k6Jq3BUT6KOXcZQvjurfR/XQ/EsIOdVaMnu6B
   VFPp3lYSV5fmtkmAamLvQgv9VLKseX7pfDao4AsFHpXVsyLWLalJvm72A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340887245"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340887245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692358316"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="692358316"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 09:57:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	vinicius.gomes@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net v2 0/4][pull request] igc: TX timestamping fixes
Date: Thu, 22 Jun 2023 09:52:40 -0700
Message-Id: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
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

This is the fixes part of the series intended to add support for using
the 4 timestamp registers present in i225/i226.

Moving the timestamp handling to be inline with the interrupt handling
has the advantage of improving the TX timestamping retrieval latency,
here are some numbers using ntpperf:

Before:

$ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o -37
               |          responses            |     TX timestamp offset (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
1000       100   0.00%   0.00%   0.00% 100.00%      -56      +9     +52     19
1500       150   0.00%   0.00%   0.00% 100.00%      -40     +30     +75     22
2250       225   0.00%   0.00%   0.00% 100.00%      -11     +29     +72     15
3375       337   0.00%   0.00%   0.00% 100.00%      -18     +40     +88     22
5062       506   0.00%   0.00%   0.00% 100.00%      -19     +23     +77     15
7593       759   0.00%   0.00%   0.00% 100.00%       +7     +47   +5168     43
11389     1138   0.00%   0.00%   0.00% 100.00%      -11     +41   +5240     39
17083     1708   0.00%   0.00%   0.00% 100.00%      +19     +60   +5288     50
25624     2562   0.00%   0.00%   0.00% 100.00%       +1     +56   +5368     58
38436     3843   0.00%   0.00%   0.00% 100.00%      -84     +12   +8847     66
57654     5765   0.00%   0.00% 100.00%   0.00%
86481     8648   0.00%   0.00% 100.00%   0.00%
129721   12972   0.00%   0.00% 100.00%   0.00%
194581   16384   0.00%   0.00% 100.00%   0.00%
291871   16384  27.35%   0.00%  72.65%   0.00%
437806   16384  50.05%   0.00%  49.95%   0.00%

After:

$ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o -37
               |          responses            |     TX timestamp offset (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
1000       100   0.00%   0.00%   0.00% 100.00%      -44      +0     +61     19
1500       150   0.00%   0.00%   0.00% 100.00%       -6     +39     +81     16
2250       225   0.00%   0.00%   0.00% 100.00%      -22     +25     +69     15
3375       337   0.00%   0.00%   0.00% 100.00%      -28     +15     +56     14
5062       506   0.00%   0.00%   0.00% 100.00%       +7     +78    +143     27
7593       759   0.00%   0.00%   0.00% 100.00%      -54     +24    +144     47
11389     1138   0.00%   0.00%   0.00% 100.00%      -90     -33     +28     21
17083     1708   0.00%   0.00%   0.00% 100.00%      -50      -2     +35     14
25624     2562   0.00%   0.00%   0.00% 100.00%      -62      +7     +66     23
38436     3843   0.00%   0.00%   0.00% 100.00%      -33     +30   +5395     36
57654     5765   0.00%   0.00% 100.00%   0.00%
86481     8648   0.00%   0.00% 100.00%   0.00%
129721   12972   0.00%   0.00% 100.00%   0.00%
194581   16384  19.50%   0.00%  80.50%   0.00%
291871   16384  35.81%   0.00%  64.19%   0.00%
437806   16384  55.40%   0.00%  44.60%   0.00%

During this series, and to show that as is always the case, things are
never easy as they should be, a hardware issue was found, and it took
some time to find the workaround(s). The bug and workaround are better
explained in patch 4/4.

Note: the workaround has a simpler alternative, but it would involve
adding support for the other timestamp registers, and only using the
TXSTMP{H/L}_0 as a way to clear the interrupt. But I feel bad about
throwing this kind of resources away. Didn't test this extensively but
it should work.

Also, as Marc Kleine-Budde suggested, after some consensus is reached
on this series, most parts of it will be proposed for igb.
---
v2:
 - Fixed possible race condition when disabling TX timestamping, added
   a per queue flag, should make the hot path (no timestamps enabled)
   a bit nicer
 - Renamed the igc_ptp_tx_work() to something more sensible (it's no
   longer called in a workqueue)
 - Improved commit message, added more details about how to trigger
   the hardware issue, and more details about the alternative
   workaround to the cover letter
 - Added some numbers, from the cover letter, to the commit message
   itself

v1: https://lore.kernel.org/netdev/20230530174928.2516291-1-anthony.l.nguyen@intel.com/

The following are changes since commit 2ba7e7ebb6a71407cbe25cd349c9b05d40520bf0:
  Merge tag 'nf-23-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Vinicius Costa Gomes (4):
  igc: Fix race condition in PTP tx code
  igc: Check if hardware TX timestamping is enabled earlier
  igc: Retrieve TX timestamp during interrupt handling
  igc: Work around HW bug causing missing timestamps

 drivers/net/ethernet/intel/igc/igc.h      |   8 +-
 drivers/net/ethernet/intel/igc/igc_main.c |  14 ++-
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 142 ++++++++++++++++------
 3 files changed, 117 insertions(+), 47 deletions(-)

-- 
2.38.1


