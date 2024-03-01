Return-Path: <netdev+bounces-76446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8486DC31
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB71C20BA1
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE5569952;
	Fri,  1 Mar 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S0UqG/Rt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7452F7A
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278785; cv=none; b=IEeZfbGb5ef9xuw4gjThB+09mqEPyoQvVZR/zjo2WO6ssZqZTSxdZCAOWsQiKI/kLQm//3aqCU8sP7S/QdEkY6CEnrNZWNWUrff3Lj/ZbTdEKJ2WFFhLmpQoZVLleG2P0to1EoeNcpys7z957QKF7KlXO3NekMCcabnngEO1O1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278785; c=relaxed/simple;
	bh=aXEZTcb6TbbuqqEwRJTcTESxeMiWjPPEetGDlIELpLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQFBgpnNyR0BzXlZkQZxihLnYGSRNwj7gEzw4ygfC1NTebkc0w3gpe46JCS7O1L7Ao9WXr2Rh7okpSwsKV4+JfFInovWarJc2kr+R1GfTfM3twACn/rXzfUci8Nmo8D8ZO41CamXAKgRR5MzQyxLUwHyUTi9ZsYtG+qSwhzPFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S0UqG/Rt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1620115a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709278783; x=1709883583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXEZTcb6TbbuqqEwRJTcTESxeMiWjPPEetGDlIELpLA=;
        b=S0UqG/Rt4ygjEqxLDqZFk/u+m6OOddk+SV5S+ZF5Ygdyyxzuy7T+nB3h8N7QWlg0my
         GY8Y7ALQe0Vqp+UkLMaHebFhueB1s5lKa99V0if5a1tI9DpfvuEj5ouEp7S3fJJTxdMj
         HgW6fU9FjgGdT2WhN3MJMzIOQV43ocVeyAyh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709278783; x=1709883583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXEZTcb6TbbuqqEwRJTcTESxeMiWjPPEetGDlIELpLA=;
        b=hPBdLjsCDUqxCKi17uNj6/c/e7J2OeWNDgEUGEI92eoUzgDPw+4wjGgf6TnYtOa9kq
         4pOqGGIyxo80jZfMStnhelgA9B0l4ENFUyLde0pyy+QJGT2W8F0C2elZ4/SD+0nvImrZ
         Iikoty/elBzREcpfwadnbEBZAO0ryBEQEBkTLngwCbZaaG9I2HCCWzWUWFmg3Yy1amg6
         JL91ox2wyInjbx4gWEFTQ0Kv3EZJCzE7VKL+TyQSZKq1vVE/moHcxT8FlFwTuKhs/7ik
         vfo/nex64G0s32RjPa//ZOjQEEuWnT3hj84QXkvTbjuax+KuYbW5iDKNJ6IJ7HaOJ06+
         a8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Gy3SKY7llvVjdn7F0XncQQlq68N8/5fUS4fiyqIgd54zRMJ88yXoC257YYYSFjV9PjDU4k1EVUryW3g4g4f9DvRGe3/R
X-Gm-Message-State: AOJu0YwNa90Zhr9YzwOjo6h0fgM5/6mfOl+4WBpYY7Wk5bm6FidxDy+2
	HVy3yhX+/oAIHVUe/nAicNhZgfcOXqQxD+8o4nIICv9wJOJVfgp0MMwUN3RuBm9SpIe0KIzLFcL
	5KilHzXVgO9ogaEk+GnrB9D4sQCwFrV3grHOz
X-Google-Smtp-Source: AGHT+IEirQcCCCc4D7QQvvylEgzWKkOZMOsKnZFJfz+cBMRczfH2WZgJbO4rC6Q8Ni/10cC3oJ2hF933UkTqg1ksQMc=
X-Received: by 2002:a05:6a20:cea9:b0:1a0:e83b:a954 with SMTP id
 if41-20020a056a20cea900b001a0e83ba954mr644802pzb.37.1709278782837; Thu, 29
 Feb 2024 23:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-2-michael.chan@broadcom.com> <ZeC61UannrX8sWDk@nanopsycho>
 <20240229093054.0bd96a27@kernel.org> <f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
 <20240229174914.3a9cb61e@kernel.org>
In-Reply-To: <20240229174914.3a9cb61e@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 1 Mar 2024 13:09:30 +0530
Message-ID: <CALs4sv1WSJSxTM=cJ84RLkVjo7S8=xG+dR=FGXmDHUWrj7ZWSw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, 
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew.gospodarek@broadcom.com, 
	richardcochran@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b490040612947a83"

--000000000000b490040612947a83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 7:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 29 Feb 2024 21:22:19 +0000 Vadim Fedorenko wrote:
> > > Perhaps, but also I think it's fairly impractical. Specialized users =
may
> > > be able to tune this, but in DC environment PTP is handled at the hos=
t
> >
> > That's correct, only 1 app is actually doing syncronization
> >
> > > level, and the applications come and go. So all the poor admin can do
> >
> > Container/VM level applications don't care about PTP packets timestamps=
.
> > They only care about the time being synchronized.
>
> What I was saying is that in the PTP daemon you don't know whether
> the app running is likely to cause delays or not, and how long.
>

As such timeouts are rare but still normal. But if you've an
environment where you want to have some kind of sync between the
application and the NIC, as to when should both conclude that the
timestamp is absolutely lost, we need some knob like this. Like you
pointed out it's for an informed user who has knowledge of the
workloads/flow control and how (badly) could they affect the TX. Of
course the user cannot make an accurate estimation of the exact time
out, but he can always experiment with the knob.
We are not sure if others need this as well, hence the private devlink
parameter. For most common users, the default 1s timeout should serve
well.

> > > is set this to the max value. While in the driver you can actually tr=
y
> >
> > Pure admin will tune it according to the host level app configuration
> > which may differ because of environment.
>
> Concrete example?
>
> > > to be a bit more intelligent. Expecting the user to tune this strikes=
 me
> > > as trying to take the easy way out..
> >
> > There is no actual way for application to signal down to driver that it
> > gave up waiting for TX timestamp, what other kind of smartness can we
> > expect here?
>
> Let's figure out why the timeouts happen, before we create uAPIs.
> If it's because there's buffer bloat or a pause storm, the next TS
> request that gets queued will get stuck in the same exact way.

--000000000000b490040612947a83
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILs6h4c43INbxaooo+xNXIZ2aReYxoTA
Bgw2fhH4ge6nMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMw
MTA3Mzk0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA0OVANQ/4/wGtsJdzPvv6kFZmib3pErjyqPfl/1Mary5h/Z+Oq
BqHWVvWzkQ+zZqlZ9pAFyBeJhjOVmoSLP1gKz8tP4nqfW82dhmPc9kjX+6bRdaDcIvN+TlmUOHRY
+7bXRt5rb1eNGXPpU+pTKt8nk3XGyngihJMt5r9jJPZsHqoQ8R/RK1aB878pm3R9dIYJvTRrpBHt
yKporgRUbDN0Bf989pFvWiMyRu3sQbRdXfVmhpnHj59DzNgTtEjYXkx+wwoE9+0JlVRBeNQzty9F
LT0UfDbmURxjFW1r5S4ca2ovLv8zy3bQZFNjoWC9itebGAOaQXS7nH8Zsq3q+U2Y
--000000000000b490040612947a83--

