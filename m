Return-Path: <netdev+bounces-194791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE1ACC883
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADBC7A19F1
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16D22FDF2;
	Tue,  3 Jun 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ05apRH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E7221F06
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958842; cv=none; b=LrwcV/35jb/1v2a0n9f86eIFFHSnZZivNq6fMU3hQghugT7Pk2b8pWFyTCW4Bp9ZQlIL93mLCwkAIL4KZeCrcFcA8axr4IDEM7/HVDwhfS2LRbhfy7wizYBjgt3MVpLwNU9dppjQJG1K7lk96OPf3Duy99If8uUn/F3DMUmBcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958842; c=relaxed/simple;
	bh=hqUMGGex+Rk/4fLYPZnrPmo6a6tUVu1IFos6f5KNRTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hrdc5xmRkxb/7JjEaFtKLe/Ez3YxQLjRXJun9vLNqAZjOZweZQyGTRnT+wEmFzf3n3doEmBoD+7WzqoIfObQRXxq5IIOJ0xun8M7hBsBTSqXPczcyqoMiQkGzn3uoby+QNnGIL6vCECZast8p1FNhNgJ5W7um/UHjrVqEX6dy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ05apRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1D7C4CEED;
	Tue,  3 Jun 2025 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748958842;
	bh=hqUMGGex+Rk/4fLYPZnrPmo6a6tUVu1IFos6f5KNRTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QQ05apRHAdY2zdY1QDxGAoK/64H/QzLjX5lxBUwmpQYGjNfqrp3C6XrfAZF05HdO1
	 Rny+Woy1K/nFH0yWEJW7cc5RdjpZbkzxhM3Vxkai94sNNHYvjykcMPJOD6OqJgjf+K
	 /IurtnUOrVn5BG9XczMLki4n55RaUQo7U5O1dtCbvODMAM3Ihmeyhxgtf8rzQ+hjgZ
	 814O2n3zdd8edLYLd9SyHGANAliMHjssJfmTXO24uxSygQBW2+TBzvJkth1T3JfgIF
	 4XScRLe154b24cPXB05fuP8+LXdxr5CLJtAPaSfNr4ynDK5iyzErHUP3FDNnuebtDb
	 jmqXOvLnEgudw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/2] netlink: specs: rt-link: decode ip6gre
Date: Tue,  3 Jun 2025 06:53:55 -0700
Message-ID: <20250603135357.502626-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding GRE tunnels to the .config for driver tests caused
some unhappiness in YNL, as it can't decode all the link
attrs on the system. Add ip6gre support to fix the tests.
This is similar to commit 6ffdbb93a59c ("netlink: specs:
rt_link: decode ip6tnl, vti and vti6 link attrs").

Jakub Kicinski (2):
  netlink: specs: rt-link: add missing byte-order properties
  netlink: specs: rt-link: decode ip6gre

 Documentation/netlink/specs/rt-link.yaml | 68 +++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

-- 
2.49.0


