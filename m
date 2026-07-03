Return-Path: <netdev+bounces-304416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YY6aEEBoR2pbXwAAu9opvQ
	(envelope-from <netdev+bounces-304416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E46FFAE1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=apLYCfxL;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304416-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 985E2300C39F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62106370AD1;
	Fri,  3 Jul 2026 07:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503936DA1B;
	Fri,  3 Jul 2026 07:40:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064452; cv=none; b=mnPHY6plDRAu5h8rzLZ+TTs7ILUqElNWwXL8YNksSjLPwGva/XjsrkOc4qAwLgsgdjItxLO/mTZ8WhOlfEzlxRQXCRs27jXQOFx7X3oOs+amCWGpxyzQYgOH2aJa0odEX9gujQIwbJel2HstQizZSAIWmxWlYIUX55/y7hocB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064452; c=relaxed/simple;
	bh=jwDwjrt9PguwfoyJTkzAXdGZ4vB+TjVV211LYJ1FFY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjtxHwFetA5TvuvU9PGVpQUp3UlnKsdNlqn1Aag0ui4aQNdUViFkOpqCuC/o0HsgtK4bvYBPAo8F8GUL3IqvoB6MM1Cj4qgiatkss19xNunx9Bth1nJuGHeaEjJSIr/ky4364Aoit+0CJWN7YYjWxe7/rUwqj8xVwdZvJDlwmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apLYCfxL; arc=none smtp.client-ip=103.168.172.139
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 8E9431380254;
	Fri,  3 Jul 2026 03:40:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 03:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783064449; x=1783071649; bh=9
	yp0AIBqmvBg7x4GZfQExgNTm5Wf4octLTg7pCeshIE=; b=apLYCfxLRd2IIUK3o
	aZM9fJxqk9/2cvqGl8M3ZY/P9WA+3onS9MuT3ICs/NUgsEmsLo2hkeh3oR5mbC/4
	yAKurox5a7FQUyTzX+6gcTdENDoBV67KS1vu739xZB1dERw8/yC1P2rNnq97sV/L
	jcZZMsMEIRMM0aYYEDM9o6Ot+GB2cFfoFZxpLYUhHlcukjYBtS80OqwXTGpPh7I5
	J8iDyJbhh9YyInD51/Mn4DwiLUIPZZmVg8WomKVKu8TjKfDqoWIWCmdgZnHdsbV8
	XufKx0WXbBGdDnQgGyTnyA3iKWWLwHeAAkryzGMaPcYysli9CDXR/jb0SC6KQNkG
	lTZzQ==
X-ME-Sender: <xms:gWdHagwV-qIv-jIqVxUIG4wlWMLF8eIpAOCgxyq8TNhOsTJmlQAMvQ>
    <xme:gWdHarMbV_cBgYkcJ2Nov1CEGlJNwQRcSyzWsBW4cBynLEDiw1H-BCfAvfq3bNqZW
    lwyx93q-KKlIXAsMV1pCF-pLgahC3qOwQCYqno07Wy3CZG4XookKRQ>
X-ME-Received: <xmr:gWdHanbv7AfIlah1BBjmlariMZOiAdoxpboajLm8jLdCpKsg2hqZqz7F4_feweveO11mvum6tIujOVTCcFoOYiNQm3J2KXEMJ5l4ow>
X-ME-Proxy-Cause: dmFkZTF5O/McLRsZCRxt94kSPLWv/pg4aIqeyt9N4Y8eJW/YDo0plxRm4srEqsmG5fka4Q
    UqwAbE5NnbduvPuBt0/76VGhbEfyxrPlr3N4jUUYTAI2UNYThU5TjW7C02DyKqwKuwlZV0
    XzAXlMuu/Q38Qv64ImOJDhrGFPwaALkKvo1cPMYCcGxDoCeD3sycEQTBJts84tGDedkbqc
    q4O68AaKqKH6xDkVovBW9IqWYwQWOX0Nx0mmP2dSZoZehjCH90aM4ftx3bOGjiAbi+vWov
    qHx+jugGkI/Xp8WLPbaj8OIoEnMxi6ux498zRQGR2b74FNxT+Hrvc3d1N/KWiePU9+F4Vk
    R65OQiZI7GdY77uC9no/CDuEh+fJXIuV14e70Pfai2/wBkrvb09S/rC/nQhsshi7Xfvg25
    iWiLvCPa/pZjAoXiXxmBBXRHl5YaxaxKyitbVR/sxG3W1ozg4WIqNp0YsCs7AEBKHOdDL6
    my+YXJBncbcFxyebQ9A3HXlUbjbbZL+obJNpWJgD6Rj1XtIOgGegZMNbEBzZv1VPglUsCP
    sYQoPlG91kE/cx9froizQPFfAsXHrX7sj23FTmoP0EO5Rm/YN5lN3E7euBuECGHLGyEaHC
    FsOWIobt+JN0Nek9XQ7UTSGUyOVn9Pl42zvDqagwgmxSjqUMvYKK4tzSm81Q
X-ME-Proxy: <xmx:gWdHaloxhHh0W03ggJ-MeB6kjWk36CkM2K6ZeNJ8mHUdr_ref00YtQ>
    <xmx:gWdHaszT9rnpovDCdvPyPio_5eshv7TwhTAXbmk_jGN4-NUdSEPEUw>
    <xmx:gWdHalJNQ5UOuNaqWrnUuwpmuUKF_838UHGmJEmrWP7To1tbt5OV3g>
    <xmx:gWdHam7gA5zV2_zPQSl2JLNfRiFEgXzcgQOv8KVhI1kHmsZTO5PcXQ>
    <xmx:gWdHamSrhAMIOJ6xJbTOQ-TquXrHpQl_0hZxCe8iIZNHxZDHvb7v6MSi>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 03:40:48 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Ericson <mail@JohnEricson.me>,
	Cong Wang <cwang@multikernel.io>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Andy Lutomirski <luto@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] af_unix: factor out kernel_unix_connect_direct()
Date: Fri,  3 Jul 2026 03:39:43 -0400
Message-ID: <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-304416-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@JohnEricson.me,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,Obsidian.Systems:mid,Obsidian.Systems:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 347E46FFAE1

From: John Ericson <mail@JohnEricson.me>

I was hoping this was going to be a simple matter of factoring out the
back half of `unix_stream_connect`. No such luck was had, because
actually instead of `unix_stream_connect` looking up the socket from the
VFS once, it does it repeatedly in the same loop that is used to deal
with full listening queues.

(This behavior is rather surprising to me, because it would allow a
deleted and recreated socket to be picked up on the next loop iteration.
But, I don't want to make any UAPI-visible changes in this patch series,
so I did not consider changing it.)

Seeing that this was going to be more complex, I instead factored out
three helpers (setup, commit, cleanup) on a state struct, so I could
reuse them both in the existing `unix_stream_connect` and also in the
new `kernel_unix_connect_direct`. This allows each caller to implement a
slightly different loop:

- resource management of `struct sock *other`:
  - `unix_stream_connect` acquires (and releases) it.
  - `kernel_unix_connect_direct` uses the caller-provided one.

- stale `other` behavior:
  - `unix_stream_connect` retries, because on the next iteration the
    socket may have been replaced by a fresh one.
  - `kernel_unix_connect_direct` fails, because no reacquisition means
    staleness is permanent.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Ericson <mail@JohnEricson.me>
---
 include/net/af_unix.h |   1 +
 net/unix/af_unix.c    | 247 +++++++++++++++++++++++++++++++++---------
 2 files changed, 199 insertions(+), 49 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index fe4547508af1..7d810321efa3 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -15,6 +15,7 @@
 #if IS_ENABLED(CONFIG_UNIX)
 struct unix_sock *unix_get_socket(struct file *filp);
 struct sock *unix_lookup_bsd_path(const struct path *path, int type);
+int kernel_unix_connect_direct(struct sock *other, struct socket *sock, int flags);
 #else
 static inline struct unix_sock *unix_get_socket(struct file *filp)
 {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3270299238c4..aa94da1f8c24 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1649,44 +1649,60 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 	return timeo;
 }
 
-static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
-			       int addr_len, int flags)
-{
-	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
-	struct sock *sk = sock->sk, *newsk = NULL, *other = NULL;
-	struct unix_sock *u = unix_sk(sk), *newu, *otheru;
-	struct unix_peercred peercred = {};
-	struct net *net = sock_net(sk);
-	struct sk_buff *skb = NULL;
-	unsigned char state;
-	long timeo;
-	int err;
+/*
+ * The state a stream connect() builds up before it has a peer: the new
+ * sock and the connection-request skb handed to the listener, the
+ * connecting side's credentials and its send timeout.
+ *
+ * - Built once by unix_stream_connect_setup()
+ * - Used to finish connecting by unix_stream_connect_commit()
+ * - Cleaned up in the failure case by unix_stream_connect_cleanup()
+ */
+struct unix_connect_state {
+	struct sock		*newsk;
+	struct sk_buff		*skb;
+	struct unix_peercred	peercred;
+	long			timeo;
+};
 
-	err = unix_validate_addr(sunaddr, addr_len);
-	if (err)
-		goto out;
+/* Free a connect state that no connection consumed (i.e. on failure). */
+static void unix_stream_connect_cleanup(struct unix_connect_state *st)
+{
+	consume_skb(st->skb);
+	unix_release_sock(st->newsk, 0);
+	drop_peercred(&st->peercred);
+}
 
-	err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, &addr_len);
-	if (err)
-		goto out;
+/*
+ * Build the state a stream connect needs before it looks for a peer:
+ * autobind if required, snapshot the send timeout, and allocate the new
+ * sock, the request skb and the peer credentials.  On failure nothing is
+ * left allocated in @st.
+ */
+static int unix_stream_connect_setup(struct socket *sock, int flags,
+				     struct unix_connect_state *st)
+{
+	struct sock *sk = sock->sk, *newsk;
+	struct sk_buff *skb;
+	int err;
 
-	if (unix_may_passcred(sk) && !READ_ONCE(u->addr)) {
+	if (unix_may_passcred(sk) && !READ_ONCE(unix_sk(sk)->addr)) {
 		err = unix_autobind(sk);
 		if (err)
-			goto out;
+			return err;
 	}
 
-	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
+	st->timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
 
-	err = prepare_peercred(&peercred);
+	err = prepare_peercred(&st->peercred);
 	if (err)
-		goto out;
+		return err;
 
 	/* create new sock for complete connection */
-	newsk = unix_create1(net, NULL, 0, sock->type);
+	newsk = unix_create1(sock_net(sk), NULL, 0, sock->type);
 	if (IS_ERR(newsk)) {
 		err = PTR_ERR(newsk);
-		goto out;
+		goto out_drop;
 	}
 
 	/* Allocate skb for sending to listening sock */
@@ -1696,21 +1712,56 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 		goto out_free_sk;
 	}
 
-restart:
-	/*  Find listening sock. */
-	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
-	if (IS_ERR(other)) {
-		err = PTR_ERR(other);
-		goto out_free_skb;
-	}
+	st->newsk = newsk;
+	st->skb = skb;
+	return 0;
+
+out_free_sk:
+	unix_release_sock(newsk, 0);
+out_drop:
+	drop_peercred(&st->peercred);
+	return err;
+}
+
+/*
+ * Positive returns from unix_stream_connect_commit() ask the caller to
+ * try again.  They are distinct only for a caller with a fixed peer
+ * (kernel_unix_connect_direct()): a full backlog can be retried on the
+ * same peer, but a peer found dead cannot -- the by-name path must
+ * re-resolve it, and a fixed peer has no such recourse and fails.
+ */
+#define UNIX_CONNECT_STALE 1	/* peer was found dead */
+#define UNIX_CONNECT_FULL  2	/* backlog was full and we slept */
+
+/*
+ * Try to connect @sk to the listening peer @other, using the connect
+ * state @st built by unix_stream_connect_setup().  Takes and releases
+ * unix_state_lock(@other) itself.
+ *
+ * Returns 0 on success (@st->skb queued to @other, @st->newsk linked to
+ * @sk and @st->peercred consumed), a negative errno on terminal failure,
+ * or a positive value (UNIX_CONNECT_STALE / UNIX_CONNECT_FULL) asking the
+ * caller to re-obtain @other and call again -- because @other was found
+ * dead, or its backlog was full and we slept (updating @st->timeo)
+ * waiting for room.
+ */
+static int unix_stream_connect_commit(struct sock *sk, struct sock *other,
+				      struct unix_connect_state *st)
+{
+	struct sock *newsk = st->newsk;
+	struct sk_buff *skb = st->skb;
+	struct unix_peercred *peercred = &st->peercred;
+	long *timeo = &st->timeo;
+	struct unix_sock *newu, *otheru;
+	unsigned char state;
+	int err;
 
 	unix_state_lock(other);
 
-	/* Apparently VFS overslept socket death. Retry. */
+	/* Apparently VFS overslept socket death; ask the caller to retry. */
 	if (sock_flag(other, SOCK_DEAD)) {
 		unix_state_unlock(other);
-		sock_put(other);
-		goto restart;
+		return UNIX_CONNECT_STALE;
 	}
 
 	if (other->sk_state != TCP_LISTEN ||
@@ -1720,19 +1771,19 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	}
 
 	if (unix_recvq_full_lockless(other)) {
-		if (!timeo) {
+		if (!*timeo) {
 			err = -EAGAIN;
 			goto out_unlock;
 		}
 
-		timeo = unix_wait_for_peer(other, timeo);
-		sock_put(other);
+		/* unix_wait_for_peer() drops unix_state_lock(other). */
+		*timeo = unix_wait_for_peer(other, *timeo);
 
-		err = sock_intr_errno(timeo);
+		err = sock_intr_errno(*timeo);
 		if (signal_pending(current))
-			goto out_free_skb;
+			return err;
 
-		goto restart;
+		return UNIX_CONNECT_FULL;
 	}
 
 	/* self connect and simultaneous connect are eliminated
@@ -1765,7 +1816,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	newsk->sk_state = TCP_ESTABLISHED;
 	newsk->sk_type = sk->sk_type;
 	newsk->sk_scm_recv_flags = other->sk_scm_recv_flags;
-	init_peercred(newsk, &peercred);
+	init_peercred(newsk, peercred);
 
 	newu = unix_sk(newsk);
 	newu->listener = other;
@@ -1813,20 +1864,118 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
 	READ_ONCE(other->sk_data_ready)(other);
-	sock_put(other);
 	return 0;
 
 out_unlock:
 	unix_state_unlock(other);
+	return err;
+}
+
+static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
+			       int addr_len, int flags)
+{
+	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
+	struct sock *sk = sock->sk, *other;
+	struct unix_connect_state st = {};
+	struct net *net = sock_net(sk);
+	int err;
+
+	err = unix_validate_addr(sunaddr, addr_len);
+	if (err)
+		return err;
+
+	err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, &addr_len);
+	if (err)
+		return err;
+
+	err = unix_stream_connect_setup(sock, flags, &st);
+	if (err)
+		return err;
+
+restart:
+	/* Find the listening sock.  A positive return from
+	 * unix_stream_connect_commit() means "retry": the peer had died,
+	 * or its backlog was full and we slept -- so re-resolve the name.
+	 */
+	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
+	if (IS_ERR(other)) {
+		err = PTR_ERR(other);
+		goto out_free;
+	}
+
+	err = unix_stream_connect_commit(sk, other, &st);
 	sock_put(other);
-out_free_skb:
-	consume_skb(skb);
-out_free_sk:
-	unix_release_sock(newsk, 0);
-out:
-	drop_peercred(&peercred);
+	switch (err) {
+	case 0:
+		return 0;
+	case UNIX_CONNECT_FULL:
+		goto restart;
+	case UNIX_CONNECT_STALE:
+		/* A full backlog or a dead peer: re-resolve and try again. */
+		goto restart;
+	case INT_MIN ... -1:
+		/* terminal errno, propagate as-is */
+		break;
+	default:
+		/* commit() only returns 0, a retry code, or an errno */
+		WARN_ONCE(1, "unix_stream_connect_commit() returned %d\n", err);
+		err = -EINVAL;
+		break;
+	}
+out_free:
+	unix_stream_connect_cleanup(&st);
+	return err;
+}
+
+/**
+ * kernel_unix_connect_direct - connect a socket to a specific AF_UNIX sock
+ * @other: a held listening sock to connect to (e.g. from
+ *         unix_lookup_bsd_path())
+ * @sock: the connecting socket, created with sock_create_kern()
+ * @flags: connect flags; without O_NONBLOCK a full listen backlog on
+ *         @other is waited on, as for connect(2)
+ *
+ * Connects @sock to @other without any name lookup, address validation
+ * or path-based permission check.  For in-kernel callers that have
+ * already located the target under their own policy.  The caller
+ * retains its reference on @other.
+ */
+int kernel_unix_connect_direct(struct sock *other, struct socket *sock, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct unix_connect_state st = {};
+	int err;
+
+	err = unix_stream_connect_setup(sock, flags, &st);
+	if (err)
+		return err;
+
+restart:
+	sock_hold(other);
+	err = unix_stream_connect_commit(sk, other, &st);
+	sock_put(other);
+	switch (err) {
+	case 0:
+		return 0;
+	case UNIX_CONNECT_FULL:
+		goto restart;
+	case UNIX_CONNECT_STALE:
+		/* The peer is fixed, so a dead one cannot be re-found. */
+		err = -ECONNREFUSED;
+		break;
+	case INT_MIN ... -1:
+		/* terminal errno, propagate as-is */
+		break;
+	default:
+		/* commit() only returns 0, a retry code, or an errno */
+		WARN_ONCE(1, "unix_stream_connect_commit() returned %d\n", err);
+		err = -EINVAL;
+		break;
+	}
+	unix_stream_connect_cleanup(&st);
 	return err;
 }
+EXPORT_SYMBOL_GPL(kernel_unix_connect_direct);
 
 static int unix_socketpair(struct socket *socka, struct socket *sockb)
 {
-- 
2.54.0


