Return-Path: <netdev+bounces-271468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BgMGDOpw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:21:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8993322153
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77FF303352B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C31352FA5;
	Wed, 25 Mar 2026 09:13:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B918345CD3;
	Wed, 25 Mar 2026 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430018; cv=none; b=TAdgF1cnEXdkR3aIMmlO3a6m5rEF/+hI3K5DZ6zoGsWe+xhd8PXP+8Fm6w/N3hlkl7Wk5AE8EfVnG0qlrxJFws60gRrLiod0+NnCsnRE0pS5SOrGceCTIve/YAVyfPfYjgkczTzKovlaocojjqH9UV09ZFFcLefER0P0YlsDMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430018; c=relaxed/simple;
	bh=HQT4kmLte2FA6Vq1NUhRZv5AfqORBcaUSyulASYLgKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lg9t3XRLGAiq+Ik4GXi9s7nEbcje7pj/uEqZnHtBhayitrPoxXcputq1vT6GUPFDRDEmMi3U02Ob+mffUDbJ2WBYkSoExf0xFPfHE+CHqS8AdgAEgNDUWw+MGRnwr+C4zgrIlvFL/vkuLpKAhNoFC4JRhGOKKAM7ARuyVGRVs44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz4t1774429932t80be807e
X-QQ-Originating-IP: HVchvQAP+d6pcBPMDfa9I97T9rtvY6iapgmEO8XzS9I=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Mar 2026 17:12:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7553183382821081949
EX-QQ-RecipientCnt: 9
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Wed, 25 Mar 2026 17:12:00 +0800
Message-Id: <20260325091204.94015-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OW4JKxETGMY2adAB6aEA6waznMi8Bu3n+vwWRoWPzZtwKlYxVxBan3A0
	YGXkjWhn/wU88uBTdPrNT1Qbfu5vXURZBEADV4ayjbnRa1WyrRNbotVtyBtAZo8EieA5JxC
	jeEZU5qgp7ZEh/Y2Su11TcKr2xiIYHYeYRVB2hzl4K5+z2cjYiE/mHXnXLiGGCGDuplanv9
	bb83IJ+M+KiSt7nKIvD7NCYn4qrPK+iROctZ5DBxLjSpnVU7Ytdl4iWEqVBsYVUR5lwKY1V
	rjmhP5S3FgIW+y/Ihea9Jd2HNJx8TWRLUzKY9aIM2/jwx4JFXjzDJGLU7n6B9KHyenkdwjp
	ueSC88bxD+l/cjRRm9RkzKpgq5H1o2EFui0uXex7RcHofXhWl7Q4U5nkej31S+lMtjGvL1o
	2peZn2kQYpFQnj5Gcz4tOZYT+sptZ3XlYPY765EcHkoBjFo+CGvj5PILKPyuRr20cV2Ppq6
	DdcdZi392AUYkp+Ja3GqQK1xKujdXYJpC0/Y4V+Ax1fyt1ZCgulqh0FZBwyAEKGddTibrBA
	JN6/KNh1Q6khw1YzqM1Vx6aWzrvHyKp/iLpqwD7ZIyAxpg/tZ1p0egxeFSf5WhiQp9YKVIp
	06UK/Yk3gXbk7pahu1Oq3nsc09rAfhQk4+2QTPvFVEf4ntJtHDMFzXXcWn5ZR6azf8UaCFf
	yd/6jaOWwJBFx8WrNmEdkK6WhxjQ2kGKChSLNjlHedje/1z5KSR2SvsdxbZBrMhVB3UeyYZ
	WNdnytavT7pRdRiCagvvTnQgDFlyZnP682lgRMnNpHkI9ObWCbKQc48nrCUcrv5/r3Z17oy
	l9OCQ5vKG3fFvgSGPm6ENw0jiu3r/SW1dxIMaSt4OToZWgrljMFgil6lzh6Uq1jv+dRNpK/
	2nloNPZPeFpqsYG+AaguI5pQUenxiWh/mHzXb6waMUJyeRFY3O6cutmn0Kw7F4kRRGWD5Jl
	qtfBp1n6/sMpnyOvSTP9acEfpqg02k+A+JUKuXX8toxRxx9IhLq5lGK0hgWZ44qJrW/Q6kT
	4HhWSp/Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mucse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8993322153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X/legacy interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Link status monitoring and carrier management

These changes enable the RNPGBE driver to support basic tx/rx network operations.

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  183 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   39 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 1917 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   90 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  103 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  165 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   47 +
 12 files changed, 2579 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1


