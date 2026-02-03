Return-Path: <netdev+bounces-256424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nv2KaxAgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:38:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85937DDB32
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9EA300E3BE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305C631AF36;
	Tue,  3 Feb 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="SKXZxLwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQxYEvLN"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F5202F65;
	Tue,  3 Feb 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143693; cv=none; b=K+jovxg4pdfCNsPzVntxi6YiKoCRpck2MSIYMDbJ8fqM777UO6WlZ06sET9/jmR4ThIpcy+IfBH9/fcphceFPzg5jQJd+yie/ZPr8Ye1qG8vyq9CvRN9DnY3ULhcb/8+iP1cOE6A7mSwfBDWq1FVdRtdvRxuaPJxmI3UhvhHGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143693; c=relaxed/simple;
	bh=ECmelJBaqyGNiD2vnRDgfRp+nr1Dh/Qeutkkkz1FrVw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=X9rhH01Die1P91+VZtiv5YhrmAF6QJShq8jigU79nZZ2h3VpbWuvcDxf4JQ76TDsPB9JfjLKlHoGUv5RrMq7UGCj8R5Fxwqj8+He2YEtbqY6kqyQXeiCtwZVgg1yBD0FjjefolniaoSszZILhhNDY5+wkheggq8bbXLSuqaAUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=SKXZxLwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQxYEvLN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B6E514000BD;
	Tue,  3 Feb 2026 13:34:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 13:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1770143690; x=1770230090; bh=qEombbxD7AaWE27qfwFKA
	4BMIF7QB219y+ImKglEtlo=; b=SKXZxLwKWf83TiZKdFnFrA64mM7YISjqlgP6w
	a/QP7OUa3J0f2xhNbl0SnerdHM8eOVLilQA3v1OF//qwgPspzVWVa2dXP7n9Zru9
	yEFgBaAjmbwGlp8ERlvszIrols3zAFW9VQV7JC/Dn1oQ5lQXEIyQGrPSA/ZVTdR6
	dQlna2C0i61rxjx1DpQQjB+48DBoq1piKM4/E5XvJnuwa/WaG6Qkx79cOotWtEu7
	fEIYmSBtMDK+sTIz/UZRZCx2boU48mZ0CtCh1G1Vq9wUlaJMq0X3lVTNe2HVHc8E
	qahgR5+u4Ilygkhq0f3MiTNXU5CZzVbwnvn4uCiYRYid2uLFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770143690; x=1770230090; bh=qEombbxD7AaWE27qfwFKA4BMIF7QB219y+I
	mKglEtlo=; b=uQxYEvLNOX6+FH+X2YOdNhilp0jRi+0bqSk4p5Vk/IfcSnWw9wN
	+yg4IPFqJ54plrd3MmulUcC/oArf9LFIz90WLqQiUjso2mCSsKNZooQ3gIyw9SZV
	S+6YgNHFqwVO6bGuMXIqGewF6x3PCm/6vxptd6u73fl2I+pV2ihQJaduh3pElQxS
	d3xHjs6B2A/QqJQ4uzTOtDPfFk4pKvSbapCu1QsWtZIQOsGnbnZtOuzdFKtfS8Z8
	KzAE9s+fT7RE6+yIUla0mtOwfGt7VJBLmKVnqR8Aegg/q5lOq7Ry3NcqV2Wq8aOL
	hgaeDeIVN5lVyUk1W7r4lHwBQk+76PmvAjQ==
X-ME-Sender: <xms:yT-CaachSLR_6SUfoBi2nOWjTyY9KxiSE6qHSWPxfY6hJt3T5xpv8Q>
    <xme:yT-CaZITc3Y1tEztK7Ewdt_UkvBnQe34QyckHTKpQbwtE8efjHDR-mXkz1fSbHYPA
    UZ3ZoywOTjkfE4aB4cCO7fxQhG8WTu9c_kJDyQmicna0_Q58LsyQEo>
X-ME-Received: <xmr:yT-CafywrPra_Z7GEJ8NPJUG4-Mgdv_i-y_4NK58jrqubGEaKUDPC-cHLqjZz_1XszJcBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifphgrnhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepthgsohhgvghnughovghrfhgvrhesshhushgvrdguvgdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yT-CaXt5e6Rtbj_GU5Fnt51sv_h8JUuhippBp_AMaHBOW3eHXj1Oyg>
    <xmx:yT-CaaA3ImhzuP3YUK3CS6PXCZlAOQrBSFuDtwCHdcNKZ0uc6fMyzg>
    <xmx:yT-CaRFW15Mus9zDcVzD-jTJipoFtxqaE82oJw5ljfMOavc2-EOanQ>
    <xmx:yT-CaSAkVfN8haHckfsiLjBBwFxFBjbSbwLdbIciLCti0RLAza9Cgw>
    <xmx:yj-CafXwHyx0Obj5ynpqtXvn3rhE5KjzUy-rH8qHDIDz8gsMGMTmd-d9>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 13:34:49 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 8B83A9FCAE; Tue,  3 Feb 2026 10:34:48 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 861C89FCAA;
	Tue,  3 Feb 2026 10:34:48 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Weiping Pan <wpan@redhat.com>,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] bonding: only set speed/duplex to unknown, if
 getting speed failed
In-reply-to: <20260203141153.51581-1-tbogendoerfer@suse.de>
References: <20260203141153.51581-1-tbogendoerfer@suse.de>
Comments: In-reply-to Thomas Bogendoerfer <tbogendoerfer@suse.de>
   message dated "Tue, 03 Feb 2026 15:11:52 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4098145.1770143688.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Feb 2026 10:34:48 -0800
Message-ID: <4098146.1770143688@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256424-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 85937DDB32
X-Rspamd-Action: no action

Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:

>bond_update_speed_duplex() first set speed/duplex to unknown and
>then asks slave driver for current speed/duplex. Since getting
>speed/duplex might take longer there is a race, where this false state
>is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
> update port speed when getting bond speed") this race gets more visible,
>if user space is calling ethtool on a regular base.
>
>Fix this by only setting speed/duplex to unknown, if link speed is
>really unknown/unusable.
>
>Fixes: 98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE")
>Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	I think this Fixes tag is fine, it's far enough back in time to
be effectively all stable releases.  The actual change in the patch is
obviously correct, as well.

	-J

>---
>v2: corrected fixes tag
>v1: https://lore.kernel.org/all/20260130111904.144024-1-tbogendoerfer@sus=
e.de/
>
> drivers/net/bonding/bond_main.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index e7caf400a59c..4cdf89b21ca0 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -791,26 +791,29 @@ static int bond_update_speed_duplex(struct slave *s=
lave)
> 	struct ethtool_link_ksettings ecmd;
> 	int res;
> =

>-	slave->speed =3D SPEED_UNKNOWN;
>-	slave->duplex =3D DUPLEX_UNKNOWN;
>-
> 	res =3D __ethtool_get_link_ksettings(slave_dev, &ecmd);
> 	if (res < 0)
>-		return 1;
>+		goto speed_duplex_unknown;
> 	if (ecmd.base.speed =3D=3D 0 || ecmd.base.speed =3D=3D ((__u32)-1))
>-		return 1;
>+		goto speed_duplex_unknown;
> 	switch (ecmd.base.duplex) {
> 	case DUPLEX_FULL:
> 	case DUPLEX_HALF:
> 		break;
> 	default:
>-		return 1;
>+		goto speed_duplex_unknown;
> 	}
> =

> 	slave->speed =3D ecmd.base.speed;
> 	slave->duplex =3D ecmd.base.duplex;
> =

> 	return 0;
>+
>+speed_duplex_unknown:
>+	slave->speed =3D SPEED_UNKNOWN;
>+	slave->duplex =3D DUPLEX_UNKNOWN;
>+
>+	return 1;
> }
> =

> const char *bond_slave_link_status(s8 link)
>-- =

>2.43.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

