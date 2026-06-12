Return-Path: <netdev+bounces-298489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /VPoHHy6K2qNDQQAu9opvQ
	(envelope-from <netdev+bounces-298489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C29677707
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:51:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=NPsRpveq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298489-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298489-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F91E326BFA3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F83E074E;
	Fri, 12 Jun 2026 07:48:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07314368968
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250491; cv=none; b=GlrXiIjOT9M0sQa3Yh63t9iFs0nYW7UYuHZQTerwD96EMj1kf0+3QnkD3EClw9Fzq+JMYdcIAnyCqKlZLsRsavN9zhI6VSyZxBMJ8FtCTQ7JNY+mfDS5Ewt5T347GSbDTBKAcVVNqSy0M/30j1n8z8dMMOGITxMopXuvoYiBIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250491; c=relaxed/simple;
	bh=e7xQN+aK6VsPcOU1iXkgNzEwNdOSaol9lhpxHvh7DEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Za25h1JOn/lV62QoqYSUQjD5J3puYdAimv9EBeQYMg8+7rZeEm2taMEjV63JfGL4earOZMgumBFwX4bh5jjzSG8cyfiFVP4lTlHLgYOdyZI6WU1BojGoa/T6OlWfSZeallrKGHZJvikOrUHaVGiaZ0gDwkKdHGE2mqUJfVL6mNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NPsRpveq; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F0B2920754;
	Fri, 12 Jun 2026 09:47:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p3mIwG4ls5sV; Fri, 12 Jun 2026 09:47:59 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4AECD206D2;
	Fri, 12 Jun 2026 09:47:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4AECD206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250479;
	bh=dQiNXbe/qYtIyE2i97A+fUbJ10tuVbExydbw3R4fKZY=;
	h=From:To:CC:Subject:Date:From;
	b=NPsRpveqZcWEkqXNr9iqign3xUhPo87QmkHWmP59IjCnL9A2H1uMeYAG+28BR3k5n
	 Rl1TuRQ3rGF9p0APhhxA03jx1CBBeWAMOH4qYrGz5+KQAcfpfr2qFmL+Ee4xKGsqCX
	 duAPYUTx6NbKYcIKMT9U3QA8G9lUeKGdWCp2AH/QE1aiCZjowy0AlTICqVbUXpNbGo
	 rKeZWl05Wc8Xza7NSW2ClVvCpe/b/nsm50GWp6KYgT6iswnhJfUrab5fIR8lqAsZVu
	 F1DdVrVZYsrSDbpPGUmUHSSIPk2W8od6YIomju6pjhU/4CpnCw7ZnhVOtn2nYT2J3W
	 9+zaIOqecOtlw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:47:58 +0200
Received: (nullmailer pid 1768262 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Date: Fri, 12 Jun 2026 09:46:16 +0200
Message-ID: <20260612074725.1760473-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298489-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3C29677707

1) Replace the open-coded manual cleanup in xfrm_add_policy() error
   path with xfrm_policy_destroy() for consistency with
   xfrm_policy_construct().
   From Deepanshu Kartikey.

2) Limit XFRMA_TFCPAD to a sensible maximum (max IP length, 64k) since
   u32 is excessive for traffic flow confidentiality padding.
   From David Ahern.

3) Add a new netlink message XFRM_MSG_MIGRATE_STATE that
   allows migrating individual IPsec SAs independently of
   their policies. The existing XFRM_MSG_MIGRATE is tightly coupled
   to policy+SA migration, lacks SPI for unique SA identification,
   and cannot express reqid changes or migrate Transport mode
   selectors. The new interface identifies the SA via SPI and mark,
   supports reqid changes, address family changes, encap removal,
   and uses an atomic create+install flow under x->lock to prevent
   SN/IV reuse during AEAD SA migration.
   From Antony Antony.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 790ead9394860e7d70c5e0e50a35b243e909a618:

  Documentation: net/smc: correct old value of smcr_max_recv_wr (2026-04-27 16:49:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2026-06-12

for you to fetch changes up to 355f808d8a11fa69b19dfd8811bc87d97830f5d6:

  Merge branch 'xfrm: XFRM_MSG_MIGRATE_STATE new netlink message' (2026-06-09 16:02:12 +0200)

----------------------------------------------------------------
ipsec-next-2026-06-12

----------------------------------------------------------------
Antony Antony (16):
      xfrm: remove redundant assignments
      xfrm: add extack to xfrm_init_state
      xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
      xfrm: fix NAT-related field inheritance in SA migration
      xfrm: rename reqid in xfrm_migrate
      xfrm: split xfrm_state_migrate into create and install functions
      xfrm: check family before comparing addresses in migrate
      xfrm: add state synchronization after migration
      xfrm: add error messages to state migration
      xfrm: move encap and xuo into struct xfrm_migrate
      xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
      xfrm: extract address family and selector validation helpers
      xfrm: make xfrm_dev_state_add xuo parameter const
      xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
      xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
      xfrm: add documentation for XFRM_MSG_MIGRATE_STATE

David Ahern (1):
      xfrm: Reject excessive values for XFRMA_TFCPAD

Deepanshu Kartikey (1):
      xfrm: cleanup error path in xfrm_add_policy()

Steffen Klassert (1):
      Merge branch 'xfrm: XFRM_MSG_MIGRATE_STATE new netlink message'

 Documentation/networking/xfrm/index.rst            |   1 +
 .../networking/xfrm/xfrm_migrate_state.rst         | 274 ++++++++++++
 include/net/xfrm.h                                 |  78 +++-
 include/uapi/linux/xfrm.h                          |  25 ++
 net/ipv4/ipcomp.c                                  |   2 +-
 net/ipv6/ipcomp6.c                                 |   2 +-
 net/key/af_key.c                                   |  12 +-
 net/xfrm/xfrm_compat.c                             |   5 +-
 net/xfrm/xfrm_device.c                             |   2 +-
 net/xfrm/xfrm_policy.c                             |  25 +-
 net/xfrm/xfrm_state.c                              | 144 +++---
 net/xfrm/xfrm_user.c                               | 481 ++++++++++++++++++---
 security/selinux/nlmsgtab.c                        |   3 +-
 13 files changed, 912 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/networking/xfrm/xfrm_migrate_state.rst

