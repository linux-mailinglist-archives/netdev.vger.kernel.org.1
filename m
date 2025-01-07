Return-Path: <netdev+bounces-155667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42F8A03520
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA33188667D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21C14B087;
	Tue,  7 Jan 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb7D5s4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9613B58D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216902; cv=none; b=krirABYNeynnfXwB6s8nsrHWMwa7LPrHJ3PtFZt8eubYybITGlF5Hvb3MCNLVI4XffoUIAgFSycbtYG6BLxJTH4N7bTJ+7AyabUFGM9dJc+kPTMo7aCEIcKwgV6/0Rp5g2Xj23NONDmdHVhZx8cEkjroyEsyKgSp5Pbl7H5DXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216902; c=relaxed/simple;
	bh=dG5aKgUngup/gI8pS/Do+LHORxr7yvt7Q+lXWc+qbL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdfB3/nMm5pT+7bf9+WnJ+ECPrFpl9vu7rWTKaD7gJDDpr1GElyTr2HFZmHpgMYafOcWbnm17JxPY2M9yF0e+RJwQov+ISDKLDIBVBPvsgmwnitpspqJVzbd5LFSk/P5PLphR0kbpJHpwd+caxo4QlqYaCkEWLJ7pciPnfCy4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb7D5s4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4B2C4CED2;
	Tue,  7 Jan 2025 02:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736216902;
	bh=dG5aKgUngup/gI8pS/Do+LHORxr7yvt7Q+lXWc+qbL8=;
	h=From:To:Cc:Subject:Date:From;
	b=Nb7D5s4TJ3FS8X0pjaL9OZX9bvdXZxZY1KPkQzpDOGRg/Xomuj4x+ViExWbsLb+CB
	 sx7929gfeRtkfSIsfmZGRtvFNEFrPc0hGMLPBD8EfPwgGLBQUR7pZGfTE42mxnyqBB
	 IzaoK76ylGkQzMIKfv/PIOGp/8AbL7Qcx6cH2juO7AxTz1GoAf/eurXNY/aHbUiA3e
	 xwicrZZKEWU+Wnepadvudf5UqTTlXTD3VWZRi26xrCsuBkmu8dQxuQ8oukZMXPEWxk
	 3O44B5mThrVyUyTGvb/CzX013bYz4v0KAWP7wJR98r7oX4KTJ6LXSgs1y6px9HUB+R
	 p0nZwGXZG734A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] tools: ynl: decode link types present in tests
Date: Mon,  6 Jan 2025 18:28:17 -0800
Message-ID: <20250107022820.2087101-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a kernel built for the net selftest target to run drivers/net
tests currently fails, because the net kernel automatically spawns
a handful of tunnel devices which YNL can't decode.

Fill in those missing link types in rt_link. We need to extend subset
support a bit for it to work.

v2:
 - adjust C code gen in patch 1, it dependend on reusing attr objects
v1: https://lore.kernel.org/20250105012523.1722231-1-kuba@kernel.org

Jakub Kicinski (3):
  tools: ynl: correctly handle overrides of fields in subset
  tools: ynl: print some information about attribute we can't parse
  netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs

 Documentation/netlink/specs/rt_link.yaml | 87 ++++++++++++++++++++++++
 tools/net/ynl/lib/nlspec.py              |  5 +-
 tools/net/ynl/lib/ynl.py                 | 72 +++++++++++---------
 tools/net/ynl/ynl-gen-c.py               | 26 +++++--
 4 files changed, 151 insertions(+), 39 deletions(-)

-- 
2.47.1


