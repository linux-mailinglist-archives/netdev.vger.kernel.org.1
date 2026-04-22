Return-Path: <netdev+bounces-280299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOtNK4VC6GnHHwIAu9opvQ
	(envelope-from <netdev+bounces-280299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0E441CFB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74B59300BC4B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58453A16B1;
	Wed, 22 Apr 2026 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKlrXjeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EF2D2495
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829029; cv=none; b=DVte5/qyZkQf8hFvh/2f1xQPx0itPZuwh9Od4ck75D5sc35hw+BdTHd1KBM8wBO2fcn2/67rVb+5EUy+rzpqJbEPJwOA4MrCV9T/55yZqC262SQkI9z8JOo/AqIFyPHAo7O6jxHmeCm3ju3t9z9eqvbmPqEFCCjSZdUunV4TMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829029; c=relaxed/simple;
	bh=TlmfMj0oSjpUNpbiocpFSZqid0mqlfXPvbNwh7NE30k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0O4F7+jQcuRRT2MR08XBrigEjnubQ6YenHl7fvN3k1A420G3tcxh7nTnckbrTAv5Ci1x3l/XCbR0pDWw1S9nc8tYb8+PwAJ/cKE8lUvFYn0bT/bmC9HATdugnT6QkTT+QJgZbgASf1hbt9JoZc4Ku9WHHlcC5OttZrvQ10fSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKlrXjeF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fcd0aa2dbso702349b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829028; x=1777433828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=pKlrXjeF5ey5zWVUWiZfOVG/O+T9l8WBMvV0wzLiSfYRrpxeL9P7AcSxRNdzcf5fAq
         0WNGnLxwVN95gVPFKbQGIX1kEXwEIQ21LvhMxrkXRyRGXuCnFFlq++F2Tm83vY7nmLZA
         vQGTUh0yBa+BA5NPeg37iYVZcCaoGaFuuT1MpLq1wm6JbefCIDBuQEAiv2KSuUEtl55v
         lcomm1YjYv1BzCb2/3gcquRzn5douJs7RGmPtOxp2gEej+lUrOhW3gOibfnZCvmZpIpP
         0okmhAMug8Vo552oZR9hzs2W6HfgvHoDf9Sb2h1QAyk9IEu96lsRBCUNsOpJ+3I8UwnP
         fxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829028; x=1777433828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=FAfv9bdFW4Xpxf8spNiEmI8pyCzU/qXp1R5wcrFQB7XMF3OFLuM4UhSSQ9Mw51XBKg
         P0INArO+ZZjjoccWq8hBShIVQpxTDkTSZOckHwpjk0XOeoYJ6x/o1wpylnZEUHK1e52+
         qL2jU0w0ovI4hXqgTlHJcacoIm2Umrc40JfrviDIh2AB7L2SMJe2aeXwdRnOR2WseZ40
         CcWoOQfiIEAgUw5GvA80e/ZlZLe4+Fi2ndiWs+/wOWY4OSVxYv8+45aiApFqv1mttGIY
         fKI2abFk+VINM0ccKe9iCwzdiYaRmJQ0EzBbKmDjPn9NsZn6UL5E/FBVYxK0QSxQP9I0
         ZMUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CeNHsNOo61ceKxzZFb8amRH1gsIPOT8uOKfQI4v7B9jh/yri71ogTUoMDs8Q8nDlc1MQkAFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqxqV9hhV1+OuMCOmRJUaUCtbiLVx8hZzXM6PdOArmTQcD6Br
	2TxiX592bfgE37kb3EvaTdm0UVKYAjT+1zn5xcjEWm5L77tZiWZkjwNs
X-Gm-Gg: AeBDievs8/uatHQAQ8CHbGSCv2sQ0Q4i2It/k+hFx3RvtQh5svnEzHch7/1hfewDkfI
	y4IQ5rm0lAJ0roj0Fpgk4GYH+yadpHad1QQATKTjLzRF/zIc82+VfUIyk3W14uVYHjfXNf2t8f9
	WlKT4jcZ9sQyUfsZaZI53i8+TyjE571inqzqD9hOi+xU14jx2U0ZVHBLY+erKAZqTMKAraAcp/i
	WPOshhRE4fnmFdbnXQCVmnPQrx5xAGkDN4DoMCUTi0sBZIChSLtY/Z6pEbPspEiZe+pqhLrwigS
	9rU20Fk2Dsv7AXP0khgvS5zhkI36uFALaCQnaBzXiLf2agb5pasUEWqrS1bBjAp1bsDBHWLXzP8
	85qfvJnFvd3MM+fdH97eOBl9ctcdg6PHKyT+nse5csnIRO+Z33bOKgTH0mcZNKaqccjSoqwHzGl
	x5ZQk4d0i2IC49OaLnO7rHZeKJXhkmasW3mtrO1Rsqee1+1OL21aJyi7rR0NGJ9C8FVuaU3bfTG
	IkMpKpt
X-Received: by 2002:a05:6a00:3cce:b0:82f:6b70:5a71 with SMTP id d2e1a72fcca58-82f8b507fbfmr16996956b3a.21.1776829027662;
        Tue, 21 Apr 2026 20:37:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:07 -0700 (PDT)
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
Subject: [PATCH net v3 2/8] xsk: handle NULL dereference of the skb without frags issue
Date: Wed, 22 Apr 2026 11:36:44 +0800
Message-Id: <20260422033650.68457-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 99E0E441CFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
EOVERFLOW handler unconditionally dereferences xs->skb via
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
pointer dereference.

In this series, the skb is already freed by kfree_skb() inside
xsk_build_skb_zerocopy for the first-descriptor case, so we only need
to do the bookkeeping: cancel the one reserved CQ slot and account for
the single invalid descriptor.

Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
xs->skb check (for the continuation case), and add an else branch
for the first-descriptor case that manually cancels the CQ slot and
increments invalid_descs by one.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..6521604f8d42 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -893,9 +893,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3


