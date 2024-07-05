Return-Path: <netdev+bounces-109559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185A5928D1B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 19:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C457828524D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC9E16DC06;
	Fri,  5 Jul 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K1LLnh6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62C16DC00
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201170; cv=none; b=YGMCv2H5XXjYoe7fmZAuF+yVlAFeup1cVTouZOAJmphCEwmop3ZWcArA4yp6PEZ9YWxdUREUeJNVKP61rezUFHBtkdqeKar877IAIPNOL1gkPvVJEXaVPl2R/jjPmO2Vm/oXXkM4JIlY6TNwIqfvVuMiQ1Gf0qI0/FHPd6vnbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201170; c=relaxed/simple;
	bh=ggY1l6jEBJV/fWqEdy2lOoLtNTPFW3crtVf3zWyszJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8smjl4IouxxGVipWlJLe6zCp5h8ig2UMT4g1xfW1TCXYMVnzz3fxNyqURsHxbU9raJD84y7EI6iKTUHGIfSVZQXH6zY/xrHuf1QCaUFdPKeHOoU5rUA/CAzYMrh2e3pVfE744UijObKXBY9ejbZwNUkJCfr+6k60zmVpaLsyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K1LLnh6T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77abe5c709so240074666b.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720201167; x=1720805967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sxMvdQUxTmJxubQazpYFxZ+ASnMzUWUgijISd4lDe7c=;
        b=K1LLnh6TjwQYU9FUN5N/4YCcJGgD4d1H170IWWsx30VIFfA4TtZEB5to4RaArqOlE4
         yRcy5/LyWOGnhArFfr4A0V9arnxexOWkjqpZY6c4SvYzWC8Kwp96dWcrGIXIbs1wtKEt
         TzuQ/vgEjpHARBOa+DQHsCAgInPHbakOp5hNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201167; x=1720805967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxMvdQUxTmJxubQazpYFxZ+ASnMzUWUgijISd4lDe7c=;
        b=uH47C0axyPretv7djZdKERHSz2FfN3Wo9UVLeOKWoqLix/1x+T6tkFyIaOvfHJg5xV
         y0b+UoRjZiBs45MEJEbDbp4suZEiuwisTrRIstUbk4Fj+uDVSAParFnsoKf1VeGSXL2M
         fyXOuqNowRxeu2ZVL0t96CEtxSkclqqBeRthqN9hh/hkMPSY4970qOeKVra7/8KNr+V1
         ItmbvawUeHkBtLGsjP7h3H8lwv6WOgG+N1Xu8QDF+1XIFDftNnbKup9G+r9ArAxuc/IP
         J+VrCXCcDy1RKAe6gEFN9Pwfa2k3Ft+JjPQyaoZlDCWe5Ni4QyvNQcrBZQ2E/M9y2j0E
         AaNA==
X-Forwarded-Encrypted: i=1; AJvYcCUP12AJXf1aavhk2tXj4KNZAKvKwkAfN/H4xtqzJBw13AGmQJS6Wry/csCEhBtsENa1Mg563A+Csb+nmsUkVhMJwgziEPq8
X-Gm-Message-State: AOJu0YxzimElJmfYXBv9yUFy4QDxRxiyOL+sa4luf0li/fgGL+VRRbDe
	dLR1XDrubN7tfSroVKAPxBu//j88pb7N03br+Ngdr40KquQ00uLZCcRU9cRYswbyKbyg/BZnZvO
	ebOav9Qmi4t1rjmU9cibrxlClQ61IrL/KhP1J
X-Google-Smtp-Source: AGHT+IFEzcpEPlECrBvtCT5iC5dgiJ0IwMAuSl+4PWNVdJ6PDzy7f8zGq3YU1PZ1HhJX8bpi6sx8Q6PbjFk7eIvArno=
X-Received: by 2002:a17:906:3b12:b0:a6f:4fc8:2666 with SMTP id
 a640c23a62f3a-a77ba70e48emr388581466b.44.1720201167097; Fri, 05 Jul 2024
 10:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
 <20240705-bnxt-str-v1-1-bafc769ed89e@kernel.org> <f708ca1f-6121-495a-a2af-bc725c04392f@intel.com>
 <20240705160635.GA1480790@kernel.org> <CALs4sv23R1GNr_rtU=u5O0QekWCs_UATq+ZO4n7c6n8VMGsCjA@mail.gmail.com>
In-Reply-To: <CALs4sv23R1GNr_rtU=u5O0QekWCs_UATq+ZO4n7c6n8VMGsCjA@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 5 Jul 2024 10:39:14 -0700
Message-ID: <CACKFLikea+jP7y_82q5C6a+GUp5Ea8TCHUdjNoJdBUo=NTVYqQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] bnxt_en: check for fw_ver_str truncation
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Simon Horman <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008c3f06061c838bba"

--0000000000008c3f06061c838bba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 10:03=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom=
.com> wrote:
>
> On Fri, Jul 5, 2024 at 9:36=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
> >
> > On Fri, Jul 05, 2024 at 02:37:58PM +0200, Przemek Kitszel wrote:
> > > On 7/5/24 13:26, Simon Horman wrote:
> > > > It appears to me that size is underestimated by 1 byte -
> > > > it should be FW_VER_STR_LEN - offset rather than FW_VER_STR_LEN - o=
ffset - 1,
> > > > because the size argument to snprintf should include the space for =
the
> > > > trailing '\0'. But I have not changed that as it is separate from
> > > > the issue this patch addresses.
> > >
> > > you are addressing "bad size" for copying strings around, I will just
> > > fix that part too
> >
> > Right, I was thinking of handling that separately.

Yes, please fix the size as well.

> > > >   static int bnxt_get_eeprom(struct net_device *dev,
> > > > @@ -5052,8 +5058,11 @@ void bnxt_ethtool_init(struct bnxt *bp)
> > > >     struct net_device *dev =3D bp->dev;
> > > >     int i, rc;
> > > > -   if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER))
> > > > -           bnxt_get_pkgver(dev);
> > > > +   if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER)) {
> > > > +           rc =3D bnxt_get_pkgver(dev);
> > > > +           if (rc)
> > > > +                   return;
> > >
> > > and here you are changing the flow, I would like to still init the
> > > rest of the bnxt' ethtool stuff despite one informative string
> > > being turncated
> >
> > Thanks, I'm fine with your suggestion.
> > But I'll wait to see if there is feedback from others, especially Broad=
com.
>
> Hi Simon, thanks for the patch. I'd agree with Przemek. Would
> definitely like to have the init complete just as before.
>

I agree as well.  We should continue with the rest of
bnxt_ethtool_init().  Thanks for the patch.

--0000000000008c3f06061c838bba
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOhivBvKAl7XpvnTo2ELGI5ccaC4XU6C
Cjz1FRkPhwF4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcw
NTE3MzkyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBW9dwj/i1humiKskkIVw3mKdRJEbHNPVEQ266YS0WVLp+mf2yt
JEb7eD4q/UxU//hkYaDrnzlXyiU5KstKrzGxSDlf0BfVeWpkWgR4QZBV5QXjI4SCbQcfccxWtL7I
BZoBl4kiY7bdFxdmF80JOc1eA0/ARmf2gYyKaaT0i9JxZ1rGAeMOzqlt7kK56U/ShvbIZfyT26tH
fUIG87mHJFUK34jWPF/Q4IT/tpeQh1nYDytINnEwz3W3Dy+vNF/QxWcnTYXr4NpLw6jE4I3ormup
MM06rm4HSRwvZca3xVbaDerj+qIf2QWn6Bc8QC2ZTM3596sWzXs0KftkQ1SD+w61
--0000000000008c3f06061c838bba--

