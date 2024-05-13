Return-Path: <netdev+bounces-96022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919248C404F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37951C20F36
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F6714EC5A;
	Mon, 13 May 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Un/x5hDl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC114D2B2
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601716; cv=none; b=uBugqb3y1kRbyHMsvJ54uc5KUefVuSWW7ITZmlO1zkdQBhDADcJnybjeaOJYoZHZjgwhfY4Jp2PO68r/4Txf+9ZW8nT78dN+cioQLzdlK9ZrJW4LCP8XqqMh3cUJPIKUWX7KLQ0ShmRDTgnWhvLEOh6HQeNzphFbiI1cpafHArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601716; c=relaxed/simple;
	bh=NVi5K4uQlumUj2MM5SVktba1lv7p0n4gGVIhu7NZPz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh99dpxslDhYWxxyfnritCLI84sLlZ9duOL7LfLmExQ1RNRvS9uWyQR60ad9VmT9S2WI4nFaUp66lp3DmUuKbia7k05pG1LTDYy3bwnFhgNeg9zOBzBdnkSsW0Wk7Hmb38HPNnRqtcos6t0/hT4SeEiuAIbZHV7l1UEDd1ua8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Un/x5hDl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e4939c5323so53903001fa.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715601713; x=1716206513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfyaoHVqjG6igehRli0DLuRA3muV1Xe+ELSLNKIUsJg=;
        b=Un/x5hDl6fFPQVCJFU/6bGS0bpvaS6oZCwo6o2lDf37zGLM1xDxrTa7eVWNe1YIg5t
         mO9ZYPzOJKfXiMbFE2ABDluMo/z5LZzJ2KwKcusB+2uqcqtEc7Xm8/UtoBeaQZCbyjAY
         QN+v+V/tdwycnEMrJKqaWn8yFCDkkLLET3NYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601713; x=1716206513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfyaoHVqjG6igehRli0DLuRA3muV1Xe+ELSLNKIUsJg=;
        b=GS6o4xavd1KtM0FVSXAg16+sLCQktiLscTl3c3EX2Ovu0dqzA5t9r5KOouKMr8NIvS
         +QFq/T+3FXe/+tUU949Gt/lVPAaFuZuHKLUilZAi0Eldg2/M3Brzujg+mw8KW9llTIkh
         ari78iaLEPKUaCTrrGXNG8feFOUiHXRzHGTqDZKuX/YaHTDizH4TvnCX+DUVvfNsxpPD
         IqMz9b6Y/HudMB0uztVsxNZaiYMPDP1Ozl5hmAKAkqnn42v4X5eE18vf0nXiunT4Dlby
         XYcYYhZoNQgbzj34eI+9AzJ0jwvmQDIQLDcYxwAdS7IuLoGOTxbtcvPJ5NgtPSuZuXmQ
         Dy9w==
X-Forwarded-Encrypted: i=1; AJvYcCXWKMB/aU3nWghyLl8zBSp9K4FuAMifKuP7pP9xw1PuWI08LnYc6Hr4SszXOMZiZy71fKJbpQC4GhHMNXmFyT8RNXBKU//q
X-Gm-Message-State: AOJu0Yz/8BBMsHczzNR4Vb1ljXN7pS5rScCp9jgCjBr9pv7xZKwaNoes
	pF3u8rcSRKkJJvhkuSajNYuP3yxFAoQPbeEqvlOIq51nlyzhjoUiJ2jyoB2RzdEUC9ycFsmW9rX
	w4yViSIo8g4bdZ2dwD8RAJ55suxzf/L1LObS7
X-Google-Smtp-Source: AGHT+IGnRCW18IDo1Hm5VBVoMvnYxI8ze0s3wnN6BnI2szKec+wUH3mTBW2IyA9IF7T7/x39aEgveHfSub4NHbVvHsE=
X-Received: by 2002:a2e:859:0:b0:2e5:4171:1808 with SMTP id
 38308e7fff4ca-2e541711898mr66189431fa.51.1715601712815; Mon, 13 May 2024
 05:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-6-michal.swiatkowski@linux.intel.com>
 <CAH-L+nPnpxJKscC74YoDUr6pirHNuiBBFN8U+o9zRsW8gw2C8w@mail.gmail.com> <ZkHp+fIvfw2m4De0@mev-dev>
In-Reply-To: <ZkHp+fIvfw2m4De0@mev-dev>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 May 2024 17:31:40 +0530
Message-ID: <CAH-L+nOv8muYENQyfPmEUsXNkkAty4ienj+4FCXGS1ZMViuBkQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-next v2 05/15] ice: allocate devlink for subfunction
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com, 
	mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com, 
	michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org, 
	pio.raczynski@gmail.com, sridhar.samudrala@intel.com, 
	jacob.e.keller@intel.com, wojciech.drewek@intel.com, 
	przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b203a9061854a6e2"

--000000000000b203a9061854a6e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 3:54=E2=80=AFPM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Mon, May 13, 2024 at 02:55:48PM +0530, Kalesh Anakkur Purayil wrote:
> > On Mon, May 13, 2024 at 2:03=E2=80=AFPM Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com> wrote:
> > >
> > > From: Piotr Raczynski <piotr.raczynski@intel.com>
> > >
> > > Make devlink allocation function generic to use it for PF and for SF.
> > >
> > > Add function for SF devlink port creation. It will be used in next
> > > patch.
> > >
> > > Create header file for subfunction device. Define subfunction device
> > > structure there as it is needed for devlink allocation and port
> > > creation.
> > >
> > > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com=
>
> > > ---
> > >  .../net/ethernet/intel/ice/devlink/devlink.c  | 33 ++++++++++++
> > >  .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> > >  .../ethernet/intel/ice/devlink/devlink_port.c | 50 +++++++++++++++++=
++
> > >  .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> > >  drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++
> > >  5 files changed, 108 insertions(+)
> > >  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drive=
rs/net/ethernet/intel/ice/devlink/devlink.c
> > > index 3fb3a7e828a4..c1fe3726f6c0 100644
> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > > @@ -10,6 +10,7 @@
> > >  #include "ice_eswitch.h"
> > >  #include "ice_fw_update.h"
> > >  #include "ice_dcb_lib.h"
> > > +#include "ice_sf_eth.h"
> > >
> > >  /* context for devlink info version reporting */
> > >  struct ice_info_ctx {
> > > @@ -1282,6 +1283,8 @@ static const struct devlink_ops ice_devlink_ops=
 =3D {
> > >         .port_new =3D ice_devlink_port_new,
> > >  };
> > >
> > > +static const struct devlink_ops ice_sf_devlink_ops;
> > > +
> > >  static int
> > >  ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> > >                             struct devlink_param_gset_ctx *ctx)
> > > @@ -1419,6 +1422,7 @@ static void ice_devlink_free(void *devlink_ptr)
> > >   * Allocate a devlink instance for this device and return the privat=
e area as
> > >   * the PF structure. The devlink memory is kept track of through dev=
res by
> > >   * adding an action to remove it when unwinding.
> > > + *
> > >   */
> > >  struct ice_pf *ice_allocate_pf(struct device *dev)
> > >  {
> > > @@ -1435,6 +1439,35 @@ struct ice_pf *ice_allocate_pf(struct device *=
dev)
> > >         return devlink_priv(devlink);
> > >  }
> > >
> > > +/**
> > > + * ice_allocate_sf - Allocate devlink and return SF structure pointe=
r
> > > + * @dev: the device to allocate for
> > > + * @pf: pointer to the PF structure
> > > + *
> > > + * Allocate a devlink instance for SF.
> > > + *
> > > + * Return: void pointer to allocated memory
> > > + */
> > > +struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_p=
f *pf)
> > > +{
> > > +       struct devlink *devlink;
> > > +       int err;
> > > +
> > > +       devlink =3D devlink_alloc_ns(&ice_sf_devlink_ops,
> > > +                                  sizeof(struct ice_sf_priv),
> > > +                                  devlink_net(priv_to_devlink(pf)), =
dev);
> > > +       if (!devlink)
> > > +               return NULL;
> > > +
> > > +       err =3D devl_nested_devlink_set(priv_to_devlink(pf), devlink)=
;
> > > +       if (err) {
> > > +               devlink_free(devlink);
> > > +               return ERR_PTR(err);
> > > +       }
> > > +
> > > +       return devlink_priv(devlink);
> > > +}
> > > +
> > >  /**
> > >   * ice_devlink_register - Register devlink interface for this PF
> > >   * @pf: the PF to register the devlink for.
> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drive=
rs/net/ethernet/intel/ice/devlink/devlink.h
> > > index d291c0e2e17b..1af3b0763fbb 100644
> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > > @@ -5,6 +5,7 @@
> > >  #define _ICE_DEVLINK_H_
> > >
> > >  struct ice_pf *ice_allocate_pf(struct device *dev);
> > > +struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_p=
f *pf);
> > >
> > >  void ice_devlink_register(struct ice_pf *pf);
> > >  void ice_devlink_unregister(struct ice_pf *pf);
> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/=
drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > > index 812b306e9048..1355ea042f1d 100644
> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > > @@ -432,6 +432,56 @@ void ice_devlink_destroy_vf_port(struct ice_vf *=
vf)
> > >         devl_port_unregister(&vf->devlink_port);
> > >  }
> > >
> > > +/**
> > > + * ice_devlink_create_sf_dev_port - Register virtual port for a subf=
unction
> > > + * @sf_dev: the subfunction device to create a devlink port for
> > > + *
> > > + * Register virtual flavour devlink port for the subfunction auxilia=
ry device
> > > + * created after activating a dynamically added devlink port.
> > > + *
> > > + * Return: zero on success or an error code on failure.
> > > + */
> > > +int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
> > > +{
> > > +       struct devlink_port_attrs attrs =3D {};
> > > +       struct devlink_port *devlink_port;
> > > +       struct ice_dynamic_port *dyn_port;
> > [Kalesh] Try to maintain RCT order for variable declaration.
>
> Maybe I don't understand RCT order correctly, but based on my
> understanding it is fine. Which declaration here break RCT order?
>
> Do you mean that ice_dynamic_port is longer than devlink_port and should
> be moved up?
[Kalesh] Yes, longest line to shortest for local variable declarations
in new Networking code.
Didn't know that RCT is also applied to inner part of
> declaration. If there will be more comments I will move it in another
> spin.
[Kalesh] Thanks
>
> > > +       struct devlink *devlink;
> > > +       struct ice_vsi *vsi;
> > > +       struct device *dev;
> > > +       struct ice_pf *pf;
> > > +       int err;
> > > +
> > > +       dyn_port =3D sf_dev->dyn_port;
> > > +       vsi =3D dyn_port->vsi;
> > > +       pf =3D dyn_port->pf;
> > > +       dev =3D ice_pf_to_dev(pf);
> > > +
> > > +       devlink_port =3D &sf_dev->priv->devlink_port;
> > > +
> > > +       attrs.flavour =3D DEVLINK_PORT_FLAVOUR_VIRTUAL;
> > > +
> > > +       devlink_port_attrs_set(devlink_port, &attrs);
> > > +       devlink =3D priv_to_devlink(sf_dev->priv);
> > > +
> > > +       err =3D devl_port_register(devlink, devlink_port, vsi->idx);
> > > +       if (err)
> > > +               dev_err(dev, "Failed to create virtual devlink port f=
or auxiliary subfunction device");
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +/**
> > > + * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subf=
unction
> > > + * @sf_dev: the subfunction device to create a devlink port for
> > > + *
> > > + * Unregisters the virtual port associated with this subfunction.
> > > + */
> > > +void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> > > +{
> > > +       devl_port_unregister(&sf_dev->priv->devlink_port);
> > > +}
> > > +
> > >  /**
> > >   * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
> > >   * @dyn_port: dynamic port instance to deallocate
> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/=
drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > > index f20d7cc522a6..e4acd855d9f9 100644
> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > > @@ -5,6 +5,7 @@
> > >  #define _DEVLINK_PORT_H_
> > >
> > >  #include "../ice.h"
> > > +#include "../ice_sf_eth.h"
> > >
> > >  /**
> > >   * struct ice_dynamic_port - Track dynamically added devlink port in=
stance
> > > @@ -33,6 +34,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
> > >  void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> > >  int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
> > >  void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
> > > +int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
> > > +void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> > >
> > >  #define ice_devlink_port_to_dyn(p) \
> > >         container_of(port, struct ice_dynamic_port, devlink_port)
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/ne=
t/ethernet/intel/ice/ice_sf_eth.h
> > > new file mode 100644
> > > index 000000000000..a08f8b2bceef
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > > @@ -0,0 +1,21 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/* Copyright (c) 2024, Intel Corporation. */
> > > +
> > > +#ifndef _ICE_SF_ETH_H_
> > > +#define _ICE_SF_ETH_H_
> > > +
> > > +#include <linux/auxiliary_bus.h>
> > > +#include "ice.h"
> > > +
> > > +struct ice_sf_dev {
> > > +       struct auxiliary_device adev;
> > > +       struct ice_dynamic_port *dyn_port;
> > > +       struct ice_sf_priv *priv;
> > > +};
> > > +
> > > +struct ice_sf_priv {
> > > +       struct ice_sf_dev *dev;
> > > +       struct devlink_port devlink_port;
> > > +};
> > > +
> > > +#endif /* _ICE_SF_ETH_H_ */
> > > --
> > > 2.42.0
> > >
> > >
> >
> >
> > --
> > Regards,
> > Kalesh A P
>
>


--=20
Regards,
Kalesh A P

--000000000000b203a9061854a6e2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIF2/itlA9aB4kBRe+/8aPcJhI66SXXX/Yi60oEEUK0aJMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUxMzEyMDE1M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBi42qJgjJD
9VOivWnAKK/6Jxgohsw8kA1ui8Y5kL0dID3wgyeDrBgYwvZDLe/0yzhFFwpt4dR3DfiACBSv0grf
SMJmq2jX/MStM8yUaMnspJioR4yDpbnTG3sk94Zxg8s4QCp4C8JZR3X1YvPdN5ddqeUJS2wQMmkD
0atSfvfQEyx+XVh9mBVJ5JexRPBFb1phu0jvwkZIeizxUSsdcgsa65EIPSurSbB2MwixHfKw22QD
T6plPOAm08rUvwYBEYArimdHu/++KEzU8Yr+gj4XlUzeq3QhyP5mCRiYSL3PiIR4kHBZVjt8n4zk
90grFKbVVr12VHjWl+Jzh0zQpatv
--000000000000b203a9061854a6e2--

