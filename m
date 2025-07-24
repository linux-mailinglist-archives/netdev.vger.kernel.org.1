Return-Path: <netdev+bounces-209595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA94B0FF2E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724574E118C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0B1D63C6;
	Thu, 24 Jul 2025 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bm5qLZZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FB1DF24F
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328175; cv=none; b=Lbi9yMLrIxnfn1j2G6FGDGsuZ0/D7AtJIdYPdMyPCFnFclcpwVC2gO5COhgE8kAyYGbeytG9cpzSjIgMOUpzkypX8caaeWkaTt5K0jTh2fP7FnzLHLxS/zRfxYUaX7id/1UJwWOiKa5uZdUuathXhrwjm8AxcI9AmNyiBhFyZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328175; c=relaxed/simple;
	bh=fDYGRL3So8HRgt6z6xrds4iVvQ2bqABjKJcZ/D9Io9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J47ZxDR5pSigy/dcaQI/n5BzhAUcgEZZOuMgcKwEGxY8D1aGZD10Fti1G1wb+iJ86GKb+1T1dmi/Qx1gZo1/n/jc6AlyLqDzPtx12S3/x+XHfPQfXJkpLUh/scynDre9L+a6XVcat0FbQSmBhHz96B2PznXxAWUomAbuvpSrD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bm5qLZZ1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso114465866b.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753328172; x=1753932972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QcqmClYbGOlW/LKCZ29EcO8PO10dlfe/aJiua+dGo9k=;
        b=bm5qLZZ1Z0n5e3CbxpPet4bNRZXtIpKacWGA+yDXYtLu0SmfXadVYk0gEgdmpy/M2j
         oue3DTG9dJZelzCjRCDmaxZjTSYTpS6R2oSl8R9q38xmVZU2Futmoyvk3chyoIDgenUF
         8PQG3/FNzitAp7FlumQW8HQwo8LAEPyyBNmwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753328172; x=1753932972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcqmClYbGOlW/LKCZ29EcO8PO10dlfe/aJiua+dGo9k=;
        b=kYlHJ6rI3WvtSemmIDEQSfDQp6pvgQw6ctqJsI13pzGiEFc2lRTWInpwgGhavl+HrU
         ohR5C8V/OPaFSGdMqM3EwUWtGZWczgl/xEV72onxQI7ua0V7JuCviBT1ClfqgTM/0Bbg
         2NgRbW36T5HYhSRDPHOKGxjp7J4+wRWmuewRBdwS4KPRLnj1CgoFuqJHLGaJf3/fzDq3
         pIjefJ6l5pt2DUjJvl96SV4SFMZgSB9vrxpDQEYEASi+tJQJQwQbfOHxKzOxuCRXgo+3
         j9LQgQT3hxNl/ucja3hkguA8CUHXPzQzuKNfEQfHKHyfDv1b1h3LfScV4OP/0tyg5UQR
         MTlA==
X-Forwarded-Encrypted: i=1; AJvYcCUF66KgevvZjdZA2Lx08AqYfYkR2KUDdRrPZyym2we65+7/67ywCOfFzik1fP1UE+Sz6dOOfc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5WQ8tz6W9Cd0liPbX9pIXoFgUgeKdyYe76iw65CKmuBGxIco
	46Mhahsf94Jsha9tKiN4yqKHZcU7tMD8RD7VIc56VgqNKpxE59Maoo79evTaoNvDte+lgK0TeDU
	v/Qc5HvqpWD+8KNv4EpfTsqDkJXAanQrJsjdRfGgu
X-Gm-Gg: ASbGncuMmYddKW3DdP1VJlwX7YCNiELEL3igDN0CqV5kHDpwnEtkOlOwzKirx/hay5K
	S4J3FnTF6zR4bSHpizwacfVILzISt2VYqaeSsnPuLnT3Xu43QT//ye1vJb7r6hBEyyz4+ch2QsR
	bgLZkAvT5ydf2icOg4PGNaEs5o1VcGowqVhJFW9N+5diqWA82c6UWdiMEi+c92EwlhUjnBKFrz5
	pjZ/E8=
X-Google-Smtp-Source: AGHT+IEyzi08XeTn5vtsrBUVc+WQ6eg2WLYEjcj1+505bJfFmcAvOomjYk9CMbJMEJlInvGZGh/hRwbgIebNhh95Wbc=
X-Received: by 2002:a17:907:3d9f:b0:ae3:6038:ad6f with SMTP id
 a640c23a62f3a-af4c1e271d0mr38744666b.3.1753328171829; Wed, 23 Jul 2025
 20:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724015101.186608-1-kuba@kernel.org> <20250724015101.186608-4-kuba@kernel.org>
In-Reply-To: <20250724015101.186608-4-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 23 Jul 2025 20:36:00 -0700
X-Gm-Features: Ac12FXyoxqEq_sZc0QFlR2lv4IKRdfkkNgKghhm-Gg-_EQrJ4fZlVHY-prQL844
Message-ID: <CACKFLikqObM2A6vDs2+ixq3pvJScdCGV+VkqubhxR6pmYw2TFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] eth: bnxt: support RSS on IPv6 Flow Label
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, pavan.chebbi@broadcom.com, andrew@lunn.ch, 
	willemdebruijn.kernel@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e208dc063aa48629"

--000000000000e208dc063aa48629
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> It appears that the bnxt FW API has the relevant bit for Flow Label
> hashing. Plumb in the support. Obey the capability bit.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - update the logic to pick the 2 tuple *OR* the FL bit
> v1: https://lore.kernel.org/20250722014915.3365370-4-kuba@kernel.org
>
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com

> @@ -1662,13 +1664,18 @@ static int bnxt_set_rxfh_fields(struct net_device=
 *dev,
>
>         if (cmd->data =3D=3D RXH_4TUPLE)
>                 tuple =3D 4;
> -       else if (cmd->data =3D=3D RXH_2TUPLE)
> +       else if (cmd->data =3D=3D RXH_2TUPLE ||
> +                cmd->data =3D=3D (RXH_2TUPLE | RXH_IP6_FL))
>                 tuple =3D 2;
>         else if (!cmd->data)
>                 tuple =3D 0;
>         else
>                 return -EINVAL;
>
> +       if (cmd->data & RXH_IP6_FL &&
> +           !(bp->rss_cap & BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP))
> +               return -EINVAL;
> +
>         if (cmd->flow_type =3D=3D TCP_V4_FLOW) {
>                 rss_hash_cfg &=3D ~VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4;
>                 if (tuple =3D=3D 4)
> @@ -1732,10 +1739,15 @@ static int bnxt_set_rxfh_fields(struct net_device=
 *dev,
>         case AH_V6_FLOW:
>         case ESP_V6_FLOW:
>         case IPV6_FLOW:
> -               if (tuple =3D=3D 2)
> +               rss_hash_cfg &=3D ~(VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6 |
> +                                 VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LA=
BEL);
> +               if (!tuple)
> +                       break;
> +               if (cmd->data & RXH_IP6_FL)
> +                       rss_hash_cfg |=3D
> +                               VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABE=
L;
> +               else

I think else if (tuple =3D=3D 2) here is more correct as you were asking
earlier.  Here tuple can be 2 or 4 and I think we only want to set
this flag when it is 2 tuple.  This will preserve the existing
behavior.

>                         rss_hash_cfg |=3D VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6=
;
> -               else if (!tuple)
> -                       rss_hash_cfg &=3D ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV=
6;
>                 break;
>         }
>
> --
> 2.50.1
>

--000000000000e208dc063aa48629
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFA5fN2nsvtcijqf4CMBV5xcXngn9Svh
CCPbiaIW63GaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcy
NDAzMzYxMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAK7HgxaXCUU4TKZ1NSxt7mBWDw/PeKJ6GpetCFQBqU8GumryD6kf3TEFHeIOMJlTI7Sy
c3SLWLpJkzPXdjzFeC+Gl+UqPbs+BcXBfIDoQWEscAyNdV71Q/aUxtSCM+d5gxkoEMY2zyn8T+tQ
yEpK0ReohkBaalIDtrSh5lYjN2Oj/7+GO1v99pE7Xr6bSVIuhCR655jbfc/O5A3m/TyrdjvKCf8g
2qS9TgUS+8IgjmD4llUnEn5LQgjChEDQom7YbmMGwBabgGZbxoH/hy7wiAa7HrP48HA0YBd6lKFb
ExiLUkuxED+6kaCeSMcE1aSvZUZtb4VsIcgYzQn+8eqeDog=
--000000000000e208dc063aa48629--

