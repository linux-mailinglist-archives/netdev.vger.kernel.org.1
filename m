Return-Path: <netdev+bounces-246739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56BECF0D17
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 11:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5527E300942C
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72F26A09B;
	Sun,  4 Jan 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrqEheWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC316DC28
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524269; cv=none; b=PiVN4173X9fMD+tKqhzmtpfNgPtD9yWphjIDG5vI6RFvaKTIR1BWlycSKFN2yLrYVFPEzy+nruW8rwVqxKK6pNsF+VQzp2FBZ5KmJD6ZJMw1r/mbBEfFJa6rFFfq3YsR7nD2/+la/WgbATnYyF5LpOfzoyPJVltopKTgQwaz/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524269; c=relaxed/simple;
	bh=ToXSaSvHXtKX2QRxKYEYwL3ZEu7LNb34jWKKNlkc1IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mCsxWZcEBPRa5lbYENpNJDsKpqFwEXoR4615OSoIoPH4a4AKne0zQ+bjaK4M2VJcbWri7myG14H2OCQFRVu6zCkmDaVmcdHLClTgHvDcarWOHUC7VJb7wpf3uzCOMXPZb6TO8DmGplCxYw0VyhGpVKqrvPbe54wz8Xn0EZZd5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrqEheWl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so10480237f8f.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 02:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524267; x=1768129067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex1tzrhi+VpVUpcNNg8DPlqsj/+xBz28OKRugjsNrj0=;
        b=FrqEheWl5018s6jF9ab4SBiYnFWRmItS1uXciJXrjBSW9IUDOoltw4jeMXSZhbIOBJ
         SsPPwluT+36iKBrv2Cft6jdgm5l7eGiQxKEQo7bjdnfCne/t6v7wTklcqiG9oVvqSdNH
         4jUndCkdIuO7z3lEPgqoZrLAnwfAHE9isQrrcFrLozF3v5v8Xm7Y1I9wTg8AwCMeAzpi
         UWnSYfrzgIOVzmJuXQjfAZI1r3DjGt5Ejkw72x3Clx1cJoqZ/4LIAP1V/Puw2yywZ8Tx
         HFD23a9HeRvVzvqXEnKzKkILNwwEM1KUyUik7HYeRpx6Fl/UTfymk+Ljph7Ki2iUnFZD
         G0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524267; x=1768129067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex1tzrhi+VpVUpcNNg8DPlqsj/+xBz28OKRugjsNrj0=;
        b=YLczgLVLaq7zew0QLMmj9GhnJ2xZGjimPvAv6bTzyjApZDiFSvDAo/QMb1wYxvToIC
         J7ih08sTfpIzM6Dm7B2iAweJdtioUfw3TTs8oB5xIkcPkAvImJ+GTWx0mGaSKZRrdxNI
         bo+IDDvPKYF28xFc7p8GYNMZ7dgQ+lk5dklhw3QQXqyI2W16hpNwzFjXWwp2Z6fSFeGj
         ECs75a3wWWbMAtD3UIITRzlEiLxwAk6JuLKp1hqW+TsSKsUeYKKjMuWkB6fei9R5xO79
         beu79DuvkYD/0R/f7X8Frnj315vWTwjsqbH5vnLuqBBK2F4J9GLrVrl/IeqBnhXNfd/3
         UIYA==
X-Gm-Message-State: AOJu0YwZR4Y7NlcgoYGZinwjYbr8et3JVqxOrRXohmwW+68QrEnALD3d
	EEgp8KS7hxrz0jJ2wN670OVgPFA0Z/JcGa4O7W6LmxnUgExgCbGo2Je3ZYf6EvMZ
X-Gm-Gg: AY/fxX6moJGnPgQgemJHIZdXBXwHHaFaeE8WdChl6x6SHVupZMXBm5jPJ1xcOaL54ne
	/xu7dBbzGUj93T6YMcnPT0r3bbpehao7bIU1Xhf9HuLILwg8oam0YQoQo1PMzb5F1GpuHNfB74u
	HTZX2UKYqbCNdsCHV2bndclHmOjqW26eW+2zW2awhMG6R67wS0uT0iriCWiWS9j+f1flU+2ZIJq
	X8jjhTiF+IIe2eHiTDZck+V0I55i8IegV2uzDTwA5GHsjnYJJa1XGsoD8wyLgq03g+n00dknONx
	rEdOhcBiZIG8XduWD6JZninF0FdTttrwhKyYtfX3BWyG75YBHsEzL6YHUhmtvkhMEwbgOdPcC8e
	XOU2wZcaq3XkAjJBzFDNHg7m36T9CPVsHDDIvJWxRPSlMMrI0G7J5O9WDH+gjxSk/iQWuxecfWl
	Iq
X-Google-Smtp-Source: AGHT+IE7kuYxbDe09JzMytqtigdG/pIaA/9PUcoDUeH+C+eF8YcTSGWrElUz8p2vRvtloSsxIaHlhQ==
X-Received: by 2002:a05:6000:4202:b0:430:fd9f:e6e2 with SMTP id ffacd0b85a97d-4324e4c3e3cmr55330940f8f.9.1767524266505;
        Sun, 04 Jan 2026 02:57:46 -0800 (PST)
Received: from wdesk. ([5.214.18.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm94682897f8f.34.2026.01.04.02.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:57:46 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
Date: Sun,  4 Jan 2026 14:27:32 +0330
Message-Id: <20260104105732.427691-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues").

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
 net/ipv4/udp.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..aff8cab57 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1709,6 +1709,13 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	int dropcount;
 	int nb = 0;
 
+	struct {
+		int rcvbuf4;
+		int rcvbuf6;
+		int mem4;
+		int mem6;
+	} err_count = {0, 0, 0, 0};
+
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	size = skb->truesize;
@@ -1760,6 +1767,17 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		total_size += size;
 		err = udp_rmem_schedule(sk, size);
 		if (unlikely(err)) {
+			if (err == -ENOMEM) {
+				if (skb->protocol == htons(ETH_P_IP))
+					err_count.rcvbuf4++;
+				else
+					err_count.rcvbuf6++;
+			} else {
+				if (skb->protocol == htons(ETH_P_IP))
+					err_count.mem4++;
+				else
+					err_count.mem6++;
+			}
 			/*  Free the skbs outside of locked section. */
 			skb->next = to_drop;
 			to_drop = skb;
@@ -1797,10 +1815,22 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 			skb = to_drop;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_RCVBUFERRORS,
+			       err_count.rcvbuf4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
+			       err_count.mem4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
+			       err_count.mem4 + err_count.rcvbuf4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_RCVBUFERRORS,
+			       err_count.rcvbuf6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
+			       err_count.mem6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
+			       err_count.mem6 + err_count.rcvbuf6);
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1


