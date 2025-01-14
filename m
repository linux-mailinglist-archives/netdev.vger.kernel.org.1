Return-Path: <netdev+bounces-158039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA4A102F8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BECA1887F78
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE91CBE95;
	Tue, 14 Jan 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ALK2smhj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231C22DC43
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846879; cv=none; b=Qe+KbQAdLBpUVB3sgq9h7w6WmJPhX5i62EAhxn2jvD9UZ4lLEfOAKTsNk+uzexK7FEe6eA1QPjzRVWy69arGjEZsmqOAhFZjh8EbzQMETVPlxbHLMKd2pQCEktHKqFZNIdIHJM1JlurWQqe9z/cIQ+s76Efs01tfzzvbcCwhQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846879; c=relaxed/simple;
	bh=k2Pklhc+f8QqYK6t8T5sToHGJ7CaAWH/BdqNDHRRPfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jveHsoX3cFjvvux9xwW2TXGXIFxWBuJOEiVqlayAjKw7i78d30PHxcQ+xVkhMIUI65w4c/P3FyRUnAnV0z1grxJaalKcsDmcHYWNgCBArYU90Rikz3gDNWjHYvQtX3D4jVBlMflpm5hc8xLyHpF81fp1I9UbHqkbc5OELESJNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ALK2smhj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f44353649aso6983685a91.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 01:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736846877; x=1737451677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVLRThx+dNIk/Jv2ofV+pPkdItit2hq0ceGW5sHKK4U=;
        b=ALK2smhjWdxCtf1nXVHzLP0ESsBvhPTYuQf79C1ZWzBKnA3ONbrTfhMiBoc8I19uGs
         cJTxB7vMoNKQAIODA3HPmtN66q0/LrS9T1kV9tUTWPxxn5KCKLMtRms4vxoB3yGqKYHu
         UhTZSvZkqZZZsHmxhp784sURpYNbGx5KlF+lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846877; x=1737451677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVLRThx+dNIk/Jv2ofV+pPkdItit2hq0ceGW5sHKK4U=;
        b=TP4kvsx2Yx/i96LUU/b93RT11R0zJgS1Hu5paOGadhB9qswq3/ThyegdmYKGYawdB4
         n6cVn508l9viu5+SmXGLzCrfBtdwaBGhYvwWvx7M53XbdJrxAW7IIv967Og0r6W/zwuB
         AvQiXR4Lq+V1QVPLP9qxlIMJ0Q6YKDQx7ngWgc3nYmjbrU5COIYYs4mSBE6HMNSM/Pmr
         ahjMZHgnU/z9fP7eMSATWAk+tyOTQKNuqhjxHfNZyqO7ha0GnG2GgwvLdLF9/7DBycMP
         6qiBGm1O96yj27mxLxce/pOeCkwSbMba8iryEhENEkaCpVEgD25GyDtVQzkFFGN0mkDH
         usqg==
X-Forwarded-Encrypted: i=1; AJvYcCW35L8JI2xScF7cjm4WgABVJkIXMS97YeTtR8NCHnMIFZHa0nqrP0IXHkXaVL5XTFyYcPxFT0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHx1KcFgMA4dm92L+OGeYEi6+R1b0yGSTeg6BMR+gBbUaCT93
	F7UrY6xv+4alAauueo7ZoO17b0H9/n9lJrLPAyDlTbA6EwhDER+6of7r6BVtMal/lfCXKVk02rN
	bcmFT/guxOKBojul14sDEfgnMTEGnF5Q0Oisy
X-Gm-Gg: ASbGncs2ibjOnurniT4cPCGE2Ji7adXizqUP+VzvzxTQU3OhhCi7ZyP8AweLXWXHAdK
	Agi1qNfw71lUy74dpRMzZFicOMmB5XeOuBnSA
X-Google-Smtp-Source: AGHT+IFm3XRm31soADxnL4miKpHQjpcIGA7W2p5rtb2tiCbHc996+KwdW45pRC2Sgx/UTae/xCwROKCEWeITyTc1+As=
X-Received: by 2002:a17:90b:5245:b0:2ea:5e0c:2847 with SMTP id
 98e67ed59e1d1-2f548edf16amr29464654a91.22.1736846877672; Tue, 14 Jan 2025
 01:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111065955.3698801-1-kuba@kernel.org> <CAH-L+nNX-3ervNe-P-a+CA8=nuYkt88QfRbpXsTtpvgXqqzZtA@mail.gmail.com>
 <2bbeb160-789e-4465-90fd-7e69d348188d@lunn.ch>
In-Reply-To: <2bbeb160-789e-4465-90fd-7e69d348188d@lunn.ch>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 14 Jan 2025 14:57:46 +0530
X-Gm-Features: AbW1kvbMwRUUq5gkrxdklBHYvrA8iP4jUf6LRcjIpwCBE6-PLWl3ea4c39YVka4
Message-ID: <CAH-L+nOBd4u4n4hv6p4y5KDeLbw5LX6iNtAbXB1NPLP6Q8tSHg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: un-export init_dummy_netdev()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000030c71e062ba72d80"

--00000000000030c71e062ba72d80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 10:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Mon, Jan 13, 2025 at 10:44:37AM +0530, Kalesh Anakkur Purayil wrote:
> > On Sat, Jan 11, 2025 at 12:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > There are no in-tree module callers of init_dummy_netdev(), AFAICT.
> > >
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > >  net/core/dev.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 1a90ed8cc6cc..23e7f6a3925b 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -10782,7 +10782,6 @@ void init_dummy_netdev(struct net_device *dev=
)
> > >         memset(dev, 0, sizeof(struct net_device));
> > >         init_dummy_netdev_core(dev);
> > >  }
> > > -EXPORT_SYMBOL_GPL(init_dummy_netdev);
> > >
> > >  /**
> > >   *     register_netdev - register a network device
> > > --
> > > 2.47.1
> > >
> > >
> > I can see that "net/xfrm/xfrm_input.c" and "net/mptcp/protocol.c" are
> > invoking init_dummy_netdev() in the init routines.
>
> I thought that initially. And then i checked that they can only be
> built in. You only need exports for modules.

Got it, thank you Andrew for the clarification.
>
>       Andrew



--=20
Regards,
Kalesh AP

--00000000000030c71e062ba72d80
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
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIA8oA+QCd6l4WmlmPhSTuMol2Xd66yyqAncy61NzAe12MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDExNDA5Mjc1N1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBWGqozE5Bm
oMC1mBjPrNC61hOD88OLf3/yFUUJ8vsJCIh75H+f2qUXxdOFQ3/oxhsJT1hCYFqQPdh4EOs9aPj2
bM2ahQR/5hR9IS7tVXViajPt7P1t5sH059Kt2mLpx5Q4CX+OR4ZCSTS0r9ejMzYqojB5iupbIlfg
aYYb7jLhu+zF2P6gAOE4f5cyLlnEq56J9NDDXEyfmClsazzIAPY49oKKOuAEcnyKF9b43W1j6Gpl
ceh+4bwgMzOHxwv8/p8xeNvHbSoGYgzy2LILcQbNnGvlidXf32oDRhpybMEmlP3fHhGWuxarnX5f
BUguKBMBiTolbj9Wxes9mzBfdz2J
--00000000000030c71e062ba72d80--

