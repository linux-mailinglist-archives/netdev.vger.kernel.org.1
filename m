Return-Path: <netdev+bounces-306944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cZAxOjCVU2omcAMAu9opvQ
	(envelope-from <netdev+bounces-306944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:22:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFD744C7D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:22:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lwGd66Lo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306944-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306944-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0AD301C3DA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048439B969;
	Sun, 12 Jul 2026 13:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA0301468
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 13:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862569; cv=none; b=tGt2YwQa2P5XJcHHzh43MGoxHiuEZIvDvqrQyBxkyP1791XRWcLyjAm88j3V5Oa0I1MC6gl6igLLTEcNlgO53mmLjU8Pvk12GUeR1eU+mNlCwaVGa1GIDre2IYSdECkv7ZTWV48Ytl7jFyRAVjJAz74CYmnTYGBMU1Ui3+u7m/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862569; c=relaxed/simple;
	bh=xAwWrn135mVWGuRJMRuBayOCkroezRocDlu6CZpN8Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipNsiswRD1xbTrzq8GxjDS/fKloSNEimSYzN1kDKn/PxfTZbSwXLTqNvnQXoJXWRnb1ED8xnqqcTemdLf1k192561dKP6GZXholJoIWVm3mK3QucbT6scaX51oLXshn1NuiHOSCKUWbxuvxJs4bXo7ZetEPofX25kUYExDpwWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwGd66Lo; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so8584335e9.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783862566; x=1784467366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
        b=lwGd66LoMamqnIsdxcCBSbsxNB6gIYf3m3vmJmXe/TYUwBmVoTkA1QZ6iD/LTm6BS9
         9gM/tmdCkjAHHHlskU3IKfeMCIrvuQ9m1oeqWN25I4G+6oPUw3Y1BUOPgD0EUX790wbK
         eqAxQVrjbNaUIopyCcrBK2vi46BeBuSaBLCEJpkBSbMXQVE9iJDOPUt1+V4SBfuMZX4o
         wQgDBdsE7OE9mrQCxt0S6f7kA47bhI6UU2tzxtNa6e0solnlmWpjRWk9urmamJVgPDOt
         PdFtLOu9YVjSPYnlcZ0GJKUJ4U0zHxLQvyjTvpMUOwPD5D3H/eKTXSEe6qKstRkHuCrJ
         kAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783862566; x=1784467366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
        b=Va+LdhS8nl7VetT+XRDKXCkTTxWEOzy6Q72dCngnUriTTJlLcX32HBbzP+QJPzlVts
         HwoKXDDhhLUkSBQAmlAJHBKaDsMhEnBOjDk+R8XWY9tGkYtLKis71wNpziAjFuzik4JW
         KYf9xiQ84EzJc7Urspmnc0Ny0ATXzduj1gM4m0Ology/mdBj/04Ef9NR2PtpZ/E2Z8g7
         OjqRVNM4sdfpP4ZmHqeDgmtwV0xu5QTDV/lUQ22JXBeGHuuQE4VC3FIUXlAzyCzcx2qt
         fH1LEK4HP5QwnNZFirlx6G65MmqW6+IAeUZk0Ke9lrjCvWWZRLoHM3hXkRD3oUoZJp/x
         q/5A==
X-Forwarded-Encrypted: i=1; AHgh+RqjVlpJ0HEQ87p8/Byx+NROks4xaOlFKS3CXYPzGkAfdeTnNrnQt1xXalCvUBvr2IlJC4jXoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZfwOEGBvMZvTAcD7q3X9WI26r/p1PK4Gju8TQ4ALk7g08JlP
	KOykpOHD1iKdFqA2pJb8C97Eu6DtT7MNZaJJWTG4mKMwcfsQCB6rNHun
X-Gm-Gg: AfdE7cmNDnN/IaIjr6CNjoy6tXuUM/QRB1waKV1X/l74JqMiTw3/Qwq9cSZ9TaXjpPJ
	3/d9udXavTe14/LypOEEAykgiCZYhcshhkTLIZ3PYAMJR7C4G+HP5+OrDa7vf7Bu3LxSlmG/fO8
	sHb0W81N5ht5wX4qjlCCrOqeA6FK5qdDfWNd39skWAi9E5AFl10iYerCE6vZaqvR4TZrtvABmgI
	78rcQL+9ZxR0OitpEfkmp+J8i/0uCkqJgP22vt30gCMc8bDI7c9t4jJEsXJyAgZQkIpB/YYjw0B
	VeKVzKh4k9W6T0VW+feLISA6A+JNgU2eXmygmDYQHdOrkC6IGRNPFPnigHDwxnYoHkGzBFK7NSu
	YdNY6lUyL4R+z9nHSjSUUXgxjrxMpCDVkfWenLPQi7gHg7ZUj8OI0yBAse9+I/iHZ+dRiQYkbnA
	DTJJ4f0cGtmmSrPAhEmVuZvsDa+Wy9HPrSoP0rfWuo+MnHWZW7ep1UybfLL1+RKT5gL1Ydyipo
X-Received: by 2002:a05:600c:8b52:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-493f87f3cffmr58484955e9.17.1783862566268;
        Sun, 12 Jul 2026 06:22:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm180883955e9.13.2026.07.12.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 06:22:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	aleksandr.loktionov@intel.com,
	advoretsky@gmail.com,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] igc: remove napi_synchronize() in igc_down()
Date: Sun, 12 Jul 2026 14:22:42 +0100
Message-ID: <20260712132242.223254-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306944-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:maciej.fijalkowski@intel.com,m:aleksandr.loktionov@intel.com,m:advoretsky@gmail.com,m:stable@vger.kernel.org,m:devnexen@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BEFD744C7D

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..b3883a5a7d7a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.53.0


