Return-Path: <netdev+bounces-99585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA68D564E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FCA1F2492F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C91761AF;
	Thu, 30 May 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar5qPtPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8D482D7;
	Thu, 30 May 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112185; cv=none; b=ojkshfngqxOqTpB0YLrCM9EeZ0xAsous5Pu/+93COA7xFLVvLzV3VkRQlhki3N7YD6mTH4g1PP/Wgx0Y7NSrBwy21X7hGd6Y7EwjbyVcUgJ/dzvj4Jmb+Y8eibV3dLBvzsyCdu0QZbOzar/3Z40Nl1vKhkCYmpC/ykWpqx0G/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112185; c=relaxed/simple;
	bh=0XSl/6+4RdfQgL1A0cDpbgP4gx1vFyZXJ4KpCRJUHxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7aM8hWOes6YiLoNGguFTSXOfhxdGsizO+hMbvkse82FS7vO6kQ0+wKUmjGCUzmSVQx2g55xkDWh+LbUj52LI+MVE4BFWurd3kDsa0A4VErl2UDF8zShBRG8Oxm3wyPwOIjBOuKs0DmNXzcIGmtJtmchsQNnPyfHCEso1UAUtgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar5qPtPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1BCC2BBFC;
	Thu, 30 May 2024 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717112184;
	bh=0XSl/6+4RdfQgL1A0cDpbgP4gx1vFyZXJ4KpCRJUHxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Ar5qPtPBqLIOyypuhjcbStrHiekjjYNlB2wjxtuuDN/q0TYlSzHhu2kZiiCP5/zN7
	 G/OGX4lA0zqbvtHdG80QB/rxGCerRyzAhT+erNDODGx0lu5eO+Gnc/FNWLyyY0Dtxe
	 KiHZVkELqDqR4ITF9Cn18IbeKAOe5w2OExssa2S8ZdItE2hC1hqal20j8ykkjAfphg
	 YyZToMTCe8Rk1pkqEj4zcifOiz1G2jfhq19t9GoHG7j+e8ppFFTC7gcFw8VvYnSBmI
	 Cyo4o4rTCj0/1jPsmIhx8M/tjp1aGUw/wA2wY4UpdnVbenqBZzivOWZub3xkTK9VrI
	 2OUsPWH3zMBYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	borisp@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] tcp: refactor skb_cmp_decrypted() checks
Date: Thu, 30 May 2024 16:36:13 -0700
Message-ID: <20240530233616.85897-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the input patch coalescing checks and wrap "EOR forcing"
logic into a helper. This will hopefully make the code easier to
follow. While at it throw some DEBUG_NET checks into skb_shift().

Jakub Kicinski (3):
  tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
  tcp: add a helper for setting EOR on tail skb
  net: skb: add compatibility warnings to skb_shift()

 include/net/tcp.h    | 16 ++++++++++++++++
 net/core/skbuff.c    |  3 +++
 net/ipv4/tcp_input.c | 11 +++--------
 net/ipv4/tcp_ipv4.c  |  3 +--
 net/tls/tls_device.c | 11 ++---------
 5 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.45.1


