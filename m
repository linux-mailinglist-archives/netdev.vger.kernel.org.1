Return-Path: <netdev+bounces-299261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsjBMzviLmrv5gQAu9opvQ
	(envelope-from <netdev+bounces-299261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:17:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40144681C2C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Ye8nZd+w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299261-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ADE03004C19
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BDF298CAB;
	Sun, 14 Jun 2026 17:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D751FC7FB;
	Sun, 14 Jun 2026 17:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457463; cv=none; b=bU7z4o64vzXNM0M2DH3bI3TQKLd+wEixsYy7zff4nLdpbQw7/sESrpnM1XKw22ExpaqSVIEnMvjcnB8AGb08k6OJTctMcxJVGGsXu0uCP4ljQ3aVcYY+plrqAGhG0QFZJckWRSVG9xzoi9+lLnx6EwQqcl2rg9hJuABwNLFWw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457463; c=relaxed/simple;
	bh=PwZFzoJAGYSme3/vZbXAZe/PX+9/56nF7zajAzbQVZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4Y74KU1X0vzwIdb9sgjkKOMIKFc9ArRUErlcQKqBRSWFoVkQ2no7rxbRfNf3p/lKtAxkjcZz0zVq4Jk1wHy8izXJcgv6aXAZ1nzzaK0vSNRzXJszzlfTih25zYJLuZ7sTVWB0+euM0XiAySF3JcHPDyH9tffGYrux89JiDJbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ye8nZd+w; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CDC424E42EF1;
	Sun, 14 Jun 2026 17:17:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8F34960014;
	Sun, 14 Jun 2026 17:17:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01C6B106C906C;
	Sun, 14 Jun 2026 19:17:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781457450; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+P39jEEH5/uZwdpUy9h9G12LAqAwQEXT5uizGd32n8s=;
	b=Ye8nZd+w80S/ogDsTCtWNb62ycZCOzVOoVLoRKYRG34lWqc21CJsQeCPkAQDh3dQvUogeY
	wZvKnSpV3p6vHUVq3ll3p+yJRKVO1PmoT4Sx/3BwnPb42K1M/rf/G0enM2rhznruOh3ccp
	IIO3U4dlUTJ45OE6b8QwaTcbuga1wmZA1bqDLZXRCqp5aXoEK/fQHTqBES2YB7zwfOjyZx
	Z5Z4TW9lOZ6576P/Wihv5dVCBxH2k9IVWfpo8RpgYC2vQwz8cHvxtBjaLhBQ7XV96gsfJx
	El0LqevN5LbGg6qtpyVc/ARm/bkI3H1U3+f8EsWfdISsg0j8ugReMzxqI55IhA==
Message-ID: <3af97c3b-b8d8-4566-b044-5d5685b6edec@bootlin.com>
Date: Sun, 14 Jun 2026 19:17:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/2] net: sfp: extend SMBus support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Simon Horman <horms@kernel.org>
References: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
 <20260614133418.2068201-3-jelonek.jonas@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260614133418.2068201-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299261-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40144681C2C

Hi Jonas,

On 6/14/26 15:34, Jonas Jelonek wrote:
> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> added SMBus access for SFP modules, but limited it to single-byte
> transfers. As a side effect, hwmon is disabled (16-bit reads cannot be
> guaranteed atomic) and a warning is printed.
> 
> Many SMBus-only I2C controllers in the wild support more than just
> byte access, and SFP cages are often wired to such controllers
> rather than to a full-featured I2C controller -- e.g. the SMBus
> controllers in the Realtek longan and mango SoCs, which advertise
> word access and I2C block reads. Today, they cannot drive an SFP at
> all without falling back to the byte-only path.
> 
> Extend sfp_smbus_read()/sfp_smbus_write() so that, in addition to
> the existing byte access, they also use SMBus word access and SMBus
> I2C block access whenever the adapter advertises them. Both
> directions are handled in a single read and a single write helper
> that pick the largest supported transfer per chunk and fall back as
> needed.
> 
> I2C-block is preferred unconditionally when available: the protocol
> carries any length 1..32, so it can serve every chunk -- including
> the 1- and 2-byte tails -- without help from word or byte access.
> Note that this requires I2C_FUNC_SMBUS_I2C_BLOCK, which reads a
> caller-specified number of bytes. This deviates from the official
> SMBus Block Read (length is supplied by the slave) but is widely
> supported by Linux I2C controllers/drivers.
> 
> Capability matrix this implementation supports:
> 
>   - BYTE only:                  works (unchanged behaviour); 1-byte
>                                 xfers, hwmon disabled.
>   - BYTE + WORD:                word for >=2-byte chunks, byte for
>                                 trailing odd byte.
>   - I2C_BLOCK present (with or
>     without BYTE/WORD):         block as the universal transport for
>                                 every chunk.
>   - WORD only (no BYTE/BLOCK):  accepted with WARN_ONCE. Even-length
>                                 transfers work; odd-length transfers
>                                 (e.g. the 3-byte cotsworks fixup
>                                 write) hit the BYTE branch which the
>                                 adapter does not implement, so the
>                                 xfer returns an error and the
>                                 operation is aborted. No mainline
>                                 I2C driver was found to advertise
>                                 WORD without BYTE; the warning lets
>                                 us learn about it if it ever shows
>                                 up.
> 
> Adapters with asymmetric R/W capabilities (e.g. only READ_I2C_BLOCK
> but not WRITE_I2C_BLOCK) remain functionally correct -- the
> per-iteration fallback uses the direction-specific bits -- but the
> shared i2c_max_block_size is sized by the all-bits-set check, so a
> transfer in the better-supported direction is not upgraded. None of
> the mainline I2C bus drivers surveyed during review advertise such
> asymmetry; promoting i2c_max_block_size to per-direction sizes can
> be revisited if needed.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Thanks for this work,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



