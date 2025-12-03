Return-Path: <netdev+bounces-243351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B9C9D8DF
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 03:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12877349A78
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133422A4FC;
	Wed,  3 Dec 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KZYxUsUv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8972628;
	Wed,  3 Dec 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764727654; cv=none; b=okpb6XHedBRZdkdg2V0wwoGgd6hb2cPxvapCgaqzTzDkvQtdLOT1ZA8LTG9w6CrcKzntiSrznUqxUut5ZCLDJK0DoxTXZOGRKOWQDLuJMzzqryrR19+4uDvneTFD5or8AcMg/biFTP7Yj+CDnFW9xDL3octQHD0p3RcVj5wAKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764727654; c=relaxed/simple;
	bh=r6nWALuEkJZL/0Gh33Kk6EjfQ7O8FWoU7y9lb21zgYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxVl0KW/nUNaAS4P/+6aHt8aqIFlfTz9HkU1lS6gAo9Wg7ajW2YUakk2KUlbgbRjnVY90TMehoMFTc3eldDer9lOzi/WFSa4c8rIMDZU9fhSjAg4V1oc9I3p7olUYNKrCxjzDG2p9cJUq5fc4eeSBRvnEw5v73amkZSs1Fqy84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KZYxUsUv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HDX8/VSDKMO86crZNm//TsHiEGek8Ev3KkwK+mxZc5M=; b=KZYxUsUvELzAwVuofy7goMtGsY
	MLjfYGUtvBuLQMw9uetYvXG2f4DIprbJTuxP0eSp+XkUfn349bxU3cJK1q3LiO4pL34AKaS7+TmSD
	5bP32GHck9F+g8xKBUvcrRkNrId6IiP1chuhMR5Zh6wUC6imlLoDd9YmTDcsBz2DV3ak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQcH2-00Fl3Z-W2; Wed, 03 Dec 2025 03:07:21 +0100
Date: Wed, 3 Dec 2025 03:07:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>

> +/**
> + * struct mxl862xx_ss_sp_tag
> + * @pid: port ID (1~16)
> + * @mask: bit value 1 to indicate valid field
> + *	0 - rx
> + *	1 - tx
> + *	2 - rx_pen
> + *	3 - tx_pen
> + * @rx: RX special tag mode
> + *	0 - packet does NOT have special tag and special tag is NOT inserted
> + *	1 - packet does NOT have special tag and special tag is inserted
> + *	2 - packet has special tag and special tag is NOT inserted
> + * @tx: TX special tag mode
> + *	0 - packet does NOT have special tag and special tag is NOT removed
> + *	1 - packet has special tag and special tag is replaced
> + *	2 - packet has special tag and special tag is NOT removed
> + *	3 - packet has special tag and special tag is removed
> + * @rx_pen: RX special tag info over preamble
> + *	0 - special tag info inserted from byte 2 to 7 are all 0
> + *	1 - special tag byte 5 is 16, other bytes from 2 to 7 are 0
> + *	2 - special tag byte 5 is from preamble field, others are 0
> + *	3 - special tag byte 2 to 7 are from preabmle field
> + * @tx_pen: TX special tag info over preamble
> + *	0 - disabled
> + *	1 - enabled
> + */
> +struct mxl862xx_ss_sp_tag {
> +	u8 pid;
> +	u8 mask;
> +	u8 rx;
> +	u8 tx;
> +	u8 rx_pen;
> +	u8 tx_pen;
> +} __packed;
> +
> +/**
> + * enum mxl862xx_logical_port_mode - Logical port mode
> + * @MXL862XX_LOGICAL_PORT_8BIT_WLAN: WLAN with 8-bit station ID
> + * @MXL862XX_LOGICAL_PORT_9BIT_WLAN: WLAN with 9-bit station ID
> + * @MXL862XX_LOGICAL_PORT_GPON: GPON OMCI context
> + * @MXL862XX_LOGICAL_PORT_EPON: EPON context
> + * @MXL862XX_LOGICAL_PORT_GINT: G.INT context
> + * @MXL862XX_LOGICAL_PORT_OTHER: Others
> + */
> +enum mxl862xx_logical_port_mode {
> +	MXL862XX_LOGICAL_PORT_8BIT_WLAN = 0,
> +	MXL862XX_LOGICAL_PORT_9BIT_WLAN,
> +	MXL862XX_LOGICAL_PORT_GPON,
> +	MXL862XX_LOGICAL_PORT_EPON,
> +	MXL862XX_LOGICAL_PORT_GINT,
> +	MXL862XX_LOGICAL_PORT_OTHER = 0xFF,
> +};
> +
> +/**
> + * struct mxl862xx_ctp_port_assignment - CTP Port Assignment/association with logical port
> + * @logical_port_id: Logical Port Id. The valid range is hardware dependent
> + * @first_ctp_port_id: First CTP Port ID mapped to above logical port ID
> + * @number_of_ctp_port: Total number of CTP Ports mapped above logical port ID
> + * @mode: See &enum mxl862xx_logical_port_mode
> + * @bridge_port_id: Bridge ID (FID)
> + */
> +struct mxl862xx_ctp_port_assignment {
> +	u8 logical_port_id;
> +	__le16 first_ctp_port_id;
> +	__le16 number_of_ctp_port;
> +	enum mxl862xx_logical_port_mode mode;
> +	__le16 bridge_port_id;
> +} __packed;

Does the C standard define the size of an enum? Do you assume this is
a byte?


> +
> +/**
> + * struct mxl862xx_sys_fw_image_version - VLAN counter mapping configuration

The text seems wrong, probably cut/paste error?

> +#define MXL862XX_MMD_DEV 30

Please use MDIO_MMD_VEND1

> +#define MXL862XX_MMD_REG_CTRL 0
> +#define MXL862XX_MMD_REG_LEN_RET 1
> +#define MXL862XX_MMD_REG_DATA_FIRST 2
> +#define MXL862XX_MMD_REG_DATA_LAST 95
> +#define MXL862XX_MMD_REG_DATA_MAX_SIZE \
> +		(MXL862XX_MMD_REG_DATA_LAST - MXL862XX_MMD_REG_DATA_FIRST + 1)
> +
> +#define MMD_API_SET_DATA_0 (0x0 + 0x2)
> +#define MMD_API_GET_DATA_0 (0x0 + 0x5)
> +#define MMD_API_RST_DATA (0x0 + 0x8)

What is the significant of these numbers? Can you use #defines to make
it clearer?

> +
> +static int mxl862xx_busy_wait(struct mxl862xx_priv *dev)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < MAX_BUSY_LOOP; i++) {
> +		ret = __mdiobus_c45_read(dev->bus, dev->sw_addr,
> +					 MXL862XX_MMD_DEV,
> +					 MXL862XX_MMD_REG_CTRL);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & CTRL_BUSY_MASK)
> +			usleep_range(10, 15);
> +		else
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;

We already have phy_read_mmd_poll_timeout(). Maybe you should add a
__mdiobus_c45_read_poll_timeout()?

Also, as far as i can see, __mdiobus_c45_read() is always called with
the same first three parameters. Maybe add a mxl862xx_reg_read()?  and
a mxl862xx_reg_write()?

> +static int mxl862xx_send_cmd(struct mxl862xx_priv *dev, u16 cmd, u16 size,
> +			     s16 *presult)
> +{
> +	int ret;
> +
> +	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
> +				  MXL862XX_MMD_REG_LEN_RET, size);
> +	if (ret)
> +		return ret;
> +
> +	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
> +				  MXL862XX_MMD_REG_CTRL, cmd | CTRL_BUSY_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_busy_wait(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = __mdiobus_c45_read(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
> +				 MXL862XX_MMD_REG_LEN_RET);
> +	if (ret < 0)
> +		return ret;
> +
> +	*presult = ret;
> +	return 0;
> +}
> +
> +int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
> +		      u16 size, bool read)
> +{
> +	u16 *data = _data;
> +	s16 result = 0;
> +	u16 max, i;
> +	int ret;
> +
> +	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +
> +	max = (size + 1) / 2;
> +
> +	ret = mxl862xx_busy_wait(priv);
> +	if (ret < 0)
> +		goto out;
> +
> +	for (i = 0; i < max; i++) {
> +		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
> +
> +		if (i && off == 0) {
> +			/* Send command to set data when every
> +			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are written.
> +			 */
> +			ret = mxl862xx_set_data(priv, i);
> +			if (ret < 0)
> +				goto out;
> +		}
> +
> +		__mdiobus_c45_write(priv->bus, priv->sw_addr,
> +				    MXL862XX_MMD_DEV,
> +				    MXL862XX_MMD_REG_DATA_FIRST + off,
> +				    le16_to_cpu(data[i]));
> +	}
> +
> +	ret = mxl862xx_send_cmd(priv, cmd, size, &result);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (result < 0) {
> +		ret = result;
> +		goto out;
> +	}

If i'm reading mxl862xx_send_cmd() correct, result is the value of a
register. It seems unlikely this is a Linux error code?

> +
> +	for (i = 0; i < max && read; i++) {

That is an unusual way to use read.

> +		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
> +
> +		if (i && off == 0) {
> +			/* Send command to fetch next batch of data
> +			 * when every MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs
> +			 * are read.
> +			 */
> +			ret = mxl862xx_get_data(priv, i);
> +			if (ret < 0)
> +				goto out;
> +		}
> +
> +		ret = __mdiobus_c45_read(priv->bus, priv->sw_addr,
> +					 MXL862XX_MMD_DEV,
> +					 MXL862XX_MMD_REG_DATA_FIRST + off);
> +		if (ret < 0)
> +			goto out;
> +
> +		if ((i * 2 + 1) == size) {
> +			/* Special handling for last BYTE
> +			 * if it's not WORD aligned.
> +			 */
> +			*(uint8_t *)&data[i] = ret & 0xFF;
> +		} else {
> +			data[i] = cpu_to_le16((u16)ret);
> +		}
> +	}
> +	ret = result;
> +
> +out:
> +	mutex_unlock(&priv->bus->mdio_lock);
> +	return ret;
> +}
> +#define MXL862XX_API_WRITE(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false)
> +#define MXL862XX_API_READ(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true)

> +/* PHY access via firmware relay */
> +static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
> +				 int devadd, int reg)
> +{
> +	struct mdio_relay_data param = {
> +		.phy = port,
> +		.mmd = devadd,
> +		.reg = reg & 0xffff,
> +	};
> +	int ret;
> +
> +	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);

That looks a bit ugly, using a macro as a function name. I would
suggest tiny functions rather than macros. The compiler should do the
right thing.

> +/* Configure CPU tagging */
> +static int mxl862xx_configure_tag_proto(struct dsa_switch *ds, int port,
> +					bool enable)
> +{
> +	struct mxl862xx_ss_sp_tag tag = {
> +		.pid = DSA_MXL_PORT(port),
> +		.mask = BIT(0) | BIT(1),
> +		.rx = enable ? 2 : 1,
> +		.tx = enable ? 2 : 3,
> +	};

There is a bit comment at the beginning of the patch about these, but
it does not help much here. Please could you add some #defines for
these magic numbers.

> +/* Reset switch via MMD write */
> +static int mxl862xx_mmd_write(struct dsa_switch *ds, int reg, u16 data)

The comment does not fit what the function does.

> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	int ret;
> +
> +	mutex_lock(&priv->bus->mdio_lock);
> +	ret = __mdiobus_c45_write(priv->bus, priv->sw_addr, MXL862XX_MMD_DEV,
> +				  reg, data);
> +	mutex_unlock(&priv->bus->mdio_lock);

There is no point using the unlocked version if you wrap it in
lock/unlock...

> +/* Setup */
> +static int mxl862xx_setup(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	int ret, i;
> +
> +	for (i = 0; i < ds->num_ports; i++) {
> +		if (dsa_is_cpu_port(ds, i)) {
> +			priv->cpu_port = i;
> +			break;
> +		}
> +	}
> +
> +	ret = mxl862xx_setup_mdio(ds);
> +	if (ret)
> +		return ret;
> +
> +	/* Software reset */
> +	ret = mxl862xx_mmd_write(ds, 1, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_mmd_write(ds, 0, 0x9907);

More magic numbers.

	Andrew

