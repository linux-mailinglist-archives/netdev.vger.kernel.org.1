Return-Path: <netdev+bounces-172536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D1A5542C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91FA17956F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419CA25CC6D;
	Thu,  6 Mar 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwL0TOcZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F02144BC;
	Thu,  6 Mar 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284362; cv=none; b=DmsW6w1q/bX0V71j3bhXNS8ctw4UOx/4lsuDA+UsZZkVqvqkk2gcpR8zZqry87ThZiWyDjpO/bcudwhnE5rv9isQ6I7imyNpUuB0V3oBp8hTZRxOj+EnkU2WiamExWewdfHsN8bp4X++klO8YetgNJ+ZwZL/qvNdLKA+pvYGGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284362; c=relaxed/simple;
	bh=6N0PqqxbmEi4VIikyzJUm5cvHtJnvpn8YYaEjzs2uMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIqzDp6VjhMr75kjIXMCFEiFXDZy30vRyhCKUQdw7VKOjFCs05XqJH8JoNwnW02/R9kNBlYrBOs+2DNMziJgCERWJMbZ3pENAPXnxTzWjUlKbcJuU8/B9ye014F83YWFIu72MsvuK9Qb/48dzF35fGRUYpfaDsGdboTbaAsMgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwL0TOcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030E1C4CEE4;
	Thu,  6 Mar 2025 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741284361;
	bh=6N0PqqxbmEi4VIikyzJUm5cvHtJnvpn8YYaEjzs2uMg=;
	h=From:To:Cc:Subject:Date:From;
	b=SwL0TOcZVoX1aw44nfN9DGCYyDOq2PpXOdnyr1IQ+CRZhLM9kOLgLVpnWB5RYpYXD
	 lKAk4fcbLxNcqyCrKJKQKc4xj9y7Osa/wUMRVuEz4BGGazrWEURMnIwiQ/hPldKWKQ
	 lX7IJ4e7v44NKsdLYIXOip3m6C8ttl49IVr/wHokRcLAb2/tmbSz6hbgVGXDmorNwP
	 YamNANN+1UHp72UvsBTPd5MRnquylLOH86W37/eigJyk5F7j4k2uR90Cby09J8dncu
	 BpNw3m6nHrNMTUPOZ+qyutI/o1Ck5bbjexCHVBnVyhnlHxDaOWk/LfF0HNGgfxK4Xk
	 b0wQL+T+3PSxA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] docs: netdev: add a note on selftest posting
Date: Thu,  6 Mar 2025 10:05:33 -0800
Message-ID: <20250306180533.1864075-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We haven't had much discussion on the list about this, but
a handful of people have been confused about rules on
posting selftests for fixes, lately. I tend to post fixes
with their respective selftests in the same series.
There are tradeoffs around size of the net tree and conflicts
but so far it hasn't been a major issue.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index e497729525d5..1ac62dc3a66f 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -311,6 +311,14 @@ user space patches should form separate series (threads) when posted
 Posting as one thread is discouraged because it confuses patchwork
 (as of patchwork 2.2.2).
 
+Co-posting selftests
+--------------------
+
+Selftests should be part of the same series as the code changes.
+Specifically for fixes both code change and related test should go into
+the same tree (the tests may lack a Fixes tag, which is expected).
+Mixing code changes and test changes in a single commit is discouraged.
+
 Preparing changes
 -----------------
 
-- 
2.48.1


