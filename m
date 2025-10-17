Return-Path: <netdev+bounces-230489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E50EBE91C0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C3124EED17
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51D369998;
	Fri, 17 Oct 2025 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AyaQT7Nq"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF17332ED8
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710322; cv=none; b=uQi5l/udEC03kBhCW3HO2kNmUM6mOWzSBxrBLrt1hrjFXewLYWPawn0Y4rn2pQORUW+hcaPNY9B8deLsijrLJSrlZND+057zaNM4wryXMfEvnJLl1gkvBhqk7CL1W4+DOzXgi2+WnNFONA/YLZwy/BI+5HnfNCKLEGWA9Ngh47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710322; c=relaxed/simple;
	bh=lRUWcpTWGYmqT2dWQv0TTLLEpP6zwqCTwDigPWa9O/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 References; b=BIcyDgbwxGpYDv271m4ziPMyIGNLnZJkPa8Tjb3RJFNWjoN+J8kcE8GVIi1mBc/4hyIuZrlc0PSgH6JkbOXiLYoeKy/3SJM1WsEOzlEDlHnIYU9YxPYKIfkdjRCQB8meT6sLseee9sLZ30LvO55qpfctYxq8eaaBedz26xrGM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AyaQT7Nq; arc=none smtp.client-ip=98.137.69.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760710320; bh=EMa4KlUiE227lmZJYVcf84OPn7YPVxdmQXazQtbytCw=; h=From:Date:Subject:To:Cc:References:From:Subject:Reply-To; b=AyaQT7NqWNlui/RYvvIMnhqHWa6mNAmvPsnAOYjuxX54NazojCuQ9TxMjjDjzwZwJJ+hN/GsuTdV28Bc7kxViO2GnCamcXdEE/xmhLUUVLPG6FoejuCiTDCWjncNwtng895H//8GKTLsQ8pgiPAqM9YIMBBxXn3j5BSXjdcbtasGLTwp044GB7M/6MSIWl0yFMcYyAc3yZb8OD//PnuH866cVFf1LJKMtFcf12IXFTi4CUk5xz3OOAScKiqssObFfwag3FhyICMJkiMZP0wWsr6+pj/RLZJBPwXhBup3SMi1+5CW4m6pmJBoCGD7TwCj7GTqe2y/qvBUt+G/1Blqqg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760710320; bh=a8GazegIIzZbs3eWuiMa9W4I7lNRAxpbb/tFeJRbknk=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=K3kSTKPoGCZz9tdXTOKXLEFf4Dop+cv5iiGAc400E0GRfzR0R5ZUvMiDYbwKLXib3l1vslfB2/UaRGGzIixS9Nzgp6HD7b2C9QWzIu9W5LMrx0QSrmJBNT7fSIGr0CgRDBG+tyCzNWBKbiR1k9ruZ4KmYvr4nJxYFn/WNfSNOr0Tl0Y7vbcBNsBLjKHCmTiYkOuljP20P34IXL9FDhtlnttqPIGejVNVkx3qYAUrE5BwzLZpdnVp5K5hWSzdqfBzsYg/NoOZ0NHmN05LiOS1QoxhgJ5KyUfor49eHaHP6QljNz4OQW4PTvQMtYn5QeVQJSut/Cub/HnhRNtrSEsTjw==
X-YMail-OSG: 1qGCdhcVM1kMXAjtQZH.hVnxztwT8qEur40HHfLn0DU2ZPfVj.h4QwOXixQ0Dkg
 Sff04oRaENTWyuGROP4RZ2TMIhZFBzIL8BoXBFQu86801LiL8MiD67GTcHf8Fl7XtZTIoPN9FvGT
 1G4nD9.JDimffc1A_P9XTG4XlTfDJDPyN8BGhxsIQh.KBPY96TtQv8KPj1ePPypizA4fUnsL9mvf
 Dzgt3zts8HgeIUgN_5Pp8TG8pJl5jwsDvbxOzRKP4p5Y.PYrirgqihgCScF0Z5nrdpHit2Be5321
 CoD1FH_8ZC2wDCD5yPSwwpaFi1JkANeAOW.3RZiWC7jCUtf_ZuuK4UgZzfnFggcMhn_jAvsyNUTi
 pLPnGGtnj01NsF5jSJG1sOmmjG9b6bMRPa3N9b_ZY0KSTvxdPbT9KWouhYO7yZho698sdxpo_z_u
 g27.wFKF_tCUS745qwpQLmeMZntwOg7PTgys.DISRd8iP9Y1fuukIw6d7JzDwalW.tj5T6GciIPr
 oqmIkBnReFBzOZBuS0b7oX4GjV3pdSy4eAKa3U6X5OdvbiMipmtY_Pg9jBEB1ck1YteWXMHVwIy4
 XUisweBcnnmEp5LB18X7PqX1cgrHP5bFS7_GDxERxtG2nOYIV.dmrvr03h3bZmK6bUFW.mD.pzWh
 IPaxBpfev9swHOhvrbVTKmiO18YBFCFvXnLTSLsowP5E96Rwas5yR2AsB2fpWO21dRCi_pVJR512
 o4f.9K3rOiyZLdZrNEvGvlovZ38hY6gLYG43tNIW8W_6b1bMhWTMKFanPJcoGGxgB2BovrFJxDxm
 8c4TLho6v42ZIkmB4Etif8bMpmHgEVW3hCzyO3GS9KpN8.Y73VdY6HLYh57ufy.cGKY1jjAp4hZV
 niToRK1CUtYmb37zsPBU7zipkapppUKZ_3iVrVglX.UWOkNAPnq8u3E_PEFPYiIha4ag9_5gUcLT
 p2l_RT6YMtrucuqvC2..fE9rNCsd2MiMZhx9VFDajOoVvdlVabjUBwfLIo1c8B5LEHvVfoUN1My0
 Gxl9jkvXEKbyncmoKBb.GbxaOmar3uATK1NcF0EGwYu17byEARJoMZxnjJxNNHCScOaPoxeAazgt
 gb_vNU8dGG_pysSu3OhpEW89gH0.dCOSgcJCg6EaEmrMdWjPrslJ12XqzCTPVQeyC.NwGwJWlsbA
 6HBtDXcilepxvmDY_yWUYagL7dQdusMyi50LRBQ_balFV6DiytiEqzRlhvnnemC_Zsj1Kx81IOQ1
 h4asEDLXs_gp2ClLmYArKB5W7ZXUmAgCSfh1R06052q7x6rms9OvXD9p.SSyxLA637FDuj2W6gPI
 OItXcBJSLpabtSZeJ27oDKO2LmkOjALgwGKsoKov_BQ3948kirRrTrQgUMNknGd49lr6_Eg_zUa5
 zX1KPB7VpVxmMfFWNFvyKRv97pT4mz5SLi4RpSUNihmHGG80jZTqv5u4CRoc4UzBKkc8H4ks8S6k
 u.85MWqa8BvdrkWh4WUfxROjNioNtaQaVLhB2njXdSesWfxkKevy_tJfNUNvvGJWgMqScRe1ydxO
 8SdkzSzU2ZRA5eb04ZhsTJ7aRc7uS7vdubygTO25T_DolRZPatnzEgbare0joUJg0weL6KtlT_c2
 yFjDCq87Qx4AaVbU0_sbCoD8FOUw2hb8hBINhYOH0_lBwCiPHi1FF1FZFUzdGSvZHml2bFB8Dg_s
 PjO0NcVlvEr4tpbX7IY_FrZL9nLEH0iSvItnIY3kZg47oj5izo_Y_JU2btrZGO3lsw3aIbhzQbOD
 Rmi74.ExiHExdzFRy_5K91mAZEOkzrvT5OA5ryRy7SshATtl7aofH_bHGWh_.ohe_wFD9fK2KVGy
 pVNnPzu4SAowqdHPfDPrD6e7hpW06GSaXKPKAq8BV0_eWrEXAQAtFUmfMge.zKcQ2Ia4dG33RHzD
 pmkYwGmOB.Z3qfImOPs6PkpROmmjdgjgI5QnsN2wAwoJBeF445liGB4zTP4.sF.iYNeyl.oYUl10
 kIOu.ex8PY2qgsrC7._UoXpzRRV53S0AFx_waCg1I.pvZuqpXHZKq7T_fZ5NME1V6YM46_GTL5Xw
 lY1iggdfLcp28LkeL325Z8VWPIYUBvkjw9T6rOTC0nMAX8NvuVfKUcRRBo77.LXMisSeGqJWg5.7
 3jQvdHsFR7xOAnJ.4GVPDsRVyqoj1X0.x_AVMieRPX4U_fsRunzaUZIprJOMUkQmhkcWBn6VbaO1
 6_GN97Y4rqx7Z407Gh.Aewgg0q2GIGnIa_lJxQjMHy2H1UUHDgwVcpjQL_7sBrLIUMbBpriiykRl
 oMrkS4vPHkj5yw_y8eWAqjJzOq.wV
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 65cd7e36-a227-4486-9003-3fe66f46082e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Fri, 17 Oct 2025 14:12:00 +0000
Received: by hermes--production-ir2-cdb597784-5nnrf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1c6a6a081dbc139ec1a9e765da42c59c;
          Fri, 17 Oct 2025 13:31:29 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Date: Fri, 17 Oct 2025 14:30:45 +0100
Subject: [PATCH] net: unix: clarify BSD behavior comment in
 unix_release_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-fix-fix-me-v1-1-8c509d7122ed@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAARF8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3bTMCjDOTdU1tUwyNrNMS0tOSzJVAmooKEoFyoANi46trQUAWPH
 BCVwAAAA=
X-Change-ID: 20251017-fix-fix-me-59b369ffcfb5
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, Sunday Adelodun <adelodunolaoluwa@yahoo.com>
X-Mailer: b4 0.14.3
References: <20251017-fix-fix-me-v1-1-8c509d7122ed.ref@yahoo.com>

The long-standing comment in unix_release_sock() mentioned a "FIXME" about
BSD sending ECONNRESET to connected sockets upon closure, while Linux waits
for the last reference. This behavior has existed since early UNIX socket
implementations and is intentional.

Update the comment to clarify that this is a deliberate design difference,
not a pending fix, and remove the outdated FIXME marker.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 net/unix/af_unix.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec231..c21230a69f42 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -734,14 +734,13 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	/* ---- Socket is dead now and most probably destroyed ---- */
 
 	/*
-	 * Fixme: BSD difference: In BSD all sockets connected to us get
-	 *	  ECONNRESET and we die on the spot. In Linux we behave
-	 *	  like files and pipes do and wait for the last
-	 *	  dereference.
+	 * Note: BSD sends ECONNREST to all sockets connected to a closing peer
+	 * and terminates immediately. Linux, however, intentionally behaves more
+	 * like pipes - waiting for the final dereference before destruction.
 	 *
-	 * Can't we simply set sock->err?
-	 *
-	 *	  What the above comment does talk about? --ANK(980817)
+	 * This behaviour is by design and aligns with Linux's file semantics.
+	 * Historical note: this difference from BSD has been present since the
+	 * early UNIX socket implementation and is not considered a bug.
 	 */
 
 	if (READ_ONCE(unix_tot_inflight))

---
base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
change-id: 20251017-fix-fix-me-59b369ffcfb5

Best regards,
-- 
Sunday Adelodun <adelodunolaoluwa@yahoo.com>


