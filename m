Return-Path: <netdev+bounces-216304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0403B33024
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9327720459D
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2322D8398;
	Sun, 24 Aug 2025 13:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42615253944
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042620; cv=none; b=XO9ayyJ8PEXHUXPEMgaxul0KjvoMikceD4he9v+PTXD48P+jG/8zBBTEKAJeYu2rmTvERDSn7sBWnAEdM/yXMMzOrQQqvY9uvfp/d+aKpp5hNV/onr/sd1s1ZPzeAP+hcDa7OvGbgMAJiKQa2PXjdaa9Z5SNWBmJTrQz35+f6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042620; c=relaxed/simple;
	bh=jJpnNVnVSjvXNRhL+EF1mdScXF3xgLUy9PyyWPapu+I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cjQLRNU0OX3b2W3xSA9ZfUlkXEQxWio4E8gJcyKzPN6Ed5CqOJduyqH7wQQ7YNCvcCRJuo0FbA3Xfl3xMaU8QTMrZk/yMiAqcEBOb1zz5z3wrjIg3uPNOx6jRp/9q1fRfxUHbypLRK2K8lmbcXzUwb0l6qob4/KIle3y1C2k1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57ODatCm013651;
	Sun, 24 Aug 2025 22:36:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57ODasg3013648
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 24 Aug 2025 22:36:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c1e50f41-da30-4cea-859c-05db0ab8040b@I-love.SAKURA.ne.jp>
Date: Sun, 24 Aug 2025 22:36:51 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can/j1939: hung inside rtnl_dellink()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
 <aKg9mTaSxzBVpTVI@pengutronix.de>
 <bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp

On 2025/08/22 19:23, Tetsuo Handa wrote:
> I think we need to somehow make it possible to logically close j1939
> sockets without actually closing. Maybe something like 
> "struct in_device"->dead flag which is set by inetdev_destroy() upon
> NETDEV_UNREGISTER event is needed by j1939 sockets...

This change seems to fix the hung problem syzbot is reporting.
Does this change look correct?
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/main.c       |  3 +++
 net/can/j1939/socket.c     | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 31a93cae5111..81f58924b4ac 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -212,6 +212,7 @@ void j1939_priv_get(struct j1939_priv *priv);
 
 /* notify/alert all j1939 sockets bound to ifindex */
 void j1939_sk_netdev_event_netdown(struct j1939_priv *priv);
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv);
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk);
 void j1939_tp_init(struct j1939_priv *priv);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 7e8a20f2fc42..3706a872ecaf 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -377,6 +377,9 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		j1939_sk_netdev_event_netdown(priv);
 		j1939_ecu_unmap_all(priv);
 		break;
+	case NETDEV_UNREGISTER:
+		j1939_sk_netdev_event_unregister(priv);
+		break;
 	}
 
 	j1939_priv_put(priv);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 493f49bfaf5d..0fbfdffdfc24 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1303,6 +1303,46 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
+{
+	struct sock *sk;
+	struct j1939_sock *jsk;
+
+ rescan: /* The caller is holding a ref on this "priv" via j1939_priv_get_by_ndev(). */
+	read_lock_bh(&priv->j1939_socks_lock);
+	list_for_each_entry(jsk, &priv->j1939_socks, list) {
+		/* Skip if j1939_jsk_add() is not called on this socket. */
+		if (!(jsk->state & J1939_SOCK_BOUND))
+			continue;
+		sk = &jsk->sk;
+		sock_hold(sk);
+		read_unlock_bh(&priv->j1939_socks_lock);
+		/* Check if j1939_jsk_del() is not yet called on this socket after holding
+		 * socket's lock, for both j1939_sk_bind() and j1939_sk_release() call
+		 * j1939_jsk_del() with socket's lock held.
+		 */
+		lock_sock(sk);
+		if (jsk->state & J1939_SOCK_BOUND) {
+			/* Neither j1939_sk_bind() nor j1939_sk_release() called j1939_jsk_del().
+			 * Make this socket no longer bound, by pretending as if j1939_sk_bind()
+			 * dropped old references but did not get new references.
+			 */
+			j1939_jsk_del(priv, jsk);
+			j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+			j1939_netdev_stop(priv);
+			/* Call j1939_priv_put() now and prevent j1939_sk_sock_destruct() from
+			 * calling the corresponding j1939_priv_put().
+			 */
+			j1939_priv_put(priv);
+			jsk->priv = NULL;
+		}
+		release_sock(sk);
+		sock_put(sk);
+		goto rescan;
+	}
+	read_unlock_bh(&priv->j1939_socks_lock);
+}
+
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 				unsigned long arg)
 {
-- 
2.51.0


