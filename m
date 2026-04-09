Return-Path: <netdev+bounces-277034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DN7JHC+12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:57:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1C3CC478
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CF43037DFF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29639023C;
	Thu,  9 Apr 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p21tqZ6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197053AE195
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746594; cv=none; b=b0AUN1PSseMqUf+N0og2DjG0w41O/YoqHJ2hxzo7p66YqtbpPh+L73FqPE9JO5ZsqXZVQTt6W8Rusq4a+7kzl03sAkRgcxZT62WI6ATDdpB6oproPMaFALHJqNIOO4co/k8mfr3tPOWQuMSCZg1Bs6WRUi5TtBZW7itCr0ra704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746594; c=relaxed/simple;
	bh=ujH1riyoIcPPooRtQba3uvQESOS5SPW18iHlzlUeAOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLxbFxxJgmovIj/u5W+ade0Y+wBfb+NtnIuAGGWDbCr1E4xWV6mYtjSP/dwX4PCRpwJNICrogFPmy2+xJlnqMgevRVs1aF452/MYV1x++DT/CUQL3T2hVS9JUANejicXmzp4OXlaSKs6v1AQYK0E25iB9RV/XSfDQgkDmNBOACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p21tqZ6c; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d7d46ea93bso250349185a.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746592; x=1776351392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAXgmliszPX/+00FrsL/zOnN9dPmK7Zemj0uP5OF1Rk=;
        b=p21tqZ6cQq6xTljwhRShuSlPyQN9hSHdZyCGrmUq8+YhiPhFVpDzxDumAIl9Xdj3Ga
         m7BEDbbIVGd+nrWhCVP8ekSYVkXqB1QqfGClgB/yRfwr6g67bCvUTFmbWGcuKWNEU/7G
         hbKiKCzOb04RKTmGs20IClfFpB+HzgALX19tQ/fpyk/xtwoUD+ZKuc9hUIbnBZkRGfe1
         EUl5hdnLAywFw1L7pRysZCVJi3ktDf17S6uGn/lodn2Om3B13uu2oeTSW2o9x1sQWK42
         e1b7tN0DjJctl8oU6njnDvmqgI3aYCkmHdvKHMAuPlQYy0tlkzosJmpq+AKcnpebKzqn
         QqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746592; x=1776351392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAXgmliszPX/+00FrsL/zOnN9dPmK7Zemj0uP5OF1Rk=;
        b=mVNPlwmofEbTvf16y6KNQ6JtuUPdNTg71Vny5f0O8EtDD+ydePCHA98XUZEEa69dka
         pY7dBG4ZEnBO/QWbNSue62NURt50kugmJyyxn+0vZcQ0Tcqe/6mAMAQTgdw233WfCoFZ
         54UvHZ0fL4edUrz3gAxtnepZ+99hibpdXOSV6yLlA4hgMj0SYCtqSqb/KUmt3Dgdyt/k
         DuDoNhAjSogP6REjS7ixSYmpKurgdXjiqCJW38Wzt34TbHKhm7x+ytnunx971FW1aneg
         GV12AF9WQAJNc8fJ5csZzxq+GVtmU99PaePLR1zIYm6GjjQ/vV9uL/mkfXTE151ElYEg
         w+UA==
X-Forwarded-Encrypted: i=1; AJvYcCVhsX81GwE8W9HK1D92j6eYa3iNrDf5X+dyMgutnlFFyH3Bt1Uoa0ROBVpbWvqXzaBo1QuT3Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Y/QC7uZ0jVZD+2zujE0EmawLVY6WB4PgJvbFVR8cUiKeEoVV
	J+MrHHsRWSBTh7UHDsAEVeS3U/Tv+Oio9wGzgLfBzI8DYoOfXV7Lmr5u3YubqrVy2JGi34Q7jbO
	DGATtYrrPmR3pGw==
X-Received: from qkld10.prod.google.com ([2002:a05:620a:136a:b0:8cf:d0b8:9bfd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40c4:b0:8cd:9033:1724 with SMTP id af79cd13be357-8d41b9ddc3emr3558267885a.9.1775746591785;
 Thu, 09 Apr 2026 07:56:31 -0700 (PDT)
Date: Thu,  9 Apr 2026 14:56:22 +0000
In-Reply-To: <20260409145625.2306224-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409145625.2306224-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409145625.2306224-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] net: change sk_filter_reason() to return the
 reason by value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277034-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7E1C3CC478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk_filter_trim_cap will soon return the reason by value,
do the same for sk_filter_reason().

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-21 (-21)
Function                                     old     new   delta
sock_queue_rcv_skb_reason                    128     126      -2
tun_net_xmit                                1146    1127     -19
Total: Before=29722661, After=29722640, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/tun.c      | 8 +++++---
 include/linux/filter.h | 9 ++++++---
 net/core/sock.c        | 4 ++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c492fda6fc15a79c13f56cb15dc273331b854422..b183189f185354051bded95f43bd77ee4f7cde24 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1031,9 +1031,11 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
-	if (tfile->socket.sk->sk_filter &&
-	    sk_filter_reason(tfile->socket.sk, skb, &drop_reason))
-		goto drop;
+	if (tfile->socket.sk->sk_filter) {
+		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
+		if (drop_reason)
+			goto drop;
+	}
 
 	len = run_ebpf_filter(tun, skb, len);
 	if (len == 0) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44d7ae95ddbccd0ba72740b5547e91e1990686f2..59931e5810b4fcff5788616a3875767421dba3bc 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1102,10 +1102,13 @@ static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
 	return sk_filter_trim_cap(sk, skb, 1, &ignore_reason);
 }
 
-static inline int sk_filter_reason(struct sock *sk, struct sk_buff *skb,
-				   enum skb_drop_reason *reason)
+static inline enum skb_drop_reason
+sk_filter_reason(struct sock *sk, struct sk_buff *skb)
 {
-	return sk_filter_trim_cap(sk, skb, 1, reason);
+	enum skb_drop_reason drop_reason;
+
+	sk_filter_trim_cap(sk, skb, 1, &drop_reason);
+	return drop_reason;
 }
 
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
diff --git a/net/core/sock.c b/net/core/sock.c
index d39a4d6ccafd9e03f4e82482d3f3e46ce5d58771..1ffcb15d0fc5e39201aab24616d40a37aa41c823 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -526,8 +526,8 @@ sock_queue_rcv_skb_reason(struct sock *sk, struct sk_buff *skb)
 	enum skb_drop_reason drop_reason;
 	int err;
 
-	err = sk_filter_reason(sk, skb, &drop_reason);
-	if (err)
+	drop_reason = sk_filter_reason(sk, skb);
+	if (drop_reason)
 		return drop_reason;
 
 	err = __sock_queue_rcv_skb(sk, skb);
-- 
2.53.0.1213.gd9a14994de-goog


