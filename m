Return-Path: <netdev+bounces-280467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKDvMgvy6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B494483D4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BB373008C17
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A83845C1;
	Wed, 22 Apr 2026 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksoZxaPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A043803E9
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873915; cv=none; b=V9lXsYCl8nplrxFZBMb6gAy7+1kTHQ01BBe3yqa4hOvkiJB5dU2ZLMHUDpZtfJmbC+5fRnVOF6rYpdgjd+JZi/8SbqvMzd67AbcrO5HnrQIT3nEEkRssNZ7i3amTv7l1YEE6CkoZ89MMMYwT/C5U/7HH5RvetJdE7BEqRSuHe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873915; c=relaxed/simple;
	bh=LnV6FHxAgXBSU98uYpz/Gtz2yuXuM8OmPayVHm+bqYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1ZxuNOa2FVbjyXua7QifdB/Z2px3QjTuLqRBl/SkP9wJzVkXYmMBMxvEqx1ZTV4jCSd6uwyVgWZ2dicqrAVyf6BgzpzAebxaS/zaiVYFuDT/bTNiGzqwi7a4NILrChn0m2rbFzV36XkiiS534+byfxPCvjg6bX2vqxPQliQ0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksoZxaPK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a3b0242631so68319386d6.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873912; x=1777478712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fLGOyiETc2mYukS8fgWyJY/y8XZRG6qnqK1xnE/hlo=;
        b=ksoZxaPK0i9uhrCCXmEHrrysq7VzKfrC+kBwj62+KvvfdWlAw4k9PU6jyDoezZXaK+
         APCc6prNQDeuG/CXbb9iKEVsM/L76pS0gNZpOnQMidI9DrYCK8lQwFMaKVCyJ4spZkwl
         I9RJ+17UaRQ9wZRz1kDCw92Y2866qQwNZIYvFvbsEDIh8uqNJyxhSr4pQls0mEZUBY2z
         fGstz5zRSbJ1+eWKkIiKuilb5iU0hIudNLjckrJD9EySvm61MYlIJ2SP20UWPjAE9Noh
         QF6aGdStv5ChJXBoAr8NkUy/1sYeAQfz1nbreYhYhPaNkMJGYs4VSNq75T6ueKR4qIFL
         ADVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873912; x=1777478712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fLGOyiETc2mYukS8fgWyJY/y8XZRG6qnqK1xnE/hlo=;
        b=pVUSOhqLb+/nn+7cC2ZCJWBg9U4t6amsUE6Ur4mvINFjDu6MyewVhWxZEbVmMTINvB
         vsozem1Mdqfs8DDd3n3viPCmsRcJ/d0KP68cAhZaArLKavMw0olMyivaRTvT7BOOap/R
         KcE/tQOHSHHa3OeovLvpP0B5A1jE7Cqu2AmVUpP0hcBpykt3YIAzXOqT5l1gxBJQwLNb
         s5paEHu82nTHzgXjSePkm/zlMyyQ9jRoZW30oUv3g8+2rtxDEDX0xO94BQPd2i/KntEe
         tQLWUWjr36hAplB0FZiVjSIXVjnSu7sG0hgyzbKQ3T/3/DWO9xW89jXnf+CjzvZAg7JC
         YA0w==
X-Forwarded-Encrypted: i=1; AFNElJ8ytRn3LnO+h0vGkw7bWX3wIGLsCcmwpzJbLW63inQ0L58oCXLLRKQTUxaQRf9DE+6ybiT2ogY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadgFsqLxo3nvgYdoI59g1ubu6XNJRSLOck9o7CplEkmgiQEAy
	G/q0g1m+Tln9TgWrs/fOZuYsWAJVHyLiZuqDGVfhoqECdJqmD0YUwEHE
X-Gm-Gg: AeBDieuRnWEIt1gPIhkG7dxLPUQz1r1JBbs4i291MUcKLU9c8YyUPw7EcOCV4xUSOTY
	torHg5+4iJwgE+jc3A6E9XOOrhc4GboobSSWRtfhYza3cZeO3YEuDBin1nMfsQ21xFcJsFM59t5
	nlGPW3OFJB29j2gykTmUGJwtum0GRZlc7CFrUmaklBB0gdB53N/Ww20tjLgcJ6VGN3IhMaR+Fco
	hQJRHLGwe56x4f2bcpliz3gLXwOVzOsLjwgIG8maA990MH8iCIp1CJ/rZpxp0+L1PkcPM+wsya8
	eKpgQV6D1fjPn+rxcT8FWEdQ5kLsfDWZ7yQNUy+tjrn+X0yoFZcVjMeB5Rgxujq7ESuizACkaBO
	3GLz3cAJfkGgdfDBBp1d4lPWAnrYZ99tUsi19rNeeJ0eHf1F0eJnvnISO4yvKhAQvj02k9y9Eg0
	XTSfNnc/ySXtM8TyMVd6YiJVXsbhUbP+EFEx7UUZVGxFjU1+DY6fJW5icNBW+K8c2hx0Q5d+vNF
	uvg8kGQT6uGz+cqkPHbOiuVWSDXOF9Qucmvzzpg5Q==
X-Received: by 2002:a05:6214:4f02:b0:8ae:652b:e3c4 with SMTP id 6a1803df08f44-8b028167396mr339665936d6.49.1776873912092;
        Wed, 22 Apr 2026 09:05:12 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 5/6] net/ncsi: validate AEN packet lengths against the skb
Date: Wed, 22 Apr 2026 12:03:41 -0400
Message-ID: <20260422160342.1975093-6-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280467-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24B494483D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AEN packets are dispatched after only pulling the 16-byte common
header. ncsi_aen_handler() then reads the 20-byte AEN header to
select a per-type handler, and ncsi_validate_aen_pkt() walks
farther into the payload and checksum without first ensuring the
skb contains those bytes.

Pull the AEN-specific header before reading h->type, and pull the
full AEN header plus aligned payload before checksum validation.
That keeps short AEN packets from reading past the skb tail on the
AEN path.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-aen.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 040a31557201..cd34ef144cf8 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -16,11 +16,19 @@
 #include "internal.h"
 #include "ncsi-pkt.h"
 
-static int ncsi_validate_aen_pkt(struct ncsi_aen_pkt_hdr *h,
+static int ncsi_validate_aen_pkt(struct sk_buff *skb,
 				 const unsigned short payload)
 {
+	struct ncsi_aen_pkt_hdr *h;
 	u32 checksum;
 	__be32 *pchecksum;
+	unsigned int len;
+
+	len = skb_network_offset(skb) + sizeof(*h) + ALIGN(payload, 4);
+	if (!pskb_may_pull(skb, len))
+		return -EINVAL;
+
+	h = (struct ncsi_aen_pkt_hdr *)skb_network_header(skb);
 
 	if (h->common.revision != NCSI_PKT_REVISION)
 		return -EINVAL;
@@ -31,7 +39,7 @@ static int ncsi_validate_aen_pkt(struct ncsi_aen_pkt_hdr *h,
 	 * sender doesn't support checksum according to NCSI
 	 * specification.
 	 */
-	pchecksum = (__be32 *)((void *)(h + 1) + payload - 4);
+	pchecksum = (__be32 *)((void *)(h + 1) + ALIGN(payload, 4) - 4);
 	if (ntohl(*pchecksum) == 0)
 		return 0;
 
@@ -210,12 +218,19 @@ int ncsi_aen_handler(struct ncsi_dev_priv *ndp, struct sk_buff *skb)
 {
 	struct ncsi_aen_pkt_hdr *h;
 	struct ncsi_aen_handler *nah = NULL;
+	unsigned char type;
 	int i, ret;
 
+	if (!pskb_may_pull(skb, skb_network_offset(skb) + sizeof(*h))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* Find the handler */
 	h = (struct ncsi_aen_pkt_hdr *)skb_network_header(skb);
+	type = h->type;
 	for (i = 0; i < ARRAY_SIZE(ncsi_aen_handlers); i++) {
-		if (ncsi_aen_handlers[i].type == h->type) {
+		if (ncsi_aen_handlers[i].type == type) {
 			nah = &ncsi_aen_handlers[i];
 			break;
 		}
@@ -223,24 +238,25 @@ int ncsi_aen_handler(struct ncsi_dev_priv *ndp, struct sk_buff *skb)
 
 	if (!nah) {
 		netdev_warn(ndp->ndev.dev, "Invalid AEN (0x%x) received\n",
-			    h->type);
+			    type);
 		ret = -ENOENT;
 		goto out;
 	}
 
-	ret = ncsi_validate_aen_pkt(h, nah->payload);
+	ret = ncsi_validate_aen_pkt(skb, nah->payload);
 	if (ret) {
 		netdev_warn(ndp->ndev.dev,
 			    "NCSI: 'bad' packet ignored for AEN type 0x%x\n",
-			    h->type);
+			    type);
 		goto out;
 	}
 
+	h = (struct ncsi_aen_pkt_hdr *)skb_network_header(skb);
 	ret = nah->handler(ndp, h);
 	if (ret)
 		netdev_err(ndp->ndev.dev,
 			   "NCSI: Handler for AEN type 0x%x returned %d\n",
-			   h->type, ret);
+			   type, ret);
 out:
 	consume_skb(skb);
 	return ret;
-- 
2.53.0


