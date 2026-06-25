Return-Path: <netdev+bounces-301976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mv3rJQM5PWq2zQgAu9opvQ
	(envelope-from <netdev+bounces-301976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D796C68AD
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=wHXbjJXu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2886C3016274
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A842134B66F;
	Thu, 25 Jun 2026 14:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482E34041B;
	Thu, 25 Jun 2026 14:13:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396815; cv=none; b=QFbs4/rNL/9/TZhO9mIVQaN1Ghn0/QLo0+CnAOtNCtBPbNp/vAsFCM3WGc+U+SlCJbHqClOHDYA5gnPWf1x0300UmZmks3LdIqxi2QJuAVe9pka7++1HmFK8DFXvY26G7Ri836++Qp1iGn5lyG4CHRWrK+c/0u3LhGe4ukGgi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396815; c=relaxed/simple;
	bh=W8LfLYhskNUNLbZYP6fAdN6VqoJhy74OyG6BAyFTReM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ok7wl21PMfzV1jg+LWQOWBYdW6dkTHREF1PNoC6R3oQp52urI4uUL8jYHMYmGS4UBhBZsEswQ6wVxrTY9D9RKhw8JUzxmdkfRa2BqA24TYFIx3R5Phvs4MKxOMFfcdcpkAim/YNnwiB4Ld3GUxXdGEu/EjR4HV5tXs6JpImKSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wHXbjJXu; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5FA651A09B2;
	Thu, 25 Jun 2026 14:13:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E7535FF03;
	Thu, 25 Jun 2026 14:13:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B3FC104C9776;
	Thu, 25 Jun 2026 16:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782396808; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=k3XImR5LuwT8/GVFa0sNRFYkN/CDPKz36sZeNivR0Ps=;
	b=wHXbjJXutSwFzKdyBO+JadrL7vzZXU2Ju+iay6NC3mqD2OVKNOmpQcK+SqpaVzmb/kfhUw
	b9eJsyPs0swywCYolXBHA9sqiLCYmtT6uu9qlEbPcUoYONRWs4Qz3g9ycv/87AB2lXiaCY
	dVXvQeAZhwn9vqI4DnCISuk++CUKb6I/A1KPjM1BARbiKqito2vCTmjxITZn6c+TsasA/Y
	hgDUl7mLW9wPZQ94naWK5t7dGuiPvzFXNe/mc9zgn4DI6COoTOIcigvIHeeJPFhcpbK2qu
	LZ4JptlGAm20dUa3h0Eg3n2MoWAJ+oZYl9WKk/LHhvhj9PpkpYcIf2WUrIh4ow==
Message-ID: <a271385e-302d-45c7-a1df-aebd380b427b@bootlin.com>
Date: Thu, 25 Jun 2026 16:13:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 03/12] net: phylink: add
 phylink_release_pcs() to externally release a PCS
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
 <20260618125752.1223-4-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260618125752.1223-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301976-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06D796C68AD

Hello Christian,

On 6/18/26 14:57, Christian Marangi wrote:
> Add phylink_release_pcs() to externally release a PCS from a phylink
> instance. This can be used to handle case when a single PCS needs to be
> removed and the phylink instance needs to be refreshed.
> 
> On calling phylink_release_pcs(), the PCS will be removed from the
> phylink internal PCS list and the phylink supported_interfaces value is
> reparsed with the remaining PCS interfaces.
> 
> Also a phylink resolve is triggered to handle the PCS removal.
> 
> The flag force_major_config is set to make phylink resolve reconfigure
> the interface (even if it didn't change).
> This is needed to handle the special case when the current PCS used
> by phylink is removed and a major_config is needed to propagae the
> configuration change. With this option enabled we also force mac_config
> even if the PHY link is not up for the in-band case.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phylink.c | 56 +++++++++++++++++++++++++++++++++++++++
>  include/linux/phylink.h   |  2 ++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index c38bcd43b8c8..064d6f5a06da 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -158,6 +158,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
>  static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
>  
>  static void phylink_run_resolve(struct phylink *pl);
> +static void phylink_link_down(struct phylink *pl);
> +static void phylink_pcs_disable(struct phylink_pcs *pcs);
>  
>  /**
>   * phylink_set_port_modes() - set the port type modes in the ethtool mask
> @@ -918,6 +920,60 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
>  	}
>  }
>  
> +/**
> + * phylink_release_pcs - Removes a PCS from the phylink PCS available list
> + * @pcs: a pointer to the phylink_pcs struct to be released
> + *
> + * This function release a PCS from the phylink PCS available list if
> + * actually in use. It also refreshes the supported interfaces of the
> + * phylink instance by copying the supported interfaces from the phylink
> + * conf and merging the supported interfaces of the remaining available PCS
> + * in the list and trigger a resolve.
> + */
> +void phylink_release_pcs(struct phylink_pcs *pcs)
> +{
> +	struct phylink *pl;
> +
> +	ASSERT_RTNL();
> +
> +	pl = pcs->phylink;
> +	if (!pl)
> +		return;
> +
> +	mutex_lock(&pl->state_mutex);
> +
> +	list_del(&pcs->list);
> +	pcs->phylink = NULL;
> +
> +	/*
> +	 * Check if we are removing the PCS currently
> +	 * in use by phylink. If this is the case, tear down
> +	 * the link, force phylink resolve to reconfigure the
> +	 * interface mode, disable the current PCS and set the
> +	 * phylink PCS to NULL.
> +	 */
> +	if (pl->pcs == pcs) {
> +		phylink_link_down(pl);
> +		phylink_pcs_disable(pl->pcs);
> +
> +		pl->force_major_config = true;
> +		pl->pcs = NULL;
> +	}
> +
> +	mutex_unlock(&pl->state_mutex);
> +
> +	/* Refresh supported interfaces */
> +	phy_interface_copy(pl->supported_interfaces,
> +			   pl->config->supported_interfaces);
> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> +		phy_interface_or(pl->supported_interfaces,
> +				 pl->supported_interfaces,
> +				 pcs->supported_interfaces);

I've given more thought to that 'supported_interfaces' thing. This
patchset redefines the meaning of

  pl->config->supported_interfaces

Currently, it's filled by the MAC driver and means "Every interface
we can support, including the ones provided by PCSs that we can use
with this MAC".

It now becomes "Every interface we support without needing a PCS", at
least the way I understand that.

It's not an error in your code, but I think this is worth documenting
somewhere as this changes one the things that's already fairly
error-prone in new drivers.

I don't know to what extent people use that, be we have a porting guide
that explains how to use phylink in a MAC driver, maybe an update in there
would be nice as well :

https://docs.kernel.org/networking/sfp-phylink.html#rough-guide-to-converting-a-network-driver-to-sfp-phylink

Maxime



