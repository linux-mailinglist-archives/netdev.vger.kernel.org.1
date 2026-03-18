Return-Path: <netdev+bounces-269171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABjRGyD8umlHeAIAu9opvQ
	(envelope-from <netdev+bounces-269171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:25:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E092C1FC2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CCE7306DF3D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5A3EFD18;
	Wed, 18 Mar 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKa7u9ou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B83DFC8F
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861900; cv=none; b=F/w2HutxKfLbPPCHB6vnxj+dSlarC9IE0L9a79I1N03b8UPMdHi/ZoqseTjtM4u1BxTz0L9e8YykwMuDZ1jeNEEPTQO/4ZhLCA2ADiLGzQnByrc9jxsXGkxvWduSNK5kv5V+IlO5AJwTAPSK0W2/+fL8gcxrIvd7CEzPHAT2u5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861900; c=relaxed/simple;
	bh=RkL+/fE7IQQEwdkd1VfiZdnuMPwzAVXxDtxGjK2oUWE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z9i16RkkPiE2rkPI3qaor1hSHBlBdCzLxEnBgzLWicFhKDtq/OFvmGdZcqJjkALPYrcdJcBsuYf8i1NCU7aPOxZ4P4sYb3SLM1EuDTwzrq1hGHkS9YpEigjxhumHOwgr0jVILP5IC+Tgqj/uLQgH+7Pec4QwlNl7xf+1e+rhhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKa7u9ou; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a1436347eso215295b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773861899; x=1774466699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jf0AumpnbQUluz6ikgKfKkdwe9GoN4gY1bq1mNWa/U0=;
        b=pKa7u9oucl8O6ZKUy3sBTv7QvyeshiyY9hCWq42W+qJ0ABU11LatRLPMrNT1pPQ0Js
         kS6OvvBz2Gtz7ach7IyOHDMSinJQ/oMfWk4Q3FxYru4E1oyVszQPZdpNw4R2ca3d+kUQ
         /6s+Dr5CRt0A7A5fM4vyB5BpVrq8BTJb3TDgM3B3/AO4v1uLZTLKOaf1igZ+8VC5rkQB
         cdU5HvYnfRWwVaD0BJ6HfZz7FM+I45gWgyQaecIn/CsNFEErrmM+UPEGphfDrv5wCFF6
         bUO+n8kn4bO5B/WxqSvq6W+1O/XdhCNjh6q5zlpR0DoxThp5HdPtKzdK/AfTQLRkc7/y
         DFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861899; x=1774466699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jf0AumpnbQUluz6ikgKfKkdwe9GoN4gY1bq1mNWa/U0=;
        b=MEgji2TDH1E+iGl7N3/oCxocF/P+l444gkz/Dm45gPzynhqI1I5fqhBWYb0oHjcYn8
         8tznGjXd3Q+vVhIDkn/YJj4dReqwWUEbmLLWr+skkZNE7TZpX2YDRWSX9kcjLf1dygqu
         cZGH/rdZijJgo9IriC6Hfs1jGAThN6AT69ItaFlAKbZxvecdRZFNxVAzFcBHQvB4EK8m
         EdeY5heYKepAgsmNlsWA2VF6ajYNBywBblvUvh5q6URRrzxuYDpXwlhZMWh1e15HR86L
         jWbk1uTQ3K8ul2KpLIgzaMFxG6VvF9PHLU+SD2VFZbrfwziLgCxKFe0cPStvYNGovd02
         c7xA==
X-Gm-Message-State: AOJu0YxeapYoeCz5wT9ISRCwdwbkyoGG/wGzdxn2WUAZEv+75RGifQ6i
	i66CFBpsZRKTz/YLqQVR52jnivANwHLYGIwGkwLZDyt+CMLZcK47Vyl6rB/sOU+SsKmtn0NH0vl
	bws78oA0KkqJ+SX0A2MPtz9j49npaJXXClnXZrudEHNXc/l0qXlnjD9CFSIf+37ig1mbIesPwb1
	GHVco0g/f1IT2BLOoImfaaTO4lri4l8A2AnLjAHZU6WI2rVPY=
X-Received: from pfbbw25.prod.google.com ([2002:a05:6a00:4099:b0:824:9ab3:ebe8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:158c:b0:824:a1c9:8a30 with SMTP id d2e1a72fcca58-82a6acbec8bmr3409789b3a.23.1773861898553;
 Wed, 18 Mar 2026 12:24:58 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:24:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318192450.3400774-1-joshwash@google.com>
Subject: [PATCH net-next v2] gve: add XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
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
	TAGGED_FROM(0.00)[bounces-269171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.782];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3E092C1FC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
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


