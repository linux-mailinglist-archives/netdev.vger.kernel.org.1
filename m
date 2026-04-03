Return-Path: <netdev+bounces-274873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJEFOAlDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4D390E8C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B67C5305440F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E631207DF7;
	Fri,  3 Apr 2026 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYFdhxSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A344351C07
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190766; cv=none; b=TZ6CIvefYLyKf8jgbqDt94SbyNfsTODtPH0jsxC1OzfC6v37iUgXhM3mlMqd35mDPdB/AIWOfMrzEcWTdhSQHEhIVIl2tHXAeqSK4Vr8BydFk8Q6+Xlme8UL7ygsx7drxT6ZE8/JQKn/c+IOj2RiOAuRCOv2iEOnDCo9Uh/ltjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190766; c=relaxed/simple;
	bh=EpH/bS4jg53Llt/Tnf1s507JiVfeG0cNOHSwzaDVIVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgCk9qA8Bkiyt2XWzlmJM1aCE6WgH802ew0BC1DNstHLxVk8D42qSbt8tj2l1L+AjoHOenIoP4v+pqOibg02/rHhRDWqZKQIyozDEWvdjqkQChlwPaAn/7Djh39rWbDbC12yJhILA1CHOxsgOwhxFO0SWReQiBigBPIZiukfL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYFdhxSK; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d5e32bd79so16944441cf.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190764; x=1775795564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjJ46q4Xd7tkQ0VssEktFyh13ieG64mYieciEu8sKww=;
        b=KYFdhxSK1mVAAUMkGRtapr+es8MGDEzRZ8Qc/25DutOs79eMULGwmPJW1nli3IxfKk
         ffjpYmzQLn/yGcalRPrX47aTuxysmVdcGFwY8HznpZGIieqG8B7aqj3Guzulp4y4iD0j
         wHzaXQAlcEzXlZ/3XrpRK9MiRzFMjIIq1alZinfJo5TM32l7bomvt+O0J4r0k901zMqE
         4w/cHOc/unYlONPkb3bTJEwCgWirpM3+zSDlz19Q+QSwwQCyBuVtG9E/tZ6/ojzZsdkX
         gd0+jvC0SS1UTKfn+Pl3RHMRr2JJys4ite9TmeIXsoG2Xfl4ZZNBL3Tt+Lguubr/NsSg
         FrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190764; x=1775795564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjJ46q4Xd7tkQ0VssEktFyh13ieG64mYieciEu8sKww=;
        b=DWafNBAjAgP3OLvJ6mY2zzUasATOOfMdqdP+lFSTSYOYg8vc9R/GEaRP1PW03AufRH
         8frv30jZxziduAQkk6yT8oxNrjNHfS3oujZhEXIR3IpP8ROeJ85FdhoFGmJ7P+oiIN6q
         HGBnI/BCKljBwu17WnP//UBOCKMhvdt11wMU32X8Y7kqK9obEZ3VXfTAE9HNzqGUpZaM
         g2CPnJxa3atpowQ1ZkTDEZ8aLibBovu790ggB3idsVurESUA3YJGqlUjaBS59Wh4ZKff
         9pVnRRfJ9ajRBTZjzcqZM4KoamYp8DRa2mZeqKdxqWc/B+u7FV3PXa3ykxH8hB2s2Gsl
         Cmig==
X-Forwarded-Encrypted: i=1; AJvYcCUxKYWR34/Raxr16rqWTew6a4A/paaF5bGUCfZmpp564RV9EwjHa5QKkPJ4QmmRYV5Sz178SCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykqwwXLddb25fcndXe4i1IWMV1+ItGKBj7vrJbwgL3NRU20HA
	7guPXV0tFoWDxzve1L8SX64fSbR8wJm68XRrUTPFXEI0HOB75aHvbDs52ewNTpSCrv/XE9hYvU1
	iw3rMlYYG7SCmtg==
X-Received: from qtww20-n1.prod.google.com ([2002:a05:622a:6854:10b0:50d:5d96:5257])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5598:b0:50b:3ecd:ed29 with SMTP id d75a77b69052e-50d62c31ff6mr28366691cf.34.1775190764044;
 Thu, 02 Apr 2026 21:32:44 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:31 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-4-edumazet@google.com>
Subject: [PATCH net-next 3/9] net: thunderx: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,marvell.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 7BF4D390E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 4863dea3fab0 ("net: Adding support for Cavium ThunderX network controller")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 2 ++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 1c183827cb9ea1a628433972cb6cb808a5f1cd69..e953b8e00ecbbc30d2b011ee24522445407fc7ab 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -19,6 +19,7 @@
 #include <linux/filter.h>
 #include <linux/net_tstamp.h>
 #include <linux/workqueue.h>
+#include <net/tso.h>
 
 #include "nic_reg.h"
 #include "nic.h"
@@ -2077,6 +2078,7 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_open		= nicvf_open,
 	.ndo_stop		= nicvf_stop,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= nicvf_xmit,
 	.ndo_change_mtu		= nicvf_change_mtu,
 	.ndo_set_mac_address	= nicvf_set_mac_address,
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 062ac4a5fa12d83d7c83f854996950a7a501f1ae..22f147cc5afb54b19f0fa2e507b28b91b2ffbb0c 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1492,6 +1492,7 @@ static int nicvf_sq_append_tso(struct nicvf *nic, struct snd_queue *sq,
 	int hdr_len;
 
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
 
 	total_len = skb->len - hdr_len;
 	while (total_len > 0) {
-- 
2.53.0.1213.gd9a14994de-goog


