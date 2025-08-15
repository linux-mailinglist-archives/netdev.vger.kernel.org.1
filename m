Return-Path: <netdev+bounces-214069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4BDB2811F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F90F1CE4EAA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA16930499B;
	Fri, 15 Aug 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mfj+H+zE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CJeyjDpg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mfj+H+zE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CJeyjDpg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD2304989
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266369; cv=none; b=qBcCxQthpMR6wQuHgznWC8IQrhNZfrB3gbxSdNQASrhgzKg8zC9QTXfGl14FMVWP4ulkTcdZgF6f85PtMKto8ZyzLIQ4OfrnbXk8AqD0DglwDlZTlDBeZPpDz9I5Mzs78gdnH0g3khmm7ZRKumRIzCKCoahM+9FNmmO24i4+9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266369; c=relaxed/simple;
	bh=deHMr2JjmE6UsFrr8InC++76v7x3dKMIyT+8ymrkA+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZY7A2mRbncoTj/ehZuXQUdlUQIRRfF0ERsUEw+AFkZdTH+isPzy5kLPYrhrgvhTthD2LNQGGcUDXLDQ+67Uvh0MwQWERtF9gdpqxXikkALVh7fnowJFDy+BpWmQIuMilzL3FqWpc/LGN59OYh3WbLoauUQBH+JxxVa7AbOrqeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mfj+H+zE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CJeyjDpg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mfj+H+zE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CJeyjDpg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E08D1F84E;
	Fri, 15 Aug 2025 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755266361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp0rsAEG/viIu9de1t5ct36ltQ2/DpagkNBEWfTIO5I=;
	b=mfj+H+zEtY/ToWnCNQszeCWajsAQwv547OFK4b6ZP3CdrOQxT0xTVjuCTLON0VcmG2lolo
	mgUJrG+QJP32ux9epaila6zTb6i7cEagX8oCWtJg8sycNZHK8adeIWyh9lBomc0/5/fgex
	vzJfX2lxtI0F/t8AkMvvTyDN8bRCD7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755266361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp0rsAEG/viIu9de1t5ct36ltQ2/DpagkNBEWfTIO5I=;
	b=CJeyjDpgnfZBEPHd1bwBP1y1CUD56wATnQkd+UfqtGiV3lEqgMgDAT6GeX0kGKwExj++M/
	d5HizWJ7ReKnwKBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755266361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp0rsAEG/viIu9de1t5ct36ltQ2/DpagkNBEWfTIO5I=;
	b=mfj+H+zEtY/ToWnCNQszeCWajsAQwv547OFK4b6ZP3CdrOQxT0xTVjuCTLON0VcmG2lolo
	mgUJrG+QJP32ux9epaila6zTb6i7cEagX8oCWtJg8sycNZHK8adeIWyh9lBomc0/5/fgex
	vzJfX2lxtI0F/t8AkMvvTyDN8bRCD7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755266361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp0rsAEG/viIu9de1t5ct36ltQ2/DpagkNBEWfTIO5I=;
	b=CJeyjDpgnfZBEPHd1bwBP1y1CUD56wATnQkd+UfqtGiV3lEqgMgDAT6GeX0kGKwExj++M/
	d5HizWJ7ReKnwKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AC7E13A8B;
	Fri, 15 Aug 2025 13:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mNYDEDg9n2jMfAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 15 Aug 2025 13:59:20 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 1/5] net: cadence: macb: Set upper 32bits of DMA ring buffer
Date: Fri, 15 Aug 2025 16:59:07 +0300
Message-ID: <20250815135911.1383385-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815135911.1383385-1-svarbanov@suse.de>
References: <20250815135911.1383385-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[dt,netdev];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

In case of rx queue reset and 64bit capable hardware, set the upper
32bits of DMA ring buffer address.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd..41c0cbb5262e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1635,6 +1635,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		macb_init_rx_ring(queue);
 		queue_writel(queue, RBQP, queue->rx_ring_dma);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			macb_writel(bp, RBQPH,
+				    upper_32_bits(queue->rx_ring_dma));
+#endif
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
 
-- 
2.47.0


