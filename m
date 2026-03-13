Return-Path: <netdev+bounces-267241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S/8GOUJbs2nfVQAAu9opvQ
	(envelope-from <netdev+bounces-267241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:33:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406D27B9C4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFA20305FDA4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010C71F4C8C;
	Fri, 13 Mar 2026 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfhI129+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2F1F1518
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361980; cv=none; b=ZRp4EmRawZLNptmbOS5uzX51Z/JldXElnJABF/pL2HfOWk8ReQGMjwShZLPE43Qc7WOAfilElrw1gOHX7X5IpuxjfNPjzu7SPTrgKOWxdeANe5VEX/Gm/eOpoxEJl4ZNaOYekfh6xzVCsRk1Ak38of2bo18TOVPVLdCTYpgzTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361980; c=relaxed/simple;
	bh=qoTGkXPm2B03nrLj14sLWy1RjTayYbSjvluqv9kWZnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUkUgblBOyam+M/DL3aCB0xvWZp4goeXgR5S6PuZZjQ3QaAZvz6LOKYojC1ZfXzIUFc7SkK1fEYosjKP6ZB6nGH3ioGQEbWrCRv3hfzyxxg62QgipQnNsf1nbA9upjGdR5qPI4jOLZ7X3f9X2HUzBWm6rN7cS2V8DfI5Lb2OyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfhI129+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab232cc803so8135005ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773361979; x=1773966779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgOsaObvfwePcK+05xS+LGdPcg/uUIfATNSEAjZLxfM=;
        b=gfhI129+euRmPyvTngvsW2CUxoGfspFBKEFAumkIPV74O30oNVdGjq13essxWDNttJ
         Z0CYrgbxaMZ4YA4qDwDydq4+b9D0icB39+L7Itp3ydCxazl5m6hCGNxVGI0hEoFMCc6t
         oQHjF99ejvTAbdb3Z/a3XIKYZ/AYsvlwR9J1RAxgo/Qd16U1BUm0AklEVR6t5rCgMHKO
         +Fxjm32NmCiWxLoUtn+vSTlkhVhpMoC8CJpQgDRTleqFpsvOMH3on4ylHfjG3gxJB8ot
         zdfCZznIogg+sxKRTAKZUOwgnMBYoSzXPS113JPe5W6cEOe3RFi084YUFK3QC2jjlOvW
         FMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361979; x=1773966779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgOsaObvfwePcK+05xS+LGdPcg/uUIfATNSEAjZLxfM=;
        b=AvUtwu/vgJoF6poApxgzN6SDgU8miz8sSkni7vEq1q/GO9tarOtNoH+u7Z/n83ZEzc
         RvAmvYel989nEAcdNw27xCitwuYts+iVX9wV7UJbc0/KnTNSiki8cyrZCXS/GV3fljTB
         hhMxeR5sHqiAO0Pqkq1EUB+dL1Ou3W26S/IdwTug1JxT4BIltWRLkG1aHIN7d6Yzus+k
         WxC1oLt02pP6s9hzhsYbwQUmcCh4+anET0xIxy1pJ4mPca8n+GkgbQyGxJcXD2urwGcX
         t4+MzGSKLGD3LCG6mRt1eBJu/Cy31HSvNlQoJJHF4qXtCyx8VVCdS34MR0WK5Jz5kjrb
         Ra9Q==
X-Gm-Message-State: AOJu0YzNmIiSKYQ4SYFemTeFPVX+ID+rHZWjxMdBU9jOqvjaWh1o7tU8
	Ok/ybXMqRY19WCuEzCkwIMvBeio7c8W1eYJVSZHIP9OgFQ6p5IUPKTG02QkaaQyh
X-Gm-Gg: ATEYQzxrFq1p/0aL0cCFlCaO7xjVGrFQxgLQLQ0CSEDbg2n8luBdRIQDN+jNC7RzQLB
	OGVUHNSw+40h/nnSBAyV/Ce+K9UyXcS/SqoujG7m5LOmrQ6hqSVRKfKSg4oYvz6GgNJZSEbTlRQ
	TWUBetehebwYefPpDmnYkcapC7sshUAZT3/lbjQ+Y1qmOIUuPN3vp7aM7XjCFJqaMVUI8Z1/wU9
	wFhJLSWhq852b+Shkut7EFUjd8K/npjx8cJx/2c5bq1DPyU3gcjrT8qQyOUx6/ItNGoD+hCptLN
	TemEBYVPeHxNs+54d5b4GuqICVlWw3SQv8Gxcxf2yROXk9tgVMDHknJrUn9HGTq0PqB+AroL+qG
	+eyeZb5+lWJRJcPsMlBnFZHUhxvzIH14nFRRZL6pK/Pw42siwMqwugLQ6zrLFDhvd6aY4MLov1q
	h2h+PXmTeak7L9HVX3UlKXedrxnjmB7Y8kXSPrjmMiXJZZTeOYKCjTQg==
X-Received: by 2002:a17:903:b50:b0:2ae:4f90:3245 with SMTP id d9443c01a7336-2aeca92e5f7mr11238905ad.15.1773361978685;
        Thu, 12 Mar 2026 17:32:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece845022sm1886305ad.83.2026.03.12.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:32:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] octeontx2-af: CGX: use kzalloc_flex for name
Date: Thu, 12 Mar 2026 17:32:40 -0700
Message-ID: <20260313003240.123975-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267241-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7406D27B9C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Don't bother allocating separately. There's no good reason to do so for
a small string like this.

Remove name kfrees as a result.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c     | 13 +++----------
 .../net/ethernet/marvell/octeontx2/af/lmac_common.h |  2 +-
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 4f33a816bc7a..0750fb696c90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1725,14 +1725,10 @@ static int cgx_lmac_init(struct cgx *cgx)
 		cgx->lmac_count = cgx->max_lmac_per_mac;

 	for (i = 0; i < cgx->lmac_count; i++) {
-		lmac = kzalloc_obj(struct lmac);
+		lmac = kzalloc_flex(struct lmac, name, sizeof("cgx_fwi_xxx_yyy"));
 		if (!lmac)
 			return -ENOMEM;
-		lmac->name = kcalloc(1, sizeof("cgx_fwi_xxx_yyy"), GFP_KERNEL);
-		if (!lmac->name) {
-			err = -ENOMEM;
-			goto err_lmac_free;
-		}
+
 		sprintf(lmac->name, "cgx_fwi_%u_%u", cgx->cgx_id, i);
 		if (cgx->mac_ops->non_contiguous_serdes_lane) {
 			lmac->lmac_id = __ffs64(lmac_list);
@@ -1750,7 +1746,7 @@ static int cgx_lmac_init(struct cgx *cgx)

 		err = rvu_alloc_bitmap(&lmac->mac_to_index_bmap);
 		if (err)
-			goto err_name_free;
+			goto err_lmac_free;

 		/* Reserve first entry for default MAC address */
 		set_bit(0, lmac->mac_to_index_bmap.bmap);
@@ -1798,8 +1794,6 @@ static int cgx_lmac_init(struct cgx *cgx)
 	rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
 err_dmac_bmap_free:
 	rvu_free_bitmap(&lmac->mac_to_index_bmap);
-err_name_free:
-	kfree(lmac->name);
 err_lmac_free:
 	kfree(lmac);
 	return err;
@@ -1825,7 +1819,6 @@ static int cgx_lmac_exit(struct cgx *cgx)
 		rvu_free_bitmap(&lmac->mac_to_index_bmap);
 		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
 		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
-		kfree(lmac->name);
 		kfree(lmac);
 	}

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 6180e68e1765..21504327032d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -46,7 +46,7 @@ struct lmac {
 	u8 lmac_id;
 	u8 lmac_type;
 	bool cmd_pend;
-	char *name;
+	char name[];
 };

 /* CGX & RPM has different feature set
--
2.53.0


