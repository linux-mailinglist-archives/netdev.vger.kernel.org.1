Return-Path: <netdev+bounces-223103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDB4B57F6B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F03F7ABB0F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0F33EAF2;
	Mon, 15 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NA8xF+H6"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC032F757;
	Mon, 15 Sep 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947672; cv=none; b=jyAu1zL7EsjZhJmcY3D5uUSYYpw7qddesqZyCOUJJl0RoPcVgvzys31/Aj8hgE+QAnjo5ZHS1fZNhXAMK6TfU/LNYgpxMdX5wDqBdWvmMjTaYOM+xuvGpSl0J86SMLFmr3TrPqXyCZpXc7OrFw4hVF4+Cg6RjjCeVnCROURjMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947672; c=relaxed/simple;
	bh=RbIKwA1YEbJ9B7hJPqXCkfvKOCOA7kqlj5tzz3+rIX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WSqevvYVHzmFwcmwrrp/K5qGSfufIhCDJyYrhRZ8CcaMmMNK3f55VHSAIir6hUFQTUsexMxX71+Lzvbun8hK0tnuf47ekWfp5JyzRgNyDWiyGMsdzxXCXJWyYESPJTWLOoPXXpQ7YnmoSFlBM2bQWG+PwF7HouMKIepZ+A8l3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NA8xF+H6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947660;
	bh=RbIKwA1YEbJ9B7hJPqXCkfvKOCOA7kqlj5tzz3+rIX4=;
	h=From:To:Cc:Subject:Date:From;
	b=NA8xF+H6E0QwDJU+/6IiEQBcJIE2tW6qMYTk9BF4TMKtUVDe+b9m6mnefi1Pe+Fxg
	 Ttb0HG4q1Ny4mbpQWDqOgThDA14FWM+ibf32SsoRV4tJuQABhnv5k9Of10MeV/dcHb
	 Hsty9YfGo6Bb92Z0T8jpkVclWq8GkpNX+P+WSMidgfJQxT/XYjrQJuNF0QW2XjvGJ7
	 ilRDwdKYxX/Fr5x7V4sSF+rH7RBHIg0OWyKaf5VgWkfnbgtBAj5oDhsm3Xvv66K5Np
	 4p5pW3S2WpSTSEUsy6nqhH5RYfkYWJQkQlVxyduRoNuFQAnL16ysXTXicVBJwlGnoE
	 7cKN7w3Y82wGg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DDC8F60078;
	Mon, 15 Sep 2025 14:47:39 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id F3401201BEC; Mon, 15 Sep 2025 14:43:05 +0000 (UTC)
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
Subject: [PATCH net-next v5 00/11] tools: ynl: prepare for wireguard
Date: Mon, 15 Sep 2025 14:42:45 +0000
Message-ID: <20250915144301.725949-1-ast@fiberby.net>
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
v5:
- In patch 4, just copy the old local_vars logic into the new helper.
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
 tools/net/ynl/pyynl/ynl_gen_c.py            | 92 ++++++++++++---------
 5 files changed, 100 insertions(+), 48 deletions(-)

-- 
2.51.0


