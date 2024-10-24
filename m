Return-Path: <netdev+bounces-138470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25F9ADC65
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1733228555F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83548189F47;
	Thu, 24 Oct 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FFHKUdjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312A189F25
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752076; cv=none; b=G3L7rwY6LNZGBULttGWNM8W2qpacXDuXuOmxuPUGbpLbJzVbt+yfLd8B4iNuU5Vv+TjNrVCm89HAuuWedmKQmk5WTKbe7Uoi8PkObe17GumdPKsNPQ0CJHKnG9BE88T7drvGmlhO9s0ZjHgVO9N01JQMNe6QFmmEkb8vnWZ1UiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752076; c=relaxed/simple;
	bh=7ptDzBv6BwZqkQTzu6OuCZORNX1h+mZHl6bm8D3jDEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGvAZSjixSX/e0W3HwPC+DRSu2NjUqE0Z+NZK6ItbfyJbs4EZRIajWDVoUXnQjJ/+lMfi5BPJ+DZm7UnOXCS3LPzDLyyzJBz00pxcJlsiK2w+GvL+BUNd8GK6ITKJZgHTbbGS21KGUrpXNU1I0zCEuMJ99iS+XwBjQ9lpFfhHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FFHKUdjZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so3895951fa.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729752072; x=1730356872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZZ2AByI2YSBk1DwQknO1LsLPGuOvmg1rX4vEo58Tto=;
        b=FFHKUdjZk6gbD8NNUNc4YjvYmMjmlMlFbUqb6sFleB6ADueNmhmI3rZ+3eXNv5/2KF
         9l/OYOs5zSfkHx1Qgr4GscZj6t+K/JsRq+Qtb8xcgXm+XGC6/WCCgfxm72yjZpuiCSF5
         Jp1LY1CIHcCCddZJNRSOnDUwV34pqvCXOwgW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729752072; x=1730356872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZZ2AByI2YSBk1DwQknO1LsLPGuOvmg1rX4vEo58Tto=;
        b=bCzZwEZc50GKz+nVuCUjp173L4FhR7GXDfOyaHlZSopvQ8ZXPiKN0WIQWxPWRQde3O
         k+9zn40XIu82+S5ci/hsdoD9Oe4cLAgM2f+A1cdgIRwY3RMDaNgH6KYdnzAXKk5yxs89
         406hPn1eE9HJE61IVj7JdObgI0YaUK4vKM9DVixJ4gJX17DGEpFmxvMPe3eiIEVrSRBC
         Ie6ZRdwS3brPLuJJ2D6V8Um/hwsYmqnTWhcYWiNk6nO9HuYy/YDiODQnmDenVdHMuGG0
         /pYRSUrlYEvFZPiDIxCDWq9QcBsz5q197qO/LLfbqc+3GVGl4LKD8mYRdp71rYZ7d/Iz
         oPQA==
X-Forwarded-Encrypted: i=1; AJvYcCX5wZPYMLJvLq1qAZQoogupCevqw8sW0LvtFkl8LTL4dQ+x6Av+aylOOtKJYl7vddCDmRycbuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+mQxM9gXGjR/8abWV8lqXaMyDv9n6hABHryqfzju5oQJFfAy
	/SloaJOsDNpxrNpKOnh3P4aKAttT58SIVBula54wXyoG/gU6IXq6i1wnyFjjcLWNZE6b3BEH/+s
	YPrS2zpH1xNoeyqaYXemt6EYuBC8IHuJOWNJE
X-Google-Smtp-Source: AGHT+IE0MYf1rvMYswmXHL8dtUfCgQ1C2Occ2fVydxr157Xr17Bzuzj2rw+rOvMTzJyLxJUJYe+5EABW0wXQHCGezSA=
X-Received: by 2002:a05:6512:b06:b0:539:e94d:b490 with SMTP id
 2adb3069b0e04-53b23e85764mr380626e87.43.1729752072195; Wed, 23 Oct 2024
 23:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-2-ap420073@gmail.com>
In-Reply-To: <20241022162359.2713094-2-ap420073@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 23 Oct 2024 23:40:59 -0700
Message-ID: <CACKFLikH-8fdqpvFouoNaFGq011+XvR0+C-8ryq-SutAs=RdsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] bnxt_en: add support for rx-copybreak
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d6d5fa0625334985"

--000000000000d6d5fa0625334985
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> userspace. Only the default value(256) has worked.
> This patch makes the bnxt_en driver support following command.
> `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> `ethtool --get-tunable <devname> rx-copybreak`.
>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v4:
>  - Remove min rx-copybreak value.
>  - Add Review tag from Brett.
>  - Add Test tag from Stanislav.
>
> v3:
>  - Update copybreak value after closing nic and before opening nic when
>    the device is running.
>
> v2:
>  - Define max/vim rx_copybreak value.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 48 ++++++++++++++++++-
>  3 files changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index bda3742d4e32..0f5fe9ba691d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

> @@ -4510,7 +4513,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
>                                   ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADR=
OOM), 8) -
>                                   SKB_DATA_ALIGN(sizeof(struct skb_shared=
_info));
>                 } else {
> -                       rx_size =3D SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH + =
NET_IP_ALIGN);
> +                       rx_size =3D SKB_DATA_ALIGN(bp->rx_copybreak +
> +                                                NET_IP_ALIGN);

When rx_copybreak is 0 or very small, rx_size will be very small and
will be a problem.  We need rx_size to be big enough to contain the
packet header, so rx_size cannot be below some minimum (256?).

>                         rx_space =3D rx_size + NET_SKB_PAD +
>                                 SKB_DATA_ALIGN(sizeof(struct skb_shared_i=
nfo));
>                 }
> @@ -6424,8 +6428,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, =
struct bnxt_vnic_info *vnic)
>                                           VNIC_PLCMODES_CFG_REQ_FLAGS_HDS=
_IPV6);
>                 req->enables |=3D
>                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THR=
ESHOLD_VALID);
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh);
> -               req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);
> +               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak);
> +               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);

Similarly, these thresholds should not go to 0 when rx_copybreak becomes sm=
all.

>         }
>         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
>         return hwrm_req_send(bp, req);

> @@ -4769,7 +4813,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
>         cpr =3D &rxr->bnapi->cp_ring;
>         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
>                 cpr =3D rxr->rx_cpr;
> -       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
> +       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copybreak);

The loopback test will also not work if rx_copybreak is very small.  I
think we should always use 256 bytes for the loopback test packet
size.  Thanks.

>         skb =3D netdev_alloc_skb(bp->dev, pkt_size);
>         if (!skb)
>                 return -ENOMEM;

--000000000000d6d5fa0625334985
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICppHr/DhN2fDeE0T6QhjsVKfl5WG+Pe
kPvf1RnXLCHZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAy
NDA2NDExMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA7+z5EFyzEgwFJb3zMq4s1ihwdq3gjMoSdV90Hd3VRSDvJ46NB
Kgzrz7OH73bxzdB/XdZYrTZcdsM9GzEv7yfyshKRpoeFel4QwQmAHkzIwI/7L+/ntDel1Mo8izMY
ReiXBx52LOUmrMqao5PyIp7qjZkLV67SGvRPT4L46IP4ROv7nBgbue81LRBow3aNzN0QYzm0b71O
iurthK17BE7tMNGdWG7V0G1CxZDNfOFWUujT/QAGFXK92/bCcwKdGLUveZKnNRnGAagEfBppbz5o
lAeCZEPv1oFbiO8HWejQu/DydFpEk6oRjXBjwf7FjmraSGVI6BrorDOHPFYY4hsT
--000000000000d6d5fa0625334985--

