Return-Path: <netdev+bounces-186759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E0AA0F11
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6904A1F6B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00783215F6C;
	Tue, 29 Apr 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ehcw0MU/"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614AA20E6E4;
	Tue, 29 Apr 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937331; cv=pass; b=ox5G96lUJfnLiEqLb90RFdkAB7a59ynrW1EjNYq8FwH0QZxtwkgIIZuMT9fNf0hgDa6BiOdvirfslnNMUYA4YlbpKwdUD4LnUIQ5KIdBO5L6NpKmNdEVZyq/kgR0menomeAMMZHrP+/eXBgJuvr1fG8jCcbLHxDll1yWE9hqUp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937331; c=relaxed/simple;
	bh=wYMHV6fprtv/QBs2jjHWuf941nt+DE9olk41DdtoVDQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XVNh1kH3jUeTywBK3GErZ/9kfExYpGqfU+g4gOdvZkx2Ewqk87mI9oZlYni9tyOZ7JQ3QnwfHi2q0df9ZQ1BVclgjGDWzblKWu+yteyTI3iGHUzQGV1cY4MSd37dQs6wAMqwEbGymPNPYJTTf0pvxFyHAaEkqLyUx7E5d7A+H3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ehcw0MU/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [127.0.0.1] (unknown [193.138.7.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zn2sl1CTKz49QLN;
	Tue, 29 Apr 2025 17:35:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745937323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOx46cBGbzAinnys1EjJeWlNLzdkCRke80YjYgbe6Z8=;
	b=Ehcw0MU/cuHk1rWCudpX005vbR60/lIrSKnx0+4rUfBF+ekiMWvR3t9zTgRMDAkHzVMBBl
	11S5o3r5IyQuZUzNdtfiXKS93b9L93MM6iZPROsz98YmCM6ppuQdKMWN/bZ3X1pNBht9k5
	aVne1eeCGo6qlWKW8izACiH/XfDelc9pGK+VBMKQls+edTxlfcEa8i+Xkbq8EPtT12Zo7F
	QzsHTS2w5MPa7IVHqxSfVnUFKmnVfEK5F5T87hnWTDp7Rr2BvzBDpdHjW9Oi1FjMRPcAgB
	xcf2UtM4f5QBrfiYBdXq3liuiWTzGvQtnB85ONXK3KpfleVDExcKKup4BGCMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745937323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOx46cBGbzAinnys1EjJeWlNLzdkCRke80YjYgbe6Z8=;
	b=t0ba0e0QoS3vUdX7W1EyeCiiKzxpPCvDEuk/iJ3gdDd9QyjjXDZgmI/PaVnPyjJ1ObX3j2
	l1kbsc2HJu1wbjaqmWulZVo4mkqL8hRhM8DUwFIAdruO7preNuJCI+mPsrXah8jbaXvMBn
	nQqmY5ZkH+kx7oUbYxdbjl+APz4nZ1jiBoD3gvNkXg6JXxA9DV7CnJg4tHzVwY/eTJoHGJ
	017hOh05G7uTe6Yg5AJRHBQoYYMAx1w3czmJNmnsl4emMMCZZFDKFTB99TF4yTviu/S9tP
	3OeccVgxz54xZwfrfMRhhj0pQhUUjD4b1UR1/bAMTVLdZLEfpEmsRoGcwnucOw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745937323; a=rsa-sha256;
	cv=none;
	b=ry02MmHhWFlUDvrC6Sri2ZZ98cFlx+q03SNnPQbZEs/20oc91JSo9322npxSIknkxLmmwu
	ssv6JX6cU3Mza8bR/haIaMZf9hQkhBhzFdnV3IFRrWd29uKm0enZSgyxCTHKWe7pXwPNHN
	n29wtsmsF7su96xKm5P/KGXamg7NOFCmuQzuTbpazdM/H1lLH26gypAYzK/EA8siWVJGGl
	nNWcVbxharZ4bxokxigw5NKoLshWSSxrdrqx3waAs1oUD6wpGixu/q2VXaBpmZYWGS7mPi
	ZTI9ZHu78jDE8PdkYfeYS38sTOHqAaKnSk86OcVMC34U8hV56ShdEkb9tWdfWA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Date: Tue, 29 Apr 2025 17:35:21 +0300
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: yang.li@amlogic.com, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
User-Agent: K-9 Mail for Android
In-Reply-To: <CABBYNZ+StxjHC4f_JmPdJg2iv+o+ngyEuSvsBZB7Rrr=9juouQ@mail.gmail.com>
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com> <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi> <d68a9f4b25f6df883a75f1a44eb90bee64d4c3bc.camel@iki.fi> <CABBYNZ+StxjHC4f_JmPdJg2iv+o+ngyEuSvsBZB7Rrr=9juouQ@mail.gmail.com>
Message-ID: <86F23E2B-3648-4EDE-8FAA-96C6DEA84813@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

29=2E huhtikuuta 2025 17=2E31=2E25 GMT+03:00 Luiz Augusto von Dentz <luiz=
=2Edentz@gmail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Tue, Apr 29, 2025 at 10:29=E2=80=AFAM Pauli Virtanen <pav@iki=2Efi> wr=
ote:
>>
>> ti, 2025-04-29 kello 17:26 +0300, Pauli Virtanen kirjoitti:
>> > Hi,
>> >
>> > ti, 2025-04-29 kello 11:35 +0800, Yang Li via B4 Relay kirjoitti:
>> > > From: Yang Li <yang=2Eli@amlogic=2Ecom>
>> > >
>> > > Application layer programs (like pipewire) need to use
>> > > iso timestamp information for audio synchronization=2E
>> >
>> > I think the timestamp should be put into CMSG, same ways as packet
>> > status is=2E The packet body should then always contain only the payl=
oad=2E
>>
>> Or, this maybe should instead use the SOF_TIMESTAMPING_RX_HARDWARE
>> mechanism, which would avoid adding a new API=2E
>
>Either that or we use BT_PKT_STATUS, does SOF_TIMESTAMPING_RX_HARDWARE
>requires the use of errqueue?

No, it just adds a CMSG, similar to the RX software tstamp=2E

>
>> > >
>> > > Signed-off-by: Yang Li <yang=2Eli@amlogic=2Ecom>
>> > > ---
>> > >  include/net/bluetooth/bluetooth=2Eh |  4 ++-
>> > >  net/bluetooth/iso=2Ec               | 58 +++++++++++++++++++++++++=
++++++++------
>> > >  2 files changed, 52 insertions(+), 10 deletions(-)
>> > >
>> > > diff --git a/include/net/bluetooth/bluetooth=2Eh b/include/net/blue=
tooth/bluetooth=2Eh
>> > > index bbefde319f95=2E=2Ea102bd76647c 100644
>> > > --- a/include/net/bluetooth/bluetooth=2Eh
>> > > +++ b/include/net/bluetooth/bluetooth=2Eh
>> > > @@ -242,6 +242,7 @@ struct bt_codecs {
>> > >  #define BT_CODEC_MSBC              0x05
>> > >
>> > >  #define BT_ISO_BASE                20
>> > > +#define BT_ISO_TS          21
>> > >
>> > >  __printf(1, 2)
>> > >  void bt_info(const char *fmt, =2E=2E=2E);
>> > > @@ -390,7 +391,8 @@ struct bt_sock {
>> > >  enum {
>> > >     BT_SK_DEFER_SETUP,
>> > >     BT_SK_SUSPEND,
>> > > -   BT_SK_PKT_STATUS
>> > > +   BT_SK_PKT_STATUS,
>> > > +   BT_SK_ISO_TS
>> > >  };
>> > >
>> > >  struct bt_sock_list {
>> > > diff --git a/net/bluetooth/iso=2Ec b/net/bluetooth/iso=2Ec
>> > > index 2f348f48e99d=2E=2E2c1fdea4b8c1 100644
>> > > --- a/net/bluetooth/iso=2Ec
>> > > +++ b/net/bluetooth/iso=2Ec
>> > > @@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socket=
 *sock, int level, int optname,
>> > >             iso_pi(sk)->base_len =3D optlen;
>> > >
>> > >             break;
>> > > +   case BT_ISO_TS:
>> > > +           if (optlen !=3D sizeof(opt)) {
>> > > +                   err =3D -EINVAL;
>> > > +                   break;
>> > > +           }
>> > >
>> > > +           err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optva=
l, optlen);
>> > > +           if (err)
>> > > +                   break;
>> > > +
>> > > +           if (opt)
>> > > +                   set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
>> > > +           else
>> > > +                   clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
>> > > +           break;
>> > >     default:
>> > >             err =3D -ENOPROTOOPT;
>> > >             break;
>> > > @@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socket=
 *sock, int level, int optname,
>> > >                     err =3D -EFAULT;
>> > >
>> > >             break;
>> > > +   case BT_ISO_TS:
>> > > +           if (len < sizeof(u32)) {
>> > > +                   err =3D -EINVAL;
>> > > +                   break;
>> > > +           }
>> > >
>> > > +           if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags),
>> > > +                       (u32 __user *)optval))
>> > > +                   err =3D -EFAULT;
>> > > +           break;
>> > >     default:
>> > >             err =3D -ENOPROTOOPT;
>> > >             break;
>> > > @@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_conn=
 *hcon, __u8 reason)
>> > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flag=
s)
>> > >  {
>> > >     struct iso_conn *conn =3D hcon->iso_data;
>> > > +   struct sock *sk;
>> > >     __u16 pb, ts, len;
>> > >
>> > >     if (!conn)
>> > >             goto drop;
>> > >
>> > > -   pb     =3D hci_iso_flags_pb(flags);
>> > > -   ts     =3D hci_iso_flags_ts(flags);
>> > > +   iso_conn_lock(conn);
>> > > +   sk =3D conn->sk;
>> > > +   iso_conn_unlock(conn);
>> > > +
>> > > +   if (!sk)
>> > > +           goto drop;
>> > > +
>> > > +   pb =3D hci_iso_flags_pb(flags);
>> > > +   ts =3D hci_iso_flags_ts(flags);
>> > >
>> > >     BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts=
);
>> > >
>> > > @@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struct=
 sk_buff *skb, u16 flags)
>> > >             if (ts) {
>> > >                     struct hci_iso_ts_data_hdr *hdr;
>> > >
>> > > -                   /* TODO: add timestamp to the packet? */
>> > > -                   hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_=
SIZE);
>> > > -                   if (!hdr) {
>> > > -                           BT_ERR("Frame is too short (len %d)", s=
kb->len);
>> > > -                           goto drop;
>> > > -                   }
>> > > +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) =
{
>> > > +                           hdr =3D (struct hci_iso_ts_data_hdr *)s=
kb->data;
>> > > +                           len =3D hdr->slen + HCI_ISO_TS_DATA_HDR=
_SIZE;
>> > > +                   } else {
>> > > +                           hdr =3D skb_pull_data(skb, HCI_ISO_TS_D=
ATA_HDR_SIZE);
>> > > +                           if (!hdr) {
>> > > +                                   BT_ERR("Frame is too short (len=
 %d)", skb->len);
>> > > +                                   goto drop;
>> > > +                           }
>> > >
>> > > -                   len =3D __le16_to_cpu(hdr->slen);
>> > > +                           len =3D __le16_to_cpu(hdr->slen);
>> > > +                   }
>> > >             } else {
>> > >                     struct hci_iso_data_hdr *hdr;
>> > >
>> > > +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) =
{
>> > > +                           BT_ERR("Invalid option BT_SK_ISO_TS");
>> > > +                           clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->fla=
gs);
>> > > +                   }
>> > > +
>> > >                     hdr =3D skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZ=
E);
>> > >                     if (!hdr) {
>> > >                             BT_ERR("Frame is too short (len %d)", s=
kb->len);
>> > >
>> > > ---
>> > > base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
>> > > change-id: 20250421-iso_ts-c82a300ae784
>> > >
>> > > Best regards,
>
>
>

