Return-Path: <netdev+bounces-221884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979CB52472
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB20B562DE2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948433115B8;
	Wed, 10 Sep 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RLr7MtZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7F30F959;
	Wed, 10 Sep 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545741; cv=none; b=FfJ6ODNfLeBUIc7hMZhnPDmsk0fTZVNkAY9z4cxEQ1QLhNxb7eg7Gl4Z2wG3dvMLWtaWpw9RhVYWN4f0lFv6Go8wsXIIT5wCIPg+XpNBzWsAqr3fwX/a8vfB71WiX+qak2R2MMPZ5BeVwU9ZHreh5Z1sI+8ik7qIR4JrN12PVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545741; c=relaxed/simple;
	bh=yVwAAwA8ZqRChTcsBFbq0ZzAjSu1W4vNRIY3ubw2sZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQyZqyoJjGo2DLFGTs26KuypFCQYMQ1Sp5JDB2H5HmwXT6ny/rODRanRlZsdX6hL736gC/eBAewHJlxso5XEtY1EWe3LhBkp/NBNSujRnSh8SWzLrT7Ck8CC4nRRtQIE2Ft2ZFS+Czro6QnZy+4GsaMVVJPwBe3yV+ksJj/sI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RLr7MtZ4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=yVwAAwA8ZqRChTcsBFbq0ZzAjSu1W4vNRIY3ubw2sZM=;
	h=From:To:Cc:Subject:Date:From;
	b=RLr7MtZ4rHKmaE1FQIIoWsxuAKru9AKHAzTux5QvM2HLOtQCzwp8yp3Sra3LYIP+L
	 xjcQd7aX9Ynrxg6CxpVOTTh/ZZR3LND1SGPQL4IT7TYRBBYkycwoNidbaT2cQD6+6D
	 8wOPud1z8QP1OsoiN/oS1VEsToeQ/KU/cKTnCb1TZcTDUh3EeaOzg8936wlh9Ia5JH
	 6xtNJ9z5pHQ/7VoJilMsu1+2oKQ3I0ay6p8lokB06Df/J468YERIgpzl9jPKJZjIyX
	 hIyFT2QYrpUmZJlGmSiXSIy+1zde8hsQ30MdIpaTu3hh/Oj2s+gXEDqd2n7kDW49qc
	 WPyPgoKJAvsGw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 56DB360128;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BFDE9201BFB; Wed, 10 Sep 2025 23:08:42 +0000 (UTC)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/12] tools: ynl: prepare for wireguard
Date: Wed, 10 Sep 2025 23:08:22 +0000
Message-ID: <20250910230841.384545-1-ast@fiberby.net>
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
v2:
- Added Reviewed-By's to unchanged patches. Thanks to all reviewers.
- Patch 4, refactors local variables for .attr_put() callers, and
  replaces the old patch 4 and 5.
- Patch 5 and 6 are new, and reduces the differences between the 3
  .attr_put() callers, so it might be easier to keep them in sync.
- Patch 7, now validates the nested payload (thanks Jakub).
- Patch 8, now renames more variables (thanks Jakub),
- Patch 10, got a dead line remove (thanks Donald).
- Patch 11, revised hex input to support macsec (suggested by Sabrina).
v1: https://lore.kernel.org/netdev/20250904-wg-ynl-prep@fiberby.net/

Asbjørn Sloth Tønnesen (12):
  tools: ynl-gen: allow overriding name-prefix for constants
  tools: ynl-gen: generate nested array policies
  tools: ynl-gen: add sub-type check
  tools: ynl-gen: refactor local vars for .attr_put() callers
  tools: ynl-gen: add CodeWriter.p_lines() helper
  tools: ynl-gen: deduplicate fixed_header handling
  tools: ynl-gen: only validate nested array payload
  tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
  tools: ynl: move nest packing to a helper function
  tools: ynl: encode indexed-arrays
  tools: ynl: decode hex input
  tools: ynl: add ipv4-or-v6 display hint

 Documentation/netlink/genetlink-legacy.yaml |   2 +-
 tools/net/ynl/lib/ynl-priv.h                |   2 +
 tools/net/ynl/lib/ynl.c                     |  17 ++-
 tools/net/ynl/pyynl/lib/ynl.py              |  38 ++++-
 tools/net/ynl/pyynl/ynl_gen_c.py            | 152 +++++++++++---------
 5 files changed, 133 insertions(+), 78 deletions(-)

-- 
2.51.0


