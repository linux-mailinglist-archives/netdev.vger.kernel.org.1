Return-Path: <netdev+bounces-250735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08622D390B9
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 21:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8646F3011404
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD04C28C5AA;
	Sat, 17 Jan 2026 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="k2AgYhTA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66902C0285
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680317; cv=none; b=W51xEbI4XPR19q1S1ktGUEFWTxGcZNirloiPV8T6hnDVNa4nRjILQ84j47tdleu7rgpHYB6E1S6TxvS10Ic5kR1+Y4XDJhorYlkYvVKtPB+bM5f5fro0FsyAKydaUYWVPfviPI40bQdiUA+56pCklwXliyFiI97fkyG6Ld/SABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680317; c=relaxed/simple;
	bh=n2LVIKE8ZiR9aYmjZerRzi9yBOiJUQKGPSysXwqGtJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9O3I2bX4PckWzGW+j0D/G6Yk7VMvZ6NetWK3M4JMcdMmW9D9fA34JCuVfFnCmglMZfcQTnz9U77is6oRlNGU6ynJIvj5zl90EnvNqLS9qJtq1I8UgXbTMYcgOY3aF0Nw6p4lLUWONyDWZf5DmycEFDSwM+JxDPF9wd47l2Rb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=k2AgYhTA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0B1BC207BB;
	Sat, 17 Jan 2026 21:05:14 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4AvGca9VE5W; Sat, 17 Jan 2026 21:05:13 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6BE9F20799;
	Sat, 17 Jan 2026 21:05:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6BE9F20799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768680313;
	bh=r3hAE2A+zDdOJDJFW4KMv77chLumUwpJhoZC9biMaO0=;
	h=From:To:CC:Subject:Date:From;
	b=k2AgYhTASuzGiCQRf5eGAoNQcg3SOo0gbdOkYWe+TMRC7KT8SKrDYJ5TTNbun9ub2
	 JV2+x7dyINbNQFv29HoB3myIA/7LxSD9al+dxajrf9dJMrsDe92TZn6AkCk1a8ezJv
	 Flx/9+Qts2RTNB/gFyfXavYwJKKYlg9LfoFZ8jMo+Pgp98FWn0DM5QmNhzXsXcnqwX
	 m/tQ+T3NIbdO7SVhdah/xd2BWMdeTIZl3JW117ifi7AGZ6F7AmeIrgECPN4CxlxQFK
	 jtf71G0YInEDP07lZtj3Zb0gznYb84zSkdzlK97DXUFUhvBKIZ7/ZSzahmhcBPU5XH
	 B6TSjNIs9GTYg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 17 Jan
 2026 21:05:12 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v2 0/4] xfrm: XFRM_MSG_MIGRATE_STATE new netlink message
Date: Sat, 17 Jan 2026 21:04:56 +0100
Message-ID: <cover.1768679141.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

The current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
SA migration, and it lacks the information required to reliably migrate
individual SAs. This makes it unsuitable for IKEv2 deployments,
dual-stack setups (IPv4/IPv6), and scenarios where policies are managed
externally (e.g., by other daemons than IKE daemon).

Mandatory SA selector list
The current API requires a non-empty SA selector list, which does not
reflect IKEv2 use case.
A single Child SA may correspond to multiple policies,
and SA discovery already occurs via address and reqid matching. With
dual-stack Child SAs this leads to excessive churn: the current method
would have to be called up to six times (in/out/fwd × v4/v6) on SA,
while the new method only requires two calls.

Selectors lack SPI (and marks)
XFRM_MSG_MIGRATE cannot uniquely identify an SA when multiple SAs share
the same policies (per-CPU SAs, SELinux label-based SAs, etc.). Without
the SPI, the kernel may update the wrong SA instance.

Reqid cannot be changed
Some implementations allocate reqids based on traffic selectors. In
host-to-host or selector-changing scenarios, the reqid must change,
which the current API cannot express.

Because strongSwan and other implementations manage policies
independently of the kernel, an interface that updates only a specific
SA - with complete and unambiguous identification - is required.

XFRM_MSG_MIGRATE_STATE provides that interface. It supports migration
of a single SA via xfrm_usersa_id (including SPI) and we fix
encap removal in this patch set, reqid updates, address changes,
and other SA-specific parameters. It avoids the structural limitations
of XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
precise per-SA migration without involving policies.

New migration steps: first install block policy, remove the old policy,
call XFRM_MSG_MIGRATE_STATE for each state, then re-install the
policies and remove the block policy.

Antony Antony (4):
  xfrm: remove redundant assignments
  xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
  xfrm: rename reqid in xfrm_migrate
  xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration

 include/net/xfrm.h          |   3 +-
 include/uapi/linux/xfrm.h   |  11 +++
 net/key/af_key.c            |  10 +--
 net/xfrm/xfrm_policy.c      |   4 +-
 net/xfrm/xfrm_state.c       |  34 +++-----
 net/xfrm/xfrm_user.c        | 164 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 7 files changed, 198 insertions(+), 31 deletions(-)

---
v1->v2: dropped 6/6. That check is already there where the func is called
	- merged patch 4/6 and 5/6, to fix use uninitialized value
	- fix commit messages
v2->v3: fix commit message
	- fixes to error path
---
-antony

