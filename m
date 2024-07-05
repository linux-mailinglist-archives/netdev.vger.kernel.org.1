Return-Path: <netdev+bounces-109557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04106928CDF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF3C28B8D7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009717A92C;
	Fri,  5 Jul 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oi9ha33f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379117B511
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199005; cv=none; b=KJ+fmjnZk/N1urlgj3PJqf5HttTCL1KSODnF1V+j0ruprewjI1Ag3WoBRxyY2DFLT81NV9+VWJSFeik0q3AW+EZftBp743jRWzsRp3qcKsU3c62nG2cPGLPS9IWRx3m7AvlffaR6W1qVMqeZDCMWAx7Aw7ZDIq/0kzpT2x72DgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199005; c=relaxed/simple;
	bh=kHGA2ENNQamPKJaKLD9Qyz4Q0cUHyt/6M2ROkdhKACM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADSqtU09P4mOSvErMRoy4kmuZqQtNxkB+AovXNOjpYGRndlAQ89Um5RtJ3ZBB3lQ1VBJO1YOPVcebnqPyAZADJ1ppb6aRFn24I8//8DJxICP/r+EXZPUuhIZ5HTY4Fql7fCukeIa6tHFxvcvO244QQDt2Tm0Pup/mZ1z4S5BiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Oi9ha33f; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so1120204a12.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720199003; x=1720803803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lXn6B5VoJHDnPpxl+s6xkr2qo3bzU2Ajuujj8WmYWwc=;
        b=Oi9ha33fiXEIyUuWjHO+W79DYXiexYnIG9BOEAPrf81l53onPIwOSDpv+aInZb50Ue
         Ilf9UjjDs2LWJR0PTO6Y1U+uE43YD81lKLrK6nJuyu4zX9OzfivHcT5VbSouA6WNj0AD
         Coq9Ycp0zYT6Ti8+DVhuVTtr6O+yUpGhyeAIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720199003; x=1720803803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXn6B5VoJHDnPpxl+s6xkr2qo3bzU2Ajuujj8WmYWwc=;
        b=Q2BUziyXPSJ6ax/pS4dPiUxMh+2CytSIFuP5J22t5oKMB6ndGrg/aD71oEAuPj2DJ2
         D+HrUcYE10LStk+Kyx/SpHtJzNFOzEkt1P0Ml4gG4JSK1U13mP27KRagM8WK7Dez8pVx
         lk6XSbP0bTP1NBOkXPaXD3sPiNntqbcQbq1KcCI5cDpc/h4Hn5Fc9T9b9cbEbnOuFtGm
         E3LSZPSmIG6AHunTJew3A5uiAqOSwV0dGYWZAZnmOSlArsLKKBeuKbWRZ3oO3cG8qzCB
         WH/MFv05n/dXgnAhrUEW1COKocYB99s0GIrGm7Z+O1HWyAqHZCmBE65+VbgqtRuToPm9
         FfEw==
X-Forwarded-Encrypted: i=1; AJvYcCWZczLVeeWXx3UOKIMkjCiBk2QYJHnF5hnhIboj5oIbFFxLqyIpp/FK2rdCbrKg1wgQMkG5cjOTFw2aYcgFx2i7mwnVqkYO
X-Gm-Message-State: AOJu0YwLzMCHRJocIQC/T4e/QKOs9wKtw4eJA+1av31UlHXy+rQxDhGF
	lg2T7Jie5gvAEueE1JfsHfiOlvMFOVW+xYsd9GogzzrDBf7IrJ6XkzeQ/0SSr/GhYLdZaK8u7YG
	640iyK2ntFFrQvjeW46JVplygT6FeDYFTW5jr
X-Google-Smtp-Source: AGHT+IH9DDsB4FMMzT2L8B4QcVQOaYYv/qpjQV+cJAw6K2+iiGYDg536zfR8fGitE22REojQr5It/1HQGwU1LWa5uYM=
X-Received: by 2002:a17:90a:1349:b0:2c8:f3b4:a3df with SMTP id
 98e67ed59e1d1-2c99c6bb37amr3803211a91.42.1720199002666; Fri, 05 Jul 2024
 10:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
 <20240705-bnxt-str-v1-1-bafc769ed89e@kernel.org> <f708ca1f-6121-495a-a2af-bc725c04392f@intel.com>
 <20240705160635.GA1480790@kernel.org>
In-Reply-To: <20240705160635.GA1480790@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 5 Jul 2024 22:33:09 +0530
Message-ID: <CALs4sv23R1GNr_rtU=u5O0QekWCs_UATq+ZO4n7c6n8VMGsCjA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] bnxt_en: check for fw_ver_str truncation
To: Simon Horman <horms@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000087ac1f061c830a03"

--00000000000087ac1f061c830a03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:36=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Fri, Jul 05, 2024 at 02:37:58PM +0200, Przemek Kitszel wrote:
> > On 7/5/24 13:26, Simon Horman wrote:
> > > Given the sizes of the buffers involved, it is theoretically
> > > possible for fw_ver_str to be truncated. Detect this and
> > > stop ethtool initialisation if this occurs.
> > >
> > > Flagged by gcc-14:
> > >
> > >    .../bnxt_ethtool.c: In function 'bnxt_ethtool_init':
> > >    drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:4144:32: warning=
: '%s' directive output may be truncated writing up to 31 bytes into a regi=
on of size 26 [-Wformat-truncation=3D]
> > >     4144 |                          "/pkg %s", buf);
> > >          |                                ^~   ~~~
> >
> > gcc is right, and you are right that we don't want such warnings
> > but I believe that the current flow is fine (copy as much as possible,
> > then proceed)
> >
> > >    In function 'bnxt_get_pkgver',
> > >        inlined from 'bnxt_ethtool_init' at .../bnxt_ethtool.c:5056:3:
> > >    .../bnxt_ethtool.c:4143:17: note: 'snprintf' output between 6 and =
37 bytes into a destination of size 31
> > >     4143 |                 snprintf(bp->fw_ver_str + len, FW_VER_STR_=
LEN - len - 1,
> > >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> > >     4144 |                          "/pkg %s", buf);
> > >          |                          ~~~~~~~~~~~~~~~
> > >
> > > Compile tested only.
> > >
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > ---
> > > It appears to me that size is underestimated by 1 byte -
> > > it should be FW_VER_STR_LEN - offset rather than FW_VER_STR_LEN - off=
set - 1,
> > > because the size argument to snprintf should include the space for th=
e
> > > trailing '\0'. But I have not changed that as it is separate from
> > > the issue this patch addresses.
> >
> > you are addressing "bad size" for copying strings around, I will just
> > fix that part too
>
> Right, I was thinking of handling that separately.
>
> > > ---
> > >   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 ++++++++++++=
++++-------
> > >   1 file changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driv=
ers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > index bf157f6cc042..5ccc3cc4ba7d 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > @@ -4132,17 +4132,23 @@ int bnxt_get_pkginfo(struct net_device *dev, =
char *ver, int size)
> > >     return rc;
> > >   }
> > > -static void bnxt_get_pkgver(struct net_device *dev)
> > > +static int bnxt_get_pkgver(struct net_device *dev)
> > >   {
> > >     struct bnxt *bp =3D netdev_priv(dev);
> > >     char buf[FW_VER_STR_LEN];
> > > -   int len;
> > >     if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
> > > -           len =3D strlen(bp->fw_ver_str);
> > > -           snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
> > > -                    "/pkg %s", buf);
> > > +           int offset, size, rc;
> > > +
> > > +           offset =3D strlen(bp->fw_ver_str);
> > > +           size =3D FW_VER_STR_LEN - offset - 1;
> > > +
> > > +           rc =3D snprintf(bp->fw_ver_str + offset, size, "/pkg %s",=
 buf);
> > > +           if (rc >=3D size)
> > > +                   return -E2BIG;
> >
> > On error I would just replace last few bytes with "(...)" or "...", or
> > even "~". Other option is to enlarge bp->fw_ver_str, but I have not
> > looked there.
> >
> > >     }
> > > +
> > > +   return 0;
> > >   }
> > >   static int bnxt_get_eeprom(struct net_device *dev,
> > > @@ -5052,8 +5058,11 @@ void bnxt_ethtool_init(struct bnxt *bp)
> > >     struct net_device *dev =3D bp->dev;
> > >     int i, rc;
> > > -   if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER))
> > > -           bnxt_get_pkgver(dev);
> > > +   if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER)) {
> > > +           rc =3D bnxt_get_pkgver(dev);
> > > +           if (rc)
> > > +                   return;
> >
> > and here you are changing the flow, I would like to still init the
> > rest of the bnxt' ethtool stuff despite one informative string
> > being turncated
>
> Thanks, I'm fine with your suggestion.
> But I'll wait to see if there is feedback from others, especially Broadco=
m.

Hi Simon, thanks for the patch. I'd agree with Przemek. Would
definitely like to have the init complete just as before.

>
> > > +   }
> > >     bp->num_tests =3D 0;
> > >     if (bp->hwrm_spec_code < 0x10704 || !BNXT_PF(bp))
> > >
> >
>

--00000000000087ac1f061c830a03
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKhpsP6AmQWH/C0pJBZKNFgptKUuSLCp
LTCq81NXaGHjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcw
NTE3MDMyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB+3+48Qbr92wvzbO9Vk6xJQPu+oiFWRHqQxZ5GjJFD0aZ4XTx1
mT5KawwyVkjh77fX3E8wXDe49B1ampzAdFc/fu4bUSCsG5w2KPu159Y4+7UmZ/mh7/uySNyj61CE
If/Lk0ueT/QLoRjYiccrjyPl74chGBOGuHb4aUBTh3nVMfjJwfAKdc4dyHtOQjYdrvzC/pS1NTxh
7V5cYo1NN66XGzumLh25aNPFHMxuepQm63iz8Y7S46GL5sAerYmrWAKxrZ0ExlPkd4L8Jl0vbL7c
NskV7pBg5uYVLQE21um1ksb7q+7grtrNtVYn7w9yYEypyW/Ddxxi4KQ7Oxj72NPk
--00000000000087ac1f061c830a03--

