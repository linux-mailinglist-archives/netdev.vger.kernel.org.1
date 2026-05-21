Return-Path: <netdev+bounces-290473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JadJskdD2rbFwYAu9opvQ
	(envelope-from <netdev+bounces-290473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8C5A7C9E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314FB338DE49
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E33E9C2F;
	Thu, 21 May 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8VrGpVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAE3E92A5
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371629; cv=none; b=S6yeeb5+sOZgW6aqHTkY1kpdLJQbUEmUwtLZOHW3fRhHJJDDUFpiz9fYxIyoWY9xu9rFvyW3rL5H6xx6L6oitwV4ASzHN7v6H0HOoX0JljDfgmj+dYQTBydbIEYvi69gCZ9ItgY7h8knPgAkuKL5cg9hJ8YDzaT+KzQyXcNhcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371629; c=relaxed/simple;
	bh=sPvR+qunGDGOG6xiEtGhN6/caa7iP7K0rRsIBTE3Hac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0Xc9c9tM7xsXrnSmZez9DKRRpRZl3JMxwFPoC62JPmpa/G0sxTxDXWFPo/lili5c4GwykGGrlbkdIRMcVS5xZg96e1NFT1bVxPWGf/5XvJJTsfHrBh06faMpC4pi2N6gSZ8ErLAq6n/eCkaYBwBbuJgUmEDaITJskam1qM+ZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8VrGpVH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8016d642b2so3033503a12.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371628; x=1779976428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYYe6B1gyz3MHLfiW9GccKcqGYxd6tgMsc5Vb+al0Fg=;
        b=p8VrGpVH1iE5ze+XGWF5KZhNA4/bZJ40oYT2/ENt4/3YoTgoZY8Z0Azb/Jl1OF+yBz
         mUkkF4M3Msvoxjxwwa5UA4nKgvhxlgnAs8bPbC2mz7Ue67zSRmBmLUFwkQOoN8AhvOzA
         kdT5pWdWX7XCKSdrNP69sMJvROaQZWTNVcfRjIfJXwvWvnAK3N49MKyf/Ust/WfRZmK3
         ojB/n70PJDAwguXVplVTfA0N+SwzxkTI9NM04AvV2A8itX/PrTeLSZ+2+qVv1ms73295
         YrCvKiBsylC0tOF+K1I3ytxpTM42ZISiRrTbj4RODdAEgwxNxZ5+tk7UA4ITulWAd8Pr
         I71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371628; x=1779976428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYYe6B1gyz3MHLfiW9GccKcqGYxd6tgMsc5Vb+al0Fg=;
        b=i5ffkuR10rnVhO9VP4OExvxF/KSIO9VoxElt21hl3nzSww95SjUcoXg4LEMpQshAJ7
         Y0oy24VK9LvU6X7g4OZCrjg+74gyhlQiAZ0zk3leL4tc2Hd7fnXK0Pi2Ex+KPnXktBek
         vXalLfcYVdicnawCpkcbdZJHw/pr4fjgYe+t1YLqQlcW5TVWnSDsVQ26EVREpnw8Ge2i
         R3sJHhYGS1U2UItVPvc4leOJ7BLr/4dEjtEAUhnunjd8ok/2RHEiV4H0qwaarvOsTbEc
         rEt5CTYxlu6EZgewqDknABmF72moLREKYpwuEDDA9u8pQaQKxXDlvvsgobI9U9qFegGa
         rmIA==
X-Gm-Message-State: AOJu0YyrAvw5ENP6EIsNgIsG6sgSwwDI+IEB6WE5GUjoQtnHqz7RY309
	/mL/wUzxvIPaqh1k5Rm/RR9+Tjo5mO1enlxVdIc2FJ6gShKeBeDoABCQ
X-Gm-Gg: Acq92OEma5ZH/9kcPCMpgkLRldATHVQkrddCLqxM1SfOiLvMIDXsiriMBPmbY/dR9DC
	sgEKbd8dLHAfsYCdaQH6w28CHL/vg07oXnDaHRN+zH8xVzz6FIcebK3j4OUHbQAvsY3Ni9IO5Tx
	+0My7VUaaRLVvpEO9e5Eot5kyM0GrD1vtN67tHkCYnkvSWsHUfCw7UajYEE+Xy/9kERLRPIxN3o
	Ug6P2ZWF3NBTzd0m4pRtf/kKAag5Mj9t29uGMof0aTyBvZlSXaeW9zA3GshyKIdbzXso3760/Pn
	XHptHin7roPWuuNcs6Njb3IVwlRfpyQghChizjOr0NZjFUddrwD6Ddv2ny6DSancPwFxsvMqqCp
	1uR8cIqRyptcII+M1uzmsp4k/73CZeDOJIY7h0LSZP1IkNF5GMSdI5vXt1fZ+GtxPDgzVr6z4lK
	qLuCboNp3y7/8Hb6lugineo2nBI5sB306jkbRbguhNfypY3GMJcRcDcszVwH1W0FYhDQ8JXDy8u
	Dn7UAK1GtvZ99qjTiBqvRsB8qMD0b597QSUYmuzLQ==
X-Received: by 2002:a17:903:2f90:b0:2b9:6cde:c34b with SMTP id d9443c01a7336-2bea229bfc6mr30322615ad.15.1779371627790;
        Thu, 21 May 2026 06:53:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:47 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 5/6] bpf: enable bpf timestamping rx in TCP layer
Date: Thu, 21 May 2026 21:52:43 +0800
Message-Id: <20260521135244.40869-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: F1B8C5A7C9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add two if statements to accurately isolate bpf timestamping and so
timestamping. They can work respectively.

As to so_timestamping, only add a loose condition via report flags
to avoid duplicate strict checks that is done in tcp_recv_timestamp()
and performance impact. If the loose condition is hit,
tcp_recv_timestamp() is able to handle the exact case and doesn't
hamper the existing timestamping feature.

Make it work in TCP protocol.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 21ece4c71612..7ad3561dc8cd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2353,6 +2353,16 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
+		bpf_skops_rx_timestamping((struct sock *)sk, tss,
+					  BPF_SOCK_OPS_TSTAMP_RCV_CB);
+
+	if (!sock_flag(sk, SOCK_RCVTSTAMP) &&
+	    !(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	    !(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE))
+		return;
+
 	if (tss->ts[0]) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
 			struct timespec64 tv = ktime_to_timespec64(tss->ts[0]);
-- 
2.43.7


