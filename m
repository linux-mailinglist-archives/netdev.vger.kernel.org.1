Return-Path: <netdev+bounces-173238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B514DA5819E
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC86C1681EF
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A517BB3F;
	Sun,  9 Mar 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c1qbXAm+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239217ADF8
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508757; cv=none; b=pG5e9Z3slfXCu2zRGSd7gVC3D6gUAlYpvEwYppsmtfk6Ult6XmMTOqhs4h5h1IrwQhorkyYK90I7RUO/MdqCYDsJ+MyveDYLMj3yyR6q9Ge98izYWjptv5RwHETwp1138t7/dp7U9Tfc3TklESGmpkhUfRIWUdxCWBjSRt0fkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508757; c=relaxed/simple;
	bh=o02t2hz/aQ3vBUfXza7xsbnj+KDVRwefsg12JyMA5Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCfleCXPUw/LDxhPb6uzA1oEnb42cId2WEidgALcWsQABlkz4KoY7SVjGmrwi2xtEX3aobTAKFBS5fdUGcuEFcbk0KwKdqIG08U73MDq4IwA/4z3mWycdP/qD/93L+ZjOllZXr6WjlaU//lSkjkmqrdsWwoV4YS6uPeYGftFze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c1qbXAm+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so5049540a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 00:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741508754; x=1742113554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+G1nearWeUHygHfEPLIUYCQl+8Os6/afc+kwew31bgc=;
        b=c1qbXAm+tMxSdMXh9RpFTcIhc3mqbs2jaAPBdakSrT/o3llizF8xcEc5GHyDY9ENDT
         5ZY2OO4AgBfKdv7Ug7ok2/Fg7n/FTvM8Amyaabv4H57xX5wxd4u4xgMSUI+EvuJTV6ez
         DbtG98eCob2RqduvKP17Oq3UQjLsV7zfM0y4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741508754; x=1742113554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+G1nearWeUHygHfEPLIUYCQl+8Os6/afc+kwew31bgc=;
        b=px0BqFN3fkx+P5RKVtrwu579GwnwaVVkqTpTUPFM6Vtr7+uWXTrcbFGYKW27XFuapi
         0odYlP7wSEAtbAZVgaWIEtjOivf9ZSytJPUDLagxDZtkDJfLwO9qrownS/w3Ig54wHxP
         sLP/RVf26Bj2StnuODZDWM71EqWJLUQmaqIpuCNWpxY4SftGHOXidKh8lsEjLkQF1rD2
         e/lUdx4Kc9b4q8JAWxTjMroYInRIRu0P4J/G7s0tRQBEkbIm9iZsDmWFs7G0U4eLAjk0
         mkkmIcPsm2ENyKEBHJ4rLCr8jzX9ec5eciwpUQ0lQFAwnSv2ubpBEuVDcuFjj+7Xi4K1
         sz2g==
X-Forwarded-Encrypted: i=1; AJvYcCWaFKMQg/lfUKQk36wN/GQc4+pdnq3GsJNkb+Y1M917+LZWX4teGntB8Et7ATe7Ot0px1R4cXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdBdD7a0n7gD7DEeP5WJ8ZbjGR0zSrTZJwBOLAnPLqqH7Z/gR
	m/9HVOHfVZhtaqcQmn6vwLybyrbP3hEKJXSdmbKSzeV+OYblNXnKrqGlbHcH2pJeZFcBH2FiM0E
	5LAx8IQtA6yua9v54qF1PL7xZYeSqGVBYmHCrOFp30P4BfdI=
X-Gm-Gg: ASbGncvcUNdejLbq5RzPlabcDUu8HQ1jrc3LGlGDy6OM+/fE0iePISgu1CbcX4NeHAj
	zECEqis4TeLm2eBJiiE3txOR12w3SvrSF4CuDDuYE4QQJ2zMBt9or6eE1bmufPNBEqVrtLTP/P+
	knoXRY/vMtaicLBvssHsa8KN9VRJI=
X-Google-Smtp-Source: AGHT+IHlHZJG82OZXBihmhMEyMmtPS8r8m+Jg6LY7c/HUDAMSujrIbiKrZ7bhAMjEgGN9hSzgJvBQbQ4TRHLnxy95iY=
X-Received: by 2002:a05:6402:354f:b0:5de:dd31:1fad with SMTP id
 4fb4d7f45d1cf-5e5e22b1bf7mr8664676a12.6.1741508753801; Sun, 09 Mar 2025
 00:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305225215.1567043-1-kuba@kernel.org> <20250305225215.1567043-10-kuba@kernel.org>
In-Reply-To: <20250305225215.1567043-10-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 9 Mar 2025 00:25:42 -0800
X-Gm-Features: AQ5f1JqaLc9bbaApztsh0yZNsseTevpRZqO7idhCuyxQz7fhi5UJxoCaiEyMkAg
Message-ID: <CACKFLikTC_xY1q2CS8orYZzkXc7e0P8GEfcb4+9wX6kBFH8srQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/10] eth: bnxt: maintain tx pkt/byte stats
 in SW
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aa53bb062fe49aa7"

--000000000000aa53bb062fe49aa7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:

> @@ -610,6 +612,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>                                     DB_RING_IDX(&txr->tx_db, prod));
>                 WRITE_ONCE(txr->tx_prod, prod);
>
> +               if (skb->len < BNXT_MIN_ETH_SIZE)
> +                       tx_buf->extra_bytes +=3D BNXT_MIN_ETH_SIZE - skb-=
>len;

s/BNXT_MIN_ETH_SIZE/ETH_ZLEN

BNXT_MIN_ETH_SIZE is 52 bytes but HW will pad to 60 bytes.  So we need
to also include the HW padding.

>                 tx_buf->is_push =3D 1;
>                 netdev_tx_sent_queue(txq, skb->len);
>                 wmb();  /* Sync is_push and byte queue before pushing dat=
a */
> @@ -634,6 +638,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>                         goto tx_kick_pending;
>                 length =3D BNXT_MIN_PKT_SIZE;
>         }
> +       if (skb->len < BNXT_MIN_ETH_SIZE)
> +               tx_buf->extra_bytes +=3D BNXT_MIN_ETH_SIZE - skb->len;

Same here for non-push packets.  Thanks.

--000000000000aa53bb062fe49aa7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQYAYJKoZIhvcNAQcCoIIQUTCCEE0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJ4Z89wdCACVRIujgVckFvRqy09xwx+I
52Q2eb66cUIEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMw
OTA4MjU1NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAHBhqm8RhzajM6ub/UvlNj6Cf6rY2FaMDzte6aXCZZCNSTE/4B2KdyyCvh2IRLLm9jhp
K2XhdT1qtzQHfnScrPlJVQo91wpi/7ZzIiuwH/x2MBCJINLv4k/5QtGv5xPccAZeLNl6qZ3Dp9PI
VkCJGTZ7PjPxiW57CWJtQNx/Qpm0fWXt9WGyBNSuEfFBVCtZ1GC4/bhma/yQFpJKlkHbjdEAfjyY
+xlwyY4o/b0BX7p42z5qkYc1gBoetxQotPbqoGB1qqkx82YXV69imW5f+b7cwkdqQWjW9Qi0h3KX
YUpB8as7h5KO7J41F2diRJQdtHRVsteSf34HY6/FDseNCeA=
--000000000000aa53bb062fe49aa7--

