Return-Path: <netdev+bounces-162413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE2A26D0E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FA216543F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DD2063CB;
	Tue,  4 Feb 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eFgboTdH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745D86358
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738656827; cv=none; b=rFmJDZQA3NqAURXWYw49viJ12qTo1DohqZjdUuYycSwTZoJshcmK373utTlqrMdHsXekOb7y1gGOuxZltKt1yqHRzBLEuKz2VIYQ5k5gA1DCe/8n3L2f+9Ah/4jXsi5TmO47jrD4inDhfUO+JYU5blwPrMAqT30WXqV/j9LYijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738656827; c=relaxed/simple;
	bh=1D0wWG6vALJ8tzLc5/y+4bTu5a7eR8DvIqyV19aP2AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdySveAca1uL52Hz29N6jcLbYHGuApi5dXAfZobKQ0J8f0Q3msZaZmqM+sDpb6MnGl1uan5Pj4FLzUqz/vCgtVqp+YLKFAwDNbzwMTnmqhUW6zmZ8Q5HW/C4F03GcOkvNxmuBf+lbzk42Sw1CSIT5V3vJ2/mcSsb+a8t9stWCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eFgboTdH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so8418694a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 00:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738656824; x=1739261624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQlEYPdSwjextI+YI0lwNOPr8Xj49Avo8oy+SBGisso=;
        b=eFgboTdH57i3wX5hTvOODosaBYYxAx1V3t7J6nTQ2FgatsjGNAAU8npzzNStu7HpNu
         o5AQAEi7KQmX/iCra3D3MmFZoXJuIq09FbSqwJ4Oi2jzLbJoppmZPQJoxZSSxtJCg5Rp
         pYc4uwfgntyIHOWBbWpXFqflZcZoNcNr80NXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738656824; x=1739261624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQlEYPdSwjextI+YI0lwNOPr8Xj49Avo8oy+SBGisso=;
        b=J2EWBfQrVBEMkcZfAdgmn1M06pta55dLuK5A8VZOccHsNChojd4nGokF5CFfyVv/xE
         ymWwbxGNpnqg3JnCF0DsWgzLEas8FH01/EbSiJjVdxjjIF3ffUn9JjS+P7OWf4zVkCEJ
         YDCQoTm1LjtM9wND3Hy8lHrWZ5Z2kHcqdMEiDc9ZzBwYiJFT2Tq++F+hQOIqKpNEQoD5
         MBvveQUhD2sDfW7+M7HeM/6gdMm/VolfCgICP8Bvoe1IhZ3n+0k0u+rwU3XGYtLRoUSi
         5bQJDbExFq148yJ6uyxi8cnYBCAEEr/rcMmVl8I78I2Aqzm9J2Gxq9hhx9xfHztxdmsa
         bJaA==
X-Forwarded-Encrypted: i=1; AJvYcCWEJB/L4u+ItejyuMQXcG+3DSyJov0mp85UESAa8u2QCbyU+9PI81ClJYsc+yi4/apON4wcbjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6cvbfqUPFkyRaE33DxrBoSbGq94koXRZ25N4RHxmSEnpdiUv
	C1qeX2MVcJTgEwxCJY16Bmbm/KMTWofC3hgb6UTrW6k0xm9A/H8sbVvPyQUWYT+9UMUIFfXOaNw
	RqCz9Bgyy5g/7L7LRK8S5+b3+DQeihBKfEe2m
X-Gm-Gg: ASbGnctf6+I748a8914cWCzkO0T9zdoYOZQSS5aNpYRIMQ2TW2ibvzVXE2FDkwmp1dE
	odPly2qWy98LCvVB0OWzx2f8CSlv3ApCfCL9eJSPncfVCRVpRLjqkZNuYXWB7PnvDGv1JhtY=
X-Google-Smtp-Source: AGHT+IFZNpxjNPHIxPU8Hx7WU1vCsZ3uNlNFnPYn35fyTXxMTTv+vOJTE+EOVEOGeGTBnEpsw6KXs3T5ZUBF/jd3HOo=
X-Received: by 2002:a05:6402:a001:b0:5dc:88fe:dcd1 with SMTP id
 4fb4d7f45d1cf-5dc88feddb1mr13378662a12.12.1738656823691; Tue, 04 Feb 2025
 00:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204004609.1107078-1-michael.chan@broadcom.com> <20250204020247.GA819839@bhelgaas>
In-Reply-To: <20250204020247.GA819839@bhelgaas>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 4 Feb 2025 00:13:32 -0800
X-Gm-Features: AWEUYZn2ooY8x9meRvNmVhpx2S1ucM2LBu8wEcTbrPKspCNYhPQXsMKDFpMjgHY
Message-ID: <CACKFLi=FK2HYy-QZ-cYxArnurGa8F+KDcA=QC=nj5dO=mWzvaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] bnxt_en: Add NPAR 1.2 and TPH support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	michal.swiatkowski@linux.intel.com, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000062f99b062d4c96bc"

--00000000000062f99b062d4c96bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 6:02=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Mon, Feb 03, 2025 at 04:45:59PM -0800, Michael Chan wrote:
> > The first patch adds NPAR 1.2 support.  Patches 2 to 10 add TPH
> > (TLP Processing Hints) support.  These TPH driver patches are new
> > revisions originally posted as part of the TPH PCI patch series.
> > Additional driver refactoring has been done so that we can free
> > and allocate RX completion ring and the TX rings if the channel is
> > a combined channel.  We also add napi_disable() and napi_enable()
> > during queue_stop() and queue_start() respectively, and reset for
> > error handling in queue_start().
>
> > Manoj Panicker (1):
> >   bnxt_en: Add TPH support in BNXT driver
> >
> > Michael Chan (5):
> >   bnxt_en: Set NAPR 1.2 support when registering with firmware
>
> Is it NPAR (as in subject and cover letter above) or NAPR (as in this
> patch subject)?

Yes, should be NPAR.

>
> What is it?  Would be nice to have it expanded and a spec reference if
> available.

It stands for Network Interface Card Partitioning.  Basically
multi-functions sharing the same network port.

https://techdocs.broadcom.com/us/en/storage-and-ethernet-connectivity/ether=
net-nic-controllers/bcm957xxx/adapters/Configuration-adapter/npar--configur=
ation-and-use-case-example.html

I will fix the typo and add the description.  Thanks.

--00000000000062f99b062d4c96bc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII6Bia12GMlyWMITIIvP7qKK21JI6vHa
swugT7wyUWiMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIw
NDA4MTM0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAf3KECNAKPnvxTPcABmMrqOWwRjbzLJt3S8Lj4CWaIbd8wUTMs
AaIAmEpqtW6vJEU+8ETaDYDBFkfpwA0xgykAAotD1vhIUqnAvv107co55qNEr7IhbgYMdOGv41Pn
5ga3H7GU5TETnhHKSiyrPclAVtywg08xFNqoBPknmZ9kQ1brRZIj7SbVxxZuX4B4TU8xEMVj5OGW
vh0Y677VqXoPJxSWzZHPqrMZFb1wbJaYMDEwwD/M4SvJS6Kq+LN/xNmhZ/iULAZdzORsZKPj7m7z
5MVVqgcZfjXcAM+Ha2afkZIZP666/3VWfgCndN8udp9eE3KUZC1JSKyhaVcACLRX
--00000000000062f99b062d4c96bc--

