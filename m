Return-Path: <netdev+bounces-267896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GZcMJxZtmkDAwEAu9opvQ
	(envelope-from <netdev+bounces-267896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 08:02:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CFC290206
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 08:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68A89300E482
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036B2940D;
	Sun, 15 Mar 2026 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="txER8Kg9";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="awfVH11H"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A43BA21
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773558167; cv=none; b=Hlb5+6nUi+nYyz9bz0ikM4dBeYx6pz2Ucqe73gDk7fH1hGr98ouMSwRxaa0KtPT7Y2eYfnDH8WvtlBkFJC+FXZz/nawEQ7tJG4o7fRY/lJg9P8sMr9CDfrVWatBgeb+3z/Lji4Iitfg6r3PInFK2+68RZ1gDsLJlAJmhdauYYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773558167; c=relaxed/simple;
	bh=TGxhI6Vk3lH7/anHLok5wN584g0vZdCgnyeMCZQDUrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCSqc8DfBQNLxgzUY/AwkCkyaYTMJVDzwW/KEs7sBshLVPjFkUMRRGGd/+PFh+Ap+gKAnFQvpXSjaka+xLsrNviIGF8hI49QxX2GLXdOuS9YYyHlFGQTlsnLB/h6vT1NJKzzk9YRi2tyoe9ojhEqwYOzhpnJflKXFmbn33SDjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=txER8Kg9; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=awfVH11H; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=txER8Kg9ps/ry1599Q410NrYYw95Z75lov/Zgd1ZHXADcwPcU2+SkIasolsuloq/xZtTwFraSVpspJIpIXqYgoIib4rWbJFHG5839x01re/frDfodgJbS9RJCeeMuoM32h20jyCXpj6D0RnoFazwz+OB81yjmpsHM/woCkqiXIeB78XA2MLz57h0Aj1BqvUrkKkv1cRTQsdpHNVzhbe1kyOvocZr0NFkDFj8/+HwMuvEmOo/m+ViV0sVevAGt0DWe3Qmi87D9rtFsAbFymuIUI+KyV8XnRxCfAErEM+OceYXvx8rhDVD4HsUwcv0HLNfxsnSwZ+DemoDvit6n6ACCg==; s=purelymail2; d=tinyisr.com; v=1; bh=TGxhI6Vk3lH7/anHLok5wN584g0vZdCgnyeMCZQDUrc=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=awfVH11H6DLHJfVEFWCfrTborc7zC7Jy2NFwYYvhHPTVQ/XwX37XRQyEUJM5KKbDMcIUvUtUwU2JFrsb86xFziLL29hwaxC+5FCfOIEWoamaCItywL2S04Zj0DM1U22pdZqm0GOBY+kFRqqo11D32+QYC9CZVoAn5VRuZ0KLwyyJtm0O8egVPhRpgXlNjt5Z+Hf6l8QUCG4iWAxSHAXobdFVxAX+mP0I76/B745zei61GWYMnd9EsnYS6jMo6HL+EBV2Pg4LK74LX+YyBzLrKPWWdFfqqmeLSfe3+yiDLyg3kwiAbctmP/4gMecD4bwSDSNjFWVE5KBJTpUiWoyetw==; s=purelymail2; d=purelymail.com; v=1; bh=TGxhI6Vk3lH7/anHLok5wN584g0vZdCgnyeMCZQDUrc=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1857942808;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 15 Mar 2026 07:02:32 +0000 (UTC)
Date: Sun, 15 Mar 2026 09:02:25 +0200
From: Joris =?utf-8?B?VmFpxaF2aWxh?= <joey@tinyisr.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC v2 3/3] net: dsa: initial support for MT7628 embedded switch
Message-ID: <abZTnRlDRFl2deFY@archlinux>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-4-joey@tinyisr.com>
 <abXyKK4wxiBySHI2@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abXyKK4wxiBySHI2@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-267896-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purelymail.com:dkim,tinyisr.com:dkim]
X-Rspamd-Queue-Id: B4CFC290206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 11:41:28PM +0000, Daniel Golle wrote:
> > The switch has 5 built-in 100Mbps ports (ports 0-4) and 2x 1Gbps ports.
> > One of the 1Gbps ports (port 6) is internally attached to the SoCs CPU
> > MAC and serves as the CPU port. The other 1Gbps port (port 5) requires
> > an external MAC to function.
> 
> I thought port 5 is a dead-end on MT76x8. Afaik it was only used on
> Ralink Rt3052 for RGMII/xMII with this switch IP, and not wired to
> any external pins nor to an internal MAC on all other SoCs which came
> after.

I assumed this was true as that's what the datasheet says, but looking
at the pinout it really doesn't have any pins to attach an external mac.

> > +	  This enables support for the switch in the MT7628 SoC.
> 
> And potentially many others (Rt3052, Rt3050, Rt3352, Rt5350).
> As support for the Rt5350 is present in mtk_eth_soc at least that
> sounds like it would be worth mentioning (or even naming the driver
> and tagger interely after rt3050 which is the origin of that IP
> block).

The RT3050 does not support all the same features the RT5350 does (which
I believe the MT7628 is based on). The DSA tag is now set up in a way
that only the MT7628 and potentially RT5350 can support. The DSA tag
does not appear to be working as described in the datasheet on these
switches and I do not have any of the ralink switches to test this on.
I don't think it's a good idea to assert support for hardware that has
not been tested with this.

I thought it would be fitting for the driver to be called after the
MT7628 as that would be the first supported SoC and add support for the
ralink switches later.

> > [...]
> > +static void mt7628_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				    struct phylink_config *config)
> > +{
> > +	config->mac_capabilities = MAC_100 | MAC_10;
> > +	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
> 
> This looks a bit wrong.
> Aren't all 5 PHYs internal? PHY_INTERFACE_INTERNAL would be best to
> describe them then. And doesn't the CPU port (6) connect with 1000M,
> if so it should have MAC_1000 set as well (as neither the Ethernet
> driver nor the DSA driver do anything to configure the interface that
> is purely cosmetic, but still)

Will fix this and coding style issues in v3.

> Iff you want to support port 5 on Rt3052 (which will also require
> setting the correct interface mode in .mac_config) I'd expect something
> like this:
> 
> config->mac_capabilities = MAC_100 | MAC_10;
> 
> switch (port) {
> case 0...4:
> 	__set_bit(PHY_INTERFACE_INTERNAL, config->supported_interfaces);
> 	break;
> case 5:
> 	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
> 	__set_bit(PHY_INTERFACE_MODE_REVMII, config->supported_interfaces);
> 	__set_bit(PHY_INTERFACE_MODE_RMII, config->supported_interfaces);
> 	__set_bit(PHY_INTERFACE_MODE_RGMII, config->supported_interfaces);
> 	config->mac_capabilities |= MAC_1000;
> 	break;
> case 6:
> 	__set_bit(PHY_INTERFACE_INTERNAL, config->supported_interfaces);
> 	config->mac_capabilities |= MAC_1000;
> 	break;
> default:
> 	return;
> }
> 
> If you don't want to deal with port 5 you should skip it here as well.

Will skip port 5 for now, due to this driver likely not working on
RT3052 as it is anyway for the aforementioned reasons.

Thanks for the review.

