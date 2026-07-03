Return-Path: <netdev+bounces-304450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SI/OHvF0R2oEYgAAu9opvQ
	(envelope-from <netdev+bounces-304450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:38:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D27700273
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:38:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=mbF6l84b;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304450-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304450-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECB153069DC2
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9E33F59D;
	Fri,  3 Jul 2026 08:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529F2EEE7C;
	Fri,  3 Jul 2026 08:15:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066512; cv=none; b=ZU+CqzdgPInLx8soZFNq6P05GL2TBGFsRCndpR6YfTOWS6cuTdMpPgcdh5b0cq98uFnW2TTk7y37jPgUAJnEeejOFCY6o4YjUjncLMMrUVUOl9n4IjzDkiztjAJjjHh4qkdFC/4w7cZ0dT6fUddO1PWq8U3mYAj2uPXcS1rgeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066512; c=relaxed/simple;
	bh=QNovCGGyOVbHtl0m25FTE08uWoRhyIW1FKXWPEOlXdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+KueKTm4IjahXOvk0SWTsTn8vDMrbxJAWd6bzE12OhvQXIKU2vhAlRSF9s18sladRyLyoyKQWZgJm5R4kTSBZV4GcC9xuFL8swOUUhPb1zmkNjmLIhj1NJKO2X3Z4UeMeAYNzySdSQhzeThYEeggIJo7q0s8JoqBLR/Drj8T64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mbF6l84b; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 8D9581380136;
	Fri,  3 Jul 2026 04:15:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 04:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783066510; x=1783073710; bh=0
	YGa7LI2K6T0iFSg9ETLaUbZGMFaFuzlKIrT2QTt1DM=; b=mbF6l84bTu11wBFsu
	CAXM3OGgW5C2M8cLI/ieC0Ar+yoqownphE2fXShwvjIbWANlngkSQffi8Hf1iFFD
	tFjEqPwRzJG5Eko71bnuSmLcI/XreFx55lcxPGoRX/jsJHTyXOJRDs9CgQwZAPr9
	xpLx9KmOegx4dJ96lHd2E8KgbaEI5pKEUlLxwbRnyCL6Cy6Mm7T6rQVaLXFEbO9k
	hlwEFcRlwrcipW0wej6oL2toOEqomztvxPW9U/g/2qX5cL+50dF3tU/BfVzHamUp
	eYTBAwqfxrDheo2XkPE83mYDZBu8v4OSH2tcgBw9d9VEjJbRR5kIjFHq6mkhtaxx
	POs8w==
X-ME-Sender: <xms:jm9HakeQDt-PfyYB56z7616BXi-__eC0OcF-Dc0DNuXEVWNmmrBorw>
    <xme:jm9HarZ_x9Ide-iFHZPMCnbqV-J-qG5GVefTRqDzFJx4PrayyQ9YngJletudp4czg
    bipnUGD-O8vXOKGhjTIW1zGCDLPtZyjMf8XgTZMXN3LabuirrqPOJ8>
X-ME-Received: <xmr:jm9Hao5s4aqbSQcoLuw2Ut9bF9aneZ5RDdW8-PcaZoxF0NVulbgPqgfEmgzsJAANC21NpwJ7nrspTdPFdZYJ1CCYEkQi3QFb2CTw-Q>
X-ME-Proxy-Cause: dmFkZTEgQgi+w+ik2T+h5VYynTeUfJqam49o7KWNziQZlGvOGhu5LEvsuowjdRwbkVP9PT
    QxYNBs0EHifHcOU3urOY6yMlSVh5MWtKuS+NqWVezs4KXjqh3yQBJ0fLZCrM1noAtSwOiq
    xUyI4tcn4sPji8EneN5rpxvzXdkhF4ShdO9S/FEF+7WMjzS0mKOjlrFs+eewCbz8Ms/m6i
    F+0+h12To1W3bdNJS6yvep+bOn9zZa6iKxG2outo1ncy3M6YD0ZljnexaLAa0wvK2DcGHw
    ET4+BNPPVBR2L+RSpuMForO6goWO4HshzVansxcSVomSmj7eH7v8yQQnM4T73bmujIIYoo
    oSIhvPBtzIvCgHlbCMW2BCl4aKHf4YG6BFYrqrb5aL/FNAMHDZulHv1VxcK6BjkvpehgOG
    g7MK/g2VeYqDo+uaE2ZHV9IF0W9lheQb+9m0sxJFTJyBZvB/4inmD/LK+gvTIOTU8tWrKV
    +O0ToNDADO80KqWWCGKJ5Hdd1XOPBB+V3Irjw/rmm2GJwfOJAGau8t67ZkUu4n0lHVF1jn
    BITAtXUth/4E+U4HNLjtKzdOg+rk5HVw2Ypye/iZtqcw6KzQMzGlL2Z5nvCOc1ogy4HHmR
    NS1EKjrip62IbiIYPutUdJL/6y7KaMbBbbf+vhSBhz9FX1ElLaCybF40OJ+Q
X-ME-Proxy: <xmx:jm9HapcLiR6_gTg4_N5G-orjDJ6xE8f7Ei83N6fz4z0B615iciRh0A>
    <xmx:jm9Harwsc6S7N15B_U-aI2AaiiyrTJuQVeR-r_iBK8FCerD5MC1t2g>
    <xmx:jm9HavpzawX1mJJ_u6oraq0mnj_b4tsFPp9nFjL2QqtwKdI9QoBS3g>
    <xmx:jm9HapyOJtJtwn3ornPyXIX4B-aIfeIU0P1No9bJYRJe8wJcz94UkQ>
    <xmx:jm9HampxHna67U_hPYAh3UEq1bqXO_E48As0BMpu0YjAN05OSDLAxm1V>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:15:09 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Ericson <mail@johnericson.me>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Cong Wang <cwang@multikernel.io>,
	John Ericson <john.ericson@obsidian.systems>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] af_unix: Clean up error handling in unix_listen()
Date: Fri,  3 Jul 2026 04:14:12 -0400
Message-ID: <20260703081416.2583118-3-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304450-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:john.ericson@obsidian.systems,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[johnericson.me:email,Obsidian.Systems:mid,Obsidian.Systems:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60D27700273

From: John Ericson <mail@johnericson.me>

To avoid the sort of bug that was just fixed going forward, switch to a
style where `err = -E...;` instead happens right before the `goto`.
(`err = other_function(...);` is not changed.) Then there is no
spooky-action-at-a-distance between the `err` initialization and the
`goto`, something which is easier to slip by code review.

Assisted-by: Claude:claude-fable-5
Signed-off-by: John Ericson <mail@johnericson.me>
---
 net/unix/af_unix.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 10ed9421e43a..7878b27bbaf8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -813,19 +813,22 @@ static int unix_listen(struct socket *sock, int backlog)
 	struct unix_sock *u = unix_sk(sk);
 	struct unix_peercred peercred = {};
 
-	err = -EOPNOTSUPP;
-	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
+	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET) {
+		err = -EOPNOTSUPP;
 		goto out;	/* Only stream/seqpacket sockets accept */
-	err = -EINVAL;
-	if (!READ_ONCE(u->addr))
+	}
+	if (!READ_ONCE(u->addr)) {
+		err = -EINVAL;
 		goto out;	/* No listens on an unbound socket */
+	}
 	err = prepare_peercred(&peercred);
 	if (err)
 		goto out;
 	unix_state_lock(sk);
-	err = -EINVAL;
-	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
+	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN) {
+		err = -EINVAL;
 		goto out_unlock;
+	}
 	if (backlog > sk->sk_max_ack_backlog)
 		wake_up_interruptible_all(&u->peer_wait);
 	sk->sk_max_ack_backlog	= backlog;
-- 
2.54.0


