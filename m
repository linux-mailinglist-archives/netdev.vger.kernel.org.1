Return-Path: <netdev+bounces-257664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BK7mHMeIhmmOOgQAu9opvQ
	(envelope-from <netdev+bounces-257664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE171044D3
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D4C3018752
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E21A9F8C;
	Sat,  7 Feb 2026 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSV0kDyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AD433B3;
	Sat,  7 Feb 2026 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424515; cv=none; b=Kjmzlnh4QkQIOD8ypDs85cdGF9BqLk30Ri3EnaSaA3HOxFP4G5eMGW5wCepbIB7CvOpi2UsnWTfA7YY3phK1gXvhqX5lDiL7bqHb9tGegkX0MKKRujC56Q4+rnrT3G/pvZ9SBR8oYiXwBJEUCaeQ+1zumVQe9EH06UoZhtIDBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424515; c=relaxed/simple;
	bh=FPWGl3nSy7e+hceX7wQr77zr0Z1byxYaxqUaPyY+Yt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5px3aRfPGxWZfxLNjrBBao72EbUQMXXuJ1o2CeUQgDASDxAj4z5p++513xOq6Y5DVuaVR1PTrgqCGIBf3MpUVf7EYE0kHok38qjScRY0mHFSUSpfm292sr/N0do/xOwl+ZzWTzCII6CK7tO7srPssOoohB90xs940SKPD5Fr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSV0kDyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F87C116C6;
	Sat,  7 Feb 2026 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424515;
	bh=FPWGl3nSy7e+hceX7wQr77zr0Z1byxYaxqUaPyY+Yt4=;
	h=From:To:Cc:Subject:Date:From;
	b=dSV0kDyyfjuh2aZQV142qlLiE27QQbmBtSF7WI5TZLOdav2/mwtoa7E4TwJd8V5LK
	 djaAbV6EciVpPm4h3p11UjcX4cNyHQJFSYTBMwgMK1i4HV7lOW0uChfgU2LwajFRhK
	 iMTA2l+S397QqT5yY10pKMijiqHYnZdt53NDxUNPDjLJv5eDkp3H/NG3SA6haZ/P8I
	 rYVFG4Wxbu0PFChmyf/Pb1latzqnDIeixtdYMxNEtY1GDPxeZGnoKQc09yeV7HZvlS
	 k39SAL2ZV4BJ1yvHzUte8l/0Wx6ysrAY1+2Jaz030NuR/0yuraQKuu6RV/w0uN8eja
	 oA6SGYbFZG3WA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/9] net: stats, tools, driver tests for HW GRO
Date: Fri,  6 Feb 2026 16:35:00 -0800
Message-ID: <20260207003509.3927744-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257664-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBE171044D3
X-Rspamd-Action: no action

Add miscellaneous pieces related to production use of HW-GRO:
 - report standard stats from drivers (bnxt included here,
   Gal recently posted patches for mlx5 which is great)
 - CLI tool for calculating HW GRO savings / effectiveness
 - tests for the stats, packet ordering and depth

v2:
 - [patch 1] fix ethtool -S and unnecessary feature check
 - [patch 3] use %1$s
 - [patch 6] do not enable SO_TXTIME for multi-flow tests
 - [patch 9] move the test to cover SW GRO
v1: https://lore.kernel.org/20260205220541.2992807-1-kuba@kernel.org

Jakub Kicinski (9):
  eth: bnxt: gather and report HW-GRO stats
  tools: ynltool: factor out qstat dumping
  tools: ynltool: add qstats analysis for HW-GRO efficiency / savings
  selftests: net: move gro to lib for HW vs SW reuse
  selftests: drv-net: give HW stats sync time extra 25% of margin
  selftests: drv-net: gro: use SO_TXTIME to schedule packets together
  selftests: drv-net: gro: test GRO stats
  selftests: drv-net: gro: add test for packet ordering
  selftests: drv-net: gro: add a test for GRO depth

 tools/testing/selftests/drivers/net/Makefile  |   1 -
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/net/lib/Makefile      |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  15 +-
 tools/net/ynl/ynltool/qstats.c                | 171 ++++++----
 .../selftests/{drivers/net => net/lib}/gro.c  | 252 ++++++++++++++-
 .../testing/selftests/drivers/net/.gitignore  |   1 -
 tools/testing/selftests/drivers/net/gro.py    | 203 ++++++++++--
 .../selftests/drivers/net/hw/gro_hw.py        | 294 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |   4 +-
 tools/testing/selftests/net/lib/.gitignore    |   1 +
 12 files changed, 859 insertions(+), 91 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/gro.c (86%)
 create mode 100755 tools/testing/selftests/drivers/net/hw/gro_hw.py

-- 
2.53.0


