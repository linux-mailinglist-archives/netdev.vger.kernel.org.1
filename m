Return-Path: <netdev+bounces-267623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN4pHF2QtGl0qAAAu9opvQ
	(envelope-from <netdev+bounces-267623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:31:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA728A6A2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE8833030DD7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66C386541;
	Fri, 13 Mar 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IZmqc4iO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4AE38643E
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441059; cv=none; b=LAkXoPQwM8dZHlGg7VF57/2qIuujjT9Dg1UrIgMtUadl/7yVBUKYPMZqE97z9JLmSLMh4p/zn398Tk0EHJDzJTbpwgngm0ivJ/SdGdVun/NpU0SO67aqpa6yV6PRwMPnW2qHnTi3CWdyxOdkb4FgV/eXTJlAx1Qnn7fftHGRw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441059; c=relaxed/simple;
	bh=OtHFbcpOVbLFwcytf7vnE+Hfd6w3VV2I2VNOK9waWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwpfHz35abfeKj0l1/IO8gdKmlZ3Rt5mtJcDILlv31OkUW3yDZ7WfPIFePhGdAV3TJ2BdD1Y0eHqwlapqmcl0c1p8JoOIWmcdFwBDva8tAfkGkBDTEdTU2kvs3Tyz9YS0xbvDTeyxv6E59ArGIRijRdg5Srb+u2PrcG7WA0e7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IZmqc4iO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-464bc03efd8so1885876b6e.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441057; x=1774045857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLKdgna2TJg/4cf6a9WLp0moZG16XDEww02DyhezqPc=;
        b=IZmqc4iOxoBtUFX6VTFP8z/4pf2m6t55C5WJyM7E6R8pUwH4XcXqwqhvf40zXvYOS4
         O4stlxlMA+ijEMBcRLuvuQ9ioFM2WGqHfS5QYsh21PLWbEnOl+AdAqFmzckLECew1FB4
         s5MMJoBrRIdkcJUbwJX7UaId8UHl/DPDBw00dDXMSVWiQJOA8q/39OQi+b5GimCYhYrK
         C12qfD2xhl+4uwzOWBO8ivqS71X2UkboQ4a/+s4kft4DpPT8TWoxCKyd7aRNlXjR1pgG
         RjVbgWXbJiwBRQieGGyOX9Lcb2aD0NHN9/e3S11ivhMIMuOTwYF+64ba8u2mKF1zft5O
         nWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441057; x=1774045857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLKdgna2TJg/4cf6a9WLp0moZG16XDEww02DyhezqPc=;
        b=dbsDdkQBmeFXBEqh1wNfLQSburd6mKTyX1MgqTiiwJsZ9jnBtdW10nGtjlnWa/e36j
         Xqiz5N/7Ria7kuqAU4xiY5EZHOS62OqpXe8zMqA8A6DQMcR+EgWy4/cQ2vckFHNVrMzT
         6Auwtab4OaRaBb1G9VYYryIQumb9z/zMVWzK1/iJq3yG5Aumb/ammxeJhe6f0cRa7ZsM
         3w+ztQk3YcHs5jkZs1v30iyrick0WM0Z5qGQTH4Z9xHkQF0L8cknvAFnVP6F3OiH1lSn
         w2K86BYM9wJu0KIxG71yU/9h1cEK8W/KEed/5q8e5Gjvj+b1hsrkfy0uJNLJ56/7/4q2
         05bA==
X-Forwarded-Encrypted: i=1; AJvYcCVo2OQT/G0tQb4HHWxFu4mQXjmlnMeIWCvvV5+0PUiw0DSBQyO0z8EJmddSj70XMFcuxO7WuK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPs5xzDxA134ru9OWOZ4O9S3oximu49bRAdj6/wmhPy8D+WAgT
	sauCRmGaOQ20wHlI9zsm/GpgRvl6dPbDowfSBcK1KQ2+8hLU/mJpb+0YVSsR/8p7OnY=
X-Gm-Gg: ATEYQzzASKQs0odzLm//YP6VRVxCzgnZtfRM92aw41s6AjTgEefv6uTioMgsTrmqhMH
	8U/biTmJu3Mo3BEl87YBEUSGr+S5/qkVTZZp/yAU5wFSUKJKfgQbdr7p5bY3EZO7lYCMTq7yYHI
	BE+uvPoPqhvZevuyiOcIUarfmyEqjRhTrXQHLJjgfszd0j5Ma1Bxql30+RSzY1S8+vFUdWV1eT1
	6a9lKJpH8ve+MXeWo5/YIJpLVHwZBGwM5cpj/8mudV9SEbUdFufhyW2xme/k1YSAtqVcGPyLLCX
	yAkYRmSUxHu3acveCkU+r7Qi5/PDCoXLRNKICEnWuYLJXDZJOrGRkky6oEClJ8Jz/ZTRuTdXfk4
	2uhCD7YfDG0h0Ln3Fi0I/VTSf75My8ISQ/2q73ZLRudYfzp3+YrzRjokqE+ElXmqwA2PrUX9IFU
	RefXe28cT75Ib1sCyYXbU=
X-Received: by 2002:a05:6808:a550:20b0:467:2926:1252 with SMTP id 5614622812f47-46761727390mr1271145b6e.30.1773441057445;
        Fri, 13 Mar 2026 15:30:57 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:56 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 3/6] bnxt_en: Move bnxt_rss_ext_op into header
Date: Fri, 13 Mar 2026 17:27:33 -0500
Message-ID: <20260313223029.454755-4-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313223029.454755-1-carges@cloudflare.com>
References: <20260313223029.454755-1-carges@cloudflare.com>
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
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73AA728A6A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This allows bnxt_rss_ext_op to be used by other functions. In addition this
modifies the rxcmp argument to be const since the function only reads from
this structure.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 -----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4881d9359549..8176d34b3408 100644
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
index 34bb98709f2b..f8b8068bb47e 100644
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


