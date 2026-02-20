Return-Path: <netdev+bounces-259767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMHnNmTJmGl7MQMAu9opvQ
	(envelope-from <netdev+bounces-259767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:51:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D4216AC9C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E1E3047027
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91401309EFC;
	Fri, 20 Feb 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjYVn/dM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B828632B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620650; cv=none; b=Z6qGPbUG1PPo0gLHRm+i+0qHe46rqIzvov7dZDmoHQD8NE2teaXbxxSP2hzYsEXTnF7CGx4QPCVV9p9pDXK3DzlHPpb1tDFKPv9C8bzPNyivZ8fYiMX7gkiTjA+ErfBhcOsvtWq5DTKu45LW76693GNnNUj8oKxXlx3Sg512mKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620650; c=relaxed/simple;
	bh=Qz3V2IoOIRQGYOCuIJKBybb0Yzb361Hkv/tfZHQrQa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3NJMDUHHg42Tck9N4rnviDiBXfd3ry2tmD8XQWBUsz+1pD8yCykLBydfqgIxrZ8VklbpO0rK0CyO+bB1eJ9QH6nRByCvQju6Z8B0RwvjyhTJbOphZz3Vug1wId2ml5jOhK/8oMPJCpgKNpBgDDFakAPwM0U15gp0A0/ILIM4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjYVn/dM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483770e0b25so25388095e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 12:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771620647; x=1772225447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddw9qpOfE4B3Gf/mI+KPYnbBAM5RibhFMT7KjaKIP6E=;
        b=TjYVn/dM0MHzVZnSwgdRlvEXXJEE0qZuvxWpX4KtuzJhCTz4OtzFjnagsL99lf4otF
         VIj57ek7rFxUrHPVu4jVz2cePXyxv7p+JxdTx/HyPTFCNGRWaK7lwq5UgngLwFgckiZj
         7AV6lpRrqwmqeZkI4HBWxAiYnBGjSMfVe+3B7b9O9jCE7+De5Agfie3plg+LTVIrpVv5
         VArQQounCYJZwaGxwH054Wbgq6COJnpVUvOSJ2genlbEzVPohN6LUf55JufTy7+YOvZY
         r0SY3OnCGDVrCnp2Iozy1hBzA4sR7P1zsKzzvq7Y2X12ceyeX8AlUHf7lTYpQqDnn0O8
         95GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771620647; x=1772225447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddw9qpOfE4B3Gf/mI+KPYnbBAM5RibhFMT7KjaKIP6E=;
        b=neV8ywdurgLSDGcWq2EXlqhYN0iRcoFFEb8AJ7e3oqYXw2zvHgeA2nzREZA6v6KSOG
         CsZpfvaDCH8di4JIGNj/p+CF1wG3YsN5g7KrcUeJ0ISW+27Q9KASEPv7rQ/myETjHz++
         23vVvpv9aKMMGH3kiazfGmVFMWaIlP1k6gSCMxZA2engbVluq3NuISo2VxME1aFlgqRv
         qAnBxPCnzrwyoXZ+Hyic70OnuKZF0Z1SPym+YJwtvUuiDvThQzCMEEjk14T4cEE/yNkk
         e5UT2YDD4L+72g1MppfaCQ162RCD0oXNKILVFUgEU3uIQo5jbeyDzFU8c7me7ANeoc62
         qJLA==
X-Gm-Message-State: AOJu0YzCfM0l+dNcAM47T/1lM818coyu6JvI+IXeagg02Dyy0Ta7NBk0
	WGwNu1HvDFt3rRUHZvWAsAvw0poQcXSc8AwmtVPCTm8DR8IlFtfdwoc0
X-Gm-Gg: AZuq6aKVfN29dqSEXpnvJGw8Dv1eLaluf6FcU9YnDfozMf95DLLBXg1yOYyEkvQpnNZ
	QluGC5LWcjfKLerFuf9hz9e/5oKn6w/7eu346ejOmrkgvc1dziaEIACnix3iOmLoqvE6Q4ln+Kg
	qfwOayFFkF6ZCUn/ihK5NeSeUK5A9sSDW61LgpdPr56XeWjpl2Y2y+9O18l/TC0xP/8CS6EIUHM
	JCqHoM0nitnvyUt2vRqIOyqunFE6YhJEApvmGlsIyO3pw7NhQIOvxn0GgN+VuTrcCFRjLaYikND
	ZeXq1tQ0BtI1XBmRCZzaloqKCO55q9cJJv0c7XDd5L63fMfNqwJ5ZRKFGwciKaQEs4Tt/zcxBC5
	wjxnCnkhIQi9Gg/lf5x6hzYVM+YYZDUKcjJGpmBzW5AUYFAqk8eQPmPOZn8fYRBfJvz9+r4cJXr
	x41ozXa2OuKuDHKTPYaEinFP4LwQubiDV/8z5SKSLxPy96W7fuiPdVCsUCv4v6I+mDWtuv8l99J
	biDKW8hzb79JoE9qUWd8+j8VCc4Zjb10/IdriFwt/Kaf3kxr3AD56MZKs3T4dofQA==
X-Received: by 2002:a05:600c:450c:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-483a963d656mr14781925e9.31.1771620646777;
        Fri, 20 Feb 2026 12:50:46 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1e:3800:1889:225f:1b5b:4b37? (p200300ea8f1e38001889225f1b5b4b37.dip0.t-ipconnect.de. [2003:ea:8f1e:3800:1889:225f:1b5b:4b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm147158935e9.8.2026.02.20.12.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 12:50:46 -0800 (PST)
Message-ID: <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
Date: Fri, 20 Feb 2026 21:50:44 +0100
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
 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259767-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 28D4216AC9C
X-Rspamd-Action: no action

On 20.02.2026 21:38, Jens Emil Schulz Ostergaard wrote:
> Hi Heiner,
> 
> On Sat, 2026-01-31 at 11:00 +0100, Heiner Kallweit wrote:
>>
>> On 1/31/2026 7:29 AM, Jens Emil Schulz Ostergaard wrote:
>>> Hi,
>>>
>>> On Fri, 2026-01-30 at 10:12 +0100, Jens Emil Schulz Østergaard wrote:
>>>> LAN9645X is a family of switch chips with 5 internal copper phys. The
>>>> internal PHY is based on parts of LAN8832. This is a low-power, single
>>>> port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
>>>> layer transceiver (PHY) that supports transmission and reception of data
>>>> on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
>>>> Pair (UTP) cables.
>>>>
>>>> Add support for the internal PHY of the lan9645x chip family.
>>>>
>>>> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
>>>> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
>>>> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
>>>> ---
>>>> Changes in v2:
>>>> - Check write errors in lan9645x_config_intr.
>>>> - Added more comments for the erratas which are not yet documented in
>>>>   the datasheet.
>>>> - Change workaround in lan9645x_suspend from ANEG restart and sleep to
>>>>   asserting Software Soft Reset and poll for self-clear.
>>>> - Return IRQ_NONE when IRQ is not handled in lan9645x_handle_interrupt.
>>>> - Link to v1: https://lore.kernel.org/r/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com
>>>> ---
>>>>  drivers/net/phy/micrel.c   | 152 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/micrel_phy.h |   1 +
>>>>  2 files changed, 153 insertions(+)
>>>>
>>>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>>>> index 225d4adf28be..fe77ad899f10 100644
>>>> --- a/drivers/net/phy/micrel.c
>>>> +++ b/drivers/net/phy/micrel.c
>>>> @@ -6502,6 +6502,142 @@ static void lan8842_get_phy_stats(struct phy_device *phydev,
>>>>      stats->tx_errors = priv->phy_stats.tx_errors;
>>>>  }
>>>>
>>>> +#define LAN9645X_CONTROL_REGISTER           0x1f
>>>> +#define LAN9645X_CONTROL_REGISTER_SOFT_RESET        BIT(1)
>>>> +
>>>> +#define LAN9645X_DAC_ICAS_AMP_POWER_DOWN    0x47
>>>> +#define LAN9645X_BTRX_QBIAS_POWER_DOWN              0x46
>>>> +#define LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT  0x45
>>>> +#define LAN9645X_TX_LOW_I_CH_B_POWER_MGMT   0x44
>>>> +#define LAN9645X_TX_LOW_I_CH_A_POWER_MGMT   0x43
>>>> +
>>>> +static const struct lanphy_reg_data force_dac_tx_errata[] = {
>>>> +    /* Force channel A/B/C/D TX on */
>>>> +    { LAN8814_PAGE_POWER_REGS,
>>>> +      LAN9645X_DAC_ICAS_AMP_POWER_DOWN,
>>>> +      0 },
>>>> +    /* Force channel A/B/C/D QBias on */
>>>> +    { LAN8814_PAGE_POWER_REGS,
>>>> +      LAN9645X_BTRX_QBIAS_POWER_DOWN,
>>>> +      0xaa },
>>>> +    /* Tx low I on channel C/D overwrite */
>>>> +    { LAN8814_PAGE_POWER_REGS,
>>>> +      LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT,
>>>> +      0xbfff },
>>>> +    /* Channel B low I overwrite */
>>>> +    { LAN8814_PAGE_POWER_REGS,
>>>> +      LAN9645X_TX_LOW_I_CH_B_POWER_MGMT,
>>>> +      0xabbf },
>>>> +    /* Channel A low I overwrite */
>>>> +    { LAN8814_PAGE_POWER_REGS,
>>>> +      LAN9645X_TX_LOW_I_CH_A_POWER_MGMT,
>>>> +      0xbd3f },
>>>> +};
>>>> +
>>>> +static int lan9645x_config_init(struct phy_device *phydev)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    /* Apply erratas from previous generations.  */
>>>> +    ret = lan8842_erratas(phydev);
>>>> +    if (ret < 0)
>>>> +            return ret;
>>>> +
>>>> +    /* Apply errata for an issue where bringing a port down, can cause a few
>>>> +     * CRC errors for traffic flowing through adjacent ports.
>>>> +     */
>>>> +    return lanphy_write_reg_data(phydev, force_dac_tx_errata,
>>>> +                                 ARRAY_SIZE(force_dac_tx_errata));
>>>> +}
>>>> +
>>>> +static int lan9645x_suspend(struct phy_device *phydev)
>>>> +{
>>>> +    int ret, val;
>>>> +
>>>> +    /* Force link down before software power down (SPD), by doing software
>>>> +     * soft reset. This resets the PHY, but keeps all register configuration
>>>> +     * intact. The bit self clears.
>>>> +     *
>>>> +     * This is needed as a workaround for an issue where performing SPD on a
>>>> +     * port can bring adjacent ports down, when there is traffic flowing
>>>> +     * through the ports.
>>>> +     */
>>>> +    ret = phy_modify(phydev, LAN9645X_CONTROL_REGISTER,
>>>> +                     LAN9645X_CONTROL_REGISTER_SOFT_RESET, 1);
>>
>> Any specific reason why you use a vendor-specific register here instead of BMCR
>> via genphy_soft_reset()?
>>
>>
> 
> Sorry I missed your mail. genphy_soft_reset() will do a software (hard) reset via
> bit 15 (BMCR_RESET). In particular it will reset the registers. We want to do
> a software soft reset, which resets the PHY without changing register values.
> 
No, BMCR_RESET usually doesn't reset configuration registers. That's why the
function is called genphy_*soft*_reset. In case your PHY behaves different,
which configuration registers does it change?

> 
>>>> +    if (ret)
>>>> +            return ret;
>>>> +
>>>
>>> AI review pointed out an error here. I will fix in the next version.
>>>
>>>> +    ret = phy_read_poll_timeout(phydev, LAN9645X_CONTROL_REGISTER, val,
>>>> +                                !(val & LAN9645X_CONTROL_REGISTER_SOFT_RESET),
>>>> +                                3000, 100000, true);
>>>> +    if (ret)
>>>> +            return ret;
>>>> +
>>>> +    return genphy_suspend(phydev);
>>>> +}
>>>> +
>>>> +static int lan9645x_config_intr(struct phy_device *phydev)
>>>> +{
>>>> +    int err;
>>>> +
>>>> +    /* enable / disable interrupts */
>>>> +    if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
>>>> +            /* This is an internal PHY of lan9645x and is not possible to
>>>> +             * change the polarity of irq sources in the OIC (CPU_INTR)
>>>> +             * found in lan9645x. Therefore change the polarity of the
>>>> +             * interrupt in the PHY from being active low instead of active
>>>> +             * high.
>>>> +             */
>>>> +            err = phy_write(phydev, LAN8804_CONTROL,
>>>> +                            LAN8804_CONTROL_INTR_POLARITY);
>>>> +            if (err)
>>>> +                    return err;
>>>> +
>>>> +            /* By default interrupt buffer is open-drain in which case the
>>>> +             * interrupt can be active only low. Therefore change the
>>>> +             * interrupt buffer to be push-pull to be able to change
>>>> +             * interrupt polarity.
>>>> +             */
>>>> +            err = phy_write(phydev, LAN8804_OUTPUT_CONTROL,
>>>> +                            LAN8804_OUTPUT_CONTROL_INTR_BUFFER);
>>>> +            if (err)
>>>> +                    return err;
>>>> +
>>>> +            err = lan8814_ack_interrupt(phydev);
>>>> +            if (err)
>>>> +                    return err;
>>>> +
>>>> +            err = phy_write(phydev, LAN8814_INTC,
>>>> +                            LAN8814_INT_LINK | LAN8814_INT_FLF);
>>>> +    } else {
>>>> +            err = phy_write(phydev, LAN8814_INTC, 0);
>>>> +            if (err)
>>>> +                    return err;
>>>> +
>>>> +            err = lan8814_ack_interrupt(phydev);
>>>> +    }
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>> +static irqreturn_t lan9645x_handle_interrupt(struct phy_device *phydev)
>>>> +{
>>>> +    int status;
>>>> +
>>>> +    status = phy_read(phydev, LAN8814_INTS);
>>>> +    if (status < 0) {
>>>> +            phy_error(phydev);
>>>> +            return IRQ_NONE;
>>>> +    }
>>>> +
>>>> +    if (status & (LAN8814_INT_LINK | LAN8814_INT_FLF)) {
>>>> +            phy_trigger_machine(phydev);
>>>> +            return IRQ_HANDLED;
>>>> +    }
>>>> +
>>>> +    return IRQ_NONE;
>>>> +}
>>>> +
>>>>  static struct phy_driver ksphy_driver[] = {
>>>>  {
>>>>      PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
>>>> @@ -6740,6 +6876,21 @@ static struct phy_driver ksphy_driver[] = {
>>>>      .set_tunable    = lan8842_set_tunable,
>>>>      .cable_test_start       = lan8814_cable_test_start,
>>>>      .cable_test_get_status  = ksz886x_cable_test_get_status,
>>>> +}, {
>>>> +    PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X),
>>>> +    .name           = "Microchip LAN9645X Gigabit PHY",
>>>> +    .config_init    = lan9645x_config_init,
>>>> +    .driver_data    = &ksz9021_type,
>>>> +    .probe          = kszphy_probe,
>>>> +    .soft_reset     = genphy_soft_reset,
>>>> +    .suspend        = lan9645x_suspend,
>>>> +    .resume         = genphy_resume,
>>>> +    .config_intr    = lan9645x_config_intr,
>>>> +    .handle_interrupt = lan9645x_handle_interrupt,
>>>> +    .get_tunable    = lan8842_get_tunable,
>>>> +    .set_tunable    = lan8842_set_tunable,
>>>> +    .get_phy_stats  = lan8842_get_phy_stats,
>>>> +    .update_stats   = lan8842_update_stats,
>>>>  }, {
>>>>      PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
>>>>      .name           = "Microchip KSZ9131 Gigabit PHY",
>>>> @@ -6838,6 +6989,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
>>>>      { PHY_ID_MATCH_MODEL(PHY_ID_LAN8804) },
>>>>      { PHY_ID_MATCH_MODEL(PHY_ID_LAN8841) },
>>>>      { PHY_ID_MATCH_MODEL(PHY_ID_LAN8842) },
>>>> +    { PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X) },
>>>>      { }
>>>>  };
>>>>
>>>> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
>>>> index ca691641788b..9c6f9817383f 100644
>>>> --- a/include/linux/micrel_phy.h
>>>> +++ b/include/linux/micrel_phy.h
>>>> @@ -33,6 +33,7 @@
>>>>  #define PHY_ID_LAN8804              0x00221670
>>>>  #define PHY_ID_LAN8841              0x00221650
>>>>  #define PHY_ID_LAN8842              0x002216C0
>>>> +#define PHY_ID_LAN9645X             0x002216D0
>>>>
>>>>  #define PHY_ID_KSZ886X              0x00221430
>>>>  #define PHY_ID_KSZ8863              0x00221435
>>>>
>>>> ---
>>>> base-commit: cbe8e6bef6a3b4b895b47ea56f5952f1936aacb6
>>>> change-id: 20260114-phy_micrel_add_support_for_lan9645x_internal_phy-6ef9a782cb8b
>>>>
>>>> Best regards,
>>>
>>> Thanks,
>>>
>>> Emil
>>>
>>
>>
> 


