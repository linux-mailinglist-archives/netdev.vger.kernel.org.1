Return-Path: <netdev+bounces-306554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xCBPCvLvUGoX8wIAu9opvQ
	(envelope-from <netdev+bounces-306554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1873B205
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:13:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=fl2dIF6A;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306554-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306554-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5E973013020
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D536CDFD;
	Fri, 10 Jul 2026 13:13:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DB329C60;
	Fri, 10 Jul 2026 13:13:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689197; cv=none; b=NM6HGh4PjtTM68fqFwDpYehn5Wo/PeNdl7ezaRAZZj02ICkTRVkexSlJytECZUVzvIby2pgc+ooOLirc3aiRuxPnfzRPLevQYRJ4eHuzrhJHCN7TAxCQS7pm8Bn3pdFc/VHy5ebQEaQURvAUCjXbHcY764DbUVcUyU5SoO1vKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689197; c=relaxed/simple;
	bh=d2QyDrs945TnluIMf34hy7lClFButS9NlGOeRk9czVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIAsPG21IS/qVsOexk9jO2yWLi5VWgm38FVA7lrWxRomllsv1a0guNBb/K07TwWBKXHyYCcbng4/ubkkFzKvoiq+hsCKL+ob6Vc1EboumgQwM74/vGhhjdukXfvSByZ0b+MxTMzzeIkU54s66TL19IAowk79Jhqw1QIVhBgeQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fl2dIF6A; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nSS3kAob3BJ4oEKJED+ufHWz0ooPsoMZ7Zqd8yLDlwE=; b=fl2dIF6A4q4crS4yv7vJpMQXUl
	Nv4riM/q1KMHDt/YhOYCqebqs0yTbToWZobkJigp3xOhk4UIrP3wlTKwm346zXW3vIe1ijL0S8f7O
	nMxrKv+ZXHfPYVqEEtDzZrc1Mwbzm4sVDbi65ndiBz1XrkeqRD9AgPFT3Xsz3MpLaVAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiB2J-00BdyZ-4j; Fri, 10 Jul 2026 15:12:59 +0200
Date: Fri, 10 Jul 2026 15:12:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xiaoning.wang@oss.nxp.com
Cc: Frank.Sae@motor-comm.com, leitao@debian.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	xiaoning.wang@nxp.com
Subject: Re: [PATCH net V2] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Message-ID: <5d55cc0f-4b9f-42df-880a-290faf201cc8@lunn.ch>
References: <20260710080018.1070789-1-xiaoning.wang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080018.1070789-1-xiaoning.wang@oss.nxp.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[motor-comm.com,debian.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,nxp.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiaoning.wang@oss.nxp.com,m:Frank.Sae@motor-comm.com,m:leitao@debian.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:xiaoning.wang@nxp.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DA1873B205

> @@ -2490,7 +2490,8 @@ static int yt8521_get_features(struct phy_device *phydev)
>  		/* add fiber's features to phydev->supported */
>  		yt8521_prepare_fiber_features(phydev, phydev->supported);
>  	}
> -	return ret;
> +
> +	return ret ? ret : genphy_c45_read_eee_abilities(phydev);

Using a ? like this is very uncommon.

Please change it to the usual

        if (ret < 0)
               return ret;

	return genphy_c45_read_eee_abilities(phydev);

It might also be better to put the test after
yt8521_get_features_paged() call, since that is the only place missing
the test.

    Andrew

---
pw-bot: cr


