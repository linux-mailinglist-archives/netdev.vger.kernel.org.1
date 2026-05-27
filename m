Return-Path: <netdev+bounces-292007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI1iNNk5FmoEjgcAu9opvQ
	(envelope-from <netdev+bounces-292007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5435DDEE1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31A9300876E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED692D63E5;
	Wed, 27 May 2026 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH7FqlEv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B52C11F9;
	Wed, 27 May 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841492; cv=none; b=ltSe3plP/ak2pXI+715pCde6wVGa9pX98ydRQ3FukGBixlfeYQ9CcdBWoIa/PQ17CsQZVcHFuhYV9pTs7LMjrWWvrNoKehW6r+Yc1T1isd4OhYkoPRRJ6aeoSbw4FIwOziGq5GPeWPmlbB93zRil9hy3GtEtGa31uqGMgmwT6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841492; c=relaxed/simple;
	bh=dW9KwbgdPNOEya51JXUerzQyizpUZFL3Rfv8xV3R8fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFxTyaX/ts2XLczCB3FnPwIrUT0uwdRre3rgKkM0oeYZeH+R4GUqG580sg3L/0vmrAPDhHd4KGZo4Kg/9Vuzf3EqyOqqD9Y1D+OKNtE32OS1Dj61/+dJWHSioFyqJYW7Yd38g95AB+pOptstO7U6mi1LLI8ujM3ihMs8IZ6x2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH7FqlEv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F4A1F000E9;
	Wed, 27 May 2026 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841489;
	bh=VzYR0VOOXrEQU3eHQZHZ1+QzTtHzanwWECA0vHgaV1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fH7FqlEvDAJscnNN/x2nFTtjY0YoL0uqfFOeoKWKAYBpa0HByra+SNZev+q1Z2TJL
	 EjXMDYDjoMl2LgcO0bcmVAHWqQqHLAibK14jOIysPto3TwxLZ4daj7AvqzY+gkjyYG
	 +dsBM14Zl5LdCf5jT2OaV12/WrQjtW/P6N5Wy4C/N1MRUWTbrDoQbyQ8nI2dI5B6rA
	 qw2a1o5Rjz6QJfkVMgDaJx/0vYsvv/Ky05IT/xSFkES1v8JheVNZFfqRCdxSEkcrDd
	 fna8t5E+dh7FELYWL4E6vwCZedAd/uAN+6rhoUs0SNrHsas5k64my9XUHPPuXhOquR
	 8R0+SNjo3JHrA==
Date: Tue, 26 May 2026 17:24:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <20260526172447.10ca4b9e@kernel.org>
In-Reply-To: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292007-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E5435DDEE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 19:51:06 +0200 Maxime Chevallier (Netdev
Foundation) wrote:
>  Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++

It'd be great to hear from others but IMHO in the current form this is
not suitable for Documentation/networking/ We can commit the "knowledge"
part but enumerating the test cases seems odd for Documentation/.

