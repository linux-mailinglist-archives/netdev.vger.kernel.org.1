Return-Path: <netdev+bounces-272983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJt6G2p+yWnbyQUAu9opvQ
	(envelope-from <netdev+bounces-272983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4972353CCE
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A983E302F278
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872811F1537;
	Sun, 29 Mar 2026 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLDMpSKo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC51DED5C
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812596; cv=none; b=Iw7wwGMa1Wf9MJRJJCI3hWVSmNdSfRw4f7Vb/v0n/+Ra07c0mQErYW9QInV2CjINAPiiZSebeoWnHYsc9hZXDX6/pWG7Bu/Ehi5u9TxD1RBovSrjgLk5qKznNQjpbePvjS+MHLpQ7yxNFrp37L7ONP2CJC3nvH3E298HKWrtf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812596; c=relaxed/simple;
	bh=TVGIvwq7++r98D6MzS4FnxGtSITtMoooJkrNi7DUieM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yiva9HXk0Yyf6czbdhvJqT7I3Jr4K2PGsnrCE7qM3z48hIszX0OuB8759Zx2b9IGEm7iIbS0GBC/ocQZPF6XoeV8C/cHdD/ILSxQn4r9LtaZKri/CTmoeDhngK9+rzn+JM52oy4E/8jEpKYY20YE+i97Z4X9tchJlCwPvnKNumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLDMpSKo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so29685055ad.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774812594; x=1775417394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTz6k9vPuNqocM97eUGslil5NIJ+KRt/46MukpBHLQ8=;
        b=qLDMpSKovunWsOxGdgNz/UsF7iACexAh3YBkrjiTziSN7bu6NglzLZ33u8Z1Pj2/1a
         ZR52nko01rY5NwcNt8qy6SYDbAtb489lQKXz1uXMASVQCvs8sgxUriklFyvwgOl7poXc
         lf+/inv8FU+q61SWkTQE+rFjLv76aiGHn/UaF+onC9PgVEgA1mn+c8JICLq/tkOidhzd
         MIXLx1JuGapYXxaeSwa//2Q4KLfP5x5tuJEo1TfSsm+wl8qrJZyOKy1o1lLb4f0jZR2Q
         AfyZTyVxz79rFjxJH4Tki3z54iECnYNnu/XZ9pAxaXa1LIaBcb0R9sWgEnb/wxVT+SAn
         3Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774812594; x=1775417394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTz6k9vPuNqocM97eUGslil5NIJ+KRt/46MukpBHLQ8=;
        b=DS5gDusCE0n6KkJJp7dHKoAdhodhO+E8sknosBDL1zDaLeBjOD2dEdzULo42ldXDTY
         YkEJpkSzAGf/iJWOvAbzl6/vz6kE4AMGZlYkRhlZLIs8nfT6OgPlX68ODHAPVmuIG6ag
         CbyiiXZCl4BcCJhUhTif+9wq+1aokyIAQPN3SR9QIhOMusVyik7KWIqXQ4CrSLTC3qrA
         wlJHgc86v1wb0lXZW4lrunG30rU7Dgc7QndHkEf8C79MAuQQsZ/syECj1L5v40LZjkRy
         sizIH5TuW5YYYEqeQfysUznpVTajBXY2RgtUT9IXUE24eYID71GMKO5r+XwqK0+QZNni
         6B9w==
X-Forwarded-Encrypted: i=1; AJvYcCUF/BziK+4mq20XFvsBdpOZRrWTytbUfXVPujJpZj9UVztV+SV54rBTvjvTkPymoztalZRgybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWY8VXy5tyuKMG0uTAqAyw88Eq6aZBTuHVclFSsKnvleyHdGqj
	nFkFFx4IqfbU5lAHWfD3+QipSvuLffP+H+j9dcdDfaSl7oIb3EBOKJ/2
X-Gm-Gg: ATEYQzxkySDV9LJ7wx/uVs7UNYtFgAN1/4CVZTn1gIBH7cfCoPL1iXeFJFlCW6d9/2J
	0dS7YXdwYQnUsuJi4K0Qm8MwxVqqjPxyzwFSEqyuyPeubCBqFYj1XQIJUEGN3k5z5bQqMOnawKc
	GLCEhzaCxdw0Bf9RI6Rz2kNX2pZ2wpn0BkXhykWIKaptJFV0igE254I4l+W8K18TjoKJAQMLZER
	MCJJvIMLg3AnNNVkhWt0VPphuRIOTXaDA1zgxxJwa2NtFG38tJIxYREBWFNhuIxO2sPrPIutpEV
	51HPHQLQa9kdrUGmwKXjxeORQCCuJkQrwUxzPB9hbsRwyXop0185O5d4dAxwDXJFlMG2w+G8+Pk
	zKrIXTJOD1+jbIW/z08pZhlasNcSm8z9ek0rGxm/8jDmLeFMaykPoyBQ7teThb2Q/kl7H0c8cHh
	2FNn/k2vr9Iq0tV3KG7QXKZ/6KHmCcz9fA0ZKzEGL6oxW2Sw==
X-Received: by 2002:a17:902:ea08:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2b23eecd00cmr67930985ad.2.1774812594514;
        Sun, 29 Mar 2026 12:29:54 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:b2f6:47fe:9572:b2af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642905sm68959585ad.17.2026.03.29.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:29:54 -0700 (PDT)
From: Linpu Yu <linpu5433@gmail.com>
To: magnus.karlsson@intel.com,
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
	yuantan098@gmail.com,
	yifanwucs@gmail.com
Subject: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
Date: Mon, 30 Mar 2026 03:29:42 +0800
Message-ID: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774701288.git.linpu5433@gmail.com>
References: <cover.1774701288.git.linpu5433@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272983-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linpu5433@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: C4972353CCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
packets always enter the Rx path, where the kernel expects the
selected socket to have an Rx ring. A TX-only socket can
currently be inserted into an XSKMAP, and redirecting a packet
to it crashes the kernel in xsk_generic_rcv().

Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
them from being published through XSKMAP.

Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Linpu Yu <linpu5433@gmail.com>
---
 net/xdp/xskmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index afa457506274c..6dac59ebb5cf0 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	xs = (struct xdp_sock *)sock->sk;
+	if (!READ_ONCE(xs->rx)) {
+		sockfd_put(sock);
+		return -EINVAL;
+	}
 
 	map_entry = &m->xsk_map[i];
 	node = xsk_map_node_alloc(m, map_entry);
-- 
2.53.0


