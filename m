Return-Path: <netdev+bounces-205360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B641AFE4AE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFCE4A84D6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067E289369;
	Wed,  9 Jul 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Oyyig15I"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64373288C22;
	Wed,  9 Jul 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055043; cv=none; b=JrsE5IaF383CT1ckffzZbOGAIhv9fzVtlB/yxgYbuQRt3TDMPSIX9ccehRBbNikaAwZ81ISbV0zSCOYj7QgUXuoHfa+rlqSCMu4h0kMMOtBZPfv0Nfy44R21qWmYnTutwJQCVhIq41ee72Z6gnNzZ8WOFpwAzRq5HlkZ+Q06GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055043; c=relaxed/simple;
	bh=Rpr1qZWet2oJ5UN1O/+auB4Sj5KXTPC7nmvjdMF/QmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgwzTyvoAbPdIMplj9EDERrw6AbNZ57nqVFNds3QOigAGjhEIULHtYo/vd8JMaZ8cmeUrEFXS6moEqfCegoG+aGd6iKr500vmXUu/dLpr8Jihg//ZTQZ/QhQEj2ryUk5Xg5TTrSoiacN+9J+pny7JSGkcmmXjzzmupg7iMYHMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Oyyig15I; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7T
	Rk/JAg0+AJHbcUQmmmgLUwsXb6N5sbLLwQWGDBboE=; b=Oyyig15I8/Dh7sTtBq
	TmnTHIM/EJLeRq8y8PfYDhmufLmgD1tyJOZddq4yY9hLIQYKEs0zFIFlZXnGFxC5
	BUB9FyYvIo/b+0eZSkrMMSUC4k+MexXqKf5d0kU7+v2s49nFxR3psDasAUG7UUWF
	6bf66Bi3nZSQurlNlyptJCNbM=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBn08jlPG5oBz4hBA--.440S3;
	Wed, 09 Jul 2025 17:56:55 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
Date: Wed,  9 Jul 2025 17:56:52 +0800
Message-ID: <20250709095653.62469-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709095653.62469-1-luyun_611@163.com>
References: <20250709095653.62469-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBn08jlPG5oBz4hBA--.440S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13Zr17KF13tF1fJryfXrb_yoW8ury7pa
	yYkry7Xan8tr1jga1xJan8X3Z3X395JrZ3CrWFv3WSywn3tr9aqF18KrWj9Fy5AaykCa43
	JF1vvr45Cw1Ut3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwo7tUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWxuFzmhuPGkO+gABst

From: Yun Lu <luyun@kylinos.cn>

Due to the changes in commit 581073f626e3 ("af_packet: do not call
packet_read_pending() from tpacket_destruct_skb()"), every time
tpacket_destruct_skb() is executed, the skb_completion is marked as
completed. When wait_for_completion_interruptible_timeout() returns
completed, the pending_refcnt has not yet been reduced to zero.
Therefore, when ph is NULL, the wait function may need to be called
multiple times untill packet_read_pending() finally returns zero.

We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
constraint could be way off.

Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from tpacket_destruct_skb()")
Cc: stable@kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/packet/af_packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3d43f3eae759..7089b8c2a655 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2785,7 +2785,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
 	int hlen, tlen, copylen = 0;
-	long timeo = 0;
+	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
 
@@ -2839,6 +2839,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
 		size_max = dev->mtu + reserve + VLAN_HLEN;
 
+	timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 	reinit_completion(&po->skb_completion);
 
 	do {
@@ -2846,7 +2847,6 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
 			if (need_wait && skb) {
-				timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
-- 
2.43.0


