Return-Path: <netdev+bounces-82308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D488D2AA
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 00:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC871F3CA34
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88813DDC4;
	Tue, 26 Mar 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="E8saQY8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD31013DDAD
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494797; cv=none; b=q23RwUaqFfDt/5c3Nxf/E9P6q5icHUE64DfbLoi2NwjNSnTvWk/4D2GF0JtZQlAbi+Ku6mp3fzxb9vhhw3CS2jgx7zS1dsygo836MOiB4Vi96mOAeyJbLsJgIw9YUR2RdZo4YgodJJU8bElAa0BHS5huwcp5X+HCdH41qSSdcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494797; c=relaxed/simple;
	bh=YCkB0V36Qla/lM8wCEj7/8F0UwlEvr6g+n1hiSiqIGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4m/zgrjJmVSWiAf2T9kYfuYZvC/FbQtVc39axEp8ACJpC9Sj3PL6838o35L9v8pUq/ZQj+y5IrLNBjGGjHE+duDaSbXt5lYQsfQLie9y6uJlf+rP0d8FhHsGCB/yIbFqIuXlBkiVDz/7cGGDDi6ztotPCnltOrrILJxznFM13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=E8saQY8O; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a104601dcso68435837b3.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711494795; x=1712099595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVOAe9ks9X+3V9OFdLT1/W/9Kwon69tRinsdN6sujc=;
        b=E8saQY8OM7iU/vXiIu8Fl6mf2l3OHcZWd70Nf28Oz0XR4tzAJkS4b+ecITan1JbOaj
         dkmyTcj7t6msTVpqytEeSS+HGA6s7dDH+Bgt44yVwOefaxhWOIBc80ARCFwq6+ea0Mor
         N80MuktLH4Rl3CgXAmpq5VImVs6D1f02tW9Ybk31wa+6MLKgZd00Y1D5wHbepfPT0jss
         i2/epeT2dXP8qQs3kJqN2osRuDRvAL+CrfxltsadAZ0qjQfgkDLrdK+qAmdcUv45QLCU
         bxPX7m1w1LAVu1yzimKcS8COzc7Um5wooiMzgF7VO1yJcDt9LHWy0E3zCF720f32aKLe
         MumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494795; x=1712099595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVOAe9ks9X+3V9OFdLT1/W/9Kwon69tRinsdN6sujc=;
        b=lW4uHi3/ySYSqYbFtXHQIseBl0M+j73/LNLQ/ZpL7WAoyPb/q/UT0O//rwJX8r/IH4
         FgnLqFL5vO9nckhfVlsR+s+v83KYwYTBfZmBeHWO5VjtuUH8Llyr2CkuxaQ1gsjKMxbl
         E0XMssy+qP1vtIeAJjOwGyJ1kZSaOR+JtLdWkxZRfCpifVkjaEmt5Msm8h7a0kFbX1jS
         tpBqYPvckTx2EOAmk7IZNZSEN39C+kep/nUxJIGFYzit6QewPfq/xbon8dHlcHeaAZOs
         lsXh/SvOrfKd/EKA+ciNp7xiXT5uNGAwe+qAOPR66gQrVl29Ljs7lTAmJHXvs1pEi60H
         gJJQ==
X-Gm-Message-State: AOJu0Yze4D+W5WsUo+RudWeU07NjS//hb2PD2C3u/a6FTOPksy6YNUuE
	NgBQqdBUHFC2jS4UZi8ebmdc/yqvn878SRQChAl1F85oecFIXzh0mOfdgcS0hiirjLqii2lX605
	fFV4JlgKg/uwTs51nOxfpfLaWKbQvBK8flQIs
X-Google-Smtp-Source: AGHT+IF0CFP7hw7yVitDsxee5TZt9donWj33FQQvvhUabNwuyCkBRFVxVkynHXUU9GFMlUZBGipjC3tiBYFdXdInQLY=
X-Received: by 2002:a0d:f006:0:b0:611:242e:4116 with SMTP id
 z6-20020a0df006000000b00611242e4116mr4133343ywe.34.1711494794847; Tue, 26 Mar
 2024 16:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325142834.157411-1-jhs@mojatatu.com> <20240325142834.157411-7-jhs@mojatatu.com>
 <ea2ad0773c91709094764474bf46825c146d741b.camel@redhat.com>
In-Reply-To: <ea2ad0773c91709094764474bf46825c146d741b.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 Mar 2024 19:13:03 -0400
Message-ID: <CAM0EoMkaa_u+Dd3OTyQDj=7W6KBSyFGf1emHp9VgCOdRRANpUw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 06/15] p4tc: add P4 data types
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:48=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Mon, 2024-03-25 at 10:28 -0400, Jamal Hadi Salim wrote:
> > +static int p4t_s32_validate(struct p4tc_type *container, void *value,
> > +                         u16 bitstart, u16 bitend,
> > +                         struct netlink_ext_ack *extack)
> > +{
> > +     s32 minsz =3D S32_MIN, maxsz =3D S32_MAX;
> > +     s32 *val =3D value;
> > +
> > +     if (val && (*val > maxsz || *val < minsz)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "S32 value out of range");
>
> I'm sorry for the additional questions/points below which could/should
> have been flagged earlier.
>
> Out of sheer ignorance IDK if a single P4 command could use multiple
> types, possibly use NL_SET_ERR_MSG_FMT_MOD() and specify the bogus
> value/range.
>

yes, that would be a more useful message. Will change.

> The same point/question has a few other instances below.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
>
> [...]
>
> > +static int p4t_be32_validate(struct p4tc_type *container, void *value,
> > +                          u16 bitstart, u16 bitend,
> > +                          struct netlink_ext_ack *extack)
> > +{
> > +     size_t container_maxsz =3D U32_MAX;
> > +     __be32 *val_u32 =3D value;
> > +     __u32 val =3D 0;
> > +     size_t maxval;
> > +     int ret;
> > +
> > +     ret =3D p4t_validate_bitpos(bitstart, bitend, 31, 31, extack);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (value)
> > +             val =3D be32_to_cpu(*val_u32);
> > +
> > +     maxval =3D GENMASK(bitend, 0);
> > +     if (val && (val > container_maxsz || val > maxval)) {
>
> The first condition 'val > container_maxsz' is a bit confusing
> (unneeded), as 'val' type is u32 and 'container_maxsz' is U32_MAX
>

Good point..

> > +             NL_SET_ERR_MSG_MOD(extack, "BE32 value out of range");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
>
> [...]
>
> > +static int p4t_u16_validate(struct p4tc_type *container, void *value,
> > +                         u16 bitstart, u16 bitend,
> > +                         struct netlink_ext_ack *extack)
> > +{
> > +     u16 container_maxsz =3D U16_MAX;
> > +     u16 *val =3D value;
> > +     u16 maxval;
> > +     int ret;
> > +
> > +     ret =3D p4t_validate_bitpos(bitstart, bitend, 15, 15, extack);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     maxval =3D GENMASK(bitend, 0);
> > +     if (val && (*val > container_maxsz || *val > maxval)) {
>
> Mutatis mutandis, same thing here
>

noted ;->

> > +             NL_SET_ERR_MSG_MOD(extack, "U16 value out of range");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct p4tc_type_mask_shift *
> > +p4t_u16_bitops(u16 bitsiz, u16 bitstart, u16 bitend,
> > +            struct netlink_ext_ack *extack)
> > +{
> > +     struct p4tc_type_mask_shift *mask_shift;
> > +     u16 mask =3D GENMASK(bitend, bitstart);
> > +     u16 *cmask;
> > +
> > +     mask_shift =3D kzalloc(sizeof(*mask_shift), GFP_KERNEL);
>
> (Not specifically related to _this_ allocation) I'm wondering if the
> allocations in this file should GFP_KERNEL_ACCOUNT? If I read correctly
> the user-space can (and is expected to) create an quite large number of
> instances of this structs (???)
>

I think changing to GFP_KERNEL_ACCOUNT would be useful regardless
especially because we are namespace aware.. Yes, there could be
millions of table entries in some cases.

> [...]
> > +void __p4tc_type_host_write(const struct p4tc_type_ops *ops,
> > +                         struct p4tc_type *container,
> > +                         struct p4tc_type_mask_shift *mask_shift, void=
 *sval,
> > +                         void *dval)
> > +{
> > +     #define HWRITE(cops) \
> > +     do { \
> > +             if (ops =3D=3D &(cops)) \
> > +                     return (cops).host_write(container, mask_shift, s=
val, \
> > +                                              dval); \
> > +     } while (0)
> > +
> > +     HWRITE(u8_ops);
> > +     HWRITE(u16_ops);
> > +     HWRITE(u32_ops);
> > +     HWRITE(u64_ops);
> > +     HWRITE(u128_ops);
> > +     HWRITE(s16_ops);
> > +     HWRITE(s32_ops);
> > +     HWRITE(be16_ops);
> > +     HWRITE(be32_ops);
> > +     HWRITE(mac_ops);
> > +     HWRITE(ipv4_ops);
> > +     HWRITE(bool_ops);
> > +     HWRITE(dev_ops);
> > +     HWRITE(key_ops);
>
> possibly
>
> #undef HWRITE
>

Nod.

> ?
>
> Otherwise LGTM!


Thanks for taking the time to review!

cheers,
jamal

>
> Cheers,
>
> Paolo
>

