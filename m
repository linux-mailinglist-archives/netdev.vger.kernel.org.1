Return-Path: <netdev+bounces-289150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPaiHM5aC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:30:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B5572462
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 664A2306C5AC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547C38D3E0;
	Mon, 18 May 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmKHzgnV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238A38C427;
	Mon, 18 May 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128700; cv=none; b=Jcccjvu1GxuDT9WJ8kWhXLpHL5vPODfYfF2ZiDU6jzZr3Hd2qmLhlTuqrucPayUzm+pxCxUZ05rL8GQFOAz6o5YVtUmcTcwOTefjYv51KblEFRu+qx2TseuW7Jtx33SQIHI9xQaSCMbi1fY2zenCRo2UEz2HrU2jtqzKysLmzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128700; c=relaxed/simple;
	bh=Y84GsqMZH3S9Oxo1jGVwdFL4nBULJFTA48F/5LHByu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPV5fc1CuUVHSAJ2lcVnEHGvulWiGw0Rq42BAQpta6bYnT5tP9cxdt5cu3UwR75m6/aw6G0ZSCAYIW73HWBxZxznM9n0CNVhxV93NgV/9tzHcg5ovv7rouzeBXr3MJNeeFJWYKdRqC26YU2n8vmHGnN2NpxedajPmIw1/aUnPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmKHzgnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D619C2BCB7;
	Mon, 18 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128700;
	bh=Y84GsqMZH3S9Oxo1jGVwdFL4nBULJFTA48F/5LHByu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZmKHzgnV1zOcnC1LeeQQsmc82fIpfB+dlWX1q+tKzRCGGl/FgWdKAKLvpzeeXPqB+
	 zZNWhcmwbNkKXy7cYjzlfn0Ui1CxqYWDGStt8WLHIvnBP8X8vnie9XEnNJsl6lnvg4
	 W9E5GVPebC2qsgtImPg7RljXLa9viU19GyXDVfDykYlaPVfDg3UbwAkCNgWtd7olz2
	 h8zu+beYSrSRZ3T53EU+T/XjuP03OSUvc6DBAtIhqPrJF9dZYEZsEo/JbyNd8S/p53
	 MhFwjCR+HFkl2jNyqon2knjfDUibAgCw3zn6kcog2o5a6izwji0eIZP9O/LuyJetD0
	 Pi3Z7Mf+pdR8Q==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:33 -0400
Subject: [PATCH net 6/7] net/handshake: Close the submit-side sock_hold
 race
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-6-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=k9ndcmxWIdqOht0wMxjUop1uvWrw2thqkYTfWFXfHD8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1+M7enEIBnttY1PlJLNawcg++wk+wRuFoF
 0cA3qnJLtiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l0aQD/4gi6tMJ1pxUtCPSoc6XBXQBpPOkQYr/KSEwKtrm8IQKiVWzckUOjE0PJ2l2ZBme6ynWAg
 ZEWU09Cht4/aZIA/L49vInnAJf8+dSEV2SzpKi7jqtX9LVl0snDVebWKXAKC83WxbRgpdvxo4cS
 KROatjK6YOWci39JFnoblqw7xbGQy8eILUoEr9FEVJmixWshTY1Fn2DrtJG2Sw/Hp2ih9jtGHLd
 Sxvth1d6/7YU7EQBQzHEnxzTjoksa7hoblMdBJzbk9NC3ZnyrEvvhgqdGKq25nl6Kz0Hp6y/AWO
 xINs7dCqUiarf4wTdoFQZ1B6xdliPjD/5xt7zjSyJK3rwWJANLxvEzBDOz3dppCLFZZo29QVqaZ
 4iwi2sW3OCpOXCOvhUjdRZpoL8Iry16rZtMD5J0IWWwpA4Hxwomwj9+I74/DUGytBRCLALoZ/47
 egWKb/daoGP58Yo/IjMRZysdvwV9SltqpV0svYWEztM4JtWgL/8ZyQ1FmmrnZrA2ZwMw1Xw25vf
 M4m9ofXetYFCgTVyrtVOExG8ZSReBL3jyAfDgdgVHdUO2TUKztnIo1MwM5/jmm6a2oSYCIXXWXh
 zM6cuXemxNXLSEGEgyOSsS+uc0RcYAqGBQ0Mon1oR3k5AaUCMBe75COmT6r1cBDKvUho1FhpBbF
 fG1MRMvYryAsE5A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289150-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: E38B5572462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

handshake_req_submit() publishes the request via
handshake_req_hash_add() and __add_pending_locked(), drops
hn_lock, and calls handshake_genl_notify() (which can sleep)
before taking sock_hold() on req->hr_sk. A fast tlshd ACCEPT
followed by DONE can drive handshake_complete()'s sock_put()
into the window between the spin_unlock and the late
sock_hold(); on a system where the consumer's fd held the
only sk reference, the late sock_hold() then operates on an
sk whose refcount has reached zero.

The preceding two patches install an explicit file reference
on struct handshake_req. That file pins sock->file, which
pins the embedded struct socket, which defers inet_release()'s
sock_put(). As long as hr_file is held, sk cannot reach refcount
zero from the consumer side, and the submit-side sock_hold()
with its matching sock_put() calls in handshake_complete() and
handshake_req_cancel() is now redundant.

Drop all three. Submit's pinning is strictly the file reference
acquired earlier in the function, and the lifetime story is
contained in a single get_file()/fput() pair.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/request.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index d24b55af1a0a..1c669c1602b5 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -301,13 +301,6 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/*
-	 * Pin struct sock so sk_destruct does not run until the
-	 * handshake completion path releases it; struct socket is
-	 * held separately via hr_file above.
-	 */
-	sock_hold(req->hr_sk);
-
 	trace_handshake_submit(net, req, req->hr_sk);
 	return 0;
 
@@ -335,9 +328,6 @@ void handshake_complete(struct handshake_req *req, int status,
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
-		/* Handshake request is no longer pending */
-		sock_put(sk);
-
 		fput(file);
 	}
 }
@@ -385,8 +375,6 @@ bool handshake_req_cancel(struct sock *sk)
 out_true:
 	trace_handshake_cancel(net, req, sk);
 
-	/* Handshake request is no longer pending */
-	sock_put(sk);
 	fput(req->hr_file);
 	return true;
 }

-- 
2.54.0


