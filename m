Return-Path: <netdev+bounces-280178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN3fJC2i52nw+QEAu9opvQ
	(envelope-from <netdev+bounces-280178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43E343D329
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE123020D44
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70133F5A2;
	Tue, 21 Apr 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bykALty5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38731344D82
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786743; cv=none; b=PzGEZSnFmZjqJ5q1+WpeiEcCZ46zcsN+lbHvfNxC0eibT/kmuv7ANRAxfbYDlhASqaGHY8U4feqgoJLShdAA2H63WgLWnDB/NRvjJm4Fin1W2biL7KcFvz/TDzZtELuDynmCLFSrl3iYtJ+V8YCh6RUx2cmkTHu5Xebxh193jD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786743; c=relaxed/simple;
	bh=5rJOMD2PEwPgKsY/Pomu1Z6FwKocBEb+ZZZlVkuvY8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkFqZh34biem3+/AnK9qVlXfGGNzM1JLrLyIJ/Xy84qUoqVASVOR/ohj94zkKsm/7H0jNB8sU/GvOcfoa8enSIMSUM+bbViFV2BxGu1/BkprmWkEL4zMZeBtr5j7xc6KW8CigOPCUlz7NgY+JPpFzJ+mMHyF79Udr3gpSODiQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bykALty5; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c726ef332so5844252c88.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786739; x=1777391539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45ymFIxphyJixlHGHv+r0Hhagbw0y8tExebfBXG9KLg=;
        b=bykALty5+dDl+lJ0FxYOONBVnf2BvBpHZ6lIbhBV09OR5RQJtxHE4B3IXLdx1bFv5S
         LCjb60Srb/AgKs4Rn7C+vviFQ4XVLhV4rn9OX1P2JnmD4Dd7jxTXY4F3Iavpw/wFgSm8
         4elYdm3PSEeP3gcgYJ5FdFJI0t5QhGKNR9e92Nn+YAfhQm/drk9O7cO0MJC7RFX+/KfB
         deP2242A+RC1/iCM40qkJRkMa79P5Aj1+IEv5A3AWhkKad2Nur3Lpp85VwO4fQs5ax9d
         /FE6dclR7xqGKftpGDGhEpkz4OyZqLYIuyh1EeQhOU//c18p6iImrK3b7B+xeiVqK5PO
         NDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786739; x=1777391539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45ymFIxphyJixlHGHv+r0Hhagbw0y8tExebfBXG9KLg=;
        b=tGli7lN/8at63nw0PCSmOA4tzPO8KmZk9OjKcaGf/l6ETcef4iJy4T7RvNTGV4+U+F
         +9dPHSCnFudv17Iu/AB2M0JaSZ29l1291Xx4+Pmzdof1eIb7fTfI9DfAWYwJgo0wEury
         zRqp37NKA7sFkeg+Nb6sU7pzZvoKjoC/IZ6UFSOAZIN761fI4j7xInGW2wAhfYWr2Y+5
         c0DApZZKiP43nnXlsz2vYhALYex97kWOOIhs+HFkk7XjSg5iuxD8UO632Zp06hExrQpG
         1wT0+24TWuA2Kxe31GIwHDDFNdUDKNSsMIP5voVRRDjwBIz//fak+7JAXJ1+iplNzua9
         FLEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Uf2I+XfDxhvc384Mq/LfYXFPZQIixU4/gOB5OLeVycHNVWZQ/B0Gpj7zlYZX1FhezLEcKots=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB94ZAgbA9bQZ16Z6J25BleJfH72T6ezR4n0zkCYJwE/kVnDfw
	VdOkvN4edFp9fd4UCXLFPubEYKR+GXVufkUq5TbM9rl6Kve/3PmvdkKM
X-Gm-Gg: AeBDievIfT3QMVw08hXFTg8qgV4/uuN7RuZmEHttePG/8LnrXL+NWCXsIqnorwy3Nsg
	DpjteBUwW6QIwn2FDCwPixGMubw/DwY5Yp+bs6Qt0feQsDTJA1PGtCNgDaHgKC+6lmel5Fn1WQE
	NRlQZIS7TNoXU5D/eRbhfyx9dvU8x83HCEfyTDJx8un9JCmVXFKqqHW7t0nzeUc8g0u49WdW64s
	w1L8QRHtzFQTf+lZ1EJIbB8FVlEKHhtPzLTF4Y8hmcP9r8WwP+jEpFTEIhUQS3XTpf8o2LyQbM+
	9JjxGuf/ZC9/E8gTOSyTBSFvzco3BVhOqZ41mRw3vkEUuQIXE5GBTvWr1zq7rlvW2JLhwZBSUcI
	f7j/cslAMDn4qUAxqfkSaIdTeyv5M7gFUqmBg9GHNSpjNap17XBtrZU46usUvOpTZ3uveX9XLKR
	bMjZGzcLiCoUKn6uhwVLf1iHISPNQGi4TU+dKCNCmBDPtZ7k0Omi2i0zykhuejuThZEjjSndaVr
	G6W0mYup+MQwVxVrZtwLWky7IqRRyg=
X-Received: by 2002:a05:693c:2b04:b0:2e2:a4ba:84ae with SMTP id 5a478bee46e88-2e479017499mr10261853eec.25.1776786738589;
        Tue, 21 Apr 2026 08:52:18 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa3ce1sm18593484eec.4.2026.04.21.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:52:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
Date: Tue, 21 Apr 2026 08:50:25 -0700
Message-ID: <20260421155024.997077-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,baidu.com,vger.kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-280178-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.653];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: E43E343D329
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

bpf_selem_unlink_nofail() sets SDATA(selem)->smap to NULL before
removing the selem from the storage hlist. A concurrent RCU reader in
bpf_sk_storage_clone() can observe the selem still on the list with
smap already NULL, causing a NULL pointer dereference.

 general protection fault, probably for non-canonical address 0xdffffc000000000a:
 KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
 RIP: 0010:bpf_sk_storage_clone+0x1cd/0xaa0 net/core/bpf_sk_storage.c:174
 Call Trace:
  <IRQ>
  sk_clone+0xfed/0x1980 net/core/sock.c:2591
  inet_csk_clone_lock+0x30/0x760 net/ipv4/inet_connection_sock.c:1222
  tcp_create_openreq_child+0x35/0x2680 net/ipv4/tcp_minisocks.c:571
  tcp_v4_syn_recv_sock+0x123/0xf90 net/ipv4/tcp_ipv4.c:1729
  tcp_check_req+0x8e1/0x2580 include/net/tcp.h:855
  tcp_v4_rcv+0x1845/0x3b80 net/ipv4/tcp_ipv4.c:2347

Add a NULL check for smap in bpf_sk_storage_clone().
bpf_sk_storage_diag_put_all() has the same unprotected dereference
pattern, add a NULL check there as well.

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 drop the NULL check in diag_get(); The caller already checks smap for
NULL.

 net/core/bpf_sk_storage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf077..67901de5b9c65 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
-		if (!(smap->map.map_flags & BPF_F_CLONE))
+		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
 			continue;
 
 		/* Note that for lockless listeners adding new element
@@ -599,6 +599,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	saved_len = skb->len;
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		smap = rcu_dereference(SDATA(selem)->smap);
+		if (!smap)
+			continue;
 		diag_size += nla_value_size(smap->map.value_size);
 
 		if (nla_stgs && diag_get(SDATA(selem), skb))
-- 
2.43.0


