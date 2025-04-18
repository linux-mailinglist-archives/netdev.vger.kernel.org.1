Return-Path: <netdev+bounces-184042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E8A92FD1
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DC08A4548
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E5267724;
	Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezRnGdhb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6417C219
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942637; cv=none; b=dzEkRtzShaveiL6rz1vwbfF0Stv2CBa0QF3ZkczCxmpuIf3t3VaBCqKaJyq1QYS87Czr6cC4hzexA33NfPkknerkMbVwLrO+WcP285TKt4QxzUtcoORQo6JVHwUVQfSr/1ZSO5TmW27pHuhZ+J/0eWAFVu570wnDs467qorVwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942637; c=relaxed/simple;
	bh=844gHKcCxqwDPGUAY4ph/FoGZliJ/fi4SrUAAecxboY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRqGEj/sf0y6sdvfKoviylSgsiCJKQN07aqwXUJ1OvIwEatsn6SOg42Wjum2+xGwkN9ZAO6lOF0qRrMY1gaYlcYD19w+TdKsC9z1EKNKU/NeFLlM4cvmjJNEJVM9NvILVlFEJSkhdVwq7byfn7TBsgZHJKVl8XV2A8ew236fKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezRnGdhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4853C4CEEA;
	Fri, 18 Apr 2025 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942636;
	bh=844gHKcCxqwDPGUAY4ph/FoGZliJ/fi4SrUAAecxboY=;
	h=From:To:Cc:Subject:Date:From;
	b=ezRnGdhbCefVenBoXMkAAavESd2Bm5HUg5kuRZ/j7lhSXosmUiYMslsDn5NO/iNMM
	 pegUmsLLZ5tkELJSnfUDk6I0B09C0e0TI/2RbIRjP3g2nblokdTKcpcnSFjWR0jkLL
	 1d90Jm/q6ZVNqKJAHQyR5zrdD5LpepIwgT1mdgupgvS+TC1VCBgLdsMBk0J3WQfEke
	 Jhf9s55hmDqIqTJnfqD+e4+fqG8czxb8TC0nBUWaj0H7vwmZbi2ke8w+DgvqtFlG/H
	 XRrLiwYJ7zf36tTmkb2YBW5DRowWFfLlQssD4pLjk9Xzz7POXBNy+go/wjJat2YlN4
	 Qtq3pqNNUHAGg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/12] netlink: specs: rtnetlink: adjust specs for C codegen
Date: Thu, 17 Apr 2025 19:16:54 -0700
Message-ID: <20250418021706.1967583-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch brings a schema extension allowing specifying
"header" (as in .h file) properties in attribute sets.
This is used for rare cases where we carry attributes from
another family in a nest - we need to include the extra
headers. If we were to generate kernel code we'd also
need to skip it in the uAPI output.

The remaining 11 patches are pretty boring schema adjustments.

Jakub Kicinski (12):
  netlink: specs: allow header properties for attribute sets
  netlink: specs: rt-link: remove the fixed members from attrs
  netlink: specs: rt-link: remove if-netnsid from attr list
  netlink: specs: rt-link: remove duplicated group in attr list
  netlink: specs: rt-link: add C naming info
  netlink: specs: rt-link: adjust AF_ nest for C codegen
  netlink: specs: rt-link: make bond's ipv6 address attribute fixed size
  netlink: specs: rt-link: add notification for newlink
  netlink: specs: rt-neigh: add C naming info
  netlink: specs: rt-neigh: make sure getneigh is consistent
  netlink: specs: rtnetlink: correct notify properties
  netlink: specs: rt-rule: add C naming info

 Documentation/netlink/genetlink-c.yaml      |  3 +
 Documentation/netlink/genetlink-legacy.yaml |  3 +
 Documentation/netlink/netlink-raw.yaml      |  3 +
 Documentation/netlink/specs/rt-link.yaml    | 61 ++++++++++++++-------
 Documentation/netlink/specs/rt-neigh.yaml   | 12 +++-
 Documentation/netlink/specs/rt-rule.yaml    |  8 ++-
 tools/net/ynl/pyynl/ynl_gen_c.py            |  2 +-
 7 files changed, 69 insertions(+), 23 deletions(-)

-- 
2.49.0


