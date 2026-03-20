Return-Path: <netdev+bounces-270005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPemNquIvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:49:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B432DEEB4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1E6F30036F5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8F3D47D2;
	Fri, 20 Mar 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEdjGkKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD63B19C0
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028685; cv=none; b=uZqtvARFrzaX0FUM2rOtlB/00WLVEjHkBXeJEovDuYdusPUvZjTXwaNafyHWHOatyFd3PexfNeRYD1MS8Ibwa/yFs7Wq3LwJq/kXHqWEgKjtV4wtHfXq1Wbhbmi/pLce6xO6blUiVAcIVqiFWd7Z5nRIiCI/1J4dCUE4UtSqAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028685; c=relaxed/simple;
	bh=51PhM+1rugE1M8mavjx8ecQn+G6TC9gbNhvlPZroWts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itw5Ac5ZlKMcHVN/1UVmPTM94svFe/rCw7hMbciGn+CuTJWfCSZtnI8ERj4eYa+d+uiAY89zH5aBNt9nNR5slehTPZWwBSCoZ8gcyzKZzjheU7OBx26B7icD/0Jt73s2RQ0zh3HVcaX/gGkvdE5mMECRSmkJfaLcEuxqiyB+JX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEdjGkKx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b41b545d9so2674781f8f.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774028682; x=1774633482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgPKvxKeDpxvc8hHwVRqR3QcnT0iTKauWTB7yBculK4=;
        b=eEdjGkKxgs6NP7fx96+a77VOGWrnEUXlPe+Dj/WkFCBPLdDLUFuq3CKJLzZwQl3Obv
         v6yuHnpb+z5WmU3S8szj66iVDoIH7dPJh7QyqrVNpDtBMHJBTShZhFFnk10M4XqWVkRM
         r9YQEePJNsB/gbpBEDUbmyMk5dTyrAAPomCLCo60XO0Ebxina0In2DZq+Y/ejQ1sQxJ+
         9gU+DbOvGOQcC1ExcPpqxnxBgbpZw0Oj3DitbyqhUT5lNQD9jWxUze4pvnRRGoKzIF49
         4HFfrIPpqL4SyK/8rPJxBTsJqDudDaSPZjkhN4DoYf9+cCLr6kweSheLYPf7wsbT6bnJ
         S3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028682; x=1774633482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgPKvxKeDpxvc8hHwVRqR3QcnT0iTKauWTB7yBculK4=;
        b=iOFubWOkwnsoegN79N+c8d2KPCM694/+PY2N87p6AECWMvXe1PbNWtZTJeHEp+rLVd
         s2e6Yxqvff9MEb1y/pueuUvX+SEjJ/1ZkU+rvDbB22+AFM2xD8hfkwtYfFU6st2YXn7D
         eMJQYBHEj+yoyiWmzZu49eVfW6jxcYi++Ms1JQdlpjaIiXSYv8vd0n03GyKY9OeD0CrN
         5ylpDcTesxxyMybIgQMRHKe4L0VJk6sgn9elW+cHCRF52qHIhiCYqvNr0MFXC82deBTD
         nN1rFu5haHq8TA6jmuu81LBYSgmEezAqCLw2JdTRqoZuKHUVirrbisq3fXDN6qRIWA89
         IcmQ==
X-Gm-Message-State: AOJu0YwyQ12DggSf4Fqs4pWjwxKWbZoh6qHoE2s/RqKjpAAdemrCRgoA
	0VhgKieSL76i6MgM87SyAbpi/4bP9gOlI4qR8mE+cE33JuLjpQai9YwJ
X-Gm-Gg: ATEYQzy8+eJibvsv2J0z3Dvl1M6kBncvH+ESDzH5I4uzJJi1MIf+7cv5xToFlbERarK
	9FP+Onk1m3lolljlrsMxdS9HhMzsTZhbBAup5iFIG4LJaUO5gTAL6L0KggCiCz9jsN1CXUXCK5x
	JPUGFDmClC3ofpov0C5Av3zX6vyunw/bvhQiEiHrWvJhct0z2CSFr/npV9qPKGTIpiMDRr3oATG
	0yJ22jXqEkbD4wkDJJ+/gCYbjfhXM2sjG2X4pTJ/HZR5Agu6JlzPfer+mqp+KtYUP2YyRrjFqm+
	Vb1PDJphlnQHZZcEVZ4MxTJ+E/Q5XSWLhpQpeSf5cquEEUuA7Nwm738WYIj83BruWCufgIfVSPx
	rNwNq4/HgHIRaKyZgJmO4PLJ5N1NURdMIUjUjLCrBr5dz1qySWM+F2Mm3dJMjItOHf96d0csn+9
	NoNOYYmmbNxZDlbXADDiFtmXItBD479vAMNqNFyzj58jkDJvRtHuoq7FvHnfahIbWsiOx7xk9oQ
	CTFr3C1FdGv
X-Received: by 2002:a05:6000:613:b0:439:c42f:10c4 with SMTP id ffacd0b85a97d-43b6423bc0bmr7637646f8f.15.1774028681878;
        Fri, 20 Mar 2026 10:44:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0b0csm7531764f8f.15.2026.03.20.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 10:44:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
Date: Fri, 20 Mar 2026 17:44:39 +0000
Message-ID: <20260320174439.41080-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319181236.14526-1-devnexen@gmail.com>
References: <20260319181236.14526-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270005-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.760];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59B432DEEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
freed via k3_cppi_desc_pool_free() before the psdata pointer is used
by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
This constitutes a use-after-free on every received packet that goes
through the timestamp path.

Defer the descriptor free until after all accesses through the psdata
pointer are complete. For emac_rx_packet(), move the free into the
requeue label so both early-exit and success paths free the descriptor
after all accesses are done. For emac_rx_packet_zc(), move the free to
the end of the loop body after emac_dispatch_skb_zc() (which calls
emac_rx_timestamp()) has returned.

Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 0a3cf2f848a5..fd4e7622f123 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -962,7 +962,6 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 		pkt_len -= 4;
 		cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
 		psdata = cppi5_hdesc_get_psdata(desc_rx);
-		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 		count++;
 		xsk_buff_set_size(xdp, pkt_len);
 		xsk_buff_dma_sync_for_cpu(xdp);
@@ -988,6 +987,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			emac_dispatch_skb_zc(emac, xdp, psdata);
 			xsk_buff_free(xdp);
 		}
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 	}
 
 	if (xdp_status & ICSSG_XDP_REDIR)
@@ -1057,7 +1057,6 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	/* firmware adds 4 CRC bytes, strip them */
 	pkt_len -= 4;
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
-	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
 	/* if allocation fails we drop the packet but push the
 	 * descriptor back to the ring with old page to prevent a stall
@@ -1115,6 +1114,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	ndev->stats.rx_packets++;
 
 requeue:
+	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 	/* queue another RX DMA */
 	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
 					PRUETH_MAX_PKT_SIZE);
-- 
2.53.0


