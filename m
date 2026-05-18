Return-Path: <netdev+bounces-288933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBapAwvPCmru8QQAu9opvQ
	(envelope-from <netdev+bounces-288933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:34:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D8568E27
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6962309C4A4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E53E9C01;
	Mon, 18 May 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpy7W49k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE63E92B9
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092680; cv=none; b=DQkUQoBDad1yVBqfCElMJ7dTPrHcF4xP28Pj/o2mksy203fputlEXrwczv+cAKx4HQrO7mDJP6Rk7blhn7IZkSNJfJdVBhDjuoWxrn870UvxLBMh647yvHA3AKbTIzFW7oUKbrHQtOywjufjpArH7BBuuPDQ/k3mXM9lfWKGMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092680; c=relaxed/simple;
	bh=Jkc6LVVtFSgsvJtOAuT2zcOAGRr/hkZce5UzLzUwX+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7vducNSldIrjvDRwW1921J/Uk6sBnrdC8TcevKGnkaUdh+eBsB20Out+4YFZpmohB6Q4S4hPeyzGX1p/I0t3p+0j00W16M/vne9CphSL6c7EaiPC5jJNAj8d+xRPO24ATFhQj3pe6ly1hz3cSDPfawffKa9ozwcREA1vNM0gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpy7W49k; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3698e34a567so1464767a91.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092678; x=1779697478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Piiu4CLk9tYF8O+ZNuJG88LykfnzhUDaL0nTx5+fqDc=;
        b=Fpy7W49khIzzfiDJuWu5ot+AycQkJqbFJmp+bfAawleOYIoTaSKfEc3uSs4gssKOAJ
         m4tQnrBL+xn1LPocWYw2ooVIujWRtuTN7SDUUEd81LoXe1gWWfTSgP5C9gbwxP74hTDI
         FDqzuMSvUp01mjkePv1gmDoPkW4HEo1kMu+aGOqgV5gpZLRha58FgLB+ln+Hnu2LV0ae
         WaAciPsxHFj8gL2h3qbQV0cAYkv/1/vUmGvKQdaBgc8t2K2b9Xjrf1XAO4t0rCpGP12N
         nb80vHNwLDLb217UoS0nr8pAhtcsZZXXOzOCCwr1o0GfXdUd5gHJPDvlTrRhWpaJbFav
         IJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092678; x=1779697478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Piiu4CLk9tYF8O+ZNuJG88LykfnzhUDaL0nTx5+fqDc=;
        b=E2m2VXE2nHZzv9z0tArsDlmMVvJ+72czvSKqG8llgKrdX/Dkb52JzQHatU6NEg/ROm
         nQGqwFgNYGzPSlzLrBIK5RXNN7IOucYr0dtnT4lEuSWBkZkgnZhFUSLa8mal/WlFAWZK
         SxYD3M1PkAKdxs5fD7vcXNG9iSchfSY9LjQ3pP6jzC6dVL74wm7n4V7G11xg2pOpdDnH
         bgDAkwpDObOlCBoWc6QAdyKK1pFjVooVKfNqO8dcKi39jaMcp1WJXfxbCExJikpS6dM9
         SahBNwD6V9RYVyV7XTqF4ReCIF0AhshYXwadB7E96VrV1Rr4h+BkmRyhTgl0rHYmMxlV
         /HFw==
X-Gm-Message-State: AOJu0YzZI0P6R8s8OQCNgoIEE08JZeYVXU50xINNeZK+mg0Cahei/b5a
	9eA/3w3vQDFjClvAHJq3d+ppqn2eBqXeSSMWsi2qtM+/sqUNNztspIF1
X-Gm-Gg: Acq92OGMbPQJgEkTGojXjCKi0okj+hljS5DWn5xKbzebC2R1/AzBJMIEif97hE1eu7X
	CCD47jq8nvFCE1CQz0xYh/uU9nOMpZEUhDz/D9PJlsZkVzNtkBOh2a4eqKK9sOHI396OyKsa+Tt
	RN/MV7ZCFk8Ix4rmnOt0aKya+U2nMbdfRzJr2VHziqNcKXeGXipFnFyjjXIqMWqob12u6L7kzgx
	FoiAQShK+y+83AhWZTPJrG7Dp20PXUyKCTnd1NxNAXg+VMqpticpsas86bo3SHVrZbmUIe2ybSv
	47qHYIp9B5JqfLyv9pVysrl9eVwGaHMXrMEyJQkTIJf3BtYzO+BQ9wBM9C2ItBLf4HxqNb5Nf2+
	8hOxI1BTkH1pYqRw5GguSe4xHkKFQSdN6PNzE7slG2ENJOl+JesIgtwyWAxLgqogTNN0sekDJJF
	S6cWXbxL9ip8TVT+1blJgdvGEEkRr9dx3UY3ECYjJ2VYZ/X8800xczsZdzlJl+ri5yZsUXm73YJ
	/vEy/D4u9OmwMNFNUeyrgdJF3arzhan++H6WQJy
X-Received: by 2002:a17:90b:58cb:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-369519cdf58mr13816301a91.6.1779092678357;
        Mon, 18 May 2026 01:24:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:37 -0700 (PDT)
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
Subject: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
Date: Mon, 18 May 2026 16:23:43 +0800
Message-Id: <20260518082344.96647-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 989D8568E27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288933-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
 net/ipv4/tcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 21ece4c71612..64c69bb3578a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	release_sock(sk);
 
 	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
-		if (cmsg_flags & TCP_CMSG_TS)
-			tcp_recv_timestamp(msg, sk, &tss);
+		if (cmsg_flags & TCP_CMSG_TS) {
+			u32 tsflags = READ_ONCE(sk->sk_tsflags);
+
+			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
+				bpf_skops_rx_timestamping(sk, &tss,
+							  BPF_SOCK_OPS_TSTAMP_RCV_CB);
+			if (sock_flag(sk, SOCK_RCVTSTAMP) ||
+			    tsflags & SOF_TIMESTAMPING_SOFTWARE ||
+			    tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
+				tcp_recv_timestamp(msg, sk, &tss);
+		}
 		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
 			msg->msg_inq = tcp_inq_hint(sk);
 			if (cmsg_flags & TCP_CMSG_INQ)
-- 
2.43.7


