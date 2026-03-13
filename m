Return-Path: <netdev+bounces-267624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHfcB6OQtGl0qAAAu9opvQ
	(envelope-from <netdev+bounces-267624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:33:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3B28A723
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFC2130C5FC8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CFF382F00;
	Fri, 13 Mar 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TOTppMoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0FF386C28
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441064; cv=none; b=o11NquLJLtnWATHvpY4t8fMO+y4jM0uPI42dIdmVDhzDIrrMd3H9x3+o7+gTZ4hf2vGDDg2YJ54VFsOtuePp2YB56KScqIaItEMgTyUHp0S3ZNxtX3jb4hp1oiTrHGFLHvP+ZsJwXRsibzSUdII4KOw9hgIa95XaeWzLR4b3vxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441064; c=relaxed/simple;
	bh=4mx+e9oVG6CrcMMG3/eO6hOms8NOKTTMBQ+YcrRMFRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP36q0iq/DHdoiVmTT7UzWkVgFyZUXbsqCpJDodN7PJ1eBfdVCZH++qHJjQMcfWiTqEOeLWT7j6sUy+TfCMk/PJDfaG4eaNlASvChRhMH+R7zIPMbZ6YO1sMLji2FPUAkUQbPUL0OX4wygJbw2xfAZJHf0qSJsuvICQCKml3E94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TOTppMoQ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4671cbce465so1378686b6e.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441061; x=1774045861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0xGdOzKFMVP5ynlZwdIR9piZg01nlaRfSX1gpCcslY=;
        b=TOTppMoQ8aJarVmSBMuAdvj9iapkP7dnGWIJ0NJ7lCwzKF/Xan6tFKV9eodJ299Cse
         i8wPJW6SUZ9TSfOi95aeoY4CatQb/pB8CNyQmzKuXcwhnhnM2c0Wn6b42SbgG5KP33ZI
         eGMS9FKiOgGevk6WJGUdHXhnnfxrw2zMmLoCG+Ie7wRuWbxzEpx+WD8K8jQ/5YKcc8VY
         DHHLsuHS2AuBUfuCkxzinJQ6hV2QFEZvXhl3JHEoXRMYu5g/EBzEFoSCCF9NJ88MuuAD
         OWt0IZ+/HmcKYTbqloZMmsRQAqQckarFrAmMPvWPoTQa7Em6nLvfS38m6oUtZTkzY4IU
         IUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441061; x=1774045861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0xGdOzKFMVP5ynlZwdIR9piZg01nlaRfSX1gpCcslY=;
        b=T1+sR0v33CCHSR6thsCP3is3aJTftySn3aqYWP0HnMepG26ntxLnFdkFm+2H2mzthp
         4sLxwzp4KCJ1Kpd1ls73qXbZXtQxm6pF0KSrkyvvcWXI8fX5qT8xUCtgOSdeGOaTFcF0
         5t2onvp6xX0utz16hYBYCw0WvqW7PVLgveM59AN2/7eWCJ4mdyNuOQ+II0zbVMfoIeSq
         xP9MYL+R50dSr7LJjcZVDzLqBKMdN/REavKgYQ4X/ary8YmZ1DOMoktw6XaBHkI4Rzfn
         5vWD2EH3Rj06JqQrk//iF6Hg3EWtRPvQRzs3GNdvQY+kPTwbVIJj5npoz9Ck8iXGg3sy
         cv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK+iUOlTslagXHn6EmeZ0LPf74Huwpz/nNStdVB5b0y0slcoH8RtIYjW0JWflTng1e4btqi98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRhQoDxoOZABhgnhcYP61MBGJOUet+CVLzuQfy6QSpKGraTB5
	mYKxP1/aIc+TB4Vt+GRHy7a2D8YJe3QyyHLwO+CZJn7kfowvZ/BXesj0ELCE5ScZMvs=
X-Gm-Gg: ATEYQzx2wyqlaMgodOmkymvIFTn/otvLwKgIcyyVFTbpN2k5fiB5eAfUxqzltnu4Bva
	N0FUqZTr4kvdjnqvhmQ/QIzy7Y/m/Cu3FskKUlDLd4jon6cLpySI6aXIUQnuFdn28lp8jMzsTX9
	VzOGtp3olOBQP8bp8t+sMej+c4nN8pBN1vqPcZERj31rbxX49AVGscnpgD7x0+BHGTvse/Mj3Ai
	qDgLtFpReIQhhFx4VkjJzfA6TL8K4Q1MGVUQ1XIgaZv/2boBn6I2LJ+bGema69y9sjW/G7YGlYU
	AQKHvOTZBhyBIgc/JwOD9u1T4VqZocyZR5byJGJlIe6IshKjt2C4ZoSFom8rZEkDpwXeAEbnE5r
	EWC/eW5jZxt7TOkrrzeelit/Z57skOzYS0Rnt57C5+H2Rc6Lb1ZA0ezBe8UyQoB+Lz54HpzQzkA
	N965lIhSi5
X-Received: by 2002:a05:6808:4704:b0:467:11fa:40a1 with SMTP id 5614622812f47-46757598a6amr2320563b6e.43.1773441060705;
        Fri, 13 Mar 2026 15:31:00 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:59 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 4/6] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
Date: Fri, 13 Mar 2026 17:27:34 -0500
Message-ID: <20260313223029.454755-5-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313223029.454755-1-carges@cloudflare.com>
References: <20260313223029.454755-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267624-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: C5B3B28A723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds another conditional when cmp_type is CMP_TYPE_RX_L2_V3_CMP for
drivers that support this completion format.

This re-uses bnxt_rss_ext_op to provide similar functionality. One
limitation is for L4 hash-types, protocol-specific bits can't be
determined.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v4: re-uses bnxt_rss_ext_op
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 1f920464b426..babcd463e50e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -514,6 +514,16 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 		default:
 			break;
 		}
+	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
+
+		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		else
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+
+		if (bnxt_rss_ext_op(bp, rxcmp) == PKT_HASH_TYPE_L4)
+			hash_type |= XDP_RSS_L4;
 	}
 
 	*rss_type = hash_type;
-- 
2.43.0


