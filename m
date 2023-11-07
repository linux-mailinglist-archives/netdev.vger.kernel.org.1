Return-Path: <netdev+bounces-46388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE6C7E3AFC
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881AAB20B48
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB82D05C;
	Tue,  7 Nov 2023 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D42oczmo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79328E38
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 11:21:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89491;
	Tue,  7 Nov 2023 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356116; x=1730892116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4Tpz5L6PCxNOS3E/Mpmben/vumZjjJ+Uyr4CUFs7VU=;
  b=D42oczmo5P6ehk84XyX3PDRwcKWAUXm1yek00Cp6XNqJYIeXto5z6YEZ
   vXG6yF71EGKO4RAe5It+fR2CuUthZa7s/Rs/UW+PjHVKgWvmti4nZ2dta
   nsL2ZY8+eaEYJv5fzrSeQKRqu79EgIZM2y8UW7T4ZTLRoXcbeLBR45RH0
   2Ps8UYsJGcAXC3GFZrP5tCzFYmdIIF+xNf8kibPj7IWQyx9Z5q9e2ohgt
   afppx+TUWURRanR+2bG/luKhbXe0uQjx4wlWAxXGS3NUVVCdW3YoBG3On
   RI52vkF5A6Qv8uCdiH88hJoFHHD6ObnJuqYXzn62fYVRccirNtLCswQzw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727076"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579774"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579774"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:21:54 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id C4038580D61;
	Tue,  7 Nov 2023 03:21:51 -0800 (PST)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/7] qbv cycle time extension/truncation
Date: Tue,  7 Nov 2023 06:20:16 -0500
Message-Id: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
the Cycle Time Extension variable allows this extension of the last old
cycle to be done in a defined way. If the last complete old cycle would
normally end less than OperCycleTimeExtension nanoseconds before the new
base time, then the last complete cycle before AdminBaseTime is reached
is extended so that it ends at AdminBaseTime.

Changes in v2:

- Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
- Removed sched_changed created in v1 since the new cycle_time_correction
  field can also serve to indicate the need for a schedule change.
- Added 'bool correction_active' in 'struct sched_entry' to represent
  the correction state from the entry's perspective and return corrected
  interval value when active.
- Fix cycle time correction logics for the next entry in advance_sched()
- Fix and implement proper cycle time correction logics for current
  entry in taprio_start_sched()

v1 at:
https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/

Faizal Rahim (7):
  net/sched: taprio: fix too early schedules switching
  net/sched: taprio: fix cycle time adjustment for next entry
  net/sched: taprio: update impacted fields during cycle time adjustment
  net/sched: taprio: get corrected value of cycle_time and interval
  net/sched: taprio: fix delayed switching to new schedule after timer
    expiry
  net/sched: taprio: fix q->current_entry is NULL before its expiry
  net/sched: taprio: enable cycle time adjustment for current entry

 net/sched/sch_taprio.c | 263 ++++++++++++++++++++++++++++++++---------
 1 file changed, 209 insertions(+), 54 deletions(-)

-- 
2.25.1


