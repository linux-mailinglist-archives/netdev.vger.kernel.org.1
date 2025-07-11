Return-Path: <netdev+bounces-206103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B60B017F1
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6706175524
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9927B4E0;
	Fri, 11 Jul 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vrtw05AQ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0F27AC5C;
	Fri, 11 Jul 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226412; cv=none; b=kOjsiJLyulhYltZIgbQGbJG7h8Tu9wiq+V8EGH3OaWub3BT5qTM6O7rJZh/Gq0PQ+VLd8XY6lNEEuLn5py6nww6blTyz76m+02gURVuHtf++Rg1fMM1hMKGDPBBsoLHaDB0cn5O8cWrJCxxPf44Jqb3WlKFKTahYxr3+c2HfaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226412; c=relaxed/simple;
	bh=V7vFD7/Fb8G++Y1kaiWeRxlwbZhdhohmLHeU+PMkKdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnBvxN18JO0MSpmTaQhFJtPv8V0Z9NPat4o+KhLRyc9ydiOvxbT1lcStzgUX8KHV4ozRpEtBG90RhsjTwAK1mWDTSiRCftpsGgeGijOMUsnyqXdW3T8HDuGIEvranRyC2KkTIa5M9Nltj3gv8WK54jcuo5Sfo4ug3sEMZEbTSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vrtw05AQ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9j
	sQItpI3KggjxElmfZojdWrsrVGwjxm/rP2m4AKOMA=; b=Vrtw05AQ/LpDlPXBx/
	0rQtJnfmOZhONRG8BbCPLXSdGgFCx4XK2bYBVlc2AJkvQ8bUxdKHgh0FT4KhGTV5
	VXSgB3nkgbHR8KY6OpWmZxe32/sATEU3Bv/gTKthxLm/pXFz5hM542obfw8S9Ie8
	OA1gGc5gKzix/178lVHyiq0yI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA3hOpP2nBo+FkNEQ--.57493S3;
	Fri, 11 Jul 2025 17:33:03 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
Date: Fri, 11 Jul 2025 17:32:59 +0800
Message-ID: <20250711093300.9537-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711093300.9537-1-luyun_611@163.com>
References: <20250711093300.9537-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3hOpP2nBo+FkNEQ--.57493S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13Zr17KF13tF1fJryfXrb_yoW8tr4rpa
	y5K347XayrJr10gr1xJ3Z8X3W3X3y8JrZ3CryFv3Waywnxtr9aqF18t3yj9FyrZaykAa43
	JF1vvr45Aw1Uta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07js9N3UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiOgqHzmhw1LywqQAAsQ

From: Yun Lu <luyun@kylinos.cn>

Due to the changes in commit 581073f626e3 ("af_packet: do not call
packet_read_pending() from tpacket_destruct_skb()"), every time
tpacket_destruct_skb() is executed, the skb_completion is marked as
completed. When wait_for_completion_interruptible_timeout() returns
completed, the pending_refcnt has not yet been reduced to zero.
Therefore, when ph is NULL, the wait function may need to be called
multiple times until packet_read_pending() finally returns zero.

We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
constraint could be way off.

Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from tpacket_destruct_skb()")
Cc: stable@kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


