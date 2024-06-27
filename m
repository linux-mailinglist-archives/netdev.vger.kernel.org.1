Return-Path: <netdev+bounces-107376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B291ABBC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531A9B2BAED
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35493199E92;
	Thu, 27 Jun 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EsfhwmVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D2199E86
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502483; cv=none; b=GsJLIiJDnNdnGh9J4HFJgZB7rMBLpOY48HoFwXrsAGRyfIZ6Zi4+PpybSUqWTxpnEvdH3k8Yc8RXviITtGv+zshmTiFSVQgV4iLeAZRyKo78wzpxk+2H4kW+Qn5EY9FDtBBgrbiV139aCdCXLq8RLPWXGuUjEfndLXbiUKXS+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502483; c=relaxed/simple;
	bh=E8cZkLMLkZFUdABW8B2eQmUl1wOUwgNzCrP7QMM10BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtFWPLi2F1487SSobIwENJ+NDPYw8+4abWU+zmR8mq1HsQh4DDv50NY7NEL6elwg0V4L9/3B1MyOhNB015pXxg/+iRIS64aJfb+CYXFJ6VfMGwxMUy4MwLQpB6NNsSHxnGkrZ/45i/wIUeH3ixooYqF113IjWLWcBYIhIxC5rqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EsfhwmVi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so6130815a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719502481; x=1720107281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GLOflnZOp7u3f35YfJVqR5DFe2bq4cOYSiEZbXjK1ks=;
        b=EsfhwmVixt6iJwMAdHloh0hcwxp/QA7usDRQkpABFXUQ4BQ0WgI2MnM+j3HO7oyY6M
         i5NumvCKiukvrJlNRb1xpeUCEeXHJum+l0WPVnJuJydd6KhL16ujG4cNlBSWqp+vUAk0
         lVXtKegCUaeOwuiB1+xA4CE3ueVD5j38NQnj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719502481; x=1720107281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLOflnZOp7u3f35YfJVqR5DFe2bq4cOYSiEZbXjK1ks=;
        b=A3ZarJ0tRB6QSaUlQopoYcRX1vY3JpekCJLgaX0ku2g9qlls7Z4fecfMLhMKkWq8u8
         A9qml+1gmwZyObWzDqunyiKXkQFbSC+LPYwUE/QCTtnpXBzOZd1HwchQrqsl5zy26p4S
         GBWUqbOb+0ZYHbtRkANjnCtvpNU8ajCX+556J2189mdOW7ImMhU/6aAA/p8xH20q8+F0
         EvlzqY1cNmws3JC4Mv7rm0zSJS4e2j+IxMCKdOyLK0CYf0i1zO84ZI2Kng7yIE6ywiDN
         OPj/ZIj6MjY7J3CEjL+KmHYPYjaM2F2TdFRSPmuZd2jXUKwuIrzM0MZYtTo/dLyDuQqh
         XmuA==
X-Forwarded-Encrypted: i=1; AJvYcCUPM1ghcJ7EPjDoDIZHVccBR6vQ4O2m0Baupw7hIc3o8Xp8B0njCn8PvyTEhT8bggTFFaGTSpEfdTFtaCjEiLAs7yKuo7AV
X-Gm-Message-State: AOJu0YwuU/oIKptJI4dnmJ65hpdPL6R4vVXRikzkwiH6WaYO6WBMzF62
	ramKMBFGZBZRZBVmC9p5RoIlXRw/d/HwzJS56QBLEkqzSbK+D5HYeTZlJHxQiN1O0ex8Uw8MwAY
	fB8PaGaBHGNS51Ep4M7ctG00a8P6FssDaN+PQ
X-Google-Smtp-Source: AGHT+IHkzARFb1fzxI6KhtFqyelCG2Wi7R3gxyw6imZH20ULUeq9y2wrm6Bpw1jv5O9FODjGgPvTWd6FeCkW2g6Sb9I=
X-Received: by 2002:a17:90a:e150:b0:2c9:e44:fb62 with SMTP id
 98e67ed59e1d1-2c90e44ffeemr927800a91.9.1719502480266; Thu, 27 Jun 2024
 08:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-11-michael.chan@broadcom.com> <cbd9c870-def1-4f06-92ed-67d809a7d8a6@intel.com>
In-Reply-To: <cbd9c870-def1-4f06-92ed-67d809a7d8a6@intel.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 27 Jun 2024 21:04:27 +0530
Message-ID: <CALs4sv2YsfZrqqXxbw47EkBsRJnr90B8sQkNz3Wm3J=zaWK5xg@mail.gmail.com>
Subject: Re: [PATCH net-next 10/10] bnxt_en: Remove atomic operations on ptp->tx_avail
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com, 
	richardcochran@gmail.com, davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000961e3d061be0de62"

--000000000000961e3d061be0de62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:10=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 6/26/24 18:43, Michael Chan wrote:
> > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> >
> > Now that we require the spinlock to protect ptp->txts_prod, change
> > ptp->tx_avail to non-atomic and protect it under the same spinlock.
>
> Under what condition you will exceed those 4 entries?

Only when an application chooses to do so.

>
> > Add a new helper function bnxt_ptp_get_txts_prod() to decrement
> > ptp->tx_avail under spinlock and return the producer.
> >
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
>
> overall it is a good series, thanks!

Thanks for the review, Przemek!

>
> > ---
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 20 +++-------------
> >   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 23 +++++++++++++++---=
-
> >   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 10 +++++++-
> >   3 files changed, 31 insertions(+), 22 deletions(-)
> >
>

--000000000000961e3d061be0de62
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIouanIVYUOnaTZauCuvtlxIe00rW5uF
Y+FFejQgM4lGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NzE1MzQ0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBNNzoeHxrr531Vo0DkENSNLPJ9vSFgbq7UEQrlJQV/T69xbb1x
4CMTWiNp5iRGmlX66jTTCL2SHN7Ppmv5ZxNNceP4WPWvC1WLoIreDpLG2BjgjLcHWnTunZ779ClB
N2VZKJE93L7bzNmedGzZ/iaMIqBxK4wnrtwTZxbNOBRQpnat8lniPkxYjZxhIFSNAWBgrB5q671x
o8Dxoe7Ho6xdMk2hNk5h56HeDasMA3SB2EjboEbbcDd+kMvPFrchpb3660jqLGo+etL5JB/lgQ7g
VxjIp/B0ynR3ZW4A9tfMP78fnL1tvgqDIZkburykr6xzE6hfISYIkfwNpFW8TTcr
--000000000000961e3d061be0de62--

