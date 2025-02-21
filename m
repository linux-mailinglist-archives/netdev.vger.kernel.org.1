Return-Path: <netdev+bounces-168606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9AA3F965
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8264519C68F3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4D21147D;
	Fri, 21 Feb 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2EL121H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB65205514;
	Fri, 21 Feb 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152668; cv=none; b=FscV79hpMKIR0fycL5la5NWOmoHkFoFIVD28P3LXolB21yx8xuURK5G8vIniMXb0eqGJERdGgnTa5U1fK66RmA0TfDYNoyZrO0uN+r7xDVSP0FwW1FZikmt1KD3IbiWpMwBQ6n2f14bYA9QPO3t2VrJSfD/PVVGcZMEx6Hm0fMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152668; c=relaxed/simple;
	bh=a1PHG4oRYa5wYXlrTgrvlkE6wAw+WAhSTwMJ3XPR460=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLP5wWYDLmswFCoCvgI0rkwy40HVdl/MNBrGTog3YZXJmVdpz3jmPgh8FJoYOxCWfidgTPU6NylBBc0amhmbs0KUwMATqny+ovur2I0VvBe6mGH1PvgG6Fda0tKqxpeByCikqiQnSrAB3do2Z50qsh6a2WTZteZCNAvzk85T66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2EL121H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABEAC4CED6;
	Fri, 21 Feb 2025 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152667;
	bh=a1PHG4oRYa5wYXlrTgrvlkE6wAw+WAhSTwMJ3XPR460=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2EL121HxSLqw57ez/5DP/DYtbt/130TGkJOjS0k5qpbTgqQBvbqGC/EucLxoytx4
	 tWlfPreHiM71kEQtpVkkdihbC03WvoDqyk4uwQpEWuj2T+sCXoRd6j2qx6hoBii78i
	 +exBxtzWOiNYPThiAXkzUTUgrcYu0MpQ4rJKl70TI3CIN4NtTuwgNgBiL1DDlm2S4N
	 itiPp374ysbgF6Ed9aqQVG/ySMEzTI3t8c1qu0VhqZ+uwYiIf4cTB2WPcrOs+sEqrv
	 RohjnMtBc3bxOUGwq81xw+uaJNpEz4syrZqF/ukxZkbdecw0a5Mc7EKiZTsmS3zbaO
	 AfqecZ0dcxxsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:44:00 +0100
Subject: [PATCH net-next 07/10] mptcp: pm: use ipv6_addr_equal in
 addresses_equal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-7-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B4keAA5ZHYw+PbPi00B+5NzpE+JM2Ll5Ekvtr28WNco=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HgKgztIEWjGR2ANIpDvvp+nYp3ap67g0KX
 WoB/r4V6jKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 cxY/D/wM8bSZa+l+C2F4bJak/9vTgbHghg2z7NeJwx03eR6zVgiB1GAhDuou2gs2ZMuK0DaXhVS
 NSzXNFy471FH4Q4drvYlOh9iFeXmdZnrv5z9XYeJG6RieNP2lpQAcBWdvFxIBEncy6rYfSLWMLw
 eC/5eztgX60aT3trgBuF15+zCBplPun11Cfbduwj7yc1RAHU4f3mg1eAUl/Fly+rdO2pP6xUMiH
 /YtJVQt82oHkhwzAp1nGcIlO3+AImjAf8Aj7MsTzwK9PIx+LcIZ3Ale6W9sCDs9VBzAzbp5qHUG
 4yyOyaYOl4npsj7ocT9n3/e0thQCfhqtDk2ujoxPOPAfFzT3T6T+0T4N52osO+QlmMmHqyvLbHo
 sCvF3un7vbM7V9Dyzh/cS78kBsHruMXBJLiF3bg/z6etulBxE/kY/5AdGwTo7BRmCA08HmX5XTq
 9bfbw7Zu6gIczvARJLMq5ySOHLJisWs5ttGkONeKMCOXtVao8j9To4aBC8QGfVqf+ChO7H4my6S
 TYCCfIAYeuBb34+RJ/XEhj7wH7aQfhkAcHbpzTP693mOtpiH6Q8lIif5tkUAQpKlYwKkRojA3cT
 DIAujJx7vdQjOzH3f5+JowlSRi4Hc453mBY6r4l/Z63sKiBBVUJ3qZHCfJviXuUYmlYHbXTypcq
 THl/f8Ms0z56wRQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Use ipv6_addr_equal() to check whether two IPv6 addresses are equal in
mptcp_addresses_equal().

This is more appropriate than using !ipv6_addr_cmp().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f67b637c1fcf7c2930ced8b5c6b9df156118cbcd..ef85a60151ad796b445afc21bcbcae1c52ef64b6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -64,7 +64,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			addr_equals = a->addr.s_addr == b->addr.s_addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else
-			addr_equals = !ipv6_addr_cmp(&a->addr6, &b->addr6);
+			addr_equals = ipv6_addr_equal(&a->addr6, &b->addr6);
 	} else if (a->family == AF_INET) {
 		if (ipv6_addr_v4mapped(&b->addr6))
 			addr_equals = a->addr.s_addr == b->addr6.s6_addr32[3];

-- 
2.47.1


