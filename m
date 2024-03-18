Return-Path: <netdev+bounces-80432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7087EB25
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4686D1F21D77
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50CA4DA00;
	Mon, 18 Mar 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RhO0gVfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCE4D11F
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772615; cv=none; b=BEsBlV2ClvbzzrWuEZyvdoTUQeDbINf6OTdgc53MBdYkhgDev2IPhAXxKw4zX0X/zgtH+akeQLeiOBv3HpfJG6/eTBdHFl37YElqOfM3RQByOZ1UlfbjzqHYFE/Fe8bW8DBlmUrOCR6hHg6g0gqD5YxKIuyqQVZHd0oKtJ1xemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772615; c=relaxed/simple;
	bh=q562mGzcp8l21Otpq9wwOLZlt//foJqxbMmuJs0tieU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH6C80lkxXpjRLtyr05ImjMoxoOPbfPqxPy0QP4qNtA76cS2B8IHDUpkaGpJo/WwGmcKgbUUcE+e7y6KiI4prBTd3KBJz3PLezGq0jKUTY0ZfU37gyshx6wuFTIEYarRSHGuDiRY84Ews384Oy+VnGkh+2m2KoWH1n743UqVpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RhO0gVfo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d247e3c4so3639646e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710772611; x=1711377411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Okm/RUykyjFI3RCk/LyumHuvJO1VfvrIZ+pDhjGsA/U=;
        b=RhO0gVfowOPVfgvCtcUdO5S1vsb1sqHkMNBXEdRhLg8dqT1jbvrGeVf1GRwnrh/UZw
         sjsPXVPxixS4xquqnm8f1+wgDebTpy16CfDGGfQjkeOC71qklsYTF/bkhKG3j3USyC09
         EEbQ9JWhKbtQ34OjKAygaMOPG+UYOgS3MtDkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772611; x=1711377411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Okm/RUykyjFI3RCk/LyumHuvJO1VfvrIZ+pDhjGsA/U=;
        b=UN5D0ezYP7u9qEwTwJXRMD3QbwdlO5uUZCJ0d4HJoxqXIiToAUXGk9i2CT91ehgwOL
         /IrcHyU0Rfd2CdElxCkhx2T1zvL9pJuejhm87oy3jDZqgM06zFLU3W1jTcxyhX2XBAkp
         vlLPk0ZYmHw83IwMvNigYC6K4I/DY4HH4XAW78HU9Dwpd8t1CfMyTjWTSHfBUA1A0JgK
         vrjc3ZNvzc051x2QkRyw/ZEP8ApSEJ720YitIFSGi5Hfz8MG6bCmYO+fPPukLyJbV/7Y
         0+l1duPiU8iqjjMntxZOnNtoLlt29UVU+vO1LaAYhnLhK5rmcec38ZW2CrxG8nvOJqwh
         MOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbj0IJn/cwnKovnalIB0kctRRHrwjA+4RFww9AS1v0h0fcIJWrHbT4izccCxM7+jxgtExR4pzW9VYdkjH5fx3jgfHwbL6F
X-Gm-Message-State: AOJu0Yw3j5QxTgJAQZ3VUjelk2nP+FrUj+erBibxS8tzU+90HJCARI+d
	0rB9Yy6bh0YQLpE8qSrE+1uCr8zh12honqeCuFkTmfgaL1gnLKMLN/JWgKbejBsEB+lvUePkXTx
	H2U5l7modGWJcqCW3SWrAbRBuns7MzIbYjjeJ
X-Google-Smtp-Source: AGHT+IGuPKhqQietc3i8/k5neqrxyfZElOYaXLgYCE9i+QkHXkfSiqVEituC4GSM/71Aid4l5qkOwGFNr1R809N473I=
X-Received: by 2002:ac2:4158:0:b0:513:d125:43b8 with SMTP id
 c24-20020ac24158000000b00513d12543b8mr4338580lfi.25.1710772611425; Mon, 18
 Mar 2024 07:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318132948.3624333-1-shaojijie@huawei.com> <20240318132948.3624333-2-shaojijie@huawei.com>
In-Reply-To: <20240318132948.3624333-2-shaojijie@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 18 Mar 2024 20:06:40 +0530
Message-ID: <CAH-L+nPtgMUXve82iVq_q8yTpzDuwR4bHyz+Tv_xb9tYGR=83Q@mail.gmail.com>
Subject: Re: [PATCH V3 net 1/3] net: hns3: fix index limit to support all
 queue stats
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	michal.kubiak@intel.com, rkannoth@marvell.com, shenjian15@huawei.com, 
	wangjie125@huawei.com, liuyonglong@huawei.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d1dff70613f0495a"

--000000000000d1dff70613f0495a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:05=E2=80=AFPM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
> From: Jie Wang <wangjie125@huawei.com>
>
> Currently, hns hardware supports more than 512 queues and the index limit
> in hclge_comm_tqps_update_stats is wrong. So this patch removes it.
>
> Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs =
for PF and VF reuse")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Only question I have is whether this is a fix or an enhancement.
Nevertheless changes look good to me.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_t=
qp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp=
_stats.c
> index f3c9395d8351..618f66d9586b 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stat=
s.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stat=
s.c
> @@ -85,7 +85,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *h=
andle,
>                 hclge_comm_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_TX=
_STATS,
>                                                 true);
>
> -               desc.data[0] =3D cpu_to_le32(tqp->index & 0x1ff);
> +               desc.data[0] =3D cpu_to_le32(tqp->index);
>                 ret =3D hclge_comm_cmd_send(hw, &desc, 1);
>                 if (ret) {
>                         dev_err(&hw->cmq.csq.pdev->dev,
> --
> 2.30.0
>
>


--=20
Regards,
Kalesh A P

--000000000000d1dff70613f0495a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQiwYJKoZIhvcNAQcCoIIQfDCCEHgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
AQkEMSIEIIMup+bTSuwzQ+oOtXgz+XbY/OiBjfWbzTGNrv1MPQPPMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxODE0MzY1MVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQASLpARj3/9
XKr39T3ii30UIyvvGO2tTdTsF9hZd4pJi63zv8lfEFIPJ9yozLVFLDre5kTtxpfKMq3h2ikWQohe
o0pSit8j+Xv+d80QdXAJuWn9dAFaCVV94B1V5OkyVsBYGCy54vAM9AKwSQY5Svn++YSjqdj3dfpf
MxQIaAw9Pc4Cvw0TzABXTTbiKQe8DP5a7MOOmmUzf4VJ2ccUlX8BVbQTBG3jGJ3z9HSd/wCNsNvH
X9ZdHm3BMKFP51/x7RtnQDHOdndElDzYYTYt4r+/72vjtnP2TcmUaTKygYqDmfYfT745UNPTqpuo
rKLgjRMthMuoTRLfsE6a9PtRsrr1
--000000000000d1dff70613f0495a--

