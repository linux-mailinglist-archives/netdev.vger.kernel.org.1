Return-Path: <netdev+bounces-252257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GUiH7PycWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:49:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3A64CA2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF98A509676
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A853101C2;
	Thu, 22 Jan 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MuqdUC9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C729DB88
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075065; cv=pass; b=ufLd0w45QhrgbzT/3f3QcEoHH//WtFVX3kHDnyEQuNnBRX0bfIULhZCfQ6XugdrxC3MLWDzNJqq+8s/BkFZVPPsqFihvDAhpeevG0sUNxMaG+j07y9CIC3pYQRSMNjeyaSiPSXWEYgBK9nCpfHY4aYege0Nxxy3YP62BTPlEHUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075065; c=relaxed/simple;
	bh=9oUyGmPOjHZCJLoDlJrWZ4Jt/qZNPYP6QXm1VxMBki4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCrXDkArlkFKf9o92O24RQy0cnCuIwhxgG0tyISXEQVSu5j103vGh2qV+sUE7EJJHsmBueHKeIdsiw0u4+kLyHPFTbwdfJC29XEUytexLEE0UbTWpgmeFIb1LC1pMCP0T+WJsLifU5ihzkD3RFcunV+dwuJuBw8JA0SqipO54Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MuqdUC9b; arc=pass smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-124566b6693so2165929c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769075063; x=1769679863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyklrThIIAGL1LXJOZg6CejubZvjpFddsN71DIKmab4=;
        b=Fubkd/Xgf74k6Mi3MqcTcjti90tnWi3ACVGKzh9Attkd+O/USEFE6NwElXc+89/VA/
         0ivX59rYV4Sn0FI0y721HmXb8CBnTgqUmcIVhdv+mNuNCwShyp2agNkMrw/5iZRaGiBE
         B7cuhNEBWnFWBN1eNuXlHVeURNuhSt72A7FD8FSGtQuIYdan9C58An5OxOPdeR6KsPMV
         GFjSq0xmDXNKbZPTsQ4cPXq26B4c59qUyoMSHwdu3NX3Glpzfg5dQTXaSJyK/muCU2rI
         oJd6u3zVQdCFjVXREDmicXvSpa6PFD1tM245fcEhmj9sb8R1DqAk62ZAU1jEcx77CnPm
         hW5Q==
X-Forwarded-Encrypted: i=2; AJvYcCXk0juwL9z/NUTyFMhg0WnRVJggsSRbkR1hK6YnHqhSuLaQU0gIkdQtb2o4o6CB34UwHT8nTk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrutdnZyF+SrXo2hDf8y8sjIE2K3w4mYIy45FlurUTpWsE4ln
	WlpJCGE3TcTWeGX3zVqhv8cX+R4gAoUdR8Nr85r5sdgMc2djDC8kdFRGZFRUSh+ughJXe4kkqdW
	5tuixvy7gURMEkMqkZ22SYTlOwIm/ybU1M458+q6TAfnU0RnAlz7aLc4n2h7/cqaZX48jtyw7G0
	K+Ma8PR5KSotr9AOTz0hmU3efY0FDTdhODSiPV7SkUOMx/ARzpgINL0v5ctkzwKGUN/mMZKcvfV
	93HbBG2Jjc=
X-Gm-Gg: AZuq6aLgoyRD7uQz2luQwDB35DsBkfYQxontxfPoc9gpQPr6MgNERJCsOpn2Uyd891J
	0DMWemwqQ++6nsKAHJG1OSs9GahgZH+F25+nbIs+B3t8ZPjAQ2I3IrJ231jZX/4Um6nC18QSaTe
	wQOWPsmzXt6Vo6fgJhoU0S04TNH28CNnQCPLDSeCnRzjNcEHAwsvdihfhQe47SODkzu2FhAvrmE
	X10YrRqhF+HXMp2epozVxlK37RQxdbU3abctK1rQOEqxR7xZjG/m9G6ecWsIpwIdzEGzims7l7R
	p0h1uABvQM0U505DjLFAmHblEomCdhMyO3g4jtmLBOLdmnJyHj1smHVCyh5iu+bfmTfX5UuYVwU
	JoD9ZzeUu47D6dt6s/B4058esGINBf15CZqlz4FYH6ucmuiFig8iFxQ5vvrBMGjgfj2qFBj68es
	zeIjg4Ox0LaRRFEnWa5zsx//1p6r8TA/YIzzhuJHwRNa0hJDM=
X-Received: by 2002:a05:7022:b8f:b0:11a:4016:44a5 with SMTP id a92af1059eb24-1244b3706e1mr14511019c88.24.1769075062959;
        Thu, 22 Jan 2026 01:44:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1244aed80besm3899809c88.7.2026.01.22.01.44.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 01:44:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a58c1c74a3so8534025ad.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769075061; cv=none;
        d=google.com; s=arc-20240605;
        b=N6OFAZe3f10hflh1eHZBLlDBuMQFiZcZ2l5JhxiWgG3sFwUvRcxis8XTEoM78k7I5b
         PFoCaBZ9Ksi7106U+OLZrNd9d1QNHzx4okMtJEIT2LuUPSqCmMgRZSkvi+hIbJdEmLzQ
         C5Cae7B/3fo02Nl12uHdQDn1no7UKuYaMs2r9VC56r1GuwkyAVY+TBi3wQx4avMFmSjt
         1Rapn2bUSYMW9qbOFiqeEL2qvCFCnnpZi5AzgCBdqWwD/HNqDWBvS7Hn1VifaL8uLbv+
         hieOD82uV5jpDlAgmMREYIRTGVyG8uuy6CwmaiOWftM0kCcXOf0VwfMS79HFeXhJ5nSu
         NWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xyklrThIIAGL1LXJOZg6CejubZvjpFddsN71DIKmab4=;
        fh=EEAW8QuTyILbupALRAO0FSo2K8Skko+DFbGA8bvSMI0=;
        b=Q5VXIzoodC+EIJfG0YS9zg4jI2GS69Iir+d2+Q0GlcBl553C4xuPEKqmh/z336hbcu
         +5xNZxrY0qt2eYkURJ9XZReRO0zZI3zZcniGUmCu+9wQuvuK3qycTnvSeM4Ajj32tYxE
         x14/ZHSJOrLu1FacwYO5ll6GHn5c4OmaXUJRWoCBi1tYCXkt7gDT8ZM+9BFfoSFqOTrg
         5uQEgXiP0+vVRNv5Bdv2SBFAkG5b+YbHZNyxHUz1FfWuKe6KxesnJSXInLQVjd2vBF4f
         2uVAZB8akYHRfKB+STCNQCrBRQ3GadoTdi9xAqUnePmKZ3yYw/Mzu+k49dXyGNiNP1ou
         yDvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769075061; x=1769679861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyklrThIIAGL1LXJOZg6CejubZvjpFddsN71DIKmab4=;
        b=MuqdUC9bTtC3qAfbPtyARa0Qd+R4Iz5s0bawdCoEIEEGpjJlFJXojGsQYf3vLRPQMe
         Yx0U45+F2x7NdqmoeM94NyemsHpfmdCxvvzgKkUFIuZD8bTF/SNnphYrS5X1Zb5KPvH5
         Jqp7ZDBiH0acHKwwEhi4RXH0pydkPurZukR0I=
X-Forwarded-Encrypted: i=1; AJvYcCVaT1oo6fenSfd6aqL6LmLWnbCP6URcUhji+H0BG7reOAgPlY+kWsMJwPgcxBKRG6paIDlMlxg=@vger.kernel.org
X-Received: by 2002:a17:903:248:b0:295:4936:d1e9 with SMTP id d9443c01a7336-2a71892947dmr198003985ad.36.1769075060988;
        Thu, 22 Jan 2026 01:44:20 -0800 (PST)
X-Received: by 2002:a17:903:248:b0:295:4936:d1e9 with SMTP id
 d9443c01a7336-2a71892947dmr198003845ad.36.1769075060611; Thu, 22 Jan 2026
 01:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122092623.479177-1-zilin@seu.edu.cn>
In-Reply-To: <20260122092623.479177-1-zilin@seu.edu.cn>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 22 Jan 2026 15:14:08 +0530
X-Gm-Features: AZwV_Qjpj8byzDTG6KRCxMovGnwP32vP7Q5SUMJHLjA2FXyx4Dsakz5QYHEJQFQ
Message-ID: <CALs4sv3STBARmMOZiBSXHtFkXd3E_hJwjWJ0x8zJ1_cYYw=ioA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Fix memory leak in bnxt_alloc_mem()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: michael.chan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009d44e00648f6e22e"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-252257-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: D5A3A64CA2
X-Rspamd-Action: no action

--0000000000009d44e00648f6e22e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 2:56=E2=80=AFPM Zilin Guan <zilin@seu.edu.cn> wrote=
:
>
> In bnxt_alloc_mem(), the function allocates memory for bp->bnapi,
> bp->rx_ring, bp->tx_ring, and bp->tx_ring_map.
>
> However, if the allocation for rx_ring, tx_ring, or tx_ring_map fails, th=
e
> function currently returns -ENOMEM directly without freeing the previousl=
y
> allocated memory. This leads to a memory leak.
>
> Fix this by jumping to the alloc_mem_err label when allocation fails,
> which ensures that bnxt_free_mem() is called to properly release all
> allocated resources.

This fix is not needed. The memory is freed by the caller of bnxt_alloc_mem=
().

>
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
>
> Fixes: a960dec98861 ("bnxt_en: Add tx ring mapping logic.")
> Fixes: b6ab4b01f53b ("bnxt_en: Separate bnxt_{rx|tx}_ring_info structs fr=
om bnxt_napi struct.")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 8419d1eb4035..99dae75146b5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5491,8 +5491,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool ir=
q_re_init)
>                 bp->rx_ring =3D kcalloc(bp->rx_nr_rings,
>                                       sizeof(struct bnxt_rx_ring_info),
>                                       GFP_KERNEL);
> -               if (!bp->rx_ring)
> -                       return -ENOMEM;
> +               if (!bp->rx_ring) {
> +                       rc =3D -ENOMEM;
> +                       goto alloc_mem_err;
> +               }
>
>                 for (i =3D 0; i < bp->rx_nr_rings; i++) {
>                         struct bnxt_rx_ring_info *rxr =3D &bp->rx_ring[i]=
;
> @@ -5512,14 +5514,18 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool i=
rq_re_init)
>                 bp->tx_ring =3D kcalloc(bp->tx_nr_rings,
>                                       sizeof(struct bnxt_tx_ring_info),
>                                       GFP_KERNEL);
> -               if (!bp->tx_ring)
> -                       return -ENOMEM;
> +               if (!bp->tx_ring) {
> +                       rc =3D -ENOMEM;
> +                       goto alloc_mem_err;
> +               }
>
>                 bp->tx_ring_map =3D kcalloc(bp->tx_nr_rings, sizeof(u16),
>                                           GFP_KERNEL);
>
> -               if (!bp->tx_ring_map)
> -                       return -ENOMEM;
> +               if (!bp->tx_ring_map) {
> +                       rc =3D -ENOMEM;
> +                       goto alloc_mem_err;
> +               }
>
>                 if (bp->flags & BNXT_FLAG_SHARED_RINGS)
>                         j =3D 0;
> --
> 2.34.1
>

--0000000000009d44e00648f6e22e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAPM6ez
c/1ivmTu3ws1n8EmOuhfjnHsaRKsbo4zN1Bt8jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMjIwOTQ0MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA1jAeK1SHG4EKi7Upuw0LCeFvqj1PNz71qK2G48JUf
M0Tv8178ni0cQKIvHHDp0hT/7+OwxKEsvSBVgyceK3aTfqELioF5kDsP1x7j5+6EKOWCrhK9Kryt
vmYHJ+SEZthWqGFeWVFBCZdTJOywTUzRW3OdSNuNYQ/T91mkAf8RgffsyfTy1Z25bT3+TUm2Vi4w
hjw5G77hd4kK6BEBBekIKamvKQXSOElfVK5k4AX1AAHb+SULtc0h869vXqgMYhS+RufSIKGxcGl+
0fGDCnlPggfhNK4pXunDkV6M+TdWI1XCqIY00WtI5ft+gq7UF4PMf9s03iqLLmnwk/r5IH2w
--0000000000009d44e00648f6e22e--

