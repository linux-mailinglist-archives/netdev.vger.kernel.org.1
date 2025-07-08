Return-Path: <netdev+bounces-205047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5FAFCF7F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A84F7A8BEA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B12E1C4E;
	Tue,  8 Jul 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dCqk1r7f"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4B2E36E2;
	Tue,  8 Jul 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989265; cv=pass; b=UukvZYroySYYfnf3RyX3FBCHDaAervnLFlS+3+JRgfWBVx4A6Y1Ad3pzrm/az9Z66++F3Zgm3j6yys3wraXDVk41IGnH25lmKQXkpYTd+iYwapTzjipNMzBbe5ybdwN25s7c0QISYstJvRcdkgJi3tzBjovMPP7oQcvQTXjU02A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989265; c=relaxed/simple;
	bh=J3epfexzx6lyet5FPTwIn1Ue7WclKV1N9J8ER2k0uSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2JMB7AGMUIYL9tNnL/CuClSxxg+RSYFfthKoyVnmXB/yjMpOVzvDjpo85V+cull9+EFjmOsLuF8H5Zj88fqy4yUP5WZyDEhL0piMlGIvsUAEX457CIzQdkXGPrFFpO6vg6GB3hV0OVFYFczj2tLkA20mOmISaZk+Q2ylCoocww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dCqk1r7f; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bc50t0rm0z49PwW;
	Tue,  8 Jul 2025 18:40:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1751989248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RcKP6Lz3/0XF15YRsRTE2y+bqfAAH0YGtQUqApJQBF8=;
	b=dCqk1r7fJv5ZQGUCAnklzxwZ/lzRAKuQ/5iATD6CToFGgqGVKUOxnxMB6jXI+hmZYNxfnb
	8so1xLOjZGv3ec7K3+ZmE6iV+XP8y/fPsGit0HdC4Ud9US5wm7/srtLpyoVgfh8h/3xitd
	YKzCEZeSNQ5RpT4+xvXBykLvzzmnFEs1ZE7Kx2iL6eLmg9aDQR9/i20jRieOGVi8sboXHz
	nsoxPeRJ08kfLGGnNwLGAHG2O/DCN8SibGvdDcOExdAH8F2Ddd9wF2mFPbXdYX3fHcmKCn
	0hEnwU0EMLU/spBWXI7eKuZPK4Wx8nnEkAr7Xacsd3W3Id5tBLKBJWeQvBme/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1751989248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RcKP6Lz3/0XF15YRsRTE2y+bqfAAH0YGtQUqApJQBF8=;
	b=uXjsrxMDQLDRr/HccMkVrJP/bkArZwCthWJIsbrZI9QXWmpicx0IWmtNGNmCo+vSXEFthw
	KcB5xMbAJsUAaJkAsJ8sds5/W5jSehWgmohikbz5lgjPQ9MyfcQ186iMjOcvS0wy7Hf0Kv
	nq/YQnYeW3XReI4g4i/zOVTgoL5WxJJNv81fhLQKZgw7h6iD4UCXcmco1otic3W1t5Biv6
	m9VdnOm94SyrLIIT6fOkdgE5pTn+2aElPeTSxDmGmzA4YUc3L9LyNekzlT06UgrPMGNxS3
	/263c0n9T3TDDj0uSqfLWZFt5dbg9N55EC2/2D0tbbxxdfKQPfEp52t67qYj6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1751989248; a=rsa-sha256;
	cv=none;
	b=BS88rs1JfJqv9u6/jt2O3jSeHuoey8TpG1vF2eb8QxQJsrkKhaDvLXYxyqnKc7BsCr1MpF
	kchaQOHzuk91aqlfsqv1czm80kCXK5u9uDc2oceRq5sPFPN/TPh8NeBeLjywGhrK5ak34+
	J2B0VH1fDu44ATv69xXuMQqi9m/W27Ipd9jC4Qhn46ckNgOEl/R4tWhrlxzBeUG52g2lGU
	vt0vNhFX33VglQNkev7irRTP7bqpbIWInA3MbGI4pZPci1Li5elPSetOu4zR6hNLfivrkw
	gxN9XJmrWBCpuHrSCUUcmOzYaJwTIPlLtESGetzUpxlcEpBWZt43P3kQEP+zmA==
Message-ID: <786703eec0ff7160b2991c393f766b7584fb8433.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
From: Pauli Virtanen <pav@iki.fi>
To: Yang Li <yang.li@amlogic.com>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 18:40:44 +0300
In-Reply-To: <8f4f0d1d-aff1-42e3-9ab0-a5eb6ca1523c@amlogic.com>
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
	 <bebb44579ed8379a0d69a2f2793a70471b08ea91.camel@iki.fi>
	 <df9f6977-0d63-41b3-8d9b-c3a293ed78ec@amlogic.com>
	 <3586e2f53a1a4c0772515846cf5ec91044e2cfec.camel@iki.fi>
	 <8f4f0d1d-aff1-42e3-9ab0-a5eb6ca1523c@amlogic.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-07-07 kello 16:18 +0800, Yang Li kirjoitti:
> Hi Pauli,
> > [ EXTERNAL EMAIL ]
> >=20
> > Hi,
> >=20
> > ma, 2025-07-07 kello 09:48 +0800, Yang Li kirjoitti:
> > > Hi,
> > > > [ EXTERNAL EMAIL ]
> > > >=20
> > > > Hi,
> > > >=20
> > > > pe, 2025-07-04 kello 13:36 +0800, Yang Li via B4 Relay kirjoitti:
> > > > > From: Yang Li <yang.li@amlogic.com>
> > > > >=20
> > > > > User-space applications (e.g., PipeWire) depend on
> > > > > ISO-formatted timestamps for precise audio sync.
> > > > >=20
> > > > > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > > > > ---
> > > > > Changes in v3:
> > > > > - Change to use hwtimestamp
> > > > > - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d=
199c8068@amlogic.com
> > > > >=20
> > > > > Changes in v2:
> > > > > - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> > > > > - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586=
f30de6cb@amlogic.com
> > > > > ---
> > > > >    net/bluetooth/iso.c | 10 +++++++++-
> > > > >    1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > > > index fc22782cbeeb..67ff355167d8 100644
> > > > > --- a/net/bluetooth/iso.c
> > > > > +++ b/net/bluetooth/iso.c
> > > > > @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, stru=
ct sk_buff *skb, u16 flags)
> > > > >                 if (ts) {
> > > > >                         struct hci_iso_ts_data_hdr *hdr;
> > > > >=20
> > > > > -                     /* TODO: add timestamp to the packet? */
> > > > >                         hdr =3D skb_pull_data(skb, HCI_ISO_TS_DAT=
A_HDR_SIZE);
> > > > >                         if (!hdr) {
> > > > >                                 BT_ERR("Frame is too short (len %=
d)", skb->len);
> > > > >                                 goto drop;
> > > > >                         }
> > > > >=20
> > > > > +                     /* The ISO ts is based on the controller=E2=
=80=99s clock domain,
> > > > > +                      * so hardware timestamping (hwtimestamp) m=
ust be used.
> > > > > +                      * Ref: Documentation/networking/timestampi=
ng.rst,
> > > > > +                      * chapter 3.1 Hardware Timestamping.
> > > > > +                      */
> > > > > +                     struct skb_shared_hwtstamps *hwts =3D skb_h=
wtstamps(skb);
> > > > > +                     if (hwts)
> > > > In addition to the moving variable on top, the null check is spurio=
us
> > > > as skb_hwtstamps is never NULL (driver/net/* do not check it either=
).
> > > >=20
> > > > Did you test this with SOF_TIMESTAMPING_RX_HARDWARE in userspace?
> > > > Pipewire does not try to get HW timestamps right now.
> > > >=20
> > > > Would be good to also add some tests in bluez/tools/iso-tester.c
> > > > although this needs some extension to the emulator/* to support
> > > > timestamps properly.
> > >=20
> > > Yes, here is the patch and log based on testing with Pipewire:
> > >=20
> > > diff --git a/spa/plugins/bluez5/media-source.c
> > > b/spa/plugins/bluez5/media-source.c
> > > index 2fe08b8..10e9378 100644
> > > --- a/spa/plugins/bluez5/media-source.c
> > > +++ b/spa/plugins/bluez5/media-source.c
> > > @@ -407,7 +413,7 @@ static int32_t read_data(struct impl *this) {
> > >           struct msghdr msg =3D {0};
> > >           struct iovec iov;
> > >           char control[128];
> > > -       struct timespec *ts =3D NULL;
> > > +       struct scm_timestamping *ts =3D NULL;
> > >=20
> > >           iov.iov_base =3D this->buffer_read;
> > >           iov.iov_len =3D b_size;
> > > @@ -439,12 +445,14 @@ again:
> > >           struct cmsghdr *cmsg;
> > >           for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg !=3D NULL; cmsg =3D
> > > CMSG_NXTHDR(&msg, cmsg)) {
> > >    #ifdef SCM_TIMESTAMPING
> > >                   /* Check for timestamp */
> > > +               if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_=
type =3D=3D
> > > SCM_TIMESTAMPING) {
> > > +                       ts =3D (struct scm_timestamping *)CMSG_DATA(c=
msg);
> > > +                       spa_log_error(this->log, "%p: received timest=
amp
> > > %ld.%09ld",
> > > +                                       this, ts->ts[2].tv_sec,
> > > ts->ts[2].tv_nsec);
> > >                           break;
> > >                   }
> > >    #endif
> > >=20
> > >    @@ -726,9 +734,9 @@ static int transport_start(struct impl *this)
> > >           if (setsockopt(this->fd, SOL_SOCKET, SO_PRIORITY, &val,
> > > sizeof(val)) < 0)
> > >                   spa_log_warn(this->log, "SO_PRIORITY failed: %m");
> > >=20
> > > +       val =3D SOF_TIMESTAMPING_RX_HARDWARE | SOF_TIMESTAMPING_RAW_H=
ARDWARE;
> > > +       if (setsockopt(this->fd, SOL_SOCKET, SO_TIMESTAMPING, &val,
> > > sizeof(val)) < 0) {
> > > +               spa_log_warn(this->log, "SO_TIMESTAMPING failed: %m")=
;
> > >                   /* don't fail if timestamping is not supported */
> > >           }
> > >=20
> > > trace log=EF=BC=9A
> > >=20
> > > read_data: 0x1e78d68: received timestamp 7681.972000000
> > > read_data: 0x1e95000: received timestamp 7681.972000000
> > > read_data: 0x1e78d68: received timestamp 7691.972000000
> > > read_data: 0x1e95000: received timestamp 7691.972000000
> > The counter increases by 10 *seconds* on each step. Is there some
> > scaling problem here, or is the hardware producing bogus values?
> >=20
> > Isn't it supposed to increase by ISO interval (10 *milliseconds*)?
>=20
>=20
> Yes, you are right. The interval should be the ISO interval (10=E2=80=AFm=
s).
> The 10=E2=80=AFs interval in the log happened because the kernel version =
I=20
> tested (6.6) doesn=E2=80=99t have us_to_ktime(), so I wrote a custom vers=
ion,=20
> but the conversion factor was wrong.

Ok, then there's no problem.

Regarding the tests, it's probably fairly straightforward to add. Only
thing that would need doing is to add new testcase similar to ""ISO
Receive - RX Timestamping"" in bluez/tools/iso-tester.c with HW
timestamping enabled, and edit bluez/tools/tester.h:rx_timestamp_check
to also check HW timestamps if enabled.

> kernel patch as below:
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 070de5588c74..de05587393fa 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2251,6 +2251,10 @@ static void iso_disconn_cfm(struct hci_conn=20
> *hcon, __u8 reason)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iso_conn_del(hcon, bt_to_errn=
o(reason));
>  =C2=A0}
> +static=C2=A0 ktime_t us_to_ktime(u64 us)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return us * 1000000L;
> +}
>=20
>  =C2=A0void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flag=
s)
>  =C2=A0{
> @@ -2285,6 +2289,11 @@ void iso_recv(struct hci_conn *hcon, struct=20
> sk_buff *skb, u16 flags)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto drop;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Record the =
timestamp to skb*/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct skb_sha=
red_hwtstamps *hwts =3D=20
> skb_hwtstamps(skb);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwts)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwts->hwtstamp =3D=20
> us_to_ktime(le32_to_cpu(hdr->ts));
> +
>=20
> >=20
> > > read_data: 0x1e78d68: received timestamp 7701.972000000
> > > read_data: 0x1e95000: received timestamp 7701.972000000
> > > read_data: 0x1e78d68: received timestamp 7711.972000000
> > > read_data: 0x1e95000: received timestamp 7711.972000000
> > > read_data: 0x1e78d68: received timestamp 7721.972000000
> > > read_data: 0x1e95000: received timestamp 7721.972000000
> > > read_data: 0x1e78d68: received timestamp 7731.972000000
> > >=20
> > > > > +                             hwts->hwtstamp =3D us_to_ktime(le32=
_to_cpu(hdr->ts));
> > > > > +
> > > > >                         len =3D __le16_to_cpu(hdr->slen);
> > > > >                 } else {
> > > > >                         struct hci_iso_data_hdr *hdr;
> > > > >=20
> > > > > ---
> > > > > base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> > > > > change-id: 20250421-iso_ts-c82a300ae784
> > > > >=20
> > > > > Best regards,
> > > > --
> > > > Pauli Virtanen
> > --
> > Pauli Virtanen

--=20
Pauli Virtanen

