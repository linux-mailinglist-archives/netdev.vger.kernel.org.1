Return-Path: <netdev+bounces-158200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF3DA10F9A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AF43A9D4A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A01FC0F1;
	Tue, 14 Jan 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd3AMgd+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049F1FBE9B;
	Tue, 14 Jan 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878017; cv=none; b=fAe8un0AN8QI1vg7yrFYt+/rPbIsVzhOEcqd0aW2mPGOtJBplM2loDV+qx7B4Fv+60YsN8uMcVMJPD1nq64igiAR0HCTMQFEnzhwlfwBZbXmHv+MG3O3w/mTJAaRGY22F16YiQUm8eXEkzYbORbCVK2IsCrRbf3S56SiB1OUy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878017; c=relaxed/simple;
	bh=swPgR7s5nmSNfZXrUImMZYYqcuaUdyCqTofQMpPD5mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dgr5Wu7bLbp+tS3szAVyaP+hRULrKJRzmkgm2wpiu5CUHcXfTvR8Kw98iCt9SO8m1Lqs/9lbTXJIWCHXyFBYHwYbe7qDHiAx+3H6ZPDyoRNbZLodWbjnpK80KrUMiwgWdrS+TG+3ILCbj83WtdNSt4JRzQHZJrMlYqdakHFV/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd3AMgd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD0C4CEDD;
	Tue, 14 Jan 2025 18:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736878016;
	bh=swPgR7s5nmSNfZXrUImMZYYqcuaUdyCqTofQMpPD5mk=;
	h=From:Date:Subject:To:Cc:From;
	b=Zd3AMgd+4EAPhqRpY8CgWGvl2NS2OePuIvJK1a/Fccs3DBN9sdRhyRfUPg3+dnCao
	 H7EYkLiYGzGI9zuEX3Cu1yUMMAatJsQgp/L/yVePpejOoqmULHIQ5P7KLkl8YLK9XN
	 6aCFxabDKnwu6cgrx7yGjkeQK/DxZL3sHl/Atylucj1MZx6xMnptnj5Jp2VsXRAfJT
	 wZwGuR4eJN7moft/tmPSH5bHFEPLjCwyGRvke232hfydSA6OBAgaKJeWIYfDpv3LdZ
	 KKcFSz8sWoWHIaT/p0ymtXRxG+TgyuZqwjktAenchKwJmPKEvdB3updzwfYBN7zQNZ
	 T6JnkNRfad+Og==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:06:22 +0100
Subject: [PATCH net-next] mptcp: fix for setting remote ipv4mapped address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ2nhmcC/zWNwQrCMBBEf6Xs2YUkRCv+ingIzbTuoWnYBCmU/
 ruL4GEOD+bNHNSggkaP4SDFR5psxcBfBpreqSxgycYUXLg67yMXdMveea19qjzLzop16+CUszJ
 G3OMtOIwpko1UhVV+B0/6u/Q6zy+UJnPCegAAAA==
X-Change-ID: 20250114-net-next-mptcp-fix-remote-addr-e7e84620e7a4
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zIgdgpu9mAsEZvi2Izt/hyFEqDf7GtFTPSU7vZg8wOg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqe9Mn4oWIMr96GQfZ6WjA9QCy2RpgJ4AiMu4
 u1MCpCtf8eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4anvQAKCRD2t4JPQmmg
 cyTIEADOYajQBRgdNNes5fGnzpS7MpEirBdYH4DPTm2A3Oxu7+IFdz5OYIR0HHQmhKPNwCjL2Ei
 j+pL0/J9nYzHOOEAcb+3IbqESNDgJBG7iSNRoFE9p2SG0ZmnpN7P62EjgUuVgJaqyz11/aaLdLH
 ZEEJ1pWbiDpoazZA+N8kI9bo1rfCE62xH1zD+GnGLp9VkZAnV6k15cbljsNkmBUsULvA8PTsVE3
 B/fjQrZHiouG+ARkuJYIUaZytUsSkx/O0j5K8yFnX/wjLRdfG9DKA4L0oQubLTqmhDP30ACbg9z
 ZZFlDCzpt4F2BG/XhGUgg6mBJVAIUPPJFmxNH1yb3jzRakJDErZQbU59k+A8NIA/z/Y9XSNH/b+
 KX/jx13jstaG9uFHoH6ZL0QGfXmnoUhFopG5tP+hdSYp+Xhnjxa3L06ga9AQzzYD+QJ5NwBU0TJ
 wMDlpMbTBupmlzCgbCV3O6t0uZssA0+LDH8crjaqbo8kJ9UABwOYKVrpy6znbFzOoDioHepyZxv
 lMHUSUQTjuVMo7hbzKKivo1uxGbNM+z5vT+fayACEPQQTLXfquH17EO2ALIaHVukPQeLaMxSA94
 GkEctl6vIBoEuO14kznK/9eA3e/AtfwnoO3+poE5YlY8Eko3MNLCulaxu51rVthEDbySKPgA7tv
 fnRoisdjWGjxWAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Commit 1c670b39cec7 ("mptcp: change local addr type of subflow_destroy")
introduced a bug in mptcp_pm_nl_subflow_destroy_doit().

ipv6_addr_set_v4mapped() should be called to set the remote ipv4 address
'addr_r.addr.s_addr' to the remote ipv6 address 'addr_r.addr6', not
'addr_l.addr.addr6', which is the local ipv6 address.

Fixes: 1c670b39cec7 ("mptcp: change local addr type of subflow_destroy")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this is a fix for an issue only present in net-next, not in net.
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f859baec975556f1d7c4e90df62c4a..a3d477059b11c3a5618dbb6256434a8e55845995 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -520,7 +520,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		addr_l.addr.family = AF_INET6;
 	}
 	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_l.addr.addr6);
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
 		addr_r.family = AF_INET6;
 	}
 #endif

---
base-commit: 9c7ad35632297edc08d0f2c7b599137e9fb5f9ff
change-id: 20250114-net-next-mptcp-fix-remote-addr-e7e84620e7a4

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


