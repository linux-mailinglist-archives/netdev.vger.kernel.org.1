Return-Path: <netdev+bounces-190878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F147AB92BD
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516723B4205
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00B2206AC;
	Thu, 15 May 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBsbfVmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38020C009
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351027; cv=none; b=C2WfxDbWQZ0SBUyJ/ggSBBzhDDjylC04i6ZfjAakxdX7QkTdCccs2LigY9hEzaS8cpffWuos3lqOJ5dVX6K/W+Por2pdrGnwx66PFYO5poMkPAT5gvlGjajb97lagZNjkyLFRbhA2LBOpTQXQ6b/nbIJvPAuj6CrUMfoqVABB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351027; c=relaxed/simple;
	bh=rpx8DzzQvWKcRh3dEnX3oQwaPjlRsB1AMz3D544Jf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4q/uOYBU/uURkHh9bBcy2CN8Y6zqzIh+Eq1TH1MbULpAO5Qc2IcPeqyztGiC3/i/Elwh8+zoROEuq0+1sjoTSq9NLa1cVJNTKvHen4Ef6v7TmGWrjFUTCekpF6PzjjdUh2uksmshamT25fyjMQ5JYK/bJaBRlbPr2u5w9FcyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBsbfVmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA0AC4CEE7;
	Thu, 15 May 2025 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351026;
	bh=rpx8DzzQvWKcRh3dEnX3oQwaPjlRsB1AMz3D544Jf0A=;
	h=From:To:Cc:Subject:Date:From;
	b=WBsbfVmMTv/lWCQjGfvCWgBSUDrKyz652lWpiF4d/1vY7LTqtAOUv9f/ObWHPefOR
	 D0uxfLAa/H16ydXGaKrAqnJ+JfybE8pFsnN6jR9VC8woFKUCZPNCV4kk0DWB9mLmSJ
	 5/VmUPzGaqKNz7jdT1zXgAgH2PhF76K81jTmgYWtEqKuH+M8VXkKtWxSKrLDhNjnX0
	 n2K/jMHJTFltZ3ao0+LZb+b5p8FrlKCH2Pn4TXgbchtZtPL6NSibBisnqgLvPrXxKo
	 RvxTnvUh11u+/0tURpN5mCNO0zYboVyZQopLRRscVto5ZAMsPvNEeMdSe/WmX51mqc
	 Y983ufAPPMN3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/9] tools: ynl-gen: support sub-messages and rt-link
Date: Thu, 15 May 2025 16:16:41 -0700
Message-ID: <20250515231650.1325372-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-messages are how we express "polymorphism" in YNL. Donald added
the support to specs and Python a while back, support them in C, too.
Sub-message is a nest, but the interpretation of the attribute types
within that nest depends on a value of another attribute. For example
in rt-link the "kind" attribute contains the link type (veth, bonding,
etc.) and based on that the right enum has to be applied to interpret
link-specific attributes.

The last message is probably the most interesting to look at, as it
adds a fairly advanced sample.

This patch only contains enough support for rtnetlink, we will need
a little more complexity to support TC, where sub-messages may contain
fixed headers, and where the selector may be in a different nest than
the submessage.

Jakub Kicinski (9):
  netlink: specs: rt-link: add C naming info for ovpn
  tools: ynl-gen: factor out the annotation of pure nested struct
  tools: ynl-gen: prepare for submsg structs
  tools: ynl-gen: submsg: plumb thru an empty type
  tools: ynl-gen: submsg: render the structs
  tools: ynl-gen: submsg: support parsing and rendering sub-messages
  tools: ynl: submsg: reverse parse / error reporting
  tools: ynl: enable codegen for all rt- families
  tools: ynl: add a sample for rt-link

 Documentation/netlink/specs/rt-link.yaml |   4 +
 tools/net/ynl/Makefile.deps              |   4 +
 tools/net/ynl/generated/Makefile         |   7 +-
 tools/net/ynl/lib/ynl-priv.h             |   8 +-
 tools/net/ynl/lib/ynl.h                  |   1 +
 tools/net/ynl/lib/ynl.c                  |  93 +++++++-
 tools/net/ynl/samples/rt-link.c          | 184 +++++++++++++++
 tools/net/ynl/pyynl/lib/__init__.py      |   5 +-
 tools/net/ynl/pyynl/ynl_gen_c.py         | 272 +++++++++++++++++++----
 tools/net/ynl/samples/.gitignore         |   1 +
 10 files changed, 517 insertions(+), 62 deletions(-)
 create mode 100644 tools/net/ynl/samples/rt-link.c

-- 
2.49.0


