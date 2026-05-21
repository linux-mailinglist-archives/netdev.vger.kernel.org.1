Return-Path: <netdev+bounces-290471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGm8OWcXD2qVFQYAu9opvQ
	(envelope-from <netdev+bounces-290471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269E5A751F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 077F83068900
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD93DB636;
	Thu, 21 May 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmrfySTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401443DA5AA
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371617; cv=none; b=ioBVvNhCD8FavOSO47t99za9cCAdv5owKi0xWos/pZn3/KQUicsQJIQbluI++KW5MMRscv98YyzIc8HI9Sms1Z46tq7X5CrTT7FhBZPznL06JkRjFpHu7u6yzksoH9yYhbtqSHFMJgIqsQqfRQfaJ3uBEqggh8/J/QUQMbfz7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371617; c=relaxed/simple;
	bh=tZtPPNL9Vrc2JmWRN3ooRrA5uBIMk5/gsLjd/4M/DXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GICW5choSyMUyzpxf8rGv8sz1Flt/J7GLUdUMxqhmehHJRJ3xvSnlXRxpH1+aON60uNmXJnoGplRZrv0T2M8pQqemKx5iYwCbq5qU62apVxEzc6DcVw++ULwVC11jFzWxBiolhvr2mGncWbd+mrU8kgbZNfHBI0zndLF4sO1+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmrfySTi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba6485d219so45469665ad.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371615; x=1779976415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=KmrfySTisbuQ+HOe0CeQh2yTv7RJoDOgcKsLgsauXV3FCdy4zVY/3O1PrPyOKW/iNo
         lrZ0flaw+QMvK4jwgJTt+ICFa1tTS3w+ky9KjE7OmqSEj5jwQ8YWkZb+Qa3fOcu2bupq
         UNpvYZW9zjMpk/vh65/kZwgHtJDRe6KZhURCcCwkfAQqEQNn50vpFfj4oTNcTlIKi2yq
         +41rjjrcuscVzle+hSvhMBxqM8m18x42dGQbjII6zx3pBqNx7cCEkYVZPhdBNtbhWzcG
         WlvVT3Skb0TCicf7CIsGDVJb6ycYPExNdA6J9XmFpvd6cXPLrikY/7dCZSJVzDwbAOLr
         /VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371615; x=1779976415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=lmEos10B7/RMfs22u+nwIs90W2V14f5l8OXAGMcQc85HSzHG9p0mdhFr5Dahm4mX3j
         nki5zJRNo5PW9nXXli8FWPTzLii+XeilVKvcapl3JqQL52I2Kj8mU9iHLsOV4ma5S3uk
         iGoC9VCE7h7GzyNfAdEEbwtv6fRnEmcHOnqqgSU6cWznmM/jzNWPC9Wcv+A6o9kPz6AA
         53XAuvxHsmPeLxL7bYayHy8eudWZiyx3rfh1Qoo277oqmnQUk/7sgsXM/v/COU/YO9fX
         GNofIBgrG4gbiJ+ddokMIDk4h4KG8NgrnkDUskv4IG/XGv5XLZSuwBQ128dUT8C9dreB
         Y0bQ==
X-Gm-Message-State: AOJu0YzKndDP/cmLJEdyXcvYM1JAUjFgbOfz6g5Ec4l2bIaOw4e2YdrJ
	NnMCLXpjDce8jZYPfUq53hXkEPD6Bbtx7jmQcErmluWNYT0rYdWWnLdC
X-Gm-Gg: Acq92OGuhG2jx/XjspeeaZAFToHKXXa9AjN1itAlcM8I8DKRVlkbWkX8WofoZnKS2lD
	5a15ddu9qKcmNNDJTnG+LXG4IjGA+08t+0Br3Lo3xBfnI/mI+j0sLoYG8/f49M13THMwpbhdYMv
	V5BJX/cS7qxE0YghAHigHEi5sgV5JQZLYw5o1FfRKflhBYfAf9lGeQOxi6YqaSlyge3Fd7nUse/
	nBBxVttvRk9SDOzB4Sc+fOqBbhSOgpuUALL6CWXNZQRlN1aZ3Pz+9Lc4fCEwiO/OHAbe+0s/7vn
	iJCC64x/6nhT0yx+uBEoLNiUM1NOfu+SI3W4MF8js5Qb1TygTPFRJBUEw3hRFPOgvmxUIsPk1R/
	PqPPcIkjelIJB5v11I0ThP8mJ+Ndu/00SJPt10+RfASk+mS4UWhRqB7KXr2lm/4XK5N/oRXnwqP
	HcAyxT/165XlWgUKupxoDFM/dqrkmgKvZXE99fzOWNfsHbwh68Tf5K6FBHNttlhjzqj8rGsxLv0
	I33cm1nPghANAV2MZr4ePF7McYQmPGzqgXcE7RPNw==
X-Received: by 2002:a17:903:2449:b0:2bd:606d:b339 with SMTP id d9443c01a7336-2bea3078c25mr31964385ad.21.1779371615508;
        Thu, 21 May 2026 06:53:35 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/6] bpf: support bpf_setsockopt for bpf timestamping rx feature
Date: Thu, 21 May 2026 21:52:41 +0800
Message-Id: <20260521135244.40869-4-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290471-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9269E5A751F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


