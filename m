Return-Path: <netdev+bounces-96225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB98C4AC8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E9D282ED5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8B1878;
	Tue, 14 May 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3xopNSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08717F6;
	Tue, 14 May 2024 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649222; cv=none; b=GekpI0dEMD8DL8MOe8RxN9ReKiyLm0pFkl0rbvjo/LzUEMIoxE5jfIXmzdTQGW2S9R0Ka0ThgrWch15PEYoquezrVaezmzr4LRzOFytHXvwsLf56Kev5bUaIG2Fp/inX6G4Yr/cxeogaF1Br+c15Iu5ZFJUow8qvDsOnRkVykbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649222; c=relaxed/simple;
	bh=4zTY02OfhcmSpb8ZPvfgLYjQbOm/Y95AKG0XL8osBME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCsaFz1OswHnGRcm5ilB8gN3+VFiIghLInIF+Vt8Eb+cw1ypTQ4MrxdhOWtzdZ8wvtd2lH/ibWaQdCbQ/Hd7H/uzQDqKn7ic6Tugj5QceS07NKqtMxhF3XG8sTL9+6lQnWEDxH/XqqEI/olVYCcLUzrfFmGnZGWRw7d2p9rfUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3xopNSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E7CC4AF08;
	Tue, 14 May 2024 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649221;
	bh=4zTY02OfhcmSpb8ZPvfgLYjQbOm/Y95AKG0XL8osBME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3xopNSGOxCXeeH81/fRTobn0aDldBslmqtazkY6oadIt31nXEJhSujeoEFMHsg+L
	 rf78IAoscZiSn5FBXvcQ76ZPxdwsY7xHzo3a0KvZjV1STh4y1vSz9Ea2KmvsSIpZPU
	 VxltQR0H4OzaxWYxHJdUERfVwIJ41+UQqKt/U9AhKiK3ljmxilcrRkcDkD1kjEySzW
	 /Z8ZsWfV2xdCasK2TBOzg7PYLNTagqB7XKNCcNjXBS119yCtXY7CJEOIT1iwsnkiHT
	 Ie680GgrxngRsRjsiQvrS6V9TJf4lX5FI5RR4enZb1Lsbq6ET6PvVGyZOtT3U+9FnV
	 PLT9bospnlu2w==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v2 1/8] mptcp: SO_KEEPALIVE: fix getsockopt support
Date: Mon, 13 May 2024 18:13:25 -0700
Message-ID: <20240514011335.176158-2-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

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
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/sockopt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index eaa3b79651a4..5ab506c96609 100644
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
2.45.0


