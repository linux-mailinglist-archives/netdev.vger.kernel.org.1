Return-Path: <netdev+bounces-142632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D49BFCD6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B242728302D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD422071;
	Thu,  7 Nov 2024 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fktRzNUH"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD96FBF;
	Thu,  7 Nov 2024 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948722; cv=none; b=HWPYfs0s/hTXYWLz08yT4lfT99Q41VjN8lqovzGtUc8DHI1qaMPbLqij4Zk6ngLa92+Op87/dYYcenMqzMLeqeecB9cul7cQr2ejMBlLMoeVOEKx0aq9gMgudTbWoK4hutg2XYYq5gMsaSEc2SPS+H23k1jLW2frGnAPos0NDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948722; c=relaxed/simple;
	bh=IXAD+jCZLyYZRQRfmCNo0LCsdh7gD/znV7S26k0a1UU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LvC5U4jhze0h/TJvXYVgBnEp866AJug+NEjkHAQWj4BLQjHB/IgfZn+kxoMhsSMqLAfSQ7ljoJ2tPnrbdiuyIvE3cVwXxg62+JqMYUIgs8HjJP26H5of+c0pfeG8W1vNWV5CshvmJd67OGsekQr8Ia2iymLqWerkCvEKuaKMSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fktRzNUH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730948711;
	bh=erZFG6Q0iFzHtXVVJZKWsaL8nS/sZz25HN4vZXCTXxw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fktRzNUHs4idIS1oslvsPvtGaZOaLFSukofrNnKtqjqeVdMPWMshQkEAVGD51IzSb
	 ECZycc8Ck+ROhQyppNi97DpnsHsREsvFji5zNXjB0O0Ecq51z8nGTRZCR4i+TsIzo6
	 3hWTpZ7uNZLssI3qfc/RcO9DbiArBtm4u1avvnhiBkzGlVC+gJ08A2D6MzY5pt+tM8
	 bjGU5Ywm702tGgwSWUyvJjvY3/eUSxWav4QdI1zMZp4IDswPOh13wlGSarvU1SDX8E
	 XiuM4AwfrmpzwoZG3bcXe7csWmi3nLM9rm5mOhdfJYxkcvrAkXHMA5lCMntpEWIx2J
	 O4kUjRVQWsJMQ==
Received: from [192.168.12.102] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CDE776B83E;
	Thu,  7 Nov 2024 11:05:08 +0800 (AWST)
Message-ID: <a5349550f7b66ff53c0875b6bcefd20dcd165711.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: Expose transport binding identifier
 via IFLA attribute
From: Matt Johnston <matt@codeconstruct.com.au>
To: Khang Nguyen <khangng@os.amperecomputing.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: ampere-linux-kernel@lists.amperecomputing.com, Phong Vo
 <phong@os.amperecomputing.com>, Thang Nguyen
 <thang@os.amperecomputing.com>,  Khanh Pham <khpham@amperecomputing.com>,
 Phong Vo <pvo@amperecomputing.com>, Quan Nguyen
 <quan@os.amperecomputing.com>, Chanh Nguyen <chanh@os.amperecomputing.com>,
  Thu Nguyen <thu@os.amperecomputing.com>, Hieu Le
 <hieul@amperecomputing.com>, openbmc@lists.ozlabs.org, 
 patches@amperecomputing.com
Date: Thu, 07 Nov 2024 11:05:08 +0800
In-Reply-To: <20241105071915.821871-1-khangng@os.amperecomputing.com>
References: <20241105071915.821871-1-khangng@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Khang, this looks good.

On Tue, 2024-11-05 at 14:19 +0700, Khang Nguyen wrote:
> MCTP control protocol implementations are transport binding dependent.
> Endpoint discovery is mandatory based on transport binding.
> Message timing requirements are specified in each respective transport
> binding specification.
>=20
> However, we currently have no means to get this information from MCTP
> links.
>=20
> Add a IFLA_MCTP_PHYS_BINDING netlink link attribute, which represents
> the transport type using the DMTF DSP0239-defined type numbers, returned
> as part of RTM_GETLINK data.
>=20
> We get an IFLA_MCTP_PHYS_BINDING attribute for each MCTP link, for
> example:
>=20
> - 0x00 (unspec) for loopback interface;
> - 0x01 (SMBus/I2C) for mctpi2c%d interfaces; and
> - 0x05 (serial) for mctpserial%d interfaces.
>=20
> Signed-off-by: Khang Nguyen <khangng@os.amperecomputing.com>
> ---
>  drivers/net/mctp/mctp-i2c.c    |  3 ++-
>  drivers/net/mctp/mctp-i3c.c    |  2 +-
>  drivers/net/mctp/mctp-serial.c |  5 +++--
>  include/net/mctp.h             | 18 ++++++++++++++++++
>  include/net/mctpdevice.h       |  4 +++-
>  include/uapi/linux/if_link.h   |  1 +
>  net/mctp/device.c              | 12 +++++++++---
>  7 files changed, 37 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index 4dc057c121f5..86151a03570e 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
> @@ -877,7 +877,8 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client=
 *mcli,
>  		goto err;
>  	}
> =20
> -	rc =3D mctp_register_netdev(ndev, &mctp_i2c_mctp_ops);
> +	rc =3D mctp_register_netdev(ndev, &mctp_i2c_mctp_ops,
> +				  MCTP_PHYS_BINDING_SMBUS);
>  	if (rc < 0) {
>  		dev_err(&mcli->client->dev,
>  			"register netdev \"%s\" failed %d\n",
> diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
> index 1bc87a062686..9adad59b8676 100644
> --- a/drivers/net/mctp/mctp-i3c.c
> +++ b/drivers/net/mctp/mctp-i3c.c
> @@ -607,7 +607,7 @@ __must_hold(&busdevs_lock)
>  		goto err_free_uninit;
>  	}
> =20
> -	rc =3D mctp_register_netdev(ndev, NULL);
> +	rc =3D mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_I3C);
>  	if (rc < 0) {
>  		dev_warn(&ndev->dev, "netdev register failed: %d\n", rc);
>  		goto err_free_netdev;
> diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-seria=
l.c
> index e63720ec3238..26c9a33fd636 100644
> --- a/drivers/net/mctp/mctp-serial.c
> +++ b/drivers/net/mctp/mctp-serial.c
> @@ -23,6 +23,7 @@
> =20
>  #include <linux/mctp.h>
>  #include <net/mctp.h>
> +#include <net/mctpdevice.h>
>  #include <net/pkt_sched.h>
> =20
>  #define MCTP_SERIAL_MTU		68 /* base mtu (64) + mctp header */
> @@ -470,7 +471,7 @@ static int mctp_serial_open(struct tty_struct *tty)
>  	spin_lock_init(&dev->lock);
>  	INIT_WORK(&dev->tx_work, mctp_serial_tx_work);
> =20
> -	rc =3D register_netdev(ndev);
> +	rc =3D mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_SERIAL);
>  	if (rc)
>  		goto free_netdev;
> =20
> @@ -492,7 +493,7 @@ static void mctp_serial_close(struct tty_struct *tty)
>  	struct mctp_serial *dev =3D tty->disc_data;
>  	int idx =3D dev->idx;
> =20
> -	unregister_netdev(dev->netdev);
> +	mctp_unregister_netdev(dev->netdev);
>  	ida_free(&mctp_serial_ida, idx);
>  }
> =20
> diff --git a/include/net/mctp.h b/include/net/mctp.h
> index 28d59ae94ca3..1ecbff7116f6 100644
> --- a/include/net/mctp.h
> +++ b/include/net/mctp.h
> @@ -298,4 +298,22 @@ void mctp_routes_exit(void);
>  int mctp_device_init(void);
>  void mctp_device_exit(void);
> =20
> +/* MCTP IDs and Codes from DMTF specification
> + * "DSP0239 Management Component Transport Protocol (MCTP) IDs and Codes=
"
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0239_=
1.11.1.pdf
> + */
> +enum mctp_phys_binding {
> +	MCTP_PHYS_BINDING_UNSPEC	=3D 0x00,
> +	MCTP_PHYS_BINDING_SMBUS		=3D 0x01,
> +	MCTP_PHYS_BINDING_PCIE_VDM	=3D 0x02,
> +	MCTP_PHYS_BINDING_USB		=3D 0x03,
> +	MCTP_PHYS_BINDING_KCS		=3D 0x04,
> +	MCTP_PHYS_BINDING_SERIAL	=3D 0x05,
> +	MCTP_PHYS_BINDING_I3C		=3D 0x06,
> +	MCTP_PHYS_BINDING_MMBI		=3D 0x07,
> +	MCTP_PHYS_BINDING_PCC		=3D 0x08,
> +	MCTP_PHYS_BINDING_UCIE		=3D 0x09,
> +	MCTP_PHYS_BINDING_VENDOR	=3D 0xFF,
> +};
> +
>  #endif /* __NET_MCTP_H */
> diff --git a/include/net/mctpdevice.h b/include/net/mctpdevice.h
> index 5c0d04b5c12c..957d9ef924c5 100644
> --- a/include/net/mctpdevice.h
> +++ b/include/net/mctpdevice.h
> @@ -22,6 +22,7 @@ struct mctp_dev {
>  	refcount_t		refs;
> =20
>  	unsigned int		net;
> +	enum mctp_phys_binding	binding;
> =20
>  	const struct mctp_netdev_ops *ops;
> =20
> @@ -44,7 +45,8 @@ struct mctp_dev *mctp_dev_get_rtnl(const struct net_dev=
ice *dev);
>  struct mctp_dev *__mctp_dev_get(const struct net_device *dev);
> =20
>  int mctp_register_netdev(struct net_device *dev,
> -			 const struct mctp_netdev_ops *ops);
> +			 const struct mctp_netdev_ops *ops,
> +			 enum mctp_phys_binding binding);
>  void mctp_unregister_netdev(struct net_device *dev);
> =20
>  void mctp_dev_hold(struct mctp_dev *mdev);
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 8516c1ccd57a..2575e0cd9b48 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1958,6 +1958,7 @@ struct ifla_rmnet_flags {
>  enum {
>  	IFLA_MCTP_UNSPEC,
>  	IFLA_MCTP_NET,
> +	IFLA_MCTP_PHYS_BINDING,
>  	__IFLA_MCTP_MAX,
>  };
> =20
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 3d75b919995d..26ce34b7e88e 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -371,6 +371,8 @@ static int mctp_fill_link_af(struct sk_buff *skb,
>  		return -ENODATA;
>  	if (nla_put_u32(skb, IFLA_MCTP_NET, mdev->net))
>  		return -EMSGSIZE;
> +	if (nla_put_u8(skb, IFLA_MCTP_PHYS_BINDING, mdev->binding))
> +		return -EMSGSIZE;
>  	return 0;
>  }
> =20
> @@ -385,6 +387,7 @@ static size_t mctp_get_link_af_size(const struct net_=
device *dev,
>  	if (!mdev)
>  		return 0;
>  	ret =3D nla_total_size(4); /* IFLA_MCTP_NET */
> +	ret +=3D nla_total_size(1); /* IFLA_MCTP_PHYS_BINDING */
>  	mctp_dev_put(mdev);
>  	return ret;
>  }
> @@ -480,7 +483,8 @@ static int mctp_dev_notify(struct notifier_block *thi=
s, unsigned long event,
>  }
> =20
>  static int mctp_register_netdevice(struct net_device *dev,
> -				   const struct mctp_netdev_ops *ops)
> +				   const struct mctp_netdev_ops *ops,
> +				   enum mctp_phys_binding binding)
>  {
>  	struct mctp_dev *mdev;
> =20
> @@ -489,17 +493,19 @@ static int mctp_register_netdevice(struct net_devic=
e *dev,
>  		return PTR_ERR(mdev);
> =20
>  	mdev->ops =3D ops;
> +	mdev->binding =3D binding;
> =20
>  	return register_netdevice(dev);
>  }
> =20
>  int mctp_register_netdev(struct net_device *dev,
> -			 const struct mctp_netdev_ops *ops)
> +			 const struct mctp_netdev_ops *ops,
> +			 enum mctp_phys_binding binding)
>  {
>  	int rc;
> =20
>  	rtnl_lock();
> -	rc =3D mctp_register_netdevice(dev, ops);
> +	rc =3D mctp_register_netdevice(dev, ops, binding);
>  	rtnl_unlock();
> =20
>  	return rc;

Reviewed-by: Matt Johnston <matt@codeconstruct.com.au>

