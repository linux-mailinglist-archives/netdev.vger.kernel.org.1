Return-Path: <netdev+bounces-275408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IINAIdqI0WmlKwcAu9opvQ
	(envelope-from <netdev+bounces-275408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA939CACA
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7BF5300B983
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D029358372;
	Sat,  4 Apr 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEtRUW36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7F33E373
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775339734; cv=none; b=mqaGWxMdSbVLumcEWqVtkv3wLypuZLgb0n+EukLKRu/CSIT61R85qSjKXq3WQyXhZtQGNoSnpsCvEYzH2q7CyW6R2V3wTkTjY5yGbtrNZsAuomXFafTkNFfggsk2ugsmUh5CfoKb4mK2A3IwCLRe2X0ux5l/FyVg3Aac3XcIZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775339734; c=relaxed/simple;
	bh=gPdJXuwQCZKoQwmcQyXUq81cbwDIJsbHpUS4TvkboxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnftIcncwg70By8CYOtJlXarBBtMSlq45Ne4m1MMqvdKCMV62KGqPS1hYPfGPGYj4yMR4wPCwPC2uJQnvM1iPCONg3GB7kZspHIZsq9p0KyEc3txWVRk4IqupeyBjH5yfw3G74GXgPYIjY2E7LhUuGXFWk82ebkgvSpjxfRkxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEtRUW36; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b949bf4easo2661207f8f.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775339731; x=1775944531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+n99Mpc/7BlQ1TlR5QehJOtWz2Oti1WxVWzQb7sOw/Q=;
        b=TEtRUW36m7582SBKVlzl/xa4F0PzNlC49tVycUdQAe/tioXYMLY1DLMC1jsbco3afE
         dzelhn+2p2Zk5/6eZHHCAdUxkjDtzFdfaRDINEmiBBZPwj7R70wOmZRrMXoPTyRh4uqX
         paEQulkGBeB0c0lpisFeBsyCd/UFKiCavxt/UWpTlHAnX41Jcov/DLnWMEwHJRmTlVcU
         6jY4nRuedIrDFU/jnRMRxC319li+NmTRCUkqPWhg0Y2/KAtHLf5SfFLpZN2DhRLLcUBB
         6Ksxoy3OSSBL96tUnZpIi3Q9UAIMSK9BTPFZidbTrf4iGIuSfrqSKnGZVhTegIepl0iV
         bE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775339731; x=1775944531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+n99Mpc/7BlQ1TlR5QehJOtWz2Oti1WxVWzQb7sOw/Q=;
        b=HWdDpbDHpKpYAy0nPXKBJQqE02zuqTsQm7zTgycdCaS/1wOudXVrbeK1BVC1KgiwXt
         VOizY7KsGLv9W6i1YoZjb7IIpoasRN9WQsbUNKYmJXbK+N7W7Q0NuSOgSob2RpsNiLzW
         1SIO1crhXZbS72COdtGC98+t2e+XkvNxz2NwvjT2tB42LWKZK/nokOUhuze5hmgCcud+
         ifEHOPXJyvhNPTcB3vgNxYdWlplgXMHQpMAad0VFi3v6TV3V4gE8diW4gvhqoprAyZoh
         2mNN4eNW/ZecRHAyAhiV+7GyqVjcy1imPtz6+vKqyGaJa/zzE7C6ocniUbofZBKbeWdc
         BofA==
X-Gm-Message-State: AOJu0YwDFSgAhwBuwrhxg2pVkCiovU8TEBKoHeS4dcehXYL0qzLuW5Z5
	m24kO4PRAeGL5X9NuKLQ14pDZUoW1uIeV+nuDDSEe8LwqAFKnw89Wqmv
X-Gm-Gg: AeBDiesJUMe72oOS3zhNZNXzCbcnAD/Qir+DniR5vpCtJ7Rrm6jQjPrBUQBzYOgctyp
	dn7EJta9/OD7ZBcD9Wa3nMqrvf7Xe9sYDlcgVyAOPKuO7HOIz1mfCgLIa5Md+aZXDkltXBD77tD
	oILWTVZPayB1B95WrOGzTgWP4aAA7VqCY5oZjViHjBRVv0JcFjzCqtFwuTMnxcygZYdy0wtbEu0
	xwUULZhGf/IXgLjyagdkLDXZ7EitmkdIoUjI+2XfuZY2Otyce5UxQSZrX67AX5MtkPzyX6535/j
	0px98EMwjZ9OJ1TDp0/S1xQfRpPDGO/5gshXM14gzOAo/dCm6dZKTLPDMOrV6IhW56NqbIYg7HK
	qwyBkC69Oq9klKycu3e7fEU9e5SqaBGBklJ3njFWP+xqbNjWW/eua5GFPOIFva7VEiUYGuC2vO6
	bju2CSV707d+gHAVYxt6PJa1pegV9txpatCf4UxIbWfhof3z7+dXTlFTqwy8UiJ8wN+dKIZ4o55
	ZTaCdllyBsRW41un1zMBwv7EgsYRsRzkoTJcKCT8XtgQ4Bhi+bCY0RQoVa3ZSRg1Q==
X-Received: by 2002:a05:6000:1624:b0:43b:4951:6b37 with SMTP id ffacd0b85a97d-43d2122621emr11957428f8f.15.1775339730292;
        Sat, 04 Apr 2026 14:55:30 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4c:6e00:411c:10cc:3245:47a0? (p200300ea8f4c6e00411c10cc324547a0.dip0.t-ipconnect.de. [2003:ea:8f4c:6e00:411c:10cc:3245:47a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm27544295f8f.21.2026.04.04.14.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 14:55:28 -0700 (PDT)
Message-ID: <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
Date: Sat, 4 Apr 2026 23:55:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
To: Fabio Baltieri <fabio.baltieri@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260404201333.2849-1-fabio.baltieri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275408-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFFA939CACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04.04.2026 22:13, Fabio Baltieri wrote:
> Implement get_module_info and get_module_eeprom for supported devices,
> right now that's the rtl8127atf.
> 
> This enables using ethtool to retrieve the transceiver identification
> and diagnostic data.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> 
> Hi,
> 
> Realtek released a new out of tree driver for the rtl8127 and it
> includes some code that exposes the I2C controller connected to the SFP
> port.
> 
> This patch implements get_module_info and get_module_eeprom based on the
> information found on that driver, it allows ethtool to fetch the SFP
> module information, which is useful both to identify the module and to
> track the health of fiber optic transceivers.
> 
> The logic for the SFF standard and i2c address selection is borrowed
> directly from the aquantia/atlantic driver, I don't have a lot of stuff
> to test it but I was able to trigger all code paths from a fiber optic
> transceiver and an SFP cable I have available.
> 

Hi Fabio, thanks for the patch. Being able to access the SFP I2C bus is an
important step towards future phylink/SFP support.

@Russell/@Andrew
I'm not really familiar with the phylink and sfp code. And I would like to have
the functionality being implemented here reusable once we do further steps
towards phylink support in r8169. So how shall the code be modeled, which
components are needed?
- Shall the SFP I2C bus be modeled as a struct i2c_adapter?
- Shall we (partially?) implement a struct sfp, so that functions like
  sfp_module_eeprom() can be used (implicitly)?

I assume this patch includes logic which duplicates what is available in
phylink/sfp already. I'd a appreciate any hints you can provide.

Thanks, Heiner

> Demo:
> 
> # Fiber transceiver
> $ sudo ethtool -m eth1
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>         Connector                                 : 0x07 (LC)
>         Transceiver codes                         : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Transceiver type                          : 10G Ethernet: 10G Base-SR
>         Encoding                                  : 0x06 (64B/66B)
>         BR Nominal                                : 10300MBd
>         Rate identifier                           : 0x00 (unspecified)
>         Length (SMF)                              : 0km
>         Length (OM2)                              : 80m
>         Length (OM1)                              : 30m
>         Length (Copper or Active cable)           : 0m
>         Length (OM3)                              : 300m
>         Laser wavelength                          : 850nm
>         Vendor name                               : QSFPTEK
>         Vendor OUI                                : 00:0a:0d
>         Vendor PN                                 : QT-SFP+-SR
>         Vendor rev                                : 
>         Option values                             : 0x00 0x1a
>         Option                                    : TX_DISABLE implemented
>         BR margin max                             : 10%
>         BR margin min                             : 88%
>         Vendor SN                                 : QT8250805131
>         Date code                                 : 250806
>         Optical diagnostics support               : Yes
>         Laser bias current                        : 5.880 mA
>         Laser output power                        : 0.5431 mW / -2.65 dBm
>         Receiver signal average optical power     : 0.6912 mW / -1.60 dBm
>         Module temperature                        : 20.70 degrees C / 69.25 degrees F
>         Module voltage                            : 3.3000 V
> ...
> 
> # DAC
> $ sudo ethtool -m eth1
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>         Connector                                 : 0x21 (Copper pigtail)
>         Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x04 0x00 0x00 0x00
>         Transceiver type                          : Passive Cable
>         Encoding                                  : 0x00 (unspecified)
>         BR Nominal                                : 10300MBd
>         Rate identifier                           : 0x00 (unspecified)
>         Length (SMF)                              : 0km
>         Length (OM2)                              : 0m
>         Length (OM1)                              : 0m
>         Length (Copper or Active cable)           : 1m
>         Length (OM3)                              : 0m
>         Passive Cu cmplnce.                       : 0x01 (SFF-8431 appendix E [SFF-8472 rev10.4 only])
>         Vendor name                               : OEM
>         Vendor OUI                                : 00:40:20
>         Vendor PN                                 : SFP-H10GB-CU1M
>         Vendor rev                                : R
>         Option values                             : 0x00 0x00
>         BR margin max                             : 0%
>         BR margin min                             : 0%
>         Vendor SN                                 : CSC240415030053
>         Date code                                 : 240508
> ...
> 
> # No module
> $ sudo ethtool -m eth1
> netlink error: Input/output error
> 
> Cheers,
> Fabio
> 
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 177 ++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 58788d196c57..45ec0b5c1c21 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2411,6 +2411,181 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
>  	return 0;
>  }
>  
> +#define R8127_SDS_I2C_CON		0xe200
> +#define R8127_SDS_I2C_TAR		0xe204
> +#define R8127_SDS_I2C_DATA_CMD		0xe210
> +#define R8127_SDS_I2C_FS_SCL_HCNT	0xe21c
> +#define R8127_SDS_I2C_FS_SCL_LCNT	0xe220
> +#define R8127_SDS_I2C_INTR_STAT		0xe22c
> +#define R8127_SDS_I2C_EN		0xe26c
> +#define R8127_SDS_I2C_STATUS		0xe270
> +
> +#define R8127_SDS_I2C_STATUS_ACTIVITY BIT(0)
> +#define R8127_SDS_I2C_RX_FIFO_NOT_EMPTY BIT(3)
> +#define R8127_SDS_I2C_STAT_TX_ABRT BIT(6)
> +
> +#define R8127_SDS_I2C_CMD_READ BIT(8)
> +#define R8127_SDS_I2C_CMD_STOP BIT(9)
> +#define R8127_SDS_I2C_CMD_RESTART BIT(10)
> +
> +#define SFF_8472_ID_ADDR 0x50
> +#define SFF_8472_DIAGNOSTICS_ADDR 0x51
> +
> +#define SFF_8472_COMP_ADDR      0x5e
> +#define SFF_8472_DOM_TYPE_ADDR  0x5c
> +
> +#define SFF_8472_ADDRESS_CHANGE_REQ_MASK 0x4
> +
> +static void r8127_sfp_sds_i2c_init(struct rtl8169_private *tp, u8 addr)
> +{
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_EN, 0);
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_CON, 0x65);
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_TAR, addr);
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_FS_SCL_HCNT, 0x23a);
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_FS_SCL_LCNT, 0x23a);
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_EN, 1);
> +}
> +
> +static void r8127_sfp_sds_i2c_disable(struct rtl8169_private *tp)
> +{
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_EN, 0);
> +}
> +
> +DECLARE_RTL_COND(r8127_sfp_sds_i2c_idle_cond)
> +{
> +	u16 val;
> +
> +	val = r8168_mac_ocp_read(tp, R8127_SDS_I2C_STATUS);
> +
> +	return val & R8127_SDS_I2C_STATUS_ACTIVITY;
> +}
> +
> +DECLARE_RTL_COND(r8127_sfp_sds_i2c_rx_fifo_cond)
> +{
> +	u16 val;
> +
> +	val = r8168_mac_ocp_read(tp, R8127_SDS_I2C_STATUS);
> +
> +	return val & R8127_SDS_I2C_RX_FIFO_NOT_EMPTY;
> +}
> +
> +static int r8127_sfp_sds_i2c_read(struct rtl8169_private *tp,
> +				  u8 addr, u8 off, u8 *buf, u16 len)
> +{
> +	u16 intr_stat;
> +	int ret = 0;
> +
> +	r8127_sfp_sds_i2c_init(tp, addr);
> +
> +	r8168_mac_ocp_write(tp, R8127_SDS_I2C_DATA_CMD, off);
> +
> +	if (!rtl_loop_wait_low(tp, &r8127_sfp_sds_i2c_idle_cond, 10, 100)) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	intr_stat = r8168_mac_ocp_read(tp, R8127_SDS_I2C_INTR_STAT);
> +	if (intr_stat & R8127_SDS_I2C_STAT_TX_ABRT) {
> +		/* NACK */
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	for (int i = 0; i < len; i++) {
> +		u16 data = R8127_SDS_I2C_CMD_READ;
> +
> +		if (i == len - 1)
> +			data |= R8127_SDS_I2C_CMD_STOP;
> +		if (i == 0)
> +			data |= R8127_SDS_I2C_CMD_RESTART;
> +
> +		r8168_mac_ocp_write(tp, R8127_SDS_I2C_DATA_CMD, data);
> +
> +		if (!rtl_loop_wait_high(tp, &r8127_sfp_sds_i2c_rx_fifo_cond,
> +					10, 1000)) {
> +			ret = -ETIMEDOUT;
> +			goto out;
> +		}
> +
> +		buf[i] = r8168_mac_ocp_read(tp, R8127_SDS_I2C_DATA_CMD);
> +	}
> +
> +out:
> +	r8127_sfp_sds_i2c_disable(tp);
> +
> +	return ret;
> +}
> +
> +static int rtl8169_get_module_info(struct net_device *ndev,
> +				   struct ethtool_modinfo *modinfo)
> +{
> +	struct rtl8169_private *tp = netdev_priv(ndev);
> +	u8 compliance_val, dom_type;
> +	int ret;
> +
> +	if (!tp->sfp_mode)
> +		return -EOPNOTSUPP;
> +
> +	ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_ID_ADDR,
> +				     SFF_8472_COMP_ADDR, &compliance_val, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_ID_ADDR,
> +				     SFF_8472_DOM_TYPE_ADDR, &dom_type, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (dom_type & SFF_8472_ADDRESS_CHANGE_REQ_MASK || compliance_val == 0x00) {
> +		modinfo->type = ETH_MODULE_SFF_8079;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
> +	} else {
> +		modinfo->type = ETH_MODULE_SFF_8472;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtl8169_get_module_eeprom(struct net_device *ndev,
> +				     struct ethtool_eeprom *ee, unsigned char *data)
> +{
> +	struct rtl8169_private *tp = netdev_priv(ndev);
> +	unsigned int first, last, len;
> +	int ret;
> +
> +	if (!tp->sfp_mode)
> +		return -EOPNOTSUPP;
> +
> +	first = ee->offset;
> +	last = ee->offset + ee->len;
> +
> +	if (first < ETH_MODULE_SFF_8079_LEN) {
> +		len = min(last, ETH_MODULE_SFF_8079_LEN);
> +		len -= first;
> +
> +		ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_ID_ADDR,
> +					     first, data, len);
> +		if (ret)
> +			return ret;
> +
> +		first += len;
> +		data += len;
> +	}
> +	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
> +		len = min(last, ETH_MODULE_SFF_8472_LEN);
> +		len -= first;
> +		first -= ETH_MODULE_SFF_8079_LEN;
> +
> +		ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_DIAGNOSTICS_ADDR,
> +					     first, data, len);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> @@ -2437,6 +2612,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.set_pauseparam		= rtl8169_set_pauseparam,
>  	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
>  	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
> +	.get_module_info	= rtl8169_get_module_info,
> +	.get_module_eeprom	= rtl8169_get_module_eeprom,
>  };
>  
>  static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool gmii)


