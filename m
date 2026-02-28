Return-Path: <netdev+bounces-262201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FdxII1Po2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:26:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF11C858E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 849B8310CCD9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15835F19F;
	Sat, 28 Feb 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIlPZS2f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5535F18E;
	Sat, 28 Feb 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305450; cv=none; b=PHLoLuWVEY6KpcFJNjh6iDB7uhmVw1TlVs5AfBv9jbEsFDNtJ30LCxKWdA97Qlup1vcscNYSKOnUSehmm733wN/bWHsvTeA6xvYrFoB9DMaPwwZekfnQV5SkuzW1XYI+vnXi1oL3KXmvU/7P2G/7boVv2P9fqWqHvzs+I03585Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305450; c=relaxed/simple;
	bh=zDXo0tm/VXl4ZESFurteuRBanIADwE9LLD324tu0poo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVQ3RMiCDFYA3wE1lXmNrlEbzGRvv9CgfW6VusjlcsAtIC6v84hOpds132C9bexcFe1ki/0+5sj5uT+UtyDR74exLjG6TNUqABSOGi5nrDswPubtAqIaJ4YWWY+mD4vk2B9rMz3WeSY2MjSAElWKEJ7S9LzNlP+S6lZyERc7Kzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIlPZS2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C86EC116D0;
	Sat, 28 Feb 2026 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772305449;
	bh=zDXo0tm/VXl4ZESFurteuRBanIADwE9LLD324tu0poo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIlPZS2fZrYutqz2v8HmVp4lM1V49xxMFqLSeyiZJ+6lS/r44DXU89p/gTisqL7GI
	 ePvEPNAyVoGMdl3+/HFpO49Q6QT3HAaxK9EaUP3xOr8VW5OLXTsn1+Gb+Zi8DLA+QA
	 yoMEyyD/tYvXTCkZDoEtfY+Yr7lO8+0CfomJWEFZa5uOlFHrWZFGBltQcTo52fwGdP
	 25dQma90g2q296jWpA3ALn0pQMNX5FzNmUxoWHcF6eBDnp9+vM5Noufl6v1XCPELlL
	 NJ+Zc4tSHp08Yd0appIYwZSG0bMs6OF+xZ7225kekwjVVWvB3YSvdWXgyhXS+Zr92y
	 7/Vsm/rnHadzQ==
Date: Sat, 28 Feb 2026 11:04:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, boon.khai.ng@altera.com,
 rohan.g.thomas@altera.com, vladimir.oltean@nxp.com,
 hayashi.kunihiko@socionext.com, boon.leong.ong@intel.com,
 kim.tatt.chuah@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] net: stmmac: Add write_hw parameter to
 VLAN filter operations
Message-ID: <20260228110408.384420e1@kernel.org>
In-Reply-To: <20260225142414.130144-5-ovidiu.panait.rb@renesas.com>
References: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
	<20260225142414.130144-5-ovidiu.panait.rb@renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262201-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44DF11C858E
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 14:24:13 +0000 Ovidiu Panait wrote:
> Add a write_hw parameter to the VLAN add/delete HW filter functions and
> to stmmac_vlan_update(). This flag controls whether the actual hardware
> register accesses are performed. When set to false, only the software
> state is updated.
> 
> The next commit will use this to defer hardware writes when the
> interface is down.

I wonder if instead of passing attributes like this around the driver
shouldn't simply maintain a flag (or have other way to test) whether
the clock to block X is currently enabled? It feels more like a global
state / property than trickiness directly related to VLAN config.

Also any strong reason to post this for net-next? We take fixes via 
the net tree, so when you repost please use "PATCH net". And an
appropriate Fixes tag on the last patch would be great to have
(presumably just ed64639bc1e0 again?)
-- 
pw-bot: cr

