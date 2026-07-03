Return-Path: <netdev+bounces-304592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6NoAAljWR2pmgAAAu9opvQ
	(envelope-from <netdev+bounces-304592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C3703EAC
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:33:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=LVx809SB;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304592-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B15D300BE8C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8497277C9E;
	Fri,  3 Jul 2026 15:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA0236453;
	Fri,  3 Jul 2026 15:31:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092697; cv=none; b=mQvUQHoXpbgxUYqAt0Cmt9xBf2Wd5IhrUTr9GaPOsKhLuCeBC5jl6Xh90wvYSkxAsBhgXFRVXY6Yx7htUWm/WW0Z+PcKe5IWRY1BzAaOj14OWaWzP46Y8q8qvaIhfjmLMikH/VpxnGsz7mLCIoItNF33dMBmusvN15IHrTaIb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092697; c=relaxed/simple;
	bh=QC/6uZNy8zYI82J+rf1kQB4r799DDxx/ZhOG+OW1DXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOUY7VFJWGUKIQJlr/G8nFql1CnunRNm8PT0RV+9gHOoS3+KAb3NfgXvqbAYSltd2qvgOOuXLsL76FrYQTxYBE24Vo8P3VjRlljpKKNEvEb8wpEt88v70eoyHMzIQYr+TLekvZtULPympIJhmG9axJnWOtacS6+0NtvPxthn3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LVx809SB; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CgrTUblCPjxXhECL6iFBBKmla6JWWmq3mWzt7wMOPzY=; b=LVx809SBVvQuzEZGQcF9ebSlCl
	x8ZTSk7xYF+Sksq4MZhkYjH4b5I5pcyLFXFIL/ZV0ORj1TVupxoZ7vJSQqtvp0dfpUuxCo+PIcIKv
	kPfQ9NAQuoKEdP7LBN7wHBlgvhLs51ZVNm22JcKksk26tEv0Sur5gCc+q1w7/5Fh1Pgo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wffrQ-00AZDe-88; Fri, 03 Jul 2026 17:31:24 +0200
Date: Fri, 3 Jul 2026 17:31:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: write the ATU FID
 register on 88E6141/88E6341
Message-ID: <eadfade3-c46d-42fd-8301-3b2acebd7bcb@lunn.ch>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-1-fbd3a1bf8965@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-mv88e6x41-fixes-v1-1-fbd3a1bf8965@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304592-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD4C3703EAC

On Fri, Jul 03, 2026 at 04:42:55PM +1000, Luke Howard wrote:
> The existing code assumed the 88E6141/88E6341 did not have a dedicated
> ATU FID register because of its database count (256), instead taking
> the legacy path which resulted in the FID register never being set.
> 
> This resulted in every FDB entry being loaded into FID 0, breaking
> VLAN aware bridging.
> 
> Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")

Please submit fixes to the net tree.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> @@ -131,6 +131,7 @@ struct mv88e6xxx_info {
>  	u16 prod_num;
>  	const char *name;
>  	unsigned int num_databases;
> +	bool atu_fid_reg;
>  	unsigned int num_macs;
>  	unsigned int num_ports;
>  	unsigned int num_internal_phys;

Please think about padding. The current structure layout is not great,
invalid_port_mask should be somewhere else, but please don't make it
worse. Also, this structure has some reasonable comments. You have the
chance to comment that the number of FIBs does not imply if there is a
dedicated register, there are examples with 255 and a dedicated
register.

> diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> index c47f068f56b32..aa5adc78607ca 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
> +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> @@ -135,7 +135,7 @@ static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
>  	int err;
>  
>  	/* FID bits are dispatched all around gradually as more are supported */
> -	if (mv88e6xxx_num_databases(chip) > 256) {
> +	if (mv88e6xxx_num_databases(chip) > 256 || chip->info->atu_fid_reg) {

So currently, > 256 implies a dedicated register.  But do we need both
> 255 and chip->info->atu_fid_reg? I would probably set atu_fid_reg
true for all devices which have a dedicated register.

    Andrew

---
pw-bot: cr

