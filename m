Return-Path: <netdev+bounces-289381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOOkLhA5DGq2aAUAu9opvQ
	(envelope-from <netdev+bounces-289381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:18:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E057C100
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39AB3301BEE3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394B481FC4;
	Tue, 19 May 2026 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tXlEYNjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED243BC68A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185595; cv=none; b=dbBT5k6/AyGnPEhsX+vdarKJrUnQ4F9UBCWQrbtF5X/hDu0HRZWZ+Hun4eSwCNrsEuimo+BvDbfNtM4pUkNXboABj/fgfy0iN0G46/hPkHN+STQFJomBltAhdfEWyzZkR8A0977XlAIlzSG1/LpHPpfhj8S2vcnTcrGiuJgPHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185595; c=relaxed/simple;
	bh=eTqAruKfQRGyqQybI9xgQhqI7pK1oOAnhdUVE3Zawmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfKDW4tPJ+PcGkOv7qFFLiIgP2iFPRsXaCBpH4C/VdUTNVJpGUaGgRAmoNXkWZXLgKo8aZL/CWLavRyaIUdbIrZ6AbPnBG8H6mHso0Wd4K/EOiRR6UUfOrncBiKrTtktUhY3Jsrh1s83fSIhRn6IHr/8XWvU09t39/j0qaTC7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tXlEYNjj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B9AFDC2B9DB;
	Tue, 19 May 2026 10:13:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 87828606E9;
	Tue, 19 May 2026 10:13:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A37C1107E8A86;
	Tue, 19 May 2026 12:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779185585; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fXx931ocGYDBa0KU95k/NnuVwTA46+I1mT0INKuaFPs=;
	b=tXlEYNjjcqUOlsL7kNkwD4Rj3L7CfHhoFDvXhq+fyWBujwyeN6RT/UmriJ73e6WBigFX3v
	aCIt7vT12f0rG9JreKlg2LWolD26GKYqzEEOvvftVIonfsUn7SNUz8FbmashQOEWvAN8Ub
	nJEjpHn3eJnz93147lQbgou7rd7KznzRMEUoDXwikolzcVHoORqRXO3gnJaJacZ18syWIy
	IR3hVLsUsT+wT9FTFLF2FS34T7kmJXxatyKnfUW4meLtHsv0CcKIEjHZEpz392Wl0HXXNn
	Xu1Yjc3/v/48268jcbBs3aaCe6IdjjF4AgO2PgKhTQPE8wdxkBs3DJasrb393A==
Message-ID: <e563f0be-8cdc-4451-ac93-af3a35485af9@bootlin.com>
Date: Tue, 19 May 2026 12:13:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: phy: sfp: probe for RollBall I2C-to-MDIO
 bridge in mdio-i2c
To: Petr Wozniak <petr.wozniak@gmail.com>, netdev@vger.kernel.org
Cc: bjorn@mork.no, andrew@lunn.ch, linux-phy@lists.infradead.org,
 kuba@kernel.org
References: <20260519043249.2868-1-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260519043249.2868-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289381-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 352E057C100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Petr,

On 5/19/26 06:32, Petr Wozniak wrote:
> The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
> unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
> vendor/part-number combination.  This works for modules that genuinely
> implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
> that share the same EEPROM strings without having such a bridge.
> 
> The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
> media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
> vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
> 00:00:00, making OUI-based differentiation impossible.  With
> MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
> appears:
> 
>    sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol

Is it really stalling, or are you facing the 25 seconds retry loop for 
rollball ?

> 
> Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
> RollBall protocol constants are already defined.  After sending the
> unlock password, issue a CMD_READ and wait ~70 ms for CMD_DONE.  A
> genuine RollBall bridge asserts CMD_DONE within that window; modules
> without a bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
> mdio_i2c_alloc() propagates -ENODEV to the caller without logging an
> error.  sfp_sm_add_mdio_bus() catches -ENODEV and transitions
> sfp->mdio_protocol to MDIO_I2C_NONE so the rest of the state machine
> skips PHY probing for this module.
> 
> Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
> the probe path; genuine RollBall modules continue to work as before.
> 
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>

The overall approach is fine by me, I see that being potentially useful
for other use-cases (e.g. the 100FX modules that may or may not embed a
PHY).

we should document that a bit better though, stating that returning
-ENODEV from mdio_i2c_alloc() means we know for a fact there's no
PHY there.

I do have a few nitpicks, mostly style, see bellow, with these fixed you 
can add :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
> 
> Changes since v3 (feedback from Jakub Kicinski):
>    - Drop spurious Tested-by: tag -- author and tester are the same person
>    - Use PATCH net-next subject prefix
>    - Move -ENODEV handling from sfp_i2c_mdiobus_create() into
>      sfp_sm_add_mdio_bus() so bus-creation code does not mutate
>      sfp->mdio_protocol; the state machine is the correct place for
>      protocol-state transitions
>    - Split combined variable declaration for clarity
> 
> Changes since v2:
>    - Compile-tested and hardware-tested on BPI-R4 (MT7988A, 6.12.87)
>    - RTL8261BE (OEM/SFP-10G-T-I): probes MDIO_I2C_NONE, link Up 10Gbps
>    - Genuine RollBall (OEM/SFP-10G-T): bridge detected, link Up 10Gbps
> 
>   drivers/net/mdio/mdio-i2c.c | 57 +++++++++++++++++++++++++++++++-----
>   drivers/net/phy/sfp.c       | 15 ++++++++--
>   2 files changed, 62 insertions(+), 10 deletions(-)
> 
> --- a/drivers/net/mdio/mdio-i2c.c
> +++ b/drivers/net/mdio/mdio-i2c.c
> @@ -419,6 +419,46 @@
>   	return 0;
>   }
>   
> +static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
> +{
> +	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
> +	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
> +	u8 cmd_addr = ROLLBALL_CMD_ADDR;
> +	u8 result;
> +	struct i2c_msg msgs[2];
> +	int ret;

You should follow reverse-xmas tree ordering, sorting by descending line
length.

> +
> +	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[0].flags = 0;
> +	msgs[0].len   = sizeof(data_buf);
> +	msgs[0].buf   = data_buf;
> +	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[1].flags = 0;
> +	msgs[1].len   = sizeof(cmd_buf);
> +	msgs[1].buf   = cmd_buf;
> +
> +	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
> +	if (ret)
> +		return ret;
> +
> +	msleep(70);
> +
> +	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[0].flags = 0;
> +	msgs[0].len   = 1;
> +	msgs[0].buf   = &cmd_addr;
> +	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].len   = 1;
> +	msgs[1].buf   = &result;
> +
> +	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
> +	if (ret)
> +		return ret;
> +
> +	return result == ROLLBALL_CMD_DONE ? 0 : -ENODEV;
> +}
> +
>   static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
>   {
>   	struct i2c_msg msg;
> @@ -439,10 +479,10 @@
>   	ret = i2c_transfer(i2c, &msg, 1);
>   	if (ret < 0)
>   		return ret;
> -	else if (ret != 1)
> +	if (ret != 1)
>   		return -EIO;
> -	else
> -		return 0;
> +
> +	return i2c_mii_probe_rollball(i2c);
>   }
>   
>   static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
> @@ -487,9 +527,10 @@
>   	case MDIO_I2C_ROLLBALL:
>   		ret = i2c_mii_init_rollball(i2c);
>   		if (ret < 0) {
> -			dev_err(parent,
> -				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> -				ret);
> +			if (ret != -ENODEV)
> +				dev_err(parent,
> +					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
> +					ret);
>   			mdiobus_free(mii);
>   			return ERR_PTR(ret);
>   		}
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -579,7 +579,8 @@
>   	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
>   	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
>   
> -	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
> +	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
> +	SFP_QUIRK_F("OEM", "SFP-10G-T",   sfp_fixup_rollball_cc),

there's an extra space added for the "SFP-10G-T" entry, which makes it 
appear in the diff unnecessarily.

>   	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
>   	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
>   	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
> @@ -2022,10 +2023,17 @@
>   
>   static int sfp_sm_add_mdio_bus(struct sfp *sfp)
>   {
> -	if (sfp->mdio_protocol != MDIO_I2C_NONE)
> -		return sfp_i2c_mdiobus_create(sfp);
> +	int ret;
>   
> -	return 0;
> +	if (sfp->mdio_protocol == MDIO_I2C_NONE)
> +		return 0;
> +
> +	ret = sfp_i2c_mdiobus_create(sfp);
> +	if (ret == -ENODEV) {
> +		sfp->mdio_protocol = MDIO_I2C_NONE;
> +		return 0;
> +	}
> +	return ret;
>   }
>   
>   /* Probe a SFP for a PHY device if the module supports copper - the PHY

Maxime


