Return-Path: <netdev+bounces-125395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6796CF93
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680B21F25650
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76818BC04;
	Thu,  5 Sep 2024 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XCNbL2fg"
X-Original-To: netdev@vger.kernel.org
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF6188CA5
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518603; cv=none; b=BTWXUIlYr6vhIxKooClKnzwygZe2lnWNPPbAyheAXtzwFZwrqWgcD4rLG/g1pedlXgNwhLXOEEjuLzQp+xK9GnLjLK+tOMv89TgMtso9Tvwli9pm/yX3kIiuZfjukIbu1nJgu78Dv12RlZLM4ostyQueOVPDPFNVtj0BK7iatqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518603; c=relaxed/simple;
	bh=L0l/Sbqu8Y5VD+Vpn1VVG6EY+J8Fh4V0w8CWh6nAeJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOQ9p4ZIu85FKDRL86NfXZPJN55q+uIF4yQO5JGeSETPkqXMsBTDo4zgICFtTUI4Jt2kW/tXYCSHsfrE0Xpg4yEX64LTW3GBqlZzAf6yx/9TGCKsVRiJeHkM7CkMGJJshR8kxO+s8cxoq2hKW437gIBKg4rZHp1qzGf4ogqj3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XCNbL2fg; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id B4F8B63EB3
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:43:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2d4c:0:640:de18:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id E3C1B608ED;
	Thu,  5 Sep 2024 09:43:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1hWjdGDRriE0-UtcftXEL;
	Thu, 05 Sep 2024 09:43:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725518582; bh=z4beoG7aOZCsI8FqZcYGPJSsfxruSTx4TiLHrR6AZX4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XCNbL2fgsx0Rb0ICnTG6T8fPdVmFLrhXouW60bq1U/feFJJ/qVjHaAgmELwbkudYu
	 hiFsiGJ57fxDm6UBfZschxKnJxQZK2cSVPOotlmRQ+CFmbvJVuiPT2EKdz8nQOY3i2
	 9ko/C+eT8LpdQxo1tuxJDo0KFnkrWPdARks9/DX0=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH RFC net] net: sockmap: avoid race between sock_map_destroy() and sk_psock_put()
Date: Thu,  5 Sep 2024 09:42:57 +0300
Message-ID: <20240905064257.3870271-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45, syzbot
has triggered the following race condition:

On CPU0, 'sk_psock_drop()' is running at [1]:

void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
{
        write_lock_bh(&sk->sk_callback_lock);
        sk_psock_restore_proto(sk, psock);                                  [1]
        rcu_assign_sk_user_data(sk, NULL);
        if (psock->progs.stream_parser)
                sk_psock_stop_strp(sk, psock);
        else if (psock->progs.stream_verdict || psock->progs.skb_verdict)
                sk_psock_stop_verdict(sk, psock);
        write_unlock_bh(&sk->sk_callback_lock);

        sk_psock_stop(psock);

        INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
        queue_rcu_work(system_wq, &psock->rwork);
}

If 'sock_map_destroy()' is scheduled on CPU1 at the same time, psock is
always NULL at [2]. But, since [1] may be is in progress during [3], the
value of 'saved_destroy' at this point is undefined:

void sock_map_destroy(struct sock *sk)
{
        void (*saved_destroy)(struct sock *sk);
        struct sk_psock *psock;

        rcu_read_lock();
        psock = sk_psock_get(sk);                                           [2]
        if (unlikely(!psock)) {
                rcu_read_unlock();
                saved_destroy = READ_ONCE(sk->sk_prot)->destroy;            [3]
        } else {
                saved_destroy = psock->saved_destroy;
                sock_map_remove_links(sk, psock);
                rcu_read_unlock();
                sk_psock_stop(psock);
                sk_psock_put(sk, psock);
        }
        if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
                return;
        if (saved_destroy)
                saved_destroy(sk);
}

The following fix is helpful to avoid the race and does not introduce
psock leak (when running the syzbot reproducer from the above), but
I'm not sure whether the latter is always true in some other scenario.
So comments are highly appreciated.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/core/sock_map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d3dbb92153f2..fef4231fc872 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1649,7 +1649,7 @@ void sock_map_destroy(struct sock *sk)
 	struct sk_psock *psock;
 
 	rcu_read_lock();
-	psock = sk_psock_get(sk);
+	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
@@ -1658,7 +1658,6 @@ void sock_map_destroy(struct sock *sk)
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
 		sk_psock_stop(psock);
-		sk_psock_put(sk, psock);
 	}
 	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
 		return;
-- 
2.46.0


