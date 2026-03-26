Return-Path: <netdev+bounces-271962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGfLFsMIxWnn5gQAu9opvQ
	(envelope-from <netdev+bounces-271962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:21:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5492333388
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDC2E31AA42E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AAB3BFE34;
	Thu, 26 Mar 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QeqPz70j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23333ADA3
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519165; cv=pass; b=UEfjCaObsUptg3JmRNZP1rrK3dM4e9AfX1jCBqffB8xoYYB5mdrcQ+gjHS0mfnWtS5afD0hfEuZZVXgwaM/vwHoqqTpgCLpB/lel7usmzB4+6FK2WcVqdibdDU+GHKn9eO7VCj+eBaWTpS3QCd64SPEBa7MDPQ+Z946DtRGf2vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519165; c=relaxed/simple;
	bh=MBrQaJnwG9EkoP2TqcHnQupba7yAK70Eu1fDX95hjnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im9xZpoA85ZRbTndvpWOKue7WbsNqg6jjAa1vUNzqsKzftMrxKrHHvJbzTDBhT1X4ezHuRU0fRirWgfeSUqFYNn05Q1l/IhcD/ynLsETehfWiZTMgmw/aw8mADopOjWJ6FWAAGr7feFx3giMc5m+X6nCN0t3rv8czPy93gLYLbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QeqPz70j; arc=pass smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cfdac74050so105087385a.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519162; x=1775123962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it5mK5v9LsFZnrXaPWXFyXSV5xVVCziD+nyYK5mtpQw=;
        b=XW9shiGSv57Uu8S/0s6098jCoAN909JjpYJUl8Q6QzvNgPijoAuE7GSu4xjhu3/Ij3
         JuR/MtbH3bhK2JbLv6bkaMSL/0v9Upd7fodGTw1xb2/VsQoi2R70Im8BS7pR/Si/PAQA
         yKqeZAIBtfdzP2NW+conTcutBOA2oP6TTLzwIhhTu60Zq4iRhl1p4QkS0AoXPQ90FAcg
         Ti6PwiybiXaX+iEkHl/UM6497a2YWtJqswVm32ZSKOd5O6KRinBj71DlLz0EiPEBPUMC
         tIhaMnp88UVRbqebE/XpUNq7fY6mzrOwApNwAwI2GnUS5oe4+UuVCZ0bHDc+6E4/u/V/
         AlCw==
X-Forwarded-Encrypted: i=2; AJvYcCUGuY/GNS9F1qSieLYN4eBGInSOPDmSISCWUQyloZYP6FhU4DVV5hwSiy6cKYmJeJ4sw25f5UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDLMkgv0kjmoz0jcu2wgv5QevbA1V8fzjf3IIXGFAo2UR89dnk
	5CekLpeZWgkrf6E0SP8j5PEDva2/0YpZV6PTrAwEqZX1Swm4WGjQhdVoj8AzMJZO9Vr8en2ETRQ
	u1Dm+bkrH7nzapZtUMj/RUZgOsB0cjXRz5cMrzSlordqve0uyYz0RxtCGeWR8zTP1inA+Oipa7x
	60ZKyQ21JVoZ8GChpIVCwqtIjvoEdqR0SiIhH/MNxiphROuU+eN9zCvbr+jI3m/wOFm0WVsF8jy
	ESspY3YIUw=
X-Gm-Gg: ATEYQzw2QZsM3sKwVQthgbVy5/t5CdtghLcmE7ZTPXTDvwOU4d4LI2x9IY79jzB4662
	eXe2Xe8GGL2M9GhwUSPUOdE21NnypJuWxqozm2XFB2gqy0lZJDtUZUt0/WyWHQX0wcMI1++4BSx
	6fmT9wyWwOUAS/EHKjZLltbo4xC29NzsQ7TQhQf84pU6b9b029R1FcRHKpaHlBCAHQgwo+v78Zm
	EbO4E0bte4iOdUK2pwwhv9f9PKUqkANP3WtJrT/rHrFsjIQssNOoCXLw/ij8qbzJgf+kKsvpEse
	CQPJUCKteldki4dho1e4nJkvRGvIYqu9t7w2lvv9qFtv/a+soypxYh1adjs/97VHkPExyr+Pd4q
	U+XY7IYTsVvb5FhidXhB++mKdqv8h80Vq8yWqcM/FTJopV/yCKVS81YwWOfBXjpUsICplmGojeE
	wVbdJsHcdcuIJY+2aHz85AdrAXhGYwdNuTLXVX+Gjoy1CVJ/4o9SCufOz+
X-Received: by 2002:a05:622a:1997:b0:509:18f4:6dba with SMTP id d75a77b69052e-50b80e72436mr101280931cf.62.1774519162223;
        Thu, 26 Mar 2026 02:59:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50b922b8745sm1865791cf.5.2026.03.26.02.59.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:59:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so2283344a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774519161; cv=none;
        d=google.com; s=arc-20240605;
        b=If+MoBXkZKsajn5wrgilGTUL+UKEd1vppdgj9OxcBvImya+6Bmoo/aoFLP/lEPOWWq
         MfIEpGCyRoqCIhouVnAXW5QeOeQ3vbkynU8ogB+8qnCy8lOgpTkb56MKc2UHQiboZAJ9
         qKRg3L4bUWXxQehYBUCehH9HPlaoEJSDeAd/uHGqJH4J9JuZ+wDMmxT2nNHfDj7+z0Qu
         mO38v1sVdGLXlx2KBTyz9jhrwHXi68+qamlcmli2h3qgHyoRaPpgfNJWxCtfMkuGMiTl
         DUK+urjG3QYKgjNGVVUjrpHMiLNC2DAI00TkAnKbbTZvESgJyanDY3stqd8uScpBz/VN
         7M7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=it5mK5v9LsFZnrXaPWXFyXSV5xVVCziD+nyYK5mtpQw=;
        fh=3GRb5VkxKq6lQK/7PY0DGhrxoiN+PnDMo5LpxPpLIIg=;
        b=Yqsun3B2ExVUC5gct8ZLydDNS6LwFzkANmyYItjUQj2H8Xh64DTJlemr+7dKqsh0rQ
         uetUTQAKgzU4fBRoY++55rwWywCstoQe2hqRz+ywLNOa5ySKeon+jAzgDg+5wRzjcduX
         khAA/YhL1YzxZt41BvRev4x67JlcInAVIDcg4bo6UBXg2A8LYdh/hgrGZIZnYCF0/EAi
         2zx8S+gl8JzQEYVB4IKKwk4xHsbwzGhLlrlNT11E2gatOHSyg46AzzCpxCvn6sPaxYf3
         rf9cToWGa6pulYXLe4lxYqJmTkcji+UcBE/cwKd9Ccu+5TT36u30gJzMNOHVUJfXmZxa
         rf4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774519161; x=1775123961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=it5mK5v9LsFZnrXaPWXFyXSV5xVVCziD+nyYK5mtpQw=;
        b=QeqPz70jSCiVs8xlzyH2Ctm2jHjJmcsthtnIJlZahUW3gnhAlMBgVi4CwB8GkUFZQ5
         Pc33xj/dUR7mjCsiDrHVZ4HEMIgkTsFext2LxCSVnPvKGXZsMZJal0PtVdP2/9ldzRG1
         Jt14RJTLUg+bRRFPqkhlw1LHE+57/BFmAkyUk=
X-Forwarded-Encrypted: i=1; AJvYcCWGYQR/5yglm/QWNdH7YShnApnwyA/w3hMYyUscC9w1h5Zl7LJo9BO/7wPdLr5v3UgdkT86M34=@vger.kernel.org
X-Received: by 2002:a05:6a00:814:b0:827:3bf8:bdf5 with SMTP id d2e1a72fcca58-82c6e160d22mr7008951b3a.57.1774519161050;
        Thu, 26 Mar 2026 02:59:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:814:b0:827:3bf8:bdf5 with SMTP id
 d2e1a72fcca58-82c6e160d22mr7008933b3a.57.1774519160620; Thu, 26 Mar 2026
 02:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325112054.108988-1-tbogendoerfer@suse.de>
In-Reply-To: <20260325112054.108988-1-tbogendoerfer@suse.de>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 26 Mar 2026 15:29:08 +0530
X-Gm-Features: AQROBzBi03Gig42Je1EudNZBQb_oKcG8E7YRmcMPDQPOOqkFkoLwRDqdwjrXPFM
Message-ID: <CALs4sv1qp7Gz-WsuNj-zvx2z=kRFLqxQnn-iUpwj0pTirBCydg@mail.gmail.com>
Subject: Re: [PATCH net] tg3: Fix race for querying speed/duplex
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nithin Sujir <nsujir@broadcom.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000042557c064dea70be"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271962-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: C5492333388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000042557c064dea70be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 4:51=E2=80=AFPM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> When driver signals carrier up via netif_carrier_on() its internal
> link_up state isn't updated immediately. This leads to inconsistent
> speed/duplex in /proc/net/bonding/bondX where the speed and duplex
> is shown as unknown while ethtool shows correct values. Fix this by
> using netif_carrier_ok() for link checking in get_ksettings function.
>
> Fixes: 84421b99cedc ("tg3: Update link_up flag for phylib devices")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Thank you.

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 21a5dd342724..73a4b569b03e 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -12299,7 +12299,7 @@ static int tg3_get_link_ksettings(struct net_devi=
ce *dev,
>         ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertisi=
ng,
>                                                 advertising);
>
> -       if (netif_running(dev) && tp->link_up) {
> +       if (netif_running(dev) && netif_carrier_ok(dev)) {
>                 cmd->base.speed =3D tp->link_config.active_speed;
>                 cmd->base.duplex =3D tp->link_config.active_duplex;
>                 ethtool_convert_legacy_u32_to_link_mode(
> --
> 2.43.0
>

--00000000000042557c064dea70be
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDDH4yd
t3r0woYv4sAwgyCTSMPJaMGwvomfQ6rzh8UZMDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjYwOTU5MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCm8lLsl6NuSL6/8VL0wW0zpoXS/Zq8jkEdDZFIbJnz
gdCA+9TnQVTR8Mt3eh9E2DaoU12f3P4t9KwGIMVhD4XMpIwxBCCyO3yNHGpf18jvwv8nrJ7OEWhx
NbGWNM92HDwvWiS+Oqa35/dWKblVC8QyfN/dctieN/b0rRF6O0D4OfFyJ7P9BoWbC4uQh5MCOVjU
jFcXwn56SyCbOvDm4yCbkbn4QRQIGQ4kbLz2+9rEAD8LgfBdXoswiVm+/89bEY0vWO95L/KdJNiD
9vgof4Oe23U+qC0zS+QYhSbCBBoqiDXLbUCi48lHk0V0cAojn/jsvJMObYNerTueEcFH5GDP
--00000000000042557c064dea70be--

