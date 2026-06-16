Return-Path: <netdev+bounces-299893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GzIaK0h1MWpSjwUAu9opvQ
	(envelope-from <netdev+bounces-299893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:09:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C24A0691BF1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:09:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FhlZFyfo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299893-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299893-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18F953046337
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB13B840B;
	Tue, 16 Jun 2026 15:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1739282C;
	Tue, 16 Jun 2026 15:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625023; cv=none; b=FcP5QHm8LymTGHQeEiuGjfB+Tz93r7uJv685jmV2FNKMCOpZIISstXCB703xjVzQfqsNO4cqbPFrXHcdnB/LgidtYl3q0GzGF0cCrU+TVOEcgJ1NW8iRKM2B9ckqXW0zN5GME+8rjIWq8cGkK9W7Zvvji7nkPZ4KNhvMqY9CZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625023; c=relaxed/simple;
	bh=TwBV8VPYVxSy1EgFWxObclBgVWNGRE9JBaZgyorMpnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRQ+E7m9Bj8iw5SswWyv6i8zzKj5CvVf0YLGiH2INIv6dbom277HoB24h2bZ8Idy/hasHYN8+7L2ymlkEk+r4n2jNajKA6fZop4y1ynnNKgojYkLf6t4l6QsS4zStp2Wg7M4UyCr3HkHeoebs3TPbahV+dY6LvllUZCd1wt+SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhlZFyfo; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781625022; x=1813161022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TwBV8VPYVxSy1EgFWxObclBgVWNGRE9JBaZgyorMpnk=;
  b=FhlZFyfolpeApEpPYBex115yGRidBo62ZAHC8J9xL+lKbePBnf/nk5tD
   XFkfwHVe09c5wRU4MYS0x1ZAlIvCpPEhc9IgGM1+zPDKG0R363uPyOjje
   3gI8/IuYDDm2aSYCfz+Pj76iW1+Ga72fUGBoANU8f+wAEkeaR+u4I2XQN
   Bp4uU9mYGmIIhWMntKwCZ84bTH2nQo6cfqZlSK9LBKQDw1rlvOurQp3dl
   HeRhVCsj8+UAMt2FSpsXexDun4jA6oz6JIJqmcsCGcNAnpLJFM2xx9H3g
   EZF1hION5jxRbqAIoBsche6x4uZgT8jIz1fvHbRggTPspO6yubkhmOtVC
   A==;
X-CSE-ConnectionGUID: npAVwhvhQWevZV2u5DR6+Q==
X-CSE-MsgGUID: lTHJMGAGTeOQgjcn2sQrbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86232985"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86232985"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:21 -0700
X-CSE-ConnectionGUID: Vlbj8AqaSmypbcOatriXHg==
X-CSE-MsgGUID: zhg1Np77Q4Ke3T7HM9ZF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247684278"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:18 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
Date: Tue, 16 Jun 2026 21:19:51 +0530
Message-ID: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299893-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C24A0691BF1

This series improves AF_XDP selftests by making timeout handling
explicit and fixing sources of non-determinism in xsk timeout tests.

Patch 1 introduces test_spec::poll_tmout and removes implicit
dependence on RX UMEM setup state for timeout behavior.

Patch 2 fixes thread harness sequencing by attaching XDP programs
before worker startup, removing signal-based termination, and using
barrier synchronization only for dual-thread runs.

Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
configuration does not leak into subsequent cases on shared-netdev
runs.

Together these changes make timeout handling easier to follow and
improve selftest stability, especially on real NIC runs.

Tushar Vyavahare (3):
  selftests/xsk: make poll timeout mode explicit
  selftests/xsk: fix timeout thread harness sequencing
  selftests/xsk: restore shared_umem after POLL_TXQ_FULL

 .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++--------
 .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
 2 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.43.0


