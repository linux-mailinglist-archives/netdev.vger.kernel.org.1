Return-Path: <netdev+bounces-268863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HXCKUAeuml8RwIAu9opvQ
	(envelope-from <netdev+bounces-268863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:38:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82A2B581E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 189363006D4D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520F3358BB;
	Wed, 18 Mar 2026 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1BwJLbh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D5243376;
	Wed, 18 Mar 2026 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805115; cv=none; b=s2HTBPY4KaD5MZCciLk7s53myWiHu6imuQ3DjKcrrSHvUG+wmTbY6AsZnaQEbyYROHBFevhTYPoeoHsLTULAiF6C2Sx/OWawEemYa//7qOZr3YietlhbT5Q3sRSStrdvJC8QglHTfXtuFZFreGUznVT8YnkkFeRE8pKWhVG7dZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805115; c=relaxed/simple;
	bh=urLLmCWUyE39H2r6PFvQyD+CopMB2sAs0N4OqyX9GIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYkGd7BVKu1E+8Uu2gSvxFL0M9sSdNB8x6vthDnE3b3rlBeje6huOkJWfwo+zLPQPSb7cCfviKdKLdKllCfRnTnQmWrpQKjYgxQ3RNtaRocF+aB9ysNae17IcalD7XcV3gGXdW5OBGje0e//ZSLHiuid4DyZeaCzrEcUPQqYNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1BwJLbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AE1C19421;
	Wed, 18 Mar 2026 03:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773805114;
	bh=urLLmCWUyE39H2r6PFvQyD+CopMB2sAs0N4OqyX9GIU=;
	h=From:To:Cc:Subject:Date:From;
	b=U1BwJLbh/630NR+DYeUasFl/uZfgdSARJ+cT4HiaT5xzsR9AVy2P37UM6mP/MF4MI
	 Nt1xlFuDRuExPLOQRcKDeOl14eE+kxpaxdKT8xhKXdPnaaiL4vx6FiWAGjsV+qFUH9
	 DFIxIJjvTbrXgHWCI59/yeHfMfOFGtT1RrArTIhi4aHDZW17gzbRax/w0nNBOyMHga
	 r7YWNge1rHka9DHKMnLRS6VAca11ufPleFe+vfqKsHv/68wQIrd7aAIWhgxRWunG6w
	 wVS/duCT07xVT4O6mvlnYqULy6pvkLCD+GYJXouS+zQhYapezo0xTQse7+9Ed9uLUh
	 QD5+aYcp5Go3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	mst@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 0/6] selftests: drv-net: driver tests for HW GRO
Date: Tue, 17 Mar 2026 20:38:13 -0700
Message-ID: <20260318033819.1469350-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-268863-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC82A2B581E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add tests for HW GRO stats, packet ordering and depth.

The ynltool and bnxt patches from v2 were applied separately.

v4:
 - [patch 6] rename [FAIL] -> [MISS]; NIPA thinks every [FAIL]
   means test failed, 'cause bash test don't ktap :/
v3: https://lore.kernel.org/20260316224505.279672-1-kuba@kernel.org
 - [patch 3] add a note about fq being needed
v2: https://lore.kernel.org/20260207003509.3927744-1-kuba@kernel.org
 - [patch 3] do not enable SO_TXTIME for multi-flow tests
 - [patch 6] move the test to cover SW GRO
v1: https://lore.kernel.org/20260205220541.2992807-1-kuba@kernel.org

Jakub Kicinski (6):
  selftests: net: move gro to lib for HW vs SW reuse
  selftests: drv-net: give HW stats sync time extra 25% of margin
  selftests: drv-net: gro: use SO_TXTIME to schedule packets together
  selftests: drv-net: gro: test GRO stats
  selftests: drv-net: gro: add test for packet ordering
  selftests: drv-net: gro: add a test for GRO depth

 tools/testing/selftests/drivers/net/Makefile  |   1 -
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/net/lib/Makefile      |   1 +
 .../selftests/{drivers/net => net/lib}/gro.c  | 252 ++++++++++++++-
 .../testing/selftests/drivers/net/.gitignore  |   1 -
 tools/testing/selftests/drivers/net/gro.py    | 203 ++++++++++--
 .../selftests/drivers/net/hw/gro_hw.py        | 294 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |   4 +-
 tools/testing/selftests/net/lib/.gitignore    |   1 +
 9 files changed, 728 insertions(+), 30 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/gro.c (86%)
 create mode 100755 tools/testing/selftests/drivers/net/hw/gro_hw.py

-- 
2.53.0


