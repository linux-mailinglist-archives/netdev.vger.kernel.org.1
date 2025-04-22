Return-Path: <netdev+bounces-184821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E4A97521
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA637A3188
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383020D4F6;
	Tue, 22 Apr 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="QG2hOaPu"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CCA1DEFC8;
	Tue, 22 Apr 2025 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348928; cv=pass; b=Y/VLWK+npEmZhFUzNO/DUxCm+Evth5cRn3x68Pbs6tw4zSIyWj4bDKpdF0drfFyXpfibL93fDFyuTNjB2ZCMGzQNzmunKO3ffnU0YcwUquVBE1lgex3+TKcJ3dOh0nrmJLqn9/0EgplEPVCWSZUMeVuNiggK4qu7cRa+Ml9xW1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348928; c=relaxed/simple;
	bh=P5ur+XrzFVcAUwDLcapmPsq2TuoX2s7DiGywCVTc1So=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUUb08lEugfIl8OHirTnjQiktRWtTh9n5DjGwUjIeaWO4plTNDMt2DDF01pukG4wivkGULY+VG66crHOFy/DoYVgIIID0/xmLPSPaNpYVak1cp4SaL3s3AQcB01C6T/Fn7GNOxRDrX2iSIVGMrE0h6jkwlgb7n2NFvo3cVqwnxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=QG2hOaPu; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZhsGG0Rlpz49Psw;
	Tue, 22 Apr 2025 22:08:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745348919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZ888A4cR0IPz0DzkmvdzwMYPKU+0D3yen3Y8Zf+H68=;
	b=QG2hOaPuq4TiX5QSbNSa7u+2HdTsioCCMZ1MU1RGU0XI6APzvAEYFU7TskjKcK45S3mACK
	lOIutPtDyaeOmW+6awzogGcO/p7SBjW4de7NLX7o6kmbW0vT3qypHhGV3cwEwgOr8gf2kr
	HkOSwSfJ8IFocDrQ8IlbEWpPpArgRHoZ6GMB1VUrYklUQ6Qn66I3uv+02+GMtKizW425yy
	FGk21uZ0AmY0RlzcCsrHgZ7/zgClwQkzR09Vjwe54MUWXDXddkLxRBP4B1Px3VmdkPEjd8
	cLo3UFiuRCXNHF9nyMwqBUJVHyH+JZOqYAMaNWQMoZPH5SeHbuV/lEI5Ukk+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745348919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZ888A4cR0IPz0DzkmvdzwMYPKU+0D3yen3Y8Zf+H68=;
	b=Jp3VMIcfBFh7IMPaFbhlsrFjRi47J/wIW1hRzxUtfMUHcgxZii19D8+AFtu8XR7q9LKL4c
	hsKGEmSZEOIb5fUQVhjINPc1MM8cYB9z9w9P78IS6+Dsv2ExOsERO+lwpp8vkjZW5X3WdM
	vbcVFOhJAXfherrpAEJuX1/3rInfWTdkUkqr+v5gVV6N54WwyYyxBM1aJ+zfLMkxZQ7dSk
	PfCl/64PfcSi/oX8UqI2tFO0dDUgxP9urfwHr1SmV7MHvfBvra8Oi0r3uX6IuhEwtApss/
	vrnW0rpskbG9UOD6jRn3UryJxCx2NmB3iGdLXAY+FTkP0BgdbYujskwFkYNdOw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745348919; a=rsa-sha256;
	cv=none;
	b=i86IlKlz0NorynQchvCUWkm11+KIYNyPBtCgOfTnyOkueq2h5ZtaXjhaBYv9R4kzwnIJAs
	5LZ6e9sCGM8UsjSnk4t0rogTpPMohSAF20sdztsPgJBzNMqeFBBSJ5TQZuRMr0WDpCl1v0
	/rA1Hj/RKX6BVAWs3A7MfAbPbG1xAsSNpfFuom1/0kirjEzPR139Bi4T0EBB0Djtjh57z+
	s2NWNK/u5F3NGm5AzZjJJyjlXmAfcF+M+cbkwEgdFEqNUKSA4yYvwKBMQLO0b7QYs3Iori
	XedLcgSNdqLLEpVZzthN1vWRbsNFZifPvoWNIF9aVVawHyeA5aTMfHNqUD1Qkw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <ceef0e19687d24fbb7847cbf95a2421414fb1fb5.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: add support for SIOCETHTOOL
 ETHTOOL_GET_TS_INFO
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, netdev@vger.kernel.org, kernelxing@tencent.com, 
	andrew@lunn.ch
Date: Tue, 22 Apr 2025 22:08:35 +0300
In-Reply-To: <68079a212d68_39c4bd29483@willemb.c.googlers.com.notmuch>
References: 
	<0ff3e783e36ac2a18f04cf3bc6c0d639873dd39d.1745272179.git.pav@iki.fi>
	 <68079a212d68_39c4bd29483@willemb.c.googlers.com.notmuch>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2025-04-22 kello 09:31 -0400, Willem de Bruijn kirjoitti:
> Pauli Virtanen wrote:
> > Bluetooth needs some way for user to get supported so_timestamping flag=
s
> > for the different socket types.
> >=20
> > Use SIOCETHTOOL API for this purpose. As hci_dev is not associated with
> > struct net_device, the existing implementation can't be reused, so we
> > add a small one here.
> >=20
> > Add support (only) for ETHTOOL_GET_TS_INFO command. The API differs
> > slightly from netdev in that the result depends also on socket proto,
> > not just hardware.
> >=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     Another option could be a new socket option, not sure what would be=
 best
> >     here. Using SIOCETHTOOL may not be that great since the 'ethtool' p=
rogram
> >     can't query these as the net_device doesn't actually exist.
> >=20
> >  include/net/bluetooth/bluetooth.h |  4 ++
> >  net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_conn.c          | 40 ++++++++++++++
> >  3 files changed, 131 insertions(+)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index bbefde319f95..114299bd8b98 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -29,6 +29,7 @@
> >  #include <linux/poll.h>
> >  #include <net/sock.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/ethtool.h>
> > =20
> >  #define BT_SUBSYS_VERSION	2
> >  #define BT_SUBSYS_REVISION	22
> > @@ -448,6 +449,9 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16=
 opcode, u8 status,
> >  			  hci_req_complete_t *req_complete,
> >  			  hci_req_complete_skb_t *req_complete_skb);
> > =20
> > +int hci_ethtool_ts_info(unsigned int index, int sk_proto,
> > +			struct kernel_ethtool_ts_info *ts_info);
> > +
> >  #define HCI_REQ_START	BIT(0)
> >  #define HCI_REQ_SKB	BIT(1)
> > =20
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 0b4d0a8bd361..6ad2f72f53f4 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -34,6 +34,9 @@
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <linux/proc_fs.h>
> > =20
> > +#include <linux/ethtool.h>
> > +#include <linux/sockios.h>
> > +
> >  #include "leds.h"
> >  #include "selftest.h"
> > =20
> > @@ -563,6 +566,86 @@ __poll_t bt_sock_poll(struct file *file, struct so=
cket *sock,
> >  }
> >  EXPORT_SYMBOL(bt_sock_poll);
> > =20
> > +static int bt_ethtool_get_ts_info(struct sock *sk, unsigned int index,
> > +				  void __user *useraddr)
> > +{
> > +	struct ethtool_ts_info info;
> > +	struct kernel_ethtool_ts_info ts_info =3D {};
> > +	int ret;
> > +
> > +	ret =3D hci_ethtool_ts_info(index, sk->sk_protocol, &ts_info);
> > +	if (ret =3D=3D -ENODEV)
> > +		return ret;
> > +	else if (ret < 0)
> > +		return -EIO;
> > +
> > +	memset(&info, 0, sizeof(info));
> > +
> > +	info.cmd =3D ETHTOOL_GET_TS_INFO;
> > +	info.so_timestamping =3D ts_info.so_timestamping;
> > +	info.phc_index =3D ts_info.phc_index;
> > +	info.tx_types =3D ts_info.tx_types;
> > +	info.rx_filters =3D ts_info.rx_filters;
> > +
> > +	if (copy_to_user(useraddr, &info, sizeof(info)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int bt_ethtool(struct sock *sk, const struct ifreq *ifr,
> > +		      void __user *useraddr)
> > +{
> > +	unsigned int index;
> > +	u32 ethcmd;
> > +	int n;
> > +
> > +	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
> > +		return -EFAULT;
> > +
> > +	if (sscanf(ifr->ifr_name, "hci%u%n", &index, &n) !=3D 1 ||
> > +	    n !=3D strlen(ifr->ifr_name))
> > +		return -ENODEV;
> > +
> > +	switch (ethcmd) {
> > +	case ETHTOOL_GET_TS_INFO:
> > +		return bt_ethtool_get_ts_info(sk, index, useraddr);
> > +	}
> > +
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int bt_dev_ioctl(struct socket *sock, unsigned int cmd, void __=
user *arg)
> > +{
> > +	struct sock *sk =3D sock->sk;
> > +	struct ifreq ifr =3D {};
> > +	void __user *data;
> > +	char *colon;
> > +	int ret =3D -ENOIOCTLCMD;
> > +
> > +	if (get_user_ifreq(&ifr, &data, arg))
> > +		return -EFAULT;
> > +
> > +	ifr.ifr_name[IFNAMSIZ - 1] =3D 0;
> > +	colon =3D strchr(ifr.ifr_name, ':');
> > +	if (colon)
> > +		*colon =3D 0;
> > +
> > +	switch (cmd) {
> > +	case SIOCETHTOOL:
> > +		ret =3D bt_ethtool(sk, &ifr, data);
> > +		break;
> > +	}
> > +
> > +	if (colon)
> > +		*colon =3D ':';
> > +
> > +	if (put_user_ifreq(&ifr, arg))
> > +		return -EFAULT;
> > +
> > +	return ret;
> > +}
> > +
> >  int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long=
 arg)
> >  {
> >  	struct sock *sk =3D sock->sk;
> > @@ -595,6 +678,10 @@ int bt_sock_ioctl(struct socket *sock, unsigned in=
t cmd, unsigned long arg)
> >  		err =3D put_user(amount, (int __user *)arg);
> >  		break;
> > =20
> > +	case SIOCETHTOOL:
> > +		err =3D bt_dev_ioctl(sock, cmd, (void __user *)arg);
> > +		break;
> > +
> >  	default:
> >  		err =3D -ENOIOCTLCMD;
> >  		break;
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 95972fd4c784..55f703076e25 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -3186,3 +3186,43 @@ void hci_conn_tx_dequeue(struct hci_conn *conn)
> > =20
> >  	kfree_skb(skb);
> >  }
> > +
> > +int hci_ethtool_ts_info(unsigned int index, int sk_proto,
> > +			struct kernel_ethtool_ts_info *info)
> > +{
> > +	struct hci_dev *hdev;
> > +
> > +	hdev =3D hci_dev_get(index);
> > +	if (!hdev)
> > +		return -ENODEV;
> > +
> > +	info->so_timestamping =3D
> > +		SOF_TIMESTAMPING_TX_SOFTWARE |
> > +		SOF_TIMESTAMPING_SOFTWARE |
> > +		SOF_TIMESTAMPING_OPT_ID |
> > +		SOF_TIMESTAMPING_OPT_CMSG |
> > +		SOF_TIMESTAMPING_OPT_TSONLY;
>=20
> Options are universally supported, do not have to be advertised
> per device.

Ok.

> > +	info->phc_index =3D -1;
> > +	info->tx_types =3D BIT(HWTSTAMP_TX_OFF);
> > +	info->rx_filters =3D BIT(HWTSTAMP_FILTER_NONE);
> > +
> > +	switch (sk_proto) {
> > +	case BTPROTO_ISO:
> > +		info->so_timestamping |=3D SOF_TIMESTAMPING_RX_SOFTWARE;
> > +		info->so_timestamping |=3D SOF_TIMESTAMPING_TX_COMPLETION;
> > +		break;
> > +	case BTPROTO_L2CAP:
> > +		info->so_timestamping |=3D SOF_TIMESTAMPING_TX_COMPLETION;
>=20
> For netdev, SOF_TIMESTAMPING_RX_SOFTWARE is universally supported.
> Because implemented not in the drivers, but in
> __netif_receive_skb_core. Does the same not hold for BT?

There is a timestamp assigned to all skbs when core gets them from
driver, so it should work in the same way.

I'll need to look a bit more into what is going on with L2CAP, I have
one use case where RX timestamps for L2CAP are missing, but I see now
in other tests it works as expected.

>=20
> > +		break;
> > +	case BTPROTO_SCO:
> > +		info->so_timestamping |=3D SOF_TIMESTAMPING_RX_SOFTWARE;
> > +		if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> > +			info->so_timestamping |=3D SOF_TIMESTAMPING_TX_COMPLETION;
> > +		break;
> > +	default:
> > +		info->so_timestamping =3D 0;
> > +	}
> > +
> > +	hci_dev_put(hdev);
> > +	return 0;
> > +}
> > --=20
> > 2.49.0
> >=20
>=20

--=20
Pauli Virtanen

