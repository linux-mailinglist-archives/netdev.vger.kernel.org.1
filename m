Return-Path: <netdev+bounces-95751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF28C354C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 09:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53CA7B20EB9
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891AFC11;
	Sun, 12 May 2024 07:22:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2ED101CA;
	Sun, 12 May 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498532; cv=none; b=W3VHfA+oF/NXaill6GprpYFRKQhofOkN/kIshiwwo6Ei8w/xqflexnY03kK59fc3s7hFrQG933GeG76GGNYsWaUoe+obv52i+laa24ocn9AtN0LR4TH2aVum3GLbW2nViYHVzL5+Sa9QTDiGyxeU3bzC89lnrLDvbdCwyQlXnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498532; c=relaxed/simple;
	bh=66Jqedg9cXpHoydTVuNznaoG+hIkMQD7XMiOtPkepiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j2wcfna48ysxbVDBsJHzQGhqHvBD4sw89OIzFep5V9h6UpWTnisqNHeOmMfAD2IFbD4z0zfgSJ8MfzCCSmj9J3s/zhq7MyJP8aAvIFaDnNrTe6GQBCNb5vBBW9ejBi3uLMNkyqfdE+5AS7ln35+/ZZmCBllZGOm+p2m9uqcHWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44C7LiBq058242;
	Sun, 12 May 2024 16:21:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 12 May 2024 16:21:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44C7Li58058238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 May 2024 16:21:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
Date: Sun, 12 May 2024 16:21:44 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If a BPF program is attached to kfree() event, calling kfree()
with psock->link_lock held triggers lockdep warning.

Defer kfree() using RCU so that the attached BPF program runs
without holding psock->link_lock.

Reported-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
Tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Reported-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a4ed4041b9bea8177ac3
Tested-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/skmsg.h | 7 +++++--
 net/core/skmsg.c      | 2 ++
 net/core/sock_map.c   | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index a509caf823d6..66590f20b777 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -66,7 +66,10 @@ enum sk_psock_state_bits {
 };
 
 struct sk_psock_link {
-	struct list_head		list;
+	union {
+		struct list_head	list;
+		struct rcu_head		rcu;
+	};
 	struct bpf_map			*map;
 	void				*link_raw;
 };
@@ -418,7 +421,7 @@ static inline struct sk_psock_link *sk_psock_init_link(void)
 
 static inline void sk_psock_free_link(struct sk_psock_link *link)
 {
-	kfree(link);
+	kfree_rcu(link, rcu);
 }
 
 struct sk_psock_link *sk_psock_link_pop(struct sk_psock *psock);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..9cebfeecd3c9 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -791,10 +791,12 @@ static void sk_psock_link_destroy(struct sk_psock *psock)
 {
 	struct sk_psock_link *link, *tmp;
 
+	rcu_read_lock();
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		list_del(&link->list);
 		sk_psock_free_link(link);
 	}
+	rcu_read_unlock();
 }
 
 void sk_psock_stop(struct sk_psock *psock)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8598466a3805..8bec4b7a8ec7 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
 	bool strp_stop = false, verdict_stop = false;
 	struct sk_psock_link *link, *tmp;
 
+	rcu_read_lock();
 	spin_lock_bh(&psock->link_lock);
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
@@ -159,6 +160,7 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
+	rcu_read_unlock();
 	if (strp_stop || verdict_stop) {
 		write_lock_bh(&sk->sk_callback_lock);
 		if (strp_stop)
-- 
2.34.1

