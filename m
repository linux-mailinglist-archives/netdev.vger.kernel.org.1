Return-Path: <netdev+bounces-111585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69F9319E9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B19B21443
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87322EF2;
	Mon, 15 Jul 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZBluxQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E871171C
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066443; cv=none; b=cOHnA/QIDAfKjQBrjt54WFcS8AskIeCXKvM3D/T7PMLqAdoT4VwqaeefpRPCAZeCoVhdOrYClR0QoTy4y4WrYCC8cKamj5afo2rjuwnTREnK1JhY8ZPQsHRuyjTrINQYMFJPq3Svd9s+gRbXr0kLE0zZBJDiRBK+xhXpsbW4nz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066443; c=relaxed/simple;
	bh=GADaNPDHTSggTybbD3HcNYa8Dy4pf5u+ifFU3f9GaLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrCGrtAqJllaI1UBcxU2gcHBIGALhYMl4aE3WUWPaqucEGDIPE3GZEYUnnU1snHQ3tW1ULISnOKJPZSAasoQMTd6f87aj2dq3ceKAuopJbVxRv+Nw51RgpTYoPnWYxJl4fQ3gdyiSgIim4SRf2f+BEaoK7nDVMXn6XECsKFvpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cZBluxQx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so5159794a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721066440; x=1721671240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O71sQgMCQUWs4HWtRgukg2GlDbpzrSlTyJNlpm9SUs4=;
        b=cZBluxQx7s0HPe7MoqvQR/q9Q/mefNIrMk0NUKWZx4irjWkAUP1RpU9geSUZLuoRrZ
         DlMeLBWQPLLR8b4H4+u/Vg8Jg2TYCSV0Q7of4MwHHLbFBbve5JozriawEfsgHidpd2Se
         VRr0d2jsCHN0tQa8JB4ymJveYXWfcmwORCjXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066440; x=1721671240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O71sQgMCQUWs4HWtRgukg2GlDbpzrSlTyJNlpm9SUs4=;
        b=vZ4slgVBZRt9WlKFoGOcMxKfkszqWDGmRdx4kh2rZfXwP16AglR1mZA0JSDaeKxxJM
         G+f+sdZ+eGNej1uoobH3et/m9lWqqR8bixBOEQNxKQi7aINkf+YI5f2kVEBudR68wi3S
         AIiTRw4SlBNMDTNLIEHTtT+82mWNJNqJSaZHGyjgQ1hEstYxnMNXKV/xBC1fiJWH6WC5
         o4Ei1Vu+8THOiFwcSf0iUBVFaR0zNix/aBIVRL4b/eNQQpUxnYf0MxV4I9VHKevzr4Ps
         VpDNmv24e1EQNTY2nKwIAupPOMiSXUmyuYiQJ02pOqovU1OyYy0C17jnV0lN+HIRSeo/
         5slg==
X-Forwarded-Encrypted: i=1; AJvYcCVE2fNGQfVpKWm6Ni9tuIfyWeYVnUHYBawcppN/UhuKLWzsl329u2qvQd+d+hOxRhS4jIdZ4ZCHzTN+JcXbms12XPE+JEMO
X-Gm-Message-State: AOJu0YyGVt1wpIQM+M3kQgvXGXSwyXtnnf0kxDOzmwPn+wihnDirwIdZ
	M3PVYWHdtxOvBIqAIVAo+Pvm+fjYzAIORfg3SRn7dG/cyHkFpXn6rc+hvYKpB9XrQFB+Tonbzzj
	FE6dGeH8vB8b2Q5e9Zu5qF9jd6h/vIVlhW12p
X-Google-Smtp-Source: AGHT+IEAIIWZE6mmlLXsD/2wZ1OyfExvcQh2zCFCACJkkulnMkgyD6ymWH+xU6zMr4wCVKGPYIHJfWd6BzK3oyKVRx4=
X-Received: by 2002:a05:6402:350f:b0:58c:2a57:b230 with SMTP id
 4fb4d7f45d1cf-59e96c83e71mr520327a12.13.1721066440262; Mon, 15 Jul 2024
 11:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713234339.70293-6-michael.chan@broadcom.com> <20240715173252.GA435752@bhelgaas>
In-Reply-To: <20240715173252.GA435752@bhelgaas>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 15 Jul 2024 11:00:27 -0700
Message-ID: <CACKFLinO3TSuZPppTWSU+P6ORfFQdWZLqyO5v48uxKbT8aS+hQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Hongguang Gao <hongguang.gao@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d5db0b061d4d0155"

--000000000000d5db0b061d4d0155
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:32=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Sat, Jul 13, 2024 at 04:43:35PM -0700, Michael Chan wrote:
> > Now that we only support MSIX, the BNXT_FLAG_USING_MSIX is always true.
> > Remove it and any if conditions checking for it.  Remove the INTX
> > handler and associated logic.
>
> The cover letter says new firmware (the revision isn't mentioned)
> doesn't support INTx.  I guess it's OK if the new driver without INTx
> support runs on adapters with old firmware that still supports INTx?
> So the INTx support was never a real benefit?  I assume this driver
> change won't force a simultaneous firmware update?  The old driver
> might work in a "pci=3Dnomsi" situation, but the new one probably won't?
> Just checking to be sure these are all acceptable consequences.

INTx was used as a fall-back mechanism in case MSIX wasn't available.

A new driver running on a NIC with older FW will work fine in MSIX
mode.  MSIX is always supported on any version of FW.  A new driver
obviously will not work in INTx mode even if the FW supports it.  But
INTx hasn't been tested for so many years that I won't be surprised if
it doesn't work using all older components that should support it.
Thanks.

--000000000000d5db0b061d4d0155
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBeMTdNGAWR4OM+R4pLsL6nmY0SIOiLz
l6M+v/yKNzuuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcx
NTE4MDA0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAjCrj7mrxjdrxvUnY9SvZQjefrIJAKl42n2YENiKd/LeCMUA5/
mArAqnomDDA9bE5AGQYVMzxtuRqKZ6GwGTj325UQ9yYZ47O5S/iqJxBg8ew5jR7L8OG69B5KD5sV
mt3zkPn07JveeC2aoPdvg9vsE1FaHzIg7WwHZ9/VejGYsHpjrDjOv4Eo/rqooS0KiSbos95mEi15
UCHHIH6VLhJG7q+kkBgMiNt2c3MjC6sQyqc86D73eCyCc4JrPH1Wa6uNPRblnyPTaQcai6VGf92l
cipkJzQzg+1gqGHvaYi/a7UYax2XtI+npfya9iaNLrL14HzAmxqLWJ9SrSfmNDji
--000000000000d5db0b061d4d0155--

