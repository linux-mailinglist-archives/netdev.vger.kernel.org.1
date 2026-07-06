Return-Path: <netdev+bounces-304983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2aRrC1yVS2rUVwEAu9opvQ
	(envelope-from <netdev+bounces-304983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E5710061
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cl9QMmKW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304983-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304983-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F68730A2AEF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE288414DE1;
	Mon,  6 Jul 2026 11:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD4414A1A
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:23:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336987; cv=none; b=Wh8yJ+t1iU8gi7mJgb4/SJqP7+hP67XmNjFmz1h+NJopGIPBM7mfNDb6mpbSQkohwEKNOPkaz5I19KKdKKg9lEcj83M1Ai3FkUhA2KOnUOygOltaeqb+kT10vRvsNI6HMowQwcfKQu+vjXXU4BWIEydyQ3fMyZLYzM2YcE3Lu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336987; c=relaxed/simple;
	bh=ELILCzori+b8jvBTMiLai110i/uvSiBxlL1xehAHA1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMpY2GNHhSy960Oc8jz64SVoCZyFKfdF6K0vEYltM7jSsz2JRhSL6Tpc6wAEWgI7MofU3MNEbhH9N1fImfiQMUmzeBGeO5UAzkP4Xy7q7Bhf+sonZbKhu6B8ulwZrVxpigSN2i8sdDxx2uuDpsqSofCj+4Pq7lICsAgFOIIy1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl9QMmKW; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso1772905f8f.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783336981; x=1783941781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3QYfk9i+JBKL/nEl+md/FCpiGlsnbGfX+vwp8WTxuI=;
        b=cl9QMmKWM6d0i/96wSQOaKN/5c5sXQxHTj4tIdVOp+eoAL/QsPjxb6Sp1oU08wqEB3
         tnppDjBBGRXZnn7wY8L19IbSSpnf7xf69vOJCB1/1LsPLdD/yKdUAgXFH3PVVPEy+SoO
         iId9aTorHRO8TWxeW/NJj54snTFOB9WofZhETNaIHLmxeROnOQQ9uAmbotBO2RgBpCS/
         R79yL4bvo8GbXtmS2+hyHFIU9i9O2laj3fHQpa3QgzH3f/7lvNM/VY4kz8TZTZPaLuvC
         2NMDZacRWvz+KUd00oz3H/c+y38Tf6BiawAFRrY8/ZRX45Hcd2n8kya4HZeb4IDu4rPv
         rxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336981; x=1783941781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3QYfk9i+JBKL/nEl+md/FCpiGlsnbGfX+vwp8WTxuI=;
        b=mLo2wqJxLXuRztS1jcxaQIWn9WTFe79YTLwekJHOJb7EIbbJbiUWtf3H9ksqeQ9zXA
         En+CJ4wIIZNpnnmGnGA493ahcwtMC0k8sJh/ofoyhudSa0owIdcnCbRdaX80KrLVuRQw
         6nCbnCL7PCvAhyD51p8jPd7KVAxyuANDDpItsbOP7uBVkAMO1nEslAwPTWo8Vnz4lcK9
         b3+IEDIlS1mFcwNhRS2MVW732tpejS+hdXuilE/R9iko1s65/4s0jefR7g20Vhfhri3a
         d7xVwhamOehVMFv2xxOEAoFsLMVsrLgL8/AxcyCSRoHAEWYzt/g4YGhZGuKNwt6Qwqy0
         Ao3Q==
X-Gm-Message-State: AOJu0YyoybVh69P4K23CnglVbkhR0lcJSfQKaBPxwGCl6TmER4BWA3B7
	k3yy5en+xnGseW8RkWyqUcKJrYgtQQX+/3Pf81uvubtLm8lcvRXfucEH
X-Gm-Gg: AfdE7cmcrgEjUgaOKu/vWjnXhdZBDyw6tEQwWuW094y8F1LeAGHI6Z5+T0sM51FmLRV
	34k7sXO8dkzTcceb/VDUZQKeeYOvcNrRt2ulGPKEVMmG5g71gg/iyXeWzwCoG3QvqhqkL7WAWQw
	4gOuFsJTXZYYIBSQKzVxscJ5MUVKfOpUvfuU6Vk/HVdZTVRg/2o9raEbygWArOvKnB79yKZ2Wmk
	avBCBI4y1360RnwBH3yfzoXrgnKhLSueiOiks8UuzzwbIiQB+dqTojlqqLFmeCiQsOs3PzCaVot
	p9QNeK2YRouCODitwVh28ogMp+YzKwiqS3i53AEzal55B22FsR7Em4nIsaxQu2cL8IvL+DQiHPZ
	c3xd2tZD6e/JAQ4MlzWaD6NTRKhUwI2lSDdjClYIjJqkseqI5SrP3wdx4JnaQ8nTicU8tIwW+qj
	AQBEL5wKG9PW7n6aMy37w6YZcNeHSSWq951KwuxcliOssa5ek48FUqTSJuJCaXgGrbeff4GmH1k
	FoVoVPzxXtU9gZtGwcWGZjW9A==
X-Received: by 2002:adf:e3c4:0:b0:472:67de:27ca with SMTP id ffacd0b85a97d-47aace8ede7mr8638640f8f.41.1783336980997;
        Mon, 06 Jul 2026 04:23:00 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f13c:d501:a53d:1108:c6d3:af16? ([2001:9e8:f13c:d501:a53d:1108:c6d3:af16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm24459120f8f.13.2026.07.06.04.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:23:00 -0700 (PDT)
Message-ID: <d5e32492-0585-4b28-a277-d58b9218443a@gmail.com>
Date: Mon, 6 Jul 2026 13:22:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 driver
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260630105651.756058-1-jelonek.jonas@gmail.com>
 <20260630105651.756058-3-jelonek.jonas@gmail.com>
 <2ee45ab5-a329-4891-8326-ac8f14b6374a@redhat.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <2ee45ab5-a329-4891-8326-ac8f14b6374a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-304983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:conor+dt@kernel.org,m:krzk+dt@kernel.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:kory.maincent@bootlin.com,m:o.rempel@pengutronix.de,m:conor@kernel.org,m:krzk@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F4E5710061

Hi Paolo,

On 03.07.26 09:55, Paolo Abeni wrote:
> On 6/30/26 12:56 PM, Jonas Jelonek wrote:
>> A range of PoE switches use a small microcontroller on the PCB to front
>> the actual PSE silicon. The host CPU talks to that MCU over I2C/SMBus or
>> UART using a fixed 12-byte request/response protocol with a trailing
>> checksum; the PSE chips are managed by the MCU and are not accessed
>> directly. The same protocol family is spoken by Realtek and Broadcom PSE
>> MCUs, diverging in opcode numbering and a few response layouts, which the
>> driver abstracts behind a per-dialect opcode table and parser hooks
>> selected by the compatible. The specific PSE chip behind the MCU is
>> detected at runtime and only influences per-chip constants (power scaling
>> and the per-port cap).
>>
>> The driver is split into a shared core and two transport modules:
>>
>> - PSE_REALTEK_MCU: protocol, message framing, dialect machinery, and the
>>   pse_controller_ops glue.
>> - PSE_REALTEK_MCU_I2C / PSE_REALTEK_MCU_UART: transport modules
>>   registering the MCU on an I2C bus or a serdev port respectively.
>>
>> The realtek-pse-mcu-* files and PSE_REALTEK_MCU* symbols match the
>> realtek,pse-mcu-rtk / realtek,pse-mcu-brcm compatibles: all name the
>> Realtek PSE-MCU front-end, not the MCU silicon or the PSE chip behind
>> it (see the binding for the prefix rationale). Broadcom PSE MCUs speak
>> the same protocol family and are handled by the same shared core
>> through the dialect abstraction selected by the '-brcm' compatible.
>>
>> Power budgeting is left to the MCU firmware; the driver advertises
>> PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.
>>
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>> ---
>>  MAINTAINERS                               |    7 +
>>  drivers/net/pse-pd/Kconfig                |   28 +
>>  drivers/net/pse-pd/Makefile               |    3 +
>>  drivers/net/pse-pd/realtek-pse-mcu-core.c | 1019 +++++++++++++++++++++
>>  drivers/net/pse-pd/realtek-pse-mcu-i2c.c  |  163 ++++
>>  drivers/net/pse-pd/realtek-pse-mcu-uart.c |  156 ++++
>>  drivers/net/pse-pd/realtek-pse-mcu.h      |   87 ++
>>  7 files changed, 1463 insertions(+)
>>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
>>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
>>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
>>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h
> This is quite large, and shouls be split in smaller patches to help
> reviewers.
>
> [...]
>> +struct rtpse_mcu_dialect {
>> +	struct rtpse_mcu_opcode opcode[RTPSE_MCU_NUM_CMDS];
>> +
>> +	/*
>> +	 * Response parsers. Each dialect must supply its own; the core calls
>> +	 * these unconditionally rather than carrying a default that would
>> +	 * silently mis-decode bytes from a dialect that forgot to set them.
>> +	 */
>> +	int (*parse_system_info)(const u8 *payload, struct rtpse_mcu_info *info);
> The 2 existing implementation always return 0; you may consider change
> it to a void function.
>
>> +static int rtpse_mcu_port_get_voltage(struct pse_controller_dev *pcdev, int id)
>> +{
>> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
>> +	struct rtpse_mcu_port_measurement measurement;
>> +	int ret;
>> +	u32 uV;
>> +
>> +	ret = rtpse_mcu_port_get_measurement(pse, id, &measurement);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* 64.45mV per LSB */
>> +	uV = (u32)measurement.voltage_raw * 64450U;
> This cast    ^^^^^ should be unneeded.
>
>> +	return min_t(u32, uV, INT_MAX);
>> +}
>> +
>> +static int rtpse_mcu_port_enable(struct pse_controller_dev *pcdev, int id)
>> +{
>> +	return rtpse_mcu_port_set_state(to_rtpse_mcu_ctrl(pcdev), id, true);
>> +}
>> +
>> +static int rtpse_mcu_port_disable(struct pse_controller_dev *pcdev, int id)
>> +{
>> +	return rtpse_mcu_port_set_state(to_rtpse_mcu_ctrl(pcdev), id, false);
>> +}
>> +
>> +static int rtpse_mcu_port_get_pw_limit(struct pse_controller_dev *pcdev, int id)
>> +{
>> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
>> +	struct rtpse_mcu_port_ext_config config;
>> +	int ret;
>> +
>> +	ret = rtpse_mcu_port_get_ext_config(pse, id, &config);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return config.max_power * pse->chip->pw_read_lsb_mW;
>> +}
>> +
>> +static int rtpse_mcu_port_set_pw_limit(struct pse_controller_dev *pcdev, int id, int max_mW)
>> +{
>> +	const struct rtpse_mcu_opcode *type_opc, *val_opc;
>> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
>> +	const struct rtpse_mcu_chip_info *chip = pse->chip;
>> +	unsigned int prg_val;
>> +	int ret;
>> +
>> +	if (max_mW < 0 || max_mW > chip->max_mW_per_port)
>> +		return -ERANGE;
>> +
>> +	type_opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE];
>> +	val_opc = &pse->dialect->opcode[chip->pw_set_cmd];
>> +	if (!type_opc->valid || !val_opc->valid)
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Switch the port to user-defined limit mode first, then program the
>> +	 * limit value. If the second cmd fails, the port is left in
>> +	 * user-defined mode but with the previous limit value; the next
>> +	 * successful set_pw_limit call recovers it.
>> +	 */
>> +	ret = rtpse_mcu_port_cmd(pse, id, type_opc->op, RTPSE_MCU_PORT_PW_LIMIT_TYPE_USER);
>> +	if (ret)
>> +		return ret;
>> +
>> +	prg_val = min_t(unsigned int, max_mW / chip->pw_set_lsb_mW, 0xff);
>> +
>> +	return rtpse_mcu_port_cmd(pse, id, val_opc->op, prg_val);
>> +}
>> +
>> +static int rtpse_mcu_port_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
>> +					      struct pse_pw_limit_ranges *out)
>> +{
>> +	struct ethtool_c33_pse_pw_limit_range *range;
>> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
>> +
>> +	range = kzalloc_obj(*range, GFP_KERNEL);
> or just:
>
> 	range = kzalloc_obj(*range);
>
>
>> +static int rtpse_mcu_discover(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_info *info)
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
>> +		if (ret != -ETIMEDOUT && ret != -ENXIO && ret != -EREMOTEIO &&
>> +		    ret != -EAGAIN)
>> +			break;
>> +		msleep(RTPSE_MCU_BOOT_RETRY_MS);
>> +	} while (time_before(jiffies, deadline));
>> +	if (ret)
>> +		return dev_err_probe(pse->dev, ret, "failed to read MCU info\n");
>> +
>> +	switch (info->device_id) {
>> +	case RTPSE_MCU_DEVICE_ID_RTL8238B:
>> +		pse->chip = &rtl8238b_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_RTL8239:
>> +		pse->chip = &rtl8239_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_RTL8239C:
>> +		pse->chip = &rtl8239c_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_BCM59111:
>> +		pse->chip = &bcm59111_info;
>> +		break;
>> +	case RTPSE_MCU_DEVICE_ID_BCM59121:
>> +		pse->chip = &bcm59121_info;
>> +		break;
>> +	default:
>> +		return dev_err_probe(pse->dev, -EINVAL, "unknown PSE id 0x%x\n",
>> +				     info->device_id);
>> +	}
>> +
>> +	if (!info->max_ports || info->max_ports > RTPSE_MCU_MAX_PORTS)
>> +		return dev_err_probe(pse->dev, -EINVAL,
>> +				     "MCU reports invalid port count %u\n", info->max_ports);
>> +
>> +	ret = rtpse_mcu_get_ext_config(pse, &ext_config);
>> +	if (ret)
>> +		return dev_err_probe(pse->dev, ret, "failed to read MCU ext config\n");
>> +
>> +	dev_info(pse->dev, "%s MCU, %s (id 0x%04x), %u ports across %u PSE chip(s)\n",
>> +		 pse->dialect->mcu_type_str(info->mcu_type), pse->chip->name,
>> +		 info->device_id, info->max_ports, ext_config.num_of_pses);
> The general guidance is to try to avoid unneeded print on dmsg, as they
> tend to scary admins, but I personally agree on message on modprobe.
>
> No strong opionion either ways.
>
> /P
>
Thanks for your remarks, I'll address them in v5.

Best regards,
Jonas

