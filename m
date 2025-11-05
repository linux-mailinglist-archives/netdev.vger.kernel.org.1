Return-Path: <netdev+bounces-235949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C37C37556
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 529B64E99D1
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926E340A63;
	Wed,  5 Nov 2025 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qKS1dZ9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11030337BA6;
	Wed,  5 Nov 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367587; cv=none; b=iwImAiGGyM3gt1mQeyvHlpqxtlSqFQ4Q118SpRNedglZHubMaRx9c9sg12idajcQExILUS+mn8rBaIztP7r9tY/vCMcLdxpL5+baVNolK8asjMCVw/3S2I4owiq7BkeqNdYkdS6vakSXx3tMDjVe9aKi0FBhiKbaUeKrBlW28Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367587; c=relaxed/simple;
	bh=W7UfEAgp8FNiK7ND+EnFtEt2/ra17VpFbW0P/KVydoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QP+2pu3I7rP8S7KdJCqsYAajHs03VKZiPW8+3+40M0LbaUVRSdrqRJJ97kQKQdug62uenyTd1d1aDLTbk4qjcg+48HItZLjukPa1zXikGXgxxsgno29xL7CDJV/2QxJFomx7LJmjqzWy6TPIf2SisaHvpJ5OUD/qDwedQ0nHA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qKS1dZ9R; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1762367571;
	bh=W7UfEAgp8FNiK7ND+EnFtEt2/ra17VpFbW0P/KVydoE=;
	h=From:To:Cc:Subject:Date:From;
	b=qKS1dZ9Rm4NBchh6eU8jAyLXN4SnlB35RJgq1OP4H89iSAq85kusv/sGki+QDqV7v
	 OQzIAmMFcYRmPkW+Vvt47IIGq6m760/IO07LFjHltqSBl2PpkZPJVW3ItqYlardJ9l
	 QEhArYR+gGjNNT87UB4X7b1fKequAKFZqlOhqMBIx4/OEhd7fFUl4CpPOyEcUVwAUw
	 gFJIlTlnH++T0nNMyXre/gXzoiCG0bFvRJmMK7RMEr5WiZd+UOn1Kz65KhaXUgNFGH
	 gB0BEFvb80dy9Ve0PdQoG+2j+C/206RTfyP/+BWCqafD9CmWyEcwTUSsGkuZha4vci
	 QI6cuWN3xqkJA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3CD5560104;
	Wed,  5 Nov 2025 18:32:47 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 112F7205059; Wed, 05 Nov 2025 18:32:25 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH net-next v3 00/11] wireguard: netlink: ynl conversion
Date: Wed,  5 Nov 2025 18:32:09 +0000
Message-ID: <20251105183223.89913-1-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series completes the implementation of YNL for wireguard,
as previously announced[1].

This series consist of 5 parts:
1) Patch 01-03 - Misc. changes
2) Patch    04 - Add YNL specification for wireguard
3) Patch 05-07 - Transition to a generated UAPI header
4) Patch    08 - Adds a sample program for the generated C library
5) Patch 09-11 - Transition to generated netlink policy code

The main benefit of having a YNL specification is unlocked after the
first 2 parts, the RFC version seems to already have spawned a new
Rust netlink binding[2] using wireguard as it's main example.

Part 3 and 5 validates that the specification is complete and aligned,
the generated code might have a few warts, but they don't matter too
much, and are mostly a transitional problem[3].

Part 4 is possible after part 2, but is ordered after part 3,
as it needs to duplicate the UAPI header in tools/include.

For the non-generated kernel C code the diff stat looks like this:

$ git diff --stat net-next/main..wg-ynl include/ drivers/ \
	':(exclude)*netlink_gen*'
 drivers/net/wireguard/Makefile  |   1 +
 drivers/net/wireguard/netlink.c |  70 +++---------
 include/uapi/linux/wireguard.h  | 190 ++++++--------------------------
 3 files changed, 47 insertions(+), 214 deletions(-)

[1] [PATCH net 0/4] tools: ynl-gen: misc fixes + wireguard ynl plan
    https://lore.kernel.org/r/20250901145034.525518-1-ast@fiberby.net/

[2] https://github.com/one-d-wide/netlink-bindings/

[3] https://lore.kernel.org/r/20251014123201.6ecfd146@kernel.org/

---
v3:
- Spec: Make flags-mask checks implicit (thanks Jakub).
- Sample: Add header to Makefile.deps, and avoid copy (thanks Jakub).

v2: https://lore.kernel.org/r/20251031160539.1701943-1-ast@fiberby.net/
- Add missing forward declaration

v1: https://lore.kernel.org/r/20251029205123.286115-1-ast@fiberby.net/
- Policy arguement to nla_parse_nested() changed to NULL (thanks Johannes).
- Added attr-cnt-name to the spec, to reduce the diff a bit.
- Refined the doc in the spec a bit.
- Reword commit messages a bit.
- Reordered the patches, and reduced the series from 14 to 11 patches.

RFC: https://lore.kernel.org/r/20250904-wg-ynl-rfc@fiberby.net/

Asbjørn Sloth Tønnesen (11):
  wireguard: netlink: validate nested arrays in policy
  wireguard: netlink: use WG_KEY_LEN in policies
  wireguard: netlink: enable strict genetlink validation
  netlink: specs: add specification for wireguard
  uapi: wireguard: move enum wg_cmd
  uapi: wireguard: move flag enums
  uapi: wireguard: generate header with ynl-gen
  tools: ynl: add sample for wireguard
  wireguard: netlink: convert to split ops
  wireguard: netlink: rename netlink handlers
  wireguard: netlink: generate netlink code

 Documentation/netlink/specs/wireguard.yaml | 301 +++++++++++++++++++++
 MAINTAINERS                                |   2 +
 drivers/net/wireguard/Makefile             |   1 +
 drivers/net/wireguard/netlink.c            |  70 +----
 drivers/net/wireguard/netlink_gen.c        |  77 ++++++
 drivers/net/wireguard/netlink_gen.h        |  29 ++
 include/uapi/linux/wireguard.h             | 190 +++----------
 tools/net/ynl/Makefile.deps                |   2 +
 tools/net/ynl/samples/.gitignore           |   1 +
 tools/net/ynl/samples/wireguard.c          | 104 +++++++
 10 files changed, 563 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/netlink/specs/wireguard.yaml
 create mode 100644 drivers/net/wireguard/netlink_gen.c
 create mode 100644 drivers/net/wireguard/netlink_gen.h
 create mode 100644 tools/net/ynl/samples/wireguard.c

-- 
2.51.0


