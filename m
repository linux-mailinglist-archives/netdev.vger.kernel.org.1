Return-Path: <netdev+bounces-216300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6BEB32ED5
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 11:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A9844863A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B5212567;
	Sun, 24 Aug 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTTp5uLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29A3FF1;
	Sun, 24 Aug 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027902; cv=none; b=cOrDIrvjAJSPa3K9g+kGcUasXhCTGPiI8JL68zXdLV85GOmYoEDL3xaRbD4lE34Ien0wukhB/6S/9E9uygRQMpAwTk646I3Xqw8Zw56Df9emCJOCaVPg8WSAHhusbaqzZW7t8Bs/LQTMikYgFWEYpNMeKIRfUdaZmAoPXXHzg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027902; c=relaxed/simple;
	bh=X4ZcmTDUCg7RjdxxMXGrdoDtPc9lCu+Uomc5G/N/pKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfA1S+a9ZBTJsH93wD0r/DMMm6DW5OEYS6KCbC6KqDR3mpDtzl0veGPOwGqc+ZLWEeRWJ8IVSlPqLKQ/U3HAFtUwEsKxPQ80QvuOR1JSnj9kPehkfNGya1PYu/hI6YlgKbcbDNe1qT94qKcgnOOu71puQLtSxotPSqY9+JtxThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTTp5uLr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-770305d333aso1817073b3a.0;
        Sun, 24 Aug 2025 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756027900; x=1756632700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kA1TfqpwSR+m9eSYiMPcP23Gb8KIWfP3WpYtJwN0gQ=;
        b=hTTp5uLrqiw8TvM3ZAUFbvobluF0CrbUmUNuoe37oJ83KhUrSNDkPiCyYQWVUndoG8
         MWwLN7VNcIi7KEh1oQNQUB0SVesqGdV1TMUHN1A5F1n4rSFh94KPf/V2QjsJh21qIlSw
         0PS+bVm7CwW7GjfGwtTfivMCSfoQfE5gYKCx7JkHxHmlTr4/w3frwxGdMVYAgaV3EZ2K
         VE+/9c7nqV+KWz1v9/YeRroKOllvT/MATXT6BBuBhFi2zrO6j2w5C2vmm1ILNShCzyFA
         WKN7IG2nPh38DfnHz30Jz0h5/G6/1svjHVSRMTul2B8/1rZVJ3hCMRqIqxkLVJzled7U
         uosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756027900; x=1756632700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kA1TfqpwSR+m9eSYiMPcP23Gb8KIWfP3WpYtJwN0gQ=;
        b=Joe+CC0TMldyvjy78tMBHN0UeOkwAvTH/Pd1hVw1Ns3P2otL3I2fWSwCIuPiMZcd5u
         BZsaGJqOpTXQXwfrilCx1HFU59LTFZBlEk8Es1OXh/3dwq6TMDIz4sC2/p92EIrwVUGR
         3y/zKwPrKIXrfQ/BidejMcjt5PcXQrTQAqt/S3w5ZaT4w9j92evHFGHP1L/lmTiqntxo
         +lthegm5oH/NgrVRj5sC/hpjPeoMwZwjmD6zy+stMUm93NglR7BI5tjBsFWY42cBCre7
         F3sJf/dbveOz6j+TutBo4zMp6bdEe3+yT2tfXzbh4W8SVsFTjlmn6jpznpG3Dp6t+uW+
         XUiw==
X-Forwarded-Encrypted: i=1; AJvYcCVq5FFAU3S707T7go+xkk5yTKJIsPy0PBJtXvc6yZmHXN9frB2c+crFO153VaBzQkaifp6wI8a8v8whOSb6@vger.kernel.org, AJvYcCWu5+FqT9yZGPFIfAa9mjy/hKXQsSlQTFm+oHPn9bFhPCOPKsNLj+JeoKqIOH7zZhYJt7ygupX8wnHX@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlmQA4fnlf81Jy/RAnBVSfxfwwd/4+WAlIw0iqytpA/r/AvuI
	6tUwehZEt/2Pktb3bBVRvH3fCrkqpyE3Pg//0fyGD+tkHdZyJV5LBqG2owQFA/uEeJ2ZzESBKYQ
	iC2AHZ7ZK5HPSnnz2CCdc5uuhDvTV/+s=
X-Gm-Gg: ASbGncsXu33ZEZWnl2tHE1uKOjd5mmN78iAkCpJegksmSe70glUGXHOMbifD6pudOOk
	4jvppnj1Gewi3Xj3KTNeOZ6BMoPL/jHsKTOPb/V+K2g5mVvnBsA530DG653Py3KVkunOPLXUNNw
	KixCa7uOb4mZMNGL2UP9Fb2nhDLEKAfm0eV8LN9Lrr60bR22QhpL52/qt+PSntK7aM6MWpMEPgz
	Mi0FB1lGkzd9RX1hHQYmTUiJEQreISSCgNyw1kD
X-Google-Smtp-Source: AGHT+IHILFYzimF4xBWhmpSR3dhAW0xrvUKyIJtdbB7nyyBRonmYCJ1GObd9BRnhpMoP4mghd0mMC7gmiOYT35UF5dw=
X-Received: by 2002:a05:6a20:3c90:b0:240:af8:176d with SMTP id
 adf61e73a8af0-24340b5e28cmr13859289637.24.1756027899868; Sun, 24 Aug 2025
 02:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-4-mmyangfl@gmail.com>
 <aKrQhggoGYKzOlkQ@shell.armlinux.org.uk>
In-Reply-To: <aKrQhggoGYKzOlkQ@shell.armlinux.org.uk>
From: Yangfl <mmyangfl@gmail.com>
Date: Sun, 24 Aug 2025 17:31:03 +0800
X-Gm-Features: Ac12FXwbajFdjh92j56yGyODVOvCKBgh6CVUE3D0AYGguMk_Mw7UXPKoILweS7E
Message-ID: <CAAXyoMN1f-z4sMgugnXy=6ComkfX6vGhGSzwbC0kMSJNG6aQ3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 4:42=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> Thanks for fixing the major phylink implementation errors. There are
> further issues that need addressing.
>
> On Sun, Aug 24, 2025 at 08:51:11AM +0800, David Yang wrote:
> > +/******** hardware definitions ********/
>
> ...
>
> > +#define YT921X_REG_END                       0x400000  /* as long as r=
eg space is below this */
>
> Please consider moving the above register definitions to, e.g.
> drivers/net/dsa/yt921x-hw.h Also consider whether some of the below
> should also be moved there.
>
> > +#define YT921X_TAG_LEN                       8
> > +
> > +#define YT921X_EDATA_EXTMODE         0xfb
> > +#define YT921X_EDATA_LEN             0x100
> > +
> > +#define YT921X_FDB_NUM               4096
> >
> > +enum yt921x_fdb_entry_status {
> > +     YT921X_FDB_ENTRY_STATUS_INVALID =3D 0,
> > +     YT921X_FDB_ENTRY_STATUS_MIN_TIME =3D 1,
> > +     YT921X_FDB_ENTRY_STATUS_MOVE_AGING_MAX_TIME =3D 3,
> > +     YT921X_FDB_ENTRY_STATUS_MAX_TIME =3D 5,
> > +     YT921X_FDB_ENTRY_STATUS_PENDING =3D 6,
> > +     YT921X_FDB_ENTRY_STATUS_STATIC =3D 7,
> > +};
> > +
> > +#define YT921X_PVID_DEFAULT          1
> > +
> > +#define YT921X_FRAME_SIZE_MAX                0x2400  /* 9216 */
> > +
> > +#define YT921X_RST_DELAY_US          10000
> > +
> > +struct yt921x_mib_desc {
> > +     unsigned int size;
> > +     unsigned int offset;
> > +     const char *name;
> > +};
>
> Maybe consider moving the struct definitions (of which there are
> several) to drivers/net/dsa/yt921x.h ?

I checked other drivers under dsa and most of them use a single header
for both register and struct definitions, so it might be a more common
practice?

>
> > +/******** eee ********/
> > +
> > +static int
> > +yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee=
 *e)
> > +{
> > +     struct device *dev =3D to_device(priv);
> > +     bool enable =3D e->eee_enabled;
> > +     u16 new_mask;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d, enable %d\n", __func__, port, enable);
> > +
> > +     /* Enable / disable global EEE */
> > +     new_mask =3D priv->eee_ports_mask;
> > +     new_mask &=3D ~BIT(port);
> > +     new_mask |=3D !enable ? 0 : BIT(port);
> > +
> > +     if (!!new_mask !=3D !!priv->eee_ports_mask) {
> > +             dev_dbg(dev, "%s: toggle %d\n", __func__, !!new_mask);
> > +
> > +             res =3D yt921x_smi_toggle_bits(priv, YT921X_PON_STRAP_FUN=
C,
> > +                                          YT921X_PON_STRAP_EEE, !!new_=
mask);
> > +             if (res)
> > +                     return res;
> > +             res =3D yt921x_smi_toggle_bits(priv, YT921X_PON_STRAP_VAL=
,
> > +                                          YT921X_PON_STRAP_EEE, !!new_=
mask);
> > +             if (res)
> > +                     return res;
>
> Here, if EEE is completely disabled, you clear the YT921X_PON_STRAP_EEE
> bit...
>
> > +static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +
> > +     return (priv->pon_strap_cap & YT921X_PON_STRAP_EEE) !=3D 0;
>
> ... and if this bit is clear, you report that EEE is unsupported by the
> device - which means the device has no hardware for EEE support, and
> the ethtool EEE operations will be blocked and return -EOPNOTSUPP. This
> means that once all ports have EEE disabled, EEE can not be re-enabled
> except through hardware reset.
>
> Please see the code in net/dsa/user.c::dsa_user_set_eee().

priv->pon_strap_cap is read from a different readonly register, and
cached globally at startup (yt921x_detect) to reduce SMI ops. It
should not affect reported EEE status.

