Return-Path: <netdev+bounces-230425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B81BE7B6E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E165D35BDBC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3330FC35;
	Fri, 17 Oct 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AUDk0xpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460241ACDFD
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692559; cv=none; b=FDSh3/F6TeDGiSKS16Wje2xfDBteOPge68Ipp435Ye4YR6hIWEtL/kDZErilJqzETc//qKsA8HSCRc3HEfT4M7lmMB7PJyFoT5WAqn1tSQtxJ37uwH2AvXTD8W+Gzn6qGPMwQjntNqnS1r49CmfMVinYik7QXx/FoFeu1zTrL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692559; c=relaxed/simple;
	bh=p2CYOpCP/qzhgG8L5LD0jTkkgbHo2KUIDnlp4IL1stE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FE/gJA1fM7vmjqEx7O+CUW+ldxGOFW7itVu62BtZplEQFYwJZr1Y/KaK/DaC2xn5wQAfBGyfA3NUVRoC3ya3/0d3EjuPvDZZCrASidk61elbEMWf24bnIiBKT+1C2Lk72cb+SReIqmh1eCpG0Vt/xa3wXOpAiZpmIaaf4pEw5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AUDk0xpq; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b609a32a9b6so995814a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 02:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692557; x=1761297357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p2CYOpCP/qzhgG8L5LD0jTkkgbHo2KUIDnlp4IL1stE=;
        b=Hf0L1/NBh35fjKPcvsGQv+MfrDJT60zPptpdu9NBTESL3kmLOsZIOFNZahr/DfmGdl
         d4gq3oiW/Y0HJv7h/CPz/VxMQV1duNcRYCASI0s6Z+ZVsKepncicOvU7Psa58Mj308DV
         jYsGcqVnn5hN8RL1alQvZ+QboC26ajK/kwNOvuOMWEJtLkDD7cjfTyXa4NHBnwH67i57
         6R+fMfCQQ7ZgOqxxkVHtMjHZB20PN4GgS30Y0/lpK9ZDLCm1MfvxEYrQpk8wJ6hUq9FU
         OkwfGIr+7uYodvtXrqfjIj0m5j23jcZcy7UZ4K8oKBWC2OJg+T/lZAHlliKVJWcgKN4K
         aHNw==
X-Forwarded-Encrypted: i=1; AJvYcCUAUWBBCmXHOBS6nWls4mQVVeyv1K+AjgZM9Z86D/ADlC0EaxTREz9TAm9dOX28sjbGsJU4asU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6A5hlO7JudRqYjgsqusmApRUquJbkmc2baSdDNyGh01hIjLSB
	xyL8Gi7yexYE3mRZR3oQL2ttPr2sIet2/tCQKFTPxd4mueGhAQxyxmK+OBEWn4VoZXoKKjFyQN/
	RcJKmLYRT2OFgoqqdNlpOvlwFApdBQrexCPytdpz615KFC+71JRvIkwRgzHLRkuzdKrI8cHvHzH
	wpXS+vswEvjykfwwD/SGY/0exddFDJfXrAbvQcUF1+Up/wOA2cilaHWAbtJ5ZKfQrGOlyqUsddN
	k8ph7CGubRNxQ==
X-Gm-Gg: ASbGnctc/WwA5SWtLDoAuKpTcg6a4MZO4q6P3KzUSw2k1y8lj6DqBmGsGuBJmB5aXBq
	FzfnOclKFbZ8jOkhHGr4UKTwLSe8CA8ifDp6rDPE4nj7MhfpsidiuizOqrlopxgHY6xNzowXhgG
	dQuLzqSD0yZryrd/6kvNhv2hZZiJWaMOeynIN4U6XVT9JH/qfgpaSwF3Ey43yTvvzmu9sQxkW3F
	sufqCVZj381Oubx377UFUSHw1YpIQNsQfXaaDukn09QL+wYQNALUKODBFV8V+rSueKeQ7tl7C/C
	+c9Uj5pAbm2aPwIVgcW1X5H6h3FtGKq27+yflK4YKVk+KDNNzCqldhREYCiu8bZgaLwogs2GJaH
	FNPpyKROGDIsTNgNvQYZMPq/pG5854uUaV6tmcSyGEETzvlhCl1kWkLBgI0neeWORKPs9c0CSJ+
	LgVojYAnFGZZ6RD9vIeraXBPI1DRZhJFe57bHF
X-Google-Smtp-Source: AGHT+IHpRA+7q+njR2/LFzUc8oPs73fj6A9+osqABbtXOzqZ2QMx7Tbn0IPx9V8wasbOMZ2b5q1kRaNWuKyC
X-Received: by 2002:a17:903:8c6:b0:26d:353c:75cd with SMTP id d9443c01a7336-290c9cc30b8mr37714145ad.21.1760692557291;
        Fri, 17 Oct 2025 02:15:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29099ab1cb6sm5955275ad.69.2025.10.17.02.15.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:15:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6ee6so19849575ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760692556; x=1761297356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p2CYOpCP/qzhgG8L5LD0jTkkgbHo2KUIDnlp4IL1stE=;
        b=AUDk0xpqTnOxxOiDZPtxCPf3gKsnHq4taEJtQsthoU1uFGRER4D46sIBa4MwvR0sAQ
         X0KwHpnNRIro2X4dLJLzqsKOiiicfyhgAciSGCZSgZESsooN3rJEFxonbyt1rXNKoYLg
         A593OYFcDFm/RATflrwpwQarYl+QGeJXD01Aw=
X-Forwarded-Encrypted: i=1; AJvYcCUCenzutpp681rLj1dKBfT26YwK0HyeAaL8QjRowMCvSDkBzV2aZLSOPPdHnbF0BR+z6m//nkE=@vger.kernel.org
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr40028565ad.9.1760692555729;
        Fri, 17 Oct 2025 02:15:55 -0700 (PDT)
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id
 d9443c01a7336-290c9c8a738mr40028305ad.9.1760692555320; Fri, 17 Oct 2025
 02:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
 <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com> <20f633b9-8a49-4240-8cb8-00309081ab73@linux.dev>
In-Reply-To: <20f633b9-8a49-4240-8cb8-00309081ab73@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 17 Oct 2025 14:45:44 +0530
X-Gm-Features: AS18NWChbNEGOiNXEl0P-QB9plHsv2aqCXVTbpljafWJs8y-Rbcu7qcZY8l0A8c
Message-ID: <CALs4sv0ehFVMMB2HPqUkGnv5iRW-VYKpeFf3QtRDgThVH=XQYQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: support PPS in/out on all pins
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005ce73f0641572e89"

--0000000000005ce73f0641572e89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:21=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 17.10.2025 04:45, Pavan Chebbi wrote:
> > On Fri, Oct 17, 2025 at 3:54=E2=80=AFAM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> n_ext_ts and n_per_out from ptp_clock_caps are checked as a max number
> >> of pins rather than max number of active pins.
> >
> > I am not 100pc sure. How is n_pins going to be different then?
> > https://elixir.bootlin.com/linux/v6.17/source/include/linux/ptp_clock_k=
ernel.h#L69
>
> So in general it's more for the case where HW has pins connected through =
mux to
> the DPLL channels. According to the bnxt_ptp_cfg_pin() bnxt HW has pins
> hardwired to channels and NVM has pre-defined configuration of pins' func=
tions.
>
> [host ~]# ./testptp -d /dev/ptp2 -l
> name bnxt_pps0 index 0 func 0 chan 0
> name bnxt_pps1 index 1 func 0 chan 1
> name bnxt_pps2 index 2 func 0 chan 2
> name bnxt_pps3 index 3 func 0 chan 3
>
> without the change user cannot configure EXTTS or PEROUT function on pins
> 1-3 preserving channels 1-3 on them.
>
> The user can actually use channel 0 on every pin because bnxt driver does=
n't
> care about channels at all, but it's a bit confusing that it sets up diff=
erent
> channels during init phase.

You are right that we don't care about the channels. So I think
ideally it should have been set to 0 for all the pins.
Does that not make a better fix? Meaning to say, we don't care about
the channel but/therefore please use 0 for all pins.
What I am not sure about the proposed change in your patch is that it
may be overriding the definition of the n_ext_ts and n_per_out in
order to provide flexibility to users to change channels, no?

--0000000000005ce73f0641572e89
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDWEwJO
Iv0N/EMYsqfl9b4EPS10gKi4U9PpAwt7UhoXGDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTcwOTE1NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBvlCi/sRMBMn4jevHWNnRHmTtEhwandEDXVJ1mwyjs
+T7w+1zX3DtuzkA1yH++tPJsrSx0fludsIxSPWQqOYDBb1jbW54rcGhO8uxhEZJs0e3RA8fgO5fq
3B7ooShWkdjEqB1yM7VnF/1CHZZlOXuCQvqj9sZZS/ICO8uvBCbbC2Qs55Vu962Ocuv9oZ6Ek6RZ
xf6QNE+Nhg7KgUHlkBEjL3V0JRgC9eNg39/gQfdFYLelImPsuHiX6swZlr6NCLoXUhSKR7aEUEZD
e+JPUB3YVYZaBURkaZuV8XpRu47LEbk0QFG4IGpkkip0h6vnPRFT29IgJI8VX13PQ9PF/dkl
--0000000000005ce73f0641572e89--

