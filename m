Return-Path: <netdev+bounces-292318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBwMJmv9FmoJ0QcAu9opvQ
	(envelope-from <netdev+bounces-292318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:19:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B45E5C2E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50513099276
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C727603A;
	Wed, 27 May 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dce7WP0z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC218A6D4
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890995; cv=none; b=LRsx6ha2eCc3zSn9WVzkRmRi8Qy/ZLyZR4W9gvBL7rGZOuF4XfA2eMj1Ce1V7NLVNBknBZMJkrDCggEyN+iGg/ZTfgAaEQhPLm+Z+/TwELVdG0k4lbT6x2oeY8kvq/Yaqoj5fJH+WXOyXaaYCRiloxyQg7eCOdpIbi1uQKrTbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890995; c=relaxed/simple;
	bh=N77LSvgSo8xOF1kyjXoXK3LnzE6wLIf0cUM4V4UI2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WduH6y4reePudXBetfF8MyHyc5QtQ+tr1FgX8vUqKwMvgCB3oN/zXkfdVTibcPqUfGFTdZPJLSio6KWObX46gzDLDG9FyoaTcK4pa0JinMIwqjbO46PWjX7k6CYTOBoMHolhcahqIKKtuQdk89WvrlcuAAvVVoGOlQrLe4jW57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dce7WP0z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49041e84237so44651545e9.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890992; x=1780495792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9b2NRW2sxpXKdJkqinkCIXe13CjljiKdRRyBQAUL6w=;
        b=Dce7WP0z/kV524Ns0wC+WvcFc/xcwhXij9h0CJq7T6atqlrmHFGlhQBg+y9sVlwHgI
         v6fdHjQSRXiS//iEItMw5et4Epdy/46VK2U797zPjfHtJVuVnk6LCtLTKTKE8kep0Uzj
         Fl8JRMnfY9Dmmjg90eimyL3FeAd7RRoDFULfhC1ch6cUnXR1GZ/I3yPCeYJfVaBr7UCE
         t2WbunLzBbxujeVo2VJW/FcnGEo979iAmt1S/I+ttQeMIXpYyH1C1w8PpDkRRSgpqrU9
         yHzOTPLmcil4i9LrDVbfsEEwAs2csXldF45bew9aG9Sp1DyJfrPXjFsssZCkKG3fcM9g
         ARsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890992; x=1780495792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9b2NRW2sxpXKdJkqinkCIXe13CjljiKdRRyBQAUL6w=;
        b=f+tnM12oYU0wcSYGp830aEcHQlb7KJcGDm3bLl7OHIw6UtfxWgLfdLfnei7+yl4ZLD
         LmxfAfEkcPXOzPFyx1WVhx52TrhZZQ48e7h8FQ3Yir7A4hMYcZPvDMtvkdN5iSCRH4xh
         oqOFQEu9PwhJSJlVCd+XlsKKaBKvP5BtugchRPK8qbIVO/X6lOMssvwT8w55j4rN1DE/
         QigCvbN0lri6zG3Nm2wSB67UVxGCw6k9K2CLZRDY2lrgG0CT9CUZdupX0koa0mWssOPW
         cCUJw4gKvT9A2k4twx+t3R5dGxZxjpD3s03SDw2qbC5n5+F+Bmg8JvjspKgAv+h4UXhq
         mLbg==
X-Gm-Message-State: AOJu0YzfMSVlP0Brl3E2JkcosvPgOhGuKWg33J3G8DdUOL1JCbP2AJbe
	hMIRL6rAiwNNuaBhWTj+KzM+hFeKiIwSBhiCyyu/wzui2WSnQ97J8A9s+3SjGJPU
X-Gm-Gg: Acq92OGATDjwerhZLu4BGwUibUy3mnGAUi2AWswfZHVsZmW7qBoFuFF2y8nWl/y+pbQ
	sB7aDxnU/1V0B9tB+CSi70fD679xd5Hm3ubdYV2LH9nlzZrjKbIxwKjL/SCnvKoD2JtVZS8L2oe
	Vv8L+IE16t/R8Yh3NgL2B0xKdwcC72FSqzGkrsOVkQtUf7xcKfRj/X1d2k5fMV/+FqffzYRVIrl
	oef+oCtx3T/8Ew0KaTN6ZrztmCydlKHlggWefiqN7JuaF3EdZcXjrsqhHZ5gPec6MdL63+yy/rC
	eV/wdb68N+UL4ik7IaMgDn7iuMjGukdDgo12rYS61Li7V08edMpTODpV1YpNUnmJYx6/02LqkdX
	3HP+nhbzfdFgE6hm9C+OYYZOZlk4erjF9nuEUM+tB08s7LVBpeqFVMPVKJGu4N7m6xlMWERMJe8
	FUIC2f8Xg9QNxmlYQG+mlBOds18InervBOMBHwi/p8cg4wyKjkIpuJR3plWXDdExx1RDkKYZ+Su
	BTp1r65sryRMwQKdQ==
X-Received: by 2002:a05:600c:4342:b0:490:4035:323 with SMTP id 5b1f17b1804b1-490403503b0mr249325125e9.9.1779890991603;
        Wed, 27 May 2026 07:09:51 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2a73sm6163871f8f.22.2026.05.27.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:09:50 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	petr.wozniak@gmail.com
Subject: [PATCH net-next] xfrm: fix xfrm_dev_offload_ok() returning true for software SAs
Date: Wed, 27 May 2026 16:09:48 +0200
Message-ID: <20260527140948.21162-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 447B45E5C2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm_dev_offload_ok() reaches the ok: label when the SA has no
offload device (dev == NULL, SW SA) because the guard condition
"(!dev || dev == xfrm_dst_path(dst)->dev)" evaluates true for
dev == NULL.  The explicit "if (!dev) return true" at ok: then
incorrectly routes the SW SA onto the GSO offload path.

This triggers the following chain on platforms with an async crypto
engine (e.g. MediaTek EIP-197):

  xfrm_output() -> secpath_set() -> esp4_gso_encap() (no encryption,
  marks skb) -> validate_xmit_xfrm() -> esp_xmit() -> async crypto
  -> -EINPROGRESS -> validate_xmit_xfrm returns NULL

On real netdevs (noqueue absent) sch_direct_xmit() handles NULL
gracefully and async crypto completes the packet via
xfrm_dev_resume().  On bridge netdevs (noqueue qdisc) the direct
branch of __dev_queue_xmit() initialises rc to -ENOMEM and never
overwrites it when skb is NULL, propagating -ENOMEM to userspace as
"sendmsg: Out of memory" on every packet.

On synchronous platforms (x86/ARM without a dedicated crypto engine)
crypto_aead_encrypt() completes inline, -EINPROGRESS never occurs,
and the bug is latent.

Fix: return false for dev == NULL so SW SAs use the normal inline
path in xfrm_output_one() via esp4_output().  On -EINPROGRESS,
xfrm_output_resume() converts it to 0 and the async callback
re-enters xfrm_output_resume() to deliver the encrypted packet
correctly.  HW offload SAs (dev != NULL) are unaffected.

Fixes: 9e1437937bdd ("xfrm: Add xfrm_dev_offload_ok helper")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 550457e4c..5454be0b2 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -434,7 +434,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 ok:
 	if (!dev)
-		return true;
+		return false;
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-- 
2.51.0


