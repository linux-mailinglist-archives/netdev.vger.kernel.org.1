Return-Path: <netdev+bounces-303570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +quSLw7nRGpe2woAu9opvQ
	(envelope-from <netdev+bounces-303570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:08:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C576EBE7C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:08:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303570-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303570-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE3933088C83
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A451403B10;
	Wed,  1 Jul 2026 10:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180930C154
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:02:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900150; cv=none; b=nyOoZNX+RqoDi0m4waKpXOlSnvKZfnbxEUw+nSoY8QeSEKMbZ/0sHeQ4Y+L1Njty7GXiYLQ6t0AxCKv1uD8urqNQ6/G7Ak4q9o1kgYdnw2HI6GXjWkTWkZJVfqBdrU2QoR1TjxInPwWCaDkYFLEqQA15CG0O8bLAjUnNqtaEtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900150; c=relaxed/simple;
	bh=Vm75Am+3esaz56D/8REMriBXwVrCo5HUy6JpUIrbYkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tmnt1J9MEzFmwvZ/IDl4PGm8uT19e4Nbx5vNEmy3MbFctkmByHylZjZ76/05Zf9cLD3GhlLhMy1jblcThtgnYKMdQ+ARydplBMKWo8tym2zdZ+8rSia7f1wtqRXWFHVswBuiraVkuQK8/NkFDsfyfW+r+5Pf9zJ9G+bPSVvNX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
X-QQ-mid: zesmtpgz4t1782900112t591a54a0
X-QQ-Originating-IP: asckYuLMWxurpVG/C7IzBMMPHTdlU9p/qA5f1AwRwj0=
Received: from localhost.localdomain ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 18:01:51 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11878846642514610118
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 0/3] net: libwx: improve VF ethtool support
Date: Wed,  1 Jul 2026 18:01:42 +0800
Message-Id: <20260701100145.23738-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OeKnwO9PF+b4nUExRHF5rhjNGsEmIYpItY1ZM9myn04NRayszTUUR/Np
	4v5jceZmrLr4qvpn+v/bHoYYa73yf9VLHP2twFlsVcVHIw1v+51y4//3h5zCHxtgFxxtX1M
	zcZocpNqe6gANbJs1NzMAnTdp70kAWm19rsCpOQ6EIgzc/9cSJuvm/ewAvtzBpK86mU3+HG
	8gmma6RK1K7X/XZ5bgnQ6Urrj58UK7C2FyHgFI5oi5nTIpPGl0ig/qpXVEADIkmYlmH1/JY
	roaI4NXoV88n3mXvbhPFHo0UH+l9hyXCWFX6ZGwDnyWygghJfexYI7DLFTHfT+b8KKfo7DU
	CyFqBzwDS67dWn7jLdMTC+mYsqlI+HVCvRlAcmcT2Dz0NDmqrFAw/XbwxdgsIDCrl3/kfKw
	2jHFIJCsbFhTtGYDL8fWA6I7cxE9VC0n57lR5K6Bvgz6vGAL2BHtw0hUfDNoxzIc3mqW/mV
	fAns1ICCShV1Z2Gh7fpqJ7qdm5nddMXOhq084Vzfxx1RqcX6CIICNMB7nCCYHLhN+GCqoIp
	RlONQ42zgkVsyzH9LIJ7apsRbcMkYmcy0Go4MHSLh5X27oMmRQpqTkbO+FfszIrxPVq0qcE
	U7m8fSnBaNUxbK2TKtZ0Q6BBJBcXLz7k1V7y/IXnz59RiUbSsfdFCqsNxfc7zYjp0fvZpeb
	TvTShpLz/sueGLRjrWwZxyaJHGd5LEzWCNy6LTBKggOz4zqI56/jPk4fd7qOdz7QbUwmrAe
	7XKx+eNLbkbeAv+jg8ydsJAHXXYMZ2bJX15mqvP21iJFDgxlP+QWi1t2AuLkv84awfMrLep
	y/UgKJWlUbbiHc7f57L4L1LbgLM31r1ekWJytZBXzTVcctfP3jVo/MhgMq+0RDsG02INd/x
	asuS+e1LLeMOK7pPM1kz5TibfyT98ChpT5PvmZKQn/A2hN07QfaGJh9xBQLeReV+iU1W1qU
	/XYzIgfFRsNiaWO/6fS2hUtgPkMASHpKRd5i6oAwcsGyMM9wYAJREGoZAvaq6fztvRJb16N
	tEJrPG3hQRvvD1RQCMUTvSoLKZoRVfFDPAFNktxrS8jpw2GJBWgF6DLrxJbBaKqlwIquMOY
	A/UFHnIpDFeNOxE4aWvsqwwdO9BLzsOYpHCcFFn+Ziv7+MMoDHz7PDnbaDldsDiCa3n9iZn
	aey9wFNFMdpbqD3KFWp4Wl1WKCwjs4uDr7NEOH+k5BGBz/g=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303570-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[net-swift.com:mid,net-swift.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30C576EBE7C

This series improves ethtool support for Wangxun VF drivers
(ngbevf and txgbevf) in libwx.

This series extends VF support by enabling:
ring parameter configuration via ethtool -G
interrupt coalescing configuration via ethtool -C
per-queue statistics reporting via ethtool -S

Patch 1 adds support for set_ringparam in wx_ethtool_ops_vf,
allowing VF users to adjust TX/RX descriptor ring sizes.
Patch 2 enables set_coalesce support for VF devices and updates
EITR programming to use the VF-specific register access helper.
Patch 3 adds VF statistics support so ethtool -S can
report useful runtime counters for VF interfaces.

Changelog:
v6:
- Patch 1:
  Clarify comments describing wx_set_ring() failure semantics.
- Patch 2:
  Expand commit message to explain VF ITR encoding changes.
- Patch 3:
  Protect ring accesses in wx_update_stats().
v5: https://lore.kernel.org/all/20260615104849.60444-1-mengyuanlou@net-swift.com
- Patch 3:
  Convert WX_NUM_{RX,TX}_QUEUES macros to take explicit netdev parameter
  as suggested by Simon Horman.
v4: https://lore.kernel.org/all/20260608103946.25786-1-mengyuanlou@net-swift.com
  sashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529075147.88398-1-mengyuanlou%40net-swift.com
- Patch 2:
  PF and VF share the same ITR value range. Update wx_write_eitr_vf() to apply
  identical range clamping as the PF path, ensuring consistent coalesce behavior
  across both device types.
- Patch 3:
  Remove wx_update_stats in wxvf_down.
  Replace both WX_GLOBAL_STATS_LEN and WX_STATS_LEN macros with type-safe
  static helpers wx_global_stats_len() and wx_stats_len().
v3: https://lore.kernel.org/all/20260529075147.88398-1-mengyuanlou@net-swift.com
- Patch 3:
  Drop netdev_stat_ops support from this patch.
v2: https://lore.kernel.org/all/20260525101115.13151-1-mengyuanlou@net-swift.com
- Patch 3:
  Remove some stats which can be replaced by standard stats defined in
  include/net/netdev_queues.h.
- Patch 1:
  Adding a return value to wx_set_ring to make wx_set_ringparam_vf can
  be passed back to userspace.
  Remove freeing and requesting of IRQs. Ring resize only updates descriptor
  resources and does not change MSI-X vector or interrupt configuration,
  so IRQs do not need to be reallocated.
v1: https://lore.kernel.org/all/20260514103405.42175-1-mengyuanlou@net-swift.com



Mengyuan Lou (3):
  net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
  net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
  net: libwx: support vf per-queue statistics via ethtool -S

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 139 +++++++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   8 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |   1 -
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   6 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  13 +-
 8 files changed, 150 insertions(+), 32 deletions(-)

-- 
2.30.1


