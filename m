Return-Path: <netdev+bounces-301112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qGuPFYwxOWoeoQcAu9opvQ
	(envelope-from <netdev+bounces-301112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7346AF9BF
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=Rk+PzL82;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301112-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301112-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D08E300D32A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E403ADB97;
	Mon, 22 Jun 2026 12:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A03AD522
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:58:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133124; cv=none; b=ko0jsKuh2lusni2ZXyewBeK/h0W06PXTD22VhkwKhlyx/toX3heuptMJU5WL1wgKWBlWsobND0rGBeShi/2HszGgbNmKcUlbhmY1dfagM1uVQ0KrnBFDPxHIxgR3btw5F/AUYeiytVq+7lNJxgMxuxrn4ZxE/wkjaHp5FNMhqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133124; c=relaxed/simple;
	bh=qDElADXlgQyAzLqXp1zhsofyI3JFx7Kipplc8adrurk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q5rXlDZGUqJllVOoJ2MeqjsjDUKCrT+v22d29KTO9AGwd6AHRqQuCJuHhdh5zDzybWlC3yxAnpM0P38zUF22pJpu7fYq1Jge6ldRcP+7q5Xvl5/mUNKYAhzw+uMp6bG122a4W0KsivH1JWDpH8raplkFaVcScasqOdDc8viwkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rk+PzL82; arc=none smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c074ac8adaaso521081666b.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782133121; x=1782737921; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfzBz+UdB3nbzgd5M+T+mIKozpGs1yOUYWhHRThmvXE=;
        b=Rk+PzL82GGZIwxrDYvSGS5tXANJhuLAG0DxXL2bcis3Ekg3+lUp6jYQi7zwN/2CHAR
         1kNnHJihnBQ3YVCswJqJty8q6sKFjOqYxkz+cO30Q+CByUbrSOwn0aP2BajAULOF2rt1
         OUmEb+SteutEeWqYJr5IEOKeCx7vXnFAjYQ07sTuzmzr4FCxncXXOnPD9zb/cFUbICj+
         TRWRv2VYLmGni2ik4xoSMD5vefpDBxPBLxHshBEuOPNMlyM8fT32d2kmKvXPBx3gOmR/
         lUZB36g5FJ/Q8Ikh9Smu/HdT9h5lDpzl/75kr3lhqKladELHXRMS/uiJFiRv0+m34v/G
         aA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133121; x=1782737921;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfzBz+UdB3nbzgd5M+T+mIKozpGs1yOUYWhHRThmvXE=;
        b=ghDAfNyUH1bx47PDzypoM88xdkHYCkbZp+OZ5Jo/t4Csy7ZIkYIMBIgjqXbHWldTdC
         9kDCuqxPyizEPe/fhO0uj5swjMKvt6ACWTqybR+F2eiXSblDwyCng8Uv4UsQVhZ7/95G
         sXw7jpC0dZa2OvpfG73mRlQ2Kg4utiEPsaWoLuvgpg+qBt0mXypoB8CxTXxkQo2UxoYc
         +i0QIqtP95e82KEzbpyNbtXGekowvig0CSBVujCVryJlm20dpClI7xDpbTrWNDrneZ8G
         cxmDahHJ6CS3g4ZudWTmoE+PC4F08FVEwE5P6Nqvy7kvqTph1QxgL77sKxPGM/K01rhd
         Ad7A==
X-Forwarded-Encrypted: i=1; AFNElJ+3bE39kgTAw6RqhX4JRyGOU+sfDVJbws9GuDt8hUwlFRrJI4wV7NzBCycVUds35GbjDZ29RHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOWf1qAtM1AORxChg8czDTHj47HEWNdEsNM8StOr2HXlSBMcP
	J7rGHFnU4mdi6NHEIjFFBkJ5ZzDSItUVIENOIX9gNbdpUNut6zvULgzQ8L62zhXA8Ok=
X-Gm-Gg: AfdE7clH6jSki5IuJaN0Tx50Nrw4M4ko67JDlQpmWY/FayusYSa7E0qZ5OsxoSADP/w
	swb6iy9TvkqooSzRbPjM2jmoumzfaUoT8tojb07jLP2kR2sO4CK/7Y0Xocn40vgiAycEFPtK5n1
	QBzrUr7KqA7X1FYRO5HSjyZi75StWFbp+v6Key9oQrN2YH5xSGRTkzyLWeLf3eblsswWXBaIY4b
	O8d1ZIIFpnVYDtBu4zVbtzZhS/H5BNHWbfXI3iJDT8iDOYR37pCdqNeopmpw89nZ6130s09mKhK
	blK1Lzi+CfYskDpW80Oc2I29rQypp7kJBSNfvjryT5nC1bnb/Nez+FvuCFxOcDLty8r5zX2A3Qk
	nBJfmw/SsmmU99pNhbLBBsKX3YiYI4nuu6qyQnHxqaWU7PY1mnoDkDE6pLp6b6CbQF8mAXlpUOs
	n7lOh1D9+5lPrkc1uu3WDjdrh2Ho5qINdxQDf3FRkbtgQWVq0WjzCG5qHmPRk=
X-Received: by 2002:a17:906:6a29:b0:bfe:ed74:523 with SMTP id a640c23a62f3a-c098f12eb0emr774449366b.50.1782133121181;
        Mon, 22 Jun 2026 05:58:41 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60bbf2b3sm352712766b.39.2026.06.22.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:58:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 22 Jun 2026 14:58:34 +0200
Subject: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAHkxOWoC/yWMQQqDMBAAvyJ77kIMYsWvlFKaZNW1bRqysQTEv
 xvtcRhmVhCKTAJ9tUKkHwt/fYH6UoGdnn4kZFcYtNKtarVGEwaU1+MjI0p4c8LFc0Z3rRunSDW
 dNVDaEGngfH5vcCSecoL738hiZrLp2MK27f6dcC+DAAAA
X-Change-ID: 20260622-bpf-sk_msg-split-unix-d714d0e048cb
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED7346AF9BF

Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/unix/unix_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index f86ff19e9764..5289a04b4993 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -7,6 +7,7 @@
 
 #include "af_unix.h"
 
+#ifdef CONFIG_NET_SOCK_MSG
 #define unix_sk_has_data(__sk, __psock)					\
 		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
 			!skb_queue_empty(&__psock->ingress_skb) ||	\
@@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	sk_psock_put(sk, psock);
 	return copied;
 }
+#endif /* CONFIG_NET_SOCK_MSG */
 
 static struct proto *unix_dgram_prot_saved __read_mostly;
 static DEFINE_SPINLOCK(unix_dgram_prot_lock);
@@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 }
 
 static void unix_stream_bpf_rebuild_protos(struct proto *prot,
@@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct proto *prot,
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 	prot->unhash  = sock_map_unhash;
 }
 




