Return-Path: <netdev+bounces-241140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E8C802CE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E35B3A1B9A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635782FD68A;
	Mon, 24 Nov 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1QvU+eC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980E2FD692;
	Mon, 24 Nov 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983190; cv=none; b=Vb3DIvormZ93YTYwdBPIrwkeNLVDLUtJkJhwrqGP1SFUmRxTqI/o4LPN7HEDN4ZJ7GJeEsLwRmcF/DVjvYMlyuaaKoWni5V/j4nHJOqF/5B98DBGg/nJUXXMZhyN+LBTlCFmIOhTwz3c7iR9q/WVXfOAMbz+N5yPifArhLIjV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983190; c=relaxed/simple;
	bh=33UMzi5ALatwQegwEyJbUX9t+OpATSj63Dck+HHNBac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7sUp+VZe2GQ0+ITc2iD0EWy2xXSpxbcSo1m+0n9RiZWWiWEwmLasINfoe+gMsfh7x6GWpdLgHCXej5sg/LR9+I5IVsBEHqs0FeLDZ8pee96pLZFlfLgjumZ7EbBDusjjt/xzhUeIS5M+hgJClfTvFt2/CJmMfknVVN1riXppJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1QvU+eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B93BC4CEF1;
	Mon, 24 Nov 2025 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983188;
	bh=33UMzi5ALatwQegwEyJbUX9t+OpATSj63Dck+HHNBac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a1QvU+eC8FsMLwO/b/53o+lQhkqXWYX8yrDCi/BRq+OdvnA7S730O87W/DTw+DotU
	 C7GRV0Zmz+y+9XrpmaUp7TXFndxQi4kBH/qvbw4FBv8r/kCQ4hLJWvkwfVe+Pt8VZf
	 SKtDYQAAbCytTFBClfCDbHDUw0tJ3ShcM9G/TtOXeiuWWWbQephhwn87k8S5JuMUGi
	 z1CIupx/wxKuudp2KlqHRkkgQZvMdRKUUg5em70+aRDBJG/3EFOZ+suLBr6K2UZn3v
	 sVecVOJSmVGxsoJUfzOSOSUwD8e26cHbd4Xqas7jJHkEad5UMx0TCOuwiEk/zYBTEs
	 t76r3U5OtK+Qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Nov 2025 12:19:24 +0100
Subject: [PATCH iproute2-net 4/6] mptcp: monitor: add 'server side' info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-iproute-mptcp-laminar-v1-4-e56437483fdf@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=33UMzi5ALatwQegwEyJbUX9t+OpATSj63Dck+HHNBac=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7L1rF767v/Vd+b63WQqVczct5F9bWxMv+drEaMLmn
 NnajmfSOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaisZjhf8m2CRMMT8Um9t4R
 ZPs+Mau06/9zvnU3kyb53BKQcEg+zcbwP+yNY0ioOUeW3cachNkfFdO+/drtcejwSz+vxcLPKw7
 cYQMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This info has been added a while ago in the kernel [1], but it was not
displayed in 'ip monitor'.

Now, 'server_side' is displayed if the attribute is defined and set to
true. It looks better to do that instead of showing server_side=0. Note
that since v6.18 [2], this attribute is only defined if it is set to
true.

Link: https://git.kernel.org/torvalds/c/41b3c69bf941 [1]
Link: https://git.kernel.org/torvalds/c/c9809f03c158 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 2908b69e..aaacc0a5 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -536,6 +536,8 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])
 		printf(" reset_flags=0x%x", rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
+	if (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))
+		printf(" server_side");
 
 	puts("");
 out:

-- 
2.51.0


