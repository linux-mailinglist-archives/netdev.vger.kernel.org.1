Return-Path: <netdev+bounces-294304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MExvNx4MH2qpeQAAu9opvQ
	(envelope-from <netdev+bounces-294304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4648D630726
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tk154.de header.s=DKIM001 header.b=G1xioQis;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294304-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294304-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80729305FBAE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26C38AC87;
	Tue,  2 Jun 2026 16:54:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8F3890E8;
	Tue,  2 Jun 2026 16:54:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419287; cv=none; b=mbDENy/KKyTZHq/Xj8GREGHv732EhFy6aXjJ+qXOlq+EcR4yClw5vyZE9Q//mtYwlK0BTiRrRaKSrN6Es6f8KNSOl9hVLz7/kBoo97ns+AImjNC/4KXlCvwZg7uCiIC0vOqgbCTTB9G1c7zQbQNz3RcrjCB2JsN2tUd8MhPf48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419287; c=relaxed/simple;
	bh=X3uWoFTL43TKtRaGf/jtjolAY6UPFdTmz02blP+KP3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBncFgDindzjcYmbffuf7owj79HBPzwPRf/4ZYx6NNfaKrCHTmQBXzU+Z9OacaszCpZDyYg7bKpVskhomKCkjWYWOIcQlpn4TEd+C2RU9y24WqeTPElEXPzoIgJVY3f+H/TdCsxJRnFN9oT+1EXr3VgZ6XzK2Y6NSFIUwT1RQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=G1xioQis; arc=none smtp.client-ip=85.220.189.106
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id B24CA2408C6;
	Tue, 02 Jun 2026 18:47:08 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 1B81F2400A3;
	Tue,  2 Jun 2026 18:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780418827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoTVEgLNauvougTiOOzgJ66IRmD3vjDkLm4JeWlu9kI=;
	b=G1xioQisIbsblKXOqfh8AgPIfXyNQRguD0CD7GejIdQVClcmscnMtcMj9oYs0VrbrvSnlg
	AiPYUjA5KoJ77Pbast0YN5IYk9dA1Q/vD4Sm4YRVPZgU90Jm7ditRkT+bjaTcGJPyXJZEC
	mCrt0eE1yEzil83rloBmj4ZKwwm/SodunJGKp4zqLpybQcC4PL4/5s6DssSsFTrHo0sOQi
	9zLzq74MtC392Fnkfjell36DCV5I83q1xSbmt892crI18VEz31HfdljMoEhKEgqHXWF05V
	FnxHRxxpNqMKEhEyAIaoH0tgzSif99eLNATtgY20BnHBSGNNDa4FnEAz5c0n1w==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id E011C2402FE;
	Tue,  2 Jun 2026 18:47:03 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Matteo Croce <mcroce@redhat.com>,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v2 1/4] net: mvpp2: sync RX data at the hardware packet offset
Date: Tue,  2 Jun 2026 18:46:32 +0200
Message-ID: <20260602164635.62517-2-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602164635.62517-1-mail@tk154.de>
References: <20260602164635.62517-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 2e1b24
X-Rspamd-UID: ed6eb1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tk154.de:s=DKIM001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294304-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marcin.s.wojtas@gmail.com,m:linux@armlinux.org.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mcroce@redhat.com,m:sven.auhagen@voleatech.de,m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@tk154.de,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	DMARC_NA(0.00)[tk154.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,voleatech.de,vger.kernel.org,tk154.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tk154.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tk154.de:mid,tk154.de:dkim,tk154.de:from_mime,tk154.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4648D630726

mvpp2 programs the RX queue packet offset, so hardware writes received
data at dma_addr + MVPP2_SKB_HEADROOM. The current CPU sync starts at
dma_addr and only covers rx_bytes + MVPP2_MH_SIZE bytes, which syncs the
unused headroom and misses the same number of bytes at the packet tail.

On non-coherent DMA systems this can leave the CPU reading stale cache
contents for the end of the received frame.

Use dma_sync_single_range_for_cpu() with MVPP2_SKB_HEADROOM as the range
offset so the sync covers the Marvell header and packet data actually
written by hardware.

Fixes: e1921168bbd4 ("mvpp2: sync only the received frame")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f442b874bb59..92a701f4fe3f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3946,9 +3946,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			dma_dir = DMA_FROM_DEVICE;
 		}
 
-		dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
-					rx_bytes + MVPP2_MH_SIZE,
-					dma_dir);
+		dma_sync_single_range_for_cpu(dev->dev.parent, dma_addr,
+					      MVPP2_SKB_HEADROOM,
+					      rx_bytes + MVPP2_MH_SIZE,
+					      dma_dir);
 
 		/* Buffer header not supported */
 		if (rx_status & MVPP2_RXD_BUF_HDR)
-- 
2.54.0


