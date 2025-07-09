Return-Path: <netdev+bounces-205222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4845FAFDD39
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E0D3B00EB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF013B797;
	Wed,  9 Jul 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="So0hTQ+Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BaMPqH9R"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C69182
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026662; cv=none; b=aIdUeB2cGFC3Sg8tjVl+1QqopD2cPEfEj5SBEDv0Bx62Tb1zEzTVAWU3pUz2I5KSj5KZFv2nslq7O677W1bcZD8ueVuWbFaqw91DZhNaHMGq5y5mNnYiubQAPVclKGdZdHIpTJXV8KdfiFSJVIwMH2r7+SGPpP63H3y00KwtwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026662; c=relaxed/simple;
	bh=XnO/mefn/BY42+J2Q+oGCkFU8d5/VvIdH/9MxrhEH+M=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=hRl3+uv8W5Kh0msKyU4sDdz0o1infv2Dsm+vnFPYyH9gi6oE3mlvn5T8A6I+m28ePZgIY19gl6sHD7i5QMu+7mfFW2z6EaKAouah3FVL6lcX98kNaPLijLWSLdT28wGo0cvD8cfYSQ9yDDUB35vE9vV27F1yXkehEfblo+ifg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=So0hTQ+Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BaMPqH9R; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36B137A004A;
	Tue,  8 Jul 2025 22:04:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 08 Jul 2025 22:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1752026658; x=1752113058; bh=T5VUJ3OOcAj1QWx4AOc31
	hI1MI0EhIzHSJvgZCAS4jE=; b=So0hTQ+ZxXXl3PVkcspzmN/+4EtaxzCLV+0Xq
	WfTP5+okJu/AseIbnAW3hWd641ye0cRZcyWInPn2IUFDfaK+A+qXyc+RuE8z4TZH
	0Qklt3dOqe7LhmjZ1DnMuNEXHvOtBuqOifG4yhNXL+iZLI6pxYLG3f3KwElYD/PW
	jzOho05ApL5jiLuQOONmuprM04EOGNZ/R4LsbL+NNC2OalOy3UzDiz8sTtYyegqr
	lcwPd+Fbh5eMq+yie8iRKYXgI/wlN3lUEmTbueJPRPFhZnPucxRHJs3D9ImbaP1p
	EBa1/LqgAIehPLgrrQEWLnJKEbaCT8F9r7+Xg0Hafc4iyKE/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752026658; x=1752113058; bh=T5VUJ3OOcAj1QWx4AOc31hI1MI0EhIzHSJv
	gZCAS4jE=; b=BaMPqH9RaM8T4fo+dlJcW2h7MGwi4T6mMdg4fKFtjwoFy4lLpDJ
	CSeu3VC+fj0ozNzm+NiEL34g3pawuFsDdz8pkXp2MPz6vGqVhYvsNyA3Ke7Vg+3x
	SDRMs+DNAYuKfTOKdhGVjAfYesTQaryDbGVxRMZYlQWjt0HZq4bp55mYlp3blFTw
	VQGPFfvLuleycw1GZADBqKwAEqlIqI0ZqXt84HHfBwRK8Wd8pAq+jGNCil8Nexed
	JoumMtOxEwbfYxsBCJowfJ8hjavY76LFX0NJoNo026wuYffLYggJ/4t7DvR3qJMS
	kd1nUm77mG4+hHhOTtPbWSm5UQb8VqGTlHw==
X-ME-Sender: <xms:IM5taJRITLjKyEPo7Y1NuK3IX3nh2VHfYNiXkrsCd89wYcJk1bDbrg>
    <xme:IM5taCehmst3waPfjhqYW_igwKnEw5SOcOST_QC-ul8Zgq8VXxlqKUsTgcJk5xDax
    z4c6ea_boMHmVnK0gI>
X-ME-Received: <xmr:IM5taKctDGJLc9dfq9ueRcuoPIca3haVyU6DVWLckHoUH2kdcqvm1AC_FkgRqcSz2eU5Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprh
    gtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehtuhiivghnghgsihhngh
    esughiughighhlohgsrghlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhn
    vghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:IM5taM29dY8vUzfe2qv9ZLw-EXggsO7a3fOMyyKyA6Q8nRoGMNeZ4A>
    <xmx:IM5taC_RiJMmhOR4hj9Lns1_3Ig-nI3Fs8udTCSh7eczz_Gz0312wA>
    <xmx:IM5taB5mUCau_dYMNsCYiefQ-qRCMeApbuTS7PgZ2tHK5T4iOwm5dw>
    <xmx:IM5taKvZ03B_tp_wTcwCJW7OptVJkUsyAu3dbLH-Hpu9WzI5uK1Rdg>
    <xmx:Is5taD_7j96CMyG_lVH7njsARbEJMPXnTPSQR5mQ2auBUi2xN71CJVYf>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 22:04:16 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 5D7A99FC54; Tue,  8 Jul 2025 19:04:15 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5A7689FC3F;
	Tue,  8 Jul 2025 19:04:15 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next RESEND] net: bonding: add bond_is_icmpv6_nd()
 helper
In-reply-to: <20250708123251.2475-1-tonghao@bamaicloud.com>
References: <20250708123251.2475-1-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Tue, 08 Jul 2025 20:32:51 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <196742.1752026655.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jul 2025 19:04:15 -0700
Message-ID: <196743.1752026655@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
>instead of pskb_network_may_pull() on tx path.
>
>alb_determine_nd introduced from commit 0da8aa00bfcfe
>
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Cc: Nikolay Aleksandrov <razor@blackwall.org>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>---
> drivers/net/bonding/bond_alb.c  | 32 +++++++-------------------------
> drivers/net/bonding/bond_main.c | 17 ++---------------
> include/net/bonding.h           | 19 +++++++++++++++++++
> 3 files changed, 28 insertions(+), 40 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index 2d37b07c8215..8e5b9ce52077 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -19,7 +19,6 @@
> #include <linux/in.h>
> #include <net/arp.h>
> #include <net/ipv6.h>
>-#include <net/ndisc.h>
> #include <asm/byteorder.h>
> #include <net/bonding.h>
> #include <net/bond_alb.h>
>@@ -1280,27 +1279,6 @@ static int alb_set_mac_address(struct bonding *bon=
d, void *addr)
> 	return res;
> }
> =

>-/* determine if the packet is NA or NS */
>-static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
>-{
>-	struct ipv6hdr *ip6hdr;
>-	struct icmp6hdr *hdr;
>-
>-	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
>-		return true;
>-
>-	ip6hdr =3D ipv6_hdr(skb);
>-	if (ip6hdr->nexthdr !=3D IPPROTO_ICMPV6)
>-		return false;
>-
>-	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
>-		return true;
>-
>-	hdr =3D icmp6_hdr(skb);
>-	return hdr->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT ||
>-		hdr->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION;
>-}
>-
> /************************ exported alb functions ***********************=
*/
> =

> int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
>@@ -1381,7 +1359,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bondin=
g *bond,
> 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
> 		switch (skb->protocol) {
> 		case htons(ETH_P_IPV6):
>-			if (alb_determine_nd(skb, bond))
>+			if (bond_is_icmpv6_nd(skb))
> 				break;
> 			fallthrough;
> 		case htons(ETH_P_IP):
>@@ -1467,16 +1445,20 @@ struct slave *bond_xmit_alb_slave_get(struct bond=
ing *bond,
> 			break;
> 		}
> =

>-		if (alb_determine_nd(skb, bond)) {
>+		if (bond_is_icmpv6_nd(skb)) {
> 			do_tx_balance =3D false;
> 			break;
> 		}
> =

>-		/* The IPv6 header is pulled by alb_determine_nd */
> 		/* Additionally, DAD probes should not be tx-balanced as that
> 		 * will lead to false positives for duplicate addresses and
> 		 * prevent address configuration from working.
> 		 */
>+		if (!pskb_network_may_pull(skb, sizeof(*ip6hdr))) {
>+			do_tx_balance =3D false;
>+			break;
>+		}
>+

	It's nice to consolidate some duplicate code and use the more
efficient skb_header_pointer, but the above will do a pull anyway for
nearly every packet that passed through the function.

	Would it be better to not use the bond_is_icmpv6_nd helper here,
but instead call skb_header_pointer directly, and then reuse its
returned data for the hash computation that occurs just after this point
in the code?

> 		ip6hdr =3D ipv6_hdr(skb);
> 		if (ipv6_addr_any(&ip6hdr->saddr)) {
> 			do_tx_balance =3D false;
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 17c7542be6a5..a8034a561011 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5338,10 +5338,6 @@ static bool bond_should_broadcast_neighbor(struct =
sk_buff *skb,
> 					   struct net_device *dev)
> {
> 	struct bonding *bond =3D netdev_priv(dev);
>-	struct {
>-		struct ipv6hdr ip6;
>-		struct icmp6hdr icmp6;
>-	} *combined, _combined;
> =

> 	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
> 		return false;
>@@ -5349,19 +5345,10 @@ static bool bond_should_broadcast_neighbor(struct=
 sk_buff *skb,
> 	if (!bond->params.broadcast_neighbor)
> 		return false;
> =

>-	if (skb->protocol =3D=3D htons(ETH_P_ARP))
>+	if (skb->protocol =3D=3D htons(ETH_P_ARP) ||
>+	    (skb->protocol =3D=3D htons(ETH_P_IPV6) && bond_is_icmpv6_nd(skb)))
> 		return true;
> =

>-	if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
>-		combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>-					      sizeof(_combined),
>-					      &_combined);
>-		if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>-		    (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION ||
>-		     combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>-			return true;
>-	}
>-
> 	return false;
> }
> =

>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index e06f0d63b2c1..32d9fcca858c 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -29,6 +29,7 @@
> #include <net/bond_options.h>
> #include <net/ipv6.h>
> #include <net/addrconf.h>
>+#include <net/ndisc.h>
> =

> #define BOND_MAX_ARP_TARGETS	16
> #define BOND_MAX_NS_TARGETS	BOND_MAX_ARP_TARGETS
>@@ -814,4 +815,22 @@ static inline netdev_tx_t bond_tx_drop(struct net_de=
vice *dev, struct sk_buff *s
> 	return NET_XMIT_DROP;
> }
> =

>+static inline bool bond_is_icmpv6_nd(struct sk_buff *skb)
>+{

	Minor nit: no need to specify inline, the compiler will decide.

	-J

>+	struct {
>+		struct ipv6hdr ip6;
>+		struct icmp6hdr icmp6;
>+	} *combined, _combined;
>+
>+	combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>+				      sizeof(_combined),
>+				      &_combined);
>+	if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>+	    (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION ||
>+	     combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>+		return true;
>+
>+	return false;
>+}
>+
> #endif /* _NET_BONDING_H */
>-- =

>2.34.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

