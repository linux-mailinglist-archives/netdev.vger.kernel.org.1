Return-Path: <netdev+bounces-188850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1564AAF124
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D81BA3211
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC21BD01D;
	Thu,  8 May 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtgcXnXs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DA4B1E40
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671327; cv=none; b=mKNsV2u83q5bxWNZ48cYA78VJxPuwjEbwTQkeM95IfvolI50xjTrXgfO0V0Z0KsNNhk+AwokxRGyR4kF5nMc2OwwZlMuWsinm0JMEp7BSoymPSyQ9ytRcmj1+erRiWwVVVib3uLRBX2kMi8sjRTccETl6tdmzDg0TAOy+xz/iBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671327; c=relaxed/simple;
	bh=f70NiPlV/i7wWT3CZwo4NHk91U1aR482RL75MAI/Jqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuMLoqEyHXXNRG3OtUmuk8vyFNtYoJ7GsxGXMNoyxnHYlyNDChHxQE5fnaT7jyg0HuNnhzoNYrPnGXyH8O2h3lgwJjk5s0oZoEXrvUEpUretyEDtHWuo1KyiPc1b3BimPQNT/9tcz7Ys9/rbkWfnnZsztQP7SWgVN1cE+lLaxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtgcXnXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E50C4CEE2;
	Thu,  8 May 2025 02:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746671327;
	bh=f70NiPlV/i7wWT3CZwo4NHk91U1aR482RL75MAI/Jqs=;
	h=From:To:Cc:Subject:Date:From;
	b=GtgcXnXsI6tGSulBYac4hkFJhaMVIpgTPc41Zc12OmzoXrskEgLgO6Pa7xrSFpe1X
	 YLQhqK9lpnPPLob5d1jlyqdfEAqWM5baWjaLLTYOrcNADMcgwjJERqBFnqXGHo5b3m
	 oLPUEdZXzfcdKcTsI8/aJPDyfpUYbqB/CHdD8xS+3do3j/+cQ6E3xqU3PFHwDMWBzn
	 UqknQ7obCF8mRRAjOrvj6FHpqHnOl7U762BFdfAH9N+WzA6cWt24Xz8vUUZtF67lb1
	 hHlXu93V32xN3ICo3zeP3jzGVl83emtJxfQotvwMYr85uWgsmRkcrFQccLz4/JCAKR
	 2bJHsdknqZV6A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] tools: ynl-gen: support sub-types for binary attributes
Date: Wed,  7 May 2025 19:28:36 -0700
Message-ID: <20250508022839.1256059-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binary attributes have sub-type annotations which either indicate
that the binary object should be interpreted as a raw / C array of
a simple type (e.g. u32), or that it's a struct.

Use this information in the C codegen instead of outputting void *
for all binary attrs. It doesn't make a huge difference in the genl
families, but in classic Netlink there is a lot more structs.

Jakub Kicinski (3):
  tools: ynl-gen: support sub-type for binary attributes
  tools: ynl-gen: auto-indent else
  tools: ynl-gen: support struct for binary attributes

 tools/net/ynl/pyynl/ynl_gen_c.py | 66 +++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 10 deletions(-)

-- 
2.49.0


