Return-Path: <netdev+bounces-298404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XyULLwFBK2rL5AMAu9opvQ
	(envelope-from <netdev+bounces-298404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:13:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE0675C81
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:13:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XSKsqaha;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298404-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2711E32074D2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03B38E8DC;
	Thu, 11 Jun 2026 23:12:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4231326A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219561; cv=none; b=ugpvtPhgFXI9jeGFEAXASv+JWiJ5n6Bs+EDL7qd5MW/cu/myoopN3scBNtZxnrK+8qpKmHu6TUMCvNRQN7dzyw48bNJq4ypHqdxi5uCPSFURPmdZIhzUp/qmN4oGq17aD60oQMabMV4zms89urTK7sQELZSYKeocpVzT2jmt74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219561; c=relaxed/simple;
	bh=pjaqCry+5jomCtNcVTv7LGesukQGkSwZ3Sv1c45EeV0=;
	h=Message-ID:From:Date:Subject:To:Cc; b=KVFNWMIsEK87D7Gj4Ev+8kJwTByhGNatiHJGVeQ8+pBeCfK1leNiU4tbdqT/Ad4MJ7EnyxbGf25f8jETA45mz7LO9SieUVd9/YDMOLR2MR8eLKIiPBFS7b+vXNy7B1TtGIL0oe9wRvkcrUuhBMYQo91oN31xvZAFcWnvoOvZHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSKsqaha; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842cd900ee0so206251b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781219560; x=1781824360; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32LA4oVKRlobt0c3JKXFPxQfDW1KytgL05KrQQdvsrs=;
        b=XSKsqahaCniRryta0hFFp2lPAFKVjiDZBj+PhvX9K8m2kMIbiPJtyYlWh5DgPPHE8Y
         y9tVSTDxH1GpLEdEZiaor42IwosTKMU02W9bI0xa2wJKb4nDL20MXUcABuxybIuVJQtR
         EUkxKgRaLlAemP719hkDfxlv2a7po+Dtb5OnDe9BVuB8y/B4HiO6oMnH4c4WhNxmyr6h
         jgxjchx99D2cfTsI2ilO2qrciSnbqxFHrDTjLun8z4AqbxD3Ymk3IPj+aVIun+NREEQW
         Du2CrmbRgtOfq0WHQHzHsSi48yj2ep4OzsHqvn7QFFBed6vsrbeS940RUYECRUsOdcf6
         +YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219560; x=1781824360;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32LA4oVKRlobt0c3JKXFPxQfDW1KytgL05KrQQdvsrs=;
        b=rl3BFyVVgEgKm9OPpjGkB2wT31459iS4G74C+dyHJiDgXV74KgCW263qFCun0A8wtL
         zHYCLwcj0metEm66DBGTcZ0Bc3FcehiF/EDlXDLsxut6CssBflgK0a4scCz4FW9Vgd3v
         JL/dYGuY2732zlfSTVlYDGPOvmQhEpccyuWcyJG5ySIcb3nraVwh9YTRO6LsPuBFeQPh
         giDindCtn1t1hsiLxzaO8gAkeOS0lsp+NeaAiSf3rMH0CspF3CgyjUMLZ+2rWzXy7GkU
         DuwD8sosPfRtFH1wPHwlwHdF5pkt9L8E7AVCbtF3+1xyluBIQPvJcK3XbkT+9IuUYHVq
         GWXQ==
X-Gm-Message-State: AOJu0Yw++s+fT1W/vJExL4/nYJyHBAasFMPUCc1GANAZsSLjP4kM2G11
	dda5eEjIcVlJBVQkL4ALdB33nsvR2fI58Sr39O0F3EGBdi9nqwHDb99OkQlqfDmZky4=
X-Gm-Gg: Acq92OFFVEN+iXoRA2i+Kx1gFCyxH/61PGsWunizm9nKmL97aiKMrbM5rI8TLTT7ZTa
	4GtoCRn48IuWxyLnlr5p8LclusW8E3+3JRr7f8F1P9ghtvW+86QCAvW9cuiSeIRTXBS/ULucYPr
	G1xEF+vrBPSs0g2O6qyPtsPVr7HD2NDVxjZBX7pnf+AErSnTjok7BK+u3+H3shE/B9iu4W+6WT9
	JZyKeGs4zEcW0+SWBnOehVACniIO1HHnwbdws+iD7eX/hzqCSU4znZzsCsHNNbyuXWg9Se9NdqE
	oHq0Z7yYZGoHMiGnj2hfE6dd0WbMcVOC1SDfIf2myXBus+Ioly+e0s7WLlwA+xwVU61+ne2w18T
	7YzRgU90mh467ZCulIG0A+K4BZzz5JrzeoTZK2Ps8NODZAGaugVZT8b+oOjkYB4fXGdBvGFeBCY
	cMQL8nuBhjkcIfkyLz
X-Received: by 2002:a05:6a00:4f8e:b0:842:6a97:52f7 with SMTP id d2e1a72fcca58-8434ceddc63mr106827b3a.19.1781219559923;
        Thu, 11 Jun 2026 16:12:39 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd100esm199571b3a.34.2026.06.11.16.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 16:12:39 -0700 (PDT)
Message-ID: <6a2b40e7.4dd82583.3a5c46.e566@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Fri, 12 Jun 2026 07:09:13 +0800
Subject: [PATCH] net: airoha: Fix register index for Tx-fwd counter
 configuration
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mx.google.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ABE0675C81

In airoha_qdma_init_qos_stats(), the Tx-fwd counter configuration
register uses the same index (i << 1) as the Tx-cpu counter, which
overwrites the Tx-cpu configuration. The Tx-fwd counter value register
correctly uses (i << 1) + 1, so the configuration register should use
the same index.

Fix the REG_CNTR_CFG index from (i << 1) to ((i << 1) + 1) so that
the Tx-fwd counter is properly configured instead of clobbering the
Tx-cpu counter config.

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11..329988a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1256,7 +1256,7 @@ static void airoha_qdma_init_qos_stats(struct airoha_qdma *qdma)
 			       FIELD_PREP(CNTR_CHAN_MASK, i));
 		/* Tx-fwd transferred count */
 		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
-		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
+		airoha_qdma_wr(qdma, REG_CNTR_CFG((i << 1) + 1),
 			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
 			       CNTR_ALL_DSCP_RING_EN_MASK |
 			       FIELD_PREP(CNTR_SRC_MASK, 1) |
-- 
2.51.0



