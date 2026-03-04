Return-Path: <netdev+bounces-263861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULo0AmxPqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:27:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58200202A58
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6971A30515C2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8C339861;
	Wed,  4 Mar 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XRCc/tHp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31817339856;
	Wed,  4 Mar 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637815; cv=none; b=rVwvyi1vk44GGG423pmV/9noDWkQly0D76hsgGXLxpjvM6jDv+fwxtUrzyAgHyzZLS59I21VSdm+eK4tFSlmwlV2RyB+cFSo/PFnuGi8daY3HIm2dTIRYR0btNEBYTLGtSwUn9/qVvKwVPq4Qt4QQTfIqvWJmGFRmuBGvyYUHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637815; c=relaxed/simple;
	bh=Q+QtQA4/Lp/mxB90Sm+CkkVn5DpvC+IrJnZVixrJpeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akFBzUUDFswqNpW0Oop3+DA4xWUJLyLnnjwLFulLxahLFFt0qEwY7P65iSCZQeeG4jl5PcOSQc5utnLdKKMeXaF2fVuCsLAXA8bq3SY60ceUI0IwXI5IIzbBP5F0PpN7/joWsPUU+v6Z2ZTenndzsnUMjYbOqWFrQSnrjZbhMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XRCc/tHp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GTp+RKx40Xq9dD5znz1U/Rg14AmMtzwAhbYEXIMlM8M=; b=XRCc/tHpioHthMVm2EtiDM/BAz
	rbRwVtHRq/hXdxf/A9lOGJcfg9TcXcbLvdotag6MViUBwZVXqUT29v0skyKP1+yJ7H0MxL+p0yiqH
	qaD5zffwidSuMG34SsmiL8N6JVy+mg2ExOtz//dFeDNLQHhfcbVocpNRdKfNHJOGZtlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxo4J-00A7rP-QF; Wed, 04 Mar 2026 16:23:23 +0100
Date: Wed, 4 Mar 2026 16:23:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
Message-ID: <c56db879-7556-4e13-bd59-2045d7048dc8@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: 58200202A58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263861-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Please could you try moving these:

> +	BUILD_BUG_ON_MSG((_fld_sz) > 32, "IFH field size wider than 32.");\
> +	BUILD_BUG_ON_MSG((_fld_sz) == 0, "IFH field size of 0.");	\
> +	BUILD_BUG_ON_MSG((_fld) + (_fld_sz) > LAN9645X_IFH_BITS,	\
> +			 "IFH field overflows IFH");			\

> +static inline void lan9645x_ifh_set(u8 *ifh, u32 val, size_t pos, size_t length)
> +{
> +	size_t end = (pos + length) - 1;
> +	size_t start_u8 = pos >> 3;
> +	size_t end_u8 = end >> 3;
> +	size_t end_rem = end & 0x7;
> +	size_t pos_rem = pos & 0x7;
> +	u8 end_mask, start_mask;
> +	size_t vshift;
> +	u8 *ptr;

here.

You are passing build time constant. The compiler should be able to
track them through the call, especially since they are inline. So i
think it should work. Please test it, deliberately break some of the
#defines and make sure the build fails.

I just think avoiding the macro would be nice, if possible.

  Andrew

