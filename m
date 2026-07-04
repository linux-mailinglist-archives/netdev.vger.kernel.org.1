Return-Path: <netdev+bounces-304688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iYIXOFOlSGoPsQAAu9opvQ
	(envelope-from <netdev+bounces-304688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:16:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D630706DA9
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p66X7s8F;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304688-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304688-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4060301454D
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 06:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A366388863;
	Sat,  4 Jul 2026 06:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCC3559D6
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 06:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145727; cv=none; b=CPwpLiK+X+h5uCMUBmh1A/fa4kZHKPuYja1lDk9y7XczNzMnQj2r41XxdEMmI+ovxKoFPOv55ZyqB4+6rgOEmUWne76BPS7MY1DY3hHcVc2I5EZTQ1K7BOOwJ0byyu3DjmAHGL0Ah0cncYFuNi99KiJqfTTSjNkvp41QQlGgufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145727; c=relaxed/simple;
	bh=TiLsgiF9D1zaS0XWGamni2xuyhVi0f9tNKG3ox9Xkl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3xvd1EBUdUBKr2ZiW/DsJ5djH+Xe8jQYQdFwrrm0VeyzpAMbOMG8WuTtyF3Q34sVpkG/2zksT8qg9FW3WKiuWlFbfTW7UiuQUIePY9N0FApzBeF8HqY2vgr9iRou+rgJXrWK+8aznBOHvpexD/UG5V6Cd0WZt5pgd25jLMt/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p66X7s8F; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so1304005a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 23:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783145723; x=1783750523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1QMnSMN4LeVAhN51TBt+vF95rU9z7m18HWe4vyd23k=;
        b=p66X7s8FPgESfMffAGdIainaXdxr9z+bx/qAhXt3uMMQ1/ge5ZUxFA/DZC9eb9/BFM
         dmcMh2WHr3eXCENk6N0P0mULqrxEHtuOKcld/JsQUo43WyNdFUtOp1gXjNy8iKg2fZdU
         R4Os2+R8LZFP4Ggma4kIryOc6J/VPcPAjuqhAOfHTsK3WrshWeYUb5cd2xBWRfQkZH0i
         Mq64r86ADZYsfzj2jVONBHg9ny2hmKs4eVmEiXQWe/1lqOzTl2NkiDUHQWLZmCFdgOrz
         7Ek6xzoUhWlAEXhfqgHW/3ZW5A9qqbI6ll3hqAk/QeHFrM8ammRIqbAvOxfJZ2pSIMlO
         7iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783145723; x=1783750523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1QMnSMN4LeVAhN51TBt+vF95rU9z7m18HWe4vyd23k=;
        b=Edx4tuQ7uubiKWFKarEaLWX1+zbOBJenv7rz8Ea75lzt0A8U4tkFlkXnjIpu2wXwXz
         IwQlACHoPxbYjoeSqTnTBGFZInJ5lOzKfWEHqtLmPGvABPgAcwQfq3gfiA1hbDN1OX3r
         0v5ftDk/TypzZClnu93Nx/dRZh0Psxc6L1a8Iy9ONgGTvz4f64ISqC2OQdpmq/IaaHfP
         CBhmGkUR6qPTIpVrERpFAYW5+yOhp6LupGBGLXBSAQexra4V1ZFHvFOHV2CqbfvvzcRT
         /W98pUKIcjvNDLQoiH66k7UsJCAz1hgFNwIFeNGIydM70Wq47UThxWRRoqMgbQZQRaNU
         8kyg==
X-Forwarded-Encrypted: i=1; AHgh+RquCy5JcL4u6bFZnTbcPRp1mRjQ5XaNRjSxb7mLJ3em3TOi5B2SLfYbSbQOTHqJ/RDG5CZmUSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7++qbAE2ckVyNLcbRzyenUn1zL3fb8iQnTq+BMzIyWhBwX67
	sLEVhWiAU93LX9d6zkLHELiMdKbU40i0lbcQkqwXRTsN6u8W5FnXVbOw
X-Gm-Gg: AfdE7ckrY8W/hO54fHMYdvwjeSn74i4ocVDegdDEffvkxjaf2DHOfCTLvalB1HcLQsY
	9UQ/rF/67DvMLDpzq2Bo4sCrYkgYMsTVjojToY8YzRcUzJHgBDHUwhgmU9X95/NIz+aSlcbRmc+
	GgvH5dSvobxcojKDW6uXFSQSWmziBcla5dXwAD4uOXxGZjL5dv7vjM5N1iyU+T28kvIlS/dFQjo
	xDBh5tLT8tSbpUL7pGlFF5CQjNyPgB/+VlQkLEttc7fnLX1HvsVZGK1VSV0FAMfCnkmNW9bE/uW
	+i4/hSsLS7rFT50KqxqMAGcQ9NpkRA1xbnIt9dYPzUyiA/LeSrqls0T1klcynanaJz5s/u4iwey
	7qj8D1nsQlPeighpe48C4HHKcApcPIEjL1+RFX1+QQMsReMH0SkeUt+bL0wYtI775t3wYkIzlfu
	h09d1vMwnokNAaUhafeKM17Vdr53liixFQ9G0fpQ==
X-Received: by 2002:a17:90b:2743:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3829ef00938mr2430492a91.17.1783145723348;
        Fri, 03 Jul 2026 23:15:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae6e2bsm1983825a91.2.2026.07.03.23.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:15:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Sat,  4 Jul 2026 14:15:11 +0800
Message-Id: <20260704061511.2350737-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
References: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304688-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D630706DA9

__octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
driver. buff_info->len comes from the device response header, and one
fragment is added per buffer_size chunk with no check against
MAX_SKB_FRAGS. A long packet yields about 18 fragments, one past the
default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
shinfo->frags[].

The fragment count is now checked before napi_build_skb(). A packet that
needs more fragments than the skb can hold is dropped.
octep_vf_oq_drop_rx() drains its descriptors. The napi_build_skb()
failure path now uses the same helper.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 46 ++++++++++++-------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d982474082..aa77b673ae 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -357,6 +357,29 @@ static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
 	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
 }
 
+static void octep_vf_oq_drop_rx(struct octep_vf_oq *oq,
+				struct octep_vf_rx_buffer *buff_info,
+				u32 *read_idx, u32 *desc_used)
+{
+	u16 data_len = buff_info->len - oq->max_single_buffer_size;
+
+	(*desc_used)++;
+	*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
+	while (data_len) {
+		dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
+		buff_info = (struct octep_vf_rx_buffer *)
+			    &oq->buff_info[*read_idx];
+		buff_info->page = NULL;
+		if (data_len < oq->buffer_size)
+			data_len = 0;
+		else
+			data_len -= oq->buffer_size;
+		(*desc_used)++;
+		*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
+	}
+}
+
 /**
  * __octep_vf_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -431,25 +454,16 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			struct skb_shared_info *shinfo;
 			u16 data_len;
 
+			data_len = buff_info->len - oq->max_single_buffer_size;
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_vf_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
+				continue;
+			}
+
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
-				desc_used++;
-				read_idx = octep_vf_oq_next_idx(oq, read_idx);
-				data_len = buff_info->len - oq->max_single_buffer_size;
-				while (data_len) {
-					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-						       PAGE_SIZE, DMA_FROM_DEVICE);
-					buff_info = (struct octep_vf_rx_buffer *)
-						    &oq->buff_info[read_idx];
-					buff_info->page = NULL;
-					if (data_len < oq->buffer_size)
-						data_len = 0;
-					else
-						data_len -= oq->buffer_size;
-					desc_used++;
-					read_idx = octep_vf_oq_next_idx(oq, read_idx);
-				}
+				octep_vf_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
 				continue;
 			}
 			rx_bytes += buff_info->len;
-- 
2.34.1


