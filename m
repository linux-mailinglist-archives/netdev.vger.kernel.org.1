Return-Path: <netdev+bounces-200837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F3AE714E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B11B17ACD8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14567252900;
	Tue, 24 Jun 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sotCIcEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFC3074B5
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799407; cv=none; b=SBDqY3eXSRXdptctXqt8hQ0EjyzOrtb1P1JIQPdbnuVVbpHDEIbvACzM6HtJTlrE1LHlhJ3eOMPNmv0aY5xvb8RLULURZQH65MLJWcGoCpcdJHhTad4Z6Y/c4nWliadriL6vcHIaDTLvuUZYaedlrHYICRFAhp+zEpSJG+paEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799407; c=relaxed/simple;
	bh=K0qbAvMA7VUS6VnVpl0pSa07/9Qw9KplOj8/Roc2TGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIG0vCIlQRNI8DHwnDLbDFrRAPweYaGVfZX1IPWrsLxcr1G9Eow9ZTBPXpxecAn4Yhm4LQKzfuW5RbeFt+DcJiCIZTSk2N+KStH/DgSdEBYyrJCVTMsN1wP3IPu566AAVy7rbrtghaMJriZjAwiOCcHWF9kxI0kgV+GHBHvr/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sotCIcEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C30AC4CEEF;
	Tue, 24 Jun 2025 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799406;
	bh=K0qbAvMA7VUS6VnVpl0pSa07/9Qw9KplOj8/Roc2TGo=;
	h=From:To:Cc:Subject:Date:From;
	b=sotCIcElX5FTAt7KLOnjzXXzTp+jACId3kQdwfKvnbx2cY6Rin16Phxui+zz96vhD
	 slnzI0zMWLi4rmVGoUvj6erbUqq2EIo5CHngfApLn/YdADb6aGwCNP7/i4V+0Nuykt
	 s2RoydYVC8wn/UdbtWJCF5Zvxgcxlb4kjgzKNYbEP9pIYsgrwH+VTgzrrRzcMIiv95
	 4VKZkI4VU9oWFBS4JfLSUNHl5BMw9c3HyHxT+FL4CyIzyyv8JlQoh6ECqXx16cXGdK
	 4uoTWUIIsOQrIsCvEyD9Z7h7267TlLDb2LMtKLWuNLu8kDdExbtt6nvGrpr52Rr1wd
	 jtJCrxRxDKyyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 00/10] netlink: specs: enforce strict naming of properties
Date: Tue, 24 Jun 2025 14:09:52 -0700
Message-ID: <20250624211002.3475021-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got annoyed once again by the name properties in the ethtool spec
which use underscore instead of dash. I previously assumed that there
is a lot of such properties in the specs so fixing them now would
be near impossible. On a closer look, however, I only found 22
(rough grep suggests we have ~4.8k names in the specs, so bad ones
are just 0.46%).

Add a regex to the JSON schema to enforce the naming, fix the few
bad names. I was hoping we could start enforcing this from newer
families, but there's no correlation between the protocol and the
number of errors. If anything classic netlink has more recently
added specs so it has fewer errors.

The regex is just for name properties which will end up visible
to the user (in Python or YNL CLI). I left the c-name properties
alone, those don't matter as much. C codegen rewrites them, anyway.

I'm not updating the spec for genetlink-c. Looks like it has no
users, new families use genetlink, all old ones need genetlink-legacy.
If these patches are merged I will remove genetlink-c completely
in net-next.

Jakub Kicinski (10):
  netlink: specs: nfsd: replace underscores with dashes in names
  netlink: specs: fou: replace underscores with dashes in names
  netlink: specs: ethtool: replace underscores with dashes in names
  netlink: specs: dpll: replace underscores with dashes in names
  netlink: specs: devlink: replace underscores with dashes in names
  netlink: specs: ovs_flow: replace underscores with dashes in names
  netlink: specs: mptcp: replace underscores with dashes in names
  netlink: specs: rt-link: replace underscores with dashes in names
  netlink: specs: tc: replace underscores with dashes in names
  netlink: specs: enforce strict naming of properties

 Documentation/netlink/genetlink-legacy.yaml   | 15 ++++----
 Documentation/netlink/genetlink.yaml          | 17 +++++----
 Documentation/netlink/netlink-raw.yaml        | 18 ++++++----
 Documentation/netlink/specs/devlink.yaml      |  8 ++---
 Documentation/netlink/specs/dpll.yaml         |  2 +-
 Documentation/netlink/specs/ethtool.yaml      |  6 ++--
 Documentation/netlink/specs/fou.yaml          | 36 +++++++++----------
 Documentation/netlink/specs/mptcp_pm.yaml     |  8 ++---
 Documentation/netlink/specs/nfsd.yaml         |  4 +--
 Documentation/netlink/specs/ovs_flow.yaml     |  6 ++--
 Documentation/netlink/specs/rt-link.yaml      |  4 +--
 Documentation/netlink/specs/tc.yaml           |  4 +--
 include/uapi/linux/mptcp_pm.h                 |  6 ++--
 .../drivers/net/hw/rss_input_xfrm.py          |  2 +-
 14 files changed, 74 insertions(+), 62 deletions(-)

-- 
2.49.0


