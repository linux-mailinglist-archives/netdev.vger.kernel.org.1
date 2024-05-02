Return-Path: <netdev+bounces-92908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438C8B949F
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CBC1C21C01
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00A21A04;
	Thu,  2 May 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hESmPkjP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63E20B12
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714630809; cv=none; b=fid7qFMFVD8qkWDlMggZNFFMtCUWU0iB90hfMdUe3fCywbLUnXMKFwgd6u+MdzeXKIzJ66x+j27aeNSGoqb9cLSWPplGvRLANlKaer17bPxQb/7/pIAZ7X3T7JHrpFhKQheS81dYCQ1V2GQtAmJ74wOxopCb/oLS4PGiUybW15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714630809; c=relaxed/simple;
	bh=s5l9wLgFtqgFGEpu6B+/tQSqHKTFHEBiI8kh6LZtxQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6vpsKQNVgW4H+fsPDy98iUAJm6XoTn7qPO9Yfpb1vahT2piKd4B2/9kQOY64OrG3NC4ij4pMFNHhdTOKHOxhtyJ3qSPqcyZY1k3tAzc3mWmZI4xUOALWoZCeTIZhCJMK3XOTS/15gKp83mhMV4KrH5FxcalNQ27/Wf43BKFZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hESmPkjP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57255e89facso7139110a12.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714630805; x=1715235605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FiugJ+IG9xJFM2DjRSlAvgcv35C2Nti165bnHvlsVa8=;
        b=hESmPkjPj4Ka8t7kqVeyP6IGXZ0a6Sxq952aiFNOKbSloR8XstggEFgWEVlMSyKZ8r
         866ZYMg8f3CIUeR4PUbWTp+aioM4ADOYmz/CWyTumVD9sQL5AMS5F5Ns999ccTDkCkX3
         pp0668ZKc0o9pUilc2dmwQ46Gjo1lNIJDTP8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714630805; x=1715235605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiugJ+IG9xJFM2DjRSlAvgcv35C2Nti165bnHvlsVa8=;
        b=CCe6ThffFw1jONmIPt3JlKOuX24dZgbP1jKs5JQbxQHDhqCjaQA/W/zFBfrgsRdw5i
         JMBzUiKR1MYcAXW7NFcY/SGHJLNxV+fG5Qm3+IKMRBRZPeEKvIS0x+pWCES9ANqIPhCV
         4K+m8FxvcTrTIupv1Acqe1cXSvWUQ6dJ4Ou1uStLOOWpvlZw2AsNadIihWAOYPgOwjT2
         CDuvYAspgzpBbPBMUYTkcHl1y7wHEVz5AVOWwTrlpQedHNbv7e/1xen0BUvufAdr2C1s
         pC3+QN4hcZSLnRXBeseIVYsCnEmRKtyaMRpFrOXyrO8IxUEoRRWCqOHaD6NhYJrR8ebK
         Ml+A==
X-Gm-Message-State: AOJu0YwWckQpcUiGrLkvBBQ+q+g6VlX4hfSAgfoKh8d0uw8D1NP1ZgU9
	lBeii4ys94E9ZFTC1nhZ2UWSXGqQdlhhrO+9cgjZRfcgpD8tmDfsCXkmqNkO+oFwuW4QNzTMmSk
	3KkTtkoyMN3fyMhg2lM7sGTIbmosx8Ifa77QI
X-Google-Smtp-Source: AGHT+IHpSOWk+fzf4mOG6fLABZiDWJVrOCKc30ZWBcjQzr7h6x1ZQXM9Pho9Cs4lUEQjRAwChEsE0Y9OzOdjW2MeSM4=
X-Received: by 2002:a50:9f03:0:b0:56e:447:1e44 with SMTP id
 b3-20020a509f03000000b0056e04471e44mr2908585edf.8.1714630803976; Wed, 01 May
 2024 23:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425212624.2703397-1-dw@davidwei.uk>
In-Reply-To: <20240425212624.2703397-1-dw@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 1 May 2024 23:19:48 -0700
Message-ID: <CACKFLinpX_pC-rge6g+yU86rx-nnXaTQqXBEpwHAkZbbpdG68w@mail.gmail.com>
Subject: Re: [PATCH net-next v1] bnxt: fix bnxt_get_avail_msix() returning
 negative values
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001a847a0617729880"

--0000000000001a847a0617729880
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:26=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> Current net-next/main does not boot for older chipsets e.g. Stratus.
>
> Sample dmesg:
> [   11.368315] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 Able to reserve only 0 out of 9 requested RX rings
> [   11.390181] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 Unable to reserve tx rings
> [   11.438780] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 2nd rings reservation failed.
> [   11.487559] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 Not enough rings available.
> [   11.506012] bnxt_en 0000:02:00.0: probe with driver bnxt_en failed wit=
h error -12
>
> This is caused by bnxt_get_avail_msix() returning a negative value for
> these chipsets not using the new resource manager i.e. !BNXT_NEW_RM.
> This in turn causes hwr.cp in __bnxt_reserve_rings() to be set to 0.
>
> In the current call stack, __bnxt_reserve_rings() is called from
> bnxt_set_dflt_rings() before bnxt_init_int_mode(). Therefore,
> bp->total_irqs is always 0 and for !BNXT_NEW_RM bnxt_get_avail_msix()
> always returns a negative number.
>
> Comparing with a newer chipset e.g. Thor and the codepath for
> BNXT_NEW_RM, I believe the intent is for bnxt_get_avail_msix() to always
> return >=3D 0. Fix the issue by using max().

Historically, MSIX vectors were requested by the RoCE driver during
run-time and we used bnxt_get_avail_msix() for this purpose.  Today,
RoCE MSIX vectors are statically set aside.  bnxt_get_avail_msix()
should only be called for the BNXT_NEW_RM() case to reserve the MSIX
ahead of time for RoCE use.  bnxt_get_avail_msix() should also be
simplified to handle the BNXT_NEW_RM() case only.  I think that's the
most correct fix.  Thanks.

>
> Alternatively, perhaps __bnxt_reserve_rings() should be reverted back.
> But there may be paths calling into it where bnxt_get_avail_msix()
> returns a positive integer.
>

--0000000000001a847a0617729880
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINGe7KmIbFxkXmYIphYyTX30jMhsL9le
wuCK72USkfs3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUw
MjA2MjAwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCy4Ji0z9UO2ZQn2hnqqtR7FfE758/Bb/D6/HSNpHiM7eVXlBLU
VvBffXyE5lcCgXD37wIqXgXh/fSIFg2DA1IIUkQee6uNIcbJc/YmBVicYQi29mXdLJkcCpsZogf4
Uo4s5iYINdaPiktP0Kjk7ZvuRE8oFIMUjgwUv4dzF+Jlvkv++I+omsHGkHnk8BPcj3JDSjwzXz1X
7xMitc3I1o6NH8A5Xc6Eci28SuuCSczdlT64VplGIdcxeSpLm4oiq88IDZLcW3kqYoKP+dGo//TC
eL6nVZAuFPPAi+CTIDLS9uaeFRA8sMOQ8R2YwiXe2i7futQuasqbImaaK9ucxb/J
--0000000000001a847a0617729880--

