Return-Path: <netdev+bounces-189898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24FAB4722
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA6C3ACB69
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8AB25D524;
	Mon, 12 May 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eAgfa1j1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C311AA791
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087731; cv=none; b=ATepKbaezhK0VbVzAJjnbF3ZpYfhhJBI4oYaFoUM9bjng2+z2o9EagsYALHtr5LleoLtf1uWZoTGdQn8rfpdNPXATHj0i9U0Nz6dpIQANirGJhZQhpHGTpXI+mbd9/Re4FMTdzaVBLi7Vv8Zb6Sj9e6x6x5V8J1JgbkZbcoe0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087731; c=relaxed/simple;
	bh=vfrM8z63pHUPgGURCEHfvsWk4SG3LbfmCdZe43jPxT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz5MnkpMQA+O7KAJwD1RL9MsMI4v01huOLvZIVDamOPdtPESZZSTCr0UUfPURD9Z5Yd2QGMEGntcF6ySR/BaZNEsennE8VOdOlZLkCW9i36GCB/D3zaHtMLr3VPbHApFrBg1Gkvf88GsZvL5J5QCUVAnRl/BJ6CD+I4Z5vv8HTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eAgfa1j1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so9436124a12.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747087727; x=1747692527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2hbgBD+7hKG0PLMbbdRq5M6YB8lxHTLs97Lj/B2MSIc=;
        b=eAgfa1j1wVbG6GYYr8AE8JTJPOuPeRxO3u69Bz+cKWZaZeO2p8MWkNeZ9Za4JTsrR7
         U8Efp8Fx/3dt4LHMljRImP9slwLcOuVXcEYrKccvxS7u8Nybepkxf25jHcj0vcWLSbYG
         CAWLUlQJLQ2kucrS6vr1nK0c2y/frCMGllPqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087727; x=1747692527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hbgBD+7hKG0PLMbbdRq5M6YB8lxHTLs97Lj/B2MSIc=;
        b=YhdJJzsVJIrFP3D+oh0/ZulWqJzNwB8TeUDLtp3U73hZGmdqofEzBNocewJD6EGQcx
         bwm4NhzwvnCADjHef4CG2rkGXL0sqpMmCGy4PmGVRiwCIMLoyEAWiQR/oznk2wd8/+zH
         38plJuGS6c6nK3zlJIdkEBZdnFi44etF5zIfY17fpoITkXre/dQ1y4nuJ2cp2hQRbwA2
         7lNli5gnRYkBcWzcjM7FEfu97E/Ur0gLs0mev9TsKFu0vp1rVLU1DYweVOqWyTt3qobs
         GklP9ARpqeaEeodU+sEeBCbYnBdDfCEg/ROdNL7plsFJFCB7sljfOodr5dvFX0wh+xGf
         Nm6A==
X-Forwarded-Encrypted: i=1; AJvYcCXK+a/cByu6pkaUeEo3NfhxFJRHJvm9s3knA33yPfUfn57rcW7g6YWoAnJJiKQlsUeoGCl+ymE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wRZcQG6ICSM9a7C4uGuuoIw6J52CI8y8Gfx5GSME58XGpTme
	uR9s6fxLtFz01aW6GwyAr1OkD/qzImoRRE5ONypq2n/xsb3CD0hRNXYH4e3rNNwPG99LAPMylLW
	ugon3EfQ/S495TqOMya0sDgK1bW+o56+C/GVa
X-Gm-Gg: ASbGnctcfzjfYufcgptxx0PivIdQ7o8dIaF3r1NGynJtN4M4HfVbfMVze8PratLXctm
	BRr8cDPaMTTS0dLabZzAxNBaax+VBdyIxT9Of1GwaDC/Bbo3V9qiOxpT1eCi1RRcCieGx3On2x9
	b7a4++57wYkH3vRmzfQzaOX/H+z9q0nkhd5w==
X-Google-Smtp-Source: AGHT+IF5a9MOHk8DWap8cLkAs5ibJGuY7ZqQghFHDtJM2/OyX2+uMa3QOJ5QGfickW1hcWyZh6K6umuysqFGvMBy/SY=
X-Received: by 2002:a05:6402:90c:b0:5fb:868b:5a59 with SMTP id
 4fb4d7f45d1cf-5fca081b48dmr13066703a12.32.1747087727404; Mon, 12 May 2025
 15:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512063755.2649126-1-michael.chan@broadcom.com> <aCIDvir-w1qBQo3m@mini-arch>
In-Reply-To: <aCIDvir-w1qBQo3m@mini-arch>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 12 May 2025 15:08:34 -0700
X-Gm-Features: AX0GCFtzBUNvmRrZIxlSPodylRhgS-EyTUvkW_oj7dp8NR30jqxhkMdIJNPi1-k
Message-ID: <CACKFLikQtZ6c50q44Un-jQM4G2mvMf31Qp0+fRFUbNF9p9NJ_A@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl_lock() in bnxt_fw_reset_task()
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, sdf@fomichev.me, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000687fac0634f78f57"

--000000000000687fac0634f78f57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:20=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
> Will the following work instead? netdev_ops_assert_locked should take
> care of asserting either ops lock or rtnl lock depending on the device
> properties.

It works for netif_set_real_num_tx_queues() but I also need to replace
the ASSERT_RTNL() with netdev_ops_assert_locked(dev) in
__udp_tunnel_nic_reset_ntf().

With the additional change, it works well with repeated NIC resets.
Thanks for the suggestion.

>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c9013632296f..d8d29729c685 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3177,7 +3177,6 @@ int netif_set_real_num_tx_queues(struct net_device =
*dev, unsigned int txq)
>
>         if (dev->reg_state =3D=3D NETREG_REGISTERED ||
>             dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> -               ASSERT_RTNL();
>                 netdev_ops_assert_locked(dev);
>
>                 rc =3D netdev_queue_update_kobjects(dev, dev->real_num_tx=
_queues,
> @@ -3227,7 +3226,6 @@ int netif_set_real_num_rx_queues(struct net_device =
*dev, unsigned int rxq)
>                 return -EINVAL;
>
>         if (dev->reg_state =3D=3D NETREG_REGISTERED) {
> -               ASSERT_RTNL();
>                 netdev_ops_assert_locked(dev);
>
>                 rc =3D net_rx_queue_update_kobjects(dev, dev->real_num_rx=
_queues,

--000000000000687fac0634f78f57
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOZ1fqC/ZLdsCvrOz+F4ozzvyT3Y/Wh6
bpYzZGEMm1t4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUx
MjIyMDg0N1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAJ6OrJlai4f7HXIqa7mlMkcOz2wqhbl7W71w6A9f6TGqxHIZUgiLef2ZsoS2B+36MO/W
sTTA4anhDX+zf1DMI5v5MozPOYu7A0crq/H/zOnAeXqVBcLFsxM6KSxI8j3y60Bxty2pFYg54AJ5
joZaGeJKF9lPPdv0leSR88i37Z01HkApnlBUr0hl0sT51fk1TY+EJE3I2udoi0Poo1TVNodfXHR7
uE9VuQWV2gLs5b4UitKMjR1fn3sK5JtQI7ZIrwmv2CY+GukmhggirEQCh4BokJ2aJGna4PykvXl+
yx0Yal3jFvRP/umWOZqtPaVUPQwoOqKKMIfeOVTAkAzec8o=
--000000000000687fac0634f78f57--

