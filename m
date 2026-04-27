Return-Path: <netdev+bounces-281284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMYmOw4w72mb8wAAu9opvQ
	(envelope-from <netdev+bounces-281284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:44:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB7470167
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BC65300693C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE363B3884;
	Mon, 27 Apr 2026 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGYJNxCu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD33B2FF7
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283078; cv=none; b=KNBpHwHjF++pJ53zo/eESDIG22Xa306xC2mUPJX5jOsTLmYKSZG8e9CcJAols1EbX0O3gLkogQ0n2J9BbFzJWhQFjOWKqIkrKuYqRe9PtM3/r54Y1mcRrSa98fi74hCdmMfckyr4i8MskiaWTcQOAWtPvLTbzIlBaWDwywyLpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283078; c=relaxed/simple;
	bh=YdtaQUlsZM4/WEYiUSZvYpnVG2bfZZGzoTMN2Z1MNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urqCW2XQ/MfDgXnZ7bB3Th2/ia4lcc8OO0WKAnVFLyYDXSAXcl5XCjCaKg2GT+NZTjqhUJO17hOf6+4vZ7MhBAW/94xC425Y15Bu4COwSaXYGIOuFeizzM+2XHt/2x4BL0D7cwhwsANg164rsD+YFu6IWw7g46r6JxNeG8Z3iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGYJNxCu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2589c26e3so93490995ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777283075; x=1777887875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g66UKc4RYYU5Rnk8BWxgfZP37Yww2yik9aCxvKxm9+o=;
        b=sGYJNxCutB0L9+ydHB1YISDYS4UfaE11SuzhDBeQ/kV/Q4YJt3but5+BnFE0pkjtF5
         FBci7WBXz9uxspjp4y3hC2NOs8t5YELAz9ZbUXHSAgfyx3Z7Gpycd/AVMV7DcYTS8aTX
         2f7rbmz31tljk2EZcuvzYA2n+rbYfkjYZ8zCVkuFAMXtjvB2z8RHHpFwaKRtbreL+ltx
         a1qB7K1//O0lEQslHht63pY5Ws1rFOI0d9IY6KZIEDilxia9tdvF9qdOqS1qrfwJIvC5
         r9FuxTuD+kPfluq/5ORxCWN1DsCZU138Yuvi8RFnLaNaw/iVO9f7ZWs+DZJC/Xv4zKDv
         ueuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777283075; x=1777887875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g66UKc4RYYU5Rnk8BWxgfZP37Yww2yik9aCxvKxm9+o=;
        b=ibvkFD2rwByj42oNaduKTbVcneycjObUhe43Qv8qNzo1fjUuuk7kg7HpQth/5kDY43
         btTa4FKqi8eFXdpBVXV0rs/oq1nONaEIhY3byPNuC+VrrGdJLrf+BD79E+k/CCCngyMh
         ZAUWeGx2Y2Jl3mg1fpNcuyRfPhnbMYUFKrpNo8sxzbMixJJvtkWyHMkCaj1ygcBhFJjb
         pEgx9hu0PXOBmSFg6LyXGQt6hMK0kaOWykajpNOtTtu8AQXgR2t+jjlvj4XPV7sm4WWP
         fGOrwvdpq+NYw8w7S/TNwihSN6Py+WmgREgtsJ7YPKTbUAWHhi1vnr/aCcINIqAvWsCm
         Wnrw==
X-Forwarded-Encrypted: i=1; AFNElJ8XUxpVd79tsONdmrOnBkM4iz/5hZDJE2sr9uSl1HbplGL23smGXX9wAhrdw/iwI3O8mGkRzX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDsb5x9bMysYjPkM0UoFfGVu02EkayCpyMhMSuaAtNvSHKLxk
	tQkT6KcqojkqyuikfU9dM0KdZpHIN1MzesTINRVseECHjm2L4G3pPPkC
X-Gm-Gg: AeBDieuYo7MtoWsCuRFxN6h0wxlrWnJul9v7P+ZeuJm5ojLViuvWHwdLDDhAlU12Gqh
	w0udrX6QSuE6uNGLh5U1hwvaDvIJ2L4dgT4ZBDCgfTmOt+p3ibL31ja0LyMRLXR5knXH2kPBglu
	xJsYGl8N6eH53KM3eHrOgIe+EG0NmDFsnikQM1QL2Mj0WMIe6SlmVTs9Cy38YiteDkpZTXsGDXO
	dxF1IBUP5AXwSLl5hgkMkufYtLzYWJFJJ0ngPvTCjaPPnFt3gl6elyyhbP5/8f7qNHomMfDgbhW
	ngyWrl9ZnDwsaFXn7Ox3eF/r9rceKlunR/qY4RA0xSIUVlQaZRxASeTIQcqEMrIO/oi+mSmYo46
	zPNkVSWmPH049wj5q6L2fIqAa7OKi4No4g99msLNUxeXxcLEuuiHoTAyi+PVlEimZblCcZnASxg
	k5fOAqqHXXFqdpOnWH20ZJ4Lg/GzPhmAl7UCAhCwu71Eq2yB0JGQL6sN5cDR2WgBfCUw==
X-Received: by 2002:a17:903:3bcf:b0:2b9:7051:2c18 with SMTP id d9443c01a7336-2b970512cfbmr12693285ad.0.1777283075064;
        Mon, 27 Apr 2026 02:44:35 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:3367:a44:8d5a:228a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3b4sm384931995ad.2.2026.04.27.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:44:34 -0700 (PDT)
From: Linpu Yu <linpu5433@gmail.com>
To: kerneljasonxing@gmail.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	linux-kernel@vger.kernel.org,
	tanyuan98@outlook.com,
	yifanwucs@gmail.com
Subject: [PATCH v2 bpf 1/1] xskmap: reject TX-only AF_XDP sockets
Date: Mon, 27 Apr 2026 17:44:22 +0800
Message-ID: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8AB7470167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281284-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linpu5433@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email]

XSKMAP entries are used as redirect targets for incoming XDP frames.
A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
traffic, but xsk_map_update_elem() currently allows such sockets to
be inserted into the map.

Redirecting packets to such a socket on the veth generic-XDP path
causes a kernel crash in xsk_generic_rcv().

Reject TX-only sockets during XSKMAP updates to avoid the crash.
They remain fully operational for pure Tx purposes outside XSKMAP.

Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Linpu Yu <linpu5433@gmail.com>
---
changes in v2:
- return -ENOBUFS for sockets without an Rx ring
- clarify the veth-specific crash path in the commit message

 net/xdp/xskmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index afa457506274..3bff346308d0 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	xs = (struct xdp_sock *)sock->sk;
+	if (!READ_ONCE(xs->rx)) {
+		sockfd_put(sock);
+		return -ENOBUFS;
+	}
 
 	map_entry = &m->xsk_map[i];
 	node = xsk_map_node_alloc(m, map_entry);
-- 
2.54.0


