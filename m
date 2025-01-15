Return-Path: <netdev+bounces-158330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE59A1169D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E035E1622AB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976B535945;
	Wed, 15 Jan 2025 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E5LF1X3k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67221BDC3
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904587; cv=none; b=Axre6Kfaknzwdui8z2K9l+ec3u81UJDhtawkCaqJx1QXkJG7DN5y2guEyadznLPk5QEiwaIO+4lZVr7YyjuwzPf2qWCaE5X4UnDOKI4eUYXNvreMVKWXGf/tzW0pM6tIt6RzJKZlMiuunY3okVdZinhwp4apH0/WHcYDy+29Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904587; c=relaxed/simple;
	bh=5LlzKIhynaso15Dgf8FEecu80LfC4b3G8fTmYShAqVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBDknZMghPA91tN3aO6tx6eRGYP9iyoELH0KWkdQRpqv78kH27T8gd47haL1dSejJP6vR6LUMIOS1b09MQFBs8m9bALtjzx+HlaUGZATjLOteEgiRuHoPiQ8qsQtgZn2PsMw36l1o1iDBVXyZllSyQwruw7gW6I7FT+3ezROA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E5LF1X3k; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so3927223a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736904584; x=1737509384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZSYLg0xvYzpVXIpw9PA3JUpD+G9Da/iJpJ9DQQzXbs=;
        b=E5LF1X3kMC/TQwEGZlDl8J2lkGhDXqBb4GiDXqk7vF3kZ8C0ZZj3hHn0CGQoxvgSG9
         41KDNF4B2fchGS8mhctZhrum54FkqApHPR9XIMm817eN5PgL6Cz9zm13BVS59dh9Dhip
         7UuR/6zE6q5yX8nZjYrdQ9gKomrYKNMDKwWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736904584; x=1737509384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZSYLg0xvYzpVXIpw9PA3JUpD+G9Da/iJpJ9DQQzXbs=;
        b=fNRxwkFKnwIlnjctelMF71sZtA9NYQafqVIvu2znnGQQFgkK0MI93JZ4uTrl5fG+nR
         qfrsMjIrxPFS8mCPjjuiI+eZGPnEapYaI9AK2XYq0ypC7GcstdMMUcwT6hSAMMeige97
         7Lx7728WLuaI6VvPaGFJeqzZb/AyG+lFS8nl1pazFdQV3iX5Q8b6PstNT7S3T0RKqkL8
         Kxe11NMnFm2jSqOp/GcwYwVemwwEh8I4CZRRI1FfXb5i1zP1oa9HEyITqwIrBaEuZF0g
         BdV570Ht26UJTnLsulzSgbUGYGG/0sU81OtbT2dpQRjSjSZDfad74hSWXrHfA8bQtm+n
         0n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVss+/L2TiPJmUqNpYiCATssbxH+FkxbNvLyddikssJFP8eHFUBCezg39DArbhbUZvszfdciJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+yd8HGojaFXHDKJ0TSH6kofkimhWpgh+KsicRDWpONPkE5t/P
	3nBgu2Qf9elDgYcVAkin95tdKiIbC6OH70gU85eC4lWQbChoB18+tFchRudldZz66JKTHUXDWto
	1R5kUI59mdtTIHyO3taP0vsugdxAWu2Bi6/ZD
X-Gm-Gg: ASbGncs3A5gYGYS0VCqBc9U1x3RoCP0P8P+n4dyvE13twhyFNaB/Y7mCLRo/7pW8h3w
	l2CewQqaRcESMyRtZpmf5UfqzuhcyiCS4QXrApkA=
X-Google-Smtp-Source: AGHT+IHuJJ9X/jcSj12nL7a+DVhThJ8i73a1R15n/TaZY4f4Yje1Tz3DV3tvzSD/4xV/m5gcLWdZphvZ5flIT0OshO4=
X-Received: by 2002:a05:6402:538d:b0:5d3:d7ae:a893 with SMTP id
 4fb4d7f45d1cf-5d972e48691mr24114090a12.25.1736904583819; Tue, 14 Jan 2025
 17:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-10-michael.chan@broadcom.com> <Z4TRYfno5jCz84KD@mev-dev.igk.intel.com>
In-Reply-To: <Z4TRYfno5jCz84KD@mev-dev.igk.intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 14 Jan 2025 17:29:32 -0800
X-Gm-Features: AbW1kvZUPH8bCVBGJzhkBTLiu6EyZP0zopjgcw0WJAkTTFoHSUNPYAniu_FDaYo
Message-ID: <CACKFLinoJwTa=pyCRDN6q79nTNLz5onRuYzrMdSJ1c4ODiy3ag@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx rings
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	somnath.kotur@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c16fe1062bb49c37"

--000000000000c16fe1062bb49c37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:43=E2=80=AFAM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Sun, Jan 12, 2025 at 10:39:26PM -0800, Michael Chan wrote:
> > From: Somnath Kotur <somnath.kotur@broadcom.com>
> > +static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
> > +{
> > +     struct bnxt_tx_ring_info *txr;
> > +     struct netdev_queue *txq;
> > +     struct bnxt_napi *bnapi;
> > +     int rc, i;
> > +
> > +     bnapi =3D bp->bnapi[idx];
> > +     bnxt_for_each_napi_tx(i, bnapi, txr) {
> > +             rc =3D bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             rc =3D bnxt_hwrm_tx_ring_alloc(bp, txr, false);
> > +             if (rc) {
> > +                     bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
> What about ring allocated in previous steps? Don't you need to free them
> too?

Any failure here will likely cause TX timeout even with the proper
unwind.  I think the correct thing to do is to initiate a reset.  I
will work with Somnath to implement that.  Thanks.

--000000000000c16fe1062bb49c37
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDSN/ZblF/+q0nPkaKmNLgmxWK6gg2oc
KaV5seGdMri3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEx
NTAxMjk0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBKKtZHZWHq6L3mdYh/yb8G8z6sBeeQlhP+DY3TQxR/UV1fvDJE
Wne6ZfB5iTNjZ84lqvr9RcyWhwYOrzerL5R0RyuTPE52JOtbX2SuCpmZ9Z7rFZI77E4pJgcNfb2W
/qAAMPTcKNn7etUAH9UHynxXY7vpyqyK4oeB0tGIKb8JLCHqYQd+2ghSL1CYFj0EZyH71VfbVeob
fz7UlfNX76PRmeruHouqjsNM7SQaJ02xb8YhR8TTc04Rd8EQivN3DS3pnMFOJTgKYZEeIVC+yD+s
vM8SgKAvrMLDeSZTNU0bt7TIe+BRi8ecjqOHhH9Q4buOuYBXB2rE9+a3raTGlJ5/
--000000000000c16fe1062bb49c37--

