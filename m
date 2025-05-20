Return-Path: <netdev+bounces-191953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F9ABE07C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415DE1885617
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE61AE875;
	Tue, 20 May 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2dbNTo1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559C4A06
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757963; cv=none; b=WCl0J3Bo1gaqN4M11o0DJAOddYcsNCk5x0y5BCV3y5229XmOUwQ8YkoV+SjNRLOTHzweFmrz7WKJqEYPGh29x/Ca+FDygqTgKhaaQqYGbZ9CFL08tZKGkAjH1nQMW8m5voGEybus3LXmxcl6R0/4P2I8shkANCILj4X0Mn/NnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757963; c=relaxed/simple;
	bh=qyko8M+DwWkXiFa9rBq9Z4beye64CDnfGvEkSN35Cpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVo8/iGsGLw3UTauIkU44ZAiBuAQDhQF3DvU02r753VoJdRx9ZKRbxjvcWLVk/xlSln9eB58dkrE0Z/bpFnzyM+2UDsuAN2J/UUHefoEbqTLlEnj9XLFNiXBvFKwMyOomI7klqGCi1yBJU/EouZ5AK9dX1zXO5jW+llZnAfTBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2dbNTo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F9C4CEE9;
	Tue, 20 May 2025 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757963;
	bh=qyko8M+DwWkXiFa9rBq9Z4beye64CDnfGvEkSN35Cpk=;
	h=From:To:Cc:Subject:Date:From;
	b=h2dbNTo1OmQYcwYQxSmDqhecuYMXkcsTHJZnKEXjiXcVd9GGvvp85SwFkR3NhMkiq
	 0+UXWdSga9dyZEa3eQ4rDvHmNoCF1yI1ECi3X0oSm7EDY69SCmSd3sXsXTFYjMq5bA
	 LTUL0JTGGfQx5k1YBlxS5hzDnFnR7LwqpisZlvmEInuHB6NYW8l1SZt3t3YGBAOtio
	 8MC7d+h/SSmM20nvpwuBCu0l6sr92lrF5hRqH3R50rVdVezotWVlgtc4Aqm5l7MMaN
	 T0/uDy/duI/XAevkyj0bc+Ehko7qbqEALkPEV5/ryzQUcxk7bMqmIWgCJXwMhaRyf1
	 e7WaccVvaR2Xg==
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
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/12] tools: ynl-gen: add support for "inherited" selector and therefore TC
Date: Tue, 20 May 2025 09:19:04 -0700
Message-ID: <20250520161916.413298-1-kuba@kernel.org>
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

v2:
 - [patch  1] new
 - [patch  8] small refactor
 - [patch 10] add more includes to build on Ubuntu 22.04 system headers

Jakub Kicinski (12):
  tools: ynl-gen: add makefile deps for neigh
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
 tools/net/ynl/Makefile.deps         |  10 +-
 tools/net/ynl/generated/Makefile    |   2 +-
 include/uapi/linux/neighbour.h      |   4 +-
 tools/net/ynl/lib/ynl-priv.h        |   8 +-
 tools/net/ynl/samples/tc.c          |  80 +++++
 tools/net/ynl/pyynl/ynl_gen_c.py    | 168 +++++++--
 tools/net/ynl/samples/.gitignore    |   1 +
 8 files changed, 500 insertions(+), 287 deletions(-)
 create mode 100644 tools/net/ynl/samples/tc.c

-- 
2.49.0


