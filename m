Return-Path: <netdev+bounces-275683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t5BhN9H102k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:05:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0B3A5FBC
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4052130157D2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CFD38E129;
	Mon,  6 Apr 2026 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R79e+1eH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E538C400
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498700; cv=none; b=SleCgDbDUPbxaBKKtqqDqr41sZpTGtSHx7t46ndhdwZyaAY/Em7MolJwMICLfDbOgQMzLk8EWV4gfkai8E/qtsw0nfyXwhIsCsCMElIcRYA7N2FNZitJZoW+RUGf2KLuCxPyhVAKWRfnStCHami2Qnt6TB+OUlHbguQSs4NG+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498700; c=relaxed/simple;
	bh=8J4pls3u7qn78HUJnmnP1h8Tq6KlhuvkbD+d8tvw0Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVeY8mpJLEUdiI1LnOXOxAV1/GifnP/v04ShFhAY3MPbjuyEV54kfGqDlRB4wIUPpBCIRtPfdz/W2e3dxBa6V2MuKOnQQT96EFXvg4p6/Ur/1I+f1jSoei3lf0dzmjSVdgvHvKT6cyU4HIqmKh10tpgf/GSsNqZOKklVsL0QLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R79e+1eH; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-82748257f5fso2957199b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498699; x=1776103499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6SwnzZ2BZui5/n0VvZLDKAOFa1i2Bnonrww9Agi+QU=;
        b=llACF40NxlSEUjjm/ONDosjjxnHUuXhi6HJMSaSD0y48PONv9vodPXN6O1cS6rgjCK
         sLkgkA2rnPy9adUBhdFlUFE0EKPztx4gJIvc12bZQ7qEXtkIA+h9IjKY3vlJChlqsNJH
         U/O3ifDFGQx4gOAJDVgmdyXIbNVWxHgZbke8QPfXokdiONu4qNrGINLH2V/DBkQyBSuk
         O1KE+zOIhnxeo5+K7WyvKpzDEwFDz+/ZyIA8PSINfW1H/2ToA0gIBCbC0O8cubJ5/bE8
         tz7R5gjMfmZkfU8c5a0LVwYgovoHfkvuOL/xR1Sp1QS3UWj+Mvm/D3GJXsh0rAeDNzd0
         /2zA==
X-Gm-Message-State: AOJu0YwXYDIt/lWRaSDldjqj5nH01IykukqG4L/8UvmGDcn5sVzOw/Ta
	8Vel15NPOsputwtUKn27WNKy3HxyOA077LKtExkMiMFDY3HYulZZPNEms8+bOI24VB9/7U6BXZC
	pQL1kp+YJZ6DPZTFafBJcz+Ko3PMdAHYzOHHHzd2o1qJ6tOU01bB34l1Xm177RHHLwe/tTCJzTW
	i+4UuSR4QOe4X2eUHhVG5lfqZXYjcKa+9iiEieQjloAscV7XXs0WhqC5tqYwJ5ZQxxhYwfskx7i
	//uqJcfj2tH/Os5Kg==
X-Gm-Gg: AeBDieucEF3VNpCxbTNNVpi8702VelQT4REYxJS2L1I7ky7KUViXlARHxSwNeSpe2li
	scuEc+oPAyfHd52yjW4ec6yAGHdMCDo4yV4iquQKXvKiS2Ci8aSGJsXIQ0Cu+3li/42iiGkOwcZ
	1tcaTdUCEIUg6GNcWD6+B72snJOQddTqKOemJ8Ja+UD0anDT5yx1eyH6iP4QxgGx8vKQp0vYjQ1
	Fsf324+nlB4ioGM5dbiGuLF4xNjz/kssuegOn6f9XnUp2mabnGm303EhSP/4gDdzss9TszVsSH/
	FZ31/95DpufWIjvqrfOIo3dvw4h+uq9s0fblbBrzkxQ1HOrNqjNPusTJA672Be2zB+D8Snd2MBR
	76eKCak1BxpPvvsQqskc+QLJsmK+zwiJe0rXuYGuc8vlGaqbG+8aivNEsmj+C9+C75AXcgzAYPE
	44AeNQIs/jwElzJJO2EM5725CQofmTLKffRPoaqvf/G0igHF9EMnM4R8gUBHZ0kUg=
X-Received: by 2002:a05:6a20:6a24:b0:38e:92f6:9ab1 with SMTP id adf61e73a8af0-39f2da5adabmr12457230637.22.1775498698747;
        Mon, 06 Apr 2026 11:04:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c76c658b458sm703470a12.9.2026.04.06.11.04.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:04:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so3207891a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498697; x=1776103497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6SwnzZ2BZui5/n0VvZLDKAOFa1i2Bnonrww9Agi+QU=;
        b=R79e+1eHwb6ehH9G+aw7JjO0htwW7emOGYqLaiFe3l3dTv5jd9furGMAtdAfmG+4Og
         Peruzo5bVB7j2kcghNeic+rH8ufqYEHzCyU49mLnCafbSjWJR2VPKYZki+2MUcS9BgLN
         8UkWRuBn3L4ecnI6tWzU/Uvnt4pFb5TGMrIy0=
X-Received: by 2002:a17:902:ce0a:b0:2b0:53b6:d0a4 with SMTP id d9443c01a7336-2b277dad2d0mr148664955ad.12.1775498696783;
        Mon, 06 Apr 2026 11:04:56 -0700 (PDT)
X-Received: by 2002:a17:902:ce0a:b0:2b0:53b6:d0a4 with SMTP id d9443c01a7336-2b277dad2d0mr148664645ad.12.1775498696120;
        Mon, 06 Apr 2026 11:04:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:04:55 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v12 00/10] bng_en: add link management and statistics support
Date: Mon,  6 Apr 2026 23:34:10 +0530
Message-ID: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50C0B3A5FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series enhances the bng_en driver by adding:
1. Link/PHY support
   a. Link query
   b. Async Link events
   c. Ethtool link set/get functionality
2. Hardware statistics reporting via ethtool -S

This version incorporates feedback received prior to splitting the
original series into two parts. 

 Addressed following comments from Andrew Lunn
   - Apply Rev-xmas fix in several places.
   - Correct ethtool-speed comment to reflect accurate behavior.
   https://lore.kernel.org/netdev/49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch/
   https://lore.kernel.org/netdev/CANXQDtb5XuLKOOorCMYDUpVz6aFuQgvmQZ4pS6RJGkAgeM8n1A@mail.gmail.com/

 Addressed following comments from Jakub Kicinski
   - Took care of missing mutex_init()
   https://lore.kernel.org/netdev/20251127190855.69779791@kernel.org/#t
   https://lore.kernel.org/netdev/CANXQDtYy2JziaaVi=Cqt+gAJNt4NjFFs8NbhrS=RBV61ORwinA@mail.gmail.com/

 Addressed following comments from ALOK TIWARI
   - Add newline for clarity/formatting.
   https://lore.kernel.org/netdev/CANXQDtZbLhdwEtN+kKg1OVLV+uy-gsNfX+rU4MR77QPuO6_y9A@mail.gmail.com/

v12:
 Addressed a valid issue from the Sashiko AI review
  - Synchronize stats accumulation to prevent readers from preempting
    writers on 32-bit architectures.

 Migrate bnge link speed and PAM4 logic to speeds2 and delete firmware
 deprecated legacy PHY link paths.

v11:
 Addressed the ~30% valid issues from the Sashiko AI review (Paolo Abeni)
  https://sashiko.dev/#/patchset/20260327201343.16146-1-bhargava.marreddy%40broadcom.com
  - Avoided kasprintf+kfree in workqueue creation
  - Added timer_shutdown_sync() to ensure no use-after-free
  - Clear force_link_chng conditionally in bnge_hwrm_set_pause()
  - Fix REQ vs RESP macro for auto_pause_setting
  - Ensured baseline (and _ext) stats are fetched even if mask query fails
  - Persist port stats across close/open by moving allocation to probe
  - Use u64_stats_sync for 64-bit counters to ensure atomicity on 32-bit archs
  - Replaced RCU/flags with spin_lock_bh to protect get_stats64 and close_core
  - Include hw drop stats on base_stats callback
  - Added comment in hwrm_phy_qcaps() explaining why 0-speed reports are ignored

v10:
 Addressed the issues reported netdev Checks
  - Removed an unused variable.
  - Removed inline functions from .c files.

 Addressed the issues reported by netdev AI 
  - Removed an unused macros & function parameters.

 Addressed the issues reported by AI 
    https://sashiko.dev/#/patchset/20260324200740.346029-1-bhargava.marreddy%40broadcom.com
  - Updated the commit log to accurately reflect slow-path tasks.
  - PAM4-112 support related issue.
  - Sync pause autoneg during interface up. 

v9:
 Addressed the issues reported by gemini-3.1-pro-preview (Jakub Kicinski)
  https://sashiko.dev/#/patchset/20260319055124.1350670-1-vikas.gupta%40broadcom.com
   Patch 2:
    - Fixed format specifier for vendor part number (%.16s).
    - Fixed early return skipping PAM4 speed validation.
    - Added READ_ONCE/WRITE_ONCE to prevent context races.
   Patch 3:
    - Added missing PHY_FL_NO_PAUSE check in nway_reset.
    - Excluded 50G NRZ support.
    - Fixed uninitialized advertising field.
    - Fixed bnge_update_speed() XOR logic dropping valid speeds.
    - Fixed 100G/200G lanes for PAM4-112 single-lane requests.
    - Fixed SPEEDS2 fallback using wrong legacy mask.
    - Added rollback of eth_link_info on HW failure.
   Patch 4:
    - Fixed missing rollback of elink_info on hwrm_set_pause failure.
   Patch 5:
    - Fixed big-endian async event bitmap using u32 array.
    - Fixed data race on elink_info in softirq handler.
    - Fixed race where LINK_CFG_CHANGE processes stale PHY caps.
   Patch 6:
    - Fixed BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED flag mismatch.
   Patch 8:
    - Fixed stats drop race by reordering BNGE_STATE_OPEN and net_stats_prev.
    - Fixed ordering of clear_bit and net_stats_prev save.
   Patch 10:
    - Fixed tx_nr_rings mismatch causing potential heap overrun.
    - Fixed min_t(int,...) signedness mismatch in get_num_stats.

   Items deemed invalid:
    - Patch 3: rtnl_lock/netdev_lock interaction.
    - Patch 7: Use-after-free during teardown.
    - Patch 8: Port stats not saved on close (hardware retains stats).
    - Patch 9: Teardown race in get_queue_stats_rx (held netdev_lock).
    - Patch 9: TX queue index bounds and double-counting.
    - Patch 10: Standard counters via ethtool -S (hardware-specific).

v8:
 - Fix the smatch warnings reported by Dan Carpenter
    https://lore.kernel.org/r/202603180509.nOQGZrG0-lkp@intel.com/
v7:
 - Addressed the two valid issues reported by AI (Jakub Kicinski).
 - Fixed minor issues reported by Alok Tiwari.
 - Addressed the concern of statistics duplication raised by Jakub
   Kicinski. A few statistics (discards/errors) have been made part 
   of the standard netdev statistics and removed from ethtool -S.
   Additionally, a few statistics that require proper implementation
   have been removed and will be addressed in a later series, for example,
   get_pause_stats and get_fec_stats.
   https://lore.kernel.org/netdev/20260312192251.61243873@kernel.org/#t

v6:
 - Resending the full series due to an SMTP failure during v5
   submission.
 - No functional changes from v5.

v5:
 Address Jakub Kicinski's comments by holding the instance lock across
 the entire service task (instead of flag-based locking) and checking
 the OPEN bit under the lock to resolve the close-path deadlock. 

v4:
 Addressed comments from Jakub Kicinski:
  - Explicitly size speed mask arrays to remove the need for manual
    sentinels in the hardware configuration.
  - Fix an off-by-one error in the queue index bound check.
  - Standardize ethtool -S per-ring stat naming to "rxq$id_$name"
    (e.g., rxq0_errors). Removed spaces and brackets to ensure
    compatibility with parsing scripts.
  - Exclude ethtool -S global counters (tx_err, tx_fifo_underruns,
    tx_total_collisions) already covered by rtnl_link_stats64.

v3:
 Addressed comments from Andrew Lunn:
  - Fix a comment and refactor bnge_hwrm_set_pause() 
    to improve code readability.

 Addressed comments from Jakub Kicinski:
  - Switch to RCU for stats synchronization and drop the 
    BNGE_STATE_READ_STATS state bit.

 Fix checkpatch warning by switching to kzalloc_node(). 

v2:
 Addressed comments from Andrew Lunn:
  - Add implementation for .get_pauseparam and .set_pauseparam to
    support
    a full flow control configuration, covering global autoneg,
independent
    pause autoneg, and forced RX/TX pause functionality.
  - Move MAC, PHY, Control, Pause, and RMON statistics from
    .get_ethtool_stats to their respective structured ethtool
    callbacks (e.g., .get_eth_mac_stats, .get_rmon_stats).
 
 Addressed comments from Jakub Kicinski:
  - Fix potential out-of-bounds read in speed mask array by adding 
    the missing sentinel.
  - Simplify timer synchronization by removing the redundant intr_sem.
  - Replace link_lock with the netdev instance lock, as it is sufficient
    to handle the required synchronization.

v1:
https://lore.kernel.org/all/20260223163641.755200-1-bhargava.marreddy@broadcom.com/

Bhargava Marreddy (10):
  bng_en: add per-PF workqueue, timer, and slow-path task
  bng_en: query PHY capabilities and report link status
  bng_en: add ethtool link settings, get_link, and nway_reset
  bng_en: implement ethtool pauseparam operations
  bng_en: add support for link async events
  bng_en: add HW stats infra and structured ethtool ops
  bng_en: periodically fetch and accumulate hardware statistics
  bng_en: implement ndo_get_stats64
  bng_en: implement netdev_stat_ops
  bng_en: add support for ethtool -S stats display

 drivers/net/ethernet/broadcom/bnge/Makefile   |    3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   10 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  732 +++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  384 +++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1132 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  173 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  676 +++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   94 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3229 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


