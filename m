Return-Path: <netdev+bounces-102402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AF902C9D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84BF1F22BE1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B3415250D;
	Mon, 10 Jun 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KEpRQOHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43C15219B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063537; cv=none; b=oO0Yeq2JqahoJ/ujF4+4Vg9vnVthufLcryKe1u5suSIAyi5cTr+Y+89FjicVGDABjD7QpOSwwpuvFQLclSteFVl+TySukYKBnj4IA1dK829gjWwHUvYkUNMrb1Uq0Cumiw2EuNndnyksQHl2zxGhRXBGlG1stmOBDWFIOgJNNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063537; c=relaxed/simple;
	bh=+LAJFFfKMgAjmGa8uVmrcaX8qfw78tha6ko8HsIWlMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+ro8MyRlHEyYw0CxKm2InQoyN3ybfM2vCss9XUINFpU4p4VjnLHwRv5nQfs88FFZaCAiJprYopuAC+pHVwP9/Bd7onzFwEh2xOzKP+L4f/KiA+Ns5mRMt1cmArvYJe0tdKnewSWR3GZDWowQv2yg3Y9ksdWP1aHVBpOEqBFY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KEpRQOHS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f06699ae4so117193166b.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718063534; x=1718668334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlc2/mQpPWLQsfx1XdcEC2aE8vUJwQJdU9zqh7a43gw=;
        b=KEpRQOHSPtYeqN+FwPWy9PVRAOk4CN0am0X0TITdDebUi6NuF9QjdHQKeqYBhHDgfc
         e2zVx5Bis7KbsEnVtYOhBTebssaI38MZRj96VrAcupojWmZF5riKD03YKzAyHVJ+FqGw
         eUQkt5kzHVza0unhqEsF3h7i5HcupezHQxoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718063534; x=1718668334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nlc2/mQpPWLQsfx1XdcEC2aE8vUJwQJdU9zqh7a43gw=;
        b=o2Z/HZwpeusV0BYrTSf6Xe7TGs0F7RDx1RMHakGWdH7rCRsW/CKmywKYR7zQmH4AKr
         /o225NT4I008600Pb9Nq3w5xPSTMDETqOWvQY9UvU/qHKPia9Z2dyczEfMqmxogV8Ax+
         /HRpbF/Tqrm/W43RCy+vGo+t3QkO5LL6kldFhYfe/5b4LOVTzDUC8OTQFMj+NAqDYeUh
         0mBC7oGW56mHdg0ZwGjU83QzNShDbgKz1KrZjC9NxcwWATn6cQ3JBevC2wJ2/EHJpEtL
         z6A54WbC0W5FlOrXGo2rKY4qAO6vULmx7iwk8Lk2uAJfbUkI1sQsguMmyUkJ0SgTvri7
         j2Qw==
X-Gm-Message-State: AOJu0YxyufeN8TaoawE4eZm6/z6s8SpFjSjDApuSfd/71njjr+BCHN8R
	Amj6CJqzmkt4Nn6cKZ3Z1mDTVO/S80F/9Khql2Ty8zFOybYvl82bADUa3K6nGKvTbuEUzHsjI7e
	M+2QbkS4illv3SMKCzcYPrdJeE2ezyYw+b1kNE1MW7R9gMqKbzQ==
X-Google-Smtp-Source: AGHT+IFX2JCWsib+CZYuWqEXuLEvsQMs8uCQIc7cVoXoOgaP5yAbXMIFA/RXuX+oDXwdY1wFTGbleEuWxO4ZHkO5TNs=
X-Received: by 2002:a50:d591:0:b0:57c:6fdc:4cd7 with SMTP id
 4fb4d7f45d1cf-57c6fdc4f3bmr4842366a12.4.1718063533748; Mon, 10 Jun 2024
 16:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608191335.52174-1-michael.chan@broadcom.com>
 <0cece70f-a7ae-47e2-a4a2-602d37063890@intel.com> <CACKFLikFP=xCKnZC_V+oEeFeS-i7PAKHmDFgZKBy+Sb1rKuTkw@mail.gmail.com>
In-Reply-To: <CACKFLikFP=xCKnZC_V+oEeFeS-i7PAKHmDFgZKBy+Sb1rKuTkw@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 10 Jun 2024 16:52:01 -0700
Message-ID: <CACKFLimMfDTatETF+iTWkCBhVH80O=SC-u066XsREoQgVEmmpg@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew.gospodarek@broadcom.com, horms@kernel.org, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ad70da061a91d619"

--000000000000ad70da061a91d619
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 7:00=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Mon, Jun 10, 2024 at 4:38=E2=80=AFAM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
> >
> > I assume that the first 96 bytes of the current
> > struct hwrm_port_phy_qcfg are the same as here; with that you could wra=
p
> > those there by struct_group_tagged, giving the very same name as here,
> > but without replicating all the content.
>
> Except for the valid bit at the end of the struct.  Let me see if I
> can define the struct_group thing for 95 bytes and add the valid bit
> here.  Thanks.
>

The struct_group_tagged() idea works in general.  However, the
hwrm_port_phy_qcfg_output struct is generated from yaml and it
contains a lot of #define within the structure.  So it looks like this
with struct_group_tagged added:

struct hwrm_port_phy_qcfg_output {
        struct_group_tagged(hwrm_port_phy_qcfg_output_legacy, legacy,
                __le16  error_code;
                __le16  req_type;
                __le16  seq_id;
                __le16  resp_len;
                u8      link;
        #define PORT_PHY_QCFG_RESP_LINK_NO_LINK 0x0UL
        #define PORT_PHY_QCFG_RESP_LINK_SIGNAL  0x1UL
        #define PORT_PHY_QCFG_RESP_LINK_LINK    0x2UL
....
        );
....
};

The #define within the struct_group generates a lot of warnings with make C=
=3D1:

  CC [M]  drivers/net/ethernet/broadcom/bnxt/bnxt.o
  CHECK   drivers/net/ethernet/broadcom/bnxt/bnxt.c
drivers/net/ethernet/broadcom/bnxt/bnxt.c: note: in included file:
drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h:4211:9: warning:
directive in macro's argument list

Because it's a generated file, it's hard to make the drastic change to
move all the #define macros.  Maybe in the future when we restructure
these generated structs, we can do it in a better way.

--000000000000ad70da061a91d619
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGLwquGjpRrc17/dvytB+7xt3vtE2+V2
zVnWOKgxBXu1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYx
MDIzNTIxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBVHw6yS2MbnO+2GofgufhIrERibsB0JdIOGdpXwG4GxzWJANq4
KHH7mOGGSx/0bFuldqRwy074dd59UjThdTmyN9o3+UDJE5NpF1PB/r9pyNFaYoTR5dbIHpNY5tH9
TpLzYanYWGyxax22tezPzOE+em0hDS/fvYLmM4ZW7mdauJeB1vI5Tie3s5d9PiO9Cde+mRu/OThx
fP3Yir5Tc/7k6mH3OTyP+ZY54eMqMBmQ7VFQpoMVz6/6FoMOVQM+R+KxbiZZf63Ej92AHMedXsjG
pBz65plVaNToxz8bt9gLAnGZTDYSPOBRjBt0Z3rmuJSZxywEEplFVDhK2J5tK2Um
--000000000000ad70da061a91d619--

