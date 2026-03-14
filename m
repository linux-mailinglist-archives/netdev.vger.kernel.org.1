Return-Path: <netdev+bounces-267819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMOSKN+otWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:28:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBE28E705
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1238330160EA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E493368B5;
	Sat, 14 Mar 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtB6DJF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1401C3C08
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512921; cv=none; b=IeLjOJpzJncCqa6w9N0NXGluvtP5ss8/lJ4KplFHPfHu87dHpFZLCqUpHVey70E57vKzspwB0iG8IupaDpwsR7nmv7BpkefL/6f5YYiMPAQcb2MFWoxKVvGM0bc0jO0O6QMDK504dfxbdf3vKJpaXqbOCAKGMBivUsifGVglSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512921; c=relaxed/simple;
	bh=6Dg4ltixbmi+/T9C42BHujX2QGGlZeoJZtMbEA7S5y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/tP5SdnUfL4jXce5i/AIlu9kO3Fot4RJ6UcU0l5i8tfv5/+DcOb0o+eujzaN0YlsK5qzg+2IcHhBNsOidiRuVo/KSs9HpyQ1c9Q3QkQX2HGa0TpjTlS1BDqoAAM39zO4Gqj8mC2yAGowWn1t+kuLXRONE0/6LZ1uS9Q8Xee/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtB6DJF+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b048527825so2245815ad.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512919; x=1774117719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzRfjfQpWVZCvzWQMidKmnmIxujMBJECx4zb/GyFV+8=;
        b=YtB6DJF+P5ZDqMFsFeOAOctLm8k/gZuY1IBJpp6n1dPg96G0CvhssknKggd+R7WIkN
         52fps7jl1DZVl+yonCcSL6ki9y5FpAKeGhQFJa5VLptK6oFnGOlR8uER3UnIvOtbRy/h
         1fysfx5qBRF5iYpfidVfWI5B216kBYtJxuWndDCAL8dBzD0B62YWUn2hjaO0YX150pbO
         n6Paz4977MDV8RxVgOWCk63lHGg6JO2l7X//tVpJNau+j9paZNSdImqbLolHSUw/Ljnx
         +plz1WD1VWRJdOGAgMtVIwyjIpCo032GVmpQugN4Ma7nkmQxe409rbcqBVRS730aCbLJ
         n2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512919; x=1774117719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzRfjfQpWVZCvzWQMidKmnmIxujMBJECx4zb/GyFV+8=;
        b=IbN/bLaW2dc9dQpVlaIgxxn8e1UOP4K3a2/SbQSeM7uarQ7AxAvPth6fMLjL5lbNLs
         XsOS7R5L+bCwOC/w2UJMf+pI101yBtutiu6koZnYFoCryfI7AyVXxlbD7PXq3p/EgAnW
         Sv+GlJ5Xg1xh3CAhzFn/x3lfBEYtXIS0xeN1L50JyvNTc2Y+caYO/M2sLA75+rAn9nFd
         UDSRvSy1YNj7OD4IWztfzQNpUL5igzQA/4rxp7uHWxHZSBiaIUT02I4UCKzZc7W+59zm
         aZyL3XRSY3OoUmTxTCrPvKxZWuvn5p4i68d66xnxpQCmuoPTx07Ci93pLmwuHPue7YXj
         HeIw==
X-Forwarded-Encrypted: i=1; AJvYcCW96MoVRvjHJUROP3rL1w0gKKz2y3uwEQ85KyeaSgaElJbQPcqs5HpwgvQL+7us3nNVIK9N5ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxtwx/r/mTUTyM06E644dIPnt1lrXdLaXD7rk1+XImHa7gj2YZ
	jyi1bz1f9ydp10JvHOXM4MnyhkNulOsVRzXpNUXk4nIYNW0ZEXwqxTEz
X-Gm-Gg: ATEYQzxFNJKmlHyGZ0eZ8GH6q57yJsTWAFOd6pNF4SxwxQQRmLGAI6qlNTIhR0riGdw
	+DZqr/8qjnfhc5d6jQuCKRLm6JwJEAflQIL8YrHHF1ZvF3LO6heaeg/U94zcvKAZhiudG83GQxj
	+enEd5oNTSx0XEWKh8E6JY15zFcTdWgL8XiVNp/F4Ka8AI9w9P0GuOtY/IysFH5PPzck3ySQgqw
	gcBv7ZA/WRCHdS2wBywNQB5oBcjSRdh+BOveVM1l631Fmkwhe1/kONdsyGnOFUFyO1hoNrzyJiE
	XyDuhkQx4wE9IFKOuVmKTIJQsqudptCTdm+Sb6VVYFjyLWIMa9WjZVp1xQiRbns5jcwv4pYESLE
	gV0fsPVY14H8Gb6BkWz3A6cFa98BIh1Pq9FYc1yDl1WzNg2UfOs63ypl2rVAPnSrnRSw+L5Zmud
	t08lIGdV6EYR9jfSkRI2+mVq7MjGWkD6sJCDaInlK3UYDsSFzgu08DUHTbXLOowunDqBy52Q1Yr
	tsjfA==
X-Received: by 2002:a17:902:ef03:b0:2ae:a429:fc42 with SMTP id d9443c01a7336-2aecac51329mr74086885ad.40.1773512919100;
        Sat, 14 Mar 2026 11:28:39 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:28:38 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 0/7] Introduce async callback ndo_set_rx_mode_async
Date: Sat, 14 Mar 2026 23:58:02 +0530
Message-ID: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20EBE28E705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

The set_rx_mode callback is invoked under the addr_lock spinlock which
makes it illegal to sleep. This means set_rx_mode is prone to
sleep-in-atomic bugs as drivers have a tendency to do the I/O directly
in the callback.

This problem can be avoided if set_rx_mode were done in 2 stages: snapshot
and commit. A handful of drivers implement this idea by implementing the
rx_mode setting as work and scheduling it in the set_rx_mode callback.
This series moves that work to net/core by introducing a new async
netdev op set_rx_mode_async.

In the process of doing this, I encountered problems described in the
the first patch of the series. In brief, the patch introduces a state
variable to keep track of the current netdev state. This should be
useful for async netdev ops in general as nothing about these problems
was specific to set_rx_mode_async.

The rx_mode refactor has the secondary benefit of preventing RX mode
update requests from building up as only the most recent request
(before the work has run) will be committed.

In brief, the new RX mode update flow will look something like:

set_rx_mode():
    ndo_set_rx_mode();
    prepare_snapshot();

set_rx_mode_async():
    fetch_snapshot();
    ndo_set_rx_mode_async();

ndo_set_rx_mode_async() is called from a work item and the handler
doesn't hold the netif_addr_lock spin lock during its execution
making execution sleepable in that part.

This model should work correctly if the following conditions hold:

1. ndo_set_rx_mode_async should use the rx_mode set by the most recent
   call to prepare_rx_mode() before its execution.

2. If a prepare_snapshot() call happens during execution of the work,
   the work should be rescheduled.

3. All calls to modify rx_mode should pass through a new helper
   netif_set_rx_mode (which requires the instance lock or RTNL if the
   driver doesn't use it).

1 is guaranteed by the implementation and 2 by workqueue properties.

Drivers need to ensure 3.

---

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch
Link: https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

v4:
- Completely reworked the snapshot mechanism as per v3 comments
- Implemented the callback for virtio-net instead of 8139cp driver
- Removed RFC tag
Link: https://lore.kernel.org/netdev/20251118164333.24842-1-viswanathiyyappan@gmail.com/

v5:
- Fix broken code and titles
- Remove RFT tag
Link: https://lore.kernel.org/netdev/20251120141354.355059-1-viswanathiyyappan@gmail.com/

v6:
- Added struct netif_deferred_work_cleanup and members needs_deferred_cleanup and deferred_work_cleanup in net_device
- Moved out ctrl bits from netif_rx_mode_config to netif_rx_mode_work_ctx
Link: https://lore.kernel.org/netdev/20251227174225.699975-1-viswanathiyyappan@gmail.com/

v7:
- Improved function, enum and struct names
Link: https://lore.kernel.org/netdev/20260102180530.1559514-1-viswanathiyyappan@gmail.com/

v8:
- Implemented the callback for drivers e1000, 8139cp, vmxnet3 and pcnet32
- Moved the rx_mode config set calls (for prom and allmulti) in prepare_rx_mode to the ndo_set_rx_mode callback for consistency
- Improved commit messages
Link: https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyyappan@gmail.com/

v9:
- Removed cleanup_work and simplified resource cleanup
- Added netif_async_ctx (which includes netdev state tracking) for async ndo handling in general
- Converted netif_schedule_mode_work to a synchronous function netif_set_rx_mode
- Renamed *_write_rx_mode functions to *_set_rx_mode_async

I Viswanath (7):
  net: core: Add state tracking for async netdev ops
  net: core: Introduce callback ndo_set_rx_mode_async
  virtio-net: Implement ndo_set_rx_mode_async callback
  e1000: Implement ndo_set_rx_mode_async callback
  8139cp: Implement ndo_set_rx_mode_async callback
  vmxnet3: Implement ndo_set_rx_mode_async callback
  pcnet32: Implement ndo_set_rx_mode_async callback

 drivers/net/ethernet/amd/pcnet32.c            |  65 +++-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  77 +++-
 drivers/net/ethernet/realtek/8139cp.c         |  49 ++-
 drivers/net/virtio_net.c                      |  85 ++---
 drivers/net/vmxnet3/vmxnet3_drv.c             |  46 ++-
 include/linux/netdevice.h                     | 123 ++++++-
 include/net/netdev_lock.h                     |   8 +
 net/core/dev.c                                | 335 +++++++++++++++++-
 8 files changed, 663 insertions(+), 125 deletions(-)

-- 
2.47.3


