Return-Path: <netdev+bounces-126959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68031973662
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB4A1C2476F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878CB18FC86;
	Tue, 10 Sep 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sOharXw2"
X-Original-To: netdev@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646C18C34D
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968658; cv=none; b=YFt4E5OEYfX0kqWs0DxqnG4Jkq7vZ6//DvLfW8OUxNzOF4X66VkELZSe28KuUfmrFRzPsnJu1sya1Visoadq8CbWSL9aVKgIuaIy8X38xZfPYrnDHX5MqbkvToFZrN9b3Pr1EgVkRohdq3xsGJX+MBPvtKr6VhFFWW8fMKRBi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968658; c=relaxed/simple;
	bh=3XDpmXcOBpSULp9Ug9/c7MzjZ3CZJGyDpwc5D6QPbu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YeYBQF5EEzrDCMiCxvGAlIhw8kOHbWv2DQojP96rM9TSFAyAttOqc0ZkJwXsK0HDKeL13W0RFQBt5Q62FLxgnTQmBiEddDMgNM46+NMtXeNU77Mq6q7ylmesmzdC44cbkOar843Y/yJHdVIOIUT4jZeoSRkULlwnviR2fv8yFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=sOharXw2; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2b05:0:640:2bb4:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 4EC4960AE0;
	Tue, 10 Sep 2024 14:44:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3igqsaAXrGk0-TzHZKqGJ;
	Tue, 10 Sep 2024 14:44:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725968644; bh=K4OmLG8mZc3PcJhXHPp2TzW1VMfW92iBpdRxg0n3RjI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=sOharXw28QlcWtzjJyB73loKoaN8/z740bEQPawfIWOjWCCsYcE0QQLG9ZF6F2skY
	 Rt/jJ6+kFx8iL2w9OG4qkKpodvyCW71JEK4Z8SepLlbNCh9Nipze6zSLoTjntNpYP9
	 0LsC2S8CaYlc/drfazYumkVaBuJKIUOJYibwDRRc=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: sockmap: avoid race between sock_map_destroy() and sk_psock_put()
Date: Tue, 10 Sep 2024 14:43:54 +0300
Message-ID: <20240910114354.14283-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has triggered the following race condition:

On CPU0, 'sk_psock_drop()' (most likely scheduled from 'sock_map_unref()'
called by 'sock_map_update_common()') is running at [1]:

void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
{
        write_lock_bh(&sk->sk_callback_lock);
        sk_psock_restore_proto(sk, psock);                              [1]
        rcu_assign_sk_user_data(sk, NULL);                              [2]
        ...
}

If 'sock_map_destroy()' is scheduled on CPU1 at the same time, psock is
always NULL at [3]. But, since [1] may be is in progress during [4], the
value of 'saved_destroy' at this point is undefined:

void sock_map_destroy(struct sock *sk)
{
        void (*saved_destroy)(struct sock *sk);
        struct sk_psock *psock;

        rcu_read_lock();
        psock = sk_psock_get(sk);                                       [3]
        if (unlikely(!psock)) {
                rcu_read_unlock();
                saved_destroy = READ_ONCE(sk->sk_prot)->destroy;        [4]
        } else {
                saved_destroy = psock->saved_destroy;                   [5]
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

Fix this issue in 3 steps:

1. Prefer 'sk_psock()' over 'sk_psock_get()' at [3]. Since zero
   refcount is ignored, 'psock' is non-NULL until [2] is completed.

2. Add read lock around [5], to make sure that [1] is not in progress
   when the former is executed.

3. Since 'sk_psock()' does not adjust reference counting, drop
   'sk_psock_put()' and redundant 'sk_psock_stop()' (which is
   executed by 'sk_psock_drop()' anyway).

Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/core/sock_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d3dbb92153f2..1eeb1d3a6b71 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1649,16 +1649,16 @@ void sock_map_destroy(struct sock *sk)
 	struct sk_psock *psock;
 
 	rcu_read_lock();
-	psock = sk_psock_get(sk);
+	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
 	} else {
+		read_lock_bh(&sk->sk_callback_lock);
 		saved_destroy = psock->saved_destroy;
+		read_unlock_bh(&sk->sk_callback_lock);
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
-		sk_psock_stop(psock);
-		sk_psock_put(sk, psock);
 	}
 	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
 		return;
-- 
2.46.0


