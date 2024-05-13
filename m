Return-Path: <netdev+bounces-95934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC48C3E19
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396F7B20BB8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8DF1487FF;
	Mon, 13 May 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h8HcLLuM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3F1487F4
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592364; cv=none; b=JpXA5lN2i6HyFZl8z6RAOSA0QI/cD2Gi+dIP7wHC+LQPTBZVh5Xe8kdLW+eaVvfr9RlZieVY2I1+FRqXFR5+sHlAEqz5oZOY1ibF8HRkaZUMvALCfjygRQ4kO53j1sg3h641JWbVU2h7Pni7NSm9XtVcXbvwHCiys/0hH2fcEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592364; c=relaxed/simple;
	bh=O2fj6Q4Zk7H6/W/ojDcFHowM5gImRGnAxHP9RWnEaKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfCUnkIWb1gdu+IDNUMpbXjAiiwAwHvOiwA7vVMVZjTQ+WDnVhCyOIp1Yo5/7I/XRN3cMCEyFHGS/CMjvqZP/iFYzudNwCKCYOtFTxkGZ3CLJwSI2eEiH3hfmKogCHg9tLOh3PD9A8LUj/3FKlsOCjGJFepkxsoH9t4mb1ZICXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h8HcLLuM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e52181c228so30379501fa.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715592360; x=1716197160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hSPrb4gf/w3lEkhkHwhxHPkJsMAAWzbRvWZnd1d5few=;
        b=h8HcLLuMOt8hqr141swwmaqhTa7o1/EawnxJN3gpcavZSNqA7L+Fu+7TLS9KXZJqUP
         1Sza2vOUmv8zsdyZz4DtNfNwY3lsIrg0MDzIUKk2QpdBp0FJddXjfYazTQfP0qR+B/1+
         2UR2IL/AgaLgNgC/lPLmqNn7G+RDuE5PF2NzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715592360; x=1716197160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSPrb4gf/w3lEkhkHwhxHPkJsMAAWzbRvWZnd1d5few=;
        b=Ankn91y6oV6aqdCS4nUcF1oGuukpipq2H0jgP3SpdMIl5869LB0lwR/sSs/MkLPr0y
         So0aRhX28ifaw4bksosfSIYc4qhm5FGFCqwcjdG+ybi1TjvjgE9ZAyVoNi0VkGnVKRA0
         SUxd/obB1W/vhOmNmd87nxtTwRZUoZ2tPlh3vvWEdw8aeeCYmb1hyOATuzRzzfFhRAui
         zjhx7S/YR04mqrhM0t4HpK/jc0Cq7wJLbfV2EXDc8PnsuLutmr1czAizbHcSYfWV/h7F
         zgqDLZpkIoQ4yHkh8pFZ5RYz5LX3s3ljQpzqftQv3t7pEczBaRqJFqllvzqe2P3oFMo5
         oXaA==
X-Forwarded-Encrypted: i=1; AJvYcCWadtzIzaOuNfpUqfBBUWxQBOj3r+MIfJbt41NqAMdlLMO2vxYrbXflL1nomfafkhBLMThYDg+xsuZnDFX+d8WT0oKpQtBo
X-Gm-Message-State: AOJu0YypBzPDjUImIhJmumWAkslOV6m0iqHmz6r6Ga4xnSXnpVFzh05g
	1VmBrUeNyaAaxw4OK4HtkC3TMSksvB2Odc6/JTc8OxEptLOnERY4YBVClpDHyw37E44t6+khK+b
	Pku9o+XoP7JIQ8NRaz3fV58cxyuRXFQA+mve0
X-Google-Smtp-Source: AGHT+IHaUA3ly42htZ6fDuZDhNulj8t1VDxuYl0Gs24UPndJ+1jzyFRk0DrJB8JeNaH9LIg674b8LkPmsVvcJxjvV9k=
X-Received: by 2002:a2e:a71f:0:b0:2dd:987f:f9d7 with SMTP id
 38308e7fff4ca-2e51ff5e559mr50145591fa.25.1715592360262; Mon, 13 May 2024
 02:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com> <20240513083735.54791-6-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240513083735.54791-6-michal.swiatkowski@linux.intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 May 2024 14:55:48 +0530
Message-ID: <CAH-L+nPnpxJKscC74YoDUr6pirHNuiBBFN8U+o9zRsW8gw2C8w@mail.gmail.com>
Subject: Re: [iwl-next v2 05/15] ice: allocate devlink for subfunction
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	jacob.e.keller@intel.com, michal.kubiak@intel.com, 
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com, 
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com, 
	pio.raczynski@gmail.com, jiri@nvidia.com, mateusz.polchlopek@intel.com, 
	shayd@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003c49930618527903"

--0000000000003c49930618527903
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 2:03=E2=80=AFPM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> From: Piotr Raczynski <piotr.raczynski@intel.com>
>
> Make devlink allocation function generic to use it for PF and for SF.
>
> Add function for SF devlink port creation. It will be used in next
> patch.
>
> Create header file for subfunction device. Define subfunction device
> structure there as it is needed for devlink allocation and port
> creation.
>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 33 ++++++++++++
>  .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
>  .../ethernet/intel/ice/devlink/devlink_port.c | 50 +++++++++++++++++++
>  .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
>  drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++
>  5 files changed, 108 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
>
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/n=
et/ethernet/intel/ice/devlink/devlink.c
> index 3fb3a7e828a4..c1fe3726f6c0 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -10,6 +10,7 @@
>  #include "ice_eswitch.h"
>  #include "ice_fw_update.h"
>  #include "ice_dcb_lib.h"
> +#include "ice_sf_eth.h"
>
>  /* context for devlink info version reporting */
>  struct ice_info_ctx {
> @@ -1282,6 +1283,8 @@ static const struct devlink_ops ice_devlink_ops =3D=
 {
>         .port_new =3D ice_devlink_port_new,
>  };
>
> +static const struct devlink_ops ice_sf_devlink_ops;
> +
>  static int
>  ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
>                             struct devlink_param_gset_ctx *ctx)
> @@ -1419,6 +1422,7 @@ static void ice_devlink_free(void *devlink_ptr)
>   * Allocate a devlink instance for this device and return the private ar=
ea as
>   * the PF structure. The devlink memory is kept track of through devres =
by
>   * adding an action to remove it when unwinding.
> + *
>   */
>  struct ice_pf *ice_allocate_pf(struct device *dev)
>  {
> @@ -1435,6 +1439,35 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
>         return devlink_priv(devlink);
>  }
>
> +/**
> + * ice_allocate_sf - Allocate devlink and return SF structure pointer
> + * @dev: the device to allocate for
> + * @pf: pointer to the PF structure
> + *
> + * Allocate a devlink instance for SF.
> + *
> + * Return: void pointer to allocated memory
> + */
> +struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *p=
f)
> +{
> +       struct devlink *devlink;
> +       int err;
> +
> +       devlink =3D devlink_alloc_ns(&ice_sf_devlink_ops,
> +                                  sizeof(struct ice_sf_priv),
> +                                  devlink_net(priv_to_devlink(pf)), dev)=
;
> +       if (!devlink)
> +               return NULL;
> +
> +       err =3D devl_nested_devlink_set(priv_to_devlink(pf), devlink);
> +       if (err) {
> +               devlink_free(devlink);
> +               return ERR_PTR(err);
> +       }
> +
> +       return devlink_priv(devlink);
> +}
> +
>  /**
>   * ice_devlink_register - Register devlink interface for this PF
>   * @pf: the PF to register the devlink for.
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/n=
et/ethernet/intel/ice/devlink/devlink.h
> index d291c0e2e17b..1af3b0763fbb 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> @@ -5,6 +5,7 @@
>  #define _ICE_DEVLINK_H_
>
>  struct ice_pf *ice_allocate_pf(struct device *dev);
> +struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *p=
f);
>
>  void ice_devlink_register(struct ice_pf *pf);
>  void ice_devlink_unregister(struct ice_pf *pf);
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/driv=
ers/net/ethernet/intel/ice/devlink/devlink_port.c
> index 812b306e9048..1355ea042f1d 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> @@ -432,6 +432,56 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
>         devl_port_unregister(&vf->devlink_port);
>  }
>
> +/**
> + * ice_devlink_create_sf_dev_port - Register virtual port for a subfunct=
ion
> + * @sf_dev: the subfunction device to create a devlink port for
> + *
> + * Register virtual flavour devlink port for the subfunction auxiliary d=
evice
> + * created after activating a dynamically added devlink port.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
> +{
> +       struct devlink_port_attrs attrs =3D {};
> +       struct devlink_port *devlink_port;
> +       struct ice_dynamic_port *dyn_port;
[Kalesh] Try to maintain RCT order for variable declaration.
> +       struct devlink *devlink;
> +       struct ice_vsi *vsi;
> +       struct device *dev;
> +       struct ice_pf *pf;
> +       int err;
> +
> +       dyn_port =3D sf_dev->dyn_port;
> +       vsi =3D dyn_port->vsi;
> +       pf =3D dyn_port->pf;
> +       dev =3D ice_pf_to_dev(pf);
> +
> +       devlink_port =3D &sf_dev->priv->devlink_port;
> +
> +       attrs.flavour =3D DEVLINK_PORT_FLAVOUR_VIRTUAL;
> +
> +       devlink_port_attrs_set(devlink_port, &attrs);
> +       devlink =3D priv_to_devlink(sf_dev->priv);
> +
> +       err =3D devl_port_register(devlink, devlink_port, vsi->idx);
> +       if (err)
> +               dev_err(dev, "Failed to create virtual devlink port for a=
uxiliary subfunction device");
> +
> +       return err;
> +}
> +
> +/**
> + * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunct=
ion
> + * @sf_dev: the subfunction device to create a devlink port for
> + *
> + * Unregisters the virtual port associated with this subfunction.
> + */
> +void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> +{
> +       devl_port_unregister(&sf_dev->priv->devlink_port);
> +}
> +
>  /**
>   * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>   * @dyn_port: dynamic port instance to deallocate
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/driv=
ers/net/ethernet/intel/ice/devlink/devlink_port.h
> index f20d7cc522a6..e4acd855d9f9 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> @@ -5,6 +5,7 @@
>  #define _DEVLINK_PORT_H_
>
>  #include "../ice.h"
> +#include "../ice_sf_eth.h"
>
>  /**
>   * struct ice_dynamic_port - Track dynamically added devlink port instan=
ce
> @@ -33,6 +34,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
>  void ice_devlink_destroy_vf_port(struct ice_vf *vf);
>  int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
>  void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
> +int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
> +void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
>
>  #define ice_devlink_port_to_dyn(p) \
>         container_of(port, struct ice_dynamic_port, devlink_port)
> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/et=
hernet/intel/ice/ice_sf_eth.h
> new file mode 100644
> index 000000000000..a08f8b2bceef
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024, Intel Corporation. */
> +
> +#ifndef _ICE_SF_ETH_H_
> +#define _ICE_SF_ETH_H_
> +
> +#include <linux/auxiliary_bus.h>
> +#include "ice.h"
> +
> +struct ice_sf_dev {
> +       struct auxiliary_device adev;
> +       struct ice_dynamic_port *dyn_port;
> +       struct ice_sf_priv *priv;
> +};
> +
> +struct ice_sf_priv {
> +       struct ice_sf_dev *dev;
> +       struct devlink_port devlink_port;
> +};
> +
> +#endif /* _ICE_SF_ETH_H_ */
> --
> 2.42.0
>
>


--=20
Regards,
Kalesh A P

--0000000000003c49930618527903
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
AQkEMSIEINAvDUVYjhE3fKJWkuScbu0hyVCqO6lBBaUwZB6tqUEiMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUxMzA5MjYwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbsMx+3YZE
M8k616QbzCTy5CTEW9xWq4rJRuY76/YzWVazoHEVyj23nWCjNx4UQmft1JVBFqAKnHlL0aaald+c
DJQEAIAYRQ4jVvt0Evln70OkSMNnyOuz3D3+ICzyc3+tYTPhkekW8pc/HyCiUTu0zosLRGAEq6lW
yL7caHov7NO00xYSxn4Y0m8Vzpw1YPtFhopjBH818kSyBh7THji4yfaVnf8VOQPBXIgKR6EWNYIK
RUzA+r3g07JO/yRP1JXVUUiDl+VQeGqrgFmdhGV9zeqTc6cSAWxkiENSbqB7s0dLvZ0kBDwwvRhH
Q+nFoz00AZZGxWueKvKi6K1QmqCZ
--0000000000003c49930618527903--

