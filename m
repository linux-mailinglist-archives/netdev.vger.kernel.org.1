Return-Path: <netdev+bounces-290470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DeiDQUXD2oDFgYAu9opvQ
	(envelope-from <netdev+bounces-290470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7305A74A0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6981930D3789
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AD3E559C;
	Thu, 21 May 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq5wjpIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC23E5A0B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371612; cv=none; b=FoIzfuTtzh/lv33xEgL+kZQr6RWTKIjcYL+8MOcUIyZ2ihmfB17mafwWlVlWVGlqv9Kd3f2aP1gi4D6SqjH10IBA1JSku1b96blwEHQUVkkDrHZBxZuiJS3XLBIaaApfABQ1c6yJZO3rca2hNMqP8lLFhA0LWLwVtqvM6waNR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371612; c=relaxed/simple;
	bh=7dRN2lVYiQcHQj85FKXslQHT95uAqRClKyLM9OSsglg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljDKu0t0+gcvqH3uKOmwHlusFXch4sjCUW0dmxXe0cbpfL4r8BDZaL6x5bEIjgP/DJSIFFouMVseafXFp2MNOVjA39+nvrfebETqJwvPrsWtqgBpU/EudVWwcdCXPcYwHZ0MmkrlEQ5ag0/8eH2iufH2JfPjXOvRBJV4bRpRF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq5wjpIn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba21d32776so44168605ad.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371609; x=1779976409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=Mq5wjpInx02XZj4i+RW0C7p5t+kYP1DX461Qqgjzo8QEYTDAJdxXCft8djRxudXGIv
         EX3yTHRdHOp7WniHFQjYcoimWtk+IcOQQUuhVdyZ798rxVuz48mnw+UJOQXXH2CAhUkA
         7KECSc3PKXWpfXVqifjB/LI4EoG4FVr7sSyqFS6yajbpwzWVMoOfA/8fFk104RxOQkAR
         GGmqJ9J0YCNfsO2CcIulbbNrFDMlabvpofb8j3FqSzQGKvAd3BrGJzpfZ6Y+SfEnAhaD
         0+90GO+1Ot7DHJgQn7wMcMTgdaKwRc3VL/if56fhgphPu1e2B+q+NG9/OVZ27Gsgm1Lu
         6RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371609; x=1779976409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=RNUm/zK6hQVFgw/NRJ7MAfR/yNqzBsrdq3Eho2B6u3Bt9rlsZIDpuu21YXyTeUP/9p
         6E2ixPWC3tUndqdZaqK3fKFKswXgeIntRDVpuR+T2q2a0EYbDI/qb3DXL1UeY6c0YGyI
         HwYm7ooTWgez8Ph72pXfPIpVX9ZPJXxT01o6eLQY7U+YAuHvmP7ydlRo0aTqN0/bTb6Y
         +T2X9xvsNV1a8/7YLDq2Kk5MxAY8yX5WAUxnPAYIbhfb3NiEQwVSGt3hvBsAQeR28gGR
         oCKfzZYQRZtYU4Pvsn1GNWek9naSpUefGg8f3tCkftx9kFmRiuFPzhFVbZEw1aJQHwU9
         ++Hw==
X-Gm-Message-State: AOJu0YyGAnUsSSnEI6+2UO/YMOQgxqT+9h12oFhkA3KgjlKUhYuCvQom
	ia1+I16Fyr9rl0KLqzSPy/fB3IWVqCQ0MQU7xw52uRotqD5YQvt+NDIG
X-Gm-Gg: Acq92OFzCcVDDLtprY7hW/0D+cJ/XLr7KywA8NHDAqkN6O12tjCtHd/cS4ww91ODSJj
	2Gstu2PddeOG36MwI/kDsnXmNC/pA1wN2GBlCvivB8hFx3N62jg6csbXB41QkhKfR4SQu4DfHag
	w9GqIonRHP+wboCVilDITW6c/tHhaqxge2EOLyU8KKKmTWFcSt5l213QTbD2YknyupJLvlbCsCZ
	ITccRRzIk3YxMnWkqn+bYmZhBplDoT7nsE6quqLMvt07hPQnfdns4zWpRKKczBfTy1GZLL/BQOX
	12ObcSPA/vj9nTvOd7L0WAcbp5d83mibVOYNjx8Tez7FCCR6Zv78nL2EPnlwKb695VFTjMt4Chb
	WuD9rr57s+LHd2UEoBNNc0hVuIWvZCJ/f9A+tFS8sAojlFKaY/i30mAO/pXvvRSU9mwsOBfF/pd
	XiTOssrr3qDlZ8ZPUdfgd5qR6ujGAcmBVcKeVzWHOw2c+DUpmqW/ht4SLQ3DlnOxpPjEpriBudK
	hobuVbs3hRiA9Cm5I2ZKzR4ZP+9LGwcjBLNlm5iqQ==
X-Received: by 2002:a17:903:2f8e:b0:2bd:7191:5708 with SMTP id d9443c01a7336-2bea30889bbmr29386365ad.29.1779371609075;
        Thu, 21 May 2026 06:53:29 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:28 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/6] net: export sock_disable_timestamp() declaration
Date: Thu, 21 May 2026 21:52:40 +0800
Message-Id: <20260521135244.40869-3-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290470-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 5C7305A74A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

In the series, sock_disable_timestamp() will be shortly used by bpf
timestamping rx feature to dynamically turn off the global time record
function. So remove the static label.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e0263bae8da9..a579d5b09207 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3047,6 +3047,7 @@ static inline bool sk_listener_or_tw(const struct sock *sk)
 }
 
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
+void sock_disable_timestamp(struct sock *sk, unsigned long flags);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index f362e3ce1efb..f3d78da3aeba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *sk)
 	}
 }
 
-static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
+void sock_disable_timestamp(struct sock *sk, unsigned long flags)
 {
 	if (sk->sk_flags & flags) {
 		sk->sk_flags &= ~flags;
-- 
2.43.7


