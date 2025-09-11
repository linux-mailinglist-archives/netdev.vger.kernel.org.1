Return-Path: <netdev+bounces-222292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E7B53CDC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5032D1CC68E5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614462727E0;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="EyrPqhWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CB1E1E1C;
	Thu, 11 Sep 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621134; cv=none; b=bmVjeBvIAJi7CW5RgucH6B1tvC28qroHSdj61rAF0oS4kYcbptRH5Hu3IeRSsIIbh48pCD7WHnWeYndRt7llL101AQ5hXF/XA/I062+AVStLlaGmP+dRkYnxVDCIoyx4Y3plX1+vmBUAgf1CFErpo4+0MKapGteiiuH1E5HMBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621134; c=relaxed/simple;
	bh=QmKA1EaeZnLUYZFxoQZW+o4tE5dP97c0rSfG3Wrs1k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzrXz0TwLtrtkN/1+N3640O/adBYxAuL+AHgNVlfSkVY6jBHUAAz2mB5lm9pzwKPlSg+bx9JTQ7H/19BJm6Bd0d9/02ysSQ+njuhY4GFyBc865VrI0dvWu/1mteEG/lczw8uT72/PTniDwtfycuON9PPSJQ14F6hVrK7za2xOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=EyrPqhWg; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=QmKA1EaeZnLUYZFxoQZW+o4tE5dP97c0rSfG3Wrs1k8=;
	h=From:To:Cc:Subject:Date:From;
	b=EyrPqhWgz6Xi5fI+L9X+zRloxLMXvFd7JFYxQiEt9VW7c21g7lYtVSG6rcamU4KDm
	 wC1LX9MhdK0s2yZLVYyRZrBrwqqsMLBIte2ETFRtWan242Zc5NcAb4ZNme1eYcO4zw
	 ffZJZty8tE2XgVd+NUOFypL7PBV1bYQ53H1zrv9xCGo5k3GO4ZwAmbcTEYw7+h4b63
	 ij0yDx0Jt9peLPvzXRCPYws63TLF5V/cxO6rgrdP15RSZgay/JHoSolQ3Gv7vv4mtc
	 kmbyoJjpMvdojjR+By88cj2qm+5nfXxidE5ORAE1YhBTuzxPYWj09iyiIci+KhrS0T
	 BJSuX65DqIRXQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EF3986012E;
	Thu, 11 Sep 2025 20:05:26 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id D033A202855; Thu, 11 Sep 2025 20:05:20 +0000 (UTC)
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
Subject: [PATCH net-next v3 00/13] tools: ynl: prepare for wireguard
Date: Thu, 11 Sep 2025 20:04:53 +0000
Message-ID: <20250911200508.79341-1-ast@fiberby.net>
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
v3:
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
- Patch 10, got a dead line removed (thanks Donald).
- Patch 11, revised hex input to support macsec (suggested by Sabrina).
v1: https://lore.kernel.org/netdev/20250904-wg-ynl-prep@fiberby.net/

Asbjørn Sloth Tønnesen (13):
  tools: ynl-gen: allow overriding name-prefix for constants
  tools: ynl-gen: generate nested array policies
  tools: ynl-gen: add sub-type check
  tools: ynl-gen: refactor local vars for .attr_put() callers
  tools: ynl-gen: add CodeWriter.p_lines() helper
  tools: ynl-gen: deduplicate fixed_header handling
  tools: ynl-gen: avoid repetitive variables definitions
  tools: ynl-gen: only validate nested array payload
  tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
  tools: ynl: move nest packing to a helper function
  tools: ynl: encode indexed-arrays
  tools: ynl: decode hex input
  tools: ynl: add ipv4-or-v6 display hint

 Documentation/netlink/genetlink-legacy.yaml |   2 +-
 tools/net/ynl/lib/ynl-priv.h                |   2 +
 tools/net/ynl/lib/ynl.c                     |  17 +-
 tools/net/ynl/pyynl/lib/ynl.py              |  38 ++++-
 tools/net/ynl/pyynl/ynl_gen_c.py            | 164 +++++++++++---------
 5 files changed, 140 insertions(+), 83 deletions(-)

-- 
2.51.0


