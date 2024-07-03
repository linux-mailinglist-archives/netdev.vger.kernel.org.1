Return-Path: <netdev+bounces-108856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096F9260D7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE18C282850
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FF17334F;
	Wed,  3 Jul 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H7jiT0OL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA341E4A9
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010974; cv=none; b=CV8gOaibrKOdyMM7OdokZ5uCVh2+HNR9jv6nXaElxwgfN3L4ulRKa7iEmQJ06X/7ftJansFSMJjwvyo/tawcn/pbTsAnjn2IhieggR8h4cUopfxwnrfOwC/YvxSZ0O1aDf/kKZa2fMnRGPYtb+r68/tYnWStpSfVDBmlNpKciGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010974; c=relaxed/simple;
	bh=2Cjt3LeW7A4sXv8CMJJR/eoJP77eQg/L0qBF+EA0wIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOyOnL8TheOWDyQxrmeRwF/JHFYGavhm+EMOb6tv3BsTHqhXDEFSEX45Sq5tEKa6SOndXONablEGymZK+GRL39D8HV+mMSiG+tezljVE2AJ0oLV9+lhSNL4BKX5Si8zfWEAT1Ssk6E49Lr1b9a5TrCMCj4md/fSIryib28wtZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H7jiT0OL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af5c40f8aso120659b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720010972; x=1720615772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+x8401gspumj95wdUbmTIQ2qdjCjAnMWtiFjH1IcFSA=;
        b=H7jiT0OLwLwCaZn6P2iDmZxWEemHk+BI1f247axU13SC0V+xel7DeedAFdapbPvuET
         NIwfDIAvsa8Egvm0kzPDW9Pw+H0Kf2E3P5HbcaxRvKkwo63midacFqYqGk25IfwJWCbS
         geuW7/OV/7kgXzvom+sKQHspbwuPTR9l4QQLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010972; x=1720615772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x8401gspumj95wdUbmTIQ2qdjCjAnMWtiFjH1IcFSA=;
        b=rOHLb3mwhbuMEE6s5RfQKJHc9QIQLfBhswDDMnEzJyBQg7wn/y+2W/RtsaDlWaRwax
         Abxtw5HXOzPNjQMvW7Durf8aEe/2qQ8uwr13ZpSb59S0THcYzH6iE+o070CMecqxPaFj
         nc84Gv5oOmZbDxPmhvZey8y/viX949d57JbWiFV/8OXRVrF6riJsfEOjyJ5uGZCeDsiQ
         B2BAePTsJjLLA+94fNGPChrLxwbbI0o48qVWw9BjxGst0Y97dhO6IlTLHCu1/9oUeyBN
         jBS+F4XAaiZ36n1i6Imt0GEJE8x3jIIv/6gCF0CvwByoDGyXG53aAhwin0sa439Swd0O
         m+mA==
X-Forwarded-Encrypted: i=1; AJvYcCWaUYPa4Io3Tk0Hm4yjI/GGlQrPnzr+kVgUIJS0+nMx5+Vm1mTMAdSTndz4vRkN0/chYWh13i3pjiDXSgg+MT5nSpGUbH3S
X-Gm-Message-State: AOJu0YwSlWjrr/PozEXtpvkz/Mmo/q6PXxVHirkWYHRYpNFrrAIaFziM
	58bP1PMDmuDbLICrCPF2vLZEbGbSuKrCVyQs7SEjvA55lpU3okAoFfKMylnIVfNAYdMFtnLvkuP
	8IaTuUEHsUZ/swZdVUSL3MPOST2T8P/dbeNnu
X-Google-Smtp-Source: AGHT+IEmw4E3fuaineS56zV8eYyBDoGosfb06Rb45zcL9zdWrMlWLf8140ntz8596fjJ41/lgwcd4aqEzUtLv18X6EQ=
X-Received: by 2002:a05:6a00:9a0:b0:70a:f0f1:480f with SMTP id
 d2e1a72fcca58-70af0f14a9emr1145070b3a.3.1720010971455; Wed, 03 Jul 2024
 05:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702234757.4188344-1-kuba@kernel.org> <20240702234757.4188344-6-kuba@kernel.org>
 <575edb3a-3c52-0bcf-4c19-b627dc99d2e5@gmail.com>
In-Reply-To: <575edb3a-3c52-0bcf-4c19-b627dc99d2e5@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 3 Jul 2024 18:19:18 +0530
Message-ID: <CALs4sv33AdVBNomJ-tnZCmn8BeoPvVsSx9s0VUhocHmbp-AE=w@mail.gmail.com>
Subject: Re: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to
 .create_rxfh_context and friends
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, michael.chan@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000007de1061c574381"

--000000000000007de1061c574381
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:36=E2=80=AFPM Edward Cree <ecree.xilinx@gmail.com>=
 wrote:
>
> On 03/07/2024 00:47, Jakub Kicinski wrote:
> > Use the new ethtool ops for RSS context management. The conversion
> > is pretty straightforward cut / paste of the right chunks of the
> > combined handler. Main change is that we let the core pick the IDs
> > (bitmap will be removed separately for ease of review), so we need
> > to tell the core when we lose a context.
> > Since the new API passes rxfh as const, change bnxt_modify_rss()
> > to also take const.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ...
> > @@ -5271,6 +5296,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
> >  const struct ethtool_ops bnxt_ethtool_ops =3D {
> >       .cap_link_lanes_supported       =3D 1,
> >       .cap_rss_ctx_supported          =3D 1,
> > +     .rxfh_max_context_id            =3D BNXT_MAX_ETH_RSS_CTX,
>
> According to Pavan [1], this limit only existed for the sake of the
>  SW side (presumably the rss_ctx_bmap), so probably it can be removed
>  in patch #5.
> The higher FW limit Pavan mentions appears to be on number rather
>  than index; at least I can't see anything in the driver feeding the
>  user-facing context ID to the device.  But I don't know whether FW

Hi Ed, you are right. It's a SW side number and the device has no
connection with the ID.

>  has any opportunity to say ENOMEM, or whether the driver needs to
>  validate against the hardware limit itself.  Hopefully Pavan (CCed)
>  can elaborate.

Because the driver is not aware of the hardware limit, and the limit
is dynamic, we can rely on FW to know if the resource request we made
was honored (there is no direct ENOMEM mechanism)
The driver already does this when we make a runtime check for
resources using bnxt_rfs_capable() when an RSS ctx is being created.
But for this version of the driver, I would prefer to keep a limit
because we have some FW improvements coming in, in the area of
resource management.
Though removing the limit may not break anything, I'd prefer to have
it removed once a FW with improvements (indicated by a query
flag/caps) is available.
Michael may also add his thoughts on this.

>
> -ed
>
> [1] https://lore.kernel.org/netdev/CALs4sv2dyy3uy+Xznm41M3uOkv1TSoGMwVBL5=
Cwzv=3D_E=3D+L_4A@mail.gmail.com/

--000000000000007de1061c574381
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOXvzUReU7RtTnsY4R4gm58C86aol6wC
YfT5TN5OY4xyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcw
MzEyNDkzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAqkgxUkB8n45jjsleLJOSebFK1a4eWFck5Uz7RjAL+7D54RMCH
FsEMIjSJnIs4z8HPx9EtTJzF6WKofUxSoQIxKRuxpg7FF3hJrKlZu4DaQL0i9LrbilEz2+g+wfdb
6yU1wwddBVrFRGHpPEHFLt9qAOJtwyRnYHBlYh3kAdHgMwZa2NSMhjnhXSaH3PLFAWyndoAjJUJ5
a0Z2FLEembUn5LuK4rn79Mjmp4b5U64wDzi2ZrFiEHL1xE8ZHxZBZostt1Wht//L8XwWMr/gfmYZ
DuHRTXK9oUEiFwarmSVSJrMzIyZunuAMpuX6yVf5W2hUHK7lvVvwdwSkX402tqhJ
--000000000000007de1061c574381--

