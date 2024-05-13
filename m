Return-Path: <netdev+bounces-96026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6E8C409F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FB11F21504
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84E14F12D;
	Mon, 13 May 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AJPdWRG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13B14F120
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602936; cv=none; b=G8JsjSH6YTeNOYX3EgiuOhIcM4/IziXMzHpEFibmVeUOGP/Qzjp4XpxU8cR9cuiBALENybOajLJuup+4QKycLybEl3GhiZ1XPuBE9ipHqAwypQbenSiASTqXeyA5iZidOj+/wM+/eX6RFnXDOeUjSGTLxZLiDRPmPMrR0KhHDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602936; c=relaxed/simple;
	bh=7tFnrBYKZfice1sWnsk6Uqnw9INoQE/igU4K5ltVAbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COI/D1UJYDhbPcOVVRb/h40SRTf1A6aarrF1CJ5Au9ZGnPKoiUgpMPvicII+og3f4jZXKMWvcqOOkhvWwcJ/lUSXSISEexbwU1wPAhv2co48xsYSOo1Zze43+x3IlbywwefTcQxg5cLeY9Dtnqxv+i/uWJ4Vssnv132mbsvI+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AJPdWRG4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e1d6166521so44067581fa.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715602932; x=1716207732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/l0WijSNQd4tiN+YJG6zu9vyFTYoEdYB/FJPhOhIOl8=;
        b=AJPdWRG4lb+Wq0uoCIDZ0TKNhC5NjISvbiD7vV5l8pcsEsW1G1DjkZQWqMtFodO4j4
         MQtE238ujIWEUk9vx3NtL4daswki0vzPFWA/cox5zzfycY8MxyAgsiFiPxagyI0MFz3T
         xjC/4kj9p8lAk9HTmZ74gj2xN158cYAtbQSxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715602932; x=1716207732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l0WijSNQd4tiN+YJG6zu9vyFTYoEdYB/FJPhOhIOl8=;
        b=J+T3VHzy15boBxs/1XVcfE0C/ekzYt2fxSsA2pq2xL4zm+baKPWx+I/56YQXU44FMG
         HBDG9T74l6FGTPXnY3F2HgRjTGtSYWcycA6R+Ak2fEMk49ecGNJ3FI4Ukm8ynlD5OCPK
         vUrU33wLanYQq5G933sqoZ3XbjnaqIHdGazK3Ddp5h6MkfGR16DDblKAOEN9BWRFZQ/t
         aESlLOSYgw8rrWHnh0Cz1Okbee5sgYtOPtXZTKBkCVmr0S7niztnDE3ziYlARcJ+IHCg
         JtOv5w1z2tM1zzEPlZ3MjXgzs/FfBgY+heS9VHBBlnpJv1uFn/96hK0Jgd3+jbKebBdo
         Dwtw==
X-Gm-Message-State: AOJu0Ywif9tKblt4aG/zeQs8t1+5vAKTttUkj/PzgIBD+eW1Qci2LrT4
	PTktcdNT43JX3q4bM4SGH51g3/ELWRYWWEFIQQ8NW6Fp0QV1pScNeS3oniIU4EAhTw541HmiA7H
	nMhgZvQjCJpaSofbjW+9okw8DazRzHVvk+IX5
X-Google-Smtp-Source: AGHT+IHb0pL1THp0q/JWWu+0YxijSDpZon98nIs4jsZ3y5hFR3bXE+IWnLAxA/+vVAY2Pj1ttu362GAGDYOSGPq3hLA=
X-Received: by 2002:a2e:812:0:b0:2d4:535a:e7a with SMTP id 38308e7fff4ca-2e51b4784b6mr30680471fa.24.1715602932536;
 Mon, 13 May 2024 05:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513105446.297451-1-bbhushan2@marvell.com>
In-Reply-To: <20240513105446.297451-1-bbhushan2@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 May 2024 17:52:01 +0530
Message-ID: <CAH-L+nO1up0OwYjiEjTw58a3az96EekXpQTZ7psxHFDYOdD=Ug@mail.gmail.com>
Subject: Re: [net-next,v2 0/8] cn10k-ipsec: Add outbound inline ipsec support
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com, 
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jerinj@marvell.com, lcherian@marvell.com, richardcochran@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000064823c061854ef2d"

--00000000000064823c061854ef2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 4:25=E2=80=AFPM Bharat Bhushan <bbhushan2@marvell.c=
om> wrote:
>
> This patch series adds outbound inline ipsec support on Marvell
> cn10k series of platform. One crypto hardware logical function
> (cpt-lf) per netdev is required for inline ipsec outbound
> functionality. Software prepare and submit crypto hardware
> (CPT) instruction for outbound inline ipsec crypto mode offload.
> The CPT instruction have details for encryption and authentication
> Crypto hardware encrypt, authenticate and provide the ESP packet
> to network hardware logic to transmit ipsec packet.
>
> First patch makes dma memory writable for in-place encryption,
> Second patch moves code to common file, Third patch disable
> backpressure on crypto (CPT) and network (NIX) hardware.
> Patch four onwards enables inline outbound ipsec.
>
> v1->v2:
>  - Fix compilation error to build driver a module
>  - Use dma_wmb() instead of architecture specific barrier
>  - Fix couple of other compilation warnings

Comments on V1 is not addressed.

Also, please respect the 24h grace period when posting on netdev:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/mainta=
iner-netdev.rst#L399
>
> Bharat Bhushan (8):
>   octeontx2-pf: map skb data as device writeable
>   octeontx2-pf: Move skb fragment map/unmap to common code
>   octeontx2-af: Disable backpressure between CPT and NIX
>   cn10k-ipsec: Initialize crypto hardware for outb inline ipsec
>   cn10k-ipsec: Add SA add/delete support for outb inline ipsec
>   cn10k-ipsec: Process inline ipsec transmit offload
>   cn10k-ipsec: Allow inline ipsec offload for skb with SA
>   cn10k-ipsec: Enable outbound inline ipsec offload
>
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |    4 +
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   74 +-
>  .../ethernet/marvell/octeontx2/nic/Makefile   |    1 +
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 1068 +++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       |  258 ++++
>  .../marvell/octeontx2/nic/otx2_common.c       |   80 ++
>  .../marvell/octeontx2/nic/otx2_common.h       |   25 +
>  .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
>  .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
>  .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
>  12 files changed, 1563 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipse=
c.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipse=
c.h
>
> --
> 2.34.1
>
>


--=20
Regards,
Kalesh A P

--00000000000064823c061854ef2d
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
AQkEMSIEIORnBzpuDjNlCkna+yv9DcQzKVDKj+1pufguM50LmEMtMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUxMzEyMjIxMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBVAWxQewlh
sNECFQXNPi8oFPTqPO4CroYeMieFUrk9GEcYSjD9uHga8WschIVsV0IWuIIwcQ54b6npGxxZDwVn
wpuMg9VCziPu+r7Fz/fxZQvHbd/A8JpRAtgGjMq6CcmXQ7zktP38KJ40E4ulYIhj28QJbAMIgdHK
QlOPtu0ejy0qUqkL3/r+xc5wKasi9nC9fv5ouEctrzTqedrvSEz2sNZzUaZhTiHsrd77kI6lAJtt
LXtWc9kY9krEGcIZd4Jwa5JFemgsF74UAx1hsv+RebvAQp1ghTK0NCvEovMibhRYQL35PH5+AGzm
xzxZEjTlTZU6J7Fl4Z7ZJPRrgsMr
--00000000000064823c061854ef2d--

