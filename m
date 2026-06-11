Return-Path: <netdev+bounces-298403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uGC1GelAK2rG5AMAu9opvQ
	(envelope-from <netdev+bounces-298403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:12:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7D675C78
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:12:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sOr75XDD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB71930BAB98
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB8537F74C;
	Thu, 11 Jun 2026 23:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4331326A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219559; cv=none; b=jtcOGUaIxqMKhmdk/97TnMMWCwZjg7BuAbor37c5hb8hQ/Ol1QvbMPkVNkkyL1BWVMVS1qrc2WcbJWgtrwLrpUCCOZ7n99VFAlxmdira2XJB4pev2NLBSN7lGXyTsULnD6H7btznXdyLCK+6CDcNfv/K3losNot6DIdxuQd4QUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219559; c=relaxed/simple;
	bh=IjGZmTh2Fj3Nl/YHkWtbpXKCw0EY2TJoxYwJ4JZpiNs=;
	h=Message-ID:From:Date:Subject:To:Cc; b=pCCo9OiRfyyvxq22PUh3s0MCT6KK8mdkp8JcqmWsXNfg6VbX3p/qWg0LUY+Q400X0bc8MTq9AG/T/ntupHufA2GVfiZuKT/E8ZsgAN8j1LwIpOWkiP6mDCxDOdGmhfrq8OO56bxko7H+fIIgHVXWEhOVAqD1ydtbjQC6JRnzwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOr75XDD; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423610ec93so370723b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781219557; x=1781824357; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chX5+4LVo+BT9/6liCDMzJGUd4v7o9vOEW+SNH6M1Ys=;
        b=sOr75XDDTrymjOI7P+yzl8WNPz2IxrygNw/jzsk63ynPCOt96qoZOFPLgdNZNlWt5j
         /0dD9kwhyuDVjxpfLg8CgBFZMALIdY8cQXp3jU64FxQRZQWOqvFK4KGBVq5d+esAWKJo
         Uotr61+AAYVPexY2nwFQjuOigUc0Pu8Fv12OxHY8Ds+TfgUtKo1ngftAoUBtIKInj0Ow
         5SHei6k3g1qEc2xXXbUbIzDWovNT+S1XwuqMpg6aglTSnN16JurCIZZK5bZ0XdT1KpRf
         D0vSNd6vN+bDUijzawE2LPV1MQvDw2VkhpFKFSGURUfcEQC+dL9pCJDGvK0d3ukgUz1Z
         gOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219557; x=1781824357;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chX5+4LVo+BT9/6liCDMzJGUd4v7o9vOEW+SNH6M1Ys=;
        b=khzNyzWse/x7s4INau23nzHx9r6ZYuXan+vQ2AZp9DIBszpQBW/+WhNuou+igIpiSD
         WwUgNSdgyjEECeGiv+geIHtrfFWFkO7FU83TtJJMUgBmMr2M1iojSMU434CC7epV5MT2
         8FpqXspy8px2FW3fF8etxQn9QkTvVAQRgvg1v0HX6iX8EccoSwyNmMdKkjoryxMV6KgM
         7k+4IkSn1s9hRLBYejLkcR/uwcGpXAAqU5hVkXF+LLuj2bRE//1q5iE0m6kerKdLwXIa
         L+OAtHAaMltH33aSplxG08tG3Oy20hJpJ5CgP8BCdczBYKiPXWLFr4u0c7hdhFtdpRJb
         v8jw==
X-Gm-Message-State: AOJu0YxAGj0cwP2MxDp6O1hXA+m6erExEhAdsMeasGoX59Zkq644w8BS
	+ZXxFwzQHVVUbr0oSdMXhJY1cEoMXLmp4jRAVhkrGs+mmQYp3HI7ZLiHNTUTd2V50ms=
X-Gm-Gg: Acq92OGBn4kDLocmPttKLUNEROypG4zHXmrFsjYAzn6Ny9SKswKU3+DFmk+X/LOY2Ob
	XEU6vknIAd2g96pX2L6v6+VnjMXrKF4HbYwdS3D2vznuLU20YH7qo4/ovW8f6z08mlaeHh9ESMt
	+ri5IsrSatmhFQeivYfccWUXSieklY87hRpfrX2BppnGM25u7Rh45Peu5DzTaBPjfQodFKniKIE
	GIjhHgyaSw6GBamHN2FkLGNd+Grr3v6yONh2Dofuy2mdjqE6WD41sP/0KIkikDXRXm0SkQ/hFVq
	ULadCwKHFdVoTup7QNwJ1ENKpSymDVY77740NDLU1MXcTxza2J2evOrEOQGeSA2pNQemrPIivzq
	7kMfG1sZz4SQ7Xmoqwevyqp/XIlsM7D+4jyYU53WgMpCAaRYXhMFPrEpFSIC2fXTvBJr27UI7pI
	krwTdrYTiQ+alnW9l9
X-Received: by 2002:a05:6a00:802:b0:842:4bb9:5fe0 with SMTP id d2e1a72fcca58-8434cc0ae30mr152666b3a.10.1781219557320;
        Thu, 11 Jun 2026 16:12:37 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd100esm199571b3a.34.2026.06.11.16.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 16:12:36 -0700 (PDT)
Message-ID: <6a2b40e4.4dd82583.3a5c46.e52f@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Fri, 12 Jun 2026 07:08:13 +0800
Subject: [PATCH] net: airoha: Fix variable shadowing in
 airoha_ppe_flush_sram_entries()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298403-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0B7D675C78

In airoha_ppe_flush_sram_entries(), the inner "int err" declaration
shadows the outer "err" variable. When airoha_ppe_foe_commit_sram_entry()
fails and the loop breaks, the function returns the outer err which is
always 0, silently swallowing the error.

Remove the inner declaration so the assignment writes to the outer
variable and errors are properly propagated.

Fixes: 620d7b91aadb ("net: airoha: ppe: Flush PPE SRAM table during PPE setup")
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6..2b849d4 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1333,8 +1333,6 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe)
 	int i, err = 0;
 
 	for (i = 0; i < sram_num_entries; i++) {
-		int err;
-
 		memset(&hwe[i], 0, sizeof(*hwe));
 		err = airoha_ppe_foe_commit_sram_entry(ppe, i);
 		if (err)
-- 
2.51.0



