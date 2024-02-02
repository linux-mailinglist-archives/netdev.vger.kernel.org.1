Return-Path: <netdev+bounces-68252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77C846523
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C4A1F26089
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029505380;
	Fri,  2 Feb 2024 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPjuBb6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFB53A1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834981; cv=none; b=cShybdKmyIpv1yRUcAQTyS9oBO9F/OO5HGXeSiMUw+6v6gJJYwrM5fLKpSiewNvNwG94zDoKyvTolhjkACDlgf8bjLdDOBjJhcg8rtcry5KfvUN/s342nkRCYZF1hYafTtrZNaRctRPOek9qSMHeZ4sXw7fNx9QxQACZuicbYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834981; c=relaxed/simple;
	bh=Oii5TWp0RAUAIw3QoHqC8rj0+bXQ/bLjUqAvwTe9Dxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/6D1KZrK1sk+saJ4oxyUyDLJEOujt6jamVF6JdOsrjmq2LVlr4dv/JW6kJi5TuoXIJCxYx13tG8Jn9LPLgZ3p8V7Ox6+t1+pnv8ki7uicAKoE6EdiV88Bsxrz9vpp/+pcTrD5SMVJpKUNlhknzvBP5LG4UFO+QbW2DhgN5kyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPjuBb6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA796C433C7;
	Fri,  2 Feb 2024 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706834981;
	bh=Oii5TWp0RAUAIw3QoHqC8rj0+bXQ/bLjUqAvwTe9Dxg=;
	h=From:To:Cc:Subject:Date:From;
	b=UPjuBb6xhfkWZ43wgP1SvA+lwM3lZkxa7vmBZ/zsH/oXs+cTEO6tY4rX7qUOAPYE1
	 s4cjrGuam8XlQDghvfOv0904OK0x1TlIoInY5gc3K1vnWxXyXk//9wA32VtQQYb+i/
	 XOrnvOY3hcL2VOH+x/pBuES2TpMwHVCgIgGD4bdmK3eqzYagOnIO8MBknutfCr4Qkj
	 xPVB6m9/i08NCQJdzH9+2huVhw3dYWhXcmVNY1vTocFlLMxdfi0movcUlfAEtxUcWX
	 HmsZBaujcmn0XsFZfbQV1j2F9EbEv29PMzYPfssI++D6Sty7roK06j94quX5OVTATj
	 IXa4w0VMlGR+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] tools: ynl: auto-gen for all genetlink families
Date: Thu,  1 Feb 2024 16:49:23 -0800
Message-ID: <20240202004926.447803-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code gen has caught up with all features required in genetlink
families in Linux 6.8 already. We have also stopped committing auto-
-generated user space code to the tree. Instead of listing all the
families in the Makefile search the spec directory, and generate
code for everything that's not legacy netlink.

Jakub Kicinski (3):
  tools: ynl: include dpll and mptcp_pm in C codegen
  tools: ynl: generate code for ovs families
  tools: ynl: auto-gen for all genetlink families

 tools/net/ynl/Makefile.deps      |  2 ++
 tools/net/ynl/generated/Makefile |  5 ++-
 tools/net/ynl/samples/ovs.c      | 60 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/samples/ovs.c

-- 
2.43.0


