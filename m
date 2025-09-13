Return-Path: <netdev+bounces-222825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48BB563FC
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CB83ABEB7
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803B2D6620;
	Sat, 13 Sep 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="nOeZyzL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1C2D060C;
	Sat, 13 Sep 2025 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807963; cv=none; b=XX1LT1prTi+o2yPfzR2Ed+PZCfzq69KAT9zG9Ehg2y7axxvi7w05veetI3Nt1U6P18dF7yJ2HS39fIWVuQRENKjPdnsi62ko2EQwctlIvh5QW9Jm7u5Lpaf5N5C6x3LpflJWnIajiQwO9duWqfKY9paJstQa5yssvDgtfDwCKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807963; c=relaxed/simple;
	bh=WEAYPSa2cbIp0UFaudtrcyt/21OA9AIcAOuHxxlvsEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rR9QiqoakkeC2oKjJFNwBmqrJSYLpbPKAY2G1xV7N7utXDNrZ+C49suTGUCtWREoM4LSP6nOPklENFcne4Jz78sav8YjI8ObA7DFD7JRHU4RQhgBRVHV5S0fyCueilFM/JGP7iBJZtp5qveckoQPogVLoizTU8Z7Rfw7sebb5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=nOeZyzL7; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807953;
	bh=WEAYPSa2cbIp0UFaudtrcyt/21OA9AIcAOuHxxlvsEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nOeZyzL7ngnAeneb1vFuBo1FYIqWH+3V4VvQ+ipRqLa3JjmfbKNHIjYlu8JY5CQAp
	 OFDPpsWnU7xq37Tbduw7yo8lmXfDXbsaFXcZnERmXTaY1g7zm16H+MMMoNwpCz19G2
	 eo8AAxMxaUkHJZY4JUxjhhYA+MN6+U2r0HEO1bqsr6iLh3b/1k65SGosI9y0NMymXa
	 wevH8nVWsdVlIu/0+YI6zRr7xKkdDjwaQOY/5KcB30dyT4j6ymVk7rwy9VE8jqYCaa
	 gdn/JmRp0KyyRL/VUKn58fjQPl5WvxFYJ5KSP9OkPAGVf0jhRSgYGG2d1s0d1PsHxk
	 jLYZhA2JwceSw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9BDE96013D;
	Sat, 13 Sep 2025 23:59:13 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 29DD9201DC8; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/11] tools: ynl: prepare for wireguard
Date: Sat, 13 Sep 2025 23:58:21 +0000
Message-ID: <20250913235847.358851-1-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains the last batch of YNL changes to support
the wireguard YNL conversion.

The wireguard changes, to be applied on top of this series,
has been posted as an RFC series here:
  https://lore.kernel.org/netdev/20250904-wg-ynl-rfc@fiberby.net/

---
v4:
- Added a few Reviewed-by (thanks Donald).
- In patch 4, changed the implementation a bit, to avoid overloading.
- In patch 6, expose __ynl_attr_validate(), and move ynl_attr_validate()
  to ynl-priv.h, as an inline function.
- Dropped v3 patch 5 and 6 from this series.
v3: https://lore.kernel.org/netdev/20250911200508.79341-1-ast@fiberby.net/
- Rebased on top of new net-next, after Matthieu's cleanup.
- Added a Reviewed-by (thanks Donald).
- Added the parsing local vars cleanup as patch 7
- In patch 4, change to use set() for deduplication.
- In patch 8, declare __ynl_attr_validate() as static.
v2: https://lore.kernel.org/netdev/20250910230841.384545-1-ast@fiberby.net/
- Added Reviewed-by's to unchanged patches. Thanks to all reviewers.
- Patch 4, refactors local variables for .attr_put() callers, and
  replaces the old patch 4 and 5.
- Patch 5 and 6 are new, and reduces the differences between the 3
  .attr_put() callers, so it might be easier to keep them in sync.
- Patch 7, now validates the nested payload (thanks Jakub).
- Patch 8, now renames more variables (thanks Jakub),
- Patch 10, got a dead line remove (thanks Donald).
- Patch 11, revised hex input to support macsec (suggested by Sabrina).
v1: https://lore.kernel.org/netdev/20250904-wg-ynl-prep@fiberby.net/

Asbjørn Sloth Tønnesen (11):
  tools: ynl-gen: allow overriding name-prefix for constants
  tools: ynl-gen: generate nested array policies
  tools: ynl-gen: add sub-type check
  tools: ynl-gen: refactor local vars for .attr_put() callers
  tools: ynl-gen: avoid repetitive variables definitions
  tools: ynl-gen: validate nested arrays
  tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
  tools: ynl: move nest packing to a helper function
  tools: ynl: encode indexed-arrays
  tools: ynl: decode hex input
  tools: ynl: add ipv4-or-v6 display hint

 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 tools/net/ynl/lib/ynl-priv.h                | 10 ++-
 tools/net/ynl/lib/ynl.c                     |  6 +-
 tools/net/ynl/pyynl/lib/ynl.py              | 38 +++++++--
 tools/net/ynl/pyynl/ynl_gen_c.py            | 93 +++++++++++++--------
 5 files changed, 101 insertions(+), 48 deletions(-)

-- 
2.51.0


