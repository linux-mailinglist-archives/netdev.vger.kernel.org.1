Return-Path: <netdev+bounces-290512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPEhJ+AnD2paGgYAu9opvQ
	(envelope-from <netdev+bounces-290512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:42:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C755A889F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32F88322C170
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA1337F00E;
	Thu, 21 May 2026 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N19ahjFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4A373BF6;
	Thu, 21 May 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374848; cv=none; b=MylnBLcIdX++62N8gyQSCWwKUgnuT5izJDv6juVQIqbKSGbuYMuHNwURsxwl1cKVd/7IE4VQTJtKr2l1mYm1uDj0seA2gjb0ZtDR5OwpgbmRUEUrAX5OWXbK8ELlslxRNI1NH38dC1sqvTBS1RGv3aFxkLxs5ro2WzvnkshvSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374848; c=relaxed/simple;
	bh=uMLC/9wXcfMDggIYqbMINXwPmpxq7je5yy+QkHTfUrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwywuuEVGmRkrhZ+1uiz5ablprMtCkSNdYWszYCxGWfzWQ7+ZFob518JAqwL9axB5uWJfQ8l2dObbZMgneFgnd8puzDo0zhayIM1gIY+pryJINnIaAFxvsVX675cFvBqrXHMDBLftR9G0lmScre5Ax9QqPcVZKmokFb047JJW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N19ahjFa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC87A1F000E9;
	Thu, 21 May 2026 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374847;
	bh=iH+hAZTnQuBHXQ7FDXtE64N21hMMt1xCdEy5ijN2/Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N19ahjFazA6Ry3KBJewafWcWBptqfdPTeMH+BxHsZgulrupGhmLg1ttfjdriZIl9e
	 S4iVmFkbJAuOB715+wkWHhVMYWDFw704kANmgpPCZvk33MgX3HblU2ywmBiXJSDAlP
	 aH5IgjLp3gL4nnf1ZwYgNW+ithQT8zzYV1lPxyuAb6PBo6a2gFJ//CGvoKasUbzyDy
	 s7XO832T+x2k2kW7RiQaZqPH1bFRXKRRIzrhekhJdHjqDQYiweuVqkFjmHas1grh91
	 Mo4JixE7jH1sC8ABopwQt+ZHxGMUoLghjOtY0/2uXDlaqZeyifzgJAXq7Rt/sBKwVA
	 oZLd2PJKeA1dQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:12 -0400
Subject: [PATCH net v2 6/7] net/handshake: Close the submit-side sock_hold
 race
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-6-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9ZOikSUuV+RCaLR3zLmrqVgvTu9j9SMOgYayy3SXkDk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr3/7Df3KopM5XcQVKWKeXMWsKIiR1xiQo4f
 NR2jal/o4qJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l3j3D/9L64/Cn/NHxuVL3oBdcZuWoaJ7qF0AlhrMeqbAGVNoZqPsrRAOpg8cevLTCe9TH2xHdJQ
 rcKzQLbDhht1kW/aYZZ0/DmuZASflTWJoBsUZfGuCnMWpQAk8mv7aUz0BtrvP451ZSnOdD2PIFj
 ufdIMmWwaC7NJjFe+ADkxuL+cZISCe4WjrQ0cHFHwInAeFkffYqiJDg09q1K1ZwVsXw+OGDzHbd
 au+/7KsvviVGg2GUs2t1Kuf7rlAX1Kqbvgcg7f3915jrK0CK7U4sPbs1Ix+IOIoSN9OF4MHDjqS
 tk7OUkUG0mAdvs2+GSnOja89JO6uoirpV1ISCWSvp+N7sEKYP0R8ixAbzkxiv0MfNz298E95YF+
 ZZQM4fK8e+yVgQnvc1rj1XBgZk5X//DVFouzxZTpuJK+d3ZHYKCwES8ta8skO0TlSmJynxomhEF
 oaTLIOTZnn+PEmqWiN6hu8nGE7VVCVYy6s0BoT5++b3SfKA8/+R9FwB2AkLlzIDXW9yUJt1Rg86
 Q93NbI86VlQzskupDU4sk75+aXpu6sRjlGn7gPouY/3uOl4KelYw0uzFfA6bXreal/ZYg83vR5g
 aTUZ8ifgppLzMDcAdJB5K0CPLtUHpvbj1fnN+Ekjjtmqb90pofhKQ5mQ3aXLfiyVctOIvwhvFZ6
 VFhw2gruS4D4iCg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290512-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 42C755A889F
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
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


