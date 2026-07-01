Return-Path: <netdev+bounces-303616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MPEcO/z5RGqG4QoAu9opvQ
	(envelope-from <netdev+bounces-303616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C809F6ECD21
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p9V5LR80;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 676353015840
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803247CC75;
	Wed,  1 Jul 2026 11:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC49478E28
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:28:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905322; cv=none; b=qIgQaCIkgXv9JdxFy99klBRJnAxpmN0FHVYR2noGa+lWch0T4eRa8bXL6JA9fUnxul78wqxdIlq7guzwz3bPKAhgmQx+kfo2COJAZ92oU0Wzn1S9stVJye269/bx+hgGSw3kqnMNakZdqJrL14TYa1vlqdVJmG4cmGdAKDDElb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905322; c=relaxed/simple;
	bh=P8kmY5D2FfcPbtlnmqGmPWI+pDbwez4b4y6ZgebXYrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMah9KGsHLaCcdfYsE/c+HEn1+NznC3rVCorPzX0KDyELCXdiE5vGnaV4b7duop6OPTtvk2M0AjAfBE6LdRmMKDRgDdJfny6o+tOvFm9tgUwuiZlnFKJI/iLYuQLIkxSnptf5oKsjG377TAMYlSQyCLR5Xbkxr+3HnawPw4LVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9V5LR80; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso150243a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782905318; x=1783510118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkD5Lx6bDM8h0NlxCAhhMs/17IvesNqBMvWLCpxBmws=;
        b=p9V5LR80uuFqnNER9S8p2mzdU+Vh6p/6wfAUjC7duAmPppc8cUD4bECBMJWlYYVUM4
         ECKuiv1eUUW2J0fxHro3D5fYBE5W3QtkoOaq0I2zP2ZE291P6mOdJ7aGX8uaba6Sgwwk
         Itb3JzeFgVgtRM9ZKTJJYvrMX8xjCA4yCL1oxZqw76NqGFYk8gJeaX9wwGxLxSygdxXN
         K7PnCkYA4T8BuERAQAe+bWurSVZLECWFmg6oIU6qwSnoe6WJDvq83JOkW7jqvKjPAnUo
         fuZfWh4nn1H7aNw+kCcnODVD17AVJrZZQjXbGbD69jZCh9pBEv7x2lMGPgHOEYE37T7H
         LkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905318; x=1783510118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IkD5Lx6bDM8h0NlxCAhhMs/17IvesNqBMvWLCpxBmws=;
        b=IFGhKp9UDreHJzy4qnWNCJou7iLN/IvHz/nNXRTpJ+QlEZl9KWAWGn0vfKlrvJ6I/K
         9Oxk7FvCNfW2/5dExd+/jpqsa4sf8X3r1yNccPOdr1rqYkQxxPv2RncucitUvkj7N+DB
         hDaLy9gl3fVf+8TPnB4A121xmMdsMSzenKKOv8W2rsip0m0PM4/Ce6o0lOG/ZBlgzqLw
         9RaybKrQMOTJm1S5sANRJ0YIpXG697+1FTNkrhP4F7PQ/AXuXqgIILbOnXIBHeXZC1fL
         tgcS6EDcVnoOKoJnnGohSza+w9juMKza+3ieAXtLc9Moo1Qhg0eSYbtCK73aMer+GEGa
         5Qcw==
X-Forwarded-Encrypted: i=1; AFNElJ/kuIOljKiJrYCHSZAnCLwZzvBFmPxlsZkeKMROpEA8/Mc8LRSbdhTLF2NUH1PlHHMC9wF+/2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09F1aOPeoPMP7vCFVsnu6DicodPhoDdRHWdvJi2I1EvB1SN4U
	tcQFbEsQSiUGHmqY3a2a4ocBvKYO37UHorXxfznEWaIdrbWqaeS38mxO
X-Gm-Gg: AfdE7cmNKN/u02LgM4e570tx2TjuCeRndtIY0Euu++dCBfi4Gz94FKIt3p1MgQ5KgG0
	Y+/4vTKVCopku8Izc1Dnujwq0Yhmiz0qguUyDh2TLOkQ6bAy1qY11ZjfPjwPZ8LNZDaj47asAfh
	zUNimdOkoaATIYQT6giZ3kLTnHw+Sih7R7Uwz+oh+grM46MK8y+QPQ0q4X0HaxL+oTX3BMBHMF6
	kRhrhLmP1tlSEEAJSpXK/idwyfNKk+6as7KiYizVoFpPNVfWCxuldPDBjuofHGELozTkAoz8OMs
	7Zp0a/2w9ZC8hpCRmmqzhdJN5/wUFFXt+Vv+cLEypsAljHxVF2iODJt/MEltgsb0ci8l5Hcw8or
	+CAQreSBLuHkw/iAqIcOqDJ4uXqVVSyAblndHOpt2snNN5FnlYg/1McV/XdA7CQ2/H1WXCvg42e
	toI0XzDjN5mU3dDTu4NTKncJQLzJtQsJO/Lnuur/HJkWMBCyBb
X-Received: by 2002:a05:6a21:3987:b0:3b4:736b:da45 with SMTP id adf61e73a8af0-3bfed47a34cmr1352711637.31.1782905318365;
        Wed, 01 Jul 2026 04:28:38 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbff28998sm2934290a12.22.2026.07.01.04.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:28:37 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Wed,  1 Jul 2026 19:28:25 +0800
Message-Id: <20260701112825.1653044-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
References: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303616-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C809F6ECD21

__octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
driver. buff_info->len comes from the device response header, and one
fragment is added per buffer_size chunk with no check against
MAX_SKB_FRAGS. A long packet yields about 18 fragments, one past the
default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
shinfo->frags[].

The driver now drops a packet that would need more fragments than the skb
can hold. It drains the descriptors the same way the build_skb failure
path does.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d982474082423..2e666df26b4c3 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -463,6 +463,23 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 
 			shinfo = skb_shinfo(skb);
 			data_len = buff_info->len - oq->max_single_buffer_size;
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				dev_kfree_skb_any(skb);
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+						       PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)
+						    &oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					desc_used++;
+					read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				}
+				continue;
+			}
 			while (data_len) {
 				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
 					       PAGE_SIZE, DMA_FROM_DEVICE);
-- 
2.34.1


