Return-Path: <netdev+bounces-287492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH1UIGNHBGrzGgIAu9opvQ
	(envelope-from <netdev+bounces-287492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E48BE530D5B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB258305430D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E193E5EF5;
	Wed, 13 May 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URqbReW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50433E5588
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664181; cv=none; b=CSM0mtH8v62RDpl6ksQPH/VKhdra2u7bm+/mQeIPOShz7bUFzPdlCSxadq5MfBYzlK65HzfXGtt3syuzagga1N8BGTSy2kzu90ISu3SpzLw6b92mfuiivg5D0J9I5shzuCvPMRKVE4QtQteQHYsjFIqVGd55x5uV25g6iJiLUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664181; c=relaxed/simple;
	bh=N/rB15ox1cgPlD7+hK+mFAOLfFqtnpiPMNHcmTa+DDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOWK9E11qEjv42wGXiB5PkzMtGyimZILbP1+I6T97v4+zzhmw4Q3LKue/1qnai5wpvSBBI09uefX5WFXw5U+oJmNh0mv6Hq/z8tlhY8uNsSL5uW0xQgLjVcX1Hbd32d6d3KvRVHewHKk2hXZzXYq9BxWrnpuXVzmHqV52BxJJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URqbReW+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b45cb89f7eso41798355ad.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778664179; x=1779268979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpyzv2VHIhgzTfaCglkBvOnwlisO3O8fbQYUx8aZ6LM=;
        b=URqbReW+SWffxEfZus0B2tRaQslrQ+e61f9uyvFzBcOc5gr6WenTkZqDIfFjmAqDZr
         Ybc3n16LLQc5k0PqXhaoh2uDd/7qQMe/M9YH03EJ+FW0bVoq1WCfD43rcrOE97m2hc9c
         9+u7fMmVxCi2KRWhlBCiM58/sAzTrWxsQ0w2KNBm8E+mcryO4nyWzGs7WpIBG8GXB3NF
         WPrbLp3mhrC2kmlHpMANTKEjzdOfhStZrYv8q+qGjvFk6Vxddb+5yDkyGm4MAZKyrZ1C
         rDw8YaDI8nBylfPEAGb992aXxF9isgQJrBzLaJ8umi8egScOhdo9X4gCjiIslHDDOvjq
         Z8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778664179; x=1779268979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpyzv2VHIhgzTfaCglkBvOnwlisO3O8fbQYUx8aZ6LM=;
        b=kJFdqZfE8z58LKJPW/2goAESy8Qym367OKTqb5n+65BQER31bZvPpfAs45+/gb9R2W
         g6cYc6a+oGidQOsi3jZxhfhJ3sJ3RiMfnhOmKGVxyMqcg5m/SRHAsuvx7wu4A854NENW
         eu2iLotZKsrcWa6ZKYzou/x3p3U3M/1HFPhxkrqPxyacvz4e1hEd2oCsFs0x6OaQbZ39
         0AsH3gjK7EGOwvSQUP19J3B3kYMLGNbTJrj7N6IFyh9yF7N1SPi4RpJoOaFILu9oyX/b
         VNfSmsdHX2rjYfnvC1cz9gvUpX9f9kWBUp4XVIIt429mqTff3HmbrGvySfc57LGRGGU8
         cUmw==
X-Gm-Message-State: AOJu0YyRsJ3MyN1F9nJd/NKnK5MwvnViImVJGCDdx91hFzWHKY6+l1i7
	ZNv0jUlp6Vugl8E5sH/GyrmbpTXIA0QlMY9NJfTzbdHsE9r3HutJtBRixkAzboyF
X-Gm-Gg: Acq92OE1Y35GpNPxE5DF89oVdQcuef0yWcoBFPo7bb/q5ykyR3pqvb6Ov5XCvnGWbWj
	fSaT7vI9Ydz0NXonoWUspll/ykVYJzQl1AkiuzKsLziryK5RFeerz4i0f3tpf6ELX0alrVEtF94
	e6As6L2qkM716BSQETQEO4YrCAfFyT11TlGMCzZd7TqJk+nvVvdta6IKnFF1hO+Kz6lZPX6QDSO
	zAytpLj/ArCom7UmJEd7oOU1g8gli0BgImDHHdrZuWkqpAiWDN5lOFxCPQOhpYwg+P9xyNEv1H0
	3nSu64xq5MThARekWyBjEjC2ppXZqNUs2ZxkP8Emr30KEHayjq2F86tkM2r0LTy86Kma0Lw2y52
	3fjbj9bfritdcZrQaZEx2KF9goVLvs7IIl2k+6UKu59F46uOST5LA5K958dOlQ3w3ubAvcVSvj9
	OBM3V6e3JwAK/aOKCkAfdUptZwldFsIMKMFlzNq32hNuz/hN2UflAVvO5t0kjEjg==
X-Received: by 2002:a17:902:db0d:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2bd276e200bmr30136155ad.35.1778664178592;
        Wed, 13 May 2026 02:22:58 -0700 (PDT)
Received: from r912.lan.4v1.in ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27002sm167791555ad.8.2026.05.13.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:22:58 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] llc: avoid sparse cast-truncates warning in counter clamps
Date: Wed, 13 May 2026 14:52:53 +0530
Message-ID: <20260513092253.3035961-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E48BE530D5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-287492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

llc_conn_ac_inc_npta_value() and llc_conn_ac_inc_tx_win_size()
clamp their counters to the maximum valid 7-bit value via
(u8) ~LLC_2_SEQ_NBR_MODULO. LLC_2_SEQ_NBR_MODULO is defined as
((u8) 128) in include/net/llc_pdu.h, but the (u8) cast does not
prevent integer promotion of the operand of ~: ~128 is computed
as int (0xffffff7f), and the surrounding (u8) cast truncates
back to 0x7f. The result is correct (127), but the implicit
truncation is flagged by sparse:

  net/llc/llc_c_ac.c:1008:38: warning: cast truncates bits from
      constant value (ffffff7f becomes 7f)
  (and three more at lines 1009, 1099, 1100)

Replace the (u8) ~LLC_2_SEQ_NBR_MODULO expression with
LLC_2_SEQ_NBR_MODULO - 1, which evaluates to 127 directly and
silences sparse.

The same ~LLC_2_SEQ_NBR_MODULO pattern also appears in
include/net/llc_pdu.h:148 as part of PDU_GET_NEXT_Vr, but there
the result is immediately &-masked, so the int promotion is
harmless and sparse does not flag it; it is left alone.

This patch is the minimum diff to silence the warning. The
counter-clamp idiom itself could be modernized to
min_t(u8, ..., LLC_2_SEQ_NBR_MODULO - 1), but that is a
separate cleanup left for another patch.

No functional change.

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
Built with CONFIG_LLC2=m; full kernel build clean, sparse no
longer warns on the touched lines.

 net/llc/llc_c_ac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
index 0779daa8aa8f..ab86c720b3ec 100644
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -1005,8 +1005,8 @@ static int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb)
 		llc->dec_step = 0;
 		llc->dec_cntr = llc->inc_cntr = 2;
 		++llc->npta;
-		if (llc->npta > (u8) ~LLC_2_SEQ_NBR_MODULO)
-			llc->npta = (u8) ~LLC_2_SEQ_NBR_MODULO;
+		if (llc->npta > LLC_2_SEQ_NBR_MODULO - 1)
+			llc->npta = LLC_2_SEQ_NBR_MODULO - 1;
 	} else
 		--llc->inc_cntr;
 	return 0;
@@ -1096,8 +1096,8 @@ int llc_conn_ac_inc_tx_win_size(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(sk);
 
 	llc->k += 1;
-	if (llc->k > (u8) ~LLC_2_SEQ_NBR_MODULO)
-		llc->k = (u8) ~LLC_2_SEQ_NBR_MODULO;
+	if (llc->k > LLC_2_SEQ_NBR_MODULO - 1)
+		llc->k = LLC_2_SEQ_NBR_MODULO - 1;
 	return 0;
 }
 

base-commit: 8ebd24a7822cbae25beeafba49b2159d6a68a5f2
-- 
2.54.0


