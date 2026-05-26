Return-Path: <netdev+bounces-291918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKizFy4BFmpngwcAu9opvQ
	(envelope-from <netdev+bounces-291918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5F5DC4A5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672E93002F8F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC193B388E;
	Tue, 26 May 2026 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT2qID+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A183AB490
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826987; cv=none; b=OLLC1asyZOyrl5DSXn9WwJsmKPI6x78XQD2CnuXphu1FxZUFfCFFPSDv0KWc1pe96KOCM23IvOzuO7hKMlyleAHOTSGqYAm8FI0Y/OnQHAR/F283nKiNv9fUvdT4IpU/qcNSMGTdBzxYORKkWDv1fZ/lNmZdIMJUPXkF8wAVT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826987; c=relaxed/simple;
	bh=TRyFeOjEFg9Z4oD9ybe51Hvm1Kn6K0WGSxcwfFiQJCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teSHs2BiDhzeIlMt1NxgWKEkgtB+COvwnRQ7P6su8JbH3y2jT0EaqFnJoqfg5V0RSlm5B7BNYzAnXuLJjgIBz2liuGOj6WJ3fOlHD0w/RbeRkmcpfn3xd+4zV8QLOl2HeVjsjT0UDRMBepnRTW+Xl54G2wYKkVCk55jfWebJpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT2qID+N; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-366330b6751so8620109a91.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779826986; x=1780431786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3mXtq2h7QJnUw/yzmR3z22pM1IqybeYG7SOGc1FU/E=;
        b=aT2qID+NCWvV+KIwCvVS94In0rwK9EOHT02vqhflSyEaGc922A6QKMATwUag/oFGDj
         FKF37CvsqUSmjsDMaOZocPGO+dWi9hxCB/Dr5uYcQvEr3M52Qigs5nuQjO9biX61sKeM
         NbB/s2zZOvn3dbmn4BmQj2MvDcPQOqfZbPpqX0BlR/1Tdf92skeRutSMYkjv4is/oPtk
         kfMo+YX/8Sb1PXJTBxqrW3c1nbp7yQUgOPn9bSKjj/upexg4F3+Dh3qgxqsFKGSVP7h5
         Fr2ZmGyeI6uvG8k7Qw84Bu/h7pHj1FSriubcjeXBQS700m8EW2IYqzEXOSXTXfI1vSU5
         dP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826986; x=1780431786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3mXtq2h7QJnUw/yzmR3z22pM1IqybeYG7SOGc1FU/E=;
        b=epHmzeypRJs51Ss6U+GQyHDCXJWv+9z7CRB2Rv1l27EYeSPXi4SSvg1OB4hCgoJNw/
         3nLmNBsvGr65AE0uysZO8X4au4i4wfjZisUMW1TK7x03voq9X5sxEz5UfLM4Qdrrh1rD
         5FHcC0aneiDD8cbR/G9XFKwHtdafJnzaIQzGU9Ic2z7qr1UCc5Ow2lK1RiafxzT/gROo
         tYW+de6cqNwatlzWWp/OzEdDTd4Lc/OScwoQjEu/OMTTdJp/TNVA9ZpI80kxW5SIM/iw
         /BOWKsa4A+6f+PS9t0smE/v1laN4rw5iKUu+veqxVu0wQJ+p/8n6iuueIRIiO9Xdx3Xx
         5E9A==
X-Gm-Message-State: AOJu0YyH2E51WLBoc/Q6MCHftp8iUv2K+mwI8tvLD3LcguxgWhbciQii
	gXH29KTw7X844p/nA9OayBw9pQbsK/FFbYyMcIDb+9OfLeiQ1ckkfgNTETPTg697
X-Gm-Gg: Acq92OFxBud9mzBHd52m7PRTitbHPcempkjc7BldYneUpe0jaywjhOc59Ocj47E7aeS
	4yZQmbkWpM0VQ4hnHkWeTrA40myHfDLxLezOvbG5ZFtD+BhVcxA7JqFvjT6L6DuuUXFTF9QDKEh
	vHFylJz67f1apxz5K7iDhl5812W2l/X5jSBcuJtHi+lV0sMfRYKJP26Lnw8VV77MFS+D8pl2n83
	lOQKFWSKgJPFlaNwz5Uzlmg3L+noUJsY2G1ezox8iNrt1+N9Unp2KMHTL7wcx5nsTXoWgxRPfhp
	dM2XYAccek2siMZdcFgNpYhRDyaCo3uofAQv4x+Dqq4dCXSvqD/TeOVTUMsmo0nadRHfA6rWHS6
	qII3NNInlC9tQgs5XOF84CKtJnwnrP7QtJZNTrfjpOlQ5+6VTzRrPo9uwRKZiUpxzZWmHEY7J/z
	JsY5KhZDdcsoTW/txjklO9uK33T4/1Vq5pZJKXSRfrBohsdpGPN0TyNs6602YMzTDsK72a4YGaS
	85ZjYZ8vvyrUfbT0u97jih7I2303XwD7o8=
X-Received: by 2002:a17:90a:fc44:b0:369:bddb:79b5 with SMTP id 98e67ed59e1d1-36a676dc2d0mr21013700a91.2.1779826985725;
        Tue, 26 May 2026 13:23:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7b92sm13280442a91.12.2026.05.26.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:23:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ibm: emac: Reserve VLAN header in MJS limit
Date: Tue, 26 May 2026 13:22:47 -0700
Message-ID: <20260526202247.13823-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291918-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1B5F5DC4A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IBM EMAC programs its Maximum Jumbo Size (MJS) drop
threshold from ndev->mtu directly. The hardware sizes the threshold
against the L2 frame minus the ethernet header, but does not
discount the 802.1Q tag, so a frame carrying a VLAN tag and a full
1500-byte payload exceeds MJS by exactly 4 bytes and is dropped.

This is normally hidden because JPSM (and therefore the MJS check)
only engages when the MTU is raised above ETH_DATA_LEN.  With the
qca8k DSA tagger the conduit MTU is bumped by QCA_HDR_LEN to 1502
during dsa_conduit_setup(), which is enough to enable JPSM and
expose the off-by-VLAN-tag in the limit.

Pad MJS by VLAN_HLEN so a VLAN-tagged full-MTU frame passes.

Reported on Meraki MX60 (qca8k switch): tagged VLAN
traffic drops at 1500-byte payload, while 1496 bytes works
and untagged 1500 bytes works.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 11d673a9f119..90471cff37dd 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -30,6 +30,7 @@
 #include <linux/skbuff.h>
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/mii.h>
 #include <linux/bitops.h>
 #include <linux/of.h>
@@ -457,7 +458,7 @@ static inline u32 emac_iff2rmr(struct net_device *ndev)
 
 	if (emac_has_feature(dev, EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE)) {
 		r &= ~EMAC4_RMR_MJS_MASK;
-		r |= EMAC4_RMR_MJS(ndev->mtu);
+		r |= EMAC4_RMR_MJS(ndev->mtu + VLAN_HLEN);
 	}
 
 	return r;
-- 
2.54.0


