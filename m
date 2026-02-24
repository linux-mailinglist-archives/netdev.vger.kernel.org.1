Return-Path: <netdev+bounces-260284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM5jOMnynGkvMQQAu9opvQ
	(envelope-from <netdev+bounces-260284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:37:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD48180445
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B2133043AF1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15B22D4C8;
	Tue, 24 Feb 2026 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eLNyRxYP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0652135AD;
	Tue, 24 Feb 2026 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893447; cv=none; b=FJjUUw840aCQlx0qTrj+976vpVw66C3X/ztTp1jiPIUcjTK1wSgZMUVsK10tIGG7Y4KTtbvUZv/DgUQeuNa7KrHOH/t2zalOLXbpcXZ3BgKhrfWHSKljxFRJaqLl2LybJJhjXFeS37whJz/zkWSjK8AxmIiM+ozeH2Rqajt60e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893447; c=relaxed/simple;
	bh=0J3oZjSMzV17bOLwFSb5Kj13pyoUUrsptIWZn1bnA2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwSFyBbY9w6gWLK3xURAJcsO1NxOz5VlS2cFPkKqDuDnMNGhzTr/zRm42XXqmNbarGtLJTG1vIOFkETF9na1rTJT58RRbdJneZvqXSWdcrgPC2w3QehDLGiwTlte36x6+8ZVtrx76g5qe4DN9N/y4ONZmDddpKLzHus8oZPzZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eLNyRxYP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Oxv0iuz2GOOH71uHwL+u1JOZWx+ihKepwCH6y8hknI=; b=eLNyRxYPjL7ApoDqQGaYpppZyE
	g15M0/BWceLm6pwiM+9dc8yZuAFpWYZXp2i+8XPzM+gjvqdas8GszMVpHA42kvK85LLHkhrf+rqG+
	au95McT7yqsPVRJZuEXdEI8DYDiPTdopuKrfmhKZxHarmV+UYW/qMMtMAL8e+XyIDcL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vugQM-008X4k-78; Tue, 24 Feb 2026 01:37:14 +0100
Date: Tue, 24 Feb 2026 01:37:14 +0100
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
Subject: Re: [PATCH net-next 2/2] net: phy: add Rust reference driver for
 ET1011C
Message-ID: <389ccb15-aef9-422b-8717-cf3a26e0858b@lunn.ch>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
 <20260223220504.2102-4-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223220504.2102-4-iprintercanon@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260284-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 5FD48180445
X-Rspamd-Action: no action

> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> +        dev.genphy_read_status::<C22>()?;
> +
> +        let val = dev.read(ET1011C_STATUS_REG)?;
> +        if (val & ET1011C_SPEED_MASK) == ET1011C_GIGABIT_SPEED {
> +            let cfg = dev.read(ET1011C_CONFIG_REG)?;
> +            let cfg = cfg & !ET1011C_TX_FIFO_MASK;
> +            dev.write(
> +                ET1011C_CONFIG_REG,
> +                cfg | ET1011C_GMII_INTERFACE | ET1011C_SYS_CLK_EN | ET1011C_TX_FIFO_DEPTH_16,
> +            )?;
> +        }

This is not the same as the C code. read_status() will be called once
per second. The C code only does the read/modify/write when the speed
reported by genphy_read_status() is different to the previous
value. This code appears to do it every second.

       Andrew

