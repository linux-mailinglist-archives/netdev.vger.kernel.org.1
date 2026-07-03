Return-Path: <netdev+bounces-304440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gKwnEMxtR2qZYAAAu9opvQ
	(envelope-from <netdev+bounces-304440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:07:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10B6FFE39
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:07:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YvOh1dPq;
	dkim=pass header.d=redhat.com header.s=google header.b=ACZ6FleO;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304440-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304440-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D76310FCD4
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7A36E468;
	Fri,  3 Jul 2026 07:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD436AB61
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065321; cv=none; b=A2cyQSeyV8SodZ5UjKuy9++Vpny6eo0GNeKgDYa4I7fBZEwcqwBfToVeFET3PiJCWCQ9TSboW7ckVgbl9QpVxXHqlMVdgBp8JCkumIgbCWa7pM+EcOrJvhTwV8MH6vj6rbEZxb/FDntHUmv0b0Yflhp+rS3uHLUZu113azinLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065321; c=relaxed/simple;
	bh=m169FI8QpCgwLu9CM0yhyki6Voz15sEqpS/ntKWgsNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8ey8sBlLXzrbBP5dwv1TEya7Gec8RDaOWhFcr8XiEjtGeOw7Zy0tOSIN2DTXcZnCWn7h8kaDe82pIu8JRT7zF3XjYeCldVjmOe9ytAdqRW/HdLVZqU259rj9ZVafVG0BIZtx76Jn1Blwcs05SVk/OgdFxPvDwwhS1wGPyrcvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvOh1dPq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACZ6FleO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783065318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHAwS8ZSbUwA3UjJs/Cts2lFQD9OCf7Yj5tr+PYSsE8=;
	b=YvOh1dPqqP3KAhmQcDR4QAewAje01D7vQTahOfI1S1yjylhYWOQ95i4cxSts3F5dIX/dOz
	2ZgKmEY23xY2a283pJnZQ1rIwBJFgd6qbPzrNHcpNnuJURO7yuZQOgD6pbZVsTkDiXbydB
	93GuoStaBXCf4MYxxYqJbc0yok6AFZ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-yiUlc3YKOnWBUbc-yv_ggw-1; Fri, 03 Jul 2026 03:55:17 -0400
X-MC-Unique: yiUlc3YKOnWBUbc-yv_ggw-1
X-Mimecast-MFC-AGG-ID: yiUlc3YKOnWBUbc-yv_ggw_1783065316
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so266749f8f.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783065316; x=1783670116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iHAwS8ZSbUwA3UjJs/Cts2lFQD9OCf7Yj5tr+PYSsE8=;
        b=ACZ6FleOH9xT2nvIDVnebKtQaaHp+WjmVgUsd9U1xJS3GUlS/wNXb7l8fS/JTAVuGP
         e9XY39bVz+tmxYCSMZ8YrnTwse7n9YqMlWIHYX21iglZfI+cjn1MiAmanJDX1fPgreOt
         EGtGZzQP8sfrCwyW4es7Gfgye9Mhg9Hbrj3HATRVwi6InpMevVFvPcLcd+VzjrC7TSE9
         ZwyOP9fSJZqQPFTpK7+zHp2+yLQcuVpXQi57hz071KIFonCUgn9SEiXzexn+hCmOcfBj
         pgwCI3rBmgE67dYqstxJ3urjHjP2zRJOnrlZciFN934d7NXpSjy4LR6q3BYMdEabsMMm
         lKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065316; x=1783670116;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHAwS8ZSbUwA3UjJs/Cts2lFQD9OCf7Yj5tr+PYSsE8=;
        b=WGTeBzqJtyPpNzUzT1FEI+vwZseFIY/06AL7LmxU6SYMuBIzoHZ27lXvt3QzMP7Ipk
         uwCKdH10ObxF4Msucui+NArXErpEsjzQHZOBaXwe9wU+N7Oqn6Qqpfled+C/MebflNgE
         HYFfrdkpQ+Nx1h6eR7JLTaocY0lVk2RmwB4KVaYHg3niKFS3zfXT0p/6UT4z9MIU+17q
         8y6K3AoXFkRi/d4/DQbYIdw3pkQ6DGEAe6nFUBxON9k6/MXT8gkvu6PTymxtHgQ2Lk24
         yxPsaxp9T4X2QlxdNPR63CQCnGJuTcpXZEq/ErdvSuj7ly8pE9X6+VFH69MnqyIWMP/G
         Cv9w==
X-Gm-Message-State: AOJu0YyaM4arqAMXT0JXjJIZSVqHxewNPo1rrT95rKoUFqQK/v3CVBeU
	FY6uousJ4+phNiUDn0ZsMDwcX4aq5f5BoF4wEmc0aJnfI6+NKY+u/7qRCyLLE3LDgwJl7BEpLD4
	dVVSJIK6iOIHmPwFjsRp0eDo7oDF3xXWwyZ1Shhr/KAD37ld72pcKwxjHZw==
X-Gm-Gg: AfdE7clpDH0lsbLz5aGQE0RdzrM6jO1cE+HSsuRkloVyOYCwV1WUlMgYLJoV2CypNw+
	EN+/4JwK65sIlgRPejpCgHHUffxGBooVJUXM3JuDDWYIc8zlg1RS1tnYl3lY2Mdeq0NKYkCpGya
	ooEDuPAXrPJ5gYGLgXlPL6HgE+eyXw6eM2AZF9CAW4PhF9EUAZg7Hqh3sYVyFEC0nS0EpO4Z0o/
	xQcYtT9USBBNEz1vrOM3TF8pU+8yFqhm7PuKdGGx2A29CwNLjENVCUaGl+08K0C6X3x7QAAl/Ec
	hEk9qVeZ/iM9upOYnpzlYmKebzfs1PnHoGYvd66oKofdcsyMHb2PuGN5ky6qQmwplCxjgj9e46d
	V7E0rYN6K8bRb95Dq+RLUdvPKmq6EpWf2rYcLajWu/21Tp9r+YkckjCzFEWvpBaQlBoxvhj2dAz
	XUBsb9udgVvg==
X-Received: by 2002:a05:6000:46c6:b0:473:76a2:67ef with SMTP id ffacd0b85a97d-477af12155bmr9166162f8f.13.1783065315775;
        Fri, 03 Jul 2026 00:55:15 -0700 (PDT)
X-Received: by 2002:a05:6000:46c6:b0:473:76a2:67ef with SMTP id ffacd0b85a97d-477af12155bmr9166120f8f.13.1783065315107;
        Fri, 03 Jul 2026 00:55:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dcf59sm15991655f8f.34.2026.07.03.00.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:55:14 -0700 (PDT)
Message-ID: <2ee45ab5-a329-4891-8326-ac8f14b6374a@redhat.com>
Date: Fri, 3 Jul 2026 09:55:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 driver
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260630105651.756058-1-jelonek.jonas@gmail.com>
 <20260630105651.756058-3-jelonek.jonas@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630105651.756058-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D10B6FFE39

On 6/30/26 12:56 PM, Jonas Jelonek wrote:
> A range of PoE switches use a small microcontroller on the PCB to front
> the actual PSE silicon. The host CPU talks to that MCU over I2C/SMBus or
> UART using a fixed 12-byte request/response protocol with a trailing
> checksum; the PSE chips are managed by the MCU and are not accessed
> directly. The same protocol family is spoken by Realtek and Broadcom PSE
> MCUs, diverging in opcode numbering and a few response layouts, which the
> driver abstracts behind a per-dialect opcode table and parser hooks
> selected by the compatible. The specific PSE chip behind the MCU is
> detected at runtime and only influences per-chip constants (power scaling
> and the per-port cap).
> 
> The driver is split into a shared core and two transport modules:
> 
> - PSE_REALTEK_MCU: protocol, message framing, dialect machinery, and the
>   pse_controller_ops glue.
> - PSE_REALTEK_MCU_I2C / PSE_REALTEK_MCU_UART: transport modules
>   registering the MCU on an I2C bus or a serdev port respectively.
> 
> The realtek-pse-mcu-* files and PSE_REALTEK_MCU* symbols match the
> realtek,pse-mcu-rtk / realtek,pse-mcu-brcm compatibles: all name the
> Realtek PSE-MCU front-end, not the MCU silicon or the PSE chip behind
> it (see the binding for the prefix rationale). Broadcom PSE MCUs speak
> the same protocol family and are handled by the same shared core
> through the dialect abstraction selected by the '-brcm' compatible.
> 
> Power budgeting is left to the MCU firmware; the driver advertises
> PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
>  MAINTAINERS                               |    7 +
>  drivers/net/pse-pd/Kconfig                |   28 +
>  drivers/net/pse-pd/Makefile               |    3 +
>  drivers/net/pse-pd/realtek-pse-mcu-core.c | 1019 +++++++++++++++++++++
>  drivers/net/pse-pd/realtek-pse-mcu-i2c.c  |  163 ++++
>  drivers/net/pse-pd/realtek-pse-mcu-uart.c |  156 ++++
>  drivers/net/pse-pd/realtek-pse-mcu.h      |   87 ++
>  7 files changed, 1463 insertions(+)
>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
>  create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h

This is quite large, and shouls be split in smaller patches to help
reviewers.

[...]
> +struct rtpse_mcu_dialect {
> +	struct rtpse_mcu_opcode opcode[RTPSE_MCU_NUM_CMDS];
> +
> +	/*
> +	 * Response parsers. Each dialect must supply its own; the core calls
> +	 * these unconditionally rather than carrying a default that would
> +	 * silently mis-decode bytes from a dialect that forgot to set them.
> +	 */
> +	int (*parse_system_info)(const u8 *payload, struct rtpse_mcu_info *info);

The 2 existing implementation always return 0; you may consider change
it to a void function.

> +static int rtpse_mcu_port_get_voltage(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
> +	struct rtpse_mcu_port_measurement measurement;
> +	int ret;
> +	u32 uV;
> +
> +	ret = rtpse_mcu_port_get_measurement(pse, id, &measurement);
> +	if (ret)
> +		return ret;
> +
> +	/* 64.45mV per LSB */
> +	uV = (u32)measurement.voltage_raw * 64450U;

This cast    ^^^^^ should be unneeded.

> +	return min_t(u32, uV, INT_MAX);
> +}
> +
> +static int rtpse_mcu_port_enable(struct pse_controller_dev *pcdev, int id)
> +{
> +	return rtpse_mcu_port_set_state(to_rtpse_mcu_ctrl(pcdev), id, true);
> +}
> +
> +static int rtpse_mcu_port_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	return rtpse_mcu_port_set_state(to_rtpse_mcu_ctrl(pcdev), id, false);
> +}
> +
> +static int rtpse_mcu_port_get_pw_limit(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
> +	struct rtpse_mcu_port_ext_config config;
> +	int ret;
> +
> +	ret = rtpse_mcu_port_get_ext_config(pse, id, &config);
> +	if (ret)
> +		return ret;
> +
> +	return config.max_power * pse->chip->pw_read_lsb_mW;
> +}
> +
> +static int rtpse_mcu_port_set_pw_limit(struct pse_controller_dev *pcdev, int id, int max_mW)
> +{
> +	const struct rtpse_mcu_opcode *type_opc, *val_opc;
> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
> +	const struct rtpse_mcu_chip_info *chip = pse->chip;
> +	unsigned int prg_val;
> +	int ret;
> +
> +	if (max_mW < 0 || max_mW > chip->max_mW_per_port)
> +		return -ERANGE;
> +
> +	type_opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE];
> +	val_opc = &pse->dialect->opcode[chip->pw_set_cmd];
> +	if (!type_opc->valid || !val_opc->valid)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Switch the port to user-defined limit mode first, then program the
> +	 * limit value. If the second cmd fails, the port is left in
> +	 * user-defined mode but with the previous limit value; the next
> +	 * successful set_pw_limit call recovers it.
> +	 */
> +	ret = rtpse_mcu_port_cmd(pse, id, type_opc->op, RTPSE_MCU_PORT_PW_LIMIT_TYPE_USER);
> +	if (ret)
> +		return ret;
> +
> +	prg_val = min_t(unsigned int, max_mW / chip->pw_set_lsb_mW, 0xff);
> +
> +	return rtpse_mcu_port_cmd(pse, id, val_opc->op, prg_val);
> +}
> +
> +static int rtpse_mcu_port_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
> +					      struct pse_pw_limit_ranges *out)
> +{
> +	struct ethtool_c33_pse_pw_limit_range *range;
> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
> +
> +	range = kzalloc_obj(*range, GFP_KERNEL);

or just:

	range = kzalloc_obj(*range);


> +static int rtpse_mcu_discover(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_info *info)
> +{
> +	struct rtpse_mcu_ext_config ext_config;
> +	unsigned long deadline;
> +	int ret;
> +
> +	/*
> +	 * The MCU may not answer on the bus yet right after power-up or
> +	 * enable-gpios assertion: depending on the transport it either stays
> +	 * silent (-ETIMEDOUT) or does not ACK its address at all (-ENXIO /
> +	 * -EREMOTEIO). Retry within a bounded wall-time window so a slow boot
> +	 * still probes, while a genuinely unresponsive MCU fails with its real
> +	 * error instead of deferring forever and masking it.
> +	 */
> +	deadline = jiffies + msecs_to_jiffies(RTPSE_MCU_BOOT_TIMEOUT_MS);
> +	do {
> +		ret = rtpse_mcu_get_info(pse, info);
> +		if (ret != -ETIMEDOUT && ret != -ENXIO && ret != -EREMOTEIO &&
> +		    ret != -EAGAIN)
> +			break;
> +		msleep(RTPSE_MCU_BOOT_RETRY_MS);
> +	} while (time_before(jiffies, deadline));
> +	if (ret)
> +		return dev_err_probe(pse->dev, ret, "failed to read MCU info\n");
> +
> +	switch (info->device_id) {
> +	case RTPSE_MCU_DEVICE_ID_RTL8238B:
> +		pse->chip = &rtl8238b_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_RTL8239:
> +		pse->chip = &rtl8239_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_RTL8239C:
> +		pse->chip = &rtl8239c_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_BCM59111:
> +		pse->chip = &bcm59111_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_BCM59121:
> +		pse->chip = &bcm59121_info;
> +		break;
> +	default:
> +		return dev_err_probe(pse->dev, -EINVAL, "unknown PSE id 0x%x\n",
> +				     info->device_id);
> +	}
> +
> +	if (!info->max_ports || info->max_ports > RTPSE_MCU_MAX_PORTS)
> +		return dev_err_probe(pse->dev, -EINVAL,
> +				     "MCU reports invalid port count %u\n", info->max_ports);
> +
> +	ret = rtpse_mcu_get_ext_config(pse, &ext_config);
> +	if (ret)
> +		return dev_err_probe(pse->dev, ret, "failed to read MCU ext config\n");
> +
> +	dev_info(pse->dev, "%s MCU, %s (id 0x%04x), %u ports across %u PSE chip(s)\n",
> +		 pse->dialect->mcu_type_str(info->mcu_type), pse->chip->name,
> +		 info->device_id, info->max_ports, ext_config.num_of_pses);

The general guidance is to try to avoid unneeded print on dmsg, as they
tend to scary admins, but I personally agree on message on modprobe.

No strong opionion either ways.

/P


