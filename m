Return-Path: <netdev+bounces-307270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NWsPECpAVWpgmAAAu9opvQ
	(envelope-from <netdev+bounces-307270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE374ED95
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:44:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b="Rt0Okg/R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307270-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307270-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF41E3120F64
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8AB35AC28;
	Mon, 13 Jul 2026 19:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0435A952
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 19:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971623; cv=none; b=ulPXDOzKgpbKywKQROTl3ywYnaDF8K405dDRld2T1d1ZDd1mqQQM4KcWwBBinBLvBrJVAVA2CQwXZLQNNSA7jGvc6nmXJvU0gMbLMA9kMDqtDQmABLO+nW7aHDMGfAV4L/yjsLNOxJCV0betLlvTnP7/NGgQ6ySr5eIn4Ca8Tpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971623; c=relaxed/simple;
	bh=Qb2HIoMSqWqjQCWpGfmBQN/eCpG6jcj8qiqVtJGiIdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5rlgfkB9FTxNkdyjGbyTyj1WlBWUqn1luaGkR6dXAqFilbai0g1M7g1VFceW/IVlvFAJgj1a08P3bcbBsU7uoqdgviyFeOHBZPUtiIJqe9re26Sxob319yeoN6KEhyAR7+Z8QvXmifJylO2g9XIK9IQwXeIK37yo53cvp+EvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Rt0Okg/R; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso2006682f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971620; x=1784576420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
        b=Rt0Okg/R7m2LYzMem/ylCjKCEzz69c8dLbMOcZti5wRcXsg1ktmSA7lar8vT1POltc
         eA/DCf7sMTam6DmzQZ/uEG2ycSY6mvUcI4pFSQ0BCat8nNIZKSEZDAYqO29MgEKL7meO
         1jCh+8ortx6Q5Z4RMUuxOsoyX4yl5iHU+ST0bVip6L2s+VseD+vroJwrM0SVba7N1hlP
         Y2g6GRcfneRw45jJH8hU29kg2YDHdPXmIqHdMnSCLSZlvXHPuhDbTWFG33wlqeLNGhUI
         fmt9B2yuuAk74yNuvkCKFGFWNVYwvqsoQTr098cRgvM8Ilcb9jQsQCXblbI6Bj2EnJm9
         grrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971620; x=1784576420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
        b=pumed2L7Gp9G2cGlrArOOjUwtfV6HSjzxOw15rDbIUkn1yapK5zCVIhG995Jt/msgV
         gatgK47W69jO7u+2KRLaOreEhK8cu5M7cl71RMgCnrpgpCBzQzKxbg/gI12DvH1+CXXH
         QyhQVOy4Zu4d40L042c8y0Nxyf43qs2f60xT+s6Te2HmW/GiVUCBIlzExbpPtHeyM21f
         +KXE2oHkv4G6BneSpe3hh952CKaKXe2yaWcxaj9gvVb3DF0CtopIEWOk4iJP0MZkX8bv
         qOn5Y5Ayekz0SRnWHGsKod3oBpAZz9ZvueuN24KNRvV2o4A/5vQdD5drip633tnR7DwM
         RMUQ==
X-Gm-Message-State: AOJu0Yzg6Hd/d40JDUJKf6kPJfOjTe28lGSR/+f40tFlFRbsBFJJ/Uiq
	D7UXxyRc6jFbNzU6C0HhveUWzcavso52EJaJNiiRKC6bBmYBx1W93bQUvFawayVERl0E
X-Gm-Gg: AfdE7clMh/Zi355KKrFuUkrJzWU011IE4QwgEhrk+v8F8p/eBvysyKVTwHVdHO42W6h
	Yg/ITD3W/aI0d9mJhkDfpuIuV+F/dA6Y2Ylj2003eWbQ//jw2gd3tTlQVKz6L0KSh9iXebge9CX
	pyEmHN1t9Ob1HofWxwE4ZJfBAEY7GItwnrvFFaAd75et+k9MFXFkeDoMoA8LoaAkWoFGdfabx2n
	QPkNqUMDx1kmhE/sx2JUn3fIohpGzXZROWdYOKybiYhbWoyHI60TdAV3ZMdGEUnXD1B323gjHlN
	1Ho8nbca5aab8X7fx1yZI8tWyhA6G7EGQkaPkvKX0Ijzukzdxbvo8K99EdmIqrTIVi0wVI3Fo8+
	pNymiNF6FejBKxAgBAuYzzSwPiRxYpTsuF28SVNOVJPRT5amnAc8TEM6I1nCbdvQyd2dMajxCFe
	FQlNWrgwnQNCUGET49oMyxRlj1i4Q17vj26uo8zw57dGYABKyWJbtyd2dJogw3Gsxf8Tg2grSs5
	L145ydKAotjP0tVlcJP/ds2PVb3+YEmihc=
X-Received: by 2002:a5d:5846:0:b0:474:9002:c74a with SMTP id ffacd0b85a97d-47f2dced169mr11560342f8f.35.1783971619960;
        Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] ibmveth: don't read an unset MAC header on transmit
Date: Mon, 13 Jul 2026 21:40:10 +0200
Message-ID: <20260713194010.54642-4-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307270-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5DE374ED95

ibmveth_is_packet_unsupported(), called from ibmveth_start_xmit(), reads
the Ethernet header via eth_hdr(skb) to test the destination address.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 6f2275433a2f ("ibmveth: Detect unsupported packets before sending to the hypervisor")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..88e8bdfbcd11 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1218,7 +1218,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 	struct ethhdr *ether_header;
 	int ret = 0;
 
-	ether_header = eth_hdr(skb);
+	ether_header = skb_eth_hdr(skb);
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-- 
2.43.0


