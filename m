Return-Path: <netdev+bounces-251009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA68D3A221
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C70F3016B97
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D62350A19;
	Mon, 19 Jan 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yXkZBPm6"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322533A008
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812838; cv=none; b=IY4ywOQZ1TV1GXnGCx4fl+Y294O9eYAa1WCgNHVSwdAA51pTKeuDLRESf092Uo44OIG56LbTo2l1CM3InQ+rukDPJKdXhj184VLzjURAhntUSBkL3T/qRk97NfrjCuRR8w2Ekk6R9gTswwNYx47rE0wKqPgOsL9RgagR75kPRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812838; c=relaxed/simple;
	bh=j3r8bzcoIb9S9vt3dJSwcWn14tR82FYfDNoA+Wixpdw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7IiCj0pR5AO+ROlAYJctwiLZnn0OITMjzUBkhBzV8SMrLJLCuj1YxdAuSv0yWOdr53eRbyaHfzb2HLJgRqZDjqjiECJL5kI+f+h0pM+3rKrS3ny+GJRrsOb4+jYA91jE5zyudbRKwqAgMuXwLyHTiZUWDgR1pW7YX0ZEpHkqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yXkZBPm6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B27A12074B;
	Mon, 19 Jan 2026 09:53:47 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TSF3xOPicpc; Mon, 19 Jan 2026 09:53:47 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 136EB206BC;
	Mon, 19 Jan 2026 09:53:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 136EB206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768812827;
	bh=S7J2Q2DVsmz2IG4AkVZrkXTcAJr3iwIbsOwyxzpVGyc=;
	h=From:To:CC:Subject:Date:From;
	b=yXkZBPm6YkmziWh1XPw5yYKt/etr5LYrFPsmvkcJxLprNGfenr2CPCcgPGf29yrsl
	 jx2FimK6/DaxTeJgpU/CxXh/Gu2eWjxijdAMnzoF5jbV+VINJA3zUVGMiK9swQA4cX
	 e89kq+lGv/oNut2DdQdl1DlUbjhR+Xpt8hbm6DXwdKZcHNYPK5D1q1M+LcIkIJDafd
	 ZF+1cinOy3TsXYuHCCvSlM7HoPr8dQWHTZDaZp5pKdGUrD0GVSjb4QG9CSAG/p79dB
	 raNLZuPJzaAKsJh37XGg1v9BC0i/cwWcBzAzIuEGb4fVjmLGl1Cv6ZBhKeDfpX8yIk
	 98IKAmPFIZABQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:53:46 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v4 0/5] xfrm: XFRM_MSG_MIGRATE_STATE new netlink message
Date: Mon, 19 Jan 2026 09:53:30 +0100
Message-ID: <cover.1768811736.git.antony.antony@secunet.com>
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


Ther current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
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
of a single SA via xfrm_usersa_d (including SPI) and we fix
encap removal in this patch set, reqid updates, address changes,
and other SA-specific parameters. It avoids the structural limitations
of XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
precise per-SA migration without involving policies.

New migration steps: first install block policy, remove the old policy,
call XFRM_MSG_MIGRATE_STATE for each state, then re-install the
policies and remove the block policy.

Antony Antony (5):
  xfrm: add missing __rcu annotation to nlsk
  xfrm: remove redundant assignments
  xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
  xfrm: rename reqid in xfrm_migrate
  xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
---
 include/net/netns/xfrm.h    |   2 +-
 include/net/xfrm.h          |   3 +-
 include/uapi/linux/xfrm.h   |  11 +++
 net/key/af_key.c            |  10 +--
 net/xfrm/xfrm_policy.c      |   5 +-
 net/xfrm/xfrm_state.c       |  34 ++++----
 net/xfrm/xfrm_user.c        | 163 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 8 files changed, 199 insertions(+), 32 deletions(-)

---
v1->v2: dropped 6/6. That check is already there where the func is called
    - merged patch 4/6 and 5/6, to fix use uninitialized value
    - fix commit messages

v2->v3: - fix commit message formatting

v3->v4: add patch to fix pre-existing missing __rcu annotation on nlsk
   (exposed by sparse when modifying xfrm_user.c)

-antony

