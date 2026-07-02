Return-Path: <netdev+bounces-304252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id smDHMcuoRmrVbAsAu9opvQ
	(envelope-from <netdev+bounces-304252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:07:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BFE6FBD94
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bz03Fj8z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304252-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304252-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0F1C308DCB6
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82F39A80E;
	Thu,  2 Jul 2026 18:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC143A718D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015533; cv=none; b=D99UwLKB+CkusLLMgfAScSNUyx7Uhh+v1lMoEhQ0jiXAU5h/7tgkJRLIhf25xpgeL48qKmAgt+GuO/WuqSP9gXCCjJHKVqdjIBckLLoMGP2dSr/OFaFo9vtirp2+ySCktlSQOVHA3AoERxsx1R8uyjJhKRfXZciPFsyHAr6mmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015533; c=relaxed/simple;
	bh=JIoUXlQepeQ3/b8j3T/tXuyELWs+N9uk25RZYtoDjXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKVEdgVq88VTAqYl29JvmfhWqKHzWh+Pu++NPmu6edAWquk4+SFFNCsneOeVIuYK8v/Vj2POkhhiiMBBUnZ65Eej9XcUu4R4Y2eBMNGPSspPD/06EWDW94oaj96spTAtmeRddBzb2yo5yooBlEbASFAi0pEr+IIWup/zcQ8R77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz03Fj8z; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845537740ddso1547215b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783015531; x=1783620331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3UiQpQDKH2c9n6CLAsdUQpOpJU3f54iB9ppdD3l/0g=;
        b=bz03Fj8zevfStxZJ1fBqtVHAxcHXFCLFCunJjMRC16w31mnBFK8T1gA6+BdSGSqZ6B
         Qo+llQm13WJTWujA0VaefXCNSzQvxWq0laKBTSDUcqv2JEb4mx88DYlwycmWq7IykRvD
         QfhcAQCDXHQVl386NZjArOoYpzGAtbd7DT3odUrPrtlB9Vu0RNQz9+HV1yYTOqqZ5yMI
         KxbQYkUKL/rgOQb3yZQyuRbW8ypQwxV9wjEJA7mo5FxD7W/VtrZMl8ycsou9lcvchrCK
         ciUCcxefAu8lVbcevqM5wHvqhtiRRM4DWyPQdo9ZaoNyx0sjVtWDrtDeUvx3PHDOu+BE
         sB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015531; x=1783620331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y3UiQpQDKH2c9n6CLAsdUQpOpJU3f54iB9ppdD3l/0g=;
        b=e8iOB7C2xvULM8kvhFnhosMCybmW46AD9S0WJS1RFj8Se5z4DWlKFZVjDBKYqfosOS
         1ZKWDG5y7emYBppa23DKFU3n2rUMWVkToB4bVNScodJWHB0lhcAqoZICym870E64olk1
         x3eCje/AzUPHllZdz9BGF3KyisHHqN0bWrGeFjT/vV/mJK5/yCX3/arl+B1COfZ1FERR
         WLLvO+1Krqq68nDhjEcs82X6V4PBnIYNIdRqDv0xH9HNcyfgB73224ohIi96j7SKeUSm
         UCMfGZUQN4rl5PW/Ra37birNrU6GbxvnUt+y3ClVudQELf2s+qnGCIPCwl3XW/qRBSez
         iGgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C1Gt5aBFyJab+3S6eXennqUJt3yFShwff8TgN2njyZyXPvkrnwYaIgdvt1z+WCA3Tlzff6NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05YZBmdUCpf1OMunIB9NQAy7y3d3CvlyRJlxBDrw2Y+zgTfZL
	VfGx0pVfTW3Jr7cDG1V6Se3kGzPNZAf9lGKrJUCIc1foahidSHgN68s2
X-Gm-Gg: AfdE7clu53QIV1UZOSrkJ9hhWndcc8hZugAH2GQdVb8cV3EiVj+MJYWevwEa83mZwH1
	2LqTFs/GVfwCQIv6cxad8IluMWepTUs7kbLoyydC8PXTYubqy5TC/u3XVK8Xu8JxKtcLvPpExEr
	11lZjHe1JYm1a6U5ofCf00jqQSdAYQsb6zjzbYGESew4d8bD90E1x7ubeM1QrTUJbyh36eZpJXL
	RY+YVbUyNS7YmdtxYDdZIIRuEaJLCv6uwHcVLivksZN5GgKaTIx+YtN5wg+TG/8jSYLJ7SiKo3p
	++uDCZqtz22lkzSmgvk+hyXishpQMq9LFE1YGnnDU77/5rI9fLCUlXEmaauEB5EyZm5yUtXezmc
	relPs+qxWBjE+6JKK+betG8PrIOGUhdql0WYDLVCNXLmDJYdzn/J4dnaSWK6DGEACa9coTwpvdb
	o3/yMt5zvEVJeL4ixMib/imrrS6jTlB7BIouiR9w==
X-Received: by 2002:a05:6a00:b8f:b0:845:dfef:75b8 with SMTP id d2e1a72fcca58-847c5036146mr6187409b3a.15.1783015530795;
        Thu, 02 Jul 2026 11:05:30 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78d69csm1701877b3a.25.2026.07.02.11.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:05:30 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Fri,  3 Jul 2026 02:05:18 +0800
Message-Id: <20260702180518.2013324-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
References: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304252-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ntu.edu.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39BFE6FBD94

__octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
driver. buff_info->len comes from the device response header, and one
fragment is added per buffer_size chunk with no check against
MAX_SKB_FRAGS. A long packet yields about 18 fragments, one past the
default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
shinfo->frags[].

The fragment count is now checked before napi_build_skb(). A packet that
needs more fragments than the skb can hold is dropped. Its descriptors are
drained the same way the build_skb failure path does.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d982474082..7af6a80671 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -431,6 +431,26 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			struct skb_shared_info *shinfo;
 			u16 data_len;
 
+			data_len = buff_info->len - oq->max_single_buffer_size;
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				desc_used++;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
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
+
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
-- 
2.34.1


