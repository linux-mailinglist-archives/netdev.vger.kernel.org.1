Return-Path: <netdev+bounces-306564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RPy3Apz0UGoh9AIAu9opvQ
	(envelope-from <netdev+bounces-306564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F1073B495
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:33:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=pviEuWzM;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306564-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306564-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3EC30158AD
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F42313E1B;
	Fri, 10 Jul 2026 13:33:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6B86329;
	Fri, 10 Jul 2026 13:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690381; cv=none; b=JCF09ED+JH7bbPCRqDYAF5zNSPndX6bA6u18HfUosIc4nI71p/Lr8T9ViwvO0lPOJdEH9o+6n0lFFS9kwM2nY3Xg9fBarl94T0XDEHtKyBQeiom/DTfMdjmNopsFNP34ICylTlD9V+JhdPJXpU8tgDVlJNwZEmlu8zvbQX3gK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690381; c=relaxed/simple;
	bh=bhDiKxoEwUFW8uGI1fuybDuF7q7LAs13VJURvA1+Zcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1vyTQWVEebZgp3d4AfHrNLcRfXiNGEcEpq37+NAZEWbMaYG1UBgRp2LhZONbYihTNsF0C5rsmRu79gIkbhNxyll0OIDalU7B+l4E0DgsFi7xK2grg9C0I1ALLP0EseV366Z63RQnfmdz84fb5lnjtTTD6zPnFrTEf7Vmcdx0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pviEuWzM; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jKWNcIAQGuJxJqjktfh3JBfLdnAx0v5jAErj9hzJok0=; b=pviEuWzMz/soHvvFsu7OpxGL8K
	biUVZMutQp9mZ+SyP0VgJxgHbMQSaPTrzMiMRHjjQyxSBAtabLHqgb3P9HfoVmgcfQbFL7eqtudEp
	LXBTUeuKJsF9QJk+4IFD5ip/TNPftP41EssGgjean6lw3kyEycN3pC6ELGQGv0uQO3/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiBLE-00Be7o-Bh; Fri, 10 Jul 2026 15:32:32 +0200
Date: Fri, 10 Jul 2026 15:32:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add EN7528 support
Message-ID: <f968d3fe-83dc-4b82-972b-0d4d477a1a52@lunn.ch>
References: <cover.1783680864.git.naseefkm@gmail.com>
 <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:naseefkm@gmail.com,m:netdev@vger.kernel.org,m:arinc.unal@arinc9.com,m:chester.a.unal@arinc9.com,m:davem@davemloft.net,m:angelogioacchino.delregno@collabora.com,m:conor+dt@kernel.org,m:dqfext@gmail.com,m:daniel@makrotopia.org,m:edumazet@google.com,m:kuba@kernel.org,m:krzk+dt@kernel.org,m:Landen.Chao@mediatek.com,m:matthias.bgg@gmail.com,m:pabeni@redhat.com,m:robh@kernel.org,m:linux@armlinux.org.uk,m:sean.wang@mediatek.com,m:olteanv@gmail.com,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:conor@kernel.org,m:krzk@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,arinc9.com,davemloft.net,collabora.com,kernel.org,gmail.com,makrotopia.org,google.com,mediatek.com,redhat.com,armlinux.org.uk,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7F1073B495

> +	/* The EN7528 LAN GPHYs advertise EEE by default, but negotiating EEE
> +	 * with common link partners (e.g. Realtek GbE NICs) results in an
> +	 * unstable link with dropped frames. Disable EEE advertisement on
> +	 * them.
> +	 */
> +	if (priv->id == ID_EN7528)
> +		for (i = EN7528_GPHY_BASE;
> +		     i < EN7528_GPHY_BASE + EN7528_NUM_GPHYS; i++)
> +			mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN,
> +						 MDIO_AN_EEE_ADV, 0);
> +

The problem with this is, you can still use ethtool to enable EEE.

Please look at phylink_bringup_phy(), where it calls
phy_disable_eee().

    Andrew

---
pw-bot: cr

