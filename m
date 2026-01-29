Return-Path: <netdev+bounces-254658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFDpAlgee2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:46:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B77ADADC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01AD13007955
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5737C0FA;
	Thu, 29 Jan 2026 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RdD+2KK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573B37C111
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676347; cv=none; b=hlsQhrBtZ1ZVgXd5XS4F84ZtH8vWy7wn6Le0LYMnD6dr41qOjGDO5Ox2MlIpUZeD/Gyf499/vlWP9oCVXh69q+3evrM1TBC7J0zJSwhzotka6+HJdDmTZ9B8xJx4XBpTGok+wMOqFc2aGs7VJV5SoLBMJRr0j9K18cGXWcknk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676347; c=relaxed/simple;
	bh=vCM6OQOvJs5WSt+9iieMhZP3WhgJYd4K/csM+xoRSNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWyShrc9UA0vA9xahwbTSJK4LM4Fuo4XmW9QLjBpbTeWGhvHMCGXP+JtUEhTGJ7v47pdu9Li0IKaGk4rfjbBx80xNpYS9uUA0bHrP5JxHZ88Twwh22Qnv+OaCCxq1nC+bYqZ2SlYdFJ5z0pb//AnfW4iBb42Bzso5XVVOdEC+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RdD+2KK5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 59FD74E42312;
	Thu, 29 Jan 2026 08:45:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15FA3606B6;
	Thu, 29 Jan 2026 08:45:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75D45119A868D;
	Thu, 29 Jan 2026 09:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769676341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=d/l3TbjoYhdgkglTb6IDQq8GQZaFfOlIjIUn/T6qpWQ=;
	b=RdD+2KK5nEuxFcbrA3BlrEEj0OtBfqtX0C2vnqEEaiGX/wQDitQjyBnTy+sf10t3JVP+b8
	tVsRAwyQobgcAVvaxRe2Sc8B3wBF2z6Km/PcsUwUL0fm/+Dj5QhJZ0t3R05FhCVHzd9CTH
	5HTN+N0qJ7kjvdkvwpBO3o+aJlebPXL4pFxQ8wkAJvCybKF1MNZ5OgT7CnmvY4xeMLTHEC
	oJNO14uThFnyTIReLmbdSBI759WRriYUnUvj+TXCQdW0JJOreJUgtzASPEdo0Lg8qeJJKU
	hUDXOo6fqFp5YVBk7py/lIAw9LNAnKG4TfykRGlI7FBDvBk3YyxhELiJ1rl/XQ==
Message-ID: <d8d6b779-358a-4d70-90f8-eba74b5a4092@bootlin.com>
Date: Thu, 29 Jan 2026 09:45:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant
 SFP module
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
References: <20260129082227.17443-1-kabel@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260129082227.17443-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-254658-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 69B77ADADC
X-Rspamd-Action: no action

Hi Marek,

On 29/01/2026 09:22, Marek Behún wrote:
> Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
> phy_interface_t bitmap") did not add augumentation for the interface
> bitmap in the quirk for Ubiquiti U-Fiber Instant.
> 
> The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
> phy_interface_t bitmaps for optical modules") then changed phylink code
> for selection of SFP interface: instead of using link mode bitmap, the
> interface bitmap is used, and the fastest interface mode supported by
> both SFP module and MAC is chosen.
> 
> Since the interface bitmap contains also modes faster than 1000base-x,
> this caused a regression wherein this module stopped working
> out-of-the-box.
> 
> Fix this.
> 
> Fixes: fd580c9830316eda ("net: sfp: augment SFP parsing with phy_interface_t bitmap")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

