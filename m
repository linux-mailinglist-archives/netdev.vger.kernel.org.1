Return-Path: <netdev+bounces-275387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDzRMdMo0WkXGAcAu9opvQ
	(envelope-from <netdev+bounces-275387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A339B799
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F9953016EDF
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AEB2749ED;
	Sat,  4 Apr 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/qQi5H2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4F26E173
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315113; cv=none; b=OEEhJEUdVRz4afkdqdzt5v/zNnMHI9Ne/QYPq1hx/ba91i58rUcdQOoUD/mjsmWsrk7kwCyKO4QujFAMzXNhSJRc+8t5SynRD+B8vB82cqJ71scNLKxT/9X0YiXD2mTA6+11r0Fh2K9WiJyfesk7iP1y9mHQGoqwMSH3+V29XqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315113; c=relaxed/simple;
	bh=bYrHVBQsBbtA88DUctBOYp6xxbPGu6oj8k5S2ee+Ehw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFPCKd4plpDEIAXhzxzNJRIK+PihiJApsrFvNvkTP+uEezSk9MmGitbVmWH8SLQ7Uv030BFyK/gilS1O3qXEV9iap4byzlSKKOEu+Wy42YjusydU64IRo3tL1QFN+fsM9MnhkOIqLJOjU54TAEvXqhChdfCDeS/PoBnBvtZIhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/qQi5H2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab46931cf1so25047535ad.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315110; x=1775919910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd4IriQRr3URJKHO1DlzNK82MX6elt7bV+ds6H1WDVg=;
        b=D/qQi5H2jkKmyzccq3UKkAGW7QWosZOrDu6RBeHIha/277ZlV1wUl5ptn2ilzKKtI7
         R7HaTMRuEy23Ng5vLV3dmxm+jInl5khy5QI5VbK+8WH5TnITPxiJgmbmgUj9oXjdUozq
         QP46f8u/8LXFhmbNwlSqrmscB543u+nWUsAcn7nw94huZSkucWZPpvgM1RaTdKT9PYOk
         R+vBp1vm7OZfiYlU4wv5SI8joQsfWyXl/sT5RTsVdk/QsrcqKQN0SYEamDiI2EObv3jQ
         I0EcA1Zg31Aq2SEZERpmQZu0pINBBcn/BX548Yy+Z3xKBX0UPQZxLvrwOrqNtZ35DZXB
         +shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315110; x=1775919910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dd4IriQRr3URJKHO1DlzNK82MX6elt7bV+ds6H1WDVg=;
        b=MgRDlxVm8IfMo8U4e6ZGuRzjTa4s9LJ9kw13hzAWrtE3JX7Ls+hfkUgCBpEqvOu8sj
         lBjj0X/CHwbOfGwFOBq/nUOxpJURQNZqzUh/fHD4U7eaBY1I6PlevGnIU1T8a2bdLCYJ
         7AwvzbEFEuYLfJqDvL44YcVgtSuIFxrvWocQqy3mMOh7+APaCBIGjqLDvOHMJzpjzDfS
         uNuem3/G6w0vaXawFuYuem29q3rT+Hpt5wH1EHTVLK8Hkz3I8nHo+y6JpxkYpqYRbEdu
         Q+eIDYXuNCfSS5sklgThmSBL/thmSwvzG8SxSBDDZ5aUKPcmnkgzO1r/zKch20+F4sHd
         b7eg==
X-Gm-Message-State: AOJu0YxVKbpphotfcs/WMlmur6AGKJkI6uRO/wocKv+5zhnUgPdInfEg
	wFeJvylPndaqYnFbrQdQadTwZE3Jf+f0z7clIoit+LCXyvgGBwqGF0cE
X-Gm-Gg: AeBDievYddnHibLBWowMrpY1s9g45a1eb5k5Vs2S6KG8YaUILC+7ezpOZjThRjr6AEO
	g8QwT2wcYue6Nx3z7xq/cXKV8u1jj+xPMMB4pXksguVnROrmCcgOVLEODcso7hw5B3DfVbVonIa
	7MevalG3o7s6kzJfufCwm2RaLFqlgyqr4DTQFMY+H1+xdpe6q1vd3JuOIEuEH9k/fjutWMSnnzb
	Gl6zIVNveHQYJ3I5RCt2IVPZ+dRf3SWDOCi7XQPFGowzgguqhylCUtqx4ndlFdvrDfAlLVTuMup
	d488epHu/NEbT1bs8YlD6HFQTrf0Ei5vxnJ80d9ZHmfBLsn4beVJmrKkrD2OWH01X0LuUnl1vhg
	FV4PGkVBgjdF/kBwepVLC3yFDJFSVb1J+5l8DVpLD0GV5J2z43ytXR3ciDl/B6frUWVPzhlGjTs
	RYeYf7ppCRXcjf2WrWJNNpspWYM0wmet8nYRIk2ynl/lDcCvyS7EKgjp7OZztjIFQ22f1h+w==
X-Received: by 2002:a05:6a20:a122:b0:398:7daf:6d7e with SMTP id adf61e73a8af0-39f2d9e755dmr5860907637.17.1775315110112;
        Sat, 04 Apr 2026 08:05:10 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:09 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH net-next v2 2/4] tcp: advance the tsflags check to save cycles
Date: Sat,  4 Apr 2026 23:04:50 +0800
Message-Id: <20260404150452.83904-3-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-275387-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B8A339B799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Check the tsflags first to see if the socket timestamping is enabled.
If so, then try to fetch the last skb from either write queue or
retransmission queue.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 169c3fff4f6d..c603b90057f6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -484,13 +484,14 @@ void tcp_init_sock(struct sock *sk)
 
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
-	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
+	struct sk_buff *skb;
 
-	if (unlikely(!skb))
-		skb = skb_rb_last(&sk->tcp_rtx_queue);
+	if (!tsflags)
+		return;
 
-	if (tsflags && skb) {
+	skb = tcp_write_queue_tail(sk) ? : skb_rb_last(&sk->tcp_rtx_queue);
+	if (skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
-- 
2.41.3


