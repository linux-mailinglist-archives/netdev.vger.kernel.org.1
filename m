Return-Path: <netdev+bounces-255383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iUrSN8TSfWmlTwIAu9opvQ
	(envelope-from <netdev+bounces-255383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 11:00:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE09C1760
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06525300A51F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484F2FDC52;
	Sat, 31 Jan 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUCoLcA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20667269811
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853633; cv=none; b=rT1FWSazoyvSzKbLH3NIVxSYzV+M8UWAb40WU4jZNCQIkCX5Hu/GjEWnCgo84ysgLiKb72g/Cxd+pQiOyPmLVYLMNzbh43Atz3ZhnXeyZF2FM/moyyggiqCfcbpY7fq8sBRP7NVoVo/z8tJ+HutLyjgztLsNAUXPojKK4dhWfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853633; c=relaxed/simple;
	bh=iJTfuvfV8vC9zefeW3F+vGRO+ganuLj6I65A9RBlbSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS5RTDWoq8rVt4JsvPsD89gUXykiKc3aH4gIyd89SbKV4wMFOtEAGYpchEpqC6vwPOwOBDs3Qsb1T3jYgXNiA17ohoT+zFMFkBCulzZZZmu7AHC3u1yZxMxXin2UPhLTUCjgDN5BMIoM14LLZyHAge91jE28IF0+S+5A1f3AOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUCoLcA0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43284ed32a0so1554209f8f.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769853630; x=1770458430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RH2Hxqmgz4Jkez8a6zJZwhFxMTwo2PRy/we9HJl414g=;
        b=eUCoLcA0wQ9hd1Ttn6wxIvFmbZCFRF0/SWZ6jsoxNupsGm+ALJo16wKrI1ZwUf6t1b
         /iyLcRB4BfPnmjavOUKhH12yBoecp0v0cETAPlsYOZYvQXfLK6pZZZBliSNcMVnO+8X0
         Wm61ZJ0/8STKkiNABLwpPgEzBLsPmqEPXaEYWPgCPj7mer79kHIjlHwFtCj4si9XdmPR
         r7afIltXpfEVFsZMbG2UpFBCJo7RturnzxBeGZW7xRYYSjVMqbbOalehVp0TkmINLoX4
         Odk6mevAmb2sFXAHOPa+uUdwwTcF60nTyHnnlgsG400Fp2dcwETI0MmyJCjMwVkb5R1P
         B5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769853630; x=1770458430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RH2Hxqmgz4Jkez8a6zJZwhFxMTwo2PRy/we9HJl414g=;
        b=qWvuY39PmkOEms1jYAikgmmE1MXv0O62NP7SPhOB5LzWhe9HiyP2h6ei0A/0A6Ff9r
         ZyR0hME0ibwoED5zXeEmyeriffnEiWSUxsb2dY5wim7brjAe651dOx/Fhpv4KLsqjfFp
         PlUR8VfE70+OcpMZXhixf9jhHwFsyurUDYhbOrfJEPKKY5QsaCtl52Xu69Hw0S+lLwq2
         0FGt6246aM9fFCQIgZGZNKYoTQuQUZAs8JRDSOHG8pDTrfbx7yml7Dc7I0LQxh6cwOB6
         fR3AOfE5uZnOcrTL1+GKnvDlj4eA749yyKiM1XAD0V4WTuk9sHOgBr+vKlj+R+e74Sxo
         adSA==
X-Gm-Message-State: AOJu0YygjKwDR0bhixMp/Nanjn0Af7cv7kwyA8atfWDS2C7R+PIobzZL
	k2rLRYBZIG2pP3LtPEmspTrJIjojaBXLV+n0nSro7LsJ1CN4wbYVbS5o
X-Gm-Gg: AZuq6aKSWht/jh6xujTzug9A+XzSVHkK8QtzoDZMjHWFbN2S5RIe8pokZBQrpm9wgYj
	T5dV3EFuLHrX87Z5EtLEIEZlsiOkFUYg3ZL3onvINXUij2B4PMDFW8FuoTIrkuf8gKRnpr8SSJ3
	ZogG9gQWJ9n9Wpeh5oPoLB7JMwenqMkxWJOp5/Yj8tUB1MYXBNgaQrT5WSvbp8mZEilqawp3wI3
	7wX4NHQRSNgxHJovg2qEl2xGVfukdNwcOricF9SnSV2GlGB5zsB8gzHq1IOQ1Fv0+2s8I6ldv57
	iAJd2MplqPwmWQ4XEyuMZQuQKKNyH8kffEluZb6BYG/8KBmi0OHM8XjrwzhkSLJQgrxj/jQBZlF
	mcDeA8d6kLCbjhUJ37UY+M08P/Erde78eivgR4o98gcL9G4LWApcaAN9ic3Hap1SSYvj6865Ni3
	iSWdEyp0kV181GEQ5YkZ41igsq1ZfHmWnzgDnEqA/wbDkLBP4q2RccByHe8D6RB8VWSNHlqL0R/
	v/lXSxu7v7L1LqpGxwf6PMqR+dywILlJYTRdPmZYVIBBgiEIbVvlcMnrqE=
X-Received: by 2002:a05:6000:2689:b0:435:e436:7fb with SMTP id ffacd0b85a97d-435f3ab00edmr8468899f8f.50.1769853630179;
        Sat, 31 Jan 2026 02:00:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f06:cc00:41be:d7:a063:4025? (p200300ea8f06cc0041be00d7a0634025.dip0.t-ipconnect.de. [2003:ea:8f06:cc00:41be:d7:a063:4025])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm28310429f8f.11.2026.01.31.02.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 02:00:29 -0800 (PST)
Message-ID: <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
Date: Sat, 31 Jan 2026 11:00:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, o.rempel@pengutronix.de,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FE09C1760
X-Rspamd-Action: no action

On 1/31/2026 7:29 AM, Jens Emil Schulz Ostergaard wrote:
> Hi,
> 
> On Fri, 2026-01-30 at 10:12 +0100, Jens Emil Schulz Østergaard wrote:
>> LAN9645X is a family of switch chips with 5 internal copper phys. The
>> internal PHY is based on parts of LAN8832. This is a low-power, single
>> port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
>> layer transceiver (PHY) that supports transmission and reception of data
>> on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
>> Pair (UTP) cables.
>>
>> Add support for the internal PHY of the lan9645x chip family.
>>
>> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
>> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
>> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
>> ---
>> Changes in v2:
>> - Check write errors in lan9645x_config_intr.
>> - Added more comments for the erratas which are not yet documented in
>>   the datasheet.
>> - Change workaround in lan9645x_suspend from ANEG restart and sleep to
>>   asserting Software Soft Reset and poll for self-clear.
>> - Return IRQ_NONE when IRQ is not handled in lan9645x_handle_interrupt.
>> - Link to v1: https://lore.kernel.org/r/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com
>> ---
>>  drivers/net/phy/micrel.c   | 152 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/micrel_phy.h |   1 +
>>  2 files changed, 153 insertions(+)
>>
>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>> index 225d4adf28be..fe77ad899f10 100644
>> --- a/drivers/net/phy/micrel.c
>> +++ b/drivers/net/phy/micrel.c
>> @@ -6502,6 +6502,142 @@ static void lan8842_get_phy_stats(struct phy_device *phydev,
>>  	stats->tx_errors = priv->phy_stats.tx_errors;
>>  }
>>  
>> +#define LAN9645X_CONTROL_REGISTER		0x1f
>> +#define LAN9645X_CONTROL_REGISTER_SOFT_RESET	BIT(1)
>> +
>> +#define LAN9645X_DAC_ICAS_AMP_POWER_DOWN	0x47
>> +#define LAN9645X_BTRX_QBIAS_POWER_DOWN		0x46
>> +#define LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT	0x45
>> +#define LAN9645X_TX_LOW_I_CH_B_POWER_MGMT	0x44
>> +#define LAN9645X_TX_LOW_I_CH_A_POWER_MGMT	0x43
>> +
>> +static const struct lanphy_reg_data force_dac_tx_errata[] = {
>> +	/* Force channel A/B/C/D TX on */
>> +	{ LAN8814_PAGE_POWER_REGS,
>> +	  LAN9645X_DAC_ICAS_AMP_POWER_DOWN,
>> +	  0 },
>> +	/* Force channel A/B/C/D QBias on */
>> +	{ LAN8814_PAGE_POWER_REGS,
>> +	  LAN9645X_BTRX_QBIAS_POWER_DOWN,
>> +	  0xaa },
>> +	/* Tx low I on channel C/D overwrite */
>> +	{ LAN8814_PAGE_POWER_REGS,
>> +	  LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT,
>> +	  0xbfff },
>> +	/* Channel B low I overwrite */
>> +	{ LAN8814_PAGE_POWER_REGS,
>> +	  LAN9645X_TX_LOW_I_CH_B_POWER_MGMT,
>> +	  0xabbf },
>> +	/* Channel A low I overwrite */
>> +	{ LAN8814_PAGE_POWER_REGS,
>> +	  LAN9645X_TX_LOW_I_CH_A_POWER_MGMT,
>> +	  0xbd3f },
>> +};
>> +
>> +static int lan9645x_config_init(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	/* Apply erratas from previous generations.  */
>> +	ret = lan8842_erratas(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Apply errata for an issue where bringing a port down, can cause a few
>> +	 * CRC errors for traffic flowing through adjacent ports.
>> +	 */
>> +	return lanphy_write_reg_data(phydev, force_dac_tx_errata,
>> +				     ARRAY_SIZE(force_dac_tx_errata));
>> +}
>> +
>> +static int lan9645x_suspend(struct phy_device *phydev)
>> +{
>> +	int ret, val;
>> +
>> +	/* Force link down before software power down (SPD), by doing software
>> +	 * soft reset. This resets the PHY, but keeps all register configuration
>> +	 * intact. The bit self clears.
>> +	 *
>> +	 * This is needed as a workaround for an issue where performing SPD on a
>> +	 * port can bring adjacent ports down, when there is traffic flowing
>> +	 * through the ports.
>> +	 */
>> +	ret = phy_modify(phydev, LAN9645X_CONTROL_REGISTER,
>> +			 LAN9645X_CONTROL_REGISTER_SOFT_RESET, 1);

Any specific reason why you use a vendor-specific register here instead of BMCR
via genphy_soft_reset()?


>> +	if (ret)
>> +		return ret;
>> +
> 
> AI review pointed out an error here. I will fix in the next version.
> 
>> +	ret = phy_read_poll_timeout(phydev, LAN9645X_CONTROL_REGISTER, val,
>> +				    !(val & LAN9645X_CONTROL_REGISTER_SOFT_RESET),
>> +				    3000, 100000, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return genphy_suspend(phydev);
>> +}
>> +
>> +static int lan9645x_config_intr(struct phy_device *phydev)
>> +{
>> +	int err;
>> +
>> +	/* enable / disable interrupts */
>> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
>> +		/* This is an internal PHY of lan9645x and is not possible to
>> +		 * change the polarity of irq sources in the OIC (CPU_INTR)
>> +		 * found in lan9645x. Therefore change the polarity of the
>> +		 * interrupt in the PHY from being active low instead of active
>> +		 * high.
>> +		 */
>> +		err = phy_write(phydev, LAN8804_CONTROL,
>> +				LAN8804_CONTROL_INTR_POLARITY);
>> +		if (err)
>> +			return err;
>> +
>> +		/* By default interrupt buffer is open-drain in which case the
>> +		 * interrupt can be active only low. Therefore change the
>> +		 * interrupt buffer to be push-pull to be able to change
>> +		 * interrupt polarity.
>> +		 */
>> +		err = phy_write(phydev, LAN8804_OUTPUT_CONTROL,
>> +				LAN8804_OUTPUT_CONTROL_INTR_BUFFER);
>> +		if (err)
>> +			return err;
>> +
>> +		err = lan8814_ack_interrupt(phydev);
>> +		if (err)
>> +			return err;
>> +
>> +		err = phy_write(phydev, LAN8814_INTC,
>> +				LAN8814_INT_LINK | LAN8814_INT_FLF);
>> +	} else {
>> +		err = phy_write(phydev, LAN8814_INTC, 0);
>> +		if (err)
>> +			return err;
>> +
>> +		err = lan8814_ack_interrupt(phydev);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static irqreturn_t lan9645x_handle_interrupt(struct phy_device *phydev)
>> +{
>> +	int status;
>> +
>> +	status = phy_read(phydev, LAN8814_INTS);
>> +	if (status < 0) {
>> +		phy_error(phydev);
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	if (status & (LAN8814_INT_LINK | LAN8814_INT_FLF)) {
>> +		phy_trigger_machine(phydev);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>>  static struct phy_driver ksphy_driver[] = {
>>  {
>>  	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
>> @@ -6740,6 +6876,21 @@ static struct phy_driver ksphy_driver[] = {
>>  	.set_tunable	= lan8842_set_tunable,
>>  	.cable_test_start	= lan8814_cable_test_start,
>>  	.cable_test_get_status	= ksz886x_cable_test_get_status,
>> +}, {
>> +	PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X),
>> +	.name		= "Microchip LAN9645X Gigabit PHY",
>> +	.config_init	= lan9645x_config_init,
>> +	.driver_data	= &ksz9021_type,
>> +	.probe		= kszphy_probe,
>> +	.soft_reset	= genphy_soft_reset,
>> +	.suspend	= lan9645x_suspend,
>> +	.resume		= genphy_resume,
>> +	.config_intr	= lan9645x_config_intr,
>> +	.handle_interrupt = lan9645x_handle_interrupt,
>> +	.get_tunable	= lan8842_get_tunable,
>> +	.set_tunable	= lan8842_set_tunable,
>> +	.get_phy_stats	= lan8842_get_phy_stats,
>> +	.update_stats	= lan8842_update_stats,
>>  }, {
>>  	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
>>  	.name		= "Microchip KSZ9131 Gigabit PHY",
>> @@ -6838,6 +6989,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
>>  	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8804) },
>>  	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8841) },
>>  	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8842) },
>> +	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X) },
>>  	{ }
>>  };
>>  
>> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
>> index ca691641788b..9c6f9817383f 100644
>> --- a/include/linux/micrel_phy.h
>> +++ b/include/linux/micrel_phy.h
>> @@ -33,6 +33,7 @@
>>  #define PHY_ID_LAN8804		0x00221670
>>  #define PHY_ID_LAN8841		0x00221650
>>  #define PHY_ID_LAN8842		0x002216C0
>> +#define PHY_ID_LAN9645X		0x002216D0
>>  
>>  #define PHY_ID_KSZ886X		0x00221430
>>  #define PHY_ID_KSZ8863		0x00221435
>>
>> ---
>> base-commit: cbe8e6bef6a3b4b895b47ea56f5952f1936aacb6
>> change-id: 20260114-phy_micrel_add_support_for_lan9645x_internal_phy-6ef9a782cb8b
>>
>> Best regards,
> 
> Thanks,
> 
> Emil
> 


