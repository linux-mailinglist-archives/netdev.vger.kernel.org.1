Return-Path: <netdev+bounces-191238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C151ABA748
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B9A1C025FD
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3F4B1E6D;
	Sat, 17 May 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDzInLFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A341367
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440812; cv=none; b=essh23ZTUfIeJ8aWLIdAMtFV/2jWl98hMKXRDBrbQ7jtgxc0eqsLceqrUaduYg05lGFu04jIY44eBK8V29VYFff11AZkrFeT7hrPuuGtGl+lnR8nGxwUgcmMd58gzmM07CnYbR0DDOW2zaCcrpzmdUmil5FLUcCaGw7It+62MHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440812; c=relaxed/simple;
	bh=ywe/mWO3qXBokoWp9AoI2bGcGK6FMJDO584l1VS44L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIMP3EF7JqC+mi75XsuFRBBo3M2DAj2AENtqKUImB70Pr4V8Wq3KDOOWAurswb7X8KuOr9i5+2UxPZ5nMEu2P1n7MfUjCikrjxftcdSQRK7iT7rvlGf2mIC0btu9kroUTfxTxSKyFH0nszi+NYHfmT/P4QrOiD6k748cnSc6e3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDzInLFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC11EC4CEE4;
	Sat, 17 May 2025 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440812;
	bh=ywe/mWO3qXBokoWp9AoI2bGcGK6FMJDO584l1VS44L8=;
	h=From:To:Cc:Subject:Date:From;
	b=qDzInLFDUd6FD44+ag05GyZMze4bHftD1Ribse1GCFyT3yz3WegkcKxoSwuktGcs7
	 hryDAz7aUHyiHnhkWhpKhbI4g7p6/bhuKeXdFdpHgkSwiT+8QwXftx3Y726XlEvRsn
	 dZWgFtEitf2A9ed6Vnh4K6qshkQhIuhKcmA7WQ3h+QB8gcN+JhGrfdyIYi8gDMWzpR
	 kdUqHf0lEhQtww1jZKj0FJb94bGHwM8B7LCdbQObuuGR1TqryT5GjpJGNhS5KRcivh
	 8KtaclBaNCNG1QKxqEJkBquwKSIdOsgILPQ6fRHRQvNdCRnmM+UhCqgcG1KNW2GKp7
	 b5Cgy+OFwF//w==
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
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/11] tools: ynl-gen: add support for "inherited" selector and therefore TC
Date: Fri, 16 May 2025 17:13:07 -0700
Message-ID: <20250517001318.285800-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add C codegen support for constructs needed by TC, namely passing
sub-message selector from a lower nest, and sub-messages with
fixed headers.

Jakub Kicinski (11):
  netlink: specs: tc: remove duplicate nests
  netlink: specs: tc: use tc-gact instead of tc-gen as struct name
  netlink: specs: tc: add C naming info
  netlink: specs: tc: drop the family name prefix from attrs
  tools: ynl-gen: support passing selector to a nest
  tools: ynl-gen: move fixed header info from RenderInfo to Struct
  tools: ynl-gen: support local attrs in _multi_parse
  tools: ynl-gen: support weird sub-message formats
  tools: ynl: enable codegen for TC
  netlink: specs: tc: add qdisc dump to TC spec
  tools: ynl: add a sample for TC

 Documentation/netlink/specs/tc.yaml | 514 +++++++++++++++-------------
 tools/net/ynl/Makefile.deps         |   2 +
 tools/net/ynl/generated/Makefile    |   2 +-
 tools/net/ynl/lib/ynl-priv.h        |   8 +-
 tools/net/ynl/samples/tc.c          |  80 +++++
 tools/net/ynl/pyynl/ynl_gen_c.py    | 171 +++++++--
 tools/net/ynl/samples/.gitignore    |   1 +
 7 files changed, 493 insertions(+), 285 deletions(-)
 create mode 100644 tools/net/ynl/samples/tc.c

-- 
2.49.0


