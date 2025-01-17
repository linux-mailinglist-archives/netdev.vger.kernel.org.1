Return-Path: <netdev+bounces-159473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14551A1595A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D73A8D3A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37F1A23A4;
	Fri, 17 Jan 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MxWvjjb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2D19E7D1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151640; cv=none; b=OOiVn7RJnMQc0stzmCT+/+sH1/N9mzjYhebc+Kswoiu1CyZ2ajKzn2xCgqKB5FSko+l/PlkY5PhN83qxSWKZ1kEQrsi32hkJlEYz4XRux5bANcEZoyKmIpdBhLk3CmqOrPStdohqOpchm7GtVj5iY0aWHqhd4Mdna1qIFswebuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151640; c=relaxed/simple;
	bh=tUe46uuOFuBc9Sp1dXYTXVHuhFYTCtu8Ckr0hrRvcTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWXAOkYyhZ0garzC2lhs+073Fhiz2qTh0lMGynvyuskIdFwNumo+2RlXDgZDxekn0Ng9l/yur+1kOdymonS+ck7pqk5JAs/iNL5zjomFNIci4qfoj4AfKM6Co4jgLlEoctikacBnBzH3X7cLRpgRNLH67FzYVK9XA5luU4zkIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MxWvjjb4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa679ad4265so717299566b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737151635; x=1737756435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1x9/3rtT8xahu83WqhvesVp14sIcbGuzyo8Y5wksbs=;
        b=MxWvjjb47Dl4GQDpEWSyVWz17B1K1C11XTgyFDez2kf26m5Bj+WiGZloOowlDDdET6
         JxpgZaD+EvX5LSFrF470Vxqq1ly/qXrXNWqvT48SCRMOIyNfq7FZO9pFCfig3980x3iL
         ysU/XZ5jWOrHBwBhVB2SHAblhNANLIDVYNeRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151635; x=1737756435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1x9/3rtT8xahu83WqhvesVp14sIcbGuzyo8Y5wksbs=;
        b=b2m2CVNyb64eP5tUqcmrEI/xMIQfpomnshAqySLBSBlvFzf12Q2II9sFORhYRateip
         vH5U4JlVmfk6fFVW/ruYPDayoadH/xf8SjrjJy1W2vq4JhRYtXGJ3evU5JOb9JBIK9GQ
         0x9QUp9v07eyQ6koJcFpGxt/1r1cYtlYm7udSTNwAzo77/QzFo2Mu6EgvT5JYkNEqItu
         qOXpZwxc792pWHSBFzxzvu9ceEAR7JVY4IrZrWv35Xvao8SsU5wl6vFSuJ3XFgCPq9Zu
         bgtKD6YRdBDYx9GOpR+j8t524aHc5yAb5jRTFS344BKbP//az/qek6BLLUqcPw2FqI31
         fRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNYDkE441YlPUVoqM2mGE3oeFg9P/Aub0wNR18w68o1ae4Jzt7OzHu3jiYbQS+VjrmX4k9eRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+apM7NhFiozsx0iKILRQhkvBKp2DAbQ80Mg9y73XuVxg+11U
	Mb6XQhT1uL62yr8RsLBVwxPA3s5U87KuiSOvF6p0PE/n5TPmfLnmb3AYFm/2tf2evmTxkEt7V2O
	y2sg4KWkzBx9Hkg4e8ZNFQoh9HF0XbHemnU2n
X-Gm-Gg: ASbGncsll4FV5p2ptLAcEoELcKuCa6bv8dsK87kUSgPHsKYRQwjU2iSbSZJH5slOpac
	h8JAUHLZ5m/1W4xHoOVisg1zCovThIIqzuyrBp3A=
X-Google-Smtp-Source: AGHT+IGtGk4zuRPsjGphCgcUl9ULsvtRiqrQbnsGUxJyzIxM0Pkb3B86Uqg8oeeWFo22g2nBFlYI/gryKDboWbBudXo=
X-Received: by 2002:a17:907:9405:b0:aa5:53d4:8876 with SMTP id
 a640c23a62f3a-ab36e406c75mr848564966b.20.1737151635413; Fri, 17 Jan 2025
 14:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117194815.1514410-1-kuba@kernel.org> <20250117194815.1514410-3-kuba@kernel.org>
In-Reply-To: <20250117194815.1514410-3-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 17 Jan 2025 14:07:03 -0800
X-Gm-Features: AbW1kvaI-VVP_vSHoHAHpX2ZL1iOvOZ9JlOKmV6n85PD6wllY2YGgqJBVXRp7Tk
Message-ID: <CACKFLinRxGgrgz8LUROsK0O+KTk=4a2B=mF-b2269JU+CigFPQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: provide pending ring configuration in net_device
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, ap420073@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002c1727062bee2205"

--0000000000002c1727062bee2205
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Record the pending configuration in net_device struct.
> ethtool core duplicates the current config and the specific
> handlers (for now just ringparam) can modify it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> @@ -688,21 +690,35 @@ static int ethnl_default_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
>                         goto out_dev;
>         }
>
> +       dev =3D req_info.dev;
> +
> +       dev->cfg_pending =3D kmemdup(dev->cfg, sizeof(*dev->cfg),
> +                                  GFP_KERNEL_ACCOUNT);
> +       if (!dev->cfg_pending) {
> +               ret =3D -ENOMEM;
> +               goto out_tie_cfg;
> +       }
> +
>         rtnl_lock();
> -       ret =3D ethnl_ops_begin(req_info.dev);
> +       ret =3D ethnl_ops_begin(dev);
>         if (ret < 0)
>                 goto out_rtnl;
>
>         ret =3D ops->set(&req_info, info);
>         if (ret <=3D 0)
>                 goto out_ops;
> -       ethtool_notify(req_info.dev, ops->set_ntf_cmd, NULL);
> +       ethtool_notify(dev, ops->set_ntf_cmd, NULL);
>
>         ret =3D 0;
>  out_ops:
> -       ethnl_ops_complete(req_info.dev);
> +       ethnl_ops_complete(dev);
>  out_rtnl:
>         rtnl_unlock();
> +       if (ret >=3D 0) /* success! */
> +               swap(dev->cfg, dev->cfg_pending);
> +       kfree(dev->cfg_pending);
> +out_tie_cfg:
> +       dev->cfg_pending =3D dev->cfg;

If I understand this correctly, cfg_pending can momentarily point to
the old cfg and freed memory before pointing to the new cfg outside of
rtnl_lock.  Shouldn't it be inside the rtnl_lock?

In the bnxt patch, we now look at cfg_pending so it must always point
to the correct cfg.

--0000000000002c1727062bee2205
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPwEgWin0+1vPUi/waNyl0KsoE/boNIp
TjQgMKS0s6fIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEx
NzIyMDcxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBTI35vgt+57p1SAstIZFtvGL8TXxANr2UF24mzj1IBlKEI0m/6
fYk5p8KMYW6XTryG7GIKz09m2gQlUakoZ2WLw3fFaOTePbBQwWXFNjdHGCP8U+HyxsFD/yYCkD35
cR41twoXhFrHvEZiEo9C327Qyt9QYsKi67ahfWCJAJjl3J/jCYbChSqrRPtsUkrzZHHLT2NjcZI1
bPec3Zfmp0XnhLlQpScnlZDYM4t/wA0J+4vOm99R0jpXix5r9AmsawDD1wdJZHavPH8E++4LHaQa
UpWqvxIfWVIfY9qlXMxma5aay33G4993UgszQL3S4HnI62br8gU9Hd/zjUhIrxhb
--0000000000002c1727062bee2205--

