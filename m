Return-Path: <netdev+bounces-279687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WODQBXzl5WlkpAEAu9opvQ
	(envelope-from <netdev+bounces-279687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE80428386
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932283077E3F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490493876C8;
	Mon, 20 Apr 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeqlyQh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B298388E4D
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673722; cv=none; b=XPrTjkoD7C6yl566OwA+8c+3z+6m35EcXz7VvnUPKEotWRrdZ/v5+qDSahiXHJR010oyjeW+x/ZZ4rg7uQABCTFLHFSqjVN78ivC0CLs9OEbOkMBLJBttV/N4BbBXMvM3bwzbBaeHRycGN4/9VeFbKFDWPbnXp/DM7oG2f1peqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673722; c=relaxed/simple;
	bh=sfRxxFfc1RGLuuasaz3UMYIDIEEkVcAhXZPiwaIAuIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5YGSjC03dClIi9BxVkCr+UqLOfXnvVP89cmRUtlUeti9ZonyZaTuTTBm+xTMdLhIKs59GZqmOxSPz99OchzwO5hIJOy9Lmo+45BucxzWrww5PdDsDC00CrFyPsHwhcynRRLuARBYmhn4VRE+/yOYqHK/kRK7ApOiQlZ69IGeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeqlyQh6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so924912a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673720; x=1777278520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMJnoak7v3dQCQqnIhJlr92vBmfJl26udBlaEN0uJnA=;
        b=IeqlyQh6gzttqXBwWk08CpU+r+O2vnQ6iW+e4mXDT5PioFBegjHUjNDHWqYlVhAkvl
         kUxEsSR/nWIA4mqJeSojcumutnTSe0epU/wSpFqylvBrgYEDfK13LqQsPODjgP7GTjCR
         1bH6IINHiYOcv7vsLomSR2SIg1ifONe3f2RrBduoe/k1FiwoUFaEPyYbrsqs0W/R0nXu
         g1NWaqJ2bhhtf+83X0QcG6MYwOca1mF+tKlC0qTt1tUUJ5vjPV+uY0ccIjFWDlSmOpdh
         KUxeoFmpZWEK4O1lRcaW75jaJUMOv5CU91u2ouBe1yN4aXu9WsDFCyElXh83UPC/Yn6A
         BMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673720; x=1777278520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMJnoak7v3dQCQqnIhJlr92vBmfJl26udBlaEN0uJnA=;
        b=QdsjT2UvbI1L0Qy793xUEmGBgi/c/oxrqu+hxG1+JrZp2S8wSft9mhFR23uxS1Jpjw
         nayasTHRkaH76U6g0upGdX6MJqIUK5Rb7DHOS32Sv1uDggXQATesFDZG1cYT2GIEHFI3
         sTYjFo1+PkdwvFglXNCbss0jaf6yDPf+Eze1w8biBz5Xykn7LBjCW7mmsYGFOD2A2/+c
         1hFKzE7SpZEMxGXsAnC7BaaVl6UjrQ7SqjreAM2TIxlQ5EtljAsnhyLVRfZTY1voasOp
         /yWM+wHcG/HesKiELj1RTSj8dCs42a7R+VO9fYaD8pP3SmCmaxAkL6/HdrHOWDrvzCRf
         nBaA==
X-Forwarded-Encrypted: i=1; AFNElJ8ThOWoPYaryAxHEYasrEZO7F/DVqmBbvN7tO+LC9t0/f45QZ934WC4XL6MmaaOlkLxs8v482c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbXNwA+7bpay37uXTloHNkmtE09NqwXB0P3PImhSqzwBs7xAY
	q5HKsetYseLWOj3zFIyTR8ah9E7CjIXHfJDbgOQlObe0j9aB/Rxxnijd
X-Gm-Gg: AeBDietGCetK1QJE1P9PlUPLxKmXyRDljKtij0/EhkvTwCDZtuwGzwvQ/RyJwM5fCgn
	KQJptvF/5+ZVmwgXaMLwV3rLFKpEAydZFOf0BXCQMmiaEI7fQbzspH5QL5ExRG91gLBgzYK2yA3
	DU3bO297SBpQmCQPBMn8375RImqA7OuHbO5YC9iU32JG/ayA0Y5+fCxlpfMry83uuiDek1hGfr9
	/PvNoDADiV7jLErAjJWJPVN0GR+cAbpxaksJZ2zzxziROugOMtYgbakYO+g7n/21TUWvTFzaGTw
	xB5keHzpQcKmeCGhfnNbIxavY2jpSqtO47lLDXGZ0vDa+DmAifnL08bTaxJbKDev61j6Mwfi/dw
	81V8WACvTL4fxpWURboIJ60aXXD4KlZzOu4yFcHbJjljjLBD3y8/E6wRMhgKbaU2yN2/IVtR4hV
	rfZGda2F4s2VIoZl09FqRhinvFCSnzzKAYZG+sqyVM0wmEjh+JAYiqWFU4wv4Z6/YW2lHHhpn0+
	UuuW06z
X-Received: by 2002:a05:6300:2109:b0:39f:a42:924c with SMTP id adf61e73a8af0-3a08d6f1a1dmr13977547637.17.1776673720435;
        Mon, 20 Apr 2026 01:28:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Mon, 20 Apr 2026 16:28:02 +0800
Message-Id: <20260420082805.14844-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 8AE80428386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 614e7bd1252b..51f76e9d6ffd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -749,8 +749,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				xsk_drop_untrans_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3


