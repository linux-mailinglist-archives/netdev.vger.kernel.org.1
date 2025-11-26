Return-Path: <netdev+bounces-241969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25089C8B374
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A04263599FB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C430C375;
	Wed, 26 Nov 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Su4mr0Wt"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1E27B50C;
	Wed, 26 Nov 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178597; cv=none; b=DfIkodOR2bGNY9oPDyQfV8R1f+l0NFyXuavJxXkHVS0a46x4GgCH/6Sy5gIwkAQ92uP3xAo/oBjz2ohOB8e0VhoUQ+cOErPXTWrydacLgcIfqaAQ7ox3NWMGPO6mt7/fPnik/rwjd17GQ4aozwggZbqJPrBMUIw3Zes07QqrTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178597; c=relaxed/simple;
	bh=4bpyYL4L6gz/OKVZlnX7lgUv1PqQBtx9ZM60vTVrZcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sICkHrHlfJ9MtpkUQ7O7YGlDSmDa1qowcSdzeMudOJ4LkwJ5Z7XAeIzd8b9d+VDwHHXBuRzCbTaYiQEcJb0rAfd+ZPHlyIJo0v3mWxr80bp8C7RxWJKkv+RIggmlZtHNWRk/XNeRK9uV6tp0mdBV8NfgWasVfKxDnzxAFEC4ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Su4mr0Wt; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=4bpyYL4L6gz/OKVZlnX7lgUv1PqQBtx9ZM60vTVrZcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Su4mr0Wtr+9gSNdIKygw2WgcVQbyq21L665npJhtCEcDg2Y6CsdUtdhhYLEX0RMRr
	 ho5xOsAoaEQ8zkw4zzVxiBU2dkVaJBY8ChztPKmNkdXzFalxnyL8Sq8CxO+38M4TK8
	 tQ1mGBlemkXnEa2/I/l6Iol6ijI12HNiGhiPIabtwCKXj3EsZQos1yp+O6ay0nA1Qg
	 juxexsHSw7K04wy3CxeUm7ltTNNUj+XzpXL9Rfs8zErLAYNXrXFx0+AZvf3W8Ht/KO
	 Ufpmxyk63Scr7q/LhQ27HwrIuadbQ/DFxn2QmVy3andTnG35sfmL20FIyGr7cBHL89
	 tGgZR0ZpOOMjQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 35D0F60103;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BA42C201DE3; Wed, 26 Nov 2025 17:35:48 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 00/10] wireguard: netlink: ynl conversion
Date: Wed, 26 Nov 2025 17:35:32 +0000
Message-ID: <20251126173546.57681-1-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series completes the implementation of YNL for WireGuard,
as previously announced[1].

This series consist of 5 parts:
1) Patch 01-04 - Misc. changes
2) Patch    05 - Add YNL specification for wireguard
3) Patch 06-08 - Transition to a generated UAPI header
4) Patch    09 - Adds a sample program for the generated C library
5) Patch    10 - Transition to generated netlink policy code

The main benefit of having a YNL specification is unlocked after the
first 2 parts, the RFC version seems to already have spawned a new
Rust netlink binding[2] using wireguard as it's main example.

Part 3 and 5 validates that the specification is complete and aligned,
the generated code might have a few warts, but they don't matter too
much, and are mostly a transitional problem[3].

Part 4 is possible after part 2, but is ordered after part 3,
as it would otherwise have to update the header guard in Makefile.deps.

For the UAPI and non-generated kernel C code the diff stat looks like this:

$ git diff --stat wg-devel..wg-ynl include/ drivers/ \
	':(exclude)*generated/*'
 drivers/net/wireguard/Makefile  |   2 +-
 drivers/net/wireguard/netlink.c |  67 +++---------
 include/uapi/linux/wireguard.h  | 191 ++++++--------------------------
 3 files changed, 46 insertions(+), 214 deletions(-)

[1] [PATCH net 0/4] tools: ynl-gen: misc fixes + wireguard ynl plan
    https://lore.kernel.org/r/20250901145034.525518-1-ast@fiberby.net/
[2] https://github.com/one-d-wide/netlink-bindings/
[3] https://lore.kernel.org/r/20251014123201.6ecfd146@kernel.org/

---
v4:
- Thanks Jason and Jakub for all the feedback.
- Old patch 03 has been accepted into Jason's tree.
- Old patch 09 split_ops conversion has been moved to new 03.
- Old patch 10 function renaming was merged into old patch 11 (new 10).
- Patch 04 has been added to adjust .maxattr for GET_DEVICE.
- The old patches 04-08 and 11 was renumbered to patch 05-10.
- Changes to the spec:
  - Re-wrap the documentation lines in the spec.
  - Reword the index/type documentation.
  - get-device now have a more strict request attribute list.
  - The pre/post functions now avoids renaming.
- Changes to patch 10 (was 10+11):
  - The generated kernel code now uses YNL-ARG --function-prefix,
    to reduce the function renaming.
  - The generated files have been moved to their own sub-directory.
- The commit messages have in general been tweaked a bit.

v3: https://lore.kernel.org/r/20251105183223.89913-1-ast@fiberby.net/
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

Asbjørn Sloth Tønnesen (10):
  wireguard: netlink: validate nested arrays in policy
  wireguard: netlink: use WG_KEY_LEN in policies
  wireguard: netlink: convert to split ops
  wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
  netlink: specs: add specification for wireguard
  wireguard: uapi: move enum wg_cmd
  wireguard: uapi: move flag enums
  wireguard: uapi: generate header with ynl-gen
  tools: ynl: add sample for wireguard
  wireguard: netlink: generate netlink code

 Documentation/netlink/specs/wireguard.yaml | 298 +++++++++++++++++++++
 MAINTAINERS                                |   2 +
 drivers/net/wireguard/Makefile             |   2 +-
 drivers/net/wireguard/generated/netlink.c  |  73 +++++
 drivers/net/wireguard/generated/netlink.h  |  30 +++
 drivers/net/wireguard/netlink.c            |  67 +----
 include/uapi/linux/wireguard.h             | 191 +++----------
 tools/net/ynl/Makefile.deps                |   2 +
 tools/net/ynl/samples/.gitignore           |   1 +
 tools/net/ynl/samples/wireguard.c          | 104 +++++++
 10 files changed, 556 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/netlink/specs/wireguard.yaml
 create mode 100644 drivers/net/wireguard/generated/netlink.c
 create mode 100644 drivers/net/wireguard/generated/netlink.h
 create mode 100644 tools/net/ynl/samples/wireguard.c

-- 
2.51.0


