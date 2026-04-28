Return-Path: <netdev+bounces-281851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PwMDYq48GkyXwEAu9opvQ
	(envelope-from <netdev+bounces-281851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:39:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A1486089
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988B2307ABB4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5843CED7;
	Tue, 28 Apr 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF58UUFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056C44D6A9
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380949; cv=none; b=G5UgV1FmduiDXkfGRH0K5dHk7IvvZucbQt6akWADONvNXhSo8wGookRtHFw9qYX7Yj6JrFtGcdsnWzgWemJIhzwJgNOWpDgu6ZMu34Qv6vqKcIICi8udv7xPT75G0unwOVL29Qwnc/ACQF4IGKmKCUd24cph4gZEPOBfJqq/dK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380949; c=relaxed/simple;
	bh=47qUe5iD0anvdWaqTf9AsGaa0trp/rCOtUxo2FmvnEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crqra0KId8Wg4gf+4n4c84Sq438HrKzmNb83R1RC5MndSeAtBpNyYZTgquBx9j0pUWkzxPucDDPyG69QSadQKi5cjJOnBN4NRMF0VxEdfDDVQZf73RKOEXF6VG2GMU60RIA+og4Ol0uajQpgnuer/2JuTh3vDYIoHVN3v/GfW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF58UUFv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so5441850a91.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380940; x=1777985740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slN5/hMTVlDaMpg5JpMzTWkk/vo41vVvsEaBCnd8nHM=;
        b=hF58UUFvzV2IB93MalYDmlii2PA03+Wb9RjeFNw40uS/NAE+c96pQXf8/2iUcQRF6T
         eJBjpitUZeWVq9SlXXkEngJ38tNAK15KJcLzhx3L6tFUFKLWPpdZhmzlufd/fCnb4f5h
         vImFYEud7tdMuAeCTKSy3tKTTaMJQ2PuVggA3O0/Hfrf1lokJ50vBrTs3fpwGpFuFTXi
         bff+1k/WYPH9FKTH3NJ2yiLhlFKExFxU8pXjmZNJnfIDHdf3kobQEvjaMybjOpXDc6Cm
         8wdOEx7Iw58zYpfccrzzLo22swzHasWIWbFVHGG0yoVzmkkMZG49x2FRXjxdG9ATUd3r
         lyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380940; x=1777985740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slN5/hMTVlDaMpg5JpMzTWkk/vo41vVvsEaBCnd8nHM=;
        b=oVXaC0CzgjHPxd54mmnYs84ZQ3cxzWQ/HwKHFbqLMnMnU78rjJ0Edg968jFc5TTcEh
         T6Lj2vgpeJ1grW123hlvxWdgD5PmnyxnBk8m/z2xttqNvM609JAjPcTjB2s/plntNGzB
         6zg5v8gYZqLAkZqd2e64O5USMP3uBXKKOWFuGIjxnu+3jLx/kR3FMcwQ6XIVNMSDl0Ft
         CuS3PxuK8L+6lh4XhhW2DVE9QcQgAWpa5NvSgQBbkzig+ZR6hUsqOWbgtkSNcMOI1IoI
         YgO7ap4iizpAbzxROB9UIhq0ksM0q4JhOfWPpyGXRt6WO7f7R22R2egGcMKTdHNHR9SB
         2yvA==
X-Forwarded-Encrypted: i=1; AFNElJ+MWW395kZPckGaPVWvW4zlYz/MZWLOOqsjp8zu31PFCbqYR/yFa7cVr4t0CxigcgIhOGAoCEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobmoTcbwt8R5141gTKFdw+0qzwmMV06TNVeRgpIXZdJSJ4DDW
	hq7sAD5O+oql5TBCGR1dY5Ya8YvjAItNHa9kB8/9UT1JlT2/RT/qcimD
X-Gm-Gg: AeBDies823qakCcp2Mw1oExkyF8exbJHHlTP/q1URRs70x0XpnBFXpKY7VjjD+YAX40
	2U7+eyKxbMAF4iPQMSbSYX83m1xIqUCdQpmV4UO4Qq40ZPS/SYwfk9GgiLJcTt9ksCfLVpWTN0U
	D0t+GAGCe4OyvwvUO16uW/o8Ahvept2yvDXATWDOPorE0ms/GQwhfX0jBXsaOJFthvyL6k26jQP
	ZxyL1hlGEscVdyExy1pGDBj5ae9WaZH+nM+okLppXB3OP7Eeq/+Xu9G/bTL6TQnlJSegpK5O2TH
	A/83hgHy0waHCSVyiuHRL699OaxmN8h9zKKHLpLcYVWDAxR9zcvr+XGi29n57UOdA+mLJEuTZAd
	39JevmgA1eVQ9R3J/W3J5ofC6XZVKsdvGk6VzUbbbh76q28UnLC9dFjR+QeGUt8FqXxLqm3rzzY
	uMRl6y0b8zdB+j3/ppaohs8Xlvxv+QWwxcmvzRpaD0esbMe3p/9wk18AcH6UxFDDuDqg==
X-Received: by 2002:a17:90b:3947:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-36491ccb41dmr2618794a91.5.1777380940062;
        Tue, 28 Apr 2026 05:55:40 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:3367:a44:8d5a:228a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490f9a304sm2912298a91.9.2026.04.28.05.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:55:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] xskmap: reject TX-only AF_XDP sockets
Date: Tue, 28 Apr 2026 20:54:58 +0800
Message-ID: <20260428125518.4556-1-linpu5433@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
References: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D0A1486089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281851-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linpu5433@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Changes in v3:
- fix the Fixes tag to point to 968be23ceaca

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

