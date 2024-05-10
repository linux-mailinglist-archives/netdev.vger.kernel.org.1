Return-Path: <netdev+bounces-95411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E78C22F7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28C4282908
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41016F0E5;
	Fri, 10 May 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwy4GnLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483B16F0DA;
	Fri, 10 May 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339938; cv=none; b=pFPPc1yy4xueEZFDDQ2DXP0Lk2Mk+9YcHzSG89BQRqLb9NH6UbqdUx/0uT/Vh8+Xi44Xu4n4dhQawe7xdUQHzV3MOqQ9Hc1j3Spf/y7sit+kGfW9PqrBvOAwOyw5SsOAROHSScaE5wAgTrR4Bbn1fdLwTaWGFWQBUmhpBcoheLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339938; c=relaxed/simple;
	bh=e72oNWyYzu0S4cUwcbJkoVMrT7hFjweEktpyclaET6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHsY9kcGUD3SrKibe20AfFdITxxKfnul1qykkeXGtiLA1TpZFVC8Bqpv/qPruoLE+YIfFt7Va9+x8k8SIJj12ixspNFxc9ecXG8ah9YEvmAGtt5hnBIwbElkCBC091fvJbcAbkZQIbkk+EuVcW8A8+w7n3UeRlKN3OY7RTMDITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwy4GnLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12729C113CC;
	Fri, 10 May 2024 11:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339938;
	bh=e72oNWyYzu0S4cUwcbJkoVMrT7hFjweEktpyclaET6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pwy4GnLC0r5k93j8vZc6EL/Ule56xU/cdUIsmZtzRraInzpI150pNndl0L4n9+Xf0
	 SbPADg/GPvU9MbRhelCo2yTjNJJd38P+eWSKMd70iOw72ilNA6a/ya/Bp0oAz2qoRf
	 N1hVRUc2zTdfFM8jjmBc+sW9Wg3GIJVuog/ORsOvQC/NCnnvbYj4OHyBmM36kSjNFb
	 O8KoMSWJKH8DaxiyqzHYZquPqcrLhgWlROGv5dRH5+Ywy3oClvPj2CCWb0uBTi56iG
	 PCmb9RK+o/F8Pnmfwu9YIf3OnmakWsbTIRG9SRXxjvqQnPpsoGAXZEXg6is5ogoGkq
	 n0xlsO3Mo5frg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:31 +0200
Subject: [PATCH net-next 1/8] mptcp: SO_KEEPALIVE: fix getsockopt support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-1-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e72oNWyYzu0S4cUwcbJkoVMrT7hFjweEktpyclaET6I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcli09G1VxtjxaHvlHQu1/+J+WFb8w/44+s
 UZ6ZsWjT9WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 c3rUEACh1Bs3IPBnK6zn8d3s27ZT8sreHxXUt+ZCmGxBhEcxASY6vCXT02Pn/kccYEgE1Bb3esa
 9fDnx8Yj4QhM7AEks4QJQOU3pV8b//X1HrfNlFRdWlRO5zvCcxzM+cE9xAQw2b0Mdf+2aT36cg9
 x6eGDWVaYSEQyWvUUlhPitSbX5E++Qsx+mtPkHEeTXUwDVQQwQ2y4pZMX5Q9W/p16fJ/oS7ZO8A
 S1gyK1Gl1DZYJ8tXzWw7BSm51Xa5XvZuNKfeXZg6EdUWps9j+LmP7iTueDL5Ef8pq9t0p0fsSYS
 g6ZDvUHhjgMEtIVqHv6JqmZxnW9FyGeYsMHtB2V78NmYkQZFbQR2TlO4UejugheE/jzwKAaLwpk
 XSIvrDzfLSGKmythuSmw8IPu6Zt7fhlMnv1KS2RrntH9ILnDywCxN++UlLMqK+76+zsKmHKKPaf
 W4cq+onNNG2ouTSJQSfxx7Z663nZYbp7mXCh7rVNEvFU/2CFzXBkZDl1ggoDmwyNiDjge9WHD5Y
 BtL37jEtkHtXshZgcUzFF4N5TN9ryxwRk8pggJj/OFpfkQ37j/cs3hTpc41n0jj7ALyhquh/OOp
 2vqhyYbOz8U6X365izSKma4KsRP7rv3eP9g2QBHR182ueQgQ4EBxlnVhCQRcD13Wi/w3YN+A9P3
 Gxii9efmB/ubzHQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

SO_KEEPALIVE support has to be set on each subflow: on each TCP socket,
where sk_prot->keepalive is defined. Technically, nothing has to be done
on the MPTCP socket. That's why mptcp_sol_socket_sync_intval() was
called instead of mptcp_sol_socket_intval().

Except that when nothing is done on the MPTCP socket, the
getsockopt(SO_KEEPALIVE), handled in net/core/sock.c:sk_getsockopt(),
will not know if SO_KEEPALIVE has been set on the different subflows or
not.

The fix is simple: simply call mptcp_sol_socket_intval() which will end
up calling net/core/sock.c:sk_setsockopt() where the SOCK_KEEPOPEN flag
will be set, the one used in sk_getsockopt().

So now, getsockopt(SO_KEEPALIVE) on an MPTCP socket will return the same
value as the one previously set with setsockopt(SO_KEEPALIVE).

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1fea43f5b6f3..69fc584fc57e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -181,8 +181,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:

-- 
2.43.0


