Return-Path: <netdev+bounces-261730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPdBCOU3oWkbrQQAu9opvQ
	(envelope-from <netdev+bounces-261730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:21:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D621B32DB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C458307078E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F43D903C;
	Fri, 27 Feb 2026 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7PwSHWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323926B756
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173281; cv=none; b=b0xs4z/e3NkTJy7840PThAzIfT6KgW/6blrkIz4SHxzWZqeo6pjQh6DMJf6e9f609PzdBTY1ytTjr/aCRks74v3xeI+0nncbtUFpxQPJ21Zr+VavSlTm6xxOaT6wByj5/q9RhGNzN7aR/Dk69opdSOn6el98D1YAxe6Eznq2njU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173281; c=relaxed/simple;
	bh=5DB6r2eGa84AcW440fmyv1J01MFlLdmp3d3rHgWXkGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaBKhofE3UhZH+42+7p8rJgyisc0Q13UOcz9ZbxZQuI/Jc38AYCHvbviKlccHXirIiPWowx07Oz4d9xDUVmKxw8aIIdeVarqvT5ReNHUh4uDrcYV31wD9IifSY9Q0pNN7i3Zft9VafuywViB6boTXaBqFK/R9um4b/X23yfg6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7PwSHWd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824adc96ad2so1737771b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173280; x=1772778080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mwj0TsO3rZmOSUGtHVEu9OCniT19qm1BOQwi4yuWyo=;
        b=m7PwSHWdpVndY4YvytPT3jSPuJASZjCOjYliHfBYqNN/RrOgbM9lccV3QqQdMeW08A
         /iDXLHQsx7TuwEFkUh6+zgmLTQlJQAxpbajrEWSgS2DCIcnluBk69MibM6i9yLDk9kQS
         W+OXUjSX8L4Ky3ZMC2qfsTji/8zN1ASnd9mrB4arl9FKpxYYs8FzLYwSJ6Fpysn3ogkX
         oHyoYtUsCkOEJnNKmG3ABQfd87scckfNsKI6rl9S4JjZkgrsQ2pEouOa/OfeEJwLo9c3
         vem7uvJQlt2G1Ks3v8W0+jC543AwMz4P02qk7so/uqeR6AL/5+idhKkn4Ttl1mpvovTC
         Nd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173280; x=1772778080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Mwj0TsO3rZmOSUGtHVEu9OCniT19qm1BOQwi4yuWyo=;
        b=D89cpksYd3IdcRrpxNb5FJMval7Vujua6JS1B+UdJWFcCP7HaTEdHClBXPdl72w5Lo
         j+aN/wHvJRm+AdrfMA8Ck/2j2pXQt4gyE3v4PLz7zoFkwFAqGM2vS2Q4R4Fi4tn3+xmX
         A5USCIZLQCA0X878XbP4Ak8tw6Wc4eOSKrAePpv0gA3e8t/fRy6eQqmB+VJmlN6W7O2e
         lRei5WPmV9/Kn39pZQMhcymNnK5OygYQrhnJ2lnTfthSS1nlVwZGBFTbrQ1aj89llOYI
         tZWuwDYl1e3K8P3oxg814PmL2dUIcxjlI+rS5ZH95Awmdp62kqNnPpPIx3ZnlpdCjBWl
         9GKw==
X-Gm-Message-State: AOJu0Yy7ptfgslKGfAvQDP5bMoToDp8NJTrceYTfplFzneU4v06TYV8C
	+8yM4OZ3zPOn+odfay/ry65dHtz+gmP6sQy7z9vP9WeXWRHvrj0LmA4A
X-Gm-Gg: ATEYQzwasJjg9yFevPIU3E1kTvkmZK96UKqYsEzTr/D1C25Vit4eeYMtOyt4GgigiH+
	dAJbfxTOIKR9CCCyV7VEHbs5w9MmtZo+XCoripEHFO/1V68RM1UZqYMA0g5dAnuFHNp2IAkwH91
	GixDMWufS06h4lcvAxFhciyJAgp29mnfkMY9jK+aMR56Pq8ASwSF17MJ0Zw0N1X7rvoNPyMkkk9
	DcNmpqij0H8M9k5x5J6qwGgfxY3BZ7mRzePLN9eTdPxoQv6rNdOibLc+8/+nI6YZyERD76SV/8i
	TLYZvygLn2QTFyqF/wWmE2pNrrqNFP37XxmdLZRsGyisp6xRYNhb59Vfz22HqmFxzDaS0JQ1GIW
	TLbbJqT3ciXbKdhmnYbRBFKmyT91CIjKCMKYVheANwlQBcmiJMeXtIku4g7viij61wALA6yVCjs
	lUfgr/9rR1UA1sMIP+suRr/nojGX2UFJFj6382kQ==
X-Received: by 2002:a05:6a00:179f:b0:821:81ef:5dec with SMTP id d2e1a72fcca58-8274d98e6c1mr1716794b3a.8.1772173279754;
        Thu, 26 Feb 2026 22:21:19 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c5e9sm4062509b3a.2.2026.02.26.22.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:21:19 -0800 (PST)
Date: Fri, 27 Feb 2026 06:21:12 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when
 disabling a port
Message-ID: <aaE32DlfrX9S5KNT@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-2-liuhangbin@gmail.com>
 <942584.1772155015@famine>
 <aaEB6X6WPs7EBM33@fedora>
 <949695.1772167347@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949695.1772167347@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261730-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,if4:email]
X-Rspamd-Queue-Id: 82D621B32DB
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 08:42:27PM -0800, Jay Vosburgh wrote:
> >> 	I'm not sure I'm seeing the problem here, is there an actual
> >> misbehavior being fixed here?  The port is receiving LACPDUs, and from
> >> the receive state machine point of view (Figure 6-18) there's no issue.
> >> The "port_enabled" variable (6.4.7) also informs the state machine
> >> behavior, but that's not the same as what's changed by bonding's
> >> __disable_port function.
> >
> >Yes, the reason I do it here is we select another aggregator and called
> >__disable_port() for the old one. If we don't update sm_rx_state, the port
> >will be keep in collecting/distributing state, and the partner will also
> >keep in the c/d state.
> >
> >Here we entered a logical paradox, on one hand we want to disable the port,
> >on the other hand we keep the port in collecting/distributing state.
> 
> 	"disable" the port here really means from bonding's perspective,
> so, generally equivalent to the backup interface of an active-backup
> mode bond.

Oh, got it.

> 
> 	Such a backup interface is typically carrier up and able to send
> or receive packets.  The peer generally won't send packets to the backup
> interface, however, as no traffic is sent from the backup, and the MAC
> for the bond uses a different interface, so no forwarding entries will
> direct to the backup interface.
> 
> 	There are a couple of special cases, like LLDP, that are handled
> as an exception, but in general, if a peer does send packets to the
> backup interface (due to a switch flood, for example), they're dropped.

OK, this makes sense to me.

> 
> >> 	Where I'm going with this is that, when multiple aggregator
> >> support was originally implemented, the theory was to keep aggregators
> >> other than the active agg in a state such that they could be put into
> >> service immediately, without having to do LACPDU exchanges in order to
> >> transition into the appropriate state.  A hot standby, basically,
> >> analogous to an active-backup mode backup interface with link state up.
> >
> >This sounds good. But without LACPDU exchange, the hot standby actor and
                         ^^ I mean with LACPDU exchange..
> >partner should be in collecting/distributing state. What should we do when
> >partner start send packets to us?
> 
> 	Did you mean "should not be in c/d state" above?  I.e., without
> LACPDU exchage, ... not in c/d state?
> 
> 	Regardless, as above, the situation is generally equivalent to a
> backup interface in active-backup mode: incoming traffic that isn't a
> special case is dropped.  Normal traffic (bearing the bond source MAC)
> isn't sent, as that would update the peer's forwarding table.
> 
> 	Nothing in the standard prohibits us from having multiple
> aggregators in c/d state simultaneously.  A configuration with two
> separate bonds, each with interfaces successfully aggregated together
> with their respective peers, wherein those two bonds are placed into a
> third bond in active-backup mode is essentially the same thing as what
> we're discussing.

In theory this looks good. But in fact, when we do failover and set the
previous active port to disabled via
  - __disable_port(port)
    - slave->rx_disabled = 1

This will stop the failover port back to c/d state. For example, in my
testing (see details in patch 03), we have 4 ports, eth0, eth1, eth2, eth3.
eth0 and eth1 are agg1, eth2 and eth3 are agg2. If we do failover on eth1,
when eth1 come up, the final state will be:

3: eth0@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
    bond_slave state BACKUP ad_aggregator_id 1 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 10

4: eth1@if4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
    bond_slave state BACKUP ad_aggregator_id 1 ad_actor_oper_port_state_str <active,short_timeout,aggregating> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync> actor_port_prio 255

5: eth2@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
    bond_slave state ACTIVE ad_aggregator_id 2 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 1000

6: eth3@if4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
    bond_slave state ACTIVE ad_aggregator_id 2 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 255

7: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    bond mode 802.3ad actor_port_prio ad_aggregator 2

So you can see the eth0 state is c/d, while eth1 state is active, aggregating.
Do you think it's a correct state?

Thanks
Hangbin

