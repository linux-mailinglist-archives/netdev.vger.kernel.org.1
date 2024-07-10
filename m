Return-Path: <netdev+bounces-110530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A392CDF0
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B411F2501D
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1B17B517;
	Wed, 10 Jul 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NZtldwTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC124F20E
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602562; cv=none; b=bzrCYr7fHfkLmrj7lBdcE3Fmr354V73hyNY2tViDBoCmv62IEx7bsW0t0HZLyjD0mZRz5AGCh0hfvcImhr7laDr3QU055fi7m2SDqcNXpeVx2RRAF8Hoih5l8C8VAVjRcmgdswPqNTLK0Q2xHI3qDzsq3tr724qopbxdFOahAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602562; c=relaxed/simple;
	bh=g9//PnPR/g3l8GKSbBEtgayz3InSuisr/p5ldjVSgzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJMA7/Q1/97BDzlu2zglq+xuuXLcEEtzodzNpx5CN+kDhCM7t0C6MY+xiz58Rae25cP2119q9Lf/a3/mqhWTWoM8NekN95QSNohowyHZLgmyZiqgZ5/JWaVDEduSVD3eqkCX1h1Fp6trxwPvIFJMFNQtd2/+55NcR79AuVI3cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NZtldwTV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9f863c46so6627044e87.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720602559; x=1721207359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OM4vo0Rrgeyy/kO62D66plEJEc5nCBb5/IdyGLSYavw=;
        b=NZtldwTVx4/rWrsug1p6i9dv0qGv08zHDJOdBLb1fTGR2tCOvpMiwUf1HHO+WQkvwB
         vjO+o/zS8q0ElTBoSvsjav5zCalXnrlAUMI4tZEmVecThawpLCiXtCz0l6OI+DKl/zmw
         wrBCk0Qw0/aaRkYQzfmzmRM2ufQDy34w9DMDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602559; x=1721207359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OM4vo0Rrgeyy/kO62D66plEJEc5nCBb5/IdyGLSYavw=;
        b=YLWIoII8duaWP4ALLhzvlBi81mnBeqE7QZR0GVGjnnnA/s9939+davKPDJMAkM60R8
         /m9CJ9Nijo6sf73rZ2w/qggMwiZXmEwAvjf71DHeY/jjlne2EA7hSQt3bvqrmZns0RRM
         vhcN5ejY/kpglw7FL/BY3PEblcQNOSKd4+zzZm8U/id51FN8aRoAzrp1VPIYsq+wds6T
         1P+h5GXE59+FJSYmazrAPLL7Y7oO0IfNRNHY+hiVerM8vl398yhJJkHKHRTjhyq8xOXS
         o28GlML69SlSziObXDWQy4mFYxeVokt/QwCXZ+siq2vHllntS3YnPYogsuJBW5XEUjk9
         GPvA==
X-Gm-Message-State: AOJu0Yxrx2qsG41LMgr6JMj1gO3QYJAjKHERkENvCMvAAOaeZdNNv16t
	CVzfRbs87elQsX6KQrhooaTvHKvPvQ9xjGYloXDVU52WDvuljNParUaLk06bB3as2PHVl3oQVLK
	m+AcNMAUF3N/JXCezFcRwCvEj7FaLYKpTDuMq
X-Google-Smtp-Source: AGHT+IHQ65msyduECZCMbfVj2aq75YSqK1S1BeX9AleoFRtScjRNeSszEoPX3RpEw2apr5PJddctiKZo8pkWzfmLCSw=
X-Received: by 2002:a05:6512:108c:b0:52e:9480:9e71 with SMTP id
 2adb3069b0e04-52eb9996055mr3106359e87.28.1720602558706; Wed, 10 Jul 2024
 02:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710075127.2274582-1-schalla@marvell.com> <20240710075127.2274582-6-schalla@marvell.com>
In-Reply-To: <20240710075127.2274582-6-schalla@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 10 Jul 2024 14:39:06 +0530
Message-ID: <CAH-L+nPXV0=wAknOHvM6KCKLj61RsMpN57DMCJuMTc6Ze4vSig@mail.gmail.com>
Subject: Re: [PATCH net,v2,5/5] octeontx2-af: fix issue with IPv4 match for RSS
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com, 
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com, 
	ndabilpuram@marvell.com, Satheesh Paul <psatheesh@marvell.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000055ccaa061ce10034"

--00000000000055ccaa061ce10034
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:24=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> From: Satheesh Paul <psatheesh@marvell.com>
>
> While performing RSS based on IPv4, packets with
> IPv4 options are not being considered. Adding changes
> to match both plain IPv4 and IPv4 with option header.
>
> Fixes: 41a7aa7b800d ("octeontx2-af: NIX Rx flowkey configuration for RSS"=
)
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>

LGTM
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 19fe3ed5c0ee..3dc828cf6c5a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -3866,6 +3866,8 @@ static int get_flowkey_alg_idx(struct nix_hw *nix_h=
w, u32 flow_cfg)
>
>  /* Mask to match ipv6(NPC_LT_LC_IP6) and ipv6 ext(NPC_LT_LC_IP6_EXT) */
>  #define NPC_LT_LC_IP6_MATCH_MSK ((~(NPC_LT_LC_IP6 ^ NPC_LT_LC_IP6_EXT)) =
& 0xf)
> +/* Mask to match both ipv4(NPC_LT_LC_IP) and ipv4 ext(NPC_LT_LC_IP_OPT) =
*/
> +#define NPC_LT_LC_IP_MATCH_MSK  ((~(NPC_LT_LC_IP ^ NPC_LT_LC_IP_OPT)) & =
0xf)
>
>  static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_c=
fg)
>  {
> @@ -3936,7 +3938,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey=
_alg *alg, u32 flow_cfg)
>                         field->hdr_offset =3D 9; /* offset */
>                         field->bytesm1 =3D 0; /* 1 byte */
>                         field->ltype_match =3D NPC_LT_LC_IP;
> -                       field->ltype_mask =3D 0xF;
> +                       field->ltype_mask =3D NPC_LT_LC_IP_MATCH_MSK;
>                         break;
>                 case NIX_FLOW_KEY_TYPE_IPV4:
>                 case NIX_FLOW_KEY_TYPE_INNR_IPV4:
> @@ -3963,8 +3965,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey=
_alg *alg, u32 flow_cfg)
>                                         field->bytesm1 =3D 3; /* DIP, 4 b=
ytes */
>                                 }
>                         }
> -
> -                       field->ltype_mask =3D 0xF; /* Match only IPv4 */
> +                       field->ltype_mask =3D NPC_LT_LC_IP_MATCH_MSK;
>                         keyoff_marker =3D false;
>                         break;
>                 case NIX_FLOW_KEY_TYPE_IPV6:
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--00000000000055ccaa061ce10034
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
AQkEMSIEIE59LJd14aFgr/cvkoKk9/aL6T8PfffLYLeLkqiIUCmNMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMDA5MDkxOVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC3xmFwh/ZE
UZZd1+bGKs3hNqVYyWxAZ3C6T/xxmEBIpZBB2pwMnqOt8TnXUKVIf27nTFNgCD4uJ0Yam7eWPMFo
L1VIIQ8Uf6wrAkqb2rbcLidAKYqLQq5x1hUx3LThRC2kDeGmwjfBS6q30fgtTmmnYpG4EcoXfo6A
mMPOoFQGSwRnfij7wZftZy42DVykR+GViHwy/LmHaz6j/KnLk8epZQyDinfR7NQehF6b2eRsSQ52
+qYdaYSunEuqgl20BqeP8cUtzFOpQShscr61uHF3pFBKK6ZlDuNv3KzT0hMDcu9oSf9u0yqGiVzs
lY8Mnw811ZlSdh8JskGx9XTBcRSG
--00000000000055ccaa061ce10034--

