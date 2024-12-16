Return-Path: <netdev+bounces-152269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B69F3517
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B850160408
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AED1494B2;
	Mon, 16 Dec 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvALylan"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17B84A5E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364650; cv=none; b=EbOahkmpIBXYJpFNOrft4XgQ2crndmEGYODIFHA0HEqzg/4u1YhrrgXCDFhqDqsVSp1+HItJ+VQdfXv7TuUFMKCNKDA2wsc4lWVRO/KR2T3vfdIDo0xjJm/3H/I6GD8Hm+WLzDOILBIhHfVPSa9CwfflnlIahDRdf7+jPq3DMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364650; c=relaxed/simple;
	bh=UjIkmOrao2jQFOpSKHwhhQN7g0iIdI104D8hu9U+ack=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4oHusC2+N3dReHJ0+fIaF/srkunt/rQTO4nxCWWnbKKNOqhlLTull8242LPMz26tOcMzbMBIE2MezXSLCgFY8EhmyzhC8OuGCmHprVTfgrVrP+Xm/T38KoHswWgguFHofC25wodc/cCivp9Ky522W45DPzDeqP/pxJe9pc1cTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvALylan; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734364647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GggK6Hg5aofy/l6GPtSv4OcqBaHliS9ouBKASQPpya4=;
	b=QvALylanPOtkB8s42GJ7BqLt4/0oH4f+htD+bj2kEnPSfVDPlkZ1t0wcutDVFdyQAd7ewm
	A92B6KgETMSYMUYos4KWIY8p2IOXHrqCwWo0HCmzTPBYHeEdanc7GZ9aWTztV//yGFgz84
	C6OSxW3hwAD73YpKXgvxqvGxdcUF72s=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-EeAcIPCgMd6uNRBKsM6Y2A-1; Mon, 16 Dec 2024 10:57:26 -0500
X-MC-Unique: EeAcIPCgMd6uNRBKsM6Y2A-1
X-Mimecast-MFC-AGG-ID: EeAcIPCgMd6uNRBKsM6Y2A
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3eb59b84349so304282b6e.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364645; x=1734969445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GggK6Hg5aofy/l6GPtSv4OcqBaHliS9ouBKASQPpya4=;
        b=gGe1PbR2l7FYcopa2Qq4pQyi2LRs8/Q0pGfHCudfdu3m2wm3lKDW2nrHRJ6pa4q522
         93YXZImoWgclfbqf5YNpllTcV5ZntubbnRuje0Bcwd59Xh5JpYrpdHhqooAs+31bfgd7
         Ndxko2KTlfKXgnCnwYG/Md9QrTXmpDoq/7HK8sTsyzx2UcOU+UoM5nQMWYl0tJPoJPBv
         i1LmeexjvfzRM5KZ7SdW5wksRICypkdyAYphzARHx/KJzgQdL1Eg9NQVKvGOhZVNJCkB
         dB+wX2grUtCbLRNhXgT30ZH4wAyUBdu9LjjM5ozNEADOoTDBjKJYg9Ddopl3jQL1J5Zb
         1A9A==
X-Gm-Message-State: AOJu0YywxI+wztiuIXr1JKCqI6TdelQJKiLyjWG2uwvgBGeaMP9fhze6
	pMtrQ5qB9OwmdLv0T7M08a8JfC6nxHQ/XSjV+5ITMjAmLdTUmpUcRxMFHNF6CN5BAJWMsQpubZY
	qSUNpJnDH45lKtGGHYEwztXcg8A50ann0DnqY4QyITOIJVhZk1j35CRUPGZu+hv7VXG0vYz0WF3
	oNqwCC6ohP93xg9ryltJvZPCsvuJE4
X-Gm-Gg: ASbGncuPBFk4nK1mkfPXOGN3X/NQRFIJztjTTR1ubXBDDvpYjM0IdrX7Eu7lxK+XMnc
	cP5kLjHGcHDdXwvrolBEaUj58PYU1eBbipGURLw==
X-Received: by 2002:a05:6870:a44a:b0:29e:79ce:933a with SMTP id 586e51a60fabf-2a3ac926e06mr2858375fac.12.1734364645395;
        Mon, 16 Dec 2024 07:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK1g/uqWSnnXcpZH9OFchKgNHws71LzECyhL9q8HUo0ekk6UxMypcTN7DdAw7xktTJzNxWHoKvpzSQOAMeTAY=
X-Received: by 2002:a05:6870:a44a:b0:29e:79ce:933a with SMTP id
 586e51a60fabf-2a3ac926e06mr2858370fac.12.1734364645104; Mon, 16 Dec 2024
 07:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212153417.165919-1-mschmidt@redhat.com> <20241212153417.165919-3-mschmidt@redhat.com>
 <40d030d5-8d30-41b7-ae86-8baae6f594c5@intel.com>
In-Reply-To: <40d030d5-8d30-41b7-ae86-8baae6f594c5@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 16 Dec 2024 16:57:13 +0100
Message-ID: <CADEbmW10cLEeSm5qZDSXFVOkzM3k1-iHZTX62T3jAV7BV6A8uw@mail.gmail.com>
Subject: Re: [PATCH iwl-next 2/3] ice: lower the latency of GNSS reads
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:39=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> On 12/12/24 16:34, Michal Schmidt wrote:
> > The E810 is connected to the u-blox GNSS module over I2C. The ice drive=
r
> > periodically (every ~20ms) sends AdminQ commands to poll the u-blox for
> > available data. Most of the time, there's no data. When the u-blox
> > finally responds that data is available, usually it's around 800 bytes.
> > It can be more or less, depending on how many NMEA messages were
> > configured using ubxtool. ice then proceeds to read all the data.
> > AdminQ and I2C are slow. The reading is performed in chunks of 15 bytes=
.
> > ice reads all of the data before passing it to the kernel GNSS subsyste=
m
> > and onwards to userspace.
> >
> > Improve the NMEA message receiving latency. Pass each 15-bytes chunk to
> > userspace as soon as it's received.
> >
>
> Thank you, overall it makes a good addition!
> Please find some review feedback below.
>
> > Tested-by: Miroslav Lichvar <mlichvar@redhat.com>
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_gnss.c | 29 +++++++---------------=
-
> >   drivers/net/ethernet/intel/ice/ice_gnss.h |  6 ++++-
> >   2 files changed, 14 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/et=
hernet/intel/ice/ice_gnss.c
> > index 9b1f970f4825..7922311d2545 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > @@ -88,10 +88,10 @@ static void ice_gnss_read(struct kthread_work *work=
)
> >       unsigned long delay =3D ICE_GNSS_POLL_DATA_DELAY_TIME;
> >       unsigned int i, bytes_read, data_len, count;
> >       struct ice_aqc_link_topo_addr link_topo;
> > +     char buf[ICE_MAX_I2C_DATA_SIZE];
> >       struct ice_pf *pf;
> >       struct ice_hw *hw;
> >       __be16 data_len_b;
> > -     char *buf =3D NULL;
> >       u8 i2c_params;
> >       int err =3D 0;
> >
> > @@ -121,16 +121,6 @@ static void ice_gnss_read(struct kthread_work *wor=
k)
> >               goto requeue;
> >
> >       /* The u-blox has data_len bytes for us to read */
> > -
> > -     data_len =3D min_t(typeof(data_len), data_len, PAGE_SIZE);
>
> prior to your patch, the buffer is too small when there is more than
> PAGE_SIZE bytes to read, that warrants sending it as -net
> There is not that much code here, and with your description it is easy
> to follow, and the change is really "atomic" (send out each time instead
> of just once at the end), no refactors, so feels nice for -net IMO.

OK, the next version will target -net.

> > -
> > -     buf =3D (char *)get_zeroed_page(GFP_KERNEL);
> > -     if (!buf) {
> > -             err =3D -ENOMEM;
> > -             goto requeue;
> > -     }
> > -
> > -     /* Read received data */
> >       for (i =3D 0; i < data_len; i +=3D bytes_read) {
> >               unsigned int bytes_left =3D data_len - i;
> >
> > @@ -139,19 +129,18 @@ static void ice_gnss_read(struct kthread_work *wo=
rk)
> >
> >               err =3D ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_B=
US_ADDR,
> >                                     cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA=
),
> > -                                   bytes_read, &buf[i], NULL);
> > +                                   bytes_read, buf, NULL);
> >               if (err)
> > -                     goto free_buf;
> > +                     goto requeue;
> > +
> > +             count =3D gnss_insert_raw(pf->gnss_dev, buf, bytes_read);
> > +             if (count !=3D bytes_read)
>
> Before there was nothing to do on this condition, but now it's in the
> loop, so I would expect to either break or retry or otherwise recover
> here. Just going with the next step of the loop when you have lost some
> bytes feels wrong.

Userspace should handle corrupt NMEA (or UBX) messages anyway. And in
the driver we don't interpret the protocol, so we don't know where the
next valid message starts. I don't see what else we can do.

> Not sure how much about that case is theoretical,
> perhaps API could be fixed instead.

It might be a good idea to change the gnss subsystem API to allow
overwriting old buffered data, rather than reject new data.
[+CC:Johan].

> > +                     dev_dbg(ice_pf_to_dev(pf),
>
> in case of v2, I would squash the first commit here, an "additional
> paragraph" would be enough

OK, I will squash the two patches.

> > +                             "gnss_insert_raw ret=3D%d size=3D%d\n",
> > +                             count, bytes_read);
> >       }
> >
> > -     count =3D gnss_insert_raw(pf->gnss_dev, buf, i);
> > -     if (count !=3D i)
> > -             dev_dbg(ice_pf_to_dev(pf),
> > -                     "gnss_insert_raw ret=3D%d size=3D%d\n",
> > -                     count, i);
> >       delay =3D ICE_GNSS_TIMER_DELAY_TIME;
> > -free_buf:
> > -     free_page((unsigned long)buf);
> >   requeue:
> >       kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay=
);
> >       if (err)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/et=
hernet/intel/ice/ice_gnss.h
> > index 15daf603ed7b..e0e939f1b102 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_gnss.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
> > @@ -8,7 +8,11 @@
> >   #define ICE_GNSS_POLL_DATA_DELAY_TIME       (HZ / 50) /* poll every 2=
0 ms */
> >   #define ICE_GNSS_TIMER_DELAY_TIME   (HZ / 10) /* 0.1 second per messa=
ge */
> >   #define ICE_GNSS_TTY_WRITE_BUF              250
> > -#define ICE_MAX_I2C_DATA_SIZE                FIELD_MAX(ICE_AQC_I2C_DAT=
A_SIZE_M)
> > +/* ICE_MAX_I2C_DATA_SIZE is FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M).
> > + * However, FIELD_MAX() does not evaluate to an integer constant expre=
ssion,
> > + * so it can't be used for the size of a non-VLA array.
> > + */
> > +#define ICE_MAX_I2C_DATA_SIZE                15
>
> static_assert() is better than doc to say that two values are the same

Unfortunately, you can't use FIELD_MAX() in a static_assert(), for the
same reason you can't use it for sizing an array. You'll get either
"error: expression in static assertion is not constant", or "error:
braced-group within expression allowed only inside a function",
depending on where you put the static_assert().

I tried improving this some time ago:
https://lore.kernel.org/lkml/20240515172732.288391-1-mschmidt@redhat.com/T/=
#u
... but it required some more work.

Michal

> >   #define ICE_MAX_I2C_WRITE_BYTES             4
> >
> >   /* u-blox ZED-F9T specific definitions */
>


