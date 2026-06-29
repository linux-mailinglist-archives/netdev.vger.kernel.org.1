Return-Path: <netdev+bounces-302474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T3ZZD4cdQmrv0QkAu9opvQ
	(envelope-from <netdev+bounces-302474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:23:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2746D6F50
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:23:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="of/X3b2p";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302474-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3EEB30ABED0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695A3C10A7;
	Mon, 29 Jun 2026 07:05:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEE3C1083;
	Mon, 29 Jun 2026 07:05:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716708; cv=none; b=pNg8xXK8x7vzPFMZhd6Pxm6s9c+3NOtF5VbTRHvS710Tvw6u3t3nuHqcRnrODMftQ0DjcZbQ5madOouXokXraf75A7m61HfVY9HA5zT/FNy8Eb08G0oBTJHvEwuTFrU/9jsrYlDWympjsw5oU1kJkxpERIRyMRwX2RsX7D1+epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716708; c=relaxed/simple;
	bh=S1hzlPC8gANr8aZdGiGeYuKVTflE4DxyuYbmc5JiOPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPjDuOr5n0qxsSsxinBJVGkKXmwb+BhhDoGKmJnUlPJQLm0FJD67tjeTaEgcAku1hFq8Pyz7eS96oO1Ym269iDuNLtMzzojT6A95o3dxUs/sDzKaMDEO0CnTy+j3mQ8pvez4EsRdNlL0+uKfJvtSnvckZekBDevtqB+UkLgEEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=of/X3b2p; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 25924C5145C;
	Mon, 29 Jun 2026 07:05:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2419A5FF96;
	Mon, 29 Jun 2026 07:05:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AF9B106F14DB;
	Mon, 29 Jun 2026 09:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782716701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1rsMIqeUo7w/8HQ084SMthYLAbPCuimMFz6Hr3QOyaE=;
	b=of/X3b2pqHw09oeoNd1OvSXDh4fwfA+/kKLRQreFdmzEqIgfhOA1Qr/ndrgAS+GDHD1foq
	YVUwy2UDChvK8VCKa8bl8WHPu/RGbgHx65vTU8qf5QhD+0SjO+EkaJQD+PiMQRKealgon9
	TuDtgKRkFFgrshWTzAVAX0UEKPDekcNslGvvWEwSaHcY0QSWF9ruFjP5u+SRAQ0XeASqZc
	cYPYWionzUmVuXiJgbsoK9MfyrKHSIylnjEV4Hxv2eg1bnCcvScdtVZk2m50nfz7Mpw8Ir
	N/mi42ewOEIx03TM2HzKhOkVMoYeeWZgwbOT1qao8LyiML3z7WV7A+3DF6KRQw==
Message-ID: <178defc6-8e60-4b0b-b3b0-f0f2a4003b68@bootlin.com>
Date: Mon, 29 Jun 2026 09:04:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 03/12] net: phylink: add
 phylink_release_pcs() to externally release a PCS
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
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
 <a271385e-302d-45c7-a1df-aebd380b427b@bootlin.com>
 <6a3fc312.6161eb1e.3441bb.c0de@mx.google.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <6a3fc312.6161eb1e.3441bb.c0de@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D2746D6F50

Hi Christian,

On 6/27/26 14:33, Christian Marangi wrote:
> On Thu, Jun 25, 2026 at 04:13:14PM +0200, Maxime Chevallier wrote:
>> Hello Christian,
>>
>> On 6/18/26 14:57, Christian Marangi wrote:
>>> Add phylink_release_pcs() to externally release a PCS from a phylink
>>> instance. This can be used to handle case when a single PCS needs to be
>>> removed and the phylink instance needs to be refreshed.
>>>
>>> On calling phylink_release_pcs(), the PCS will be removed from the
>>> phylink internal PCS list and the phylink supported_interfaces value is
>>> reparsed with the remaining PCS interfaces.
>>>
>>> Also a phylink resolve is triggered to handle the PCS removal.
>>>
>>> The flag force_major_config is set to make phylink resolve reconfigure
>>> the interface (even if it didn't change).
>>> This is needed to handle the special case when the current PCS used
>>> by phylink is removed and a major_config is needed to propagae the
>>> configuration change. With this option enabled we also force mac_config
>>> even if the PHY link is not up for the in-band case.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/net/phy/phylink.c | 56 +++++++++++++++++++++++++++++++++++++++
>>>  include/linux/phylink.h   |  2 ++
>>>  2 files changed, 58 insertions(+)
>>>
>>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>>> index c38bcd43b8c8..064d6f5a06da 100644
>>> --- a/drivers/net/phy/phylink.c
>>> +++ b/drivers/net/phy/phylink.c
>>> @@ -158,6 +158,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
>>>  static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
>>>  
>>>  static void phylink_run_resolve(struct phylink *pl);
>>> +static void phylink_link_down(struct phylink *pl);
>>> +static void phylink_pcs_disable(struct phylink_pcs *pcs);
>>>  
>>>  /**
>>>   * phylink_set_port_modes() - set the port type modes in the ethtool mask
>>> @@ -918,6 +920,60 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
>>>  	}
>>>  }
>>>  
>>> +/**
>>> + * phylink_release_pcs - Removes a PCS from the phylink PCS available list
>>> + * @pcs: a pointer to the phylink_pcs struct to be released
>>> + *
>>> + * This function release a PCS from the phylink PCS available list if
>>> + * actually in use. It also refreshes the supported interfaces of the
>>> + * phylink instance by copying the supported interfaces from the phylink
>>> + * conf and merging the supported interfaces of the remaining available PCS
>>> + * in the list and trigger a resolve.
>>> + */
>>> +void phylink_release_pcs(struct phylink_pcs *pcs)
>>> +{
>>> +	struct phylink *pl;
>>> +
>>> +	ASSERT_RTNL();
>>> +
>>> +	pl = pcs->phylink;
>>> +	if (!pl)
>>> +		return;
>>> +
>>> +	mutex_lock(&pl->state_mutex);
>>> +
>>> +	list_del(&pcs->list);
>>> +	pcs->phylink = NULL;
>>> +
>>> +	/*
>>> +	 * Check if we are removing the PCS currently
>>> +	 * in use by phylink. If this is the case, tear down
>>> +	 * the link, force phylink resolve to reconfigure the
>>> +	 * interface mode, disable the current PCS and set the
>>> +	 * phylink PCS to NULL.
>>> +	 */
>>> +	if (pl->pcs == pcs) {
>>> +		phylink_link_down(pl);
>>> +		phylink_pcs_disable(pl->pcs);
>>> +
>>> +		pl->force_major_config = true;
>>> +		pl->pcs = NULL;
>>> +	}
>>> +
>>> +	mutex_unlock(&pl->state_mutex);
>>> +
>>> +	/* Refresh supported interfaces */
>>> +	phy_interface_copy(pl->supported_interfaces,
>>> +			   pl->config->supported_interfaces);
>>> +	list_for_each_entry(pcs, &pl->pcs_list, list)
>>> +		phy_interface_or(pl->supported_interfaces,
>>> +				 pl->supported_interfaces,
>>> +				 pcs->supported_interfaces);
>>
>> I've given more thought to that 'supported_interfaces' thing. This
>> patchset redefines the meaning of
>>
>>   pl->config->supported_interfaces
>>
>> Currently, it's filled by the MAC driver and means "Every interface
>> we can support, including the ones provided by PCSs that we can use
>> with this MAC".
>>
>> It now becomes "Every interface we support without needing a PCS", at
>> least the way I understand that.
>>
> 
> Wait but with the current code using the OR logic, it still follows
> "Every interface we can support...". The modes that needs a PCS are
> specificed with the pcs_interfaces mask in phylink_config.

you current code is correct, I was mostly concerned about the doc
that goes along with it :)

So in the end, we'd have something like (simplified):

pl->config.supported_interfaces = RGMII_xx | SGMII | 1000BaseX
pl->config.pcs_interfaces = SGMII | 1000BaseX

pcs->supported_interface = SGMII| 1000BaseX

correct ?

> 
> The late add and release operates on the phylink supported_interfaces ONLY
> when the MAC didn't specify support for it (by removing it as only the PCS
> will declare support for it)
> 
> The confusion is present because everything is validated later on
> major_config so those supported_interfaces are just an HINT that are later
> verified with get_caps and with the pcs_validate OPs.
> 
> Adding the supported_interfaces to phylink is really to keep an original
> reference of the value. This is to address a pattern I have notice where
> the MAC driver always OR the interfaces with the one supported by the PCS.
> (I remember it was pointed out by Russell)
> 
> But I'm more than open to discussion as this is something marginal to the
> whole implementation, I'm also questioning if this OR is actually useful to
> anything on the nth tought on this.
> 
> One thing that I notice is that parsing this early with AND might be
> problematic at phylink_create, but I still have to evaluate that.
> 
> My take is that would be good to have some review also on the other logic
> as I think I reached a point where Sashiko starts to comments on more or
> less unreal problem.

True, TBH all the fwnode part is something I'm a bit less familiar with though
so maybe someone else can browse through that.

FWIW, I've tested that whole series on a board that has "legacy" PCS board
that has mvpp2 and 2 possible PCSs, and it seems to work fine so no regressions
there :)

A side note with the "legacy" naming, I'd rather have it called "built-in" or
something like that, I don't see a clear path to porting the existing code to
fwnode without breaking DT compat, as it's likely we'll have to remove the PCS
register ranges out of the MAC's range. 

Thanks for this work anyway, this is great !

Maxime

