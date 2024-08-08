Return-Path: <netdev+bounces-116955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4394C318
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E87E282C2A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9518E036;
	Thu,  8 Aug 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BC74YnOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251518DF70
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135958; cv=none; b=ilqq/drDNh7IxudIn/d411b9mkkA4wSphcs6ytjazJYUhwVZfaH4GvhWxZ4nUxBL4A0C0eOrI7LV7C4hyBq0TU95cOG3NUmrgFLgqr6zC4dRgNLLmqXTiFOn/rdFq7Bbxwzy7+X+Q2oR7JCiGfFt5nmxnOIuei5/kg8DRUNeDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135958; c=relaxed/simple;
	bh=UhvebXMSm5SpcW2o8ds+g5AMeskIL6tRsSYHWOSHky8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFSl3A+jhVmRGfsUlf8SLg8Pfu7nO7yoyAn4V9ZWRhB5RNIDFQaJM7UgmzSDztZek6xsqT05txI1XQCs3JJel4cjHcaErgPfBc95YnOgy+4A5EygjgSVto+WwMKMywzCyAd2SzvrgLB30+Sqg1mWO540pZveJfQyuAVRKrP7TNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BC74YnOm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so1050235a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723135955; x=1723740755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qmN+HaJWQ2xuvtMRRkN3P04VdelMu1SnTcVnWwq6S94=;
        b=BC74YnOmqi+sniEc7+cO2xc4tZgbCtIqOzJESHLh/WvYgN0f7gED0voSQYv0xUW3aG
         ce/CWdejGdxENE3RQP4KE8QyDKcK/Vh5Gly1lAej0KYjKLXgSXqBB5TBGKE0k4qdGMet
         odKlPQj7P8+75MSOExsjUaKaeDgaKxVM1d1Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135955; x=1723740755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmN+HaJWQ2xuvtMRRkN3P04VdelMu1SnTcVnWwq6S94=;
        b=mBHhEpL94qY5jHRV5hGtG6ZUr9B6cTiIm1reUkiMJctyP8GPyOgnWCWVRyKfkQpios
         9Mvja/AT9rM5GbLgozssSm3cG7xL2mRA+cFMiLE6PGP+MJ7Fm9+i7waygo1mSoM5vfst
         7zfhxtwTbYsMaGWJZgjsXh+haNxMqySdc+VKRLrIK3wrwhEUJPn+sXwsi8plAJQb1Ukl
         j67fhgtY7DPCwcG01ch+Fe7U9jJmWiiFBkb+9hyfTCha+73V/NrDu4MFR3fZrTK0eL1P
         yvbn0+DyQ0+ZsOkaJz9UEC2BbDPnsUeLXWd8H9NIOZJ9ThwDJUHUIi+qRr5iZd8/Kn75
         EXQA==
X-Forwarded-Encrypted: i=1; AJvYcCXqv/eciXslz+hiLMH1uVSe+BS9RP0IXG6EGNHmdOwhmfnXAVJRImFHxcTy1GUCRnTrmKU/unx6KwaZZU67mPdrzOlQVhOl
X-Gm-Message-State: AOJu0YwRo0L90/7i30t/+/tAkS+uEa62RFE9g+wwuxTR1fPwaCLxdZrm
	zQrQNJf1K6KhJd550ByqJIgQ8K15MOkBEQrA7bM6AgF8H9xjPCe64tYimvsluNRkqHKeO0SZfGh
	l06jiHzvP9YgjeWp4d8Gv692ljvT3ok1Nka4C
X-Google-Smtp-Source: AGHT+IE47cQynh1hebpf7WM/0/K0OipaFsM+ry/ug3UJFqe0cp8UtWqzgWhqoi00U6KNZAqfHKYUjzhgRBh/fREaKoc=
X-Received: by 2002:a05:6402:1f87:b0:5a2:2654:7fd1 with SMTP id
 4fb4d7f45d1cf-5bbb2357382mr1630651a12.36.1723135955280; Thu, 08 Aug 2024
 09:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808051518.3580248-1-dw@davidwei.uk> <20240808051518.3580248-7-dw@davidwei.uk>
 <CAMArcTX_BDeFQv4OkOk6FLdaoEaS6VQyv6wijUPoQNPCy456zg@mail.gmail.com> <45a6ddd7-886e-4d48-a57c-21d948390d56@davidwei.uk>
In-Reply-To: <45a6ddd7-886e-4d48-a57c-21d948390d56@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 8 Aug 2024 09:52:22 -0700
Message-ID: <CACKFLinGY9fuT-7O+6=bC5yySQ-6U_KHDQeqwXmVkWbaWFhkQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] bnxt_en: only set dev->queue_mgmt_ops if
 supported by FW
To: David Wei <dw@davidwei.uk>
Cc: Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008aa009061f2eda52"

--0000000000008aa009061f2eda52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:42=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-08-08 08:13, Taehee Yoo wrote:
> > What Broadcom NICs support BNXT_SUPPORTS_QUEUE_API?
> >
> > I have been testing the device memory TCP feature with bnxt_en driver
> > and I'm using BCM57508, BCM57608, and BCM57412 NICs.
> > (BCM57508's firmware is too old, but BCM57608's firmware is the
> > latest, BCM57412 too).
> > Currently, I can't test the device memory TCP feature because my NICs
> > don't support BNXT_SUPPORTS_QUEUE_API.
> > The BCM57608 only supports the BNXT_SUPPORTS_NTUPLE_VNIC, but does not
> > support the BNXT_SUPPORTS_QUEUE_API.
> > The BCM57412 doesn't support both of them.
> > I think at least BCM57508 and BCM57608 should support this because
> > it's the same or newer product line as BCM57504 as far as I know.
> > Am I missing something?
>
> The hardware is correct (Thor+) but there needs to be a new FW update
> from Broadcom that returns VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP when
> queried.
>

BCM5760X and BCM5750X support it but will require a firmware update.
I need to check when the new firmware will go into production.  The
older firmware will work to some extent but our internal testing shows
that the chip can sometimes hang when an RX ring is restarted with
heavy traffic running.

--0000000000008aa009061f2eda52
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICZnvn+6et1nH7qG/kyZMifGh8BIeFI6
Rldqcc6T/CPPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgw
ODE2NTIzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAuc2sHO7auZ9XK6uDad6rrnK70J+3RPlLaG1uPjb4A9zaKPJMA
wZvD+tsVpDzN3CBZW5JSv8TjzywfCPCZDqwHFKUyhEAZZZoTo+l79a9kpU4xCpCAOimnI2GfYJLy
GPdWkSG5VgDS99jV/L/CPLJ98LcmqWsJY88xv4tSU4+49MkgewTAV64ce0iVb91GTrxRKOJ3/wjB
03jNJzYz8WfFz6Evti6CAzBvdxrIm2BRVFoeOzPG25FX041xRj8mzTEbQhWN10JUX7axFS3cDqT1
6lgrVusrLvAarry3wB7kbcrFh6yJAmVbQLSAkBQoNELTLqv9rhXjY/Z8ZAOUV9OQ
--0000000000008aa009061f2eda52--

