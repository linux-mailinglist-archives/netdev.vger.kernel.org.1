Return-Path: <netdev+bounces-235958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C0C376D7
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C9B3BB404
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A52FD1AD;
	Wed,  5 Nov 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bk2HP3K+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B6299AB5
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369551; cv=none; b=IZe7M5rzxMcftBDduvG0kXx8vQEG40++p7bMp0jm2u/UIMsijvgY6osRm9haiGkDh/c2irnjnP9Q/MxWL0fUQpg81Rz3eHgwW9YGXrSy5euxDaEq0lX7K0tjq70xhhWPX7evBlHyOkxkdp4bvUK+8JVnpYzTSVMxOFUNolC/heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369551; c=relaxed/simple;
	bh=LJvop/bOttmtaE86qx+Kj/a6PXNJQNr1LXBBkHQBAoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXs3znWnCGkvtmhYlxzQ4cnnneAVclBD/cr4gox9jwz1hNZkXeSGyKIB9rCbkSK/kbol8Kg5KyQuBl8JRLuw8ATqDL8+0vuyrm6r8GVk0cbhEUD1Jwcua+VCO/edHI4Y1WFRP8GIDPadqMbw9oyfQRkw5Nb2u4N9cALbl2uJWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bk2HP3K+; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so80443137.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369549; x=1762974349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ooi4I+mhmFHAKQDL7c+9BQJYIK9Wnzd06QWW2wK04G4=;
        b=fAgfGVKEo5eVLMR5by736TBiXzotNFsLKUAwJgJx8uTYYJwToXagvNSVlk8XkRYHMk
         zu2AHR9B2vcocxf8B69/3Kt89Llh1y/mtOR0ejbaVrbM8U/LvhCmivjEBQFHkxADTkd0
         yX3RCl9771l9AO2T2Tc7ZYy0cyGS7pDMmhKDRDr5JRQ0aQ1//VBD9ee6yWemHDUn0qtg
         uFkfC0YAhcc+3pU3ZYJ/Na/hz7kayUOjHD9iaRbYaDzaI37BcbInmWXTSYNcUYbFdQxg
         iI5G6nLaV8nMvbpHfRLnfWjhRshtuYOThjBFxKk9sPS+0EUpS8J3F/EoMx8mSORPRhjR
         47zg==
X-Forwarded-Encrypted: i=1; AJvYcCUtWXpl88KfiXVsxPySBpuQwBmWiG8DN/1GSfidjL+w3BtFLeewI0XP2VBT8E1WEbhQ9x1ZG2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkT9dkbf+9Iu38It+MeQi/XOsntGBUmG+FWlxRAgPvpBdAjoqy
	vwBb1ZNwx/qhVZANaOAT3/YXieZIyzxT8QdNRE6nIJ2l19GJiD3QgQcC/4lpuD49DgCkj+r95kA
	dgkOmQFrxzHl1xQ0XT2+hb5UegH3HHpE/iFnoSI0Jzu5nSstDHcwh1wAivE1POTj4iAhfBdConD
	Ejq4PYWrqkpkgJgRXJXoE+HLBuBmOpfwNw6gcQi9dVsEDG9Iu4HlM3/lhwM0Mu6cOJFr0FmBU7d
	WlfLvPbgZE=
X-Gm-Gg: ASbGnct4du+eVqjQbTPhwYDKyiSYj/xFQNEmENznXGYwZgeFSIVWY4R35kctpxXTN4a
	KXBs/LJ5wDuUYUxOpTX6L4K4E8rsH1mzAMJy/OyLnWp4yKPVhlnPRpEUhF52jFrWh5QEKBZNjBO
	REaOcgdG5i1TfFQNhNbUX05O+asjtJzhoghZifN+97Jj8zLPqEFZK2W4bUwbUEq2ZQ/kBl7CIJd
	AZo0fvpUW06TKgMEvT15ECojimt41IA+L9V7wa+TazkevsZCiQ1oXaHGDOSnnrI7cviafC2nEjR
	ZPGhS5FW8EVhbYsvpFiUg0MW0eea6UjnK8+m6M8fupehO4dkUFrwo0+EOF2EmkmblQ982TO9361
	v7Qd4Jm9Rliq2bbVJLOPND1ljaNBBOdwXLKzgxBgK5cFna24qyH9aQav5Zsq4SLptt3hxojzgLz
	BFMDj2+KCJPvvoqg+QCquS7I676JCiNLY1UNM+
X-Google-Smtp-Source: AGHT+IEoLbFKlCGNZvfhslJzHHIhR3juDJwgS9197FGEn/jxS3CNd3bn2cPWu74Te5pJBRvq2c7XmZnSCtt9
X-Received: by 2002:a05:6102:c09:b0:5db:ca9e:b57e with SMTP id ada2fe7eead31-5dd892c28b7mr1623489137.43.1762369549100;
        Wed, 05 Nov 2025 11:05:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5dda1d361ddsm2398137.2.2025.11.05.11.05.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:05:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-640ed3ad89bso166538a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762369547; x=1762974347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ooi4I+mhmFHAKQDL7c+9BQJYIK9Wnzd06QWW2wK04G4=;
        b=Bk2HP3K+UIr+wtx9pu1WgURif4D6qed0yN6LBgqrxSQDNiWjAocrSxP7QFdfjsBUYi
         brB+HcMf9AiwiNqK5/AXDdfkdlnOQD/BsR6PwwA528+O2gAhfAMrPrqj+cm6pOAgm8cf
         HiqxgCWn73HEsHYpZ8cWi0yrE3EPGhElosC7s=
X-Forwarded-Encrypted: i=1; AJvYcCXA3Fz69iQDXopRpL8t/8aHiWjjwzapH+dMr8dnDlYNRuYc9zleGKOIMFqq+QnHEO1Nh6IqNvA=@vger.kernel.org
X-Received: by 2002:a05:6402:13cb:b0:640:7690:997e with SMTP id 4fb4d7f45d1cf-6410589b532mr4469832a12.3.1762369547556;
        Wed, 05 Nov 2025 11:05:47 -0800 (PST)
X-Received: by 2002:a05:6402:13cb:b0:640:7690:997e with SMTP id
 4fb4d7f45d1cf-6410589b532mr4469810a12.3.1762369547179; Wed, 05 Nov 2025
 11:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
In-Reply-To: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 5 Nov 2025 11:05:34 -0800
X-Gm-Features: AWmQ_bl5sAu4acxptbQQWQKxza7hK026iidWM-ZCPTg7etQbj3JqVyEA4gUc-mc
Message-ID: <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
To: Breno Leitao <leitao@debian.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dd822a0642dda2fc"

--000000000000dd822a0642dda2fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:02=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
>
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
>
> Given that tg3_get_rxnfc() only handles ETHTOOL_GRXRINGS, then this
> function becomes useless now, and it is removed.
>
> This also fixes the behavior for devices without MSIX support.
> Previously, the function would return -EOPNOTSUPP, but now it correctly
> returns 1.
>
> The functionality remains the same: return the current queue count
> if the device is running, otherwise return the minimum of online
> CPUs and TG3_RSS_MAX_NUM_QS.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> PS: This was compiled-tested only and NOT tested on a real hardware.
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index d78cafdb20949..fa58c3ffceb06 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -12719,29 +12719,17 @@ static int tg3_get_sset_count(struct net_device=
 *dev, int sset)
>         }
>  }
>
> -static int tg3_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *i=
nfo,
> -                        u32 *rules __always_unused)
> +static u32 tg3_get_rx_ring_count(struct net_device *dev)
>  {
>         struct tg3 *tp =3D netdev_priv(dev);
>
>         if (!tg3_flag(tp, SUPPORT_MSIX))
> -               return -EOPNOTSUPP;
> +               return 1;
>
> -       switch (info->cmd) {
> -       case ETHTOOL_GRXRINGS:
> -               if (netif_running(tp->dev))
> -                       info->data =3D tp->rxq_cnt;
> -               else {
> -                       info->data =3D num_online_cpus();
> -                       if (info->data > TG3_RSS_MAX_NUM_QS)
> -                               info->data =3D TG3_RSS_MAX_NUM_QS;
> -               }
> +       if (netif_running(tp->dev))
> +               return tp->rxq_cnt;
>
> -               return 0;
> -
> -       default:
> -               return -EOPNOTSUPP;
> -       }
> +       return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);

The existing code to use num_online_cpus() is actually not correct.
This is more correct:

return min(netif_get_num_default_rss_queues(), tp->rxq_max);

I think when netif_get_num_default_rss_queues() was used to replace
num_online_cpus(), tg3_get_rxnfc() was not properly converted.

Thanks.

--000000000000dd822a0642dda2fc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAq54X6
LbigKCMQcj9cwpsJfC5jvKkzzZTwsebkTdeIcTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTExMDUxOTA1NDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBFlsrx+dB92/ImjyP1A47mzz9dFSt8SR+PzAsmK3PI
iZDPIKZ7hoiOiGPZKP6kXMgqmBrls96iNg2sk3oT+UhYLCFQROyq7NFNdD+Shas/jFiaVTYMs26B
aXATrN7F5f+SmDrXeA/v221C9JxDke+oKkDkhhGWsLaAlm0LL5TAYBVHbHemPu6ZyZCh4QZmNYeS
C7czTBI7s1RARi1fodWlL9on1Ehip2rsAu95z3RP6VfMVAvQ4YYBSrPByccP0GYPof5XIkUvgFqw
fW8JsMJ9Sj3i38SimMBU29nToOkA6lCr/KVg8obvIu2B3qVQ0sktWxoubbEtuxMMsuIBIv70
--000000000000dd822a0642dda2fc--

