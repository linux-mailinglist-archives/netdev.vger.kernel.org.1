Return-Path: <netdev+bounces-102029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AFA901248
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 17:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8686E1C20BE5
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CB15A86A;
	Sat,  8 Jun 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OOqh7Wmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFC155349
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859989; cv=none; b=LPXna1M/TG/X47XAHnxNbCeejWOGMB58vL3xv69WAga83FIruOpUzfuVcWDbkiJ3QfQArFQqfpzqN/b5UF0xxecu4t2gzzf1Us+uqEylyzF7akA5x1XGz/4pa0pxlyTO29yc4qfbdV40bbxsQjiVJ8hCajFu2gb1ZJPEnNgsNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859989; c=relaxed/simple;
	bh=QZqf4K/C3Ay/pPagnqiirSBtHd2NeUIU6GWz/QOqclY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9LwId88YXAfFUx1REjJ5YkfYiuUa4aTQAQL7R0YMzqYoem/YhOU3ohIwT0X6NE+VUkQM2oay1ZqDlsIqIDosOfOt14AJ6kRFiFKftJzDnGjKJXHiLk1dT3EE7M5gEobAlcy4Ok9BYLz91GhsGhHdq/VcP5dy1K9X0QucNM6StY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OOqh7Wmj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe639a5so3755542a12.1
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717859986; x=1718464786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaOa8O4lEl08A3XXFZTOyk/HXa+EQJqjiLct7npm0TY=;
        b=OOqh7Wmj7BNphL9wSsFecZHUqBFQTgx4UI1eW/FL2QfrQAWMxreTcepqIt70f5RLHu
         WGl87h4yddyGIlIOanYLwDk9Zf4s2+CfMKL2N5MtHYH3vcsnCxOa8oLAM2ZXP3d8Z6Av
         CB3EgBABtwr5qhZxpj2Qwmxox30bhm+MaxSJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717859986; x=1718464786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaOa8O4lEl08A3XXFZTOyk/HXa+EQJqjiLct7npm0TY=;
        b=GshJFycuYlbvxrEERtysgzwqQU8gLMsP/eOsGhkCXakyI4tfbHEEEbAPzb/NStq90I
         gpHtF6gJzLLK6WK/wRomL6ZeBXPRElBbfrW7VxQY4RAYr42TZcgUp4ESQX27vbZw1k+K
         dSFkIQl7J7WMZl+b6b5gGRz0Pmyio7cKzGlul1iBejy8h+omugg0B4t54ipKHxYNg44L
         0mTJQMGnZWeuGh44SN8ssY4giqUfGIzV9Hz8bPIoAcg8xm+l61qGGkoCMONASyUw37d4
         EQ/UlFk7jT/EkZDvnQTRSep4TiVu4/v+EJe0qkV5jfF13zVU8rHIBmpKH8kmWTKRwQys
         aOew==
X-Forwarded-Encrypted: i=1; AJvYcCXinM3Dxq6ZtgP6jmNYGu6QAoHFs3MYgHBous6VHnllN1Ryua7cbUNdPYwV3TYWr6SIfb5eLXd1hgQcfERfmXxnfftCVY8Y
X-Gm-Message-State: AOJu0Yz7Nn8a/2PBm6K63f9qd8KmxEdLH2VJ9XmEPcjpgpNLVV2gxQfp
	fXM6aL1rypzFA4E9+I4kM8UtU5KQjysxrSnGsbiKh80uam5yjD01Du9gCbrqG9X36zXoKHb8cOM
	bOmfC2cw93N3z/hNQIrXP3NuOoIKs/cEla2TT
X-Google-Smtp-Source: AGHT+IF9GYzcm34I7+/dCGMs0/J3aNglGSy+aOOzdXl6sz4kGgtQQKx80IMOquGppCSosLgE/ad0RoMZ97kHqbUYkJw=
X-Received: by 2002:a50:a68f:0:b0:57a:2fe7:6699 with SMTP id
 4fb4d7f45d1cf-57c508ee85bmr3075917a12.14.1717859985231; Sat, 08 Jun 2024
 08:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606175107.53130-1-michael.chan@broadcom.com> <20240607135046.GD27689@kernel.org>
In-Reply-To: <20240607135046.GD27689@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 8 Jun 2024 08:19:32 -0700
Message-ID: <CACKFLinG4a8D-=erOkcU7JbHzq2UjbxRhqf7QXP9OBVo1rP9aw@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000040cc79061a6272c0"

--00000000000040cc79061a6272c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 6:50=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Jun 06, 2024 at 10:51:07AM -0700, Michael Chan wrote:
> > Firmware interface 1.10.2.118 has increased the size of
> > HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
> > forwarded.  When the VF's link state is not the default auto state,
> > the PF will need to forward the response back to the VF to indicate
> > the forced state.  This regression may cause the VF to fail to
> > initialize.
> >
> > Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
> > 96 bytes.  Also modify bnxt_hwrm_fwd_resp() to print a warning if the
> > message size exceeds 96 bytes to make this failure more obvious.
> >
> > Bug: DCSG01725771
> > Change-Id: I4cd5e06a7625f9d06e779e4acd9603d355883e7c
>
> Hi Michael,
>
> Does the above relate to publicly available information?
> If so, a link is probably in order. If not, let's drop it.

Sorry, my mistake.  I will drop it in v2.

>
> > Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118"=
)
> > Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
>
> ...
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_sriov.c
>
> ...
>
> > @@ -1096,6 +1099,8 @@ static int bnxt_vf_set_link(struct bnxt *bp, stru=
ct bnxt_vf_info *vf)
> >               mutex_unlock(&bp->link_lock);
> >               phy_qcfg_resp.resp_len =3D cpu_to_le16(sizeof(phy_qcfg_re=
sp));
> >               phy_qcfg_resp.seq_id =3D phy_qcfg_req->seq_id;
> > +             phy_qcfg_resp.option_flags &=3D
> > +                     ~PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED;
>
> I may be missing something obvious, but it is not clear to me
> how this change relates to the rest of the patch.

The SPEEDS2 fields were added to the structure and made the structure
bigger.  For example, support_speeds2 was added beyond the 96 bytes.
So here, we're clearing this SPEEDS2_SUPPORTED flag in the legacy
structure so that the VF driver will not interpret the new SPEEDS2
fields beyond the legacy structure.

I will add a comment to make it more clear.  Thanks for the review.

--00000000000040cc79061a6272c0
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJpyd/K82j0kL4KW+ADsfV0pzmWtB2+M
m0QrARRdpWcUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYw
ODE1MTk0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQApH4mEgUWERiOggkeOQA78kJGcqVPKU8DCuQTESQDbQNOR118V
kcImCG5iqvey/Eot+F9+Cb4bxQppQZjPBbb01F8WSzavxZv3opDPMecDmmNuLa29fBqFtdv0lsqU
LzQTZTYfobbuZOR/o23RJj4gewblNQDmCJ6rttILbfNfXHD9TQnBCVp8P6KkdtRHcG3C2hdh8noC
NJozDCQ1qU69zY6wZ9jHJutMY/je4kfMomzhHNtk1KIQPvJ/fUxQEId4zz1D86vh2/mVmPNki/V1
vcZ1IAnEwy9QVaDKihsOrxdXoBklQYPmMCVK1twIOW61nrQfcGffbb00XdhgSBNw
--00000000000040cc79061a6272c0--

