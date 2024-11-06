Return-Path: <netdev+bounces-142491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B429BF59F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9421F21C38
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255520896A;
	Wed,  6 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUCgvukC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA735208219;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918995; cv=none; b=VwY3l8KEWMo08CO8B40bfPMA/aKwmDg8MzREV2mffjyT4r1U8SrXINnMIvfQiueO6DGw4cdCKukPmwbZsCUk5HZq9672ulskzmo/iIgTOM2zFC7E+lk73rTOvQGa+labbDxogxqbFIDCft3AB275qDqq8uLeUdfyVD2Tlud5LQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918995; c=relaxed/simple;
	bh=PTBVL2tPmPN6P0/h38z8Y2oc6jqzgBOjiS1aI01AKeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MhgQwbLvrOVfrmS/wQLP2K+tGvEDEFeWTWuCcOBGHuGjiCFkSc78Pno3ZG7MoafQJNW4RD8DfrCPvv0rfSNVE9uQT49H6uu89US+6EbxgGcuLLfFDEdW/hn97TECH4MANM3ggfhTNTVIwsmXSpNGK80d1rrgtQODrMbmWH4Pl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUCgvukC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CE1CC4CECD;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918995;
	bh=PTBVL2tPmPN6P0/h38z8Y2oc6jqzgBOjiS1aI01AKeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IUCgvukCE2xslOF/m4R+aX/b1Mo4ERsVCh22l19vBv/Pv1OUXioO/sJf33MH4ApjH
	 kETYe1FfmJMKGCzG5J9Mu4Pb1zLlEAM6WvtYe7FP/yldtARcgjz/AHMxB9Rn4HKBzC
	 miOFydWNx7l5xqv9xCsBUln6yFKeRmC/haMKodW54jwiomzNYV/BWg0BDldXXseX+g
	 zPg3qg6LYFVrI54ZhhuQF/gUEZL9FfRLeue7gCn2RCKoL9BEisoKhPhX22qgDV7o/h
	 h2+MTjTFyF+kl79lEtLq5OrlMTF6RDftRYaeWgIkYCX9xaA9iR8e0Bdl/LsqOvIvdG
	 fszOAv0aWMTVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C268D59F65;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:15 +0000
Subject: [PATCH net 2/6] net/diag: Warn only once on EMSGSIZE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-tcp-md5-diag-prep-v1-2-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730918993; l=1040;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=yIywEl4vHF1DrEzww1U5WkkGaZ14BAMY3GjreNIr5EA=;
 b=bEe3Nj9Ft2qwDiKOg6KHN8UOZdyHHL7bHoshX5SjL0EAZKvZYSRS+mbNynLT6KyczIi/0eUzz
 85bYlJhVu7LDv+U41rm8yFwML1IPrO7jppiwuqrOGVdv3zmyeZetppD
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



