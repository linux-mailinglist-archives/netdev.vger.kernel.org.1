Return-Path: <netdev+bounces-275389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD1qOvgo0WkXGAcAu9opvQ
	(envelope-from <netdev+bounces-275389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B5539B7AF
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9C6301E21E
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D5287268;
	Sat,  4 Apr 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGK1kybz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0128F948
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315120; cv=none; b=VW0MFvwiMIMX1dnRv3E0yOPC1/dd/uZH2zJHTncMhCyobi7fhToaIZMIV4/NisxNtouRdIOUC9nnfWtCOfSR5bIJwwMpoCsToXu1bQRNRrU+HCB9mEVARd1PBtw1TSnN3vxorJC0/RPglcZQpa2MR9GawPMwgfcMbv7Kid/WUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315120; c=relaxed/simple;
	bh=FtKTq7Q2omV5L6dMEgKtQrlVoRSKqix2q+h2ljhis6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FyXM1EhhcYw9d8r3htwNHfByTbEUT5ERgQMt0Dd7hPkyjHjgCx3hoN+lNeTpcjFUc4WgGW8cs1CHEV7K3MUWo7hpX9itX3aUNRJcdHsdaqLdB2DVv5tOR8gGgNomlNK7kbOD68isrXjOc5aktoY5bhK46mFCiQhTF9msZhK9OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGK1kybz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so1169004b3a.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315118; x=1775919918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ien+mM5l9GTSiQaCM6QFkP9RFuVj/1ho/sT8zyGGYM4=;
        b=nGK1kybzBfoofYK7NIBmQCwbuL7Z+MdRJTo1kzrx6edJPCarhFjgQ+Y4KSfRvvoWLX
         r3CT0Xtfu57ac1ttOv6/iKk5z4f3b+VRrdZ4yZ7EjaaNrwrgA6Nvzsni4E11F/T9PSh3
         RkoYekk43g3psoyvZftGMGNg3U68waGo2DAT0evDXl5cOhoJ82XgsSi0bbnPNl1ytWBD
         40YJPDp+c8nwmg1PN74V8Ry+hxkUng9sAa7M8v9wkp6YRnOiw5klq9WmFlrdgAX1WXaa
         4EMvmC5GY1GZv0puYTVGaWHedVLzZFmzpi3U8FYpdOqg68Rb/265HAPTtozcrjHEJB0B
         LGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315118; x=1775919918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ien+mM5l9GTSiQaCM6QFkP9RFuVj/1ho/sT8zyGGYM4=;
        b=X+b2vTaei6iHaLC02dudOvARPD71KLuoIJerAdThkYTEvc2+1k7N/m6/j4DGv6LkDY
         2k8WIk20CD/JXBZOT1FSBXWlXXRkKzGIDQ7KCmehfZM/TsgbbQ3+D+elxjGzB7Hnu/sF
         kx7nJOTmwzvY32YAmq6N5sfuErahnEr+wtS7jrDneOtKjeHp0SaekR1vtIIEl9pM3Xua
         Jmf46CvroFfR7O7l+1q8IRGnW/SEd5uX9mxUr4kqCPMGPW+17aYviT9RLzVWQUpGXBR9
         rh9PoYK3HKJm75STMNjG3YUYI/xo9yUbi6rAnvmM3joIzCLyx15z6poeY96yPCMhjt5N
         OnzA==
X-Gm-Message-State: AOJu0Yy+W8qWu4jsJv+2C+y2lSxPq1CjWeHdWx/8HbYbtKXCg2a7m435
	Hd8Cremdkww3/muyBwJBhu5THxuSnH+OZw+yfZS9OCqUHxlJfOqPZD+A
X-Gm-Gg: AeBDietF1I8VvEtiE5bNkTAk+JFA53CbxCqDZgBedU0d5MC1tCIzNXhyZ8RuckCQFVQ
	T0i4Z7IHEgzkEB6KeQH7zsj0cHquk4l7NYTP7tY/q7o9XYYC9y6/wS1Yke11MRXz+q+5OBVBGsQ
	X+iZOlN/ftocCAqAL+mVkM3SSPvnrjDA7jYXAYoDNdz8T0UmNR5X7MzP0LEML+1c3qkvdHZdkdL
	z4ukGIc5n0U4wQTht0T0lUQNek1XWS5L66QaDWozD0CzXKus/dAw5avagKo+7ilD5o3uHjZA3Jl
	SuJuTjHO6VsgJDcSvurZ3J2SwLbHh9GrrwSPEgEIqeDS9Alh5Y2UcAb7X4hq+iAOqqKRRqZVdXF
	AB9khEGuErdUCTK2cxZH3he2bmkOZE2gIsBLIQ2IuHVVO0NfO8KOha2Yh/Vs5OvuDsDKXGu5pJQ
	bQUd7qz7wiU7DVkW0K1GVctfAf5bU1326/R1vyQBbbtajMyXwnqdDcjx0F7wk=
X-Received: by 2002:a05:6a20:431a:b0:39b:ae5c:164d with SMTP id adf61e73a8af0-39f2eda9e97mr7034068637.4.1775315118410;
        Sat, 04 Apr 2026 08:05:18 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:17 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	martin.lau@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/4] bpf-timestamp: complete tracing the skb from each push in sendmsg
Date: Sat,  4 Apr 2026 23:04:52 +0800
Message-Id: <20260404150452.83904-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275389-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56B5539B7AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

The patch is the 2/2 part of push-level granularity feature.

Prior to the patch, BPF timestamping cannot cover this case.
Here is how we reproduce in theory:
1) in the first round, __tcp_push_pending_frames() or tcp_push() kicks
   the stack to transfer the skb.
2) in the second round, problems like skb_copy_to_page_nocache() that
   returns with err code.
3) it jumps into 'do_error" label and then 'out' label.
4) at this point, there is no single skb staying in the write queue
5) the end of sendmsg

Monitor these two push functions with the previous one to complete
the conversion from send-level granularity to push-level granularity.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7d030a11d004..43fa8329a5ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1392,9 +1392,12 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 		if (forced_push(tp)) {
 			tcp_mark_push(tp, skb);
+			tcp_bpf_tx_timestamp(sk);
 			__tcp_push_pending_frames(sk, mss_now, TCP_NAGLE_PUSH);
-		} else if (skb == tcp_send_head(sk))
+		} else if (skb == tcp_send_head(sk)) {
+			tcp_bpf_tx_timestamp(sk);
 			tcp_push_one(sk, mss_now);
+		}
 		continue;
 
 wait_for_space:
-- 
2.41.3


