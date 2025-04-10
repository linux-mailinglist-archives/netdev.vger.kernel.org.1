Return-Path: <netdev+bounces-180987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7F7A835E5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B66464283
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6023596F;
	Thu, 10 Apr 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4wqLxkW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F2BA38
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249631; cv=none; b=rqINRyFnN8cTGtJzyTq4EyqCGqv0FTzUiZovD0oEFNVGFPODuqP2Sum01H9OT4LvO7XlWcOz0diGptkTl4GecrZT5DpQjtR92/dcoUOSfLH6Z2diH5HW+Uy9sOkoZKY9fjvpC95aEveH+spmM/CHOWh16FCfSCXIRIQR9LkbPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249631; c=relaxed/simple;
	bh=DMFKXAyaW0sajoTLfe/tA55sMOZodC6Ikr5XooZwJs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHswJQtYi9RgJAaZr0Ui4B9zmD4W/o1NR37FrWfXcLy+czAgOgP4VQRILaBD6BefgaXQFFTMBO4EeHrV303mnBEYFcOOJMmmShVPE9SGkTR7XUSyoyCOuqmHQoP4RUM9MzejzH0h7uCnnIPRqDMex5r+q2XoSZ9MSj2Z9su6AYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4wqLxkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4051BC4CEE2;
	Thu, 10 Apr 2025 01:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249630;
	bh=DMFKXAyaW0sajoTLfe/tA55sMOZodC6Ikr5XooZwJs0=;
	h=From:To:Cc:Subject:Date:From;
	b=l4wqLxkWQRRVwrubZ/PxCkKhLIfmhJXwHbaCiRtqU5vPRJ5J75XBBfIf/3BhKKEMA
	 b4nzRftxzPWvQlpnJdcThClbbALhkIA6Tg/5CziHVOkc7s//qUoY6RnKhw/vL6xhXA
	 RA1jdqDFZnAExNvN8LVZ756BX/TLo2U9ZcXtW86ZiCbDoBZ9BRyP4OUAIKIoVvbako
	 lWLwY6moolGYPtLdVSmA4dyVgKczfWf6mvlPO+7MTQgOQWvVDUgJCsgkxA2r/TbgPU
	 tAIIPPzgcYk0Njx7Me9omBXDD4AWa73DWBuapqTZfmnSi0SFNV1TXB/Xw8n9Z0nlVt
	 6SlUAWLAbJ/0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/13] tools: ynl: c: basic netlink-raw support
Date: Wed,  9 Apr 2025 18:46:45 -0700
Message-ID: <20250410014658.782120-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Basic support for netlink-raw AKA classic netlink in user space C codegen.
This series is enough to read routes and addresses from the kernel
(see the samples in patches 12 and 13).

Specs need to be slightly adjusted and decorated with the c naming info.

In terms of codegen this series includes just the basic plumbing required
to skip genlmsghdr and handle request types which may technically also
be legal in genetlink-legacy but are very uncommon there.

Subsequent series will add support for:
 - handling CRUD-style notifications
 - code gen for array types classic netlink uses
 - sub-message support

v2:
 - extend commit messages
 - [patch 10] fix typo in member name
 - [patch 12] remove unused arg
v1: https://lore.kernel.org/20250409000400.492371-1-kuba@kernel.org

Jakub Kicinski (13):
  netlink: specs: rename rtnetlink specs in accordance with family name
  netlink: specs: rt-route: specify fixed-header at operations level
  netlink: specs: rt-addr: remove the fixed members from attrs
  netlink: specs: rt-route: remove the fixed members from attrs
  netlink: specs: rt-addr: add C naming info
  netlink: specs: rt-route: add C naming info
  tools: ynl: support creating non-genl sockets
  tools: ynl-gen: don't consider requests with fixed hdr empty
  tools: ynl: don't use genlmsghdr in classic netlink
  tools: ynl-gen: consider dump ops without a do "type-consistent"
  tools: ynl-gen: use family c-name in notifications
  tools: ynl: generate code for rt-addr and add a sample
  tools: ynl: generate code for rt-route and add a sample

 .../specs/{rt_addr.yaml => rt-addr.yaml}      | 24 ++----
 .../specs/{rt_link.yaml => rt-link.yaml}      |  0
 .../specs/{rt_neigh.yaml => rt-neigh.yaml}    |  0
 .../specs/{rt_route.yaml => rt-route.yaml}    | 22 ++---
 .../specs/{rt_rule.yaml => rt-rule.yaml}      |  0
 .../userspace-api/netlink/netlink-raw.rst     |  2 +-
 tools/net/ynl/Makefile.deps                   |  2 +
 tools/net/ynl/generated/Makefile              |  2 +-
 tools/net/ynl/lib/ynl-priv.h                  |  3 +
 tools/net/ynl/lib/ynl.h                       |  3 +
 tools/net/ynl/lib/ynl.c                       | 59 +++++++++-----
 tools/net/ynl/samples/rt-addr.c               | 80 +++++++++++++++++++
 tools/net/ynl/samples/rt-route.c              | 80 +++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py              | 55 +++++++++----
 tools/net/ynl/samples/.gitignore              |  4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  4 +-
 16 files changed, 263 insertions(+), 77 deletions(-)
 rename Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml} (89%)
 rename Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml} (100%)
 rename Documentation/netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} (100%)
 rename Documentation/netlink/specs/{rt_route.yaml => rt-route.yaml} (93%)
 rename Documentation/netlink/specs/{rt_rule.yaml => rt-rule.yaml} (100%)
 create mode 100644 tools/net/ynl/samples/rt-addr.c
 create mode 100644 tools/net/ynl/samples/rt-route.c

-- 
2.49.0


