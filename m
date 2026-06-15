Return-Path: <netdev+bounces-299386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HWYiGLzKL2q3GQUAu9opvQ
	(envelope-from <netdev+bounces-299386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:49:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD36852C6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:49:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=msQLu2id;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299386-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F3C1302FA90
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E293DB997;
	Mon, 15 Jun 2026 09:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E9307AF4
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:47:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516865; cv=none; b=mjcI7mBw4MGzEAzxezyQ2BRNcYSnLk0iH1V/ejJjnzDvWYF33zhyYLwnSPsJxCzZeabOl9Q0K6JhUxv7LojOWtwdvkj6HOcG3h5zIzZti+sMs5474wXeGOww/7EluPso5Bakjy5JcBbaWZy3JjISqaBfskxApvGMvT9v8dupK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516865; c=relaxed/simple;
	bh=oRdiyeOjH0aUktYn1+FRWgx2GsnQKnaO38v78u+4ArI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVOf4GL+IVBXPajHwQp74eM/MZtSxbPSAM4P4VoFNJhM0VsgA7TVN3WoGEl3ikhL0zivHrQAKya5hqsRwZHrljTy18VGGOBiBGCm//f1Sdn1oXBK9+5QZ5GvO30aVCuMfkGtv2NmzumbaCBGKLFJCHFRasjODVIQ43o+aeMc/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msQLu2id; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ac357c55so29984085e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516862; x=1782121662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xj9QL4/yOEaypRgWx6F22O/WECZ96lxRB8xdf7w7GbI=;
        b=msQLu2idVMhhHemjXn7R6pFLoPS68xg3jDRa3iBTc1433g0fVI2QNPYZkcXRedLPgD
         fPvF8a8148ipMo2h0+I47RnQJOq9U6mjfDyvfdDnORzXjlbGHwQIdXQ3Qd3NDLU7CAF0
         pV5j/x6o1v/hD15WpHkiu8XMPlZ63k82irK/FgNxqQ57gzmZNodQwBUfY5ts1Ua6DZU6
         cP/nNNypjKcA+qsrYWOvak0G8Xubt4eYIRmGBf6u8xbStmS7wS0CYe+R+cT+S99WV2kU
         5hEDSxhQ8OG+RfEpkowDsWzMIxS5GwmKvpd45e6u2kz3v331MhCkLcgGHkyDbsSz1ZsE
         8FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516862; x=1782121662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xj9QL4/yOEaypRgWx6F22O/WECZ96lxRB8xdf7w7GbI=;
        b=PTIKavKiyaFigEKTSCOkNNPc18TBz2zNrmJcOjmnnFGPNy+Fu4DHYFd0A2go1ai4V5
         9PU+Fq9bRnqlFQXW3YBt6xzoWzc0Wg9DcieVD1l+lpGzlf0gqOzKOT/fL4P9Ms9Ao32c
         A+LDGv8GqTaGJt74yEk0t++OBVV9xQ3p661uwJphYnVjOLmmpFh/z+8Q1QG/MsqSzfiX
         pxhd+Dvlgx3mUW4mR3kDVizsnp3+yFz90NJIvfDtbEvxPbSVbyf+0+aMAwPNyM+LZPiF
         bc6sV7NqYRhdqS9DqVI5WXOgCgfbPga10+RSBJzYPvQKd3KVHd7CHU6yDq0DPQCb65rb
         Tgtw==
X-Forwarded-Encrypted: i=1; AFNElJ/ec8a6mHFSBjPVocQjnEc121nngde9Tr1m7NVjTsVCBHlODV8o2BybUiPgtztpcGb9luUQOEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjtktzBuoQWohkqoV2AWUEv5a8DPIUOxxTMMbKNAzJe3DWery
	wp/yEXNXELR9GhnVCwtaPBEaz6zUAtfCZmk77qrVbNEznQRTD562ld33
X-Gm-Gg: Acq92OF4aKY7BM9Yf/HMrAsSqsOsAzB0DgisYtrujveu6RX15ZiiuFLhZAMiykXg00Z
	bMUHMRwZjCHftebRrBFbkuGtdW3nDLMqwd5+lTzYdhXNiDTv3sJdaR52pBFtB4b+hFNSeViGpQU
	YL3MhuCiu2cBW5+ZubB0RQmOb5Pn6lvJgt/nUaBPlAtoP+0375TY2h7tt7YzddJR7hA9hqSUPQ5
	W6vca0eyR0OCq8QIY1VVCJr6qyC+UNkIVQ/yeKVqATqPu8ASUWpK+vZxHbzji24oh2OPUi2pI53
	z0BJ+WOYM/xGca07aaaYvBHFSHG7AX/oTHUk+RhKjvzFx0rwiSzKL8RqN583nYkbAQDyjUN2Zqa
	9VwFzgqSe59KRiFDvZ39S9joheC2C4NbHRxiLvXPtrUqECRIWpX4ZPBEULnQ8gTifywSyniMTy6
	fmWU7yHvAn9HFblwi4JhsHZM2BtWpMlfi4jZChfMp2WAVB+DTh5izp8gsZMt3tNRkbN4ZlF22hF
	f8kkJ+dChbykK8xPWuq7hr4rQ==
X-Received: by 2002:a05:600c:8b56:b0:490:c2a3:23cf with SMTP id 5b1f17b1804b1-490ec507974mr164349725e9.34.1781516861481;
        Mon, 15 Jun 2026 02:47:41 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619a041986sm9483420f8f.23.2026.06.15.02.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:47:40 -0700 (PDT)
Message-ID: <94f2d540-36a7-48da-8fc6-6ac32d7787a2@gmail.com>
Date: Mon, 15 Jun 2026 11:47:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 driver
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
 <20260615090733.739423-2-horms@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260615090733.739423-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-299386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9AD36852C6

Hi,

On 15.06.26 11:07, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: pse-pd: add Realtek/Broadcom PSE MCU driver
>
> This patch adds a driver for a microcontroller that fronts Realtek and
> Broadcom PSE silicon on PoE switches, exposing the MCU over I2C/SMBus or
> UART using a 12-byte fixed-frame protocol. The driver is split into a
> shared core plus two transport modules, with a per-dialect opcode table
> and parser hooks for the Realtek vs Broadcom variants.
>
>> diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
>> index 7ef29657ee5d..b065b19db126 100644
>> --- a/drivers/net/pse-pd/Kconfig
>> +++ b/drivers/net/pse-pd/Kconfig
>> @@ -13,6 +13,34 @@ menuconfig PSE_CONTROLLER
>>  
>>  if PSE_CONTROLLER
>>  
>> +config PSE_REALTEK
>> +	tristate
>> +	help
>> +	  Shared core for the Realtek/Broadcom PSE MCU driver. This is
>> +	  selected automatically by the transport options below.
>> +
>> +config PSE_REALTEK_I2C
>> +	tristate "Realtek/Broadcom PSE MCU driver (I2C transport)"
>> +	depends on I2C
>> +	select PSE_REALTEK
>> +	help
>> +	  Driver for the microcontroller (MCU) that fronts the PSE
>> +	  hardware on switches with Realtek or Broadcom PSE chips, attached
>> +	  via I2C/SMBus. The MCU exposes a message-based protocol; the actual
>> +	  PSE silicon is not accessed directly. To compile this driver as a
>> +	  module, choose M here: the module will be called realtek-pse-i2c.
>> +
>> +config PSE_REALTEK_UART
>> +	tristate "Realtek/Broadcom PSE MCU driver (UART transport)"
>> +	depends on SERIAL_DEV_BUS
>> +	select PSE_REALTEK
>> +	help
>> +	  Driver for the microcontroller (MCU) that fronts the PSE
>> +	  hardware on switches with Realtek or Broadcom PSE chips, attached
>> +	  via UART. The MCU exposes a message-based protocol; the actual PSE
>> +	  silicon is not accessed directly. To compile this driver as a
>> +	  module, choose M here: the module will be called realtek-pse-uart.
>> +
> [Medium]
> The realtek, vendor prefix is used for both the Realtek dialect and the
> Broadcom dialect compatibles (realtek,pse-mcu-rtk and
> realtek,pse-mcu-bcm), and the binding documentation explicitly notes
> that the prefix "reflects the platform" rather than the silicon vendor.
> DT compatibles are stable ABI once accepted.
>
> Would a brcm, prefix (or per-MCU-part compatibles) for the Broadcom
> dialect be more appropriate, given that the BCM variant uses Broadcom
> PSE silicon driven by an MCU built by Nuvoton or STMicro and has no
> Realtek involvement?
>
> Similarly, would describing the I2C wire framing (native vs SMBus) via
> separate compatibles be preferable to encoding it in the
> realtek,i2c-protocol DT property, and would describing the actual PSE
> chip in DT (rather than relying on runtime device-id detection) match
> the usual binding patterns?

This has been the hardest part so far but the solution I have right now
seems the "best" one so far. But this part needs some guidance from
DT maintainers.

I would hold against the AIs suggestions due to particular reasons. Using
specific compatibles for the PSE chips would be very wrong IMO because:

(1) It would claim those PSE chips are what is interfaced on the bus. But
     this is not true, there's only the MCU which mostly hides the PSE chips.
(2) The PSE chips could be used without such an MCU. While this is rather
     theoretical for Realtek PSE chips, it is definitely the case for the
     Broadcom PSE chips. And in that case, they even use a different
     for communication, called Broadcom Serial Control.

On the other side, using specific MCU compatibles would be wrong too:

(1) The MCU silicon is irrelevant to the PSE/PoE system. Those are just
     general purpose MCUs where the supplied firmware on that MCU,
     not the silicon, defines the interface to the host.
(2) The MCUs are from various vendors (here STMicro, GigaDevice,
     Nuvoton), since they are general purpose they're likely used in various
     other applications. Claiming compatibles here for a specific
     application is IMO wrong.

Finally, why using the Realtek prefix/scope: The system that is described
by the bindings and supported by the driver has so far been seen solely
on Realtek-based switches. Some SDK sources already include a driver
implementation for that. Though there is no 100% evidence of that, it
seems quite reasonable that Realtek provides this MCU+firmware+PSE
silicon as kind of a package. Thus, Realtek defines and provides the
interface and behavior. The suffix then just denotes the protocol dialect
used, correlating with the PSE silicon behind the MCU.

In older switch generations, Realtek just decided to use BCM59xxx PSE
chips until they developed and shipped their owns. Likely because
the capabilities of BCM and Realtek PSE silicon slightly differs, they
decided to alter the protocol with different opcodes and slightly
different command set.

I've seen a similar review from Sashiko on the bindings patch, my
explanation above applies to it in the same way.

I'll try to improve the rationale a bit in the descriptions for the next
version.

>>  config PSE_REGULATOR
>>  	tristate "Regulator based PSE controller"
>>  	help
> [ ... ]
>
>> diff --git a/drivers/net/pse-pd/realtek-pse-core.c b/drivers/net/pse-pd/realtek-pse-core.c
>> new file mode 100644
>> index 000000000000..3a601cfb6280
>> --- /dev/null
>> +++ b/drivers/net/pse-pd/realtek-pse-core.c
> [ ... ]
>
>> +static int rtpse_port_cmd(struct rtpse_ctrl *pse, unsigned int port, u8 opcode, u8 arg)
>> +{
>> +	struct rtpse_mcu_msg req, resp;
>> +	int ret;
>> +
>> +	rtpse_mcu_msg_init(&req, opcode);
>> +	req.payload[0] = port;
>> +	req.payload[1] = arg;
>> +
>> +	ret = rtpse_do_xfer(pse, &req, &resp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (resp.payload[0] != port || resp.payload[1] != 0)
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
> [Medium]
> Can an all-zero 12-byte buffer be silently accepted as a successful
> PORT_ENABLE/PORT_DISABLE on the BCM dialect for port 0?
>
> For the BCM dialect, RTPSE_CMD_PORT_ENABLE maps to opcode 0x00, and the
> checksum of eleven zero bytes is 0, so an all-zero response passes the
> opcode and checksum checks in rtpse_do_xfer():
>
> 	if (resp->opcode != req->opcode ||
> 	    resp->checksum != rtpse_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
> 		return -EBADMSG;
>
> rtpse_port_cmd() then verifies payload[0] == port and payload[1] == 0,
> both of which pass when port == 0 and arg is 0 (disable) or when arg is
> 1 but the MCU never observed the command and the buffer is all zero
> anyway since payload[1] is checked against 0.
>
> The seq_num field exists in struct rtpse_mcu_msg and is filled with 0xff
> by rtpse_mcu_msg_init() but is never checked on the response side. Could
> a seq_num round-trip check (or a non-zero opcode sentinel for the BCM
> dialect) reject stale or zeroed-out frames here?
>
> [ ... ]
>

Valid, I will add a check for the seq_num field here.

>> +static int rtpse_discover(struct rtpse_ctrl *pse, struct rtpse_mcu_info *info)
>> +{
>> +	struct rtpse_mcu_ext_config ext_config;
>> +	unsigned long deadline;
>> +	int ret;
>> +
>> +	/*
>> +	 * The MCU may not answer on the bus yet right after power-up or
>> +	 * enable-gpios assertion: depending on the transport it either stays
>> +	 * silent (-ETIMEDOUT) or does not ACK its address at all (-ENXIO /
>> +	 * -EREMOTEIO). Retry within a bounded wall-time window so a slow boot
>> +	 * still probes, while a genuinely unresponsive MCU fails with its real
>> +	 * error instead of deferring forever and masking it.
>> +	 */
>> +	deadline = jiffies + msecs_to_jiffies(RTPSE_MCU_BOOT_TIMEOUT_MS);
>> +	do {
>> +		ret = rtpse_mcu_get_info(pse, info);
>> +		if (ret != -ETIMEDOUT && ret != -ENXIO &&
>> +		    ret != -EREMOTEIO && ret != -EAGAIN)
>> +			break;
>> +		msleep(RTPSE_MCU_BOOT_RETRY_MS);
>> +	} while (time_before(jiffies, deadline));
> [Low]
> The comment says the loop is meant to tolerate a slow-boot MCU, but the
> retry whitelist excludes -EBADMSG and -EIO.
>
> rtpse_do_xfer() returns -EBADMSG when the opcode or checksum mismatch
> fires, and rtpse_port_query()/rtpse_port_cmd() return -EIO when the
> echoed port byte does not match the request. On a UART-attached MCU
> that emits a single garbled frame while its serial peripheral
> stabilises, or on an I2C-attached MCU that returns stale boot-ROM bytes
> right after enable-gpios assertion, the first attempt would surface as
> one of those errors rather than -ETIMEDOUT or -ENXIO, and the loop
> would break out immediately.
>
> Should -EBADMSG (and arguably -EIO) be added to the retry set so the
> documented intent matches the actual behaviour?

This would be speculative IMO, because 'no answer' was the only behavior
I could observe so far. It always came up as a timeout when the MCU
wasn't ready yet.

> [ ... ]
>
>> +int rtpse_register(struct rtpse_ctrl *pse)
>> +{
> [ ... ]
>
>> +	if (!info.system_enable) {
>> +		ret = rtpse_set_global_state(pse, true);
>> +		/* Dialects without a global-state concept (e.g. BCM) return
>> +		 * -EOPNOTSUPP; treat that as "no separate enable required".
>> +		 */
>> +		if (ret && ret != -EOPNOTSUPP)
>> +			return dev_err_probe(pse->dev, ret,
>> +					     "failed to enable PSE system\n");
>> +	}
>> +
>> +	ret = regulator_enable(pse->poe_supply);
>> +	if (ret)
>> +		return dev_err_probe(pse->dev, ret, "failed to enable PoE supply\n");
>> +
>> +	ret = devm_add_action_or_reset(pse->dev, rtpse_regulator_disable, pse->poe_supply);
>> +	if (ret)
>> +		return ret;
> [Low]
> If rtpse_set_global_state(pse, true) succeeds but a later step in
> rtpse_register() fails (regulator_enable, devm_add_action_or_reset, or
> devm_pse_controller_register), is the MCU left with the PSE subsystem
> enabled while the kernel detaches?
>
> The regulator is rolled back via rtpse_regulator_disable through
> devm_add_action_or_reset, but there does not seem to be a matching
> devm_add_action_or_reset to call rtpse_set_global_state(false) on
> probe-failure or driver-removal. Is that asymmetry intentional?

No, this is an inconsistency. I'll fix this in the next version.

> [ ... ]
>
>> diff --git a/drivers/net/pse-pd/realtek-pse-uart.c b/drivers/net/pse-pd/realtek-pse-uart.c
>> new file mode 100644
>> index 000000000000..785407b379a4
>> --- /dev/null
>> +++ b/drivers/net/pse-pd/realtek-pse-uart.c
> [ ... ]
>
>> +static size_t rtpse_uart_receive(struct serdev_device *serdev,
>> +				 const u8 *buf, size_t count)
>> +{
>> +	struct rtpse_uart *ctx = serdev_device_get_drvdata(serdev);
>> +	bool done = false;
>> +	size_t take;
>> +
>> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
>> +		take = min(count, sizeof(ctx->rx_buf) - ctx->rx_len);
>> +		if (take) {
>> +			memcpy(ctx->rx_buf + ctx->rx_len, buf, take);
>> +			ctx->rx_len += take;
>> +			done = (ctx->rx_len == sizeof(ctx->rx_buf));
>> +		}
>> +	}
>> +	if (done)
>> +		complete(&ctx->rx_done);
>> +
>> +	/* consume all to avoid desync/misalignment */
>> +	return count;
>> +}
> [ ... ]
>
>> +static int rtpse_uart_send(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req)
>> +{
>> +	struct rtpse_uart *ctx = to_rtpse_uart(pse);
>> +	int written;
>> +
>> +	/* clear any leftover rx state before transmitting */
>> +	reinit_completion(&ctx->rx_done);
>> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock)
>> +		ctx->rx_len = 0;
> [High]
> Is there a race between reinit_completion() here and the asynchronous
> serdev receive_buf callback when a previous transaction has timed out
> with bytes still in flight?
>
> reinit_completion() is an unlocked x->done = 0 write, and the matching
> complete() in rtpse_uart_receive() is called outside rx_lock. The
> following interleave seems possible:
>
>   rtpse_uart_send() runs reinit_completion()       /* done = 0 */
>   rtpse_uart_receive() takes rx_lock, fills rx_buf
>     to 12 bytes, computes done=true, releases lock
>   rtpse_uart_send() takes rx_lock, sets rx_len = 0,
>     releases lock
>   rtpse_uart_receive() calls complete(&ctx->rx_done) /* done = 1 */
>   rtpse_uart_send() writes the new request
>   rtpse_uart_recv() wait_for_completion_timeout()
>     returns immediately (done was 1), then sees
>     rx_len == 0 and returns -EIO
>
> rtpse_discover()'s retry whitelist covers -ETIMEDOUT, -ENXIO,
> -EREMOTEIO, and -EAGAIN but not -EIO, so a single occurrence of this
> race during the boot retry window would break out of the loop and turn
> into a permanent dev_err_probe() failure.
>
> Would moving complete() inside rx_lock in rtpse_uart_receive(), or
> performing reinit_completion() and rx_len = 0 together inside rx_lock
> while excluding the completer, close this window?
>

Valid, will fix it as suggested in the next version.

>> +
>> +	written = serdev_device_write(ctx->serdev, (const u8 *)req, sizeof(*req),
>> +				      RTPSE_UART_TX_TIMEOUT);
>> +	if (written < 0)
>> +		return written;
>> +	if (written != sizeof(*req))
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
> [ ... ]

Best regards,
Jonas

