Return-Path: <netdev+bounces-260550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDNoE+yynWnURAQAu9opvQ
	(envelope-from <netdev+bounces-260550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:17:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C8188423
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45BC53058581
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBAB3A0B0B;
	Tue, 24 Feb 2026 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dGQK4B5f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D23A0B24;
	Tue, 24 Feb 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942588; cv=none; b=VxpKscj5D9hgVavf2Xwy0kFe1aObiqcBAHfGeqeven0mjfjiVJrfjd6eE040rx9bTAge6uvBY0wetfQSMyYbClWJc7cDJJDwBWWoYN0U5qSyA5vh8cKf2ecsaXbFO55M1BIVvewUEySir67fxHauZG5YEdA7dGVzWgSlpMw0hHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942588; c=relaxed/simple;
	bh=3WFNIEpIpKjMRWISmMFfQNY5diha/HFuSSjbuEju7PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPdMn/fVReKOEip9E6OW1WVWZrtBzSjw9MU75uG085j/cipz1d163ePpiNpjoUuZ9suEW+AhyxyeNwzZ5Sldj87pT6chX+gajq0k+0nvdpTmwl+3dLoDI9mk0O9Lj0KzkTDBv5moFQ6/7JpIDBwmRSnCGGqhPfXJ2IF+GkjzGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dGQK4B5f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U2X9R9BxoDYD8cWYw2myWhpi+Eh7wrFFlz8lj3AcueE=; b=dGQK4B5f8LjFggKycQH2+1O/JG
	6/14KOc2r4tmCrnmz0qG2yelkhabvt5aXdMgXcAGZT6m/UoTj5dw4OYqfuVv6/7251NF5PL+eywMd
	5XeCkT6w75DTDqXcYpmiL10tTcj/yr3NqBuON7icSsPkxd59gDWnjXxheO2k88Ts1SFc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vutCl-008c1Z-HP; Tue, 24 Feb 2026 15:16:03 +0100
Date: Tue, 24 Feb 2026 15:16:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: add Rust reference driver for
 ET1011C
Message-ID: <e19108f8-956b-4b95-92be-f49303964200@lunn.ch>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
 <20260224043211.1747-1-iprintercanon@gmail.com>
 <20260224043211.1747-4-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224043211.1747-4-iprintercanon@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260550-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ax88796b_rust.rs:url]
X-Rspamd-Queue-Id: 6E3C8188423
X-Rspamd-Action: no action

What board are you testing this on? This is a pretty old PHY, and
nobody has done anything with it for a long time.

> +const BMCR_FULLDPLX: u16 = uapi::BMCR_FULLDPLX as u16;
> +const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;
> +const BMCR_SPEED1000: u16 = uapi::BMCR_SPEED1000 as u16;
> +const BMCR_ANENABLE: u16 = uapi::BMCR_ANENABLE as u16;
> +const BMCR_RESET: u16 = uapi::BMCR_RESET as u16;

ax88796b_rust.rs also has:

const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;
const BMCR_FULLDPLX: u16 = uapi::BMCR_FULLDPLX as u16;

Can these be shared somehow?

> +impl Driver for PhyET1011C {
> +    const NAME: &'static CStr = c"ET1011C";
> +    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x0282f014);
> +
> +    fn config_aneg(dev: &mut phy::Device) -> Result {
> +        let ctl = dev.read(C22::BMCR)?;
> +        let ctl = ctl & !(BMCR_FULLDPLX | BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_ANENABLE);

It is pretty unusual to clear these bits in BMCR. BMCR_FULLDPLX,
BMCR_SPEED100, BMCR_SPEED1000 are only used when autoneg is
disabled. genphy_setup_forced() will set them, if
needed. BMCR_ANENABLE will be set when auto-neg is restarted.

Is there any hint in the datasheet why this is needed?


> +        dev.write(C22::BMCR, ctl | BMCR_RESET)?;

BMCR_RESET is a self clearly bit, and you should wait for it to
clear. genphy_soft_reset() does the polling. But before you can swap
to this, you need to understand why the other bits are being cleared.

Given how old this C driver is, i'm not sure it is using best
practices. So you really should be looking at every line, is it
correct in todays phylib framework? Should it be done differently in a
modern driver? We don't want a 1:1 copy in rust, we want something
which is up to date.

     Andrew

