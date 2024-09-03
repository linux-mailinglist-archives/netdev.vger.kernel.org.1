Return-Path: <netdev+bounces-124597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 442DC96A1C6
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF077282CA1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59018592B;
	Tue,  3 Sep 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iPpAuMZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CB16F8EF
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376348; cv=none; b=SFuXcV0oGuvhPC0Ow+W9VqcHmm8QjfCOhfGehAQkkZ7dGRtfMW5kJ7sODMdo0zaufaFl9KosUfuktXoAnOXImX+oclCsHohnjdSCB1tBgxBJqoBVUATlxCXPYAIINOT3fGvfj/5ivd8A4lLwiXcnSYVDaQvdx2HpxaoDZh41h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376348; c=relaxed/simple;
	bh=dy9gj+VcaRXhrCXmuG+Dkp10RektmT8xd6Ey/BQmqU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsjiFyVMmoCAC82GfoOImZ5ez+rv7LejD0K/h5IUdxOv1BmkPjq9KpJW1oVIJusj3wSDF7kpEVf0eW5TuoINGjdWw6D4VLo2IWLeouPQTY0GdZRMkYIJS5P6xcfXPepXszca4ExrYkUsI4RkR6k67cT9x+tBX26wZFSXoSnXyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iPpAuMZH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8fa2ca5b1so1125510a91.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725376346; x=1725981146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+DGbQ7gU3BDeALBQjFv3x+uoh1NuRt507dd6Tng+EFk=;
        b=iPpAuMZHaNDeKhoPG2G7uXaB943UpfK1n8iAncs743zVAgwraCbDc49/OGgPuCe8Kh
         eFZJrBNXoLLbkNftzH7wiLpKAmLxEBAlFnwfQdeJ/EFl42C2GNBRPHQocTF60H46FrVX
         uydrzcyGXJe8j8ui94cxFMsnYTaltEuHv5L3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376346; x=1725981146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DGbQ7gU3BDeALBQjFv3x+uoh1NuRt507dd6Tng+EFk=;
        b=jCw85BfmtB3QYpdbam3zfv+xOvXw75BnBGGYs1v4Iv0w12NOfGcNHd5DV2xYqu89yI
         EAavCeNW0M3BP0b7bfRI5cAeNqYGePRbsd2L9KmOZuAnAptnSkfG1dSUB/PXWg9AQV9W
         NjC34BfNbuO4IUb+JLJaqGhrgql7zd4Mewf79g3s63qEL+9IKRdFSIejDihz4t1LSroH
         CXHJ3vEYT5wp4HB+Pg8+l71gD7UVuGD34nOgDvgbpwIlclzpDiNsq+OsppSAvKXz8dww
         bI4qJV6K4aOIADmaNUbSA1toUQfvoX1SnQCnFcHrviaSw8mTsYVxFp0QVhKR2TFGPTpN
         qUFg==
X-Gm-Message-State: AOJu0YxkuQqeQRglbZhOm8LRvntwA0UeXTGX633jNaa1LQwud2naPWZ3
	3CxpHb7DGtDBhriQfUGuXdq9QuigJt9SjJDPi3LnmCQNDbXmdlLtUR6zlvnpSXHIIUYO2AUWSkF
	2taShtZPsOWYrUKMCZugWth0EcWtKxBO5q+rS
X-Google-Smtp-Source: AGHT+IEVsh4Pz5U7yMVuSUtZ0SnK6Hcnq19Cu/S6EpXeRxqn2b5zL7kKjXJjso2OLo6ePSHAZ7K+Vr4lKZX4GTYxkPk=
X-Received: by 2002:a17:90a:8d0f:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2d88d6db509mr12699331a91.20.1725376345593; Tue, 03 Sep 2024
 08:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903124048.14235-1-gakula@marvell.com> <20240903124048.14235-3-gakula@marvell.com>
In-Reply-To: <20240903124048.14235-3-gakula@marvell.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 3 Sep 2024 20:42:10 +0530
Message-ID: <CALs4sv3KVxTFex3FHWSFjx37FahOTiMN0DJyZ0Zn9qxQZQpZow@mail.gmail.com>
Subject: Re: [net-next PATCH 2/4] octeontx2-pf: Add new APIs for queue memory alloc/free.
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003790dc0621387cc7"

--0000000000003790dc0621387cc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 6:12=E2=80=AFPM Geetha sowjanya <gakula@marvell.com>=
 wrote:
>
> Group the queue(RX/TX/CQ) memory allocation and free code to single APIs.
>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../marvell/octeontx2/nic/otx2_common.h       |  2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 56 +++++++++++++------
>  2 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index a47001a2b93f..df548aeffecf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -997,6 +997,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id=
,
>  int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
>                    int pool_id, int numptrs);
>  int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
> +void otx2_free_queue_mem(struct otx2_qset *qset);
> +int otx2_alloc_queue_mem(struct otx2_nic *pf);
>
>  /* RSS configuration APIs*/
>  int otx2_rss_init(struct otx2_nic *pfvf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 4cfeca5ca626..68addc975113 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1770,15 +1770,23 @@ static void otx2_dim_work(struct work_struct *w)
>         dim->state =3D DIM_START_MEASURE;
>  }
>
> -int otx2_open(struct net_device *netdev)
> +void otx2_free_queue_mem(struct otx2_qset *qset)
> +{
> +       kfree(qset->sq);
> +       qset->sq =3D NULL;
> +       kfree(qset->cq);
> +       qset->cq =3D NULL;
> +       kfree(qset->rq);
> +       qset->rq =3D NULL;
> +       kfree(qset->napi);
> +}
> +EXPORT_SYMBOL(otx2_free_queue_mem);
> +int otx2_alloc_queue_mem(struct otx2_nic *pf)
>  {
> -       struct otx2_nic *pf =3D netdev_priv(netdev);
> -       struct otx2_cq_poll *cq_poll =3D NULL;
>         struct otx2_qset *qset =3D &pf->qset;
> -       int err =3D 0, qidx, vec;
> -       char *irq_name;
> +       struct otx2_cq_poll *cq_poll;
> +       int err =3D -ENOMEM;
I don't see 'err' getting set to anything else. Can avoid the variable
and directly return -ENOMEM everywhere?

--0000000000003790dc0621387cc7
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMw8k44Tqc3GIkC5poBBkcb7bIkJVgar
WZEE24MUCx/kMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkw
MzE1MTIyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBhHAZ4zRAVvxy1Q2jtf5lVJzeIOaSjznKai9Jk5HaFt8KwOsiV
BZBZuc6ARvc+TgFjWuMpnFMnTMczI3HWmW1QWf5MlqAL++Zf6XmrKxSFOGJ5HSD6Yom4Ml9sDlW/
OIM8EfgxCAX6ONZiKVfb1+oDus7qXp0QnU9H02ykZcyuBV2EHY4XRffvs0tjU4qCHKQQ+bEuuLJ2
ZP2uwmtSElZAhKD3DDdK6HeVGIUe1y/q9vK/0Em5+zNGUN0EEmWRzlJaQJ5WIimIAsE27D+cQ+qC
4NN7VLtLA2oIRlJlJ2m4WbRw9igcQ/+Blz/yR5Vsq6/nqNVd4l9G834MTEYduKAM
--0000000000003790dc0621387cc7--

