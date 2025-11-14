Return-Path: <netdev+bounces-238777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F73C5F534
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF78535CE92
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8134B1A3;
	Fri, 14 Nov 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3MCqg8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C73491EB
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154747; cv=none; b=NWcS1TqHNV44/oiVcXoPu7HUc4ogCvirEGlGJBt+oD1C1REQQHHy8KYJHlCHCP3RAa/Et5jH9V3SznpKeZDwIadykgdbxJGkBBwDoMoynrcSgpIJ4pE16DnLdKCjj0v2YGrwSl2d8ywut/k6vW/7Btg+nmyEWsWLtt62pw+AhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154747; c=relaxed/simple;
	bh=T6+d668CY7Ck7eZvXYmqIoDhdMFjjZNlShKvRnyo6yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XXNR0/+wknDrRpF5El0dNHZKHe0GaxBWzaZYdlf3AGu0toyFghyl4nRiXbyqwfe0v9uQ+QF+Ht2py4Xmktdc9GoY4T/HWZ/t9KhHnQ1sjDzP5t0bJumsygKxCh4KBsMMC+8O9Bjnfu6R/b33RpGiVxuJdeCT/evpG2Ayzp74DoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3MCqg8T; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso2121341b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154746; x=1763759546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmEQOsW5fdEOM8rVgZL0f19iMNBD1EWCqYTBFjDAENI=;
        b=q3MCqg8TX33FBuYmaeNw0Don1lwRfeiwXe5XqCUOd8Vm9RdZOjDI3dl/s2iq78sygQ
         OgBaep0SGsoyciTq+O8R8MX8lZDgbuL0PcvZKTdJg1lJzVcJIFqVG2OluTWpbtFx020M
         rba7H2RZqrZUW7Q8Jqf29TqbNnYNiRAbxa3W/+PuuuQ8jJWj10oZvpewCs8vDp5x6BRh
         5YpMwOxe00zAfUKgPR/yy2nxkzFP5UN23znsPKO5hjDfLzcmVDWzWwop9DFi5FDSraPx
         pT33/Ys26FULmZ95ZXUwMNOiTW2QmlNuxMM1BNuYSkHb3VVxQ3JErGY65drBGNkPFbeu
         QWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154746; x=1763759546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmEQOsW5fdEOM8rVgZL0f19iMNBD1EWCqYTBFjDAENI=;
        b=jypGih2BzFKibu+jQL+qLdMlF6fDeyw3MH3L46p5iZ7DTNhIeH0CoIIp5Jt3d8KeYD
         7OKOMLim8T6QNfUDwJd3zyWMI3U0/Pl3cu60wt23esWJAlyY6IeKdeuuZYMs/2A+E09U
         1ljQy6BmAv0JvhfVe5Enboj5/GdsmJr58GosXZ3tOfAak+y/CzQTxM3rQsZ2sbtqLG8c
         itjWU8KUhKh5YzAViNpjfh9oyIlFgkI32fZMuO0P+Vr3NXRXG8hsSnd9VVtgOJX9EGxC
         GNb2TiJFKyrGlyrfn+RCra95pnaH6HdW+s8BSjUORumbFkP4V1roLQyk8rg3bcyHK+0d
         gdcg==
X-Gm-Message-State: AOJu0YyCxyBAydTBssZeiqPECpsEqKj0qecgrgynWHfc+xkrX+GnKpgm
	5/zBpTT53Iu7gnSIunZZaaLCkwz0zWprLu309ns4fv3t4tvkVWxiLHTe2sClGF/3VcRgZI6qPDL
	U8ZOhZF1lCdvp2kgLqXTubJbbTjGN50/P92kraFGzBa2lbY2OW2c2JLHH2k9laJMmmGCB9ZOU94
	Wqs6+GrKqVtAjrtWbMEBPe6aK64F6jMZFY6FwUUrKHRoOljgA=
X-Google-Smtp-Source: AGHT+IFZzfB2L/hPLfcxvKwlFateyylLJARdQKfDv09tdbnT7hsReWajdQtkS8JbmkPJUWMTInKqnF2TjKYjTQ==
X-Received: from pgag19.prod.google.com ([2002:a05:6a02:2f13:b0:bc7:bb77:3836])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7484:b0:34f:28f7:ed79 with SMTP id adf61e73a8af0-35b9fd7be60mr5841238637.19.1763154744982;
 Fri, 14 Nov 2025 13:12:24 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:44 -0800
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114211146.292068-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-3-joshwash@google.com>
Subject: [PATCH net-next 2/4] gve: Wrap struct xdp_buff
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, Kevin Yang <yyd@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

RX timestamping will need to keep track of extra temporary information
per-packet. In preparation for this, introduce gve_xdp_buff to wrap the
xdp_buff. This is similar in function to stmmac_xdp_buff and
ice_xdp_buff.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  5 +++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index a33b44c1eb86..a21e599cf710 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -205,6 +205,11 @@ struct gve_rx_buf_state_dqo {
 	s16 next;
 };
 
+/* Wrapper for XDP Rx metadata */
+struct gve_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 /* `head` and `tail` are indices into an array, or -1 if empty. */
 struct gve_index_list {
 	s16 head;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 1aff3bbb8cfc..76b26896f572 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -840,23 +840,23 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (xprog) {
-		struct xdp_buff xdp;
+		struct gve_xdp_buff gve_xdp;
 		void *old_data;
 		int xdp_act;
 
-		xdp_init_buff(&xdp, buf_state->page_info.buf_size,
+		xdp_init_buff(&gve_xdp.xdp, buf_state->page_info.buf_size,
 			      &rx->xdp_rxq);
-		xdp_prepare_buff(&xdp,
+		xdp_prepare_buff(&gve_xdp.xdp,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
 				 buf_len, false);
-		old_data = xdp.data;
-		xdp_act = bpf_prog_run_xdp(xprog, &xdp);
-		buf_state->page_info.pad += xdp.data - old_data;
-		buf_len = xdp.data_end - xdp.data;
+		old_data = gve_xdp.xdp.data;
+		xdp_act = bpf_prog_run_xdp(xprog, &gve_xdp.xdp);
+		buf_state->page_info.pad += gve_xdp.xdp.data - old_data;
+		buf_len = gve_xdp.xdp.data_end - gve_xdp.xdp.data;
 		if (xdp_act != XDP_PASS) {
-			gve_xdp_done_dqo(priv, rx, &xdp, xprog, xdp_act,
+			gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp_act,
 					 buf_state);
 			return 0;
 		}
-- 
2.51.2.1041.gc1ab5b90ca-goog


