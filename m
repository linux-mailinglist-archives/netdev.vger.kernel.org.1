Return-Path: <netdev+bounces-157586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB958A0AEE2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FCA7A1F2F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16581C3306;
	Mon, 13 Jan 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XCBndu84"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A610E0
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747303; cv=none; b=ZXxRbFJQjoNd6GobCcZta10Defj1OHgpnPE+Tjhqv5+0Lxl5fIrXRy6AEyuIYd5lxbP9bzZ1qktwunSDmKsSX2D8VFNKbPhV3AEsUK/ItYwfIOvnL9j9KHMO5/lQu+E8REIjrCaucl7j8wArAQPX9TMXwSLgYpgb43HnObpflQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747303; c=relaxed/simple;
	bh=+hENPcZehMB/wbmaOPZAq9lKN6Z251GDBXeE9+tJGNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWZjVqIGqgPp2jHimIX5gMui/HBTtCsFegRN8EYBK6mLUYF/hpzpUpyO8U8xB1WxU9+JyZtc0QDqcMShhP+ncozy9PotBpgqnQyrVVCzUZ1akzwxeMCyoIe2hxX2CvcvFzLwEvQ6VhjE5cGp43dIYEj+7/gq8n6UYSG3teaBa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XCBndu84; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-518799f2828so2076271e0c.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 21:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736747301; x=1737352101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhSorsZlNgQSkY1IODbRLyGquygI1YDv41GHFcfOVc8=;
        b=XCBndu84/EyUB75StPpD3TuaaGgOcyTk8TWp7j/hxBltjDECmjseC2djEtJZGCBMW8
         EjrVidJau/xy9zsZZuku+xorrsIMGSlBlgloqBB+EQOSuJDcVimFKXj0vFjNfG8LBo3N
         wmcALVoU55intTTc+l+IhwjRm/sLmBdLi+Hzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736747301; x=1737352101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhSorsZlNgQSkY1IODbRLyGquygI1YDv41GHFcfOVc8=;
        b=xGlsM7AfhIBTkbDcCU0/3ZrIaMKTeyBhFpIDULP3voMjXhvSD0Nixg2CqY+C7m6gYl
         aPs7LyfTjYqIXhdxlcqfKwVVWJowWMGDzQhEGdyXmTnscYAWOQejSQAtLPYmaRopsPog
         QzAb9YDM17N404WEmKumv7PX4VREEyOX51onCaCUFsyirnf3xatpik7q6IompFOkUfDH
         r4T42/3LBu+HQCr6hKaXzr02UqmPpvQr5v1qEENjAaGz7UogHe+57hxLbFhgOxKJvf3+
         ZoQkVrE4htFW6jtdeTZ8eGehlvamkH+PVs3ABjgt9XCq0ytjIgF2vyTbhDVkqMaa6OHH
         jR0g==
X-Forwarded-Encrypted: i=1; AJvYcCVqszwTtyICAcg4pJvejRo/FNFdCk637FvAsbkhDCmO1nzXy7RpK1DQXd1BkO3Yt/RC3EXAxrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOef/2pWboRYpkGr6WT08wuDnINOn8WdThE28RJ0rIoBcn1b4C
	dr/+sPoIFw2ixaiC3nv4SCKrnDx/ct8QaZdkGsxrCeXKfPZS3L0sF3EtoVdV+gLwzibMk2QVjoa
	3hMTPX9+FO/UCAuAknD5kOVSaLDt+2J6culp2
X-Gm-Gg: ASbGncv/L4vzzY9IJ3VHzyLbGev//ZJSZ7HgGAPIgBfPj89KGEJhArc5dcbOb9ZdjFK
	OIdEfAHZBlInHeqg3Sz6pPnuKsUaUwyT6PI+gPCA=
X-Google-Smtp-Source: AGHT+IEVptP9JMqCwZipPoI7yeRJcw45a18VhAUj+TVUTdF4/PZKvJd+L4IfJ3ZdLqJBigTH4oY/0VrUxuXLwwNcPGY=
X-Received: by 2002:a05:6122:a0e:b0:515:d230:f2c6 with SMTP id
 71dfb90a1353d-51c7c872ae5mr13884868e0c.7.1736747301068; Sun, 12 Jan 2025
 21:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111065955.3698801-1-kuba@kernel.org> <CAH-L+nNX-3ervNe-P-a+CA8=nuYkt88QfRbpXsTtpvgXqqzZtA@mail.gmail.com>
In-Reply-To: <CAH-L+nNX-3ervNe-P-a+CA8=nuYkt88QfRbpXsTtpvgXqqzZtA@mail.gmail.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 Jan 2025 11:18:07 +0530
X-Gm-Features: AbW1kvbERTXMf9xGEy4708n3yDQarzg82s_RRDumdwAqEcqriBdiVW87YSJ7NFk
Message-ID: <CAH-L+nNKsOrTuZT+0=TREAXXRVzzgdzgduHPdXA8oZiHLD8CPw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: un-export init_dummy_netdev()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f55b6c062b8ffd8a"

--000000000000f55b6c062b8ffd8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My bad, missed the V2 of the series. Please ignore my comment.

On Mon, Jan 13, 2025 at 10:44=E2=80=AFAM Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> On Sat, Jan 11, 2025 at 12:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > There are no in-tree module callers of init_dummy_netdev(), AFAICT.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  net/core/dev.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1a90ed8cc6cc..23e7f6a3925b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -10782,7 +10782,6 @@ void init_dummy_netdev(struct net_device *dev)
> >         memset(dev, 0, sizeof(struct net_device));
> >         init_dummy_netdev_core(dev);
> >  }
> > -EXPORT_SYMBOL_GPL(init_dummy_netdev);
> >
> >  /**
> >   *     register_netdev - register a network device
> > --
> > 2.47.1
> >
> >
> I can see that "net/xfrm/xfrm_input.c" and "net/mptcp/protocol.c" are
> invoking init_dummy_netdev() in the init routines.
>
> --
> Regards,
> Kalesh AP



--=20
Regards,
Kalesh AP

--000000000000f55b6c062b8ffd8a
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
AQkEMSIEIM8DDz/GVDUl40kKBJecsuu9rkcDIFC0MMCrGe/N+7DaMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDExMzA1NDgyMVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC8IYmOwdkj
2Y2V4Sp/yg58Joli0+WrDC46f4mTWDEUpuUu3pUGtNqn+Nm3PVH8WM9TXun5UyLTOpHpa0n7VkgG
R1dKv8kZbZ1x5Dq1xaCsdZKjE7aC6k1eN0eNbO4BRVfr7ZjA29sGn3HunNfSUKFoS0b2suaBkkJi
KuQMVfiAO1HdGH28zclQza3e7w7SZCi6PUP2lHAV2aG+qv9g2wu7JvV3Z22QqJC0buXgrEHuwPDi
akuDRyPd1qmvLu/f+gyxE9Fbnr0OawQEHKcIepIM2wk4pKb02mVpKVM1jpQWzFjJBIyfx9rWAyqX
QveZ820fY9ea62fOS7PP7gTRlDDN
--000000000000f55b6c062b8ffd8a--

