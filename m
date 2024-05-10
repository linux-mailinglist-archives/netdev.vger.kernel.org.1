Return-Path: <netdev+bounces-95413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B03F8C22FB
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC5BB20C0E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6017082A;
	Fri, 10 May 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHa//+Rm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52D170820;
	Fri, 10 May 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339944; cv=none; b=htr/kQKmbMj2xz4aAADX95ae3hkepjjlSZav5Alps0WHUzmobYxqXNnLBKOWT9m1dRnT8WbTgA3henpcaZQqcnlVaGWDGy+N49WWHfkjFzEA5f4zBx2JmGA75PCijSmwSVuQfyLNGA5gEIsY5y7Ssqn+q0FWqTSLz5CPhTidhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339944; c=relaxed/simple;
	bh=pINmx7wjasMIzKOzIYi//6CSOIrW7PFU3u6Ef24zc9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxZJ4fYWzLLSi1X5Z3af8zkE7N3EYlHxhIXG0Ab4q67dMP6VQJBTU7ijEDC/csDxNs+YVcCB69IKqdby9teFWn4b5f9S2s1vlVy6dXFsBB3qh/RsA4xQuoVLrmgWJ3nN/i6d6BwD8YbzXojqShOA0s3Ix9zKtHUHDt8TvWGSXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHa//+Rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6B3C32781;
	Fri, 10 May 2024 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339943;
	bh=pINmx7wjasMIzKOzIYi//6CSOIrW7PFU3u6Ef24zc9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EHa//+Rmb9cn8zOi/ZXRzswfG6jB2dAFNCce7FVetQwXVsX63XR6/B4qHXlnCN1iP
	 PQCeyLU4UI6Qk4SN2AxV09E1l0R99tDL1f8gk644A2McCFgsiHWn6KP2P4sfVoaNAb
	 0Ruu0t6DLQpv4KcDOF3RiEp3Ox4wo/s5AjjQ6MGPDFqcyp8AJvfW5Ga7/ErVKHwqDI
	 acF5ZRFEKctrH81FHdRLomzVreWR5w5mKaQ0d/0rnS7CV4ncZ3mnOyh89DWQ1nMVxW
	 ciL4Ii2mQS9mLWN3QQtbZsN+YbmzqqbX6J1JTsNm6wEhyz4KqHE8Rp9cYf7YMbD7Ia
	 mbPJNtvAcLdUA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:33 +0200
Subject: [PATCH net-next 3/8] mptcp: sockopt: info: stop early if no buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-3-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pINmx7wjasMIzKOzIYi//6CSOIrW7PFU3u6Ef24zc9I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcH1RuhQuyv02ND9Fv6tMewkMKpuR9jyHCj
 W+eN0IGmNOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 czetEADP6o+iepSNJOR6IvzfH6OZitnn2NkgObMiX9GYsoNlivJSa8H9GnhY02y/dp1D752Rw/3
 6W2Z9V8HEEr9Ot5taL8BeTq+E29h2svpLufGn+eIPi6QsdqwItEj3h5P5SlYJO/X86KtxeG2bvQ
 +VplqCDQQHHFm0w6Vvb3v1ChyX1xwgqEQsBU3YPm4D7GIfJl/893gdQ8PHER+zTW1bsep7N5p1C
 MGetQY/zFJdtBMO7yYhD7XsQf/YpgK9nu2zDjZjqlSRvV+2erk6X9f01l9voU9jmrWZCKMLgLbZ
 e4SLqXl7wC2oFlqNvG9mMeOfCU67TDOJNHBtOto41lP6EuLkJSt/sDUHxnKaUT76MGpQodw7vkz
 7qONNGC7WQIqSpPwBiC+2z0QPeOP7y1FYKcZStEuVzftC9BXOQYZpRCxrJV+6OtIzVGoNLYfGnl
 8yZFKKL1Qw8yJphAitItwYMOsYuTgz0U0IEufRggX4fqaBZRlWkg2eVdl2MRZZOltCnkbrfPHv/
 qVBj05h6jYvT2zaqrOdHwoDNdgKaOicfVo2VUJ+CyM7WE2raiu7qEvobYhhSRaxE3VzWNXeIN1+
 1Ad3karsAmZHV02qUcjcwwWqxqe77HCpaOyV0ORDJV/ZplZ4WsLbk1MKjNSAmSrl+ZbDAtxnYIF
 6rI5krGOW0MMMmQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Up to recently, it has been recommended to use getsockopt(MPTCP_INFO) to
check if a fallback to TCP happened, or if the client requested to use
MPTCP.

In this case, the userspace app is only interested by the returned value
of the getsocktop() call, and can then give 0 for the option length, and
NULL for the buffer address. An easy optimisation is then to stop early,
and avoid filling a local buffer -- which now requires two different
locks -- if it is not needed.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 63a3edc75857..cc9ecccf219d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -999,6 +999,10 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	/* When used only to check if a fallback to TCP happened. */
+	if (len == 0)
+		return 0;
+
 	len = min_t(unsigned int, len, sizeof(struct mptcp_info));
 
 	mptcp_diag_fill_info(msk, &m_info);

-- 
2.43.0


