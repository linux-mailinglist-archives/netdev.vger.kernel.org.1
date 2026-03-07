Return-Path: <netdev+bounces-265047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XsHAHFGdq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:36:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB00229F47
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A337303D2CD
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E52D7D27;
	Sat,  7 Mar 2026 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgLjiEvd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58541281369
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854603; cv=none; b=nb3BWiKynrZ9xoRE5vkDRDtVRdnC+a4tRhZk/RuqyreZkMvV+prbf1blUCQmo7vOHazjryiWwqvhrKxO5xDDEZEtRUmhZilUx1jSZd07qZsupeDLl8zW2ljbIATBlrucKcmuAVEEH8vZ6gwHhIZNjbYK0ggbv6NRQ5IyjOFDOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854603; c=relaxed/simple;
	bh=P2/c4HUsSRxLdFwv8qd05MUthAhc/AJ/Ut2/iyCEJN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7Fs7ORyaZeGu5QNfBQBQhZvDSVQpGV5zE79Z78AVBdrh38P6H+Y4V9jOyJYkMM/QZ8FuQ+RiMOW0kldxwXoqQzNA3VmFQYht6Q7WOrvgUlXbDqt1fJyOSYlt88jypbmxDqMcxOH576pz+gWCBatfagQv9Kg8tQUGSGdJgPN8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgLjiEvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D80DC19422;
	Sat,  7 Mar 2026 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854603;
	bh=P2/c4HUsSRxLdFwv8qd05MUthAhc/AJ/Ut2/iyCEJN0=;
	h=From:To:Cc:Subject:Date:From;
	b=RgLjiEvd8sYHYwfIsg663cOuWqaSSOeV4u3BVZ6fllBxyvW0RC8aghp5KGrbGHNWE
	 3Edd7z1C3KrC0ZG+SW8HUNyxzOTWQ6t2XU1db1vELPlyQLcK8VuRQmwxaOAdayr6BK
	 R7Ha0TnLXHkxTLZbAAl/0XRJ2nDG8Hn+ye9UqQQujVEC/pN+nz9W84GqyFV8a7yVFo
	 YwVRb4woL+S3uAiCQhNJnPcmlRLzQe0yW7g5q8LWwLsq9hy6joH7+pU8hRTCOuMiSm
	 R1VoxuDdxyChyVxoMJCrqphfeBI3lukihOvkpmmDNnrwFvgkRYeF5tW3MYzkrpaO/t
	 QyoYlaYatO7Ew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/10] tools: ynl: convert samples into selftests
Date: Fri,  6 Mar 2026 19:36:20 -0800
Message-ID: <20260307033630.1396085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCB00229F47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265047-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The "samples" were always poor man's tests, used to manually
confirm that C YNL works as expected. Since a proper tests/
directory now exists move the samples and use the kselftest
harness to turn them into selftests outputting KTAP.

v2:
 - add missing ASSERTs on allocation failures
 - fix the exec in the bash wrappers preventing cleanup
v1: https://lore.kernel.org/20260306020901.524105-1-kuba@kernel.org

Jakub Kicinski (10):
  tools: ynl: move samples to tests
  tools: ynl: convert netdev sample to selftest
  tools: ynl: convert ovs sample to selftest
  tools: ynl: convert rt-link sample to selftest
  tools: ynl: convert tc and tc-filter-add samples to selftest
  tools: ynl: add netdevsim wrapper library for YNL tests
  tools: ynl: convert devlink sample to selftest
  tools: ynl: convert ethtool sample to selftest
  tools: ynl: convert rt-addr sample to selftest
  tools: ynl: convert rt-route sample to selftest

 tools/net/ynl/Makefile                      |   4 +-
 tools/net/ynl/samples/Makefile              |  36 --
 tools/net/ynl/tests/Makefile                |  70 +++-
 tools/net/ynl/samples/devlink.c             |  61 ---
 tools/net/ynl/samples/ethtool.c             |  65 ----
 tools/net/ynl/samples/netdev.c              | 128 ------
 tools/net/ynl/samples/ovs.c                 |  60 ---
 tools/net/ynl/samples/rt-addr.c             |  80 ----
 tools/net/ynl/samples/rt-link.c             | 184 ---------
 tools/net/ynl/samples/rt-route.c            |  80 ----
 tools/net/ynl/samples/tc-filter-add.c       | 335 ----------------
 tools/net/ynl/samples/tc.c                  |  80 ----
 tools/net/ynl/tests/devlink.c               | 101 +++++
 tools/net/ynl/tests/ethtool.c               |  92 +++++
 tools/net/ynl/tests/netdev.c                | 231 +++++++++++
 tools/net/ynl/tests/ovs.c                   | 108 ++++++
 tools/net/ynl/tests/rt-addr.c               | 111 ++++++
 tools/net/ynl/tests/rt-link.c               | 206 ++++++++++
 tools/net/ynl/tests/rt-route.c              | 113 ++++++
 tools/net/ynl/tests/tc.c                    | 409 ++++++++++++++++++++
 tools/net/ynl/{samples => tests}/.gitignore |   3 +-
 tools/net/ynl/tests/config                  |   8 +
 tools/net/ynl/tests/devlink.sh              |   5 +
 tools/net/ynl/tests/ethtool.sh              |   5 +
 tools/net/ynl/tests/rt-addr.sh              |   5 +
 tools/net/ynl/tests/rt-route.sh             |   5 +
 tools/net/ynl/tests/ynl_nsim_lib.sh         |  35 ++
 27 files changed, 1501 insertions(+), 1119 deletions(-)
 delete mode 100644 tools/net/ynl/samples/Makefile
 delete mode 100644 tools/net/ynl/samples/devlink.c
 delete mode 100644 tools/net/ynl/samples/ethtool.c
 delete mode 100644 tools/net/ynl/samples/netdev.c
 delete mode 100644 tools/net/ynl/samples/ovs.c
 delete mode 100644 tools/net/ynl/samples/rt-addr.c
 delete mode 100644 tools/net/ynl/samples/rt-link.c
 delete mode 100644 tools/net/ynl/samples/rt-route.c
 delete mode 100644 tools/net/ynl/samples/tc-filter-add.c
 delete mode 100644 tools/net/ynl/samples/tc.c
 create mode 100644 tools/net/ynl/tests/devlink.c
 create mode 100644 tools/net/ynl/tests/ethtool.c
 create mode 100644 tools/net/ynl/tests/netdev.c
 create mode 100644 tools/net/ynl/tests/ovs.c
 create mode 100644 tools/net/ynl/tests/rt-addr.c
 create mode 100644 tools/net/ynl/tests/rt-link.c
 create mode 100644 tools/net/ynl/tests/rt-route.c
 create mode 100644 tools/net/ynl/tests/tc.c
 rename tools/net/ynl/{samples => tests}/.gitignore (87%)
 create mode 100755 tools/net/ynl/tests/devlink.sh
 create mode 100755 tools/net/ynl/tests/ethtool.sh
 create mode 100755 tools/net/ynl/tests/rt-addr.sh
 create mode 100755 tools/net/ynl/tests/rt-route.sh
 create mode 100644 tools/net/ynl/tests/ynl_nsim_lib.sh

-- 
2.53.0


