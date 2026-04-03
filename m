Return-Path: <netdev+bounces-274879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLvWGVBDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:34:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D5390EC8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CF6E305C918
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086233B949;
	Fri,  3 Apr 2026 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUmcaVDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A653563C4
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190777; cv=none; b=XvKrx2A/ixNnaKNUsEAOvEtnRXm6YqcrObOcRU1TuS6wMovjLjnOx3A+mcG6834cD2+4tk2ergRy0fz/z4ehNrkYY7tDLeE2mhbWDwHm7ceUrgYmN7OtxaDOoY/cQUyKaDC2OYMsmf43RW5HlmPo8B56uPmn+w9wG56S+qYiAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190777; c=relaxed/simple;
	bh=gQZlYX4xreSP1RES8QoW2e27TADBjAFOVMGXRG5qKEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mev+k5ZirY0RgYnfb9kiD8i9HwdbaxrF/G8v6z/g7bdoxxuyb1W1XZGaWPOYLuf04JPWpjDf37hogE3YqZ4BFtM8kuoyg8L2xaXxIHbD+EUGcj+NVnpheLuXBTYFE1FpOBnQJKKwG3x4HqYTgETPUGumvoAFphTMDz/LzfOx5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUmcaVDJ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b802961ecso20951731cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190775; x=1775795575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFnsTopiv0vs6n83Kdz/36mXuLpNGNPfKIAXR6cRPOM=;
        b=AUmcaVDJhsYJZSGDkg1wIh+bWqm/KHRMIKZOT7uOuoDTKVODc+qcx7d+1ElYOgQDHD
         ZSR0CIXoKgIuX4LoAzH9ItEuR4BhrromlkoFczRdHmvvm7EiHPJHyFPFOR1ntz4D7P4n
         VrzGFHK0ukHePfZm4/SW1SC02G0+aLm/CZwjg4qMLcHXhryFBpN3+H0qfunDg13DHucK
         vvpDdmoTB55cw6pGk03h3H+Eim7BLeDpxE/N3g4eqc7div2YiPyJf2md5jByDwT/KLgB
         3iSQVrUFeYjdXinDXX4ADKXWlm5SfLPekk0RSaggC5bRtZbE5jEMsSG85CgN2JtcXeU+
         c2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190775; x=1775795575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFnsTopiv0vs6n83Kdz/36mXuLpNGNPfKIAXR6cRPOM=;
        b=NnVaAx+jb8j3SZto1rn5NZQe7WkepsYJqwuTEiJZ7HdGS27WnaIRGpYkGwm9B6o/Pe
         ZI8SlgUDVEFKXYUpCXM5oBQSKKawDrp6yVz34Do4r5VEddYrbMmkfg8XL5/v+o/gWea7
         9sVidwUjGsY3SKxPK43oGX9QzxnZL4Z1cV5U7Qm7T70tAaTDUTKxqKN9gLCZXI92OOIy
         WPwQ237AhOjcHmIq6bx5SdQVBdgOs/3dsxt1oUhxdrx8T/ACyLMwhylizgR+fegjeGxk
         UlckysmL9wpnc1QRAKt9m0befKKcbQUBXG3omjuRt4Sdz2iszJemyyNaLyGj7TFBWMfm
         12Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWKDza4qdNtsLSn/Die44T4fgIYmTmb71T4krIgdjZMHrECKBAC7P59BzngHCuWuX4W2V6jBiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbzJW1MzZ2CYLDLb3QoWV6Tc0B1MytxxOQbdDDT8+AtQf+65V
	LYPSHOThc9P/CanAm7CRYwRlKvH0+EqK5VBNQa3O96fYuNCWUeGBztjNSWiDx3r7YyfP5+ryzL3
	prWxzvlfF/07vWw==
X-Received: from qtww20-n1.prod.google.com ([2002:a05:622a:6854:10b0:50d:5d96:5257])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d02:0:b0:50b:2c9f:dee4 with SMTP id d75a77b69052e-50d62b4b750mr26628321cf.52.1775190774942;
 Thu, 02 Apr 2026 21:32:54 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:37 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-10-edumazet@google.com>
Subject: [PATCH net-next 9/9] octeontx2-pf: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,marvell.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: D77D5390EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 2 ++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c   | 2 ++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c       | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff1ad10a4149a065773fcd7050d970..a6cb0058603a530a11637c054f43cf0c8d129b32 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -17,6 +17,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/bitfield.h>
 #include <net/page_pool/types.h>
+#include <net/tso.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -2924,6 +2925,7 @@ static int otx2_ndo_set_vf_trust(struct net_device *netdev, int vf,
 static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_open		= otx2_open,
 	.ndo_stop		= otx2_stop,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= otx2_xmit,
 	.ndo_select_queue	= otx2_select_queue,
 	.ndo_fix_features	= otx2_fix_features,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 625bb5a05344c0b6521c28fc28e7390553bc8f84..52cc122bf519589ad0d1f6b079bc3da03063b2f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -936,6 +936,7 @@ static void otx2_sq_append_tso(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
 	struct tso_t tso;
 
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
 
 	/* Map SKB's fragments to DMA.
 	 * It's done here to avoid mapping for every TSO segment's packet.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index f4fdbfba866764477d7c72f4f71da9beb0f61f5c..44ba038964e8e4b0843ac38ce9428bf249c0af47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/net_tstamp.h>
+#include <net/tso.h>
 
 #include "otx2_common.h"
 #include "otx2_reg.h"
@@ -526,6 +527,7 @@ static int otx2vf_set_features(struct net_device *netdev,
 static const struct net_device_ops otx2vf_netdev_ops = {
 	.ndo_open = otx2vf_open,
 	.ndo_stop = otx2vf_stop,
+	.ndo_features_check = tso_features_check,
 	.ndo_start_xmit = otx2vf_xmit,
 	.ndo_select_queue = otx2_select_queue,
 	.ndo_set_rx_mode = otx2vf_set_rx_mode,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 94f155ffb17f0060e1d1fbba3916948e5578e3a1..75f688013b75cda12522b1e3d708dbcc960502cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/net_tstamp.h>
 #include <linux/sort.h>
+#include <net/tso.h>
 
 #include "otx2_common.h"
 #include "cn10k.h"
@@ -487,6 +488,7 @@ static int rvu_rep_stop(struct net_device *dev)
 static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_open		= rvu_rep_open,
 	.ndo_stop		= rvu_rep_stop,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= rvu_rep_xmit,
 	.ndo_get_stats64	= rvu_rep_get_stats64,
 	.ndo_change_mtu		= rvu_rep_change_mtu,
-- 
2.53.0.1213.gd9a14994de-goog


