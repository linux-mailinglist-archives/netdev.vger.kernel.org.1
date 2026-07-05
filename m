Return-Path: <netdev+bounces-304749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m4BaHafMSWoL7QAAu9opvQ
	(envelope-from <netdev+bounces-304749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 05:16:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96DF708D9E
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 05:16:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gotlOx+O;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304749-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304749-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB1C630210DA
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8226E6F3;
	Sun,  5 Jul 2026 03:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECE6FBF
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 03:16:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221403; cv=none; b=JLQv58WweDohnozvK3Olmp8Ex73KNbn8Ne+Qal13U4PTax1iSNXeE1tTq0ELQ+Rofu0NykylsKbGlDAu9NwNkbfaZ3Dx1kP8N1xhlpBdDf5fdPF8QiITADHj3iQZIsgfZxkR/nMMDqMiFCGrAKg+7DpDVcBf25l0gaLPRpjJHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221403; c=relaxed/simple;
	bh=aHScDNt4/t5A/Co2XvOPk7VWarXz337CU5CtUW138mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAO46O7xqvlkRV+L7aGjj4t4h95fLX/oVnZ4AHnVQzZ3CSkBphUzro9u4V+zlESNV7/zje0jhJpl7TefIQdjnS0znli2zOBeuxLPKUyJ7XaHoS77fpaiONBbW+DRK8NoAi3kAaIClkrh1VsdkOjp0kanQqONq8oiZ3XdfY1VcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gotlOx+O; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1649643b3a.3
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783221400; x=1783826200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdMBF9HgtBA/0yHlO0vaoiTg/IGe3bGgmehxiViDhmU=;
        b=gotlOx+OBvHTCvDfDtsmh1V5/cGRJXogO9GslsFX7eBt4eRuXxVTpl0tsbRXby9KG1
         4j8gurqWeXG4ob5qtAFndIGFCqiJxnzjKmXhU0nraxgXQ1DYdtCHHb+KbDmOcTZv/6Fn
         wHVWdNZkpw8h61glp1LOPClOMdhaNTzx0StOywQiC0YigJuhGD8WmgyPLBIGny+5T2HK
         9PSE3+BqFDAi6x+6vhCdUJMBBFiv2OXSTDaHdZqnpp7e59RtOzpuhw7ap1F6K2L2iSX7
         nL5FLhreAhkatVkn9+PstLPBDmFkk9Ab6iHY4NFGxWxvkcf3yWbSHo/wAZz9CvJYFsv7
         PLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783221400; x=1783826200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdMBF9HgtBA/0yHlO0vaoiTg/IGe3bGgmehxiViDhmU=;
        b=JMsFWVMV0o2acDK3QLrKaoel87Et/hJNYOZYWxGIp8IXgmSNd1Y0teEOQ3aPZMkmvB
         jbOhYn3y9tA/nDaAwqeoGV9yr6wz2xGy8QE6UvkK2YZBMWQyN/FXoYu9jFAWgZzm7G8a
         m5JbwGq6npo5ZvlQPd/vqREKOkvk6JEpfqkNafMfHKm9Zc4CNYpc2cPK7dTNhDbbJxm1
         i+AxHYi0BQqbMRpnNm1i+YRBYY2kFmN8ewapBZGzoNqHdH+GbSkE8V2BRSvXhdeL7B9w
         T2ZwWpQWrt4JRIbmnwL/25r4eVrczsi+rqMAQg0zKcKLLvXQZtlBlsrwIhlmaosRVaXg
         C5aQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Fwkb3osjHpUC1SjoRgzZ3+ADnEfa74WoBdtg2S9tjygbRq9rX5yFfdAcWE2I4bHjhe0fXu5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9H+YUcVOs4L6lsofo1c1NWr1gyquBP8UdOkhtIAf25sgFhXk
	1uOWCS/eFeyPIcHpNwQ3ZRb8DH6Tw0JBHdERkXuoK01f8i0FqjsB9gfQ
X-Gm-Gg: AfdE7cm8s6wHxUqdOlo/zgva97Yhjg/5fSxmolG+qLnCAqb64fb3oylgKmBuAnwaawD
	WPNQ5YLlyR3/HfukmGDwfMuZWtJFZZekxruzK7Z5Xsl7d3F0V+aYCpM4Wzacu9H1js5UBca7RMN
	TrusWGJsjptri7KgOWK3qYjZ1F06q4n1FBl01fkKZyxtjL72/n+UCENUcOG0D86N3jrNlL5lSbX
	5OBsACWOGS/pvjRO+Np8NaIE+h9oMIDtr6UTcN2vNG8ZHYGZ3RddhSBeaLWht98NiBqCUojUyhN
	dwCOisjzOE4p/XrDJfBuUp9TiLURWML+l/GKe2bm4nfljTPMviVrpg9CRTJHW1l0l0Wx0+qvvA4
	LBTIdAWsN0x+zUpF460RtIvhs2E7IC263fRhDoMe3W20vHaMWcczVso0cLCG+N2Lz0R7owDi9OD
	6dFQ==
X-Received: by 2002:a05:6a00:410e:b0:847:7f38:27c6 with SMTP id d2e1a72fcca58-847f6f3a87dmr4488004b3a.50.1783221400392;
        Sat, 04 Jul 2026 20:16:40 -0700 (PDT)
Received: from lgs.. ([152.32.188.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dddf8bsm1832912b3a.61.2026.07.04.20.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 20:16:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] octeon_ep_vf: Fix RX page leak on napi_build_skb() failure
Date: Sun,  5 Jul 2026 11:16:20 +0800
Message-ID: <20260705031620.274396-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:srasheed@marvell.com,m:sburla@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C96DF708D9E

__octep_vf_oq_process_rx() clears buff_info->page before building an skb
from the RX page. On the success path the page is consumed by the skb,
either as the skb head or as an RX fragment.

If napi_build_skb() fails, however, the page is not consumed by an skb.
The error path advances the descriptor and leaves the ring slot cleared,
so the page is no longer tracked and is leaked. In the multi-fragment
case, the remaining fragment pages are also unmapped and removed from
their ring slots without being released.

Release the head page when napi_build_skb() fails, and release each
remaining fragment page before clearing its ring slot.

Fixes: dd66b4285470 ("octeon_ep_vf: add NULL check for napi_build_skb()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d98247408242..302559b16be7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -418,6 +418,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
+				put_page(virt_to_page(resp_hw));
 				desc_used++;
 				read_idx = octep_vf_oq_next_idx(oq, read_idx);
 				continue;
@@ -434,6 +435,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
+				put_page(virt_to_page(resp_hw));
 				desc_used++;
 				read_idx = octep_vf_oq_next_idx(oq, read_idx);
 				data_len = buff_info->len - oq->max_single_buffer_size;
@@ -442,6 +444,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 						       PAGE_SIZE, DMA_FROM_DEVICE);
 					buff_info = (struct octep_vf_rx_buffer *)
 						    &oq->buff_info[read_idx];
+					put_page(buff_info->page);
 					buff_info->page = NULL;
 					if (data_len < oq->buffer_size)
 						data_len = 0;
-- 
2.43.0


