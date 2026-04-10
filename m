Return-Path: <netdev+bounces-277562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFUQAZRZ2WkuowgAu9opvQ
	(envelope-from <netdev+bounces-277562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4553DC661
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAAD130562BF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878683859CB;
	Fri, 10 Apr 2026 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LOg32HDL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f230.google.com (mail-pl1-f230.google.com [209.85.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E636A01A
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851668; cv=none; b=cVaaTbGh/bHjU0bpQClb8aOvBmOBTRXnAp5O6pCT4UUIk6RlQy7uwvCDztQNqSAJ4Sd3jE7E+QX6M/QISymQLgX30O34j5aPHbe+smEWqYbY65R9A+tTpJRBAjDz7ChZWNxiPxqZ8J+ovbldN6PK3Z6H4oWa1OZRBZFG/MXUiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851668; c=relaxed/simple;
	bh=y/0KK68rNif8HOVPI1oF/5FZPttd6UV7nx1XuuQZHQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0zBv/QaaZKbO/VWG3Qrivif4YDtuKyIrOtT548pquh3z6Sk7nnmT6IN6zPcXl0ANKGugrIjryJW0ua3Lu8/oLCG+uT0tDIr/iTFAaeOji+S2ef+a9WnJObVH0qfK4vQpB0mw5XCvdYl8rcK1ajSvwawF/cIc/WuuJNyZtfCIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LOg32HDL; arc=none smtp.client-ip=209.85.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f230.google.com with SMTP id d9443c01a7336-2adff872068so13822165ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851666; x=1776456466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoN63iKdskxLZpGo/VYidf2RAdOw0Z/JCoT62c+/cy4=;
        b=BofsuxcLckwOOM7tYAHa9bneYjNZnh6PsS7bD78sed8BEZTlft6JImRRu+tMjmg4JI
         GpXccc7e1INDsfno/Vx8zlujztE//zyHSlMY+MkJFEKUX3YMfw2PDMAZe8dyOIp8JQ4K
         hRj+hzS0hXjhEscTJRp5m5v7Iv79mO49lbHor29K5eujSEw9H7x74h4enJrUvY/n5pSK
         bL/jh2YTv4CNjomA32rJDaWwUMuyX6Su0uyLkFvbEjiscttHaNqAW1HG0cmY/pCnyyFi
         RUJjb6S+LYpgSSLzGFURLwXdaXe/CSEg64PsUkrh06WxTpAbqhzv9HAfS+kyZaIHX0fk
         DELg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3oKqJMmKDPohkFrYjPolUKt2s3hT04VNmIR2uy90CI0JwB6fgeD+rgNT84hvyzRWjTgbFjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+iMCMoWeEJbZ0cGgtRJE2VlejjrEIb7s6eQ61g/ELkfEJdiSk
	69fHQEno3oC+44/TuSY+RfcjlQq6psglmiZMhLoAqxoW2MWT3kQllI01UKHbRlrAZINw4X2SrCF
	mCviLKicAThY4hQgnC/3YyN9ABcewQd6Cr3/725yhAP4wOkJDDqjTSa/MsgF3E7yEZSabvgscLX
	n+vi6X+yct5t+WSx93DYZrWQdKauynNtaY9gLyn1TbOCSyeT71FLCmmDTKClS7WGYJrMdX4nndt
	9bDWKhQAU6n9nync+8h
X-Gm-Gg: AeBDietvIfIpkACXjJknm2F3myc0aYckrAyRh9H9Bxta9uOmWO4Wwjh1Lo1XgUN+HRu
	RN3RlJt/w1iboayW/ND7vy14i5W20ejo2daiDEdO1nYf2EbBa13gaRJbK1tRiH9qQnNIK+PXRx+
	yNV74CNSmz0V2izyRCW/CCsJBqBf1dCeLrHeygjWDzmrsxvc4h1RmQXo5oJ6bCEE3jDy/gWLURp
	EAwAhphkBQ5Gn86Sj06ROoXoaEp+qVP/ACkrIATO4nny/wuf4w5/6IBO0nuBcBR1+0JPChgvvb+
	x9cw6RXAQglnP9emKEZCstplg0RRuSN372Gdne3lp/yQFzaSH1JqM0NeiEOyqceQQH5XMGOYypV
	oEANbq2SIU8VEFcHOK5m+GGu3lGfp1xSf38GHGceyd72ypZKKi+mSwMObArHZr+4VtuHy8/Vj+X
	EO4UMOooNtdsykD3Kaf4KWyVTQJ9XlRgyEEOBE+Zua8XXrVmG02NOhp65R0wgLCaA=
X-Received: by 2002:a17:902:f64e:b0:2b0:afbe:4e1a with SMTP id d9443c01a7336-2b2d5a90331mr47731945ad.41.1775851666357;
        Fri, 10 Apr 2026 13:07:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2d4e3d46asm2494785ad.15.2026.04.10.13.07.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:07:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79e095d7628so57030127b3.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775851665; x=1776456465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoN63iKdskxLZpGo/VYidf2RAdOw0Z/JCoT62c+/cy4=;
        b=LOg32HDLOryY9UfxC7Wic6HHS790+J7OJmIKYOs5RnTEryBpjgsHTjeLT/biwpvy8o
         MvTS8EYonXyZ25123kCRE/5AzehZrkZuVLqbICv/r542JRPZRLBevbO1XWVsMeV4+58a
         /2v85tRYvtPllGhoAt05cEbpVS0D5JnnBRYrQ=
X-Forwarded-Encrypted: i=1; AJvYcCUsJZ6NC7o81lzzlyiKcBbOdOZEb9fq7fkZ7LAmGoHiJ8j3MhohXermrofFSr11yqqEKsk0uWY=@vger.kernel.org
X-Received: by 2002:a05:690c:388:b0:7a4:80ce:8275 with SMTP id 00721157ae682-7af71478e2fmr48573647b3.35.1775851665084;
        Fri, 10 Apr 2026 13:07:45 -0700 (PDT)
X-Received: by 2002:a05:690c:388:b0:7a4:80ce:8275 with SMTP id
 00721157ae682-7af71478e2fmr48573197b3.35.1775851664523; Fri, 10 Apr 2026
 13:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-4-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.9cf8a81ff43@gmail.com>
In-Reply-To: <willemdebruijn.kernel.9cf8a81ff43@gmail.com>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Sat, 11 Apr 2026 01:37:31 +0530
X-Gm-Features: AQROBzA7ZU5qfHcLOgDGaH3CXRZuhuDiCI0BvK8MgBtTb-FaANqUjA-Re4BspNI
Message-ID: <CANQF7iAdNUOcYdDOFgJ5Ry2i+59w1-_6ebFJm+TASO9-2BT_=g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests: net: psp: add crypt-offset and
 spi-threshold test cases
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemb@google.com, daniel.zahka@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com, 
	ajit.khaparde@broadcom.com, kiran.kella@broadcom.com, 
	sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b06245064f20afc6"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 6C4553DC661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000b06245064f20afc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 3:22=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akhilesh Samineni wrote:
> > Add test cases to set and get crypt-offset and spi-threshold attributes=
,
> > verifying both the applied value and the restored prior value.
> >
> > Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> > Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> > ---
> >  tools/testing/selftests/drivers/net/psp.py | 32 ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing=
/selftests/drivers/net/psp.py
> > index 864d9fce1094..9253aab29ded 100755
> > --- a/tools/testing/selftests/drivers/net/psp.py
> > +++ b/tools/testing/selftests/drivers/net/psp.py
> > @@ -171,6 +171,38 @@ def dev_get_device_bad(cfg):
> >      ksft_true(raised)
> >
> >
> > +def dev_set_crypt_offset(cfg):
> > +    """ Set and get the crypt-offset """
> > +    _init_psp_dev(cfg)
> > +
> > +    dev =3D cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> > +    orig =3D dev['crypt-offset']
> > +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> > +                       "crypt-offset": 5})
> > +    dev =3D cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> > +    ksft_eq(dev['crypt-offset'], 5)
> > +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> > +                       "crypt-offset": orig})
> > +    dev =3D cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> > +    ksft_eq(dev['crypt-offset'], orig)
> > +
> > +
> > +def dev_set_spi_threshold(cfg):
> > +    """ Set and get the spi-threshold """
> > +    _init_psp_dev(cfg)
> > +
> > +    dev =3D cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> > +    orig =3D dev['spi-threshold']
> > +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> > +                       "spi-threshold": 10})
> > +    dev =3D cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> > +    ksft_eq(dev['spi-threshold'], 10)
> > +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> > +                       "spi-threshold": orig})
> > +    dev =3D cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> > +    ksft_eq(dev['spi-threshold'], orig)
>
> These tests mainly verify that netlink works as intended. Not sure how
> much value that brings.
>
> Once crypt-offset requires bounds checking (say), such control ops
> functional tests may become more valuable.
Agree. I will include bounds checking for the crypt-offset in the v2
submission. This will ensure the control path is properly validated as
suggested.

>
> More interesting would be to see the effect on the datapath. E.g.,
> a crypt-offset that actually leaves plaintext. Not sure how easy or
> hard this is, so don't take this as a requirement. But maybe something
> that achievable with PSP packetdrill (eventually)?

Regarding datapath verification, because PSP encryption and decryption
occur within the hardware offload path, the host cannot directly
observe the encrypted/plaintext transition for self-received packets.

We verified the crypt-offset effect by capturing and inspecting
traffic on an external switch between the hosts. While integrating
this into packetdrill is a valuable suggestion for long-term testing,
the current hardware-based offload makes host-side snooping difficult.
We will investigate packetdrill support for a future update.

--000000000000b06245064f20afc6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDCI38VoeiWHImjdPjDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMzA1MjIwODU3NDhaFw0yNjA1MjIwODU3NDhaMIGY
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGjAYBgNVBAMTEUFraGlsZXNoIFNhbWluZW5pMS0wKwYJKoZI
hvcNAQkBFh5ha2hpbGVzaC5zYW1pbmVuaUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDAO001ZnYPXmhKsI+E+ksMK/hc9m3qLeGDkvGAIpfLyKfdk2C4d6tsRhM8
4xrNQmMMM+f5wF271rTc0O+CTfIIIayklTmjzksl5CwimtzjGpPZRcLeABJk4Z8VdCU+TW0gSDgU
UGsHqEkCW3ifD8UhO+1xsg2k1ER9gbJ5HfkiiRjtx/jG0Eik3rXjcrxyU4CSTJeFrMsRfHBINs1b
XQiZIKEA2v9ryzZcqBG67oV2mIMYV0PyoO5ccmjophMLX5I6d9LmhVG+o7Fb8fYE43v1Gmx1cF3/
HLCRJ9lVtOZNrDg8Tx5LaODYomcqd8Jym3+vbToQ+O0SQyV9WNR9n6OnAgMBAAGjggHfMIIB2zAO
BgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQw
QQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczov
L3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8
oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3JsMCkGA1UdEQQiMCCBHmFraGlsZXNoLnNhbWluZW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU7Bc6
vjugq1VNABQ8AiT04kX10IgwDQYJKoZIhvcNAQELBQADggEBAELCFtU20SHhQMZA0lekkhYfBuuc
/5XYCUX21R6IQyTnqwWwOQ4xNOiq5rC7P2bOGpEKMcMBcHB/VDqpT7Cs0PXecOkC+0cWvmZoxCjx
Hk+3d71Ie1w8r5QiYuGOgGhNWbfhc5aVZUENjC+zlYStnReq3uZcf/oziznbvTX38pyuhVsuHFSo
+SP9KHflLUYGQLmToaPGlRjPh+LJmpbiZ0NRrRXz883+dlADC7tW3fUlrqdeLN9xsoTh7CoWxLUl
xSAQfSnXdfTNfF36dQxm8Az8xhjNmD04jilAg+UVGs7xWqnIkFChNe8pykTtDwdrkjzaaISKeUDj
4fW8f5qx0B4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIBIDyv7iaZu
352ptTY/pZTAtI7ThUwypVwRbLNR0ms/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxMDIwMDc0NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJfueCukYJgpNDp1oUB3SZANersNdNBZMLE2Z+wxi3SS48Go
hPx92udM4xp26F5xHfHG/U2hD8HyFBVKkib80DJCB5U7bW/NHKr3WnMaFoInsFT7KzVl1wGPD2CV
gL+794roKTWhn4YfwSmehh4hzDo9CKVMKfZOPJW9ipeuFuNPQtBohqwUUau1IFcuR2KCfyaEExho
pciXs6IqIJT6TkbMNjFT8asMKD6OYnn9wShM+JeBUEF+kmfqIZ2J0O7GszotxC4ObWE04dWE+Ohl
Vk8SqypNW4Y/GSh8hLLYYUKDd6kcDFg2+W9RceJ9R2MAjAZkHmgSrpDDfkyfvWvjHpU=
--000000000000b06245064f20afc6--

