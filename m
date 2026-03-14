Return-Path: <netdev+bounces-267849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDMOD8DBtWkV4wAAu9opvQ
	(envelope-from <netdev+bounces-267849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:14:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E813D28EBC3
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D35D13029C0C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EE38550F;
	Sat, 14 Mar 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhUkIN79"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3938424D
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519285; cv=none; b=cU7u5yEvguDtAzIAbEK5yyBONvo7//IY66xYBmNTmDJehwkn3qru9nk/A+lbDa5iLhRtZ/wBe5pSZRoexK056uvIQiTjAY93fDxKu5XeIfptdz4UH21RyrB2I7/tpB42uC5hesU00HmVXS/jdiOF/0hTON8dXigA0xc1Vfgcado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519285; c=relaxed/simple;
	bh=x7JZBaiPMjila4i+dsi/muzHxZeS9PJ/SGrV4i00JNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct7yPvhrUjOZNBTPzMb8zCSHPsGegXRsT9mHSTWwiX4M3YcFdazSP7BxYkNaLVrVRqAoDhSi6solbMx7wQzrV842vrq9hvp5IEAcH3Mc1X+A4NoqeChWGpa8Rtfzr1kytXUT+mxkb3bif7xjEJx4IYsFQAtzB3cyS54N8DEKuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhUkIN79; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40ea611d1a4so1313962fac.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519282; x=1774124082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO8Gig+uUsNsJX3c3oLWHfAhxFR79WVWca0SWR3nLZY=;
        b=AhUkIN79mN8ojz/fybmKvpF0JjleCLGY4QbBKJgI6OUDuBXH4XR3lV3+WckMvA4KCc
         0OjOLBcBwM71dp/Mk32iasY+Z2jObUC4pSQP4hQqWgy0rpHeliVj8qTuEtNgwgrUcnoJ
         seV+FVl7Z93NKeu9ucjyvGwlbAFnJbY3D28Gs5S1QmeSbxksLmAUGkHjrA/P1xTN4edZ
         EOb+QWuFCp8WX0ZIJtxHpe70w9ne1eN+Xii8M33lXisL1CNd8vydDrg1MsnigRVFcecW
         bjcQFJWcU58wxnXkq+57nzQ57x/HlYiTb2HC26qEevaQptff6NMfXwj31ErwfQ8+QhUm
         kElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519282; x=1774124082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iO8Gig+uUsNsJX3c3oLWHfAhxFR79WVWca0SWR3nLZY=;
        b=NFaOht0xOIi6gdjjwdms7qPxHODiaohPmRYpSbUgyOhRNal2303ZvHE/sEBr1ZY2aV
         H+MoZtvvUfclZ2PUR0y6OhgyfUorJ6R+LKpxzg2BzPwmkwYpJ0tMBkTQopxVuirB7xsh
         +1dxzGYrkBAqJgq4OH1okrp1ZSjnLUMoZ8zBuyql1bc3QQjl2NSd9swyeaGmP2sc/mmA
         Nfxat+SQQwkVHjJTDm0/7pla/xufwtwR5BJEChZqig4qBr3xSIat6aNjQTsy2X9XhXvh
         mQvOJPezwX3XC96xiX9GiPD0c95dYDfXD5ViV1LX2adqSWEvWccV5zjkzpo5wA+LPzGh
         GjxQ==
X-Gm-Message-State: AOJu0YxX0Yd6drp51RoSHW1q1sjMS7waTP2p4HkpoEjXFH9WAJrixMWt
	1YFxd55hV7kvXlMWVnoKR+2vtw4884zCwVcF+Re16zUbMaijGGhlIH0RJu8wFSjjyto=
X-Gm-Gg: ATEYQzw4G2I6rGpB7qaRatbwhohNJ44O5CLaG16HVi973ZRkGa/6vgu9yCk9GXJjqWQ
	v2/kvGX2T4c9IT37rRrdYHcvA27PNvj3gyprjbxy40NpgSY5vxIu6jlO8rg0c1a+DvdX1rZE4dn
	Skba0qD+lOFiNVQiX3eg4u9rqH8J63AwP7Eo79qjgmezTJpKSfyYMdVr7B9C0PEoc6w6pd3yctI
	e4PIJcadMjd+kLkuivSztJ0qQzBTL2VJUNjve0CwYU3hKtmivyjTEJjj1Addf98vXUTH4PkSEsu
	e0GQmnK9WUnu8KaWxrWuo7SegWXB/Iz5vqO743Gsf2txLcKvsWPQTdXWsTT8iQIab52q+OAD40I
	wppR+u/WeeaskWPZgCkG2upHemGNV9U90vFqWcUsEQQu7/M8/ELsypboS3AUePnHihLKHcmz5W0
	IIfrCnIGrIiN418pGJD+TGMHNnwuXBtmgFXLYU8JEdmAfTqbNiImIIyLcI9ITvxfdrJfUoidx6l
	wLt/llGpD5HwsLgdsyid61cFJcIBkEywxt305bc
X-Received: by 2002:a05:6870:d8c:b0:404:33e1:3cc2 with SMTP id 586e51a60fabf-417b91b2c8fmr4474193fac.13.1773519282232;
        Sat, 14 Mar 2026 13:14:42 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:41 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 01/14] tcp: factor receive-memory accounting helpers
Date: Sat, 14 Mar 2026 14:13:35 -0600
Message-ID: <20260314201348.1786972-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267849-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: E813D28EBC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Factor the core receive-memory byte accounting into small helpers so
window selection, pressure checks, and prune decisions all start from
one set of quantities.

This is preparatory only. Later patches will use the same helpers when
tying sender-visible receive-window state back to hard memory admission.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h    | 32 +++++++++++++++++++++++++++-----
 net/ipv4/tcp_input.c |  2 +-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f87bdacb5a69..3a0060599afe 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1751,12 +1751,34 @@ static inline void tcp_scaling_ratio_init(struct sock *sk)
 	tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 }
 
+/* TCP receive-side accounting reuses sk_rcvbuf as both a hard memory limit
+ * and as the source material for the advertised receive window after
+ * scaling_ratio conversion. Keep the byte accounting explicit so admission,
+ * pruning, and rwnd selection all start from the same quantities.
+ */
+static inline int tcp_rmem_used(const struct sock *sk)
+{
+	return atomic_read(&sk->sk_rmem_alloc);
+}
+
+static inline int tcp_rmem_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) - tcp_rmem_used(sk);
+}
+
+/* Sender-visible rwnd headroom also reserves bytes already queued on backlog.
+ * Those bytes are not free to advertise again until __release_sock() drains
+ * backlog and clears sk_backlog.len.
+ */
+static inline int tcp_rwnd_avail(const struct sock *sk)
+{
+	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
+}
+
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
-	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				  READ_ONCE(sk->sk_backlog.len) -
-				  atomic_read(&sk->sk_rmem_alloc));
+	return tcp_win_from_space(sk, tcp_rwnd_avail(sk));
 }
 
 static inline int tcp_full_space(const struct sock *sk)
@@ -1799,7 +1821,7 @@ static inline bool tcp_rmem_pressure(const struct sock *sk)
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	threshold = rcvbuf - (rcvbuf >> 3);
 
-	return atomic_read(&sk->sk_rmem_alloc) > threshold;
+	return tcp_rmem_used(sk) > threshold;
 }
 
 static inline bool tcp_epollin_ready(const struct sock *sk, int target)
@@ -1949,7 +1971,7 @@ static inline void tcp_fast_path_check(struct sock *sk)
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
 	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    tcp_rmem_avail(sk) > 0 &&
 	    !tp->urg_data)
 		tcp_fast_path_on(tp);
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e6b2f4be7723..b8e65e31255e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5959,7 +5959,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	/* Do nothing if our queues are empty. */
-	if (!atomic_read(&sk->sk_rmem_alloc))
+	if (!tcp_rmem_used(sk))
 		return -1;
 
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
-- 
2.43.0


