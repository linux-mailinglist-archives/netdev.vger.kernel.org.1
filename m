Return-Path: <netdev+bounces-295196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E1eYEdtiIWovFgEAu9opvQ
	(envelope-from <netdev+bounces-295196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:34:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1E63F76C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pSR8395E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295196-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A32B3028F2E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86694413D96;
	Thu,  4 Jun 2026 11:31:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDF407590
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:31:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572704; cv=none; b=r6tRskTIMPwbqvhNI/DiDcEc1DTxtqvnf7pi9fBwAz0hsbe1I0cy2a63Iw2m3DGbbLx+eJfJC7EZ/IW5QLHMj0jBuO/Yw43uZFAzrAJ/XVpa2nJxPslcACCquG3TgWdpDuQM9cE5AB+eQ2UiiPgK29zdssPLuG/ArwejvcHSmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572704; c=relaxed/simple;
	bh=LyyIlg3QPX1rQJHGpgzEqbAUkTXPZTiK+PQ73NyhaYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJobvaBZ2GulXm1uDLP6Yo1zt+8YaD9lUInfyRQ+lXSRfstBVL6u/6piHKMn/OGeZmst8KHg715edOzpc7CihkdMdosKdE1yyHfv1kqYLvpjqahfgzR8OezBXroommEVw505sXuJvBvdTGgdOtjESInyViRYQtH6mC2887ZKiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSR8395E; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so232842a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780572702; x=1781177502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWJU4AISHJoKW2jVY+HLmgCpe1wG/GRzkKLWOkBA9NQ=;
        b=pSR8395EYeg876uScrRj3WexBnuPB3+AmQJttzO2xqjXClIJWFxNcK5EDBg1mmy5K7
         HxcqDZGkfbgPECLth7Y0RmlQhvoJM3LRJkS6piZOUU99xRikWKe/xfw/l4LmaKixw73R
         9unVJ/uRhnbI5kLnaVwe2PNIvhHQKWvb+De+++RwLXAlxdllDbCYN4nMGcErDp+DcSEH
         MNzyYS0YYRdA2NPPHmRxGNbuXTTqNtwg8X9KvIGQHWgCcEPIa7H9mLEZUCveiQZ24apR
         QV69GuwFDgEkuwFCKZIEy5RzeHfZWw9oz+8xSnuX0Q+vq1P/SwteIrHXQDRY92pvPNRL
         MA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572702; x=1781177502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWJU4AISHJoKW2jVY+HLmgCpe1wG/GRzkKLWOkBA9NQ=;
        b=Vbx2t49mOpJsbNL9b+XHj3Q8yzOu6pvcSlAJIHSqJJ6qmu9JPiul83bRq2LE7VszvE
         QXcMpiT+OOHbaqy58Mnbipkk715Tf20yqnJyy5pC8TDEnoq6VExaT9WPykrFfA2P6eGx
         TovY2gV/uGi/BRBADrgfOmATQCZ+0hwssBGDYTeIpkT+iNRjEv0gBLpLKeQTElXfODZV
         dycZhhRkSShAl0v05WVA92P0kpbO/y3l98/fSKSlbM9zyncV424LGtwLF1pIyZ0E7y2c
         C0NFBs2h+FOP1obj2tP0mlUEs7FkmKE/MLNdls4NlzHkFBWsoal1HsIj1EaxG/uuPPeO
         qYsA==
X-Forwarded-Encrypted: i=1; AFNElJ8bimjtfakVZQ2sUbvgZO4bSCmYXZndtzFbs5tTROLu307L0BBqcBEGWAaohoqamxD/UNdtHpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxDMlVpJsqQ4Ev1nbVf8WUMjKIoJ1Z9ES29wFf07bnHt1Uv2c
	n7wJ9Wi4iIdDEZPUqW73Tuv30KPQBbAMTTn4ZgtfSjampAAYItTiyriWSvQQM5JXCn8=
X-Gm-Gg: Acq92OG7uf/K/D29DQsgYk4zQQOVllrLLWWL3ZgUcDBlJeABOpxgKfJq/vYBvUKPnSi
	3lp225M/dN1GSMaxMoEuOWcJxFNeH/dPpAujUmRDbrmblPz74eZUbXzPKAlD/fH7JskPtroJ1SA
	YkhvCr1AGkPM+AklhsjQG8aFSfO4vyNqF4raqM4RX/ns+Uu1Mny1DkNtvDL+jP2APUvPWBKDzop
	JCumNojm5yMXd/uV9wSuv5bEfjLUPcwN8Qq5AoS4Q+uUXVgwKOsniYgKyCcuLvT2nRB50nHZx3o
	alvtHIMr87/p4TFhJ4bgSpo7UkVhIQQMlKiqlyp0YGJhgOJiLJHe3QdTvB/aB36BTx1JG9+NwU0
	RidjH1ODQ7RTTejCstl4u2qv0dduFszs3+O0bPXL011nB8Y20IC/SSirqHMugPIe8wHX/FIuYyo
	5zmVih053rjAIZKycL1Kt0Q7jwIuo=
X-Received: by 2002:a05:6a21:2212:b0:3a2:f7bd:a9a5 with SMTP id adf61e73a8af0-3b4979e946fmr8507751637.38.1780572702468;
        Thu, 04 Jun 2026 04:31:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221c3e4sm6124968b3a.5.2026.06.04.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:31:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] net: lan966x: restore XDP RXQ page pool on reload failure
Date: Thu,  4 Jun 2026 19:28:46 +0800
Message-ID: <20260604112846.1420908-1-lgs201920130244@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-295196-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:lgs201920130244@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 93C1E63F76C

lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page pool
with each port's XDP RXQ. During an FDMA reload, this registration is
performed before fdma_alloc_coherent() is called.

If fdma_alloc_coherent() fails, lan966x_fdma_rx_alloc() destroys the new
page pool and returns an error. The reload rollback path restores
rx->page_pool and rx->fdma to their old values, but it does not restore
the per-port XDP RXQ mem model registration. As a result, the XDP RXQ
state can remain associated with the page pool from the failed allocation
attempt while the RX state has been rolled back to the old page pool.

Restore the old page pool registration for each port's XDP RXQ in the
reload rollback path before RX is started again, so the XDP RXQ state
matches the restored RX state.

Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index f8ce735a7fc0..76654b44baf2 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 restore:
 	lan966x->rx.page_pool = page_pool;
 	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
+	/*
+	 * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
+	 * each port's XDP RXQ before the allocation failed. The new pool is
+	 * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
+	 * registration before restarting RX.
+	 */
+	for (int i = 0; i < lan966x->num_phys_ports; i++) {
+		if (!lan966x->ports[i])
+			continue;
+
+		xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
+		xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
+					   MEM_TYPE_PAGE_POOL, page_pool);
+	}
+
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	lan966x_fdma_wakeup_netdev(lan966x);
-- 
2.43.0


