Return-Path: <netdev+bounces-144536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC89C7B88
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2482896A0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05F20604D;
	Wed, 13 Nov 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsDYDsVz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C29205E13;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523628; cv=none; b=VT/BSaYszIL0OTJnsV76mdCnewk97t0ldic8FfqFab7hXe+OOYotGirNUmktc1g+fSoyzeyAVwkEVfpu9u7m1omOuqLMca4el1a1MYTUdl5aVmc6BQUwPzyZlmTN11KnD3NEAadBcTb3xSjLdKNuA6rbS8t9YJo+NaDEfXmy4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523628; c=relaxed/simple;
	bh=PTBVL2tPmPN6P0/h38z8Y2oc6jqzgBOjiS1aI01AKeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjnSGe2TjDQKh483R+0zVaoS6uzBNpH1ODiZC2Za65TKQdNSMQGmakE22ZMnAGTSgoMEAdpVjGaOd4nTwDI9xPq0UcR950RpVg61hnM8G64x7z8+J7PJOPdmw3OnukHy5FXbsWdHd96ER81iSp60Dju5hSL+gTptW0vG/Tkl6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsDYDsVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A568AC4CECF;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523627;
	bh=PTBVL2tPmPN6P0/h38z8Y2oc6jqzgBOjiS1aI01AKeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OsDYDsVzVrPdBnUG4IQpFYZQEfL4QclBGBwUONlLvNjmgLm6V+TloGIoYEPHwGTy0
	 tkz2UBdyvu5BSOFaDGNHBlcQlF8nkB2CxI5//IzdiIi+BRrWoV283k/Lp6z6Qf3VsV
	 mcHknwgGXH2Rh2Yqwo6luktMRKJAj4k0Os7lMeDCcQjwk6rpHL4F29CW0QwVzoHypk
	 TgPVn2L/ZCtJ/OqrcGQNvakEp3QxK3Zql4Rei1gEvIT18FSAOBrS4sJk6vPqCNq17Q
	 NrUICRLOaXYgyMQVtNMDbTQo7kWl8Ij/KjXUERNp4y0+7OIag0cVD+4Io6e2ihebWK
	 R7kxEBpb23DkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91040D637A9;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 13 Nov 2024 18:46:41 +0000
Subject: [PATCH net v2 2/5] net/diag: Warn only once on EMSGSIZE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tcp-md5-diag-prep-v2-2-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731523626; l=1040;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=yIywEl4vHF1DrEzww1U5WkkGaZ14BAMY3GjreNIr5EA=;
 b=ahphbF5AdQ/YmMPb55wCdyrbqn/6GMhNcA7jAD8XjpApgUgjhWRAjpue/f/P1DrnN2kU89FZ+
 GTRYqJkq0hjDMElCMf254wHTm+cB5av1JauVhNtee+mxdyHaF/mjKwV
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

The code clearly expects that the pre-allocated skb will be enough for
the netlink reply message. But if in an unbelievable situation there is
a kernel issue and sk_diag_fill() fails with -EMSGSIZE, this WARN_ON()
can be triggered from userspace. That aggravates the issue from KASLR
leak into possible DOS vector. Use WARN_ON_ONCE() which is clearly
enough to provide an information on a kernel issue.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/inet_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 67b9cc4c0e47a596a4d588e793b7f13ee040a1e3..ca9a7e61d8d7de80cb234c45c41d6357fde50c11 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -583,7 +583,7 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *hashinfo,
 
 	err = sk_diag_fill(sk, rep, cb, req, 0, net_admin);
 	if (err < 0) {
-		WARN_ON(err == -EMSGSIZE);
+		WARN_ON_ONCE(err == -EMSGSIZE);
 		nlmsg_free(rep);
 		goto out;
 	}

-- 
2.42.2



