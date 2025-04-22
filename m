Return-Path: <netdev+bounces-184672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B861A96CDF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1BF40150F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAB425DD00;
	Tue, 22 Apr 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Gom8o6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AB28151B;
	Tue, 22 Apr 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328679; cv=none; b=Y5xuLr/1mxSBPwfcgt9f7COqECn+QZvLylmPol5wyKM5wnR01eiaOTlLOM0Lzf7fCSCBvXmRNiyW7Xhqeu5+2WEMp7BMlpsvFaj1EU3dJTfAp1v5ZacZS81jKmlAS1G0NkqSnKL5jMJ58G9rV7X4M1MTWM/YhMSF+olSnSFnpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328679; c=relaxed/simple;
	bh=1O/F7jR3isUTtXuS8gmsx+Awwj542obtNcxfZFQbvNA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o/XnB7wHTWzpVQ32ikWBFPa+Uuva3P5cdZrE/uT0rAJndKeM7CkS3FGIToXGhZLCDfYNzgP6YpNMLsR+Wygj87hIJelVpAXihNjKvTjPFFLPRA7LcLvSAiK3rarv5YxrGuHo0D13Fw1DRPdojHugVINh6oqeL8RSN2xfqm+DM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Gom8o6; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso2713722fac.0;
        Tue, 22 Apr 2025 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745328674; x=1745933474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWtvXi1lZA4X1ZRWnABAUfhjPr7bdh9Gvu1eT4tAqUs=;
        b=T0Gom8o6SS7DSKeXMWBSzHnNMQ0NyrnnceF5s2206xh9a1nM+h72FR1gGl61C9SlZX
         Q1T7szHgaRKRPVq20Ywb2DUJznaL8zvM4+wmD2EQrMdnZllPwJ6WNfNMm+cdY+id7iYC
         0yy+etOruCwNKC2PiJzTUiWlVXnqK57KwfXa7X0oW1ENmkzQMpPxVZf6XiCpEBgmIMWZ
         e/4BjQcP3z70DTvD20MERaXg4KOaRQWDPvr18SJqFayRISHnnoVA2lcBxd2ZvR0een15
         XNYVWl7Yks1/bRjQSf5v1OxFrG9nyaXMb77I4/CklE55M0uX6lEU3OKXPLGEe/j2FnLU
         PHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328674; x=1745933474;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWtvXi1lZA4X1ZRWnABAUfhjPr7bdh9Gvu1eT4tAqUs=;
        b=j1pmzNlW1TYydhlMYc9Q3+CDVAyTKpdgGHiwSZ8IX4MnFpuM3ufWvMYqwuFdTBvOhT
         H6MEY2TDXbUg+EWhNjbDBYa48Lp6FVCd3xz8WenV5PCV2EsvATOIZQ5xqpohFWcPtmdL
         dzNUWjKncq5Ly4goTZLzFaagVhUkmQIW59V1gsFaIjevGkNSMxkQt7g0FMCvN9Xr4a84
         Tcty2uMUrVJbf8qZyTlWG66sHDx/7kdm1In9mUZT8BFLVLp7JwBYQ2rWoXltWuRienp0
         4Yd6i+zxIJS5yiwd/Oe1HS7zd2I+BZs0moGK+943TqZz+Az96/OD4qOk4FRjA+DTK19h
         +PLw==
X-Forwarded-Encrypted: i=1; AJvYcCUKM2Gb1ls7piI+6SwdGDZRIINlShxpnay0ORK9A7XtvlKeRRr4SpItPnVzb0MB4c3aCokrnlndzLMO/9x1V+w=@vger.kernel.org, AJvYcCW/67CFmy65wl3MBifOWhUsZAgnpZBvPpZE5OFx1C1XEjc9NdOk9Fxuf4uLWUP5dbsAEAOVDEMe@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHTkVB1rzd0rYA5WthzguZ3mrvVhuSBop+VkWNBCVAZfdEuy7
	Iv6wh+Em39ztxNaZnOuNibtNYwl1u4zkZ8HPRwGbuRoYvp8/cwF5
X-Gm-Gg: ASbGncus7rKdGXN+gMOFrA3xETFZk34U1ioMENYVhpb4iZpgaoybDGQngaGj02gEtYh
	E6zneYWqGJdn7UKxfDTQbh0ohGaz9/p20lTGjygYnl0qFDB4By8wsBcdkP2RH14RrvLQpgKxegw
	SAkdM8wCjdgTNvACfrk6h2Bb5w+r5uULwZeZUDDouw4pK+oiMO6x5sz+6Z/+a8BuAMosGC/Pk07
	DpMbwahb+g2AtKBdHN/y8Dv40tzqplLx1NrHe5qySHURb1R/nPYUr71ff/RJGBrXK+qOMlI46HJ
	djWWBpoiIQoMEHWdVJXJP0jkQ3PlPvPgSGR+erTPWkr2LE/hE/vusBuj8RfMJ2CZ/l2xE5pfS2d
	9sBkne8bc5RwW8ieDKgyGoPbDzKwqVDU=
X-Google-Smtp-Source: AGHT+IH7lWstPmdTCU4BrCHGR0aIqv1cD9s/6PiCr0kcmb2QyW5ZcoVWlIzqwdoog7VnsiBZc6AxhQ==
X-Received: by 2002:a05:6871:630c:b0:29e:24c7:2861 with SMTP id 586e51a60fabf-2d526bd4e5cmr8572843fac.13.1745328674295;
        Tue, 22 Apr 2025 06:31:14 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c3bd57sm56115641cf.20.2025.04.22.06.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:31:13 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:31:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, 
 luiz.dentz@gmail.com, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 kernelxing@tencent.com, 
 andrew@lunn.ch
Message-ID: <68079a212d68_39c4bd29483@willemb.c.googlers.com.notmuch>
In-Reply-To: <0ff3e783e36ac2a18f04cf3bc6c0d639873dd39d.1745272179.git.pav@iki.fi>
References: <0ff3e783e36ac2a18f04cf3bc6c0d639873dd39d.1745272179.git.pav@iki.fi>
Subject: Re: [PATCH] Bluetooth: add support for SIOCETHTOOL
 ETHTOOL_GET_TS_INFO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pauli Virtanen wrote:
> Bluetooth needs some way for user to get supported so_timestamping flags
> for the different socket types.
> 
> Use SIOCETHTOOL API for this purpose. As hci_dev is not associated with
> struct net_device, the existing implementation can't be reused, so we
> add a small one here.
> 
> Add support (only) for ETHTOOL_GET_TS_INFO command. The API differs
> slightly from netdev in that the result depends also on socket proto,
> not just hardware.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>     Another option could be a new socket option, not sure what would be best
>     here. Using SIOCETHTOOL may not be that great since the 'ethtool' program
>     can't query these as the net_device doesn't actually exist.
> 
>  include/net/bluetooth/bluetooth.h |  4 ++
>  net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++++
>  net/bluetooth/hci_conn.c          | 40 ++++++++++++++
>  3 files changed, 131 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index bbefde319f95..114299bd8b98 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -29,6 +29,7 @@
>  #include <linux/poll.h>
>  #include <net/sock.h>
>  #include <linux/seq_file.h>
> +#include <linux/ethtool.h>
>  
>  #define BT_SUBSYS_VERSION	2
>  #define BT_SUBSYS_REVISION	22
> @@ -448,6 +449,9 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
>  			  hci_req_complete_t *req_complete,
>  			  hci_req_complete_skb_t *req_complete_skb);
>  
> +int hci_ethtool_ts_info(unsigned int index, int sk_proto,
> +			struct kernel_ethtool_ts_info *ts_info);
> +
>  #define HCI_REQ_START	BIT(0)
>  #define HCI_REQ_SKB	BIT(1)
>  
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 0b4d0a8bd361..6ad2f72f53f4 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -34,6 +34,9 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <linux/proc_fs.h>
>  
> +#include <linux/ethtool.h>
> +#include <linux/sockios.h>
> +
>  #include "leds.h"
>  #include "selftest.h"
>  
> @@ -563,6 +566,86 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
>  }
>  EXPORT_SYMBOL(bt_sock_poll);
>  
> +static int bt_ethtool_get_ts_info(struct sock *sk, unsigned int index,
> +				  void __user *useraddr)
> +{
> +	struct ethtool_ts_info info;
> +	struct kernel_ethtool_ts_info ts_info = {};
> +	int ret;
> +
> +	ret = hci_ethtool_ts_info(index, sk->sk_protocol, &ts_info);
> +	if (ret == -ENODEV)
> +		return ret;
> +	else if (ret < 0)
> +		return -EIO;
> +
> +	memset(&info, 0, sizeof(info));
> +
> +	info.cmd = ETHTOOL_GET_TS_INFO;
> +	info.so_timestamping = ts_info.so_timestamping;
> +	info.phc_index = ts_info.phc_index;
> +	info.tx_types = ts_info.tx_types;
> +	info.rx_filters = ts_info.rx_filters;
> +
> +	if (copy_to_user(useraddr, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int bt_ethtool(struct sock *sk, const struct ifreq *ifr,
> +		      void __user *useraddr)
> +{
> +	unsigned int index;
> +	u32 ethcmd;
> +	int n;
> +
> +	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
> +		return -EFAULT;
> +
> +	if (sscanf(ifr->ifr_name, "hci%u%n", &index, &n) != 1 ||
> +	    n != strlen(ifr->ifr_name))
> +		return -ENODEV;
> +
> +	switch (ethcmd) {
> +	case ETHTOOL_GET_TS_INFO:
> +		return bt_ethtool_get_ts_info(sk, index, useraddr);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int bt_dev_ioctl(struct socket *sock, unsigned int cmd, void __user *arg)
> +{
> +	struct sock *sk = sock->sk;
> +	struct ifreq ifr = {};
> +	void __user *data;
> +	char *colon;
> +	int ret = -ENOIOCTLCMD;
> +
> +	if (get_user_ifreq(&ifr, &data, arg))
> +		return -EFAULT;
> +
> +	ifr.ifr_name[IFNAMSIZ - 1] = 0;
> +	colon = strchr(ifr.ifr_name, ':');
> +	if (colon)
> +		*colon = 0;
> +
> +	switch (cmd) {
> +	case SIOCETHTOOL:
> +		ret = bt_ethtool(sk, &ifr, data);
> +		break;
> +	}
> +
> +	if (colon)
> +		*colon = ':';
> +
> +	if (put_user_ifreq(&ifr, arg))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> +
>  int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  {
>  	struct sock *sk = sock->sk;
> @@ -595,6 +678,10 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  		err = put_user(amount, (int __user *)arg);
>  		break;
>  
> +	case SIOCETHTOOL:
> +		err = bt_dev_ioctl(sock, cmd, (void __user *)arg);
> +		break;
> +
>  	default:
>  		err = -ENOIOCTLCMD;
>  		break;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 95972fd4c784..55f703076e25 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3186,3 +3186,43 @@ void hci_conn_tx_dequeue(struct hci_conn *conn)
>  
>  	kfree_skb(skb);
>  }
> +
> +int hci_ethtool_ts_info(unsigned int index, int sk_proto,
> +			struct kernel_ethtool_ts_info *info)
> +{
> +	struct hci_dev *hdev;
> +
> +	hdev = hci_dev_get(index);
> +	if (!hdev)
> +		return -ENODEV;
> +
> +	info->so_timestamping =
> +		SOF_TIMESTAMPING_TX_SOFTWARE |
> +		SOF_TIMESTAMPING_SOFTWARE |
> +		SOF_TIMESTAMPING_OPT_ID |
> +		SOF_TIMESTAMPING_OPT_CMSG |
> +		SOF_TIMESTAMPING_OPT_TSONLY;

Options are universally supported, do not have to be advertised
per device.

> +	info->phc_index = -1;
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF);
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE);
> +
> +	switch (sk_proto) {
> +	case BTPROTO_ISO:
> +		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE;
> +		info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
> +		break;
> +	case BTPROTO_L2CAP:
> +		info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;

For netdev, SOF_TIMESTAMPING_RX_SOFTWARE is universally supported.
Because implemented not in the drivers, but in
__netif_receive_skb_core. Does the same not hold for BT?

> +		break;
> +	case BTPROTO_SCO:
> +		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE;
> +		if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> +			info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
> +		break;
> +	default:
> +		info->so_timestamping = 0;
> +	}
> +
> +	hci_dev_put(hdev);
> +	return 0;
> +}
> -- 
> 2.49.0
> 



