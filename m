Return-Path: <netdev+bounces-95928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67A8C3DE8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF1F280AAE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C71487CC;
	Mon, 13 May 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FI8VEE8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA814830A
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591709; cv=none; b=GrZf4xXjrSK29NuyU55Hhs1CsmeNJTgWVAOYfp94VNxNbm5yetENOCOkWRT7L8eCoNqKMs4YnXiRxz1YGwLP3B8jvwGd8S67daDH1azMcTQNvdxqKoOnN2jdvF/8gUhgVPfnxjGRv7sRirr10wtbE2nuVSxewedirsS4HPNGZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591709; c=relaxed/simple;
	bh=8SkuejOmoTMa7vOKY+mjrQxWONEmrStQhLYRNp88UiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKuGGa1gdElPfho3jpJ3OVkesAVbn86pjjjDhqDdb7du3dnGtLLB4KAGtMQ/DyPlxiBXWU2AdDfaWqrG0wN/uLkHi7DhDPjdHESVu0KFGyhWh2C+9TYHdpHa6vRN9oA+d9FHVvtogL9ArrVW198bqAzvt/YQxMPRlope2PPo/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FI8VEE8k; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e43c481b53so50977381fa.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715591706; x=1716196506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sa5exa9aURQILrca/h39E53KIOiUSJ95AFjYU7C3v20=;
        b=FI8VEE8kbtN7DfytaVS+4h5kZHDwraM4VjiS6TbJ4RrOx5gVMvt8fI7NdHNPLPQyXQ
         Y5JWIXY1hsAXxgzvwXEZ1FbMlMeKVEfux4KwKLE1iFKfJ3b7lSFRtqf00/Lr2bu/bZAH
         e3GFcSOdck3BBJ3OvM2Pc3Ks0qk5I/wFM4CcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715591706; x=1716196506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sa5exa9aURQILrca/h39E53KIOiUSJ95AFjYU7C3v20=;
        b=spuniPy+aIwJyHr//tPZiDOCYi6nxMo71V1tVk2TCuvAiFfbRc24TSPhp91SCw7QUf
         tPtsW3FB0xlHk1MI9Q16V21SQEW4ad1oRXoLSVSTDfe9gstdlf/XGNvbkBfPeT6LZ5xe
         Px6AgTDiHGIjuoWeAk10MiSLOxDeW8cA2T6lYbyfln/xwiWIc04LpNcimSA8w+gF2s30
         bSSAX/lnts2uIlH424SaW4yMmdkxAlrZpg8INl1BPLcgL1+Szu3bHOyj1UfdoF50Z1WY
         5BEXXuFmQtElN1orX/HTo4wvLeu1UljUY0/oXb+3j33qnJSCXwh6zsEWWjNiL+G6Tru4
         DvWA==
X-Forwarded-Encrypted: i=1; AJvYcCVLa+yIMsItB+2w7CXS3hRm1x9SM/Ygvqic52mdUjmq8ECKN4qrI0qjfDSGezjDNisHxIRIZIov+QXchRqLVJaqpIqOJ1vj
X-Gm-Message-State: AOJu0YxVmXEfo86kmWSE83XpqFMIMD6EGy3g+kdkfcMsz3J5B2yGaSCd
	jKLMMwCoBc5Jr9VaR5hxxhjoL+ghddj8DP25sUvEDbJZxr0v//85hIEQTtEWoek2Sflo5RGG0Pu
	A/H7IiVH0vNkA7hDTkSkxbTiekyy6Y1oXD1v2
X-Google-Smtp-Source: AGHT+IE5JB+cm3f3Zl0ksu7kRlEwaoLbkm6DJ9f0Uclrztf0E1Myr9UcxZpPm1OMM0QBgKqmHAN56O3V5gYROE2zFVY=
X-Received: by 2002:a2e:bc26:0:b0:2db:348f:5c33 with SMTP id
 38308e7fff4ca-2e51fd4addamr68628601fa.16.1715591705710; Mon, 13 May 2024
 02:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240512124306.740898-1-tariqt@nvidia.com> <20240512124306.740898-4-tariqt@nvidia.com>
In-Reply-To: <20240512124306.740898-4-tariqt@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 May 2024 14:44:53 +0530
Message-ID: <CAH-L+nPOW8_miPvwkv7rEzWRsnVy3Q+-rd8FyWo6-HnBwBJKxQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Remove unused msix related
 exported APIs
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000038a3ad06185252cd"

--00000000000038a3ad06185252cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 6:14=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Parav Pandit <parav@nvidia.com>
>
> MSIX irq allocation and free APIs are no longer
> in use. Hence, remove the dead code.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Looks good to me.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 52 -------------------
>  include/linux/mlx5/driver.h                   |  7 ---
>  2 files changed, 59 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/=
net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 6bac8ad70ba6..fb8787e30d3f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -507,58 +507,6 @@ struct mlx5_irq *mlx5_irq_request(struct mlx5_core_d=
ev *dev, u16 vecidx,
>         return irq;
>  }
>
> -/**
> - * mlx5_msix_alloc - allocate msix interrupt
> - * @dev: mlx5 device from which to request
> - * @handler: interrupt handler
> - * @affdesc: affinity descriptor
> - * @name: interrupt name
> - *
> - * Returns: struct msi_map with result encoded.
> - * Note: the caller must make sure to release the irq by calling
> - *       mlx5_msix_free() if shutdown was initiated.
> - */
> -struct msi_map mlx5_msix_alloc(struct mlx5_core_dev *dev,
> -                              irqreturn_t (*handler)(int, void *),
> -                              const struct irq_affinity_desc *affdesc,
> -                              const char *name)
> -{
> -       struct msi_map map;
> -       int err;
> -
> -       if (!dev->pdev) {
> -               map.virq =3D 0;
> -               map.index =3D -EINVAL;
> -               return map;
> -       }
> -
> -       map =3D pci_msix_alloc_irq_at(dev->pdev, MSI_ANY_INDEX, affdesc);
> -       if (!map.virq)
> -               return map;
> -
> -       err =3D request_irq(map.virq, handler, 0, name, NULL);
> -       if (err) {
> -               mlx5_core_warn(dev, "err %d\n", err);
> -               pci_msix_free_irq(dev->pdev, map);
> -               map.virq =3D 0;
> -               map.index =3D -ENOMEM;
> -       }
> -       return map;
> -}
> -EXPORT_SYMBOL(mlx5_msix_alloc);
> -
> -/**
> - * mlx5_msix_free - free a previously allocated msix interrupt
> - * @dev: mlx5 device associated with interrupt
> - * @map: map previously returned by mlx5_msix_alloc()
> - */
> -void mlx5_msix_free(struct mlx5_core_dev *dev, struct msi_map map)
> -{
> -       free_irq(map.virq, NULL);
> -       pci_msix_free_irq(dev->pdev, map);
> -}
> -EXPORT_SYMBOL(mlx5_msix_free);
> -
>  /**
>   * mlx5_irq_release_vector - release one IRQ back to the system.
>   * @irq: the irq to release.
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 8218588688b5..0aa15cac0308 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1374,11 +1374,4 @@ static inline bool mlx5_is_macsec_roce_supported(s=
truct mlx5_core_dev *mdev)
>  enum {
>         MLX5_OCTWORD =3D 16,
>  };
> -
> -struct msi_map mlx5_msix_alloc(struct mlx5_core_dev *dev,
> -                              irqreturn_t (*handler)(int, void *),
> -                              const struct irq_affinity_desc *affdesc,
> -                              const char *name);
> -void mlx5_msix_free(struct mlx5_core_dev *dev, struct msi_map map);
> -
>  #endif /* MLX5_DRIVER_H */
> --
> 2.44.0
>
>


--=20
Regards,
Kalesh A P

--00000000000038a3ad06185252cd
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
AQkEMSIEIGCs7bpIUeX407zVjQRB7OyoqXQOD05TvmQ9J1o3BfR+MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUxMzA5MTUwNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC7lv3J8Ds1
hwBhuUElhKEaor0+b4Dp6mq4I++pOVCTTCWKrgLR3nLrMG/k9DdkCyG/vVTEdSMLIkEFltoYty/f
DcyedpcBsQsPpFlm2cijKfjPjgay3/yCgf5XqLEfQpjQJ5h0uLqFF+fOP27TrtpMhFGLHvMA0e8F
w6tyozo75dIk962At1VGpVVC2uJVVduxYxvTfX5OqCP6bvI+mSdN2f/ZPIZ3eLMwqtVHLITc2aNy
bhO2KECWgr8NsiKTbGV4yNB90SGw6uShM6dkJ2JdrfukxPs05RugEpF4LB9aCgwEJkJe+l/Ye3ID
Iu/wdimjqvIQ7vXnQ9IrxNcLyC+d
--00000000000038a3ad06185252cd--

