Return-Path: <netdev+bounces-151877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F369F16DC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC616128C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8C1EE03D;
	Fri, 13 Dec 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0IEwRBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB961EE00E;
	Fri, 13 Dec 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119687; cv=none; b=WNxJYVq9vQtyfv24LzExo/aCE4oibfuz8t513+lDJw0nYiUlls8vJhHZOAe+5X5WYxyZK81/SO2SlwLfq4ffIHw+OwwMDxJ4JbOP16cDZF36Gf9rmtF69h2V6fv1Xzu07fbI7dSEnP/5+ik01NfBFQVvd58Q7ezm87cXwIJ7hMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119687; c=relaxed/simple;
	bh=7oL25jhFXzdbLw5+wM5A5ckyzaIWred6kZBGWuVszro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HeZIcZWCAJNNloMJfFX8nldjRiH6CVVphZ4pCmIkSIfIqWBzuEQVwbd6Vwaq2dUE7Xgyf24YuSY7vQC80MfB/csLOIVRYJopC/abQeIb9CM5sJ/LoO0YcIw6tn89KzDY7e7i09Wc9xGtEw3hta2+u0dYzD1DJUFTEJZTrhu75sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0IEwRBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FBEC4CED0;
	Fri, 13 Dec 2024 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119686;
	bh=7oL25jhFXzdbLw5+wM5A5ckyzaIWred6kZBGWuVszro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z0IEwRBBq1aJbH5BQBb7wG2L5dnWK2rseQ7exB3z3io7IzzkwiqsZT/hZlGY+qp0P
	 BhDrg3Skmjg5ThxJKym0FIXHPxRy7N/QiagskD5v6/G9LJMfHa8tQ3yY6Ki36zTiNj
	 e/PNvs1oe+cyI/bWv4HiUaNPxI7hACaSOyXymyp3P0mXE6k9LRBZJM4zJwh8yzXLyg
	 3mINu447aa/4AYPPQ52mdm89MbkcE4aYCPpQ+eKqXYb337EaCN/UColTylUGLtbCzo
	 DAOMjaBtdupnZ8KQL47S+hW6eIFq9G8dj9JeOcQ2lcMl5mnEN5IpM2UZeuT14FdN/K
	 n8hOSJVWadBlA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:58 +0100
Subject: [PATCH net-next 7/7] mptcp: drop useless "err = 0" in
 subflow_destroy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-7-ddb6d00109a8@kernel.org>
References: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
In-Reply-To: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rsC7IsSRZXPkUerMAAj+cBgM1aGHI4tEFgkPXwpi7nw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxsnXB+CRb9Ph5EgoNY/WPHborbSYNMoaXt
 OMDtI2pUzGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 c2y3D/90W3msnUl0x14ifXGyjR9XoFZOZpWoHdrYNpKncGXgAa/s7388ulrw2UXTYqq5C5k/lIX
 MFjPIS/CBle6OXe5nal9IfI2xiUjt9dbleIvlSgTvyebG6580b30E/qZBTZtunsD8uM21+wyBPZ
 q80V2c4AjikZ5edjeYmFbxYvGNLIdvWCXNa10l7NhIA8ss1J2TRTKwv8UEaiXG5vGg3iQtnVRHK
 hmk5/C+Yc3idfU6b9C1fnlR1oZxcHkdiiYcsZT23tmo8Vr+2etN4gUpo6YyLg+VuR+OH6CQqSw3
 SI8QdjaDIlmkSYhE4VlWGFoz1mi6jpPG24piKQPUGUvlg4SqZGFdZK+dUgQw7LqBDYMclU0F812
 7urADlamsg8pTmSaWgh+hDRVaC4JhAANvZRLaNnVF8MSnGCCoPJr6tLzY4zMT5qmz864Ira0VLJ
 uKCTqSNEQKB99d/ro3EpLKcpNVNsTRgAgz0BfMT1HLvAoJXnhqSyBMlHxHyhPSqSvQUUinOXD13
 PZjJxhborHj+4ha/TMolrHIlP7q54lkUBO209Qm0NO2ESNWpUKbxAxgdt6eJww0qjV54QdC3uey
 G1ZPRuR00DXy6FegswOrBsRasBwXATsKXUn/APkQA3Y6KoRwnviC/C675T5HcZ8K1/TBFDnhHm1
 mebeauR6ocbMwkg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Upon successful return, mptcp_pm_parse_addr() returns 0. There is no need
to set "err = 0" after this. So after mptcp_nl_find_ssk() returns, just
need to set "err = -ESRCH", then release and free msk socket if it returns
NULL.

Also, no need to define the variable "subflow" in subflow_destroy(), use
mptcp_subflow_ctx(ssk) directly.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1d5b77e0a722de74f25c9731659b2c938122c025..740a10d669f859baec975556f1d7c4e90df62c4a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -538,19 +538,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
-	if (ssk) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-		mptcp_close_ssk(sk, ssk, subflow);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-		err = 0;
-	} else {
+	if (!ssk) {
 		err = -ESRCH;
+		goto release_sock;
 	}
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+release_sock:
 	release_sock(sk);
 
 destroy_err:

-- 
2.45.2


