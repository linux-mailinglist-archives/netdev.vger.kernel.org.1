Return-Path: <netdev+bounces-268329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOFMNrqMuGkhfwEAu9opvQ
	(envelope-from <netdev+bounces-268329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:05:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775B2A1D38
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF42302D5F6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA537703B;
	Mon, 16 Mar 2026 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKIZGXPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0322874E3
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702281; cv=none; b=QC0HZwJpHg7zXG7wdwhzozHgjVijHLhWDZE3GvN/0LdFbY1KqzKBjOoTztOLX4XvZOtX5hgVHB69AXCfox2Ou0H5GRAx42YxjtQ95Pjfsuzn9nh9E8ndA42STosdwJDOhJzx2edL/UEakbh+yd84jI2+xo1Cc81eJ5t0fXaIIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702281; c=relaxed/simple;
	bh=e/UJdbtjfIAWPFAbM4sh8O6m1MaFL8Rs759mJkAnoxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g/JJIJEXKDL4sF8UA1DgULFy9uZHgFaMGe8LDLWZFp5xfuh7ZZ18yfMwwdGMFCYI7kq5f3idEMViBsAIo3gaMuqsBFiATRJsbHa/DGdGL8/n5LEtegWCZHrZDBGzwJboABXjbv9SZUol9ru9cXSRcYh8hutQztMrsVXOWfFwbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKIZGXPU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829b7ed8958so17574734b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773702278; x=1774307078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2YG2oO3UdAqZk7gaMfdq/iHM5U3MIRMYZTmSCx+DiOk=;
        b=GKIZGXPUjqC06FjPmnrt+J5u20iAgL13bKOqowx9YAK3oqKHrdpBtm40cAgMOksH2N
         6NspyaVAZLEQrJWhYIUaEOOBRfiWdILgwVryHUaSSfOMXJt1Fj/JjpR/yfSCculgcjOs
         wTXpeHJzuJdeSrFV1SPNWpik2I4ZdY20jitwXQwsm43xywBGEpjnlcd0/w3Y/KMTVXnN
         TziIEtKaTRpfc3PTCmghdacSY/Vdh+fMgSOpb8bV4MMkmKaOUIMWMwFwnLEvkUEM2vAy
         PgeOpj4O8yeB4RHA8pnA0lt1MGYxFkN8BtDeUQdYddESi/7WIduumz+4arrdmKmS/Ig7
         oQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702278; x=1774307078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YG2oO3UdAqZk7gaMfdq/iHM5U3MIRMYZTmSCx+DiOk=;
        b=AE3sEcg1HoPjEx+6lXPOtNDgvlKi9Rwbr70dZscVMkzua80fwcfDoNktdW9vOX0jvX
         e6sUF1vZl29NNF/WxJ+FV5KndDhZBDQjfLa/SICQGTF1Ddf3XFZAVWA/VWhNKJE2RqYI
         9Kf9+dEOp/MM3zIhrP8/vdnzScfGL7QasCm5CYHVwPtYfyI+76k+sQ7o3O+eA7fzuPpx
         L9EwpSl08wVmQtS/ZLnQ+qky0U3Be5dh3+X6iShvWOIa6H0bJear2NX8FgkDjOM3kgxS
         P5Aw9zr+5nmvJchEwVI6YlbvR3/qDbz+gzyxRSWSBRW8i9uFOtWkcN+0JZ7nWxd/wLkY
         0hrw==
X-Gm-Message-State: AOJu0YwDafVsE5j9PifR8m9Ic6SSwe4O5OI7U6Dl4m5eN8XMSqhSMEOS
	tdmcHF8xgAnkE1m+HteHldD+Zu5V3ADE8iZsMVXhZBISI7XS3msRUKM7SLOjuLEUZ9zrO1VsMAh
	XYO1ICdgWn0Q+7uUtwGhLn1iiVGgj1XFG58ZpuI83WzRrw+Y/Si6Zs2pnTCA17Na3ZEi1kJjCml
	lim3Rm1B7g4sFFlShTIDbpIAfeQVKR2/zWudqkSOtMhdg2qSs=
X-Received: from pfbhu32.prod.google.com ([2002:a05:6a00:69a0:b0:829:f706:70e1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:9062:0:b0:829:837b:9068 with SMTP id d2e1a72fcca58-82a1987bbc8mr13609230b3a.29.1773702278077;
 Mon, 16 Mar 2026 16:04:38 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:04:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316230434.1398828-1-joshwash@google.com>
Subject: [PATCH net-next] gve: add XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Tim Hostetler <thostet@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8775B2A1D38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit daa7ff1e1269 ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
exposes support for the XDP RX timestamping metadata operation in the DQ
RDA mode. While the operation works on its own, the intent was to enable
XDP metadata support for the queue format as a whole along with it.
Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
This change updates xdp_buff preparation to set meta_valid to true, so
metadata can be fully used by XDP programs.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7924dce719e2..48945b4b6766 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
-				 buf_len, false);
+				 buf_len, true);
 		gve_xdp.gve = priv;
 		gve_xdp.compl_desc = compl_desc;
 
-- 
2.53.0.851.ga537e3e6e9-goog


