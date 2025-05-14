Return-Path: <netdev+bounces-190311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9ADAB62B1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4AB7AB882
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51291F4261;
	Wed, 14 May 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd7tczGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6571CEAC2;
	Wed, 14 May 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202491; cv=none; b=q2jmwjWGz0UdWYjah7nl/Gs8EUG+PPNUoU4TzlrfeX0aL/v4qi5SFdrfegoGKIykVmIjzg/O9ZbSR4AovajeGjNP9xbKpuivwq/Vak7rgN5laDTYXUXr6oyivb4scpOQbX3ma8Ey+4swnHngjFCqL1T7R/Ysc0Xq6cS+th5w/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202491; c=relaxed/simple;
	bh=LIAbg8il03sYhpZ4iTz6RphXN708dSIECrcMAcaZm4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lC/JoUcfzyc/pryV4jwMeEQF4UHWvWkBRLszqN8B5G9J2anzgjN6gTkr55iMgd7iYUzwgbI1EnYMNqTVOdXGa6gNhiMBamyh+TmHreK5QkGgHoB7zxH+RXz7PnqDxEJf3GfrOlYL3gGPaXVYsT0DWi2k6XiTgIhu1KIx4gGQ9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd7tczGd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad23c20f977so586427566b.2;
        Tue, 13 May 2025 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747202487; x=1747807287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WjtoFKyUD9QK5VeUwWZz1KDGWgH/6Z+bW/4WJg9RYQ=;
        b=Nd7tczGdgGY2emKQoGVKc5ISqvBujeyYyotbDmJdaCXarlGKA1vciA7GlA08bmVSzV
         Vk4zgOqiTScAVuV6aMxsJ3ggclxmA19PQRJILdxmw+FgA0LYO8jFv/HRJdd2YSh4luAp
         IDQ7DjiGsfnQJU3wDADCRfHrqrf/uaYyx1VCsbN45Jxv5SKAhIlcnw6S4SQlpZYATwqz
         jOM5MGcItewYv8ZYvKOuTKmFI5osBlfRRRImp/kYwzh9fUE+Fe4az+jBt5CQEqzJuabf
         0ycP4VW30IHQ7hLY6xWernAafxXi+0VQXToTmPrKweM4D5syfNbMgW6JgAfF/Um6r6fn
         BmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202487; x=1747807287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WjtoFKyUD9QK5VeUwWZz1KDGWgH/6Z+bW/4WJg9RYQ=;
        b=j458HuQm52Mwj0U1IV8M03Of7uozxh0qg3MmeUIxhQdq2NGigfvNoJrMu4o1GtUZ6l
         GaNg63D2ACSVcsd/NPLKngQZ7/z717NfU0OCKUAXMbk3hyaiK3+iqxJscKA25i/hRKoa
         LPYjiRv+WH3h0kKiylvwrTMe5serkLTcmxbWew9vQluD2FPpPujF4owHpK8vToV/+Pjb
         ky2WjD00a3lyrQEIqdGnw7D/58mrNEEtfwDS6cQTptcoKsKLIgHQ07pmQ9qY69n0tx1t
         A6/nLTf3RstokJgkMts/N+aflU1VYLXpF/GTbobvd894L2RKbKOqxt1A/TmOpLdDGFLD
         g68g==
X-Forwarded-Encrypted: i=1; AJvYcCVXIJ93oVmdVXHQ5fMz4/9HX4FT8uOkuIotWyTxlxuZYm0dyEiN8htuC4xaGMCbDdRSHDUhO4Sn@vger.kernel.org, AJvYcCWKp2hTwyXFmM0gLV9Db0eAe0Q4LWV9AaoXyc8tYmZGWOYXlGrAs4X6u2upA0ahAutBPnv2x7NAzcn7+64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOYtlJfgfi8hisAncvTP5js+aF6l2hJjh/BrvQB4HEmXw0Whu
	GKtK/faretfR4OPKc9hoJoiGh30fSe5cQpXHkXC5VsnH+DIe6yt/IahK+RPCAJGqTd2ZH4mb5yi
	5avDh1OsQd7ZsPyVICa3DUswzafw=
X-Gm-Gg: ASbGnctO38x4JNKRdKBkjz04YqeIQAGKNwdb5l5gyD9veWHDKaSCJFeoOjpPsbTBRcE
	mT7xjiY2LYniDJir/crPP8bT7TC+QB26FVABOJz8ZqBxpNxCK+NV9aJrtOCJYsxhfZ6PczHnZql
	vnuOmTRaYn9PYKdxGgCkYhz2z/DF6CrWk=
X-Google-Smtp-Source: AGHT+IEfz2bJXf6lQFPnSyf4yxbnWSwQgLNzrFF+PuO08yeodEUsWgBGZbs3fx925zJbGN0ZL7XwkuMFZQCsXf1Rae4=
X-Received: by 2002:a17:907:3d8c:b0:ad2:3e5e:336b with SMTP id
 a640c23a62f3a-ad4f71364d0mr189263966b.9.1747202486541; Tue, 13 May 2025
 23:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511154235.101780-1-maimon.sagi@gmail.com> <4ef4472b-62a5-43f6-bd16-d6e0ace2335a@linux.dev>
In-Reply-To: <4ef4472b-62a5-43f6-bd16-d6e0ace2335a@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 14 May 2025 09:01:00 +0300
X-Gm-Features: AX0GCFsZpoX5SnLzI92g1eXio4f0aX5DMuSPEL7oeCqR9QUy_A1oPLZOO0dTlZA
Message-ID: <CAMuE1bEQUH6WdJhS0rAcnnXe3Tn+xwzJZ4iQFND1jx1U1fu+rQ@mail.gmail.com>
Subject: Re: [PATCH v4] ptp: ocp: Limit signal/freq counts in show/store functions
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:53=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 11.05.2025 16:42, Sagi Maimon wrote:
> > The sysfs show/store operations could access uninitialized elements
> > in the freq_in[] and signal_out[] arrays, leading to NULL pointer
> > dereferences. This patch introduces u8 fields (nr_freq_in,
> > nr_signal_out) to track the number of initialized elements, capping
> > the maximum at 4 for each array. The show/store functions are updated
> > to respect these limits, preventing out-of-bounds access and ensuring
> > safe array handling.
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> > Addressed comments from Vadim Fedorenko:
> >   - https://www.spinics.net/lists/netdev/msg1090730.html
> > Changes since v3:
> >   - in signal/freq show routine put constant string "UNSUPPORTED" in
> >     output instead of returning error.
> > ---
> > ---
> >   drivers/ptp/ptp_ocp.c | 40 +++++++++++++++++++++++++++++++++-------
> >   1 file changed, 33 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index 2ccdca4f6960..14b4b3bebccd 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -315,6 +315,8 @@ struct ptp_ocp_serial_port {
> >   #define OCP_BOARD_ID_LEN            13
> >   #define OCP_SERIAL_LEN                      6
> >   #define OCP_SMA_NUM                 4
> > +#define OCP_SIGNAL_NUM                       4
> > +#define OCP_FREQ_NUM                 4
> >
> >   enum {
> >       PORT_GNSS,
> > @@ -342,8 +344,8 @@ struct ptp_ocp {
> >       struct dcf_master_reg   __iomem *dcf_out;
> >       struct dcf_slave_reg    __iomem *dcf_in;
> >       struct tod_reg          __iomem *nmea_out;
> > -     struct frequency_reg    __iomem *freq_in[4];
> > -     struct ptp_ocp_ext_src  *signal_out[4];
> > +     struct frequency_reg    __iomem *freq_in[OCP_FREQ_NUM];
> > +     struct ptp_ocp_ext_src  *signal_out[OCP_SIGNAL_NUM];
> >       struct ptp_ocp_ext_src  *pps;
> >       struct ptp_ocp_ext_src  *ts0;
> >       struct ptp_ocp_ext_src  *ts1;
> > @@ -378,10 +380,12 @@ struct ptp_ocp {
> >       u32                     utc_tai_offset;
> >       u32                     ts_window_adjust;
> >       u64                     fw_cap;
> > -     struct ptp_ocp_signal   signal[4];
> > +     struct ptp_ocp_signal   signal[OCP_SIGNAL_NUM];
> >       struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
> >       const struct ocp_sma_op *sma_op;
> >       struct dpll_device *dpll;
> > +     int signals_nr;
> > +     int freq_in_nr;
> >   };
> >
> >   #define OCP_REQ_TIMESTAMP   BIT(0)
> > @@ -2697,6 +2701,8 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct =
ocp_resource *r)
> >       bp->eeprom_map =3D fb_eeprom_map;
> >       bp->fw_version =3D ioread32(&bp->image->version);
> >       bp->sma_op =3D &ocp_fb_sma_op;
> > +     bp->signals_nr =3D 4;
> > +     bp->freq_in_nr =3D 4;
> >
> >       ptp_ocp_fb_set_version(bp);
> >
> > @@ -2862,6 +2868,8 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct=
 ocp_resource *r)
> >       bp->fw_version =3D ioread32(&bp->reg->version);
> >       bp->fw_tag =3D 2;
> >       bp->sma_op =3D &ocp_art_sma_op;
> > +     bp->signals_nr =3D 4;
> > +     bp->freq_in_nr =3D 4;
> >
> >       /* Enable MAC serial port during initialisation */
> >       iowrite32(1, &bp->board_config->mro50_serial_activate);
> > @@ -2888,6 +2896,8 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struc=
t ocp_resource *r)
> >       bp->flash_start =3D 0xA00000;
> >       bp->eeprom_map =3D fb_eeprom_map;
> >       bp->sma_op =3D &ocp_adva_sma_op;
> > +     bp->signals_nr =3D 2;
> > +     bp->freq_in_nr =3D 2;
> >
> >       version =3D ioread32(&bp->image->version);
> >       /* if lower 16 bits are empty, this is the fw loader. */
> > @@ -3190,6 +3200,9 @@ signal_store(struct device *dev, struct device_at=
tribute *attr,
> >       if (!argv)
> >               return -ENOMEM;
> >
> > +     if (gen >=3D bp->signals_nr)
> > +             return -EINVAL;
> > +
> >       err =3D -EINVAL;
> >       s.duty =3D bp->signal[gen].duty;
> >       s.phase =3D bp->signal[gen].phase;
> > @@ -3247,6 +3260,10 @@ signal_show(struct device *dev, struct device_at=
tribute *attr, char *buf)
> >       int i;
> >
> >       i =3D (uintptr_t)ea->var;
> > +
> > +     if (i >=3D bp->signals_nr)
> > +             return sysfs_emit(buf, "UNSUPPORTED\n");
> > +
> >       signal =3D &bp->signal[i];
>
> I've checked the code again. Jakub is right, there is no need to modify
> singal/seconds/frequency show/set functions. Now I'm not quite sure how i=
s it
> possible to reach this functions with unsupported input? You export a spe=
cific
> set of attributes for your card:
>
> static const struct ocp_attr_group adva_timecard_groups[] =3D {
>         { .cap =3D OCP_CAP_BASIC,     .group =3D &adva_timecard_group },
>         { .cap =3D OCP_CAP_BASIC,     .group =3D &ptp_ocp_timecard_tty_gr=
oup },
>         { .cap =3D OCP_CAP_SIGNAL,    .group =3D &fb_timecard_signal0_gro=
up },
>         { .cap =3D OCP_CAP_SIGNAL,    .group =3D &fb_timecard_signal1_gro=
up },
>         { .cap =3D OCP_CAP_FREQ,      .group =3D &fb_timecard_freq0_group=
 },
>         { .cap =3D OCP_CAP_FREQ,      .group =3D &fb_timecard_freq1_group=
 },
>         { },
> };
>
> It has only freq1, freq2, gen1, gen2 attributes exported to sysfs. How ca=
n it
> happen that you can change freq3 or gen3?
>
> The only problem I see is in the summary output - that should be addresse=
d with
> this patch (well, you've done it already).
>
you are right the problem can only happen in _signal_summary_show
_frequency_summary_show
> >
> >       count =3D sysfs_emit(buf, "%llu %d %llu %d", signal->period,
> > @@ -3359,6 +3376,9 @@ seconds_store(struct device *dev, struct device_a=
ttribute *attr,
> >       u32 val;
> >       int err;
> >
> > +     if (idx >=3D bp->freq_in_nr)
> > +             return -EINVAL;
> > +
> >       err =3D kstrtou32(buf, 0, &val);
> >       if (err)
> >               return err;
> > @@ -3381,6 +3401,9 @@ seconds_show(struct device *dev, struct device_at=
tribute *attr, char *buf)
> >       int idx =3D (uintptr_t)ea->var;
> >       u32 val;
> >
> > +     if (idx >=3D bp->freq_in_nr)
> > +             return sysfs_emit(buf, "UNSUPPORTED\n");
> > +
> >       val =3D ioread32(&bp->freq_in[idx]->ctrl);
> >       if (val & 1)
> >               val =3D (val >> 8) & 0xff;
> > @@ -3402,6 +3425,9 @@ frequency_show(struct device *dev, struct device_=
attribute *attr, char *buf)
> >       int idx =3D (uintptr_t)ea->var;
> >       u32 val;
> >
> > +     if (idx >=3D bp->freq_in_nr)
> > +             return -EINVAL;
> > +
> >       val =3D ioread32(&bp->freq_in[idx]->status);
> >       if (val & FREQ_STATUS_ERROR)
> >               return sysfs_emit(buf, "error\n");
> > @@ -4008,7 +4034,7 @@ _signal_summary_show(struct seq_file *s, struct p=
tp_ocp *bp, int nr)
> >   {
> >       struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
> >       struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> > -     char label[8];
> > +     char label[16];
> >       bool on;
> >       u32 val;
> >
> > @@ -4031,7 +4057,7 @@ static void
> >   _frequency_summary_show(struct seq_file *s, int nr,
> >                       struct frequency_reg __iomem *reg)
> >   {
> > -     char label[8];
> > +     char label[16];
> >       bool on;
> >       u32 val;
> >
> > @@ -4175,11 +4201,11 @@ ptp_ocp_summary_show(struct seq_file *s, void *=
data)
> >       }
> >
> >       if (bp->fw_cap & OCP_CAP_SIGNAL)
> > -             for (i =3D 0; i < 4; i++)
> > +             for (i =3D 0; i < bp->signals_nr; i++)
> >                       _signal_summary_show(s, bp, i);
> >
> >       if (bp->fw_cap & OCP_CAP_FREQ)
> > -             for (i =3D 0; i < 4; i++)
> > +             for (i =3D 0; i < bp->freq_in_nr; i++)
> >                       _frequency_summary_show(s, i, bp->freq_in[i]);
> >
> >       if (bp->irig_out) {
>
> ---
> pw-bot:cr

