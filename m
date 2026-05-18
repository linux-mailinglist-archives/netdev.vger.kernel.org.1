Return-Path: <netdev+bounces-288930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NELC4bOCmru8QQAu9opvQ
	(envelope-from <netdev+bounces-288930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A4568D60
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4175F3014FE8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BA3E8662;
	Mon, 18 May 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb484C78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AB2264C7
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092668; cv=none; b=DOoMC6Mj8w3TCgBM/5WUC7l3YXdjkDR127XQldm5+ZT7ffP8MsW4lWAvstqLgnm9IykfwYBSssyGC5OtukIOisGC1VhLxmtEXK08tfjOnZaWRUL5UYo5npAH7Bn5YwCuFlLeWQQWu7lDHUq6ts0YEpAiwzRPfIhYE95et2fruxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092668; c=relaxed/simple;
	bh=tZtPPNL9Vrc2JmWRN3ooRrA5uBIMk5/gsLjd/4M/DXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YL8/O6eVasOvk5y5yTXsVlp72zP48UnKU7xdylNUnd21u+UZ0vyuyecnnU9abARW1MS1y2tn1hZN4WNGNJ57YszqhASsI1euSc1Iun+aH5y64tzsWfzoMw9InywaMoB66NA5JBWxz65cGAe1IawSNIshXAdw/fW93w/4RjpWErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb484C78; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-365d8e43759so1283466a91.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092666; x=1779697466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=pb484C78zr5kBRcZeZh9Mfo9D9lMKJjkm50qdlF34FJ4qUb1gsknrXgp4xajY9bCVZ
         NV3aGoNB30aoYsnOn1wD3zAHFCRD6hiX6GI2BAwJik+tepBKeWLRtawjLYBlRjNqyeRk
         +49nRbGCoMu5DDZSXAELvFIngeHz304wJl6pWoQVh5tnFVbHGvObDnUQa3QyW5RlRY87
         LI1bE+rQbl9ByDonkUD8jMrrxYi2RC/0DTtOkXTLksdB1dTUP1ln+XaMnAZs06vA49O4
         0aBPKMrk5xxQKPXIiiA3qKGM0deXnr0jBlyBU+QQx8gM+V9/tlb8BvOWbgRjTIPe+Rou
         UWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092666; x=1779697466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=M3XtAY3DdcgDzLIZJHn0bnX0V0ThS1+3IhRuWpSoO1Aqq3bQJ4Bn+YpVchVjNpM7lY
         IK3dXZFUye2N3lxFpXJZOFZrxcHr0ERlWxVl5bUU1eZ+nrpFCK54XbyLboEzxbjFQ1x5
         5VudlntvQAFMSIAsKuLd+T/2J6CpRE/NlLVNagy3vH7axqtj5P58HhGMDTDwW5NHngQ2
         s8IH++lkpEjXY2Mc0u0i3WSTvGg81aT1Gr+2ax908LHPZn75KugGzkqlAgxKeLUwVWqr
         gdsz8i+RGzjaUovYYs5m5oPaa6JbH+3j8BtbE/nSdLEtswBTHvXBWV+KJc3six0RqKP9
         U5Hg==
X-Gm-Message-State: AOJu0Yz9ZgxmuPrOIkM18H7AnhGAcr3vV3wCXOnkAi8ZJ3GZBZV289Yy
	WigvW+Bxr4EiCfQ+1BtTemHm9n4CvV3KdJOmVuEXpJ7z40UmcCCwc6UT
X-Gm-Gg: Acq92OGINaB8hlMpEwgYwb5ILaTaGStUu8fXoRib3ywOckRnBVghhW6yl25E1Gqfb8D
	8p8TeZh3bitVMk/owCP2Wirb8ZUIhxNOR+vPRaW4YH2NniMWxf5xnakssZxVvVGLXhYC7qMRGxB
	uU2IU8r/yZkhYitJoWD/kqMSMTjJhigD5t6xAB9BSGXRRhZ+7Re25WFjJ3uGxk8BEwAk/wjTPTB
	ulbVyjQ1DtTfU2H5HXrPTLlDapYbLkwMY/n74k5nYFNj3qgZ6cohXZ6jk9aUxxrazdEfK+laG0Y
	MY7iW+xBLbJF2s1IzGfOvhE/jSMphgcdwqt2jIlQtlJ4LzvhhgY3cQwnWnmGBffT99VkyI+Alno
	AIwHaGjdZA5Q2k4oetDrhDPGpm9Qm7mJ0i5/3eSuIBUssZPJVjsOqBApx3tKtxGui+BD/nvIBd9
	ekDfnNcU6Ir16UGjmJhMyn9M7B8oe2ZjONUbvgfj9lqoxLb/J45xaQ8E3tSRQDANOfNSk0AwL9I
	1hYfVI0yrxAkiGq3wb3qV9XsA7yfQ==
X-Received: by 2002:a17:90b:4c03:b0:35f:c493:cac5 with SMTP id 98e67ed59e1d1-36923639232mr17170261a91.16.1779092666081;
        Mon, 18 May 2026 01:24:26 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:25 -0700 (PDT)
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
Subject: [PATCH net-next 3/6] bpf: support bpf_setsockopt for bpf timestamping rx feature
Date: Mon, 18 May 2026 16:23:41 +0800
Message-Id: <20260518082344.96647-4-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: D80A4568D60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288930-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

Add SK_BPF_CB_RX_TIMESTAMPING callback flag to enable RX timestamping
via bpf_setsockopt(SK_BPF_CB_FLAGS).

Add SOCK_BPF_TIMESTAMPING_RX into enum sock_flags that is used as
centralized management of net_enable/disable_timestamp. Note that only
one of them (timestamp, so_timestamping and bpf timestamping rx) can
enable and disable the global time record of skbs.

In addition, include SOCK_BPF_TIMESTAMPING_RX in SK_FLAGS_TIMESTAMP so
that __sk_destruct() calling sock_disable_timestamp() to thoroughly turn
off the global time record.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h       | 5 ++++-
 include/uapi/linux/bpf.h | 5 +++--
 net/core/filter.c        | 8 ++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a579d5b09207..cf0e82e46482 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1022,9 +1022,12 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_BPF_TIMESTAMPING_RX, /* BPF RX timestamping enabled */
 };
 
-#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
+#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | \
+			    (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			    (1UL << SOCK_BPF_TIMESTAMPING_RX))
 /*
  * The highest bit of sk_tsflags is reserved for kernel-internal
  * SOCKCM_FLAG_TS_OPT_ID. There is a check in core/sock.c to control that
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..1e09b5cd7a39 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7029,8 +7029,9 @@ enum {
 
 enum {
 	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
-	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
-					   SK_BPF_CB_TX_TIMESTAMPING
+	SK_BPF_CB_RX_TIMESTAMPING	= 1<<1,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_RX_TIMESTAMPING - 1) |
+					   SK_BPF_CB_RX_TIMESTAMPING
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..08ad102f204e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5304,6 +5304,14 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
 		return -EINVAL;
 
+	if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_RX_TIMESTAMPING) {
+		if (sk_bpf_cb_flags & SK_BPF_CB_RX_TIMESTAMPING)
+			sock_enable_timestamp(sk, SOCK_BPF_TIMESTAMPING_RX);
+		else
+			sock_disable_timestamp(sk,
+					       (1UL << SOCK_BPF_TIMESTAMPING_RX));
+	}
+
 	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
 
 	return 0;
-- 
2.43.7


