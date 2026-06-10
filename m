Return-Path: <netdev+bounces-297503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fBy2LyMUKWoiQAMAu9opvQ
	(envelope-from <netdev+bounces-297503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:37:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2C6666AF5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:37:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="t/Izaowf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297503-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297503-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 547903014129
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2438E8D5;
	Wed, 10 Jun 2026 07:30:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A63876B7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:30:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076653; cv=none; b=BXX55PZC01W4Gwut48baamBlfC1XYXZ8cITIpTnI79xiyfYpqwr36ckr+gtyGDeTuQxcOEQkE6vbUubI3QHRwE8QogGhhT4TJrpBFwCQDg63Kub6XXFbltogHBWKMTfy1zLmxlnFhlAExwnpRaaAeUxYckJ8oVb7x11UhsiW+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076653; c=relaxed/simple;
	bh=IigwtTcrIQognWI4jbkMZAJaKP3duykd2Z83udMFGdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMOljm/ainOi1cM+Qj3u9XSaKmgLxOyqqE/DlH+aPhUhfWz+19FB6pHjUU6INtOf/KCQVfP8FFLOvzChLuy7wkvTxqn15MsdWJqEL1g48OvodUy6eRxSjToPYcvCEw/y3/P7R6zKUGQ4gIk/7zE3KvA2LaU5jmNWxZ2Gr6rAga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t/Izaowf; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 503121A381E;
	Wed, 10 Jun 2026 07:30:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0830B5FFC9;
	Wed, 10 Jun 2026 07:30:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56E91106B96FE;
	Wed, 10 Jun 2026 09:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781076642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=juSc6QnvI0q/sb8xWkAHDkPnxJLB2/dxCvNlblbk6JM=;
	b=t/IzaowfbSd6+7BtUmBLBCLxJjxDylqFsGxqjsOJ2L1sI1hxyADXIIv8CH38Bwqrmmzrxa
	IQ7L99KZb7k9w4/2IqwRFlTRt2SNKowicZ1iCZeT/9eE2SyP/NcErqDcIKCRmvPMJ8XI2c
	S2ZU06axsxoOkNdf6vrI/xjtpbWxMalG0nSG/JoueVvMhnwpBgCUdUxyWjAN7ks3Dcy36u
	XiG8yreQNjh/TRl4LInf2nyTPyBMUpYy+l6KmnkD/1ow71vUPfVtcsYdethmHm1Mc6gqtR
	eGsaGIOtTRaXcB+7o3Vrvx6oXXu7anbmRYt5v3DtYRJ9KlF20xMVol8Ss3aJ3A==
Message-ID: <399497f5-ab96-4a8c-81ef-d3c4588fe341@bootlin.com>
Date: Wed, 10 Jun 2026 09:30:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
To: Greg Patrick <gregspatrick@hotmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260604151614.3310544-1-gregspatrick@hotmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260604151614.3310544-1-gregspatrick@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297503-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregspatrick@hotmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[hotmail.com,armlinux.org.uk,lunn.ch,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F2C6666AF5

Hi Greg,

On 6/4/26 17:16, Greg Patrick wrote:
> An SFP cage (compatible "sff,sfp") whose MOD_DEF0 signal is not wired to a
> GPIO currently falls back to sff_gpio_get_state(), which unconditionally
> reports the module as present. An empty cage therefore fails its probe and
> is parked in SFP_MOD_ERROR forever; because SFP_F_PRESENT never deasserts
> there is no REMOVE event to recover the state machine, so a module inserted
> after boot is never detected, and empty cages spam -EIO at boot.
> 
> This affects boards that route none of the cage presence signal to a
> software-readable input. On the NicGiga S100-0800S-M (RTL9303, 8x SFP+) the
> cage I2C bus is the switch's SMBus master; TX_DISABLE is driven via a
> PCA9534 I/O expander, but no MOD_ABS/MOD_DEF0 line reaches a readable GPIO
> (the RTL9303 gpio0 lines read stuck-low, the single PCA9534 is fully
> consumed by TX_DISABLE, and there is no RTL8231).
> 
> For such an SFP cage, derive presence from a throttled single-byte I2C read
> of the module EEPROM instead: an ACK asserts SFP_F_PRESENT, two consecutive
> failures clear it (to ride out a transient error on a live module). The
> existing poll then emits SFP_E_INSERT / SFP_E_REMOVE normally, giving
> working hot-plug and silencing the boot-time -EIO spam on empty cages.
> 
> A soldered-down module (compatible "sff,sff") has no presence signal and is
> genuinely always present, so it continues to use sff_gpio_get_state(); the
> new path is gated on the cage type advertising SFP_F_PRESENT.
> 
> Signed-off-by: Greg Patrick <gregspatrick@hotmail.com>
> ---
> v2:
>  - Keep sff_gpio_get_state() and gate the new I2C-probe presence on the
>    cage advertising SFP_F_PRESENT (an "sff,sfp" cage), so a soldered
>    "sff,sff" module keeps its always-present behaviour. (Andrew Lunn)
>  - Reword the commit message to state precisely that no presence signal
>    reaches a readable input on the affected board, and that the cage bus
>    is the RTL9303 SMBus master. (Andrew Lunn)
>  - On using a 0-byte read like i2cdetect: not available on this board --
>    the cage master advertises only I2C_FUNC_SMBUS_BYTE_DATA (no
>    I2C_FUNC_I2C, no SMBus Quick Command), so sfp_i2c_configure() selects
>    sfp_smbus_byte_read() and a 1-byte read is the lightest presence
>    primitive; it also works through sfp->read on both raw-I2C and
>    SMBus-only adapters, whereas a zero-length transfer does not. (Andrew Lunn)
> 
> v1: https://lore.kernel.org/netdev/20260602235528.2795028-1-gregspatrick@hotmail.com/
> 
>  drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 376c705a9..056bbe6de 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -206,6 +206,11 @@ static const enum gpiod_flags gpio_flags[] = {
>  #define T_PROBE_RETRY_SLOW	msecs_to_jiffies(5000)
>  #define R_PROBE_RETRY_SLOW	12
>  
> +/* Interval at which sfp_i2c_get_state() re-probes the I2C bus for module
> + * presence on boards without a MOD_DEF0 GPIO (see sfp_i2c_get_state()).
> + */
> +#define T_PROBE_PRESENT		msecs_to_jiffies(2000)

I'm genuinly wondering if 2s for this isn't too slow. With a 4s total including the
retry, this definitely leaves time for a user to swap the module with another
different one, and we wouldn't see the hotswap from linux here, leading
to very interesting problems. I think we need a faster removal-detection time.

I'd like to give this patch a try, however I won't be able to do so
before at least saturday :(

Feel free to send a V3 though

Maxime



