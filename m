Return-Path: <netdev+bounces-186760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D3AA0F10
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07693B2A48
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA6204C07;
	Tue, 29 Apr 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jcpjU+oY"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9518A93F;
	Tue, 29 Apr 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937358; cv=pass; b=bAll3Gbv0oykvjFQZ8S+eqn+MqBvv30oXQErn5Hns4C860AyCHVzRai3qCaGJ+6pNgfE5BC6IC+gJDDIGFfjY4ivNXJmLwT1Rb+2ydkw370nN01Y63o9zmjD5kmaRyXdsHeSuSMxqK/02aBoATZcRUXiNLnF2GyPy5BwBn+nxSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937358; c=relaxed/simple;
	bh=B4ZhHOPWXTLD+jks4hLgkwngmiPIC29s07o73k+klWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFxCX/4QK0FKXRtC6NYth9+My6zz/KVO9uk2iFTPRqxN4IgfPfgA5rlAA7umoAcPh810tvgSZsiq+ni1c3mMmxplpmPfTG7zepo5g15mpXvVrIovIEVc1q2dLRqgXYu5/io4igvRt4tRTdKNTmy6AtJpISdxFGVK5jvjWbcR/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jcpjU+oY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zn2gm0h4Lz49QKR;
	Tue, 29 Apr 2025 17:26:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745936805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+LPdLHldj8m4kLlIoSXyLpt2zuVRo5HpVSDqROrbTwA=;
	b=jcpjU+oYZWfAmdwZqBXAq5dqSSkR08KOfneCg5jCFxpM9RiGYqb8aaQirhlNQF8YXS5Ww5
	P3P34p0ttU4LFwCEDR9eAshs6EKfVWCY4GxtCmIbfZfALxlxn4QriNjKh9yr3p4VhRvPn9
	/cAmf4YvNKGtY+t0xaP+weFcMmW4YUpGThS/r8OquEMvyK+61rdmxOOyQvO69/1M2sSf4E
	kBoaTZ2Llm6Guqh8HK6JUTr5Apha1jJRF4J/kLJfw/vgxL2WkXeF/nbhGw3wRWXPBSs1YO
	1CZBIz4IzkawiR3gIUPt2STkfUGHqI1nHzIBZmDyS+wS3Fh9FzzZmX4HrifU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745936805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+LPdLHldj8m4kLlIoSXyLpt2zuVRo5HpVSDqROrbTwA=;
	b=jGNnfwlGOe/v/Y5/ZRjeE4BteZl/yixU1pkAV+7LYSVY8VxI41zF3YmevgtKlUTKDze9sD
	N6QSJ+1Igtesqv3F5Qhtk4Ew+uSUprxsdqCLDDqILqYlUcmdB8+ZvdJGeyaRol/ups9BBK
	IZVN/wyZFa4ROp96ElB3C3NQ3+CEyfI3zNsjt9WXL7/zkUlCO0AC2gbp4Mw6tAMAqUlB81
	eEuVe5iBLJWoRXbdkV8uA7AC6wecVrmpx9K/ONtFPuLQGUJ3FCqRz8y6cKTVPcB6O8msRE
	OUsHB/i+Dga3PJkyxutHb2pI2kM3OsSvwamPvmGECiYDrqD2nb2atr+9AOtyuw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745936805; a=rsa-sha256;
	cv=none;
	b=FyS/OxLn+S7c8FR6FhZ4NnfgqZRj4JLKtThvq3sen4IphZZh3poxIHMvXRtKtIojhcxAA/
	DJQOUhM3xGEPY+IhrpnZq4BY8FQUxf5Ji/6XYokiLJXHOP4O1UolJQerNiORK0tN9HYTif
	K3ez+SgpOKaje4Tx3Q43HWfcjun7kFHOwT/uMhRWT1C2sOg7f03tKC42yGUFVRYKpnYxaW
	NCBw39hrMUGOnSSrgm0HDBkCToBeqFhAYg7/sDmQGSX9FY5DAQPLEWElwqYSblNjguAdpO
	mjji26fF+gpTCOFAgnjg2RTq2z2lE7N0IyBS2RHLBwyxt9hQT17m15FV5Z0/QQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi>
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Luiz Augusto
 von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Apr 2025 17:26:41 +0300
In-Reply-To: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
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

Hi,

ti, 2025-04-29 kello 11:35 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> Application layer programs (like pipewire) need to use
> iso timestamp information for audio synchronization.

I think the timestamp should be put into CMSG, same ways as packet
status is. The packet body should then always contain only the payload.

>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  include/net/bluetooth/bluetooth.h |  4 ++-
>  net/bluetooth/iso.c               | 58 +++++++++++++++++++++++++++++++++=
------
>  2 files changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index bbefde319f95..a102bd76647c 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -242,6 +242,7 @@ struct bt_codecs {
>  #define BT_CODEC_MSBC		0x05
> =20
>  #define BT_ISO_BASE		20
> +#define BT_ISO_TS		21
> =20
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
> @@ -390,7 +391,8 @@ struct bt_sock {
>  enum {
>  	BT_SK_DEFER_SETUP,
>  	BT_SK_SUSPEND,
> -	BT_SK_PKT_STATUS
> +	BT_SK_PKT_STATUS,
> +	BT_SK_ISO_TS
>  };
> =20
>  struct bt_sock_list {
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 2f348f48e99d..2c1fdea4b8c1 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socket *sock=
, int level, int optname,
>  		iso_pi(sk)->base_len =3D optlen;
> =20
>  		break;
> +	case BT_ISO_TS:
> +		if (optlen !=3D sizeof(opt)) {
> +			err =3D -EINVAL;
> +			break;
> +		}
> =20
> +		err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> +		if (err)
> +			break;
> +
> +		if (opt)
> +			set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> +		else
> +			clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> +		break;
>  	default:
>  		err =3D -ENOPROTOOPT;
>  		break;
> @@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socket *sock=
, int level, int optname,
>  			err =3D -EFAULT;
> =20
>  		break;
> +	case BT_ISO_TS:
> +		if (len < sizeof(u32)) {
> +			err =3D -EINVAL;
> +			break;
> +		}
> =20
> +		if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags),
> +			    (u32 __user *)optval))
> +			err =3D -EFAULT;
> +		break;
>  	default:
>  		err =3D -ENOPROTOOPT;
>  		break;
> @@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_conn *hcon=
, __u8 reason)
>  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  {
>  	struct iso_conn *conn =3D hcon->iso_data;
> +	struct sock *sk;
>  	__u16 pb, ts, len;
> =20
>  	if (!conn)
>  		goto drop;
> =20
> -	pb     =3D hci_iso_flags_pb(flags);
> -	ts     =3D hci_iso_flags_ts(flags);
> +	iso_conn_lock(conn);
> +	sk =3D conn->sk;
> +	iso_conn_unlock(conn);
> +
> +	if (!sk)
> +		goto drop;
> +
> +	pb =3D hci_iso_flags_pb(flags);
> +	ts =3D hci_iso_flags_ts(flags);
> =20
>  	BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
> =20
> @@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
>  		if (ts) {
>  			struct hci_iso_ts_data_hdr *hdr;
> =20
> -			/* TODO: add timestamp to the packet? */
> -			hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
> -			if (!hdr) {
> -				BT_ERR("Frame is too short (len %d)", skb->len);
> -				goto drop;
> -			}
> +			if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
> +				hdr =3D (struct hci_iso_ts_data_hdr *)skb->data;
> +				len =3D hdr->slen + HCI_ISO_TS_DATA_HDR_SIZE;
> +			} else {
> +				hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
> +				if (!hdr) {
> +					BT_ERR("Frame is too short (len %d)", skb->len);
> +					goto drop;
> +				}
> =20
> -			len =3D __le16_to_cpu(hdr->slen);
> +				len =3D __le16_to_cpu(hdr->slen);
> +			}
>  		} else {
>  			struct hci_iso_data_hdr *hdr;
> =20
> +			if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
> +				BT_ERR("Invalid option BT_SK_ISO_TS");
> +				clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> +			}
> +
>  			hdr =3D skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE);
>  			if (!hdr) {
>  				BT_ERR("Frame is too short (len %d)", skb->len);
>=20
> ---
> base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
> change-id: 20250421-iso_ts-c82a300ae784
>=20
> Best regards,

--=20
Pauli Virtanen

