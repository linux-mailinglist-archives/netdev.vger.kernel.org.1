Return-Path: <netdev+bounces-274278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNOWNYCszWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:38:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D6E381B79
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 401FD30470A9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EAA3F0770;
	Wed,  1 Apr 2026 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="h8OgMh5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09D3F1658
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086696; cv=none; b=SwghzQTzBEwD8UBs/hrpnZKqBMXsUS4pllSHbHbE1mRtJXya1QtnsxcFsrPtr+HZb6MSFzKVXEGzENeIDFHAvq3CJLRv8jwxljBzOLu7TnYeJPgZ5JFxqYM4yR/QS6ld+YXWfRELXu32plZ+i/vlxudNHyM+Bp6ytJAT3fuLsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086696; c=relaxed/simple;
	bh=Lu2Nj/UoAaaciq2gpBkUn86nXLEy3o1XfRVQu4gPPcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHx59QLdM8lGyPBAahMCE6U2JzrfBpbfAGEULgRZEWlEzZ8hrWmuJXOk0Qkv0eJ1g5tlwNVhfWlrgR/ka3TAXP9RQZQhKHaaIyqA47Pv6cnDvqImPVGjjJuREBp+icXm2jUkPEDyC+tOcmxf3RjTxBq48MyLb29soufPFC+bJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=h8OgMh5Z; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so85865a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086691; x=1775691491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U5nQ07hN5UPJ21y01kKu+oNHzfnV8MRDnHGP25Esxw=;
        b=h8OgMh5ZpzUp4ZKkz9pyVNE+LhnQWeBnIl5ObE9j1rTWQZuL/YXUlrimdjPWjwVGC3
         5zuqk8YiBNk4H5J91DAtJJIFL9GGANYV94hX8N2Rb/lSswXipc9VZOmI4DuG5G0nKvpz
         NAN+mjTayevi9uYZHE4iNWoFvT9po1Vo5AB4jn20n15FgBTysal8ctOLZXnn+SxyNSJW
         p0jER2AeoqmNYU4ijHnsXpXB/M9zeCIJaP7ZAXePZhHEoO7RXMBo1toYymiDzzx6EFZU
         Wnjnd3X3ahYDZIDTpfLx88m0AsqAlciFff0O7HqBNlUW5/9ullJwhY9nBN8gJONZH1Lx
         4V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086691; x=1775691491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3U5nQ07hN5UPJ21y01kKu+oNHzfnV8MRDnHGP25Esxw=;
        b=FnI9Cos0878IxWiqRCGxPr9XZVwxjfUeM3Xhhwyd7gKaY/LGgElZR2sFIFDAz3YagC
         2E3vnbr1dcUEMOWlfauZ99vsM14sLvtSbxF8SfCGinly6ckGpIs/2RdZUJfQagnXBL7e
         7m2T5FflM5iCzXl4VgTjBa/MrPBJYwmrf7u+2bt1fViKusxjrTvwm/iMTymUoFVCmQay
         Tk6G6EJEo/B7Xqv/7pKKV5EX0g6mPBmlXbFUjzmfgM0DWvoEFWi+hyi5tlAyu0b6F6kp
         KsK3ZRHX2x2avguWHXPUsGMED5afX2I8XG/Oxn1vOzG/kfO5htj/KjcXY/69SOYQj0Ih
         ySsg==
X-Gm-Message-State: AOJu0YxD7C4aMeE7m6Le6Ry/4cWhaDUbJCMDSS9EiBbztYCIvgILRYtM
	/jP1VOggANgvsGG9iAmOufFCgsl9kZsWKnJhIPD75g3eTFDFsqJ6YciAVycRvs4dYct8s020Zis
	Z2GrCJds=
X-Gm-Gg: ATEYQzz6elEQ7DILDbXsGEpm2upY+SrcL2pEEAfzeDWVYYAICw/2P54Cwnd9nGBh/zl
	zSZOcs90ehOEDOpu4CudVkQ642RUhDVJLe0/nYx25d6dpshZQI87OL/Q0+5JvAx70RxO7w6G1Dl
	7yymMEyskNN/cnd812eUm52X6a0YCOldo0ichC70GrLKHS/3gd9bvTt2459VGI9EYAQ67lXX7cG
	+WWP2ROv+PREENWjjQWa36jZYW6N9m+z8dcy8mBEy9jEbDnX05QNGclnsrt96ktXVBaZI0d2vqf
	FkXx2SyALfVEgzjY3tFG8YxXNwm1lAVxFBxjjHmuVo2jINv1NsuWH893xUvWSk7ngA/AxYgC9lU
	Q8FHT0a92i+3sDxRYqXpqQ56feNIeg/3nWJR3vZH9r8U6s5MNPtOzJXk0bYMC14w1k/iVqAovdW
	UZEUiZ
X-Received: by 2002:a05:6a20:734b:b0:398:6461:688c with SMTP id adf61e73a8af0-39ef7223b3amr5684829637.2.1775086691183;
        Wed, 01 Apr 2026 16:38:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6476a81sm900824a12.7.2026.04.01.16.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:38:10 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v7 09/10] net: bnxt: Dispatch to SW USO
Date: Wed,  1 Apr 2026 16:37:37 -0700
Message-ID: <20260401233745.2333858-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401233745.2333858-1-joe@dama.to>
References: <20260401233745.2333858-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274278-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: C3D6E381B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 92a4c270d2f5..90bd1b806db8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -508,6 +508,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 #endif
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
+		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
-- 
2.52.0


