Return-Path: <netdev+bounces-214697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73212B2AE9A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007DC1B65F93
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FA3203A2;
	Mon, 18 Aug 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nt1fwPBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6D27B358
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536214; cv=none; b=pyODKFc0ivj3y8uVN4qUNDdq1rlrVDjunq803IVSnA/a27eVTwFZCkvm7949gj66U0KsaJ/qsGHvMEDbwBDtaWQjVw/urjjWAD8obJ+VBAm0FSzvb2tw2tLH9vT+PX5agKfktMPcwxUuCVRbIPN1W5KOYnBsYFyrC9+HpVYsdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536214; c=relaxed/simple;
	bh=we/BJvAeN7lQ0lJvzBeVCtYDn6sQusuwMGvQtALChtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgFaY0th9zSKvSaoCU8zZNyy9lAmxq1WSa6Hl33qpPN4eiKNzXvi2WO1465ZsRsuIcKF0ufAMM+cIKKiJJjExts9CQ6JJkf33SXJ6gWYQZJoYQEonhFLMcnwZdnAw9kzq8GIaDZQmTr0wA17bLkWhIVx27THCKJbkEpD6fvO4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nt1fwPBL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so5573900a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755536211; x=1756141011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pDEE8WjLroaAuEtVDjUxNYlE0DAVkBUGW6VOfByXGo=;
        b=Nt1fwPBLf/TwimAJqehhpwDpCc/aQU9Jr4ZkQDAMm5BtsykrtJ0jHahvVRm9BCkZv+
         oIPEcYIZR6jPbkS9hdC+D5Sgnv8oIMqy2v+IQR9bgDSgv0BGev5OlQ2/mVVYEIGRkqNZ
         VlUqVxN+V70w1sbE4Dkn1gde8K1V0yUa1DmlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755536211; x=1756141011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pDEE8WjLroaAuEtVDjUxNYlE0DAVkBUGW6VOfByXGo=;
        b=a08IIzcDsIM9lMARuXhzmN2COFB6cOke0AO9udm7Zsfx0b0Jhtyizzf3OXnkicNl2e
         qfIsw5ToyerV62Jj1QiywT+WqJaI/nwcjCjLkpBN44uRlhwQfocF7bi0P9eBLz+sYCt3
         BAuNtHzStsEDAGUlOJKSgnTtemH6jfFOod/CIT87tKc2e4J+AHCYlfzsokB4mSmeE7ec
         fhf3DUKVdlckeEgZrMMM8n9YiWWJKr13LoC+T4aV28BK+pKs+JIu+j8i4cg3DAFzhTdY
         tQkcZEOWd6m51+9rkedYCe6a7ba3gUAv6gCyysvBsgeDDATosKMiEagfSU1sxJYOaX00
         adew==
X-Forwarded-Encrypted: i=1; AJvYcCUCzMI2Yva4AeWBU/rJvQzW6brekM8RflB7ZO+RbPcD2yrUArvrwy/5ocK6QAE/wTLaWAVsrSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRi7KQOCGOvqL9hlbx+vDxxMoBwyuvXmXVGDSAFsaDX4ejwTJ
	9yAJw2MAy6hAztNNm6VBoTpmY5ZPkJkQOa2a8QenLBiFCxocvUH7k9s7FJhb6GETZ0jngpv7tME
	5bP82U3L+lANqgkV6iGB6CJJX6273K3pZAnmgSFV3
X-Gm-Gg: ASbGnctlHFT3HdzLq9/4F67EeTkAFh3X6BmVhASkvz130zEmcKLumxyOi5bKqbN4/lt
	Omc8qoCNQE5lbT2/b/dfVPtewzX3h5V3YgjnzAObHXroXRtUbR48n8NBGDsOxAdESENmrbo048a
	D4C37QF54kCYPzUcxVt8Mql2/gkq69WGUblNwW5GCxZJI3JhINrqHuE+EdNLuwnr8n89d+diHXI
	8dkykJV
X-Google-Smtp-Source: AGHT+IEdSTYT9JHNTeMfbH+5mQKqPAmLPF1ne4k63/9UVz0pPtN0GxYc1ox5SECC1U0rzNtl7Mg8s81H0o+0g2mmXCA=
X-Received: by 2002:a17:907:868b:b0:af9:6065:fc84 with SMTP id
 a640c23a62f3a-afdd99358ecmr12140766b.27.1755536211165; Mon, 18 Aug 2025
 09:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818004940.5663-1-michael.chan@broadcom.com>
 <20250818004940.5663-3-michael.chan@broadcom.com> <2b711a6e-23ff-4859-b572-fdcab8c4a824@intel.com>
In-Reply-To: <2b711a6e-23ff-4859-b572-fdcab8c4a824@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 18 Aug 2025 09:56:38 -0700
X-Gm-Features: Ac12FXxIV11WSde2mib2NKUGcaBbJ3LRHG11A3snPJxxyc_WW9Ibv-SrQVSqQ9I
Message-ID: <CACKFLikfBJGf7PzayopO5r-gNfM5BMFLvv2omxikKEdRq3fHug@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] bnxt_en: Refactor bnxt_get_regs()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Shruti Parab <shruti.parab@broadcom.com>, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000047c7d4063ca6a0ea"

--00000000000047c7d4063ca6a0ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:56=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/18/25 02:49, Michael Chan wrote:
> > From: Shruti Parab <shruti.parab@broadcom.com>
> >
> > Separate the code that sends the FW message to retrieve pcie stats into
> > a new helper function.  This will be useful when adding the support for
> > the larger struct pcie_ctx_hw_stats_v2.
> >
> > Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> >   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 43 +++++++++++-------=
-
> >   1 file changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index 68a4ee9f69b1..2eb7c09a116f 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -2074,6 +2074,25 @@ static int bnxt_get_regs_len(struct net_device *=
dev)
> >       return reg_len;
> >   }
> >
> > +static void *
> > +__bnxt_hwrm_pcie_qstats(struct bnxt *bp, struct hwrm_pcie_qstats_input=
 *req)
> > +{
> > +     struct pcie_ctx_hw_stats_v2 *hw_pcie_stats;
> > +     dma_addr_t hw_pcie_stats_addr;
> > +     int rc;
> > +
> > +     hw_pcie_stats =3D hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_sta=
ts),
> > +                                        &hw_pcie_stats_addr);
> > +     if (!hw_pcie_stats)
>
> looks like hwrm_req_drop() is missing
> If that was intentionall, I would expect commit message to explain the
> imbalance of old and new code for "refactor".

The caller handles hwrm_req_drop() for the success and error case.  We
will modify the Changelog to make this clear.  Thanks for the review.

--00000000000047c7d4063ca6a0ea
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIM3vh1mGGpDbF/Q2x+wRuE4N2/hsFn2D
5J6/wKQ6S2TlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgx
ODE2NTY1MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAHWd+SVKwFr/h+EAU82EaqypX6q475akY9un9jveGlFQCEPGocz9ANwSmjJMKAC33B0b
AnvE052pm+MVAwMb+Qk24DLOAP3HucGER4EHVPQVa6coNwHDL2ZHAPG6vE7mIIFWbx5G0ThZUrlR
QCl1ysSCYERtQ2+8S9YcndVSi2N4oqhH3ocyt/yKguDpF5796cuuyuu0t1oE+Yyc/OpUB6vkySKK
PiNWCayH0WYfR8TXVg09SrbwNcOS6N1Zg9pwY60c6f7baL+CDIhIkZ++QIORiUm9fJODZOpBQ91a
DIB/qqp6f7jXVdWP+XpdP8ztHEA5xux6RIB6cl2mT73GQ9I=
--00000000000047c7d4063ca6a0ea--

