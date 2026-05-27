Return-Path: <netdev+bounces-292081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDYXGWFhFmo5mAcAu9opvQ
	(envelope-from <netdev+bounces-292081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B058F5DECE8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2093018D4F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63720376463;
	Wed, 27 May 2026 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nIm6kU63"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7F277C9E;
	Wed, 27 May 2026 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779851614; cv=none; b=q4Ynk/tzHWyl5fdwZfRcgNsL3QYp/YMJvUHqaHUw9isJjihNQshFMk5Lc1eL0UU00XRcFsYZ1NtdmQkzBczWaPT4O7Ozfn9tue2tZ6EiywjQJuWLhmpTN7wdo++45PTawOuss/4nqXgjW3ak5vy9FnT6Em8GVgET1sfRIK6ExkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779851614; c=relaxed/simple;
	bh=d1KOCvdX3a6rS6lxOCI4VykOPhKfCFHVynoNhaIDO44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsuCATRS/sQDcStFzsxSAogQiWuATv8nemE2bpxoQwENguOhiz1wTctI4sZDjir3Gwo7AVyB6fOoiDTu6KQmetNIbt5CQqzYh0ooc7KgXvDnWA11w5hkHyt5eujw1V5KHKW0xhPO4XRLrU/dyfRX+uJ74/UZvjVSfiajGBUWZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nIm6kU63; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xOV+eMXQZHIeZbhjui1qOIrpCtPWtKx1yhCRd/HqaBY=; b=nIm6kU63t2ta1lnKUJWV6yxGmi
	RGz7oOa8+U+4GleGPhC43cif5aMeJdby8HGIQjXSJrwdloWiRt68+B2F7VbQdqCpWN1k6cJseSbnN
	bKBDV6rlgtHXdFaJK+dHYhBKWnPSVv/3G90TZqysasFk9tEQjiNNseFYmZxtDspBAKKo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wS4hs-004h37-SR; Wed, 27 May 2026 05:13:20 +0200
Date: Wed, 27 May 2026 05:13:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <0796cf1c-b85d-4e1c-b734-e0145e5fc2d9@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-292081-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: B058F5DECE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +   These are used to allow the PHY do know what Pause settings the MAC supports, in

s/do/to/

> +Similarly, the link partner can advertise its capabilities through the same
> +bits. These parameters are exchanged through the negotiation process, but can
> +also be enforced locally by disabling **pause autoneg**, thus ignoring the
> +link partner's capabilities.
> +
> +The local resolution of the pause configuration after receiving the link-partner
> +abilities is done according to the following table, from 802.3 Annex 28B.3 :
> +
> ++-------------+--------------+--------------------------+
> +|Local device | Link partner | Pause settings resolution|
> ++------+------+-------+------+-----------+--------------+
> +|Pause | Asym | Pause | Asym | RX        | TX           |
> ++======+======+=======+======+===========+==============+
> +| 0    | 0    | Any   | Any  | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 0    | 1    | 0     | Any  | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 0    | 1    | 1     | 0    | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 0    | 1    | 1     | 1    | No        | Yes          |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | 0    | 0     | Any  | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | Any  | 1     | Any  | Yes       | Yes          |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | 1    | 0     | 0    | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | 1    | 0     | 1    | Yes       | No           |
> ++------+------+-------+------+-----------+--------------+
> +
> +The currently configured and advertised settings can be queried with ::
> +
> +  ethtool <iface>
> +
> +  Settings for eth0:
> +        ...
> +	Supported pause frame use: Symmetric Receive-only
> +        ...
> +	Advertised pause frame use: Symmetric Receive-only
> +        ...
> +	Link partner advertised pause frame use: Symmetric Receive-only

> +A : Standalone driver testing
> +=============================
> +
> +Requirements : The interface under test must be connected to a link-partner whose
> +interface is admin-up. We don't require the link-partner to be configured in any
> +other specific manner for these tests.
> +
> +A.1 : Sanity Checks
> +~~~~~~~~~~~~~~~~~~~
> +
> +Pause autoneg is set to off::
> +
> +  ethtool -A <iface> autoneg off
> +
> +The 'supported' fields retrieved using the ETHTOOL_MSG_LINKMODES_GET includes
> +a "Pause" bit and an "Asym" bit.
> +
> +The ETHTOOL_MSG_PAUSE_GET command returns the currently configured pause modes
> +in the "tx" and "rx" attributes.
> +
> +These parameters must validate against the following truth table :
> +
> +   +--------------+-----------------+
> +   | linkmodes    | pauseparam      |
> +   +-------+------+--------+--------+
> +   | Pause | Asym | rx     | tx     |
> +   +=======+======+========+========+
> +   | 0     | 0    | 0      | 0      |
> +   +-------+------+--------+--------+
> +   | 0     | 1    | 0      | 0 or 1 |
> +   +-------+------+--------+--------+
> +   | 1     | 0    |     rx == tx    |
> +   +-------+------+--------+--------+
> +   | 1     | 1    | 0 or 1 | 0 or 1 |
> +   +-------+------+--------+--------+

I think we need more sanity checks here, in order to know if the tests
that follow can be run.

If ETHTOOL_MSG_PAUSE_GET returns -EOPNOTSUPP, it is not a test error,
but all the following tests using forced pause should be skipped,
since it indicates forced pause is not supported.

When pause autoneg is on, and LP values are not reported, we probably
want a warning. I don't think we can say it is an error to report
local values but not LP values. There is probably firmware
implementations which don't make it available to user space. But we
should discourage such behaviour with a warning. And some of the tests
which follow will need to be skipped.

I would suggest looking through the tests and making a list of things
which must be implemented in order to actually perform the test. If
something is missing and returns -EOPNOTSUPP, we need to skip the
test.


> +
> +Test scenario
> +-------------
> +
> +Following the reported value from::
> +
> +        ethtool <iface>
> +        Settings for <iface>:
> +                ...
> +	        Supported pause frame use: <value>
> +
> +Iterate over all the 4 combinations of rx and tx pause parameters::
> +
> +        ethtool -A <iface> autoneg off rx <rx_val> tx <tx_val>
> +
> +The settings must be accepted or rejected, according to the above truth table.

-EOPNOTSUPP should also be consider a pass. Other codes should be a
fail.

Sorry, out of time now, i will continue later.

       Andrew

