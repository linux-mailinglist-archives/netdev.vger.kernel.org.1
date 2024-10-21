Return-Path: <netdev+bounces-137541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95179A6DD4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6D82817FA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA71F9AAA;
	Mon, 21 Oct 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tULXF4Pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAA1FAF14;
	Mon, 21 Oct 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523678; cv=none; b=o0qVaSo3dvJKp8nIS8ii7b3JXj4LYtM/6IHCViE7UM/9heUCspsk5I60cXFtb2YDqcmWRMaUBDgcI7iLWiozY+yHF5c5fBvEOfYYvUyIdHINhosL2L8YPi/r2GqfFesGaHynItMUWvrdjuLRA0zW6g920QKi3RHoioxl14xN3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523678; c=relaxed/simple;
	bh=M4gPPP8WBXV2kHlMXNqnYefCKiRRE1r3jiRrHS8QQmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4fnwncnzSYgy9RL4CNt0caD+1Z23X/t/UBAzq1vbThAk5X2fzsQrum1MOKc8CWMYGkEq6c1gvgi+jT1kgaRC9XVONvwmViG+ZH/WHRvgt9MgNOuWDZwBlw3ORxELKMgzNSf9s65uzh6HRlmo3k7Iiiw6Pnp2Kx7T6OE4WA2wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tULXF4Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5FAC4CECD;
	Mon, 21 Oct 2024 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523677;
	bh=M4gPPP8WBXV2kHlMXNqnYefCKiRRE1r3jiRrHS8QQmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tULXF4PlMYT4RoeEWgrCWZ9q0Xkl34N7eNw8fkwZe5Keu1H1LmgPPu0HzVbkqtric
	 bhVp1E/8LzSM53RlaXgAHW/7b49KaAxlmc6ysX+C2V7gdE2hCcOHeYIp7o+nYxNeQY
	 cJMRCxagBeZgNZZXxht7vGCpLwyVJYPwdTvMWzVSVgmEX0sCCWMa07mJqumQ9gAeqC
	 1SPaxDYjbkGCKtUUrjvPSpkFZ1ehTZ1pUfMsVm/1cY1WjKiDxqR+dcOmtibFez7bLE
	 mkbSymIt+WRsjNjDX92a7vIdNIFOLZ77GrmKAM5ly+gK+YAKav8hkk9D+hELbjP+QF
	 tUFDwewV4Y5jA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 17:14:05 +0200
Subject: [PATCH net-next 3/4] mptcp: implement mptcp_pm_connection_closed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-next-mptcp-misc-6-13-v1-3-1ef02746504a@kernel.org>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=agrTHeEkp+bsi6wma1yUOugua1XDIq5XGUvPVwsQ3+k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFm/SQvVEebUgTCd82ssFUoEPFz6smHVpKZ/Pk
 UyhjloWt/aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxZv0gAKCRD2t4JPQmmg
 c49zEADvPuiwMVcKElM7GNwUwbEu7noL7c/L6GXYXcrb6+MZAorpoXwN3z+xqVSwm9FMczBOK7+
 Ys5KAtNxNkM8shpkbGkMK2sDVmjhpjHbzSkfeCHXpDzaDAkZmqiyrNQEpmGrfLRae8i8QgtfvtW
 kvi7cNv6zhP/drhAe2SqN4ruuUs/zk+qnO3pm9S0LFOJ34oYgy+kkqSYwDWMOuUsr+ZOldgMCFK
 FgjzlWOJlIle5d/ruGHnMEWDWPYsTHe9Bfnds/xGEobvhm+4WBN7is0Zn1Vm+1kBHgkO+madb2f
 fmeCWmDsyoYOHH7ewiUD6HW8OZdh89HJwvmQ5eo0oOyxqLB9UV01mXWuBbe9vD3Rt62Zao5UAY7
 UpM/fJuG5j33qwKhxubGdRDLW9GmnPnrmYDg6y+5JErw3pd67XMnI8zRYQQWGA9EEUMclxKlES/
 EcZbkB3qGDWqXOkNLQLdnu8LBqkDIQZEAKRRUzBZA9FaJpnW11P6rzvHnTofRZS2ZhWns7LMMYy
 VYUGTwdrlTyGAC3cZW0sTOz4Zw2EQnbG5vqO8lDpXo4TwC358VLR9+AlgBDnVt03qpuIPHwG3Ya
 6UTaWITn9uMEmSQ68LiKCp9jn4B+2qbSUvRJ1U4MHkH+jd21nF0io+GUsW9GXn1YzFvKQJpFL0u
 lj4ufNdaBVZnLvA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The MPTCP path manager event handler mptcp_pm_connection_closed
interface has been added in the commit 1b1c7a0ef7f3 ("mptcp: Add path
manager interface") but it was an empty function from then on.

With such name, it sounds good to invoke mptcp_event with the
MPTCP_EVENT_CLOSED event type from it. It also removes a bit of
duplicated code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 3 +++
 net/mptcp/protocol.c | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 620264c75dc2e3b79927c5db44ec6ce84d83590b..16c336c519403d0147c5a3ffe301d0238c5b250a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -154,6 +154,9 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
 	pr_debug("msk=%p\n", msk);
+
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a6c9661a4c45a00e982d0f68f21621c3cf33469b..e978e05ec8d1357c4d40cd9830f7dd82a68cf4bf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3139,8 +3139,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
-	if (msk->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+	mptcp_pm_connection_closed(msk);
 
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
@@ -3206,8 +3205,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_rtx_timer(sk);
 	mptcp_stop_tout_timer(sk);
 
-	if (msk->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+	mptcp_pm_connection_closed(msk);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow

-- 
2.45.2


