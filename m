Return-Path: <netdev+bounces-259596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLpkO8mMl2lv0QIAu9opvQ
	(envelope-from <netdev+bounces-259596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:20:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3CF1631B7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B32A303677E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4832ABD1;
	Thu, 19 Feb 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkYVGrrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C3325710
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539649; cv=none; b=mlsVLB48ASzRK4SDLtqdrumQkA4RAZPgiJUcQR6u0YW5DLtfNcrEHkexn9h4QWlufaIfIfmiqtKFwDhbLZsZCYTX5UhNrCyYzC3MW0Po3Q9tEQ6esDFfHKXNS3hcS0x34vngTO+vXlRRpZcYT0ikpxCDjkg/a/crSokcNQ6PDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539649; c=relaxed/simple;
	bh=7rG7l1d8wcnIU2PDqonrIOzyrgRE6wVd+m8ziks3L0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scny7mrktZ+lrYyux70AwyJId61vZey70AXi8LkoreWzgbFMipCu+kHqZCPSi1sk8zmbH06fxjgGpEnIOYG82cRwdL7Ui0O0SEBtoOUwz2hRCXMVTE8PWb1Mx1SsNz6Ge2pmIBmuOs0cC3g+WmczE/wCnYAqnCtohb7KZq4qswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkYVGrrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E301DC19423
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539648;
	bh=7rG7l1d8wcnIU2PDqonrIOzyrgRE6wVd+m8ziks3L0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bkYVGrrMdVbwT40dySkOnvwkm1hYiynUJQ4p/5crPmc++ZM56K2KA58eC85PIW2K4
	 KhbBvWCodfk5kpeVVkfTJMF0kt/OJ97ak204rybCR/EwpcefilzILdjrZj7DZHhJJq
	 w8VCnqWhHr8+Y1eHCv71BIlMdztqHESjYdQ8bSFQadnnkdagDlA3B3GbeQPP545pR1
	 gLjSup71iEEt66QSpNGikykmRJ7XS1okjh3ozu7WcdjaOfXhbwgVrnf9Qoo3gcyD8f
	 WsC3hknQm7EMDpHgje1pM2XE9t2CjO0y+forlkDHM3R3qOOQwji/DQyMwlFYz6cFBp
	 wbmqM4OMCSqOg==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-797d857e3f4so14861257b3.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:20:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpZpJWGVLLb99NjNIBKvwdXIhppzorj8KUo0FeTiq9Ad26lM5OpCzwBnZwX8QBsWhFBI81CSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOTObmtY15KAOvj6rO2hTCt9JGV+goBlbSPc0VJmJmfmHU6dQ
	yR3dkiBbTpzNPdwLVktbm31V0NeYO4J9Ivt7K81YJg+nMDPw28yPjmAjUdEVWmd+jVo9uOkWsLR
	xUjzREtp/2B8XoosxrSTNzMQ63LQojRE=
X-Received: by 2002:a05:690c:4913:b0:797:a162:f7d7 with SMTP id
 00721157ae682-797ac668393mr155417627b3.62.1771539648217; Thu, 19 Feb 2026
 14:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218083618.67805-1-christophe.roullier@foss.st.com>
 <20260218083618.67805-3-christophe.roullier@foss.st.com> <aZV-b6TdLMdI8dm4@shell.armlinux.org.uk>
 <CAD++jLnF=8MvW4CbXmPZR=w8tAUZiL9M3N73WB++DaYYwhToDQ@mail.gmail.com> <aZdjke4eOwF-wTZO@shell.armlinux.org.uk>
In-Reply-To: <aZdjke4eOwF-wTZO@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 23:20:37 +0100
X-Gmail-Original-Message-ID: <CAD++jLmkGtsr9jdzSeyRbHeh_abgz1osn2czEcBOzJ1n1JSh_A@mail.gmail.com>
X-Gm-Features: AaiRm510EWGZUrBhAzIL44W1hn8wAZ_A5KLa10hcXdNoXBhGJk2lSRSIAxMNPUY
Message-ID: <CAD++jLmkGtsr9jdzSeyRbHeh_abgz1osn2czEcBOzJ1n1JSh_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: stmmac: restore pinctrl when driver remove.
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259596-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4B3CF1631B7
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 8:25=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Thu, Feb 19, 2026 at 08:11:13PM +0100, Linus Walleij wrote:

> > There is really no other cleanup that can happen: there is no
> > before-default-or-init state we can revert to (that would be the
> > power-on values), so there are just these states in some pointers
> > that could be accessed by e.g. pinctrl_pm_select_sleep_state()
> > that get free:ed up, and muxing and pin config that happened
> > in the pin control hardware just stays around.
>
> What we seem to end up with is that on probe failure, we set the pins
> to init or default state.

Indeed.

> However, on remove, it's up to the driver to
> decide whether to put the pins into sleep state or not.
>
> Shouldn't a driver be consistent, and place the pins into the same
> state in both these scenarios?

I think you're right. Just very few device trees define the "sleep"
state (the infamous "so far so good...") so it has not been adressed.

> Conversely, I'm slightly worried that putting pins into sleep state
> when we're not powering down may be bad if they're allowed to then
> float, which could cause the PHY to interfere on the network.

That's a good point.

It's perfectly legal to define any random state for the driver, such
as "relaxed" or "unused". It had the only downside that the device
driver core will not help out in looking up the state by default.

I'd be happy to take a patch that e.g. looks for an "unused"
state and put the pins into that state if probe fails, or when
remove() is called, so we get something everyone can use for
this.

Yours,
Linus Walleij

