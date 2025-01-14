Return-Path: <netdev+bounces-157990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8004A10007
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 05:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5553A76FF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BA230D39;
	Tue, 14 Jan 2025 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WVsVeVRr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3602309AF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736830648; cv=none; b=fr0TvPcChGEJSJJgADXQ4VfhUikqBOqG+5E8EJVJ3rWINapS6zStrMcod0zM+8eOESn+/1Lu2/VZn9bhXOxHvgCC9rtenJaKUjgaPc1jsFEPAvwV7wB4nAx9AAVzhG8XM7yYEQ87akxpz5Kj82b4RHwC029zKD1nqIWKsqITCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736830648; c=relaxed/simple;
	bh=eKqmBzeLc05L4io1olbQhrG8rM8FAoCEk9isFCnvqNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSvTHN96aQuirYvGHgb5NvwKtrF91LlaR8GLcUDfQCCPOXCxi6mh6L3/Ir88GnSPjI6Y6vdshJ4AM1+ecT2/TzT4tKuP8ymWz4WH3mzMnFEa/Tgp/Vo+f5SWG034aHujwy/8/0AlYv/yNUYXUhiE/BRwdkyfnihRfa+4r+BiWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WVsVeVRr; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51873e55d27so3034830e0c.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736830645; x=1737435445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gROxy6ciwRdz47BSLb2mPCFsQp9R9L3rKYPPME4sh5c=;
        b=WVsVeVRr61P8DmuuE89sSS+d4Ytr8nywPqbfJFwYAI4qecDtldJviEju8FjiznSXs2
         WmeGeejNFXacchE/w8+UC+RdYtb+yS5ItFrKQsi9kxwzgRLlFsO8NH+LfCQpL8HZ8Abr
         7HW6YkkAscpU4g9/4BaLJzDrP/gGO70lbgJSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736830645; x=1737435445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gROxy6ciwRdz47BSLb2mPCFsQp9R9L3rKYPPME4sh5c=;
        b=uqfOhNkG5/NNoNeYJmOKxFMws0OeW22kzl2AZeE/kbuZ5pZ6CHQn0QffDsGXYNLJgE
         HSU4hpMGFzsJko8lp//3e08gyaR2Ix/u21yPomGiSQ7dsZ2QVr3evigJ7iqvnWxH0HQx
         zP9exaqDXTj0j9ysos/OvzAx070LnGwkL306gyyL8E5RfIZN4QYASgd/LFJgFmDy6Ysh
         FC1tcbOQVi1LY+uY+BDyGW8webLQcjhngpRrKZTSeote+BPZVLXwbIMZvHyVnoS/rqsB
         +wKDm7jk+a+BDgrRa2CxjOSuTOfuKdoAZndkcUhwLXYhCDg87kcFxEmzBFqAPEA1Lb4U
         eCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7L9znEQejqoy9sE+Mx8jlCz22w+NzhH9Zgu9VaVNbIfbYMEEzQR0lNeWZIt5ZdvyjyR7hLzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRh0wUkwKyefV1De2B6Lo7f3UWGg5KGnVyFpOGldFImkGhnLS
	qqNKfpYek5G+5qvOXEgWL8EwWVDhpWV8/zG0lLhHGkbpUceF1dZvVo+k086QZcyj6i2GypzRCxA
	p5/EzNG6k+0jX+65API9j1tjLQtBE/Rtitnr+
X-Gm-Gg: ASbGncuKz2XrcVoLkkMJd4oo2SDYVV+IjMXEpuvGy9sxH4JHObh0fUUOUFnzycDJias
	zBgpZDxclKSwe9MQtRwFrBC8KHYKtW6lGmgQD
X-Google-Smtp-Source: AGHT+IGJVKpajUdSaaU9QDZEPuG2elv3QQRA9lQleXkclGWbqWznHMKj7ulOu/9SvnDPkPEiEOs+RAh9wVvVRIBT+mw=
X-Received: by 2002:a05:6122:10d8:b0:518:8915:89ec with SMTP id
 71dfb90a1353d-51c7c73fb7bmr12280193e0c.1.1736830645393; Mon, 13 Jan 2025
 20:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113063927.4017173-10-michael.chan@broadcom.com> <20250113160105.GA404075@bhelgaas>
In-Reply-To: <20250113160105.GA404075@bhelgaas>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 14 Jan 2025 10:27:13 +0530
X-Gm-Features: AbW1kvblGC5Ifp0fKHoV7BoQoPnTov_tF48TGUU1jJWp44aVCheojg3KpIGI1kI
Message-ID: <CAOBf=mt5Y4YW+jB_4vsZyUHOBv=U2ffXq435EEFWPnKAy6=9dg@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx rings
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aeba9b062ba36585"

--000000000000aeba9b062ba36585
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:31=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Sun, Jan 12, 2025 at 10:39:26PM -0800, Michael Chan wrote:
> > From: Somnath Kotur <somnath.kotur@broadcom.com>
> >
> > In order to use queue_stop/queue_start to support the new Steering
> > Tags, we need to free the TX ring and TX completion ring if it is a
> > combined channel with TX/RX sharing the same NAPI.  Otherwise
> > TX completions will not have the updated Steering Tag.  With that
> > we can now add napi_disable() and napi_enable() during queue_stop()/
> > queue_start().  This will guarantee that NAPI will stop processing
> > the completion entries in case there are additional pending entries
> > in the completion rings after queue_stop().
> >
> > There could be some NQEs sitting unprocessed while NAPI is disabled
> > thereby leaving the NQ unarmed.  Explictily Re-arm the NQ after
> > napi_enable() in queue start so that NAPI will resume properly.
>
> s/Explictily Re-arm/Explicitly re-arm/ (typo + capitalization)
>
> There's a mix of "TX/RX" vs "Tx/Rx" styles in the subjects and commit
> logs of this series.
Sure, thank you will take care of this

--000000000000aeba9b062ba36585
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO/IoeyaQk0jLzaZG3HFbGo53mBY
vAf1ip/cAPju2cooMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDExNDA0NTcyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAgwaPOSyMzkkBQk+RD6WOKfzc+cd4MvKTEuK9OvcrVymg3
blvgMZBXJh36QUBC73VkvafdZsWW+F13QzjZDqbFrHDCTap7DJb1kt5WVenE2+TD59HDAlxyjpQS
/TA96l6nxcvvpmM/S4i/jpKUvvqlPN8gLM9HBx+OACn5NL89QHLDipEeRkI5DUwlz70JU73Llp3Q
KpUtMwMT7OYEW+J9LJDV7ifphP4z+qcCArAUoDXiyqstVQoQ9r++yo+3+RDnAlGSGJnAKpwl8HMx
pgBKERUzGJuigP9P0VXr/ofCq4PIGrpcGHvvfEFfdQ+sq6vFLnkwKM7NM/lLWGzx4V52
--000000000000aeba9b062ba36585--

