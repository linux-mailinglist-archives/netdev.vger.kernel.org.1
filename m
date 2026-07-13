Return-Path: <netdev+bounces-307271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qw4fCcxEVWofmQAAu9opvQ
	(envelope-from <netdev+bounces-307271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231974EEF7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:04:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HgkFk3n1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307271-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307271-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE4023039C99
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886AA351C25;
	Mon, 13 Jul 2026 20:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472B3382F4
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:04:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973064; cv=none; b=jNnEiGEAvtLKQVexE53/FVUQlEyPAQJ1/LHOkT/3iRC4Ag834EfgWVDbbDYhgpEjBTTtTmsJ6KElX1xAdOrOY5avxi5i7z1axNQROKNcycL8vtVGoX/QGQUTSur8cyaDtRbnkYyAybi4nusSpGLQEqt0EE0hVXYfwBHCqAmtGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973064; c=relaxed/simple;
	bh=YF+KOotGzZmW5OzmRDV//DtHveaZ5nJeRsKupPRkt7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=six++qbpMpgOUrionsw+QghAlKSoSx/fhxpSxjAbvI0O0RBWzPBicsPHALnmEV5Ew8vC5ySFPRnGVkmArkU0+g2mLN3fB4Xs/tsRuZA+/Mks1tNm4dE0KCj6DfGbOmOPjxo7BhFbW+0N+lvLVKKO8obIA9ny9A9vkwXv0qnf54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgkFk3n1; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46f88060e8dso549854f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973061; x=1784577861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
        b=HgkFk3n111Uu2CWlsOwuDk71tx53WKuPJM4XSbnq8Ii8Al8FgRS7/TN9Ooc0SzS8Ih
         0z/155WlWBOAq8NfjKLt3MkWhLffWp4QKiOrJ1R+AWFtFmg6CofXbl8wSUQeCCfu7Bao
         rWKrDmeloj9iIvvyP4b5W1CuS+URN+R5CwHxvAuTgAygpTLENCSBV52PH7hi9PZ9H3Ac
         JG2QsBOeFw+RtnTSsWOselL9mWGqKryCSshJEjD38J0WcGBHAtSaFFpfgWceDYroEJWN
         I8OiG7NNZA6OsENsVIQ4PWzKDF1zXnjayvMoIVtbZv6QiyCcb67sCUbP5bkbMNXs6UcP
         Z7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973061; x=1784577861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
        b=debKZ4Z6Xqz8t2je5YMFb745bZnmQteqRPmEEmhu63DkgVemplnLsRXh/xD5FVucg6
         DdK42GypD9gXzpS5qYJqdfETSOoVG4J7asIGyuYi/6fG+d567pK3xJplI2mGoj4W06fR
         F7Jw98csF8y4GTZTMRvr5KQ1Dc8St1KAwjydmZIzRl45DGygN/XIgb1zEq7YtxT5puEP
         WlqUsdrLbUm8h/BRnsoChW1dtA61clU24VzE3b2WyBVKw7zf+cYoab31FLxz0bEzkMDL
         hm6y49IALSFsiom+Vz3EvZk8g+oT7ympvSdcP4EQdOhEoF7Up6wzJK1IfMbCJOypdGK8
         KePA==
X-Forwarded-Encrypted: i=1; AHgh+Rrf4jMpA16tUUE0oIAFijUgNOgKomCknwZa0YejQM0gQ0HoM6BR23dggWu+sPcCDLOT72YTnoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76x7HRDb1IhKBJcwwk+oAq4BR3eqB2HpDSrJWWdcWvPsJJzO7
	wgqx+kkqHVe0ZXJoFvjD7lWquctbE6qRcZ9X5PRwKyrMdMcy4NIXDkiu
X-Gm-Gg: AfdE7clxUbg5XRvs/Q8KU67MoHMYVR9qbcs/CW6UZCIflGy2oMsEcY3UajLhAXv+hlO
	f9kC9yoR2GolqfkWtmO51M0MjLjOAeVMZGBaAuBeUpsc6CJpGBAEasX/wnlxW+uhr2d2v9yvX8v
	xwmy8CCABlePHx6M0shLtoGme/VBNU+Aq9Xwbw3AapIUrxOvSorLA3JUzKlpWHBP2IfvuMfWXWM
	GICmmnh19dgr7SDfhNzYsKbmMev0a1AnG8N72L2+M+GiPM0j9tbiALFg8MFfwXZo9OCkx2D+RCl
	tiQuFiEgjzr7wVa5eXPQ7d6a+jdmiKuVwLTUlU5bCKlRR0Pu76Px3/H1Pr7zgCtozYkdclxE6rm
	NOojE7qNs/UAob2AaBKlY4JRXdvf4ajE6uJ0sADzHh36rvbdS68Yc0+/Zxua5pb7Bx80pa86AQq
	JKPtoA
X-Received: by 2002:a05:600c:4f94:b0:492:1e4d:d44b with SMTP id 5b1f17b1804b1-493f8835228mr59867925e9.8.1783973061275;
        Mon, 13 Jul 2026 13:04:21 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:d8f0:7a38:1703:914b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322c86sm17366115e9.11.2026.07.13.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:04:20 -0700 (PDT)
Date: Mon, 13 Jul 2026 23:04:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
Message-ID: <20260713200417.dghlrj4ca27b6nd4@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai>
 <20260713194010.54642-2-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713194010.54642-2-doruk@0sec.ai>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.ozlabs.org,queasysnail.net,ellerman.id.au];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0sec.ai:email,0sec.ai:url,skbuf:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6231974EEF7

On Mon, Jul 13, 2026 at 09:40:08PM +0200, Doruk Tan Ozturk wrote:
> ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
> destination address against the link-local range.
> 
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
> resolves to skb->head + (u16)~0 and the read is out of bounds.
> 
> On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
> done for the same class by
> commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
> and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").
> 
> Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
> Cc: stable@vger.kernel.org
> Found by 0sec automated security-research tooling (https://0sec.ai).
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I was not aware of the bug introduced by commit d346a3fae3ff ("packet:
introduce PACKET_QDISC_BYPASS socket option"). Commits
eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")

were made assuming that the bug to avoid would be exclusively a future
one (the revert of commit 6d1ccff62780 ("net: reset mac header in
dev_start_xmit()")) and thus they were not marked as bug fixes.

Are they true bug fixes, as in "can we reproduce these [using
CONFIG_NET_DSA_LOOP=y on virtually any network adapter]"? If so, should
all the commits above also be backported to stable?

