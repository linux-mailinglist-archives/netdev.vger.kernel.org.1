Return-Path: <netdev+bounces-305105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BxpxJAjhS2rGbwEAu9opvQ
	(envelope-from <netdev+bounces-305105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:08:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2833713AF5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:08:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cz1lkyek;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305105-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305105-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA9A335F38C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2137F723;
	Mon,  6 Jul 2026 15:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B7371885
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350146; cv=none; b=o0DML9N+KTc5X0MdjbGdOoMVGgJVse4NafsLuLP+joj2pQkWxyHODFvJr+m7sxYRuX5ammxxNWhuVDadU2WkXiGOhECRZr0Z/sFIbPOTpSw2aKW0yIqGIBljDbMWiCfO+xsolysJ+qsTkXct42f8f7kesx49CT1r+VIw817v25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350146; c=relaxed/simple;
	bh=t9a5ssxdpXDVyO9sUclJsBFNl0rY6QGQUgOZ+6cTNJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVFJ9/ZxjHOCjgZPQipbBrtljBd5AwHp6ic7a3jHd7hQqJYvHmpkycalBuZ5vKcb5xtNmvRd9tLyN07UOlp8L6vYsmyUzeT5PCw7U3lcqbUn+ZJOgHOlxxHOuc0PIvc9JBBWt4Ip3zENOz7sf6ZQK30iu55pGb8lQ9XmUYbQEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz1lkyek; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso37278545ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783350143; x=1783954943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx1WqksvuISZjKB8qjiAsted/XID7FOi3iV53rUECy4=;
        b=Cz1lkyek2kpVk6CMrbOpwDxJmMo3cfzI/dN7jTnBkp3/tr6GDd14k6UFgS8LgzxqR5
         vKYHlbTt0G+lwFMorCUjVro07pQbII5jQDdAh4LNqNdLm/Cgt+tTeLxmBREVLZlyQ2tO
         oE6vGbOyQ2FCkhOsFPWwP2yt9Y/UlyWuaB7mknAhNNZsQE7HMblX1c9YvECnnj7VMPGq
         FMvWGeWPDBEWMmK1sS/nIKBL8QJKbnwgpSKspBXriEVL03tge+AIOcLq6qYz5/X69kbq
         Z4eZVPSe+TuDfGOJo74y9AmVSJ0sJzSo/XOEovRDxevafMcN5jpGoWL7HFdeRWldGj+9
         qaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350143; x=1783954943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fx1WqksvuISZjKB8qjiAsted/XID7FOi3iV53rUECy4=;
        b=Z/nJkt6275WkQ+XKhcZeVscpFPIXw4+ZOzn+CquKxZaS1WK+70repReRjM8okJYj5V
         8eWi+GA9AWFnlzX6DfjzWLJNJjkMtKF33nBp8RVectFzWi+ZMlKJjpG67YrXn5aj0afv
         u0nrEzj+9AQdTbqP3nYjeQOnRZSLvjje5KVt9pRuj6CuoH5GsQDbHE3d78N2OJ6QtkIx
         XbJmvPLMzXsg3O87zaquB2jCW1sNl7pSTHIrJLZVkeVg6oWoi+cqMbYCWFU9KucBkaYW
         xGDqwd60ksdSPrjeEVvTP8Caah/zHyYennH9Z4Py5EaojvGlrip4bFt8bhpJZy9Sl0bZ
         9oQg==
X-Forwarded-Encrypted: i=1; AHgh+Rpl30LD1TfYoyRMEDuaFnf0cavENjFM1h7WbG/7VGGN0OeYpYw61eerBbcrQ5RXT3+FzxCEhCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7I3XXCba9E2guE4fF2tq3qek4okTRtYZ1ItRr1WZ9XLFpzq2
	BKB91Wq/bYDZVaIXeihnzUsSBkq5osco2lMpfU/kn3suFUUHFFpHu16m
X-Gm-Gg: AfdE7ckSXhioar9Z7o8onKCsRRI4eAsPJ3pFxrfCcga/4o2Gaa8CVmy9DR0qxJaLBEQ
	rE//zL2isVQZYWhy0k8cbGUd20uc1iJD2MEy2rCbAlNrcdd7w4TBRdJEWKYHNL2Iia2+31KMnYv
	wa/ANjT0yrO8b4MGOlffRuqK6UccwbzLdYsX4OvFJrlNUltUUfzsGS7brfNLzZ6R4xpDwvmTHFc
	ebuxlk3opfJmRzTGXwOP/zNydGEVVIhldZIkCy9MllQwfz1hPdivKVQ+7Iav3AAVwSx5C2eUcEw
	gs2ZyYIPxUu4Ii3CemPDeYlGGN5+zwb2/8hLXTua4kzNBQthDdhAmu182TxIZNZjP3rrHZ4kV+Y
	PNsJtvxjiM4medRly7GTua7CYZrfPL52dwJfvizdhFs94J8NRSswMA9b8TwxjDrJmhqNONwBURa
	mppVssB0lu+b0y4pkiVOzNUak9os9UQWmLjPHWxQ==
X-Received: by 2002:a17:903:4b08:b0:2ca:7131:cace with SMTP id d9443c01a7336-2ccbf07a420mr8997815ad.31.1783350142309;
        Mon, 06 Jul 2026 08:02:22 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cb3f5b7090sm41651765ad.26.2026.07.06.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:02:21 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/3] octeon_ep: fix skb frags overflow in the RX path
Date: Mon,  6 Jul 2026 23:02:06 +0800
Message-Id: <20260706150208.2944898-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
References: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305105-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:sburla@marvell.com,m:srasheed@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:lgs201920130244@gmail.com,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2833713AF5

__octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
one fragment per buffer_size chunk:

	data_len = buff_info->len - oq->max_single_buffer_size;
	while (data_len) {
		...
		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
				buff_info->len, buff_info->len);
		...
	}

buff_info->len comes from the device response header
(be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
about 3776 on 4K pages, so a full packet yields about 18 fragments. That
is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
writes past shinfo->frags[].

The fragment count is now checked before build_skb(). A packet that needs
more fragments than the skb can hold is dropped. octep_oq_drop_rx()
consumes its descriptors like the build_skb failure path. The same class
was fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path").

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index e6ebc7e44a..bdbed58c7b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 
+		if (buff_info->len > oq->max_single_buffer_size) {
+			u16 data_len = buff_info->len - oq->max_single_buffer_size;
+
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
+				continue;
+			}
+		}
+
 		skb = build_skb((void *)resp_hw, PAGE_SIZE);
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
-- 
2.34.1


