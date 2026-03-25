Return-Path: <netdev+bounces-271726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEuqMeZBxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7832BAF7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C31A030699B3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E736B045;
	Wed, 25 Mar 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AhPErz/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EE369210
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469517; cv=none; b=a3f0daAdmqFasukzh8QuNKeS1kncH+EKSWDjFHKD1PpvSE8w/DQCiGroxKv7g+7LDQsieCpiRim5z0G+648frmp42uPTzFaOw+qYVb9GVAqUO/qkzY8BKGrQG/0/it0aq1H/Triw7GwKFnQL9Gp2Ej1qsat9dK5XIGSuwC2OH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469517; c=relaxed/simple;
	bh=obmtBdcSErYACs2keWx638lE8dHmynlQPWIspKdIllY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXT902bJVq6PNBVkWlq1SUVjmHd6WExrLzaopOx6RCUdbih/BabNG1bfO9Sg+KZl8u6SkRPyqVgTiczO+W951Aol+N2M1EzoweHjevTXHGMvqlVWY8KLEITFbRQHCbdSj5QODlXaiC66RzL0uMVwIvBUR+Xm2RN+5dOSI1rNM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AhPErz/v; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67bb3fe55a5so124106eaf.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469515; x=1775074315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHj50gQQ7PYxlZfANZ5z4tfrKRrWvnoZOUlG8MRPfY8=;
        b=AhPErz/vR8OLgPHXJe8F0etJtixaBNyoBEc8U7W2MTVofAvFfCdZHhvUkRlZ3p2hfL
         Yvj/bDYyw+FITmC9OLAMuO+f3SK3PFIp5d6sMmIYzM4/gnTlOrYEOtA4NcHfAHHd+GnI
         lrvWegHvZFxaZdBvPO97IdZX7zx18slANrULlunW0qc1mEf95U/+EPOPAoSmi2sFukBr
         K2aqCAOxKGQ6crlwPDDgp8sB7pfjy/cI0r9dlTQY/3MAWhVBnTA91euAQuuOznT4Lmys
         Iw9GXoZhsuwRRZ+11+zim6tJPi1Boj871OPZ+O9TqTy3iSj4P3YoKHm7EbW33pYV/V2x
         TYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469515; x=1775074315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YHj50gQQ7PYxlZfANZ5z4tfrKRrWvnoZOUlG8MRPfY8=;
        b=s9yPPU9RvekEc12wm97dOeYnyVzSpiYmIPzxPj5y7sjMKzBASU7xv/frzT8uvrditK
         CzlVOw4KlL24Bw2AKKvzCAxoiA62dUrUqNM1qfncyqx/3sFj9/LdlvTLk/Ab1xVSlYFF
         CHR8GSWXbt+o8Z8r/Ng/4jJGuHixlgUimVTGQCuPbNTIMozNshP4n39VTZtRo+4Da0wy
         3X8+ikzuOhPysMCr7LBlWrA6YO7WzWF5FxhP/b1Wnyb9qkve8B2oRf+gOF0sVj0uPvGQ
         BFAm7EpnJ+VPPEVJgf9EyW9m8kBxNerCDPzXTuVVQzL2fct1MvGB8Ykssys4ZdJ/Apcd
         u6GQ==
X-Gm-Message-State: AOJu0YxauNWYOwYEDwn6t9xUJLGcIvdjZeYd346wzRyv0iLhRfQ0cfsB
	N/5mkz2YymIGa0c9slUFMMcLRRDiovSSsTmwAOqHctv/Ydz8hvdeLY6F53N7RN5OrQQeLqKjaNf
	vsUBiNSv5Fw==
X-Gm-Gg: ATEYQzyXeB4UDyYrV8I26iA5wGiwTr3NA8dQGQ0SlJ1IfTWpwKirpxPmNw4hzRIM6yn
	wa90LQqIKrb1kL3C9xANDO5uLSoX1VizStpQa2BvwoBzp3OGNdcxJ5PWEmQy7NLJ1pV7/f++072
	IMI2GD+L0tH0B4iGmliO2w6IcbURdgq/HuG9jSKnZMCKmeywbzunpsuI+BT8pAcrvpUwR4g0HkH
	SL4Egs64cy4QnpCrmk0CNw96eE29LfiJxxAxz95ZpcPUXAdXAA0j+A59Cgyto7NoAXv36ttINLz
	iKjvo5hAwzHLJSKxcWs9RhMaz0zZ57y8DS8F2GvS6Uf+RTBiCfjIChoXEpHuNZufvpQrqQwPudr
	uyO+/UUYa+A3lLJS6MUXuOqBK78VfYMP1e9lrJIKHti6B2MdEdMHCwEGFhf3AUb53zIHleo2n1m
	2/d0jDjVaS++XkVnHcYMgFJScSf0LZsg10WA==
X-Received: by 2002:a05:6820:82b:b0:67d:f55b:a992 with SMTP id 006d021491bc7-67dff59d93amr2981589eaf.46.1774469514723;
        Wed, 25 Mar 2026 13:11:54 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:54 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 3/6] bnxt_en: Move bnxt_rss_ext_op into header
Date: Wed, 25 Mar 2026 15:09:49 -0500
Message-ID: <20260325201139.2501937-4-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271726-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: 4AB7832BAF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This allows bnxt_rss_ext_op to be used by other functions. In addition this
modifies the rxcmp argument to be const since the function only reads from
this structure.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v5: no changes
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 -----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d15548dfd4a3..8ec611bc01ee 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2077,23 +2077,6 @@ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
 	return NULL;
 }
 
-static enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
-					   struct rx_cmp *rxcmp)
-{
-	u8 ext_op;
-
-	ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
-	switch (ext_op) {
-	case EXT_OP_INNER_4:
-	case EXT_OP_OUTER_4:
-	case EXT_OP_INNFL_3:
-	case EXT_OP_OUTFL_3:
-		return PKT_HASH_TYPE_L4;
-	default:
-		return PKT_HASH_TYPE_L3;
-	}
-}
-
 /* returns the following:
  * 1       - 1 packet successfully received
  * 0       - successful TPA_START, packet not completed yet
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 99f45686ed09..30efcfbb4791 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2902,6 +2902,23 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
 #endif
 }
 
+static inline enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
+						  const struct rx_cmp *rxcmp)
+{
+	u8 ext_op;
+
+	ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
+	switch (ext_op) {
+	case EXT_OP_INNER_4:
+	case EXT_OP_OUTER_4:
+	case EXT_OP_INNFL_3:
+	case EXT_OP_OUTFL_3:
+		return PKT_HASH_TYPE_L4;
+	default:
+		return PKT_HASH_TYPE_L3;
+	}
+}
+
 extern const u16 bnxt_bstore_to_trace[];
 extern const u16 bnxt_lhint_arr[];
 
-- 
2.43.0


