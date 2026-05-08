Return-Path: <netdev+bounces-285868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOmNKAv4/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934D4F815A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37A2306C3D4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBE3ED5A3;
	Fri,  8 May 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg8HjAmb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E43C73DE
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251436; cv=none; b=hWNTsME91T3+rymLOJTm3X/9k46rRkpysGytybElKpAMHfawQOOnPo58GeUYICPGp8u89fzNX0IWVOjmJKW8uSvz0Fes99VlfwnJ08vagkujRrp0e1NG2AhCzQt/T/Wb3DrnkB9lZU6qeDKXYfx64lMjh3nJ2Z2jGNe1Lue3k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251436; c=relaxed/simple;
	bh=EyXG+VwrAF+um4XflE0usQdCTWRvEq/i5fmd3Ev8uzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZtYqUmKMnLOZYebJZHCcLHYaHpUsE9jFBudanWrx8lKOuV0pbpKaDM7t/1ebNJmDPumDgKXWUfUsc0gd6m3mBIaEVaYwBJqaesNN+I21ClcIulglWcvSv4Dt1byQ7iAGuBASTDQvii+UZZldUzg+kc57SHoR7/QphGyrkHMhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg8HjAmb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82748257f5fso2013755b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778251434; x=1778856234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2w1uSP/0twE+5ljaP1rCYoWbGtAjbga1hTtB1LlN6c=;
        b=Dg8HjAmbjrTgvDXVnmvLLG25cAknvGCWOVEvIZpItXfQt+6YIWNUAP0jI1hNIXzX23
         IA4TJzQ9LQRSEcfKZQIgE5RsNd1iV5LBMtBCvx33MWIZmuxOShb7FYvNfAex3lt/+7DL
         SU4GoxlxwCb5srsbctjt5kYfB1AQLKL1FZWLtJ6z753owcHsQbG1RdpylocU6eofoIB/
         8d5Ig1EvZsJ7B1HsYqNkdXiPPh4+yKll97a0sMeTCDIfsYcN3fJ802iFti7Vu38lMOht
         VhHJ4+SYpyy5OjpMHI9xZNxZYljgSb3dXY/JncuRaL7kK+OoRPWCiJn0pzveQXJuUn21
         bBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778251434; x=1778856234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2w1uSP/0twE+5ljaP1rCYoWbGtAjbga1hTtB1LlN6c=;
        b=RwNdlxTl7lo3KFmuyl4w5CFP5EYgjsuO8LwQo7BxFttC+O+4DEDxj66iiOEhUjdk16
         IHr0X9QkeAfBrY1mfneOtVyv8hHzFBoLk4hpCyGBqrxGoDBAQJYVi0vEjXXgD1MyEC7n
         XoS2YDJ0g4t2i68Wp3STJWrF4dyeIzk/zxIk1MRJp6EGGzct31HdN6quzs9Ua/DBQ+XY
         x5uf8d6YtTPPT+7XURoo4F4ltyZf7v99jrtWIDw/ydCJpm5WI9VNITnopbMhcr5SuQzr
         tI8LvmqZvAtERALEylWhDcMNqEP+Wg/1UEor2tqJsvPKYnu/K938e8snOyhJCeKC5syJ
         mXzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wjxkFsyLGx7nUFjTwk/4zZFR6f51wS9+9R2Ra22IPQbBWuf6w9EK8Y0por0YfUX3nIusDTt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+Evv3S0xh8NbDqBlXumSfHSJiQcjdRFMH40mfzLARwfmrF/r
	r23fpCdyC5rJFBHxzXfyO20p3vF58qtY/ZxER8jPrQGvMvbxMmp87laB
X-Gm-Gg: Acq92OF8jnWgQjzntQUWDoHcusmseQQT5sbRPORC3AMOWTNtJWd6JSzXxDZKGwJb6sg
	pFIj47QpE8eyG49VnFbh8N/eRTGTBNaH3Vt8X1nLB1wmajDtuqgWmyDMQUbx/YPOoTHRS6BMWDk
	vVEjxId4SfhKS1YXIpjiz1CyDOjc36dPzrRUhvCV3R+W7036Gm/oLYoLZkEWxVXsmRvLyPuXtdW
	YmtBO/riu9mjPcbPLFlDxWhxy3W0Ob/b4dsmo7Tur+XsgxeiQkDuzPfOwggxdVh3RuVBDbWR0qP
	zlvXB6chlgdkuTgI298aLO4/LGQvF0o2Nvm/Ws9GhouLFAFIcKqtdiIpWXLCzlRWNLmLtPLTnoy
	i6r/nWbvHk0JxUxeJEiVKDsEwZc5bDDqrsKi+D3B/AvTmahv5kauHIy/2E3E8R1+RbV+UGiPRxV
	pdTQZLf35KmGynZFhJQ1n5CYqbZYMUPyt4vA==
X-Received: by 2002:a05:6a00:2304:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-83bb8691c49mr6557122b3a.28.1778251434012;
        Fri, 08 May 2026 07:43:54 -0700 (PDT)
Received: from hyj0824TXAir ([110.65.147.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm12856887b3a.44.2026.05.08.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:43:53 -0700 (PDT)
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
Subject: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
Date: Fri,  8 May 2026 22:43:43 +0800
Message-ID: <20260508144344.694-1-linpu5433@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0934D4F815A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285868-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Action: no action

XSKMAP entries are used as redirect targets for incoming XDP frames.
A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
traffic, but xsk_map_update_elem() currently allows such sockets to
be inserted into the map.

Redirecting packets to such a socket on the veth generic-XDP path
causes a kernel crash in xsk_generic_rcv().

This became possible after xsk_is_setup_for_bpf_map() was removed from
the XSKMAP update path, which allowed bound TX-only sockets to be
inserted into the map.

Reject TX-only sockets during XSKMAP updates to avoid the crash.
They remain fully operational for pure Tx purposes outside XSKMAP.

Fixes: 968be23ceaca ("xsk: Fix possible segfault at xskmap entry insertion")
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Linpu Yu <linpu5433@gmail.com>
---
Changes in v4:
- retarget the patch from bpf-next to bpf
- resend after no feedback

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

