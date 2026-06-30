Return-Path: <netdev+bounces-303325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9RAxBLYJRGpQngoAu9opvQ
	(envelope-from <netdev+bounces-303325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39086E72CB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:23:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CdMPGt07;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303325-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BB723022572
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E24611E1;
	Tue, 30 Jun 2026 18:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664243E1227
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843696; cv=none; b=QVdeSFaTmVjde/u/Qrzl6YmBy5/LLQ+6hPACBqzeVysr7PZW+p9L5mKL2Ryg6aShUxxaYbBm9bJgV2SHIjsxWw1I537XKQ3lfAsYjxpAmRjS5XkysoheT8cWBD54se0HnwxWTTxIGDqdj1gio0dAGoqgSwn700IO9p6/fLkHlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843696; c=relaxed/simple;
	bh=+Bck/AIRrSuAnBk1w2hhYEDp6AJYcc5dryvZH3onWLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx9OkcNjS/h0rY9zXSNzN0htGdq4MHbNnConQcrAM4TeId/fIJjhaqrbUn9BxIExnpZIdnK8OesSD3W9aXT681lxSogrBzL/LW900mBSo3EG9KbxGC+qAyJSOc36ax4S/ElbaPNhVanUcWFfzC5gh7nUmob6hHCkHqHMVouDt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdMPGt07; arc=none smtp.client-ip=74.125.227.129
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2c980dac2b2so4973635ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843695; x=1783448495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbiP2ZDbDEF7MxMBi2Cibr1JyKAUZE0Nd+Glad1yqDU=;
        b=CdMPGt079y9/yCh4tjOSzYpQtgEXbukdPkD0mzCcMI4t/c185BU7CKRrWWGn61s6wq
         5lv/k/KtZNo8jrXuccDuE7XPqD8UaoYGXVTOGwY2nQdvTpm4rWv+HDHd/XH17NAh1Q+r
         uN+MjREbF6qjBBPWrkJ2wtxoFxhFiNi1KHoxoF7UafoZK/mcgyiCHm7/H+DOfZfzlWm+
         CfDpCPPBNLYnexVcfkzIQulkwFXIZkqfrGRpxzVsQlN6EN5M7kmX/cV1KdxhqCPzyP0G
         dw19iWuLYXmWdETGdEJT19iKkyL8DVJQ0At75+qXapCkPm94R5LX+M5GQSMSCChA587f
         T14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843695; x=1783448495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbiP2ZDbDEF7MxMBi2Cibr1JyKAUZE0Nd+Glad1yqDU=;
        b=dQcnCh0thHnanFy443I8WZgMtnOICTE1WpfVlYiZaiU42Gfsqe82O8kkk+y9sxZgB1
         IdCeL8IWtNVNOJ5MMBbzqlP7II+MXo1GDp+SeTIzn/XXocR69jr/uXoW8pgtOsyf4rD5
         +7iEdTRvbcThncaPxecdShBVDeX0apMZWIsE8E9OtNHdK//fTvJzxm+RFLJYQNzVTZRw
         /BAvtq88rFLYVNZdT3wr4/s3I0J4ftcJFwf/Y06OaBweI6TIyMwftCRJS/uqhbfyQMBb
         EMOIg8pCXPnjUAttrJpRO5E83rd2465KQK8LsOU6Kd31vs+EKNVOXhXu0uXmjYjOedd8
         03Mw==
X-Gm-Message-State: AOJu0Yw+8wMGgvE72XZCEWLNK76mPRMX06MaCSsHtglI2cHyKRZmfKCS
	rP7xw0rQT20mufKDCG0LSuuHYU/OMqNCC2uQiEEgiiTlQIE5u6nkc7MP2MS1wzFC
X-Gm-Gg: AfdE7cnmLv8ShvcbV4C3ivMzMCuTtNDWXdwAD28yvvlEyhxZUw7VajKCtHUsM22X6MY
	bEsyqy8PH2kTD9sCk0pdjEQApQ3BgmYJu/zPJ6V/AgizwTqrEwWuAOcNXkOA50binAfDg4fJH5j
	INKlL51/jIY/5f1KmDx5KBK8N6k6vJI8aLN/A8nbldRgEWwMmGnz5hzJHKn75U0VekrJ0rWHk22
	l4Locak7k3WLaa27z0j6E7UlCYVJmVKD8Q9uxVdvksbBt8MdgjwINBWGwg8SbszBzDt84SNkDMj
	n1CIomzTZxg2NexVd85J/no4yLKS7F+wbLWJMOowIMKy8PliIgEezr7yv748Z6k6yxHKR2pXNrt
	lcjbZqTOQdbRuWYPLeOedg+c+ik5LY/TSKUlucB/bXXrGueZSDby4qvivxv/HzypzKbKbrCmTC+
	fFj9IhZQ==
X-Received: by 2002:a17:902:e752:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2ca2d53de86mr36706655ad.12.1782843694858;
        Tue, 30 Jun 2026 11:21:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70763sm19496125ad.12.2026.06.30.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:34 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 3/6] net: mtk_eth_soc: hold instance lock around DMA-device-swap close
Date: Tue, 30 Jun 2026 11:21:26 -0700
Message-ID: <20260630182129.1601784-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303325-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fomichev.me:mid,fomichev.me:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F39086E72CB

netif_close_many will soon assert ops lock (for locked DOWN/GOING_DOWN).
Update mtk_eth_set_dma_device to manually grab and release the ops lock.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 5d291e50a47b..fe7610c42e5d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -26,6 +26,7 @@
 #include <linux/bitfield.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
 #include <linux/genalloc.h>
 
@@ -5030,10 +5031,14 @@ void mtk_eth_set_dma_device(struct mtk_eth *eth, struct device *dma_dev)
 			continue;
 
 		list_add_tail(&dev->close_list, &dev_list);
+		netdev_lock_ops(dev);
 	}
 
 	netif_close_many(&dev_list, false);
 
+	list_for_each_entry(dev, &dev_list, close_list)
+		netdev_unlock_ops(dev);
+
 	eth->dma_dev = dma_dev;
 
 	list_for_each_entry_safe(dev, tmp, &dev_list, close_list) {
-- 
2.53.0-Meta


