Return-Path: <netdev+bounces-296479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YyASI+uiJmoyaQIAu9opvQ
	(envelope-from <netdev+bounces-296479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:09:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA293655838
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:09:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296479-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296479-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90CF310881B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F773B9D91;
	Mon,  8 Jun 2026 10:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4292F1FDF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915229; cv=none; b=QzHMi2ocCzPTHLl1T6g4U3yy6l5Gj5fNBBfG9BmMqWhMM4KZ+N/paYi0h+I061PCupXSIm0Qzn4LQyiqjuL2l/erq21hrgk/XXjJvoF+sxGK2qenJ0Bgrh1xa9RM8CqeNF+KWxTj5Df4SMqyL0MgJHiMXrVZdbcdj8vk4vTYj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915229; c=relaxed/simple;
	bh=pHb/ECYYE4vX0dgavYocmmN0ZoSJD6L3Y2SJU0sXJc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Os9RdYyGZh9QArp/UCp0fBKFt12DBBQ7fwCdX4G50wIhuprxA5KmEsNnx8utwTgc/9hs5a15K2+pdqvGIcN1XHXgWAR3qge8WxzIExSnDLPmmgpjYNI9o90HiFBlUhM3DwC4opnnStPF/OcvQ3hOVuJk4VqmsPBelG8mtqs0BuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: esmtpgz10t1780915189t4d0b3729
X-QQ-Originating-IP: lS65FxF7Sh6M6Z6L5hLzfgiBAIV5fqZ5VPH7LVLtLSA=
Received: from localhost.localdomain ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 18:39:47 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4187864515070242619
EX-QQ-RecipientCnt: 6
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4 0/3] net: libwx: improve VF ethtool support
Date: Mon,  8 Jun 2026 18:39:43 +0800
Message-Id: <20260608103946.25786-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N2VAmXEDAsCXyyZU7KLHGfUDs0DBhcAjQZ5gxwmWsAgmTlbH83/LiBlj
	85VEUkBTGKunCNQsbVlVAiWncohjgs3QDrj6FKdbs4M59vkU6nP5o1jXJL1ilEgMEohVaUh
	xKXNaV9q666+4GDLzhzFGQ/aQYXS3ZDH21xTAwx1iT53pRSqhncE6SnkWj0VN8s7ctGLMPr
	eJNQPNXyAT2wdX4xAKOfL+QoAN4iA3nLQcAuCMCSvriGvQj4+Dm6hvo42Z26CDn0rLlpeFb
	DaPnfXMSru7WozZAc7jiDPeOQEik76KNJhdHJkaeY3RUtIyJTelbgQ4DAbLG4NAPv8fKPlZ
	Ri8OUspxIW/3FeI7WkerYcpJebWfdyS7bQpOnQJ9CdIuB4ow/Pzg77F8R4hZVI0oDnnuE84
	ztJCqJvg/5rc4WDApoK/iidO27s5gBCDrShzYc+sUQS2P/iURZT8evzFMkvtyIoWZ3SH4hC
	cSyZdI/YqZAihGa788ghqzSAfPMN0T73FNUIOr+OpnhV3AAU7LxvRb4najGboiusgn9rDI9
	JGB43F7DRo5L9Jo7jcon7AR2WFWc1QLHcEklhvtKOXve7RkV6W5D0uQD3J+B3sTRa45ab0U
	oa//6azL/EviVteI1BrfM258tgB/PYbBci+cQNH0Xe6G/NyObjcMp/snLqjytIFUj25zkx4
	uDXDp3CvG74NzKLpFv6zGWeJF3AyVwjVYzzPTENXcPEelcPkOhwDYcaDUCkoQQMeTubtRj7
	EATKh73eQ6ihRrwss0shW02bBd98tDQk9g/YTJN3h6CReT7y05Uv+afxBtgbPmD5vb5NQFY
	Wl0FpD9LEWmWsn4zeu5tKAikptVGBOOheBvgQc2pUkS+F4QV29np5T2UiyO+l/MliGPneP4
	gLW/jJ7+T4QF6ntZzneU6WnwPaAVox0hdR+BdyvBZQ/4AtCmnW/zin8htPOHu7WzdxNzVLV
	qPe5MDlpugVJzvlEhC8i6sUzkBU3ZvQh21QLVf0H3xQR/Wk5UuSjjc3dmKfG2E92yEYQQ+y
	REfquJxPiowRdn/Wi9xN2y65EgxNpYq5boiDq3TYnigNJxLaAWBkzYe1boeudQjSl9FaBIa
	RAegrV9TJ0CtenAFsQtDhAjDdQr23FuRuqwHqT1PgZzdM8djTQmHBNUbr0Ezt0T9mn66xJz
	UC1WkwtQ1ACyMUKWJLx/X9w/bM7ixWhyMJ+JzCcBuLg0sZg=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296479-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,net-swift.com:from_mime,net-swift.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA293655838

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
v4:
  sashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529075147.88398-1-mengyuanlou%40net-swift.com
- Patch 2:
  PF and VF share the same ITR value range. Update wx_write_eitr_vf() to apply
  identical range clamping as the PF path, ensuring consistent coalesce behavior
  across both device types.
- Patch 3:
  Remove wx_update_stats in wxvf_down.
  Replace both WX_GLOBAL_STATS_LEN and WX_STATS_LEN macros with type-safe
  static inline helpers wx_global_stats_len() and wx_stats_len().
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

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 115 ++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   6 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  13 +-
 7 files changed, 133 insertions(+), 20 deletions(-)

-- 
2.30.1


