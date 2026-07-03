Return-Path: <netdev+bounces-304453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzezKPB4R2pOYwAAu9opvQ
	(envelope-from <netdev+bounces-304453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:55:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACA700534
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:55:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Di6ZMyIH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304453-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304453-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F011930477F5
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734E33A9DA;
	Fri,  3 Jul 2026 08:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2633D6C0
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067940; cv=none; b=nuylgvYHQxzdoVSlDQNIofjBSiwSNWFARl3zyydWvtigQg/QwzgU3A/0koY+nUJjPlqkJwbaKb+H02CYp5tUMq8Wv1EXiJSWz2kLlb1PePHbPyK0Gg3Vn9qHAyAKqxzKUZqtaqWmKCh9paBcuXoOyToRdY/IzjRDSsXtr8+Ds5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067940; c=relaxed/simple;
	bh=2Mw4C8cP0ikdSYP87ULxE42c8XBOd2yv7kzUvLAoAOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjUL3sCMgJ64gNNKmdeg+1xuDni0KUtDP5Gz4fkewKZxywl1ZdNVrE5W2ZcaVC5tupx1RCGRGdZLAUEcasHlfvZOmubj9DVj1kFUjgadEQFz2Lq63hpfFhVmsX+t1S08e9rVtbVfGUkZOt+5/fz6VbPkDVXGKPNoBJPN8SgY3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di6ZMyIH; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace7da66eso2874105ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783067938; x=1783672738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9S390maFuLWYl6z3JcBWyDaB6H00jCR0tOf9HccGvs=;
        b=Di6ZMyIH8ltZYvdBkB8JanOcWS5t64BqqK1pGO7MhaI30a7OkWCZbuwU9H0EM8wUXq
         zX7Hsg3p1l+RYBkuOf91Q13Z3I7q2Z6hbyov7Yw66YELd05K6gFH2KJLr2e9cjZYPa0/
         AkNTpGRSbpRftEa2ixMQCaagKvcXTmvj35M/iW9YZyjxHsMXeRNLjI5LoqwAuNyGbQmC
         gkpPGbiRYDlKZMx0TEHRBdwsudeGzXp3JFAiVQw2BBCVrf+SWFdc7w/u9QVBlRgKehrA
         16b56Ec/PX1ty+VM3NFT34HSGBPoBQrhd6c9gqGcpXv6GlV3nIdvtkxwKda6nc/AYdOm
         WS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067938; x=1783672738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9S390maFuLWYl6z3JcBWyDaB6H00jCR0tOf9HccGvs=;
        b=ScaURC/9tgoI+1cn2Ssl2Il9a2VVYRIHdyZ/c6ZrkP8s7X/v5SRBmia8bNwXtNmzyh
         /t2qdbuhPnozs5h4NHdRbS9wNpnCdbzUOPFtF5Pr46MsiMpxAiJ1EyK+psQGdcPEBdYt
         47dy6/a0FYV6ufccR8C46fFb23FqMuF2wBWIOPzYe5/UcM7yL9GOFYILEo50DiPKSqyl
         KffEIUdFBH/DJmWVoog76loA0ct4zQiQ1iPDbMrt2wN9EPkuMmhBOPETHNn8R0wfdOmW
         WLDI972eE9L7FQhgFRvPXGlkq17vrf9Q5C0tp2i1+mKsOK+oms3Qts0oHWvuaDGC/gHa
         Q73g==
X-Gm-Message-State: AOJu0YwELlFVuJaStSdYktOJHLXoU+fx920BMA7P0AEVopU4HJUytdNE
	KYezkmcJyd/jtbylWm5S1b+LDJvrwQCiN9uk4k5KikKak/msLFs9Cx0k9RYxm7G1
X-Gm-Gg: AfdE7ckD6MwoEf5o9p0+Xt3pLeJ+HDiDMn2J16b6TiL1IjKPJg3drBobB22/98xWhnZ
	3yy0hbYqgWEYo94sbdOZ2EH1YOkHA1pzacxfoKLygUEsMVXAvuHDj8pcBXuypto2Sngyj0KuLUh
	4XsnfbYEL0ozAvnDACp7GKw0a8dt4p6fIjUD/8Ou9Hugew/++pcw3fiB0jNnp0S4NaXCLD+dfkB
	1gsTWwLIL+0DGxXjQ4MAM0xnLtBPlMS42vYg2Zn3sVcWm1GbX9JJtEkWipVnfI+jqRhIfJFlCey
	6ba3oYcLsRAMA+pHbLfp1T5PDD6GkgEdmoZKZXGsh3MHUFOujIS8KKW/tlaZJXjSJAhHuV52OPQ
	Q2DCLnbfJTNCZsDh+lpIVYBAUkfPvvcUPbDtvYNTl84KCxcjDe1vmBlygo9wUUdXusPEzH+rRao
	yt+ptrSNdMDJstj5MR7r0fW3hg
X-Received: by 2002:a17:902:ef07:b0:2c9:b1ed:eb5d with SMTP id d9443c01a7336-2ca7e8ebde3mr113691185ad.47.1783067937746;
        Fri, 03 Jul 2026 01:38:57 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f23061sm5954145ad.5.2026.07.03.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:38:57 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] macsec: don't read an unset MAC header in macsec_encrypt()
Date: Fri,  3 Jul 2026 17:36:33 +0900
Message-ID: <20260703083634.2035145-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304453-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:4ncienth@gmail.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0ACA700534

macsec_encrypt() reads the Ethernet header via eth_hdr(skb)
(skb->head + skb->mac_header) to memmove() the 12 source/destination MAC
bytes forward and make room for the SecTAG.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches the macsec ndo_start_xmit() with the MAC header unset, so
eth_hdr(skb) resolves to skb->head + (u16)~0 and the read is out of
bounds: a 12-byte heap over-read that is also emitted on the wire as the
frame's outer source/destination MAC. KASAN reports a slab-out-of-bounds
read in macsec_start_xmit() on 6.0; on current mainline a CONFIG_DEBUG_NET
build flags it as an unset mac header in skb_mac_header().

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), added
by commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
macvlan_broadcast()") for exactly this purpose.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index fb009120a924..dd89282f0179 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -646,7 +646,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	}
 
 	unprotected_len = skb->len;
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	sci_present = macsec_send_sci(secy);
 	hh = skb_push(skb, macsec_extra_len(sci_present));
 	memmove(hh, eth, 2 * ETH_ALEN);
-- 
2.54.0


