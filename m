Return-Path: <netdev+bounces-167898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6774A3CB72
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3916A1896649
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A2257444;
	Wed, 19 Feb 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c5qw3aEv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C3257431
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000540; cv=none; b=cK4svdRNUAXtNpbxR5faCOrYhD3+prCxkVQJKASsdd3KLjWqCK45hlwR3mvFdsNqxz+4xUAnfKp/ObZRgm9YPJbFQ2Bcv7U1qB08vSoNkkAnNWXdubNlrVQtODBInTiUQoazf2+YbLgkNLqjbtPlMVuxXyhsDDJHrLiLn3OEdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000540; c=relaxed/simple;
	bh=eYY7z7OqmI6osnbmFwYX44XMxYVa28H4chOmP1G8OVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBVRYW0P0e91kw6jy4r54aWy/eEpBUjmzwORSI7IxZKg5ecTn5Ae5tFMupIHwQU/vm0fignilJ3KCZA1OK/OSlDdtsVWpHp9npSbwq5sS9FzKqeC7EApMWsiNwmhwzMsOIQlY4BTryf+44b3T7WejMBxgH5RCbAI+Nyr9aIuhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c5qw3aEv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso52664366b.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740000536; x=1740605336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CBcGbyJa7k6MBhctkHAR3CTAwrQQCdvGVR1Vqm1HAf4=;
        b=c5qw3aEvnOFbHu7sr0IWJ6GLyIrw1YwlmdmgetwRSstKd04no6vjGFjqo7kDzc2eaT
         /F//eVepjKexYsq/BtNGh+IYcV3cAwja61lkn89CRFbmLnMm43MzBHI5vvRNiG5V64Sw
         nO+6JhRA8e7l7lcyXpKFsEM9tGMDJLb+OWtnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740000536; x=1740605336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBcGbyJa7k6MBhctkHAR3CTAwrQQCdvGVR1Vqm1HAf4=;
        b=KZ0fXPZeuk1AdjE5zkjYzMO+FvunfZ9Taxl+80d9PA8D5j1HNRyBpm4cxnLMvZKQ9s
         XuOnmEcQSPkCI005Ok7cQ0qfuydWIfnTuLinHESPoyNyFLbo/b44R/OOP5EsbbgI4foQ
         NdLWJPAe8AOqiqcn6MR109P5Xq/zlHKvHi+8WhBZTXv1edgyLjkDK4XU1Xc29CYX7J/m
         ANtFBRbKrtrdpvFqxB9tQIXL2Sd8Of2jZMLWIzK3njCcGVBoXDhkQmkK/wWxD9HWJsxg
         lGvw6fPzFK7GuI9uU5pAwgz3CXat/maZDUC6D1ZvknUbj32B/u+rCCz74uBd7FLric9L
         HnbQ==
X-Gm-Message-State: AOJu0YwiL9kExxiZ9GWWBb9Npld2rN6bUb9Ybfkov1dkxeF4XqnhvcIQ
	ItbEPavAwTAj0suuBt01QSWZetE5NPHTtbfatpZSm89WUBNINSDhCrRmol55n/SwioEJnnuFDcV
	U5QbLGHOYkpCoJW6Ky7WRPWxobmEOgUWcpjXd
X-Gm-Gg: ASbGnctSLUXKkdY3XDJxCsTD/tvFVklTegU5E0AAgszYQYtzUSZNV9fGbxpYk12nd6W
	Gf5ZgdZm3/uS5Rh4cFFn9XIPdOOnZHmKzsQ/dBAto50OKV160A8hA2WalvgwnZotdbc/K879slw
	==
X-Google-Smtp-Source: AGHT+IE/Adj8YC98iFwR3c+pTYuAGUKVVnWHrIa+Qp+e1mrGfRCFXSTVTEVkkhkoTckZ812Wztuu12P2ZF+1okdndZA=
X-Received: by 2002:a17:906:c154:b0:ab6:d547:da9b with SMTP id
 a640c23a62f3a-abb70b353b2mr2126002566b.23.1740000536255; Wed, 19 Feb 2025
 13:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219202719.957100-1-sdf@fomichev.me> <20250219202719.957100-13-sdf@fomichev.me>
In-Reply-To: <20250219202719.957100-13-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 19 Feb 2025 13:28:44 -0800
X-Gm-Features: AWEUYZmjjPmqtUwGwDSdEbny7WCumsWnXNjDatj0bhp2z3aAWvR3Z6nnmgMUwqU
Message-ID: <CACKFLinkP2aakfuBP7rC0Z28qb6jf3_WKVS5W8Q5LPmHZAum7w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/12] eth: bnxt: remove most dependencies on RTNL
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e45b14062e857175"

--000000000000e45b14062e857175
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:30=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Only devlink and sriov paths are grabbing rtnl explicitly. The rest is
> covered by netdev instance lock which the core now grabs, so there is
> no need to manage rtnl in most places anymore.
>
> On the core side we can now try to drop rtnl in some places
> (do_setlink for example) for the drivers that signal non-rtnl
> mode (TBD).
>
> Boot-tested and with `ethtool -L eth1 combined 24` to trigger reset.
>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

A typo in a comment below.  Otherwise it looks good to me.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

> @@ -13965,30 +13967,30 @@ static void bnxt_timer(struct timer_list *t)
>         mod_timer(&bp->timer, jiffies + bp->current_interval);
>  }
>
> -static void bnxt_rtnl_lock_sp(struct bnxt *bp)
> +static void bnxt_lock_sp(struct bnxt *bp)
>  {
>         /* We are called from bnxt_sp_task which has BNXT_STATE_IN_SP_TAS=
K
>          * set.  If the device is being closed, bnxt_close() may be holdi=
ng
> -        * rtnl() and waiting for BNXT_STATE_IN_SP_TASK to clear.  So we
> -        * must clear BNXT_STATE_IN_SP_TASK before holding rtnl().
> +        * netdev instance lock and waiting for BNXT_STATE_IN_SP_TASK to =
clear.
> +        * So we must clear BNXT_STATE_IN_SP_TASK before holding rtnl().

... before holding netdev instance lock.

--000000000000e45b14062e857175
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICKOCI03V+Zdl+g4IwLL51HuR22c7ei1
0Z25qXaapqMVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIx
OTIxMjg1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCPVtioDGHSQRvoLjlWwpda5av8RVRwZlw3niJzTsikygPHHSGc
aFjNz6htD281IK7zALFeIkjahas8qkblL3WNWOjHvr73+SfMHLvBkaRHNJSahOFvRj0LOr4F3gt+
imELC5sFIwF7C4kP84c1iEnDx2NhLFjrIUma3vD/F1Uj4K8am8kWFISh8kUK1akEZSUtsdJjWUM7
fnxdT6YAS305PsqAt0S9+VKD/XnDYYNAg/hTK9GUt4/MiZT+C9SxFF85CUATJFkLx3Y/6vyEGNEl
J+Px8+QnS/Ws2xvRo2QySFgvuKEgnmxMRPLMawgmuwBQGAWK+kpXoAWJwjDWGe7Y
--000000000000e45b14062e857175--

