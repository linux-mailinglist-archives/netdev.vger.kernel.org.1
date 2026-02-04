Return-Path: <netdev+bounces-256759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOdXOMZyg2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:24:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49064EA2AF
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1027D301E3E2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08C423A63;
	Wed,  4 Feb 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hipCrzHJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC2238171;
	Wed,  4 Feb 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221656; cv=none; b=hNWn5moBdVF0I4R99vJEFMaPbHO9QNEgR24uLpLr1sP3Jx+OYZWj2TMGzgqqMefpBcyN/S7kddxJHaiAWWU8cLVe/3Vy9s9uWgKLEUOhccwT7z6asbtp5Xf9SsYkNaBoRNcTbmDAdqop7hhu8xKdLIzxpN2JxEwIxHTeWnbc40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221656; c=relaxed/simple;
	bh=2mxuE/OB002UVRZBKUVN4eexkKYad3kitTUkKrjPIYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLa9HiwsU6IDfRW4v852k2XquUFmis89GnSJIwEGRXcTWKSC8aODDliALjsM3JvIKlD2mvElRunkTWCAR4f1EyY9HEziSwT5Hpk1uXPVnZ09S3RL1gD4tK1NxXRz0R2JeRx6XAuYisCr1ESGT2tZArs68JlnruYnQ8ZMxoNSBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hipCrzHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDE7C19425;
	Wed,  4 Feb 2026 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770221655;
	bh=2mxuE/OB002UVRZBKUVN4eexkKYad3kitTUkKrjPIYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hipCrzHJz6wAiDYvjelMn+Vn7JDxQhdSGL4a9i8++xUJ85zeKPxXijpHozxComS2y
	 EeIVZOC/0NXPWq+IjJHUqvu/lsmUi7Y6TqBdTfHoEcY/9HOdCm+Hs9Y8pFXq8rlw6l
	 XstiQxeYYq0m16XPerFGRJj3QbQNgs7MTe8ZjNX9PW0XaCHElpZpJEi8L15ll95KLy
	 5FPgk6b6o1Evr8Z6H3JlQRPZwWoKx3lPeTFAYvmlaGZZn5Xf82UWoa5BW1ShIEPKhP
	 uNjNcG30MlTcr1oU1syicoQb5VZkp+uyXbCu0QKQ6/errAzO5Pc3U6L8njuLsOSRW8
	 YbrZwVSPRIfhQ==
Date: Wed, 4 Feb 2026 08:14:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v4 12/13] netlink: specs: Add ethernet port
 listing with ethtool
Message-ID: <20260204081413.7bab62ab@kernel.org>
In-Reply-To: <20260203172839.548524-13-maxime.chevallier@bootlin.com>
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
	<20260203172839.548524-13-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-256759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49064EA2AF
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 18:28:36 +0100 Maxime Chevallier wrote:
> +Request contents:
> +
> +====================================  ======  =================================
> +  ``ETHTOOL_A_PORT_HEADER``             nested  request header
> +  ``ETHTOOL_A_PORT_ID``                 u32     port id
> +  ====================================  ======  ===============================

No idea what happened but suddenly last doc build run started noticing
that this table is malformed. Even tho the patches have been present in
previous builds already and there was no error. Very odd. But the table
does look wonky..

Documentation/networking/ethtool-netlink.rst:2538: ERROR: Malformed table.
Bottom/header table border does not match top border.

====================================  ======  =================================
  ``ETHTOOL_A_PORT_HEADER``             nested  request header
  ``ETHTOOL_A_PORT_ID``                 u32     port id
  ====================================  ======  ===============================
-- 
pw-bot: cr

