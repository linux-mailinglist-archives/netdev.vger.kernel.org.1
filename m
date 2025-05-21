Return-Path: <netdev+bounces-192117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083CABE92F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62727A606C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212C14A09E;
	Wed, 21 May 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BXPzVb7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305E3C38
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791540; cv=none; b=mXAQefDZvzpyQxKYAGgNsqyDodYXP8ahg67HChOYHgPx5CqDWR33pnaKWW8WoSbN/V50Y2XixOjSgwQRvwKuXv0pfD71dn//fI2uY/Dv9oqBGmu69ursVuWWlM/Ln1u04E4IlRvV74576nBstCMV+8AEHtafL3q8ERneYn9atOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791540; c=relaxed/simple;
	bh=sr1RrRFKUWkGCp9Yw6NHK4VpGiHH3VTDdPIliJVzpOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2yMxdQfvktsvpDYIEQz74T+5Wa7pUrROHucpiBYRsPPUW93NHQSgKhjNQS2uRUBfzYLCYPjMDsdcUJEqiEZYs8vAA+2mUG/JjMDxeoqoxQcLu8VubHvqULgMNQDb6HNzZxnlXd01guWT7wKOnf88OdZ0SDxKvmEXc42Oe7rkJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BXPzVb7q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601aa0cb92eso4525872a12.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747791537; x=1748396337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8wzikdj4Zmr8WMWXZ4DoDYhkc5RFe2St8jVSTdEjTQ=;
        b=BXPzVb7qsy1exznSq3RrIrf4hW3+n2FT0IQ3cD/JxIazLAfevz9hXE7KJokSamMhbG
         3qSeQL+OWK/eXV3256r6PBhvqYBh6Ly62KMF8CaukDM1pXN1jXOM7L5tEa2BbgtRoZd4
         0EQ+CQhhE/+XR+9dGPGFocKYWcHM4DHQMNjZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747791537; x=1748396337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8wzikdj4Zmr8WMWXZ4DoDYhkc5RFe2St8jVSTdEjTQ=;
        b=fcZOTdu7oVH95vVu6B3lMyX+chZ+JnFYoWq4YrU092kq/vgDEy6/aOIpIuuPyMOY0E
         liaZ/iP4mhqzKLM003RJVXsKNW5RmqlV478jjqTY3h2vgrMtDg0gEEgIjiW3R+ikzfaQ
         af5wKDEOq9xGoWK7u0fR84t2eyIYflY7xBu3LMMsuQzQokqWXrqVCzmrnChEw+G9ZFEZ
         uOJawUn8UDstuGrGMh3MMzCFoBUorBOHz/Py2x/BmFuNtu5Hz5J7oDncYhPp15c7z2hg
         g0JbXe3lrQUc2gH4oginMpFjnWVo0pRO5l2Z45i7ZKLFwZUHkVkBgbzl4TZsDBXtcEvk
         oVPg==
X-Forwarded-Encrypted: i=1; AJvYcCWltBZigDlQnruZuWjvDrFEl6po3KWGQ+JKTdc1n8/GGLtWb9E+3A8TXFK5WQc+X2KegEVF1q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyfBxB9C9GicVWo7TGTjvI9zzmpXobxdyMC6j5rIIkvRx/PC/
	kAvTVdyK/b8YW6EVMEeLxe+TbXfK8lKp1iT0pjRI0KLA1+2jyhnIwbXeTSIjOZrGz7og/ucWRnx
	KdDee/2rEktoH7drld2JUOeuVIvxMSDiBvmtljLbR1yF+dJI1B/Q=
X-Gm-Gg: ASbGncsbIc2/sqBjdCMIgyC4cqyxEk8EZmfiZF+2WgmoU15Lk0xfZylF3V71+Lfao26
	TlQRxAQurul3RyAsEnJ3n5WK6WjPfN60lzx254lw/b7Wrpqui/XY1HGOF01skNXr/2OyKKlWG9e
	9PN6HeJHN+jIOVpEvacZAaB+grSNP1WJkZDFJUPNnfrfI=
X-Google-Smtp-Source: AGHT+IE/wOAaBFmQbBHdWvZ1glkiZNPf626INHfF9tuewZoYeAyBAkEIrleUry04RZkeg8u1WPYt0ngGYhGXAY644uQ=
X-Received: by 2002:a05:6402:5252:b0:5fa:f7ed:f19c with SMTP id
 4fb4d7f45d1cf-60114069366mr14788756a12.4.1747791537013; Tue, 20 May 2025
 18:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-4-michael.chan@broadcom.com> <20250520182838.3f083f34@kernel.org>
In-Reply-To: <20250520182838.3f083f34@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 20 May 2025 18:38:45 -0700
X-Gm-Features: AX0GCFulEz7N4ALO1g9fbAjxWvt99E7GWMq58rkaHUYlJ7De5N3ErJ1ZyQsO0o8
Message-ID: <CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b93cf206359b6daf"

--000000000000b93cf206359b6daf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 6:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 May 2025 13:41:30 -0700 Michael Chan wrote:
> > @@ -15987,6 +16005,7 @@ static int bnxt_queue_stop(struct net_device *d=
ev, void *qmem, int idx)
> >
> >               bnxt_set_vnic_mru_p5(bp, vnic, 0);
> >       }
> > +     bnxt_set_rss_ctx_vnic_mru(bp, 0);
> >       /* Make sure NAPI sees that the VNIC is disabled */
> >       synchronize_net();
> >       rxr =3D &bp->rx_ring[idx];
>
> What does setting MRU to zero do? All traffic will be dropped?
> Traffic will no longer be filtered based on MRU?  Or.. ?

That VNIC with MRU set to zero will not receive any more traffic.
This step was recommended by the FW team when we first started working
with David to implement the queue_mgmt_ops.

--000000000000b93cf206359b6daf
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIK1Mj6w9k6Aj5cJBX9NVIBnvFJcTM+YU
t3Hc/t9lEuXyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUy
MTAxMzg1N1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBABp77iQO9zBzwq3Biocwt/hN84s2J1iFYEu3ZqMN3kDpiJF9FhHkulYjmaLWZfLWICRt
zqxFju6RMB4b5Ca8lFnQSanJyc/LmnPwGLguXdS3ycLSxZt++gpgTxeHdw3q3v8VajKe9GCS/d1V
MrgHmYmLtMe9nYTYfwWwAGS9JR0BVUz2BX1wgum8Kp6dhvXAU93lNxrlI9F8cViZlEhFWxKNV22Y
Jww2+7o8m/ijGaZRHYkDvifFjTtFCeCxWmYaUHgsrI9YikLZnpfbvGUZuAtWFxCwqLztfmhlLep6
+y/Otvy1afv5CsbxQdKfhO9MHqg8yK7REOgB+dGcYs1i2MQ=
--000000000000b93cf206359b6daf--

