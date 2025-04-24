Return-Path: <netdev+bounces-185362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A71A99EA6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE10446516
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3517A318;
	Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfA1NiYH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3F2701BA
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460736; cv=none; b=HSzFvDTEVzGVjspMM8Js64dXSq4tf2+MtouGaIxErq4/c09r2/xwSmxYMIGHIbesvryqAWiG2HO+U/1DxAZEB115dgNQHgsc91GfgH938oL/A1eMW4fQdkKkaCMOyyORo7zzO1UbyONzygoXDGNObeQ/Q8Pew91TaTzTObmsn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460736; c=relaxed/simple;
	bh=cmTG6M7cbBN54FrMUG8iFDHEDNYiW4rO3er5F1lSPCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ih6zVtGHFRH0/to4s08CwuPl28IbR0EJcK9xxruZjZ+iC7oLFal8lvlBjJzCqTsbQQK6dBHjFAJ4MRZ/dDqGpIT236qY0EMA6iMBUj64CUUIPQ7WtCI/WTsF9JNpirff6IAqup+UEqU0vuN5Qvta3MNesjo+7aLZZeiH9BZxUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfA1NiYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D02FC4CEE2;
	Thu, 24 Apr 2025 02:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460735;
	bh=cmTG6M7cbBN54FrMUG8iFDHEDNYiW4rO3er5F1lSPCk=;
	h=From:To:Cc:Subject:Date:From;
	b=GfA1NiYHBP+BTFiH8zlYcTdKxYPOW11/yb9SPZqHlyoPK686ycSIf9ZEN4Gz33fTP
	 Fk+RHnOMoF38bou3DOVGBCOMDC1ZyzK0X1rP0AM/of0vRljj8DbtQWE4+KrWs2AYEE
	 Jr/DD7LVEUQWgSnS96LK+8p74Q0LUQi/Ij9zkicQDp6/zsHBa/+rA3C8VBLfJs5zmk
	 Xi3HdLhj9G5k2GL5b4utabSFHiApZ8AlrxCrx/FodwMtvi44cCj8gA3kCj9Ebk1xwD
	 64ZCIoXy5hbBTPfdiJWlw8shkbaO28g9XxGTRv8iSd1ukq4b+W6Qbx2QwEijiNC6Pu
	 AsNkdKbwtevqw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/12] tools: ynl-gen: additional C types and classic netlink handling
Date: Wed, 23 Apr 2025 19:11:55 -0700
Message-ID: <20250424021207.1167791-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a bit of a random grab bag adding things we need
to generate code for rt-link.

First two patches are pretty random code cleanups.

Patch 3 adds default values if the spec is missing them.

Patch 4 adds support for setting Netlink request flags
(NLM_F_CREATE, NLM_F_REPLACE etc.). Classic netlink uses those
quite a bit.

Patches 5 and 6 extend the notification handling for variations
used in classic netlink. Patch 6 adds support for when notification
ID is the same as the ID of the response message to GET.

Next 4 patches add support for handling a couple of complex types.
These are supported by the schema and Python but C code gen wasn't
there.

Patch 11 is a bit of a hack, it skips code related to kernel
policy generation, since we don't need it for classic netlink.

Patch 12 adds support for having different fixed headers per op.
Something we could avoid in previous rtnetlink specs but some
specs do mix.

Jakub Kicinski (12):
  tools: ynl-gen: fix comment about nested struct dict
  tools: ynl-gen: factor out free_needs_iter for a struct
  tools: ynl-gen: fill in missing empty attr lists
  tools: ynl: let classic netlink requests specify extra nlflags
  tools: ynl-gen: support using dump types for ntf
  tools: ynl-gen: support CRUD-like notifications for classic Netlink
  tools: ynl-gen: multi-attr: type gen for string
  tools: ynl-gen: mutli-attr: support binary types with struct
  tools: ynl-gen: array-nest: support put for scalar
  tools: ynl-gen: array-nest: support binary array with exact-len
  tools: ynl-gen: don't init enum checks for classic netlink
  tools: ynl: allow fixed-header to be specified per op

 tools/net/ynl/lib/ynl-priv.h     |   2 +-
 tools/net/ynl/lib/ynl.h          |  14 ++
 tools/net/ynl/lib/ynl.c          |  12 +-
 tools/net/ynl/pyynl/ynl_gen_c.py | 218 +++++++++++++++++++++++++------
 4 files changed, 198 insertions(+), 48 deletions(-)

-- 
2.49.0


