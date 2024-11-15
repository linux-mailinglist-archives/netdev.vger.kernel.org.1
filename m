Return-Path: <netdev+bounces-145104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B97B9CA0B9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26333B21EA2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B388837;
	Fri, 15 Nov 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QvKFBqpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F104A11
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630164; cv=none; b=bg7pri3eT3tQcw6WsslyuUz6jy5GzZz63s8kpIydcm9xP5aaA+TBTA98KauhfRyx+4TUm8OXr/UX4EnOeirW9p32L+8NPihrIadbRkVTPHYrc2FTN7AGhjEP7vAsRM0yWDOVZRFUzQmJJNoXXtDUrv40kA/nBduDUv/ZdbaF47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630164; c=relaxed/simple;
	bh=moI8WxGiB9tv0ZyrmC+zOv4MuT1TuR7i0bMoi5MdArg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/XmnNxPN0NU+a7NWGMaAYJetFGTQQHoVD3hWNfrZNabLoG59eFr9kezMlN/3ut5JTWdCtta83BKrL9MvOXaDkFroI2gWDU2qz48+O2tizNoQLWXeEXZJZNvCF3KPE6AdbtOuS06//YIYmHD/8ItacVY0061bLIbZfrPw8KgnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QvKFBqpz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cf764e50a3so2501676a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731630158; x=1732234958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hfS1H2yOchvS/qqNKVWblV/sdXddi+zLRSwGNQFOfzI=;
        b=QvKFBqpz720C9nCXfuDPFDHXw1RJy4OSRHtspAm0TnBKlFsHFKLcCa/AzIHgyBUddE
         FYIUr6tINqsxFXCPtFrEg1xoh1WMxDDrc6mH4zVy8iwtiS4njq5Z5+q4gAg7b4sMQ86B
         ycpd0F8BbxHXHV7DZbLGG7yxsBts+vI+tJSIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630158; x=1732234958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfS1H2yOchvS/qqNKVWblV/sdXddi+zLRSwGNQFOfzI=;
        b=OhB9OfBLMDBzepGhCwMHC/3wwkS48J985sekcMYFlx8a6PG94OhvzfeOC7cM5+YnEL
         m1mWViapZ+N4fJYZIWAtZ1cjyN+gEqJj85yo7xPrFVhaOt6qXPvgwLZvZ6NqjCaG33EH
         WADXd4nYCr30Nq7qY7sB7rTc6B8F1bMmfc19ONFqppcBm1AZgJiEwM1jbKfYIEEZWT6x
         grIL4PUxX2JXqu+OY9TbdD48fy6GvWEw24piA1MYDD9Zs6nrCwVqRpbg8DBBIBzxxqme
         4/8L12djXSBHbWSHlFYVFsq0zrnLYMfCabqZ6YX/QQazYeXVqrBcgUtmdFpyIiGygwCV
         Z0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXj7+iEwpGweD6y2qhxaQUvg2l7Dg8D8c4nUfi1LqDmRvFqxaPqrjQynH46KJD4BTWw3JZZAQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8h1c2durwNVxe1YR9/HjpSMCOEnnlCldh+HihphiagvzeMIh0
	SrKmIkUDfrF6w6DXzLAz3cX1F8RZjxbnRdGQnmJC/bkhXKPWho1GALLvwH9JseghCnetiQySV5t
	oHmhxJLeJhI/XDkHTVHV8X2GifUxq7bT+kyPi
X-Google-Smtp-Source: AGHT+IFAajEiR/JuU4hBVske0C10Goc34RQVrgIDuPPp1N6VsXYF4OjopM5yM6/7PIRNEuoATX9GxT1sZBW+91oBxJk=
X-Received: by 2002:a17:907:2d93:b0:a9e:82f3:d4ab with SMTP id
 a640c23a62f3a-aa207687241mr481420666b.9.1731630157868; Thu, 14 Nov 2024
 16:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-2-ap420073@gmail.com>
In-Reply-To: <20241113173222.372128-2-ap420073@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 14 Nov 2024 16:22:26 -0800
Message-ID: <CACKFLikWhVicBRENq9Je=61+zJUqpcrpKONKP7sczi89sgbw0g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077a63c0626e89077"

--00000000000077a63c0626e89077
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 9:32=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> userspace. Only the default value(256) has worked.
> This patch makes the bnxt_en driver support following command.
> `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> `ethtool --get-tunable <devname> rx-copybreak`.
>
> By this patch, hds_threshol is set to the rx-copybreak value.
> But it will be set by `ethtool -G eth0 header-data-split-thresh N`
> in the next patch.
>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

> @@ -6417,16 +6422,14 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
>
>         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLAC=
EMENT);
>         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_=
THRESH_VALID);
> +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
>
> -       if (BNXT_RX_PAGE_MODE(bp)) {
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> -       } else {
> +       if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RINGS)) =
{
>                 req->flags |=3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_H=
DS_IPV4 |
>                                           VNIC_PLCMODES_CFG_REQ_FLAGS_HDS=
_IPV6);
>                 req->enables |=3D
>                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THR=
ESHOLD_VALID);
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh);
> -               req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);
> +               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);

I double checked our hardware spec and the HDS threshold is 10 bits,
so the maximum value is 1023.  When we get to patch #5, the HDS
threshold is separated from RX copybreak and the HDS maximum becomes
256.  So it is within the hardware limit.

--00000000000077a63c0626e89077
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICMpYCS6omWQotCOf8bRp7xnEsn596tm
u5kUdVwn5xPJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEx
NTAwMjIzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCUrqs0eWJuKiXhj/zgv89WL4nxWI4dYFnAh35ZcaLXT/j28FQf
FRzBteR1jPs/VR2ROmOiNESkG+86uYSPqAN8U0h8d64hXEDgSvm7Tk1obsjYMxuz3lAiBeDGZl3B
OAd13jngAXzkd7YKgUcah6nqsvRGNdZkd40HM1zzdMOAJPDOQEmc7Ih2GWuTxQ/eCO1leP8GXxk9
Tc3H4ZW2is46bj4aRnAu3R0lxhTLAIRLAeEnEQyRTUBPt3GN5gvciLC5DPdOP3meBpDR7zXavtYX
lW0M/qG+cd7ciZNyLNFgmcK2q3c/vyThdDdyCmQMi4flaetGH8zTb3jUkV7CEkoQ
--00000000000077a63c0626e89077--

