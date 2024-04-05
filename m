Return-Path: <netdev+bounces-85085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628638994D0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BBD1C21C71
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 05:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FA21A06;
	Fri,  5 Apr 2024 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M9QwqnW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D51EB2A
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712296416; cv=none; b=pTv5TNGRgy6JaD2ceHwthYNu0nwtrHBudYzKZoRtUeiXONjyXdf7R+8x/RwMXZ/r7XLQcmk/P0lNB9aQfQLU/yL8whPNrm7bH1P62Tdl1UJVawzfdwjH6FFLujzkdewxNBEEDfzCYb7xA23lj2MjSdvhySshS+51nhzAYEG8KvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712296416; c=relaxed/simple;
	bh=n5LB3J9lhx/XAyJXIr+jOeHpIS18sT/H9d4IsGumCBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW/aW+NnzQfCS0M4xAyQBM1UB9w7vRXJj0v/tKdSgkpyaUOV/6H1MdTEL3QJgckyWpr+SwzFEsIJM/OYL9ZOVQiciGA/8F4n/kXDTqesVSmmAWimsNC+96yX1f+c6YwurnAdD+z40vvvfOTG9bUaUg0VAcMuS6GMIGQ3P7vs+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M9QwqnW9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so1829613e87.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712296412; x=1712901212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvAkGwUt1BdzniDO/8juRrRvNv+5XSPhrjr/lZq6CY0=;
        b=M9QwqnW9ephi5dG31ZgVV/KB8BjeYObXXU3pf0mvYbyS4WM1KmG95vZeAaQQpvnq+a
         oFxYb0Q+gQ4+nFN/MnDl8e0Jmx6mhFqsg3rvlGFtGmJGAMzBD2fRQmvkICa0434l2F5D
         nQdHwj69La5b56ISnQU9EuOxDeTToPtrpXslM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712296412; x=1712901212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvAkGwUt1BdzniDO/8juRrRvNv+5XSPhrjr/lZq6CY0=;
        b=jqgDb4zNGhC5ogG26EN6rsnhv1//GahOItIaDZU33CZ+ZG3EuxqxFvtPGda0ttsVg4
         ob5shnptzaY40HcpbXDv15ybt+bNt3aSkJCLZFsu+7eiA6SunWOtofedZW6o4nwTWmZH
         8pz9vjKBWvaiguq60IatIUSPL1fmyn+f8PyRGIA9qVdc9bgqizONvx5YEOmTpGC1nSBc
         TLKMYDvH/f8cey8NYzyfiXFXbtVKh1cC8as98Jl3RE322w2pcT/c3BlvdqgiDBxjVzX7
         D3FMNoj0hmR+Yoj1SbTOgSjqp5jr5amXzPP42o+sr3FEsyvspyY7r6AYmjt3rGZWSS8J
         QV9A==
X-Forwarded-Encrypted: i=1; AJvYcCVBk210JDPNXjhmMRhnX3x1QW5YYiWzV1voneiiYBogD91Jv5UXzgFe5+IPVabdIfwSRHdcXD4poiM2bNUirnzcpZSb/mRQ
X-Gm-Message-State: AOJu0YxFc4LzKch10UubyRW1YnbNLI5Epc11QFGwQiEbCvuWnoVcOE7q
	A+fEvmc4xOGWvBW8+q1TJGAbyphm5m1jlNiX5sWfjYajKgxM7tr14AsPYc0mT1zsUUisqRizY1H
	QJUTzs1NztldI65npBAdUjP47FtDbctBHzTph/3en6ekuT0Fb9w==
X-Google-Smtp-Source: AGHT+IH318P7xUEvR0sYDReA6CZViKHg0qPme8Z1/3DioLARCT7PbF+RAKCIseVWzpYZsud40TsPtAv3RruNf9T9bAw=
X-Received: by 2002:a19:ac07:0:b0:513:5e6b:a191 with SMTP id
 g7-20020a19ac07000000b005135e6ba191mr203596lfc.50.1712296412249; Thu, 04 Apr
 2024 22:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404173357.123307-1-tariqt@nvidia.com> <20240404173357.123307-6-tariqt@nvidia.com>
In-Reply-To: <20240404173357.123307-6-tariqt@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 5 Apr 2024 11:23:19 +0530
Message-ID: <CAH-L+nMWGRpFYHks+Yb=pmGV6HJO46PN5-WU3bZrBFs8xAU8Rg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] net/mlx5e: Un-expose functions in en.h
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006ea6d7061553132d"

--0000000000006ea6d7061553132d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:05=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> Un-expose functions that are not used outside of their c file.
> Make them static.
>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 ----------
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 22 +++++++++----------
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
>  3 files changed, 12 insertions(+), 24 deletions(-)

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/e=
thernet/mellanox/mlx5/core/en.h
> index f5a3ac40f6e3..2acd1ebb0888 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -1143,7 +1143,6 @@ void mlx5e_close_drop_rq(struct mlx5e_rq *drop_rq);
>  int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn);
>  void mlx5e_destroy_tis(struct mlx5_core_dev *mdev, u32 tisn);
>
> -int mlx5e_update_nic_rx(struct mlx5e_priv *priv);
>  void mlx5e_update_carrier(struct mlx5e_priv *priv);
>  int mlx5e_close(struct net_device *netdev);
>  int mlx5e_open(struct net_device *netdev);
> @@ -1180,23 +1179,12 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv =
*priv,
>                                struct ethtool_coalesce *coal,
>                                struct kernel_ethtool_coalesce *kernel_coa=
l,
>                                struct netlink_ext_ack *extack);
> -int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
> -                                    struct ethtool_link_ksettings *link_=
ksettings);
> -int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
> -                                    const struct ethtool_link_ksettings =
*link_ksettings);
> -int mlx5e_get_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rx=
fh);
> -int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rx=
fh,
> -                  struct netlink_ext_ack *extack);
>  u32 mlx5e_ethtool_get_rxfh_key_size(struct mlx5e_priv *priv);
>  u32 mlx5e_ethtool_get_rxfh_indir_size(struct mlx5e_priv *priv);
>  int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
>                               struct ethtool_ts_info *info);
>  int mlx5e_ethtool_flash_device(struct mlx5e_priv *priv,
>                                struct ethtool_flash *flash);
> -void mlx5e_ethtool_get_pauseparam(struct mlx5e_priv *priv,
> -                                 struct ethtool_pauseparam *pauseparam);
> -int mlx5e_ethtool_set_pauseparam(struct mlx5e_priv *priv,
> -                                struct ethtool_pauseparam *pauseparam);
>
>  /* mlx5e generic netdev management API */
>  static inline bool
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 69f6a6aa7c55..93a13a478c11 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -996,8 +996,8 @@ static void get_lp_advertising(struct mlx5_core_dev *=
mdev, u32 eth_proto_lp,
>         ptys2ethtool_adver_link(lp_advertising, eth_proto_lp, ext);
>  }
>
> -int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
> -                                    struct ethtool_link_ksettings *link_=
ksettings)
> +static int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
> +                                           struct ethtool_link_ksettings=
 *link_ksettings)
>  {
>         struct mlx5_core_dev *mdev =3D priv->mdev;
>         u32 out[MLX5_ST_SZ_DW(ptys_reg)] =3D {};
> @@ -1167,8 +1167,8 @@ static bool ext_requested(u8 autoneg, const unsigne=
d long *adver, bool ext_suppo
>         return  autoneg =3D=3D AUTONEG_ENABLE ? ext_link_mode : ext_suppo=
rted;
>  }
>
> -int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
> -                                    const struct ethtool_link_ksettings =
*link_ksettings)
> +static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
> +                                           const struct ethtool_link_kse=
ttings *link_ksettings)
>  {
>         struct mlx5_core_dev *mdev =3D priv->mdev;
>         struct mlx5_port_eth_proto eproto;
> @@ -1268,7 +1268,7 @@ static u32 mlx5e_get_rxfh_indir_size(struct net_dev=
ice *netdev)
>         return mlx5e_ethtool_get_rxfh_indir_size(priv);
>  }
>
> -int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param =
*rxfh)
> +static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh=
_param *rxfh)
>  {
>         struct mlx5e_priv *priv =3D netdev_priv(netdev);
>         u32 rss_context =3D rxfh->rss_context;
> @@ -1281,8 +1281,8 @@ int mlx5e_get_rxfh(struct net_device *netdev, struc=
t ethtool_rxfh_param *rxfh)
>         return err;
>  }
>
> -int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rx=
fh,
> -                  struct netlink_ext_ack *extack)
> +static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_pa=
ram *rxfh,
> +                         struct netlink_ext_ack *extack)
>  {
>         struct mlx5e_priv *priv =3D netdev_priv(dev);
>         u32 *rss_context =3D &rxfh->rss_context;
> @@ -1411,8 +1411,8 @@ static void mlx5e_get_pause_stats(struct net_device=
 *netdev,
>         mlx5e_stats_pause_get(priv, pause_stats);
>  }
>
> -void mlx5e_ethtool_get_pauseparam(struct mlx5e_priv *priv,
> -                                 struct ethtool_pauseparam *pauseparam)
> +static void mlx5e_ethtool_get_pauseparam(struct mlx5e_priv *priv,
> +                                        struct ethtool_pauseparam *pause=
param)
>  {
>         struct mlx5_core_dev *mdev =3D priv->mdev;
>         int err;
> @@ -1433,8 +1433,8 @@ static void mlx5e_get_pauseparam(struct net_device =
*netdev,
>         mlx5e_ethtool_get_pauseparam(priv, pauseparam);
>  }
>
> -int mlx5e_ethtool_set_pauseparam(struct mlx5e_priv *priv,
> -                                struct ethtool_pauseparam *pauseparam)
> +static int mlx5e_ethtool_set_pauseparam(struct mlx5e_priv *priv,
> +                                       struct ethtool_pauseparam *pausep=
aram)
>  {
>         struct mlx5_core_dev *mdev =3D priv->mdev;
>         int err;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 81e1c1e401f9..a0d3af96dcb1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5562,7 +5562,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *pr=
iv)
>         mlx5e_ipsec_cleanup(priv);
>  }
>
> -int mlx5e_update_nic_rx(struct mlx5e_priv *priv)
> +static int mlx5e_update_nic_rx(struct mlx5e_priv *priv)
>  {
>         return mlx5e_refresh_tirs(priv, false, false);
>  }
> --
> 2.44.0
>
>


--=20
Regards,
Kalesh A P

--0000000000006ea6d7061553132d
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
AQkEMSIEIFBJFtXDhjjm2RVsqIZLTEQZPOQJggyPMQl+o6u7swQeMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQwNTA1NTMzMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCZuulqhGqH
Ti401Rt11gQNkgfjQK7x4d9eUS4fZNGc+7xqeqWuFx5P/ZHN/+9wokVGghszYjz68qFROU/g6vnh
oYDlUvQei6Dq6OWqs5cgG2e2ntc3TYRWVQrfGtfx13bC6HJ0WUpgj2wstyyeH40CBAQliFqerSYR
47Zdryhc1qJpOLvza9nA2qBzahXmCcXAvMrleQQNn/iWNgy9oeeET9vY0vido6vyfvhUxk+H6D9v
XfZTQK7Yo+TYVD2W6NPNCk9bCipzERPG2oaNmIfvscDrMSLBFef/vVX0pI0uq04HOa+SivuJmlx/
xoboniqaem9Tm4taBe3UKshjDNkD
--0000000000006ea6d7061553132d--

