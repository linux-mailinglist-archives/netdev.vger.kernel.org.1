Return-Path: <netdev+bounces-277033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHVfF2C+12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:57:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B317D3CC471
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B61302DA16
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D63BE174;
	Thu,  9 Apr 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1WoqY4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A236DA07
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746592; cv=none; b=IiXH6EJ9R3+7TV+N+t6udkSab+hXxs5BicPx75WSDNSMUySj2Kw2w/R9gJJnvIdziA/j2Z/740zfxiTnCKpSaQJVrnLj6FdAKkASJB7e8/UQeMsBHWfdh+UHOdmhe+Grf4P9tmRbEOfTleVN5KVJAeVElUvAXMIBRWHo1g6SvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746592; c=relaxed/simple;
	bh=vNKdj13g8RQ9o8xpxlwh+bjMtzC3t2pDi2f5ynudiOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gdO66ln8Jy4jnFuOiXgy0FBK9qBgL7KhQanduyXpsk79YSBTT1yvuSbVzcJojxsn7a4g0RrbaimX4cUn+4Kez3mYjFwX+ZW9dIjeLVeMOqUY8+18hhYqcutRmJEzEbzd20CJVl3vFzV1UEyPG4VlkJ+1rzl3R/LTMC8gqSUMSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1WoqY4x; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-65014989b1eso468915d50.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746590; x=1776351390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=irW4vLLINOLQFc+gHTz1I71J3ZqIc5ZNrgk18uw/kmM=;
        b=u1WoqY4x4TsHYI7LVm137KmMSWmeswXf9f2la+VUgbRary5dV6ma6o5us79er8KbEM
         VfCtBTKdoghIUov1HE7FXxuDcVBEg2a/ULjlyjGuD90U4a4Rcy8Ux8qJ32vGba5tfcYH
         jo+5rGUXEJg+lDMl5pOFs/HBrPFRTqBa3OUzSE22g4V3Jurpmtd6V6EffKZOsE5zTMoG
         s11s57GiZSrhL1JxnRnXYIxjfDyQMlos2xo0q1hPyM1I4kqvAisQ/wh96YlJzLAodK75
         2Uev5a8QZ9V/Z8R0AfHfeEkTcH6kMo9gdLrCKXLJKZFDHb4LWMZk7BM5WmykZD8t3KEp
         RilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746590; x=1776351390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irW4vLLINOLQFc+gHTz1I71J3ZqIc5ZNrgk18uw/kmM=;
        b=kHB/CkiXMa2jj4qorx2SzYcxwJ5/iQ9bQ+y+v7+xW8suI+WfNGLUqNyitYM/kMwQAy
         I7t6vjYr5e1zmxSMUSrGaKvVbBC4MZjcm7ysIRh9TNjjCkvWoEQiobjSbDv1Onf/KWtj
         ygOclwexrqe7Iq4VzNbPYWrK7NraxulehwFh8i5maLzwzJQotL6NiF0m8Bxg5ptCjeDR
         1OewPTZU3/VPwAihW7ZFzXJW7sXAKfz9V+uq3+/cJgt3YyQpv7rbzxZDdEGc2k8dOYaV
         KHZa7/G3q1eeMlbXz0ocV67hDN175zZQBbvMwRMuf1avZDuVw6R6ABIrUhNIAU7yTXUu
         Ujiw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2egqSnSYaFwx60NgoLrlAR7IH+PsDrbSsi9uuno6kACB8D2I2f/Rr9l0eyyL4r5bo7XRCss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyePA6tONRmFzdunkxUt0cxwdVXugyKoiZFez/Jt+7Jf+o58Uoa
	EHCTRObiTdg5iQW8PXooEcKMw3OX/jUyat5bEKcm1AZHzKzaeV2pos3lf4FjVrKOJVr4UtoXlTV
	ArOg1FBuQdMzrvg==
X-Received: from yxg15.prod.google.com ([2002:a05:690e:58f:b0:650:5368:7623])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:a4f:b0:650:3bbf:6a60 with SMTP id 956f58d0204a3-65187789683mr3164475d50.37.1775746589960;
 Thu, 09 Apr 2026 07:56:29 -0700 (PDT)
Date: Thu,  9 Apr 2026 14:56:21 +0000
In-Reply-To: <20260409145625.2306224-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409145625.2306224-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409145625.2306224-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] net: always set reason in sk_filter_trim_cap()
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
	TAGGED_FROM(0.00)[bounces-277033-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B317D3CC471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk_filter_trim_cap() will soon return the drop reason by value.

Make sure *reason is cleared when no error is returned,
to ease this conversion.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-7 (-7)
Function                                     old     new   delta
sk_filter_trim_cap                           889     882      -7
Total: Before=29722668, After=29722661, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cf2113af4bc9ae7c976d7c55f3092643e1d875b6..5569d83b8be06dc1fe64ddff2ae338acd1622ed7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(copy_bpf_fprog_from_user);
  *	@sk: sock associated with &sk_buff
  *	@skb: buffer to filter
  *	@cap: limit on how short the eBPF program may trim the packet
- *	@reason: record drop reason on errors (negative return value)
+ *	@reason: record drop reason
  *
  * Run the eBPF program and then cut skb->data to correct size returned by
  * the program. If pkt_len is 0 we toss packet. If skb->len is smaller
@@ -168,11 +168,10 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb,
 		pkt_len = bpf_prog_run_save_cb(filter->prog, skb);
 		skb->sk = save_sk;
 		err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;
-		if (err)
-			*reason = SKB_DROP_REASON_SOCKET_FILTER;
 	}
 	rcu_read_unlock();
 
+	*reason = err ? SKB_DROP_REASON_SOCKET_FILTER : 0;
 	return err;
 }
 EXPORT_SYMBOL(sk_filter_trim_cap);
-- 
2.53.0.1213.gd9a14994de-goog


