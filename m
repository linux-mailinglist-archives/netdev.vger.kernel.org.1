Return-Path: <netdev+bounces-288369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLsyD3BbB2orzwIAu9opvQ
	(envelope-from <netdev+bounces-288369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E61C7555786
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48EFF316BB74
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912343D0919;
	Fri, 15 May 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="aeeVo2ba"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6432ABC0;
	Fri, 15 May 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863259; cv=none; b=N2oIPIo/a4ieGmdnklSFUFChY2zIn2AxbWkYniWKTUFNgyS6M+y512ov2fmG3ZxmkTSRmItA2/wcuE+A2qwJ/eTR1EuO5VG1LtAUjc12+FNvjTefEHcgoq+kPSeE9GkVKJffN3JvCb3FJ5yg8v9zQuAl8NQv/Zzu4Nko31g842g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863259; c=relaxed/simple;
	bh=XWBFSg8szzCHX65W+LYQnfSnkWMu48jKtZ5yOZzh0cU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvESPKU0XKR4hdfChh+wKzMbSWL4643XU3zUr4mRyxyVR7Jf54t7TeqmQeC7bzS9ACstszo4NQJdjQwlB5Zq3aC0nlgnLyVeFkcFmo8XeAERDzixNuaXJh+wSTx9eOotkKhNHQHdDP7yhjs2PPd7w/nMcJVsU6v8/7caYm57bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aeeVo2ba; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778863257; x=1810399257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UlJWLuxmHT8SCx8qRHdUgoi0qgBbNM8ZIVyE0ArpedI=;
  b=aeeVo2baZn2DzTKeWkhInOn+91yNyKVgv3oS42wFn7O+pRFHY6kNaMlC
   jBMxLejs5xPmmOjA729AGTcdGAd8HOpKsDnt4GKgOLurjSVqM/Uudz4QX
   h0TQyg4XvHsDrFJ67MkMCeIz+rc+No8YRMtgobO6jwKU7S8B9OZewtkwa
   NYZTlrCKHbUA4Pr4Yu/PjCgLWuoPmDHty6bhISlZdQsSNWe1WIF0x5VaQ
   3K837YCkBi4MwGxMQESaZG2GegwyQsDnrHUiTsWqCirxs527/t4YEKKkw
   UqYGiNat4IJ7spp16thZPKtkBkgtbPcHzyrUPovUID9NJpSedPLXlc1kO
   Q==;
X-CSE-ConnectionGUID: BCUwzNNiSlGSpTmlVVao0w==
X-CSE-MsgGUID: Rrxq5KTkRc2wiKl2qJtcDw==
X-IronPort-AV: E=Sophos;i="6.23,236,1770595200"; 
   d="scan'208";a="19524399"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:40:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:28511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.132:2525] with esmtp (Farcaster)
 id 424bb4e9-4620-477f-afcd-4a4e409a5240; Fri, 15 May 2026 16:40:53 +0000 (UTC)
X-Farcaster-Flow-ID: 424bb4e9-4620-477f-afcd-4a4e409a5240
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:40:53 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:40:48 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v3 net-next 0/7] ptp: Add PHC timestamp quality attributes
Date: Fri, 15 May 2026 16:40:20 +0000
Message-ID: <20260515164033.6403-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: E61C7555786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288369-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series adds quality attributes to PTP Hardware Clock (PHC)
timestamps, allowing userspace to obtain error bound, clock status,
timescale, and raw counter values alongside timestamps in a single
call.

Motivation
----------
The existing PTP APIs return timestamps without any indication of
their quality. Applications that need clock accuracy and
synchronization status commonly rely on external tools such as
ptp4l, which implement synchronization logic and can export their
measurement of clock accuracy. For managed PHC devices — such as
the ENA network adapter, whose clock is synchronized by the device
without userspace involvement — these tools are not available, and
the existing APIs lack a way to report quality metrics to consumers
of time.

This was previously proposed as an RFC [1] with a single ioctl.
Based on community feedback, the design was reworked to cover both
the extended (multi-sample) and precise (cross-timestamp) paths,
with a shared attributes structure.

Design
------
This series introduces two new ioctls that extend the existing
extended and precise timestamp paths with per-timestamp quality
attributes: error bound (nanoseconds), clock synchronization
status, timescale, and raw hardware counter values.

A capability flag is added to ptp_clock_caps so userspace can
discover attributes support.

Patches 2-3 add testptp support for the new ioctls.

Patch 4 implements the attributes for ptp_vmclock, reporting
error bound, clock status, timescale, and raw counter values.

Patches 5-7 implement the attributes for the ENA driver,
reporting error bound from the device's PHC layer.

v3:
- Remove patch 5/8 from v2 (return-code bugfix) — sent separately
  as [PATCH net] to the net tree.
- Zero-initialize struct ptp_clock_attributes in PTP core ioctl
  handlers to prevent stack leak of unset fields. (Simon Horman,
  sashiko)
- ptp_vmclock: validate counter_period_shift < 128 to prevent
  undefined behavior on untrusted hypervisor input. (sashiko)
- ptp_vmclock: add overflow check on err_hi * NSEC_PER_SEC to
  prevent silent wraparound producing erroneously small error
  bound. (sashiko)
- ptp_vmclock: report PTP_TIMESCALE_TAI after tai_adjust() to
  avoid timescale mismatch. (sashiko)
- ENA: set counter_id = 0, counter_value = 0 in gettimexattrs64
  for defense-in-depth. (sashiko)

v2:
- Fix build bisectability: move ena_com.c consumer updates into
  patch 6/8 and ena_phc.c caller update into patch 7/8 so each
  patch compiles independently.
- Add missing Cc for Amit Bernstein (co-author of ENA patches).

[1] https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon.com/

Arthur Kiyanovski (7):
  ptp: Add ioctls for PHC timestamps with quality attributes
  selftests/ptp: Extract print_system_timestamp helper in testptp
  selftests/ptp: Add testptp support for attributes ioctls
  ptp: ptp_vmclock: Implement attributes ioctls
  net: ena: Update PHC admin interface for error bound support
  net: ena: Add error bound to PHC communication layer
  net: ena: Implement gettimexattrs64 callback for PTP attributes

 .../device_drivers/ethernet/amazon/ena.rst    |   2 +
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  17 +-
 drivers/net/ethernet/amazon/ena/ena_com.c     |  47 ++--
 drivers/net/ethernet/amazon/ena/ena_com.h     |   5 +-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |   3 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  64 ++++-
 drivers/ptp/ptp_chardev.c                     | 130 +++++++++-
 drivers/ptp/ptp_clock.c                       |   4 +-
 drivers/ptp/ptp_vmclock.c                     | 209 ++++++++++++++--
 include/linux/ptp_clock_kernel.h              |  30 +++
 include/uapi/linux/ptp_clock.h                | 225 +++++++++++++++++-
 tools/testing/selftests/ptp/testptp.c         | 175 ++++++++++----
 12 files changed, 804 insertions(+), 107 deletions(-)

-- 
2.47.3


