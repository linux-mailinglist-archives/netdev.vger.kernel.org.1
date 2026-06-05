Return-Path: <netdev+bounces-295716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCKQMUSCImp2ZQEAu9opvQ
	(envelope-from <netdev+bounces-295716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:01:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC6646393
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:01:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LRoFk0pz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295716-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295716-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE7FD3063EAE
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE887481659;
	Fri,  5 Jun 2026 07:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59348125B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:57:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646245; cv=none; b=t4wA6EebZ9ghi17rdfjCOPZSq2UABAQWcEk0LSwe3rYk5gMOMJEBiFKnDvF4dbSvdhW7IL2q7QDinWAcHz3fCVrnja6g4jZXODEH4t4lTwobXgnjY5bcBWTo5v7leVFeczsJVfphmB97/e0CuRf/gKel9QicLoX5t+HmqCci154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646245; c=relaxed/simple;
	bh=FyoT6jElRNhZ/XR8me8pCu8SF+rmD4dgSDPDQvZXrZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dGOI9XpCJbHQ3E7ANpSMPHYKoMElPiZhhy0Pi2lAXwXRevCQeyNUewlTQ3o7xE7m6p+a5Iv9hXrY0494RmKCHTDaEVzmPAg9/TGzmUD3/FyyJ64KEDBdmiEa/4AACogBv/ndcCeivaXZ89v/vqHSolg1XPnOXAU3tE/hS7kbgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRoFk0pz; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so1151942a91.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780646243; x=1781251043; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypRXmfNw4AH7NGaRxQ71Nt3S+wAEO8XxXRpJWlgrK/o=;
        b=LRoFk0pzEXlI9g+wQcOHkWJgIJz/lZ+546mIf56y3vR0op0BpXZ2K37D5dGWNj2SzJ
         d3GzsLACru+w6jau1Nzo/VmfH3cDbyt+RMi3Kift9Tl0MN+6414a+DzCpYURezCuHQt+
         72psawsisQ5YnBHMhhm5bYdknDAz4Oa3dplQeQe/+FC57402ZEFeOcOsq33CEuThRTGe
         q7VJrxGIXM5oH0PG4IPENZ3kTSRQYyW4mHyvFMDzgzsx/anS7khK9AuFRvA5wVrBism5
         IOn6CPM8jwouDQRoV7/2ui5ZKMtLJfGDGQgWrtlqUxW2NvP+G09ghB1UNGhl4T5i/Xpc
         FrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780646243; x=1781251043;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypRXmfNw4AH7NGaRxQ71Nt3S+wAEO8XxXRpJWlgrK/o=;
        b=mOXvRjuraMYhvbHtneNGNcepMuv7/Ik7z2wvi+gKzrQI3sntcYgbIzSgWGywNzQjuz
         sVGUAwBiOJFGfI5BopHFQwA0FKwhmEY4K7FAEfTbqmCRpzAFZRPf/598TYM8kJpAqNJY
         AS0pPnyA0h1PBAl8mCu3rNGVkyf3BpcuQew4VMsYYjGKrHBMHIAATMh8VOKEqeaEE92z
         xu7ir+7PXYXCEoUTQVHmVA/BfJkGUYRYbEeyHk1WK0zlPn3gRowAihjl0j6bQT9U8MUk
         3HutRNOcAKypc8gstw1WbP0P96QwUol9WS96g4sQHMR3w+Rz3OoTtgUUBbXgivibU2np
         P62w==
X-Gm-Message-State: AOJu0YwoACo7UMhjVikkm+SA0IOXCorSQh1U04BQoEQEwzgC9sWibDPc
	exC4t7GWGKlHkeDV9rwsDvOrDA+J/822x3fReYHzd1XHMZT9sbYvUgmv
X-Gm-Gg: Acq92OE2OQMi/rF2c0VxkA31Imr9NbXuarMRzOP4oqZxNlXlelwAbS2eQ7mPxSIy5x6
	ezrqLeRPu3ct5qw3iYd5k18Y7jbiJTv0zQmhSBCQhtFwDdvtQwlPbD6uMQC3b26wP6Z/oNnxmrN
	1BBWrNaIK/iqbB6iLj6lurWeTddtPMicGEzWEqr73MwaIjTR8ccZAQ1EOg0dz86AQ0L+nlpY/UZ
	/iMBYkU/nudeG1Qszk5aGV7LOyAlx6xTICV89GHmSbfFQ5yXbMnbgMNRLn4jMXyuquAmau5/AdG
	3rVstAWX9sw6qn1HjXdZsO9buTq15al66LmzKJE/ImvXpCKqd4hWV81kWv/WDvDjhHvaDxrDUtR
	/ODx3734EaIkZqoeQTyHJcGKiku7ZxCcg4p3429q6qbV+tdMjrRSZi74qUUpZmi/uav109WRnQz
	EOmicWIS2pf3cn6utzRALCbQwurNvFFx2m2l/UsMrDTV+MbZouoYSo9zGh+QYIX6sQZ3JGrwKXU
	A==
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-370ee82fa3cmr2367318a91.1.1780646242679;
        Fri, 05 Jun 2026 00:57:22 -0700 (PDT)
Received: from u9dbb0cac493f51.ant.amazon.com ([50.35.61.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37133082519sm897559a91.1.2026.06.05.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:57:22 -0700 (PDT)
From: Carlos Fangmeier <carlos.fangmeier@gmail.com>
Date: Fri, 05 Jun 2026 00:56:35 -0700
Subject: [PATCH] net: stmmac: prevent kernel panic during XDP program and
 XSK pool transitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
X-B4-Tracking: v=1; b=H4sIADKBImoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMT3dzEzDzdNDPLNEtTM5NEc5MkJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAMnGDJdoAAAA
X-Change-ID: 20260604-main-f69f9564a74b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Carlos Fangmeier <carlos.fangmeier@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295716-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:boon.leong.ong@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:carlos.fangmeier@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:carlosfangmeier@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[carlosfangmeier@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com,foss.st.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlosfangmeier@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38FC6646393

stmmac_xdp_set_prog() tears down and rebuilds all DMA channels via
stmmac_xdp_release()/stmmac_xdp_open() without pausing the netdev
TX path. Similarly, stmmac_xdp_enable_pool() and
stmmac_xdp_disable_pool() reconfigure individual queue DMA rings
while TX remains active.

If the kernel transmits a frame during these windows — for example an
MLD report queued by the IPv6 stack — stmmac_xmit() calls
dwmac4_set_addr() against an MMIO register whose mapping has been
torn down, triggering a level-3 translation fault:

  Unable to handle kernel paging request at virtual address ffff8000840ec000
  pc : dwmac4_set_addr+0x8/0x18
  lr : stmmac_xmit+0x64c/0xb60
  Call trace:
   dwmac4_set_addr+0x8/0x18
   dev_hard_start_xmit+0xb0/0x220
   sch_direct_xmit+0x108/0x3f0
   __dev_queue_xmit+0x844/0xd00
   ip6_finish_output2+0x2d8/0x610
   mld_sendpack+0x180/0x2e0
   mld_ifc_work+0x1dc/0x480

The existing netif_tx_disable() in stmmac_xdp_release() is not
sufficient because stmmac_xdp_open() re-enables TX via
netif_tx_start_all_queues() before the caller regains control, leaving
a window where the freshly rebuilt rings can race with pending TX work.

Fix this by wrapping each reconfiguration path with
netif_tx_disable()/netif_tx_wake_all_queues():

 - stmmac_xdp_set_prog(): hold TX disabled across the full
   stmmac_xdp_release() + stmmac_xdp_open() sequence, only waking
   TX after stmmac_xdp_open() returns.

 - stmmac_xdp_enable_pool(): disable TX before tearing down the
   queue, re-enable after the queue is rebuilt and NAPI is active.

 - stmmac_xdp_disable_pool(): same pattern around the pool teardown
   and queue rebuild.

Tested on Cortex-A55 (stmmac/dwmac4, kernel 6.6.60) with AF_XDP
zero-copy and IPv6 active — no panics observed across repeated
XDP attach/detach and XSK pool setup/teardown cycles.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Carlos Fangmeier <carlos.fangmeier@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..a6611aee687f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -34,6 +34,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
+		netif_tx_disable(priv->dev);
 		napi_disable(&ch->rx_napi);
 		napi_disable(&ch->tx_napi);
 		stmmac_disable_rx_queue(priv, queue);
@@ -46,6 +47,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 		stmmac_enable_rx_queue(priv, queue);
 		stmmac_enable_tx_queue(priv, queue);
 		napi_enable(&ch->rxtx_napi);
+		netif_tx_wake_all_queues(priv->dev);
 
 		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
 		if (err)
@@ -72,6 +74,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
+		netif_tx_disable(priv->dev);
 		napi_disable(&ch->rxtx_napi);
 		stmmac_disable_rx_queue(priv, queue);
 		stmmac_disable_tx_queue(priv, queue);
@@ -87,6 +90,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 		stmmac_enable_tx_queue(priv, queue);
 		napi_enable(&ch->rx_napi);
 		napi_enable(&ch->tx_napi);
+		netif_tx_wake_all_queues(priv->dev);
 	}
 
 	return 0;
@@ -121,8 +125,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		xdp_features_clear_redirect_target(dev);
 
 	need_update = !!priv->xdp_prog != !!prog;
-	if (if_running && need_update)
+	if (if_running && need_update) {
+		netif_tx_disable(dev);
 		stmmac_xdp_release(dev);
+	}
 
 	old_prog = xchg(&priv->xdp_prog, prog);
 	if (old_prog)
@@ -131,8 +137,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
 
-	if (if_running && need_update)
+	if (if_running && need_update) {
 		stmmac_xdp_open(dev);
+		netif_tx_wake_all_queues(dev);
+	}
 
 	if (prog)
 		xdp_features_set_redirect_target(dev, false);

---
base-commit: 4aacf509e537a711fa71bca9f234e5eb6968850e
change-id: 20260604-main-f69f9564a74b

Best regards,
--  
Carlos Fangmeier <carlos.fangmeier@gmail.com>


