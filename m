Return-Path: <netdev+bounces-168604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CDA3F956
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7FC3A5993
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B21F4295;
	Fri, 21 Feb 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvyLLQYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDC1F4275;
	Fri, 21 Feb 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152663; cv=none; b=IEOaAun7vr3DGfkktm8hBFs9LgI9daa3VS4ZKGOFcwz7eMxwzy4kbfUrKcEc5va5CfhhygzDAS2+1I2JMt1IP0yt10WHAd38scGq9U9Ngv2qXhlKSw4VjR7RgD5zXRAqdEYfaEqWsUiFTDTV8AKRJ5IRu4iQpez1UoUPLAcHCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152663; c=relaxed/simple;
	bh=J+IXwnOTNXP0fpRQ/SqXuNG3muK0hvCfC2BIDBbhPT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9oYpamrYeXLi/PpMAeFrmzBuO0q2yVvcURATuqI0uvOoZdLh2Xoo0cLGYqdeqRNldidBIzYPIgO+JrJeETijZPFg3iz9USzvLseDu5bVSTL2Sskel8hKbmDMm7gAxDDbcBuE4kyWzR7iZwruQFoHjv7FmPbMUOBWV3beo1h1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvyLLQYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38BAC4CED6;
	Fri, 21 Feb 2025 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152662;
	bh=J+IXwnOTNXP0fpRQ/SqXuNG3muK0hvCfC2BIDBbhPT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvyLLQYOL4ddBQb7DYF1sphenSwCA5ACfcRQ7NBrTi4Y4QuTn9UfxHrtO+TW6V75m
	 gUG7IkuBG0SSoubUVWLGEWIC0Zxw+/rGasYsOBwepjCMiOePATThMy0a67gdtmMe5B
	 4XLqERPNG9BKp8akJAb6ylf6yVMngNsRACfs42DrDLRY3k3VV7BMqtPIrcHQXkQrWX
	 zF5YiRgqS8e8vtgvK0kgKeKyZXSpftufzw7nSwfkWqeZ2Z95lbRx7I90okBlcTjvfo
	 q1PhwTIXgp11IiGOSukwCfHL1jHHP6tQCVJLm/qv5OjM4JGtFQaAvsUnz3m+s61o82
	 y46LfRHfFuCkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:43:58 +0100
Subject: [PATCH net-next 05/10] mptcp: pm: drop match in
 userspace_pm_append_new_local_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-5-2b70ab1cee79@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+WHQJW9mFchuIGDnd54gHSZuQ8fDbAw3VW8ytyvo7ME=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9H4PJtjy3xdXnpJ7jp34XGXnSRSQyO+1RyW
 qgN37bR2ueJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c2ikEADYykoKvmb15wQS+cf/vzizuepPoy39GxXls1kSuAUUvonSKoBBlsSzCYx5QS2vjTpKpXZ
 0kD+9p4QNy+3Jg5+j0Fd3xHUCU3oKbR9XJLz42JlZBztWt8586wDgDNzZBjsp/jvZglYwYTKQg0
 pvxl5urarPbmxiAnuG83zn2EVuGUet9qE4LaO1qLViHHjZtSURAqsU4xXn1VJFsja7eZusIfz++
 SEvmabDnlRYEA4G+MfUpLZHMW87LL5jSg3+sjS7RNct1p+4C2OAcskDu+d1/x3y6qbGd5p22RYq
 DOxQ8o3y7ZDeFrmDYktGBKFHCKVSfFToHVwX2EBIzCLG4NAQbFuv5GJmTF7jjXJDcMPZm5Hc4yD
 Po9v1NjdSOVN77/uPwQe4wxolCPQswN2/r+8a5ZgpaEedO11PfA9IYrDq6ccnlEslr4WJjMX9h+
 028CYWLcp/rxLTTy2Ld7HeZXBX7TdPwv+/TpxEnGCVaj7YuhP5ln/72vk1n/HvZFiL33+neZ05G
 ih9UFyJwMB2alWeKIY8y+cO9EWffdnsyNG+c6UPnSlSH5nzZNUscFX0ruMYV7QVb8AzB7Fjfr1K
 r/mWIYNkCUPI+YNE7IMTZNE0qgE9FCNV//rOxqamK4NEeL9byWhk+x9NZQ6lEUaFsAE2ip0+pux
 wmGx/gZch3WHA9A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'match' in mptcp_userspace_pm_append_new_local_addr() is a
redundant one, and this patch drops it.

No need to define 'match' as 'struct mptcp_pm_addr_entry *' type. In this
function, it's only used to check whether it's NULL. It can be defined as
a Boolean one.

Also other variables 'addr_match' and 'id_match' make 'match' a redundant
one, which can be replaced by directly checking 'addr_match && id_match'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bedd6f9ebc8b07871d317dfaf65135342cdeeeee..a16e2fb45a6c68bc0c3c187122a54765ef0fb259 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -48,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -63,16 +62,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
+		if (addr_match || id_match)
 			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
 		__set_bit(e->addr.id, id_bitmap);
 	}
 
-	if (!match && !addr_match && !id_match) {
+	if (!addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -90,7 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 

-- 
2.47.1


