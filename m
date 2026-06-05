Return-Path: <netdev+bounces-295752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KjUNHTKaImofawEAu9opvQ
	(envelope-from <netdev+bounces-295752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A7646F7D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jNrMbS2n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295752-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295752-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E517C3026E7F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542403F825D;
	Fri,  5 Jun 2026 09:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237783F825B;
	Fri,  5 Jun 2026 09:22:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651370; cv=none; b=WEO1Zh9gQeVYGSprbJSaEC7iH8GE2pkZNJdT7RsDMNcIz2jJu5J0czZq2YsCxp7nqc57o0oNciPlqpNpjXm3+h4ef9ODmelS1REqbIUVlXPq19y1xZzoJlH7hiL7NFhNupvmyawALlyM7kMcPPOjyD5iD7QRYel/D7/TiZlU1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651370; c=relaxed/simple;
	bh=OFWGyV7iubxVQyVxwUBOM9IG3EfDtnt2dbEXqtmwj38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKc8mk2HNro2W3IoZF1UaP0hte6ZjmsD9AM0GP9VHahIZSmPTzrZXpMxKjNxd6hbhzhuxDhFaqmrnxosdiCC1xA9O6ZJ2O25mlS/wx33bPQNFLxtGD/Tp6PDRbS9VAjsuXhY6DtBhB8l4iyKhqpGiqpzSVIi3XNQ/vobBF1o+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNrMbS2n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFA91F00898;
	Fri,  5 Jun 2026 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651368;
	bh=T36wjmUo5GrSowCuXneK/CafyGSZCLKHyknQi59K/1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jNrMbS2nE+Fz1IAB9nj2saR2rlvIoQVugkEcy9mYQhFkjgz7vTCvIvnw02Dg/MlQZ
	 Mjix3sismoBYfLJNwsRTyZInd8pOtOKPryqg3fk+sc37bz4zfTN2+XzcJzMw22XFde
	 El+j024mlubURzgL5fzMhVhQ+lKRxYheN6le5k0TlEIpcvJUAddzmsy90cvH2C5VN2
	 3cbUSrnefN0UAeViEFrMHkXV1FVm2i9lfc5Wxul3fMIo5SlWNCm28F29P0YsjWpd6y
	 hdFpkwcKKyLxPiaXVSTZWBXeOs/WQvvYTbwUnpkyV9lV0peEow9NwOIsxObKqhDjU+
	 9VB1iFzpkNEdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:58 +1000
Subject: [PATCH net-next v2 14/15] mptcp: pm: avoid using del_timer
 directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-14-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5344; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OFWGyV7iubxVQyVxwUBOM9IG3EfDtnt2dbEXqtmwj38=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxVmeHDtXjrHoy4BRugiUMGCEDgLNpGR0RC
 aKipMZwmM2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c2CkD/4lJ3ZyA2BqFr0EaZHhIAOSyRWutvWn6AAygjjLkg3DdEiYMkrx7XhujGlZZE8HWiYGbjD
 diDD3/4ui+/K6dpwgmohLzZIP6+F8fSJV0lzZk6vqMNYd8VvrOK73jkiY/4NdrmLHN4MKRBd641
 +Z2xVbouBkVfJXxNc1jI2nc/qYiG34UIlv3QOJW9dgFUtpDG36gW2MalNWm4/kSMN3DhnZKMFV/
 i4PVpOPwWu7qeVjx2HJZk9bsVRUUz+m3dSUCdCHbUUAnuB1zd737iaLyHP84IRo/pJjBkeUY/+6
 cw/6Syvdqd728O1Zk93ixx7P22F1+23S8K1UK8A/dw5cDb9w038essIIHG0PQ3o57yDVDZnjw7c
 gXOMy2Le81bBQGxboLM5juWOhzY9wqsQ/1wAmQDpBsMJ5WjVg8KDK1+xe0kUebfKFcsoS5rmTJZ
 uy+YBAHTd6tL+I7D9FQnlZKq9rKH45ERz1bVvRIAFnJCOEzN2Nm70zIS/klXtR8Id+zfvOPiu5A
 dORWzvlzpRwsuQ+siZ+HC/VhI4ngH1ZLKQI1vFnxEaCzFrGfZxUghVeGRyxQvfzgWZbUwwV56Jw
 M5QOu2YGOkIw31Ek7X+ylx4Cv7NAelnHd4I2uGXIDK9/BQQpvyqsIueoIieJHNC3YsxHuflQHOx
 mZxUkdtV4vh4y6w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 620A7646F7D

mptcp_pm_announced_del_timer() removes the matched ADD_ADDR entry (if
found) from the ADD_ADDR list only if check_id is false. That's
dangerous, and not clear, because it means the caller should be free the
entry only in some cases, and it easy to miss that.

Instead, make it static, and call it from mptcp_pm_add_addr_echoed,
which is the only other case where mptcp_pm_add_addr_del_timer should be
called with check_id set to true. Bonus with that: a second call to
mptcp_pm_add_addr_lookup_by_addr() can be avoided.

Note that instead of adding the signature above to avoid a compilation
issue because this helper is called before the definition of the
function, the whole helper is moved above where it is first called. Its
content is untouched, except the addition of the 'static' keyboard.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  1 -
 net/mptcp/pm.c       | 75 +++++++++++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  3 ---
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4215270bfba7..614a561c1f7f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1183,7 +1183,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f4604611f10f..6afd39aea110 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,40 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 	return NULL;
 }
 
+static struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_add_addr *entry;
+	bool stop_timer = false;
+
+	rcu_read_lock();
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_pm_announced_lookup(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		stop_timer = true;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	if (stop_timer) {
+		if (check_id)
+			sk_stop_timer(sk, &entry->timer);
+		else
+			sk_stop_timer_sync(sk, &entry->timer);
+	}
+
+	rcu_read_unlock();
+	return entry;
+}
+
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
 {
@@ -398,40 +432,6 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_add_addr *entry;
-	bool stop_timer = false;
-
-	rcu_read_lock();
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		stop_timer = true;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* Note: entry might have been removed by another thread.
-	 * We hold rcu_read_lock() to ensure it is not freed under us.
-	 */
-	if (stop_timer) {
-		if (check_id)
-			sk_stop_timer(sk, &entry->timer);
-		else
-			sk_stop_timer_sync(sk, &entry->timer);
-	}
-
-	rcu_read_unlock();
-	return entry;
-}
-
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
@@ -730,15 +730,18 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_add_addr *entry;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	entry = mptcp_pm_announced_del_timer(msk, addr, true);
+
+	if (!entry || !READ_ONCE(pm->work_pending))
 		return;
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
+	if (READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7bc8fd486e81..4a2d40cd7b13 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1131,9 +1131,6 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      u8 bkup);
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr);
 bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);

-- 
2.53.0


