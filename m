Return-Path: <netdev+bounces-307766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NAk9KBqSV2oOXQAAu9opvQ
	(envelope-from <netdev+bounces-307766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:58:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4329075F123
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:58:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Fz9fjNmW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307766-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307766-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06DED30582BB
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3E339858;
	Wed, 15 Jul 2026 13:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E565334C3D
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 13:54:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123672; cv=none; b=U4UlIMK94ELIco8Q/AT6TfigXXsMaBehzG56A40itumqJ0M5/n1UtS6tQ941ib7qIIL75EO3KtrDiFWwJIja5U2e7mEuHj8I7yPb4gjoQV5F7+R+WyVANuZZLGneYZnTRqacpid98Z/6S4l2e3BU81q0elEzq1rb0qHXVh/8ynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123672; c=relaxed/simple;
	bh=yRVQhOWlz14iW7poHzvdYVzf1lPxMUlveqK4DYCoMLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JngY3KgSEPFdehxQuJqY6pNZvpZ2F2sioIkVLkGU9+3LsRso5LP3x1VBWNIwTSUGC5pH+2gW0K0k4yvwha2944+AyTxDQoYzgsrqleD+xe92mzmlv90U5ekRLxdCLm/F6OdUqmXZLL4JuRz1atWgkcqinM1oGeEYf55YKc5gcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fz9fjNmW; arc=none smtp.client-ip=209.85.221.226
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5bdc96b0714so4289201e0c.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784123668; x=1784728468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktbOE4+h01QNkO6N/JfRnMcBFPObitABCgwHYYzSoo8=;
        b=XHmBcNCDqeW48OWCnnjyL3VdyTkfLrRCa7khDRdQc0bFcW9f2JLbHMAq9eDxMxdhAb
         RK0qGxhNKi85i+TIeBrBV6WOkYumySp6sDkqsIQfpBu19giUAOphb3gcwWjYSu/G81Lo
         +OmlZIcEF664l35NLVse+qoChzXlOSgHz3GOD8EyKws49NT7r0hL1BcBURTAxsn/wCEx
         Dk4MxGo2gdDlEiCN7w52vKvS7gdBrkYzfWlr1GK34mv3DJsV4K0q+YsTLBJmTf8MtcKI
         UevK1eza1iCqg8cQE3K4IS6Q6uMH8DAdjzL/qFVnKXRCLXmWc5IGj3wel8tB8W1346BM
         6bCw==
X-Gm-Message-State: AOJu0YzATZKKlGQgeLK8n4A1Ucv7Elp3vFaf4EaPUK+bqElbDN9K3chp
	EZIU/mwVUfESx76OGW+Ub8iBNnN+rr3ET4BWa9yZ9CR+eqw48yQiz5PGB9RKtafdH4Lj7tdygVT
	KiUI0rhd/YMYHwIogU8lLZy8DONP6hYgYWHnUWgpKR6qWv7udFIT+IFon8pQRsEqSpn1JXLS1Eh
	DVBHfRlQmHnLmCe55nohctL09z3LKg8k0OI+QvzItuIskOhDJJg2+akzNUIDBvzcRJiqoUl3W2e
	Lv/QzWnw/4=
X-Gm-Gg: AfdE7cnDBxpWxtDu5teOs7xnJmni4zRwQnJrRSEsHPX19T2KR4TKh8Ft71nNjUZyjMf
	HPZsdRqMtcyCdCztyO2dA53uI4XA+dThwTCvXBfLs6rFKW+6Ok78bf+TvCNH+YmPZniSy7lMp0J
	+WvKxvyD0YBQp0D1edhpAbG3OWRjoQBOSyXbkukcbFH2s4WBlzw98O359K6Hpbk50t/BCNjz+lS
	5xw3d5Mh4XvyE8PngQVHHW6ORIRN/vLW+Y/aIYWIkwTKXzf/19tSXqB9A2d4Cwds1zHX7eM0Itv
	1FrPWg6wC9Uk8JjHNkkdk0bNx9nOWuvCueQxP+q9T1Y45ISDmb8eeI3grlFjGRp31zUTckDCopj
	ZuUXetj1ePo2Ko0EPUBX84iwmJi02Yxp97h2ZFmOyiZwZMBNLtd1g4ylPe6V10GkOHOrENeKfoI
	LEqeKa8JJwCiaoUuKn5Gn+Y3Gt2USYuYcSVqI60i0XlVa5uFzh
X-Received: by 2002:a05:6123:14b:b0:5bb:baba:61d6 with SMTP id 71dfb90a1353d-5c1250b0956mr1714129e0c.6.1784123667784;
        Wed, 15 Jul 2026 06:54:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bf6f7dac98sm2166449e0c.6.2026.07.15.06.54.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:54:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848860def2cso5866164b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784123666; x=1784728466; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktbOE4+h01QNkO6N/JfRnMcBFPObitABCgwHYYzSoo8=;
        b=Fz9fjNmW+u+zZU3ttURqvDHkjXcIcQuBzI6ghSD1wxNOTNa6HeAMjF1KzDwOj4jktM
         m/g3bnS6drSfm78K46LoSmG+S5RDkv2dIBocRrKTpeWulL1iShVgKRe4U/xHNc9S/q/c
         Zdb8xZ7myGFdP9qu7QPW/xzFZx8jQSetDTQ50=
X-Received: by 2002:a05:6a00:4c98:b0:848:4b27:36ce with SMTP id d2e1a72fcca58-84a673c79a1mr2407926b3a.73.1784123666489;
        Wed, 15 Jul 2026 06:54:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c98:b0:848:4b27:36ce with SMTP id
 d2e1a72fcca58-84a673c79a1mr2407899b3a.73.1784123666060; Wed, 15 Jul 2026
 06:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714082511.2817-1-igorpetindev@gmail.com>
In-Reply-To: <20260714082511.2817-1-igorpetindev@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 15 Jul 2026 19:24:12 +0530
X-Gm-Features: AUfX_myRpJw31ynJ2qn7fYjA_0AIOwWtkUokVx30Z8WgzYZOIJyyIlGch4Vd0rE
Message-ID: <CALs4sv1USjjUfEFHDfNawzjMo-WA=J2ayr--6vwpZ+SB0=W6OA@mail.gmail.com>
Subject: Re: [PATCH] net: core: use WARN_ON_ONCE in datagram iterators
To: Igor Putko <igorpetindev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000065fca20656a6a958"
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307766-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:igorpetindev@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4329075F123
X-Rspamd-Action: no action

--00000000000065fca20656a6a958
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:55=E2=80=AFPM Igor Putko <igorpetindev@gmail.com>=
 wrote:
>
> Datagram fragment iteration helpers check for invalid buffer offsets
> using WARN_ON(). In fast-path packet processing routines, a malformed
> skb or lower-level driver bug triggering this check can result in
> unbounded dmesg logging.
>

IMO the things that you mention as the root cause are the ones need
fixing.  I don't see a reason why the log should be changed here..

> Excessive console logging in data-path contexts introduces severe I/O
> latency overhead and risks triggering a DoS or system instability
> via log flooding.
>
> Replace WARN_ON() with WARN_ON_ONCE() in __skb_datagram_iter() and
> skb_copy_datagram_from_iter(). This ensures anomalous conditions remain
> reportable for debugging without spamming the kernel log on repeated
> occurrences.
>
> Signed-off-by: Igor Putko <igorpetindev@gmail.com>
> ---
>  net/core/datagram.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465..125b52870 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -416,7 +416,7 @@ static int __skb_datagram_iter(const struct sk_buff *=
skb, int offset,
>                 int end;
>                 const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
>
> -               WARN_ON(start > offset + len);
> +               WARN_ON_ONCE(start > offset + len);
>
>                 end =3D start + skb_frag_size(frag);
>                 if ((copy =3D end - offset) > 0) {
> @@ -449,7 +449,7 @@ static int __skb_datagram_iter(const struct sk_buff *=
skb, int offset,
>         skb_walk_frags(skb, frag_iter) {
>                 int end;
>
> -               WARN_ON(start > offset + len);
> +               WARN_ON_ONCE(start > offset + len);
>
>                 end =3D start + frag_iter->len;
>                 if ((copy =3D end - offset) > 0) {
> @@ -570,7 +570,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, =
int offset,
>                 int end;
>                 const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
>
> -               WARN_ON(start > offset + len);
> +               WARN_ON_ONCE(start > offset + len);
>
>                 end =3D start + skb_frag_size(frag);
>                 if ((copy =3D end - offset) > 0) {
> @@ -594,7 +594,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, =
int offset,
>         skb_walk_frags(skb, frag_iter) {
>                 int end;
>
> -               WARN_ON(start > offset + len);
> +               WARN_ON_ONCE(start > offset + len);
>
>                 end =3D start + frag_iter->len;
>                 if ((copy =3D end - offset) > 0) {
> --
> 2.47.3
>
>

--00000000000065fca20656a6a958
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDc9J7n
MODFUBnU7BMj2lQv6aPUUDk9IGR44emExwNoKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MTUxMzU0MjZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCFF6JO8AUbUQPfUpHllUeuKSDkKPnKdthp8d76Yruv
HI6M3S+0MC2r00Sy8pmB1cG0dMlQaT7PNGiqQQm3KkUDQkpVTggIoRQCbdnJpWbx7tsNYxxFThfK
JgUB5ybm3bv342EIQekw0xfIj7BEP+LIW11FFyUzxI9C4qlmMxkVSfILgVJohAPTWMx6tg1QCMMh
sPMMsEHyt/b/aBzK1XynLqsGMTFa89dby7tGh9QJ0VHN86BiYzztBR7JidCHHO7acDBTA/EfX84o
5EKDvb0Qys+9VsZSwtaYAL0JW0wriSx7MwmGFS+OXhI8CRVD9l/N69LfzF9dLTt1I5AJ+8CM
--00000000000065fca20656a6a958--

