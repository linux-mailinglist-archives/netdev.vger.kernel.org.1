Return-Path: <netdev+bounces-102724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B890460A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539891C22738
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D81534E7;
	Tue, 11 Jun 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LdQLGz80"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8727D086
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139712; cv=none; b=VfNaJ49nJQWlXXnvge6kJugWWBuo04mKQyQmf7d8dEiX6Ekzc7K3WmVrd1wWAp3riIjP+0MP78yb48pzPnG+y0vfZIho0KbU+/0j777iK2HrgPF7As+UXW+RN7be34pm9Rnfe3QsGIqOatDIbBdeI7+xO9GaL89I0RU+Po6fl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139712; c=relaxed/simple;
	bh=w1KluxEs1QV1PvCoK3yunkb1Skj3UpOBxumCDFI7xwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF8qL3Dr6c9xjn0iW9kbSI8yFkziMxA/kN4HzEOw/zrAjmtNBiCaZC2gUIQUcF5KUKymk/EwoxWu01dlEKKijzVCBIONs30cuJq8WfOn8yuuPoYxV+bp2t+5WZDuZfbBHIPnv9VSsApSkAwKROK27c3ufy+H8U9+szdad+PYh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LdQLGz80; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebed33cb67so17203241fa.0
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718139709; x=1718744509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=31LNO7PEmgnOgIxWP1h2RhA4vdcED+tZG4Ps/lFnMxU=;
        b=LdQLGz80ACF8j7E1OWZvZXrFn0cl1FScvS+QIowvX2h8BFx5UAvhOTIRWhSiWXBbfC
         +sx3lmfBF5BDdL3Ry6fvoIB6NpyuEQleSZdmkuvra+U31fA1z2IPeyxSUZAp1iAwa+FJ
         9+UrbnZdAcDnER0oKyNaMTCQWpF/Lu/exQt9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718139709; x=1718744509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31LNO7PEmgnOgIxWP1h2RhA4vdcED+tZG4Ps/lFnMxU=;
        b=sZsY7w1BxcAa67JhsmpbIFnWjQxawb6J0+YPdosVDy0C7YpadBq+DbCFpIM5G0AHy2
         cJ1z+q5vZVyuAvvwvA7Bp3M9sQy1RTaHUnmApVhtwHuH4Hsi0A7VyQWI00loz1FnpcxY
         8V3Ai1QUrwhzPuya8fDBNPiMVt8KDLc/JKNBSnf/7GUjZLa/5ozcAj99usAqShLynbcV
         IKlA9hiPoClZZiIngoNdWYMGclCFJTTq0gLNg95KK3YFiJbZpM9C+UlvWg/EqvvjKSTo
         FvEgEhGbcM5aqV5KdzIzOi2uUQZKyCws/8/ZZn8EzdiL/lrUMlRz1kUi0VJSVOSM3pLC
         wlHA==
X-Gm-Message-State: AOJu0Yx8NAQoLrScf04XuAGW/RwH2ma3pdjDGHWL7bngS00MYfqL0S4L
	Nl+CwqhguPMR00d0M3/hoQxsGz4b/OZ5Dn4K8tdSJ1EZOPON24OyLtjhL2q4xDwyrR5Vq1bSzct
	MPhI5mpfnxHMZrCSvznXREjqh36lnKBUq74SX
X-Google-Smtp-Source: AGHT+IEBsOOwObBSa6yIknF9yOOBT+CcJBhse7oVVUBJwHUpcgxmxqxlOMDOYZCbOJ//k8ZjQDbTph/El89a4QllFU0=
X-Received: by 2002:a2e:740a:0:b0:2ea:ea79:4fa3 with SMTP id
 38308e7fff4ca-2eaea7951admr74429491fa.28.1718139708432; Tue, 11 Jun 2024
 14:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608191335.52174-1-michael.chan@broadcom.com>
 <0cece70f-a7ae-47e2-a4a2-602d37063890@intel.com> <CACKFLikFP=xCKnZC_V+oEeFeS-i7PAKHmDFgZKBy+Sb1rKuTkw@mail.gmail.com>
 <CACKFLimMfDTatETF+iTWkCBhVH80O=SC-u066XsREoQgVEmmpg@mail.gmail.com> <37cf9088-b050-4788-b870-f28f0fb58b9e@intel.com>
In-Reply-To: <37cf9088-b050-4788-b870-f28f0fb58b9e@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 11 Jun 2024 14:01:36 -0700
Message-ID: <CACKFLimHuwfwNcbFqGTJw1V62z7o+xfFJsTZvOT07uheDbEKig@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew.gospodarek@broadcom.com, horms@kernel.org, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000dc297061aa39387"

--0000000000000dc297061aa39387
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 4:10=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 6/11/24 01:52, Michael Chan wrote:
> > The #define within the struct_group generates a lot of warnings with ma=
ke C=3D1:
> >
> >    CC [M]  drivers/net/ethernet/broadcom/bnxt/bnxt.o
> >    CHECK   drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c: note: in included file:
> > drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h:4211:9: warning:
> > directive in macro's argument list
> >
> > Because it's a generated file, it's hard to make the drastic change to
>
> is this generated as part of upstream build process or just manually?

This is generated internally for our firmware interface structures and
definitions.

>
> > move all the #define macros.  Maybe in the future when we restructure
> > these generated structs, we can do it in a better way.
>
> You could also just split struct into two and combine them (packed)
> into hwrm_port_phy_qcfg_output and add compat one as combination of
> hwrm_port_phy_qcfg_output + valid bit

What I tried to do was to use struct_group_tagged to wrap the first 95
bytes of the structure.  No changes are required for the existing code
using the structure and that's the good thing.  The new compat.
structure uses the struct_group plus 1 more byte at the end for the
valid bit.  This works fine except for the warning due to the embedded
#define within the struct_group.

>
> If you don't want to do so, please at least document in code that only
> the first 95 bytes match and the last one is different

Will do.  Thanks for the review.

--0000000000000dc297061aa39387
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDKKZrWBJS6fXXIBwisJ/E3i/Od3o3sD
eF5mSOtGro6lMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYx
MTIxMDE0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBB5EliNyxGyCm7bL8BNgx/3Vz3iZ31l/w1+rUe2CIVo1tEECQc
BkQTtM5xf3KbenS/UH7YBIxuc3li8UUz7jzQIvE4ZubunD5wbFNrCkDxW9ETtr2Q2g05H9wcD8Oy
O5h2NEIb/pLTjJuZHHHwD63TC2vwGAfQnjlIQbA2jVzXrgEGdMbEtoTqIxYfaCEtXcX+39iI6TBT
XAY3IwtHe6k6vhdbL/pqfwYdKNt8pxSawlbiPlRue1YzxqhPzlenD4P4IXbuMVFIFZ+/GXE5RRLY
61RsTyt2qVajBuLBB0K/BytmaWxYSKuasvNQql30pymOOJsrRc7Mo2HmJJBlVm4C
--0000000000000dc297061aa39387--

