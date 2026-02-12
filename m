Return-Path: <netdev+bounces-258496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODB0HsgljmlrAAEAu9opvQ
	(envelope-from <netdev+bounces-258496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:11:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5704130959
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9985300C279
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341351B81D3;
	Thu, 12 Feb 2026 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ea0ZR3kt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AF1643B
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923460; cv=pass; b=bgu6IrQ6SQZMjpYpPwTfZEwLOEj8DeYDkOususDqGe7sFMZtvmICzfHY6kbubqpX9Pv8NgoDoTrOB+aT+k/6dJFR2Y5S4vhxB+Hn3l/36uIfVLcUdL3oK+hMlRsRTHorhVIEy9tTP1vYeeLZigYFbF07mjmSvGBNSZ8inAYBUHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923460; c=relaxed/simple;
	bh=Zuwma9cq5BMcXGGy6Z3hGLVWQGz++UUO4bV36hVKyeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVHtYdpjAqyfD5uxTeF1nvtdmk4oJSesBVfwAxmAZzzPY118kv6QSzP8wmnO5sXg3RPgUMW9BTdwuBnKMIcp2fC6pyNNngR4wp7tMPrORK0bjE/Uwd2gF8TRlQCxIf/WE54tzpRM0vi1u2/5BE1vfvrggxz20CocW7Ur7eDBy6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ea0ZR3kt; arc=pass smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64aefa98fe6so150434d50.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923458; x=1771528258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i074dI8yhL9g8dgNzb8VTlddDSoM01qJKE86H/ioC38=;
        b=HkcVsW4J0IkBo7db2dOEwsxdsZQ1odtjHH7wv+R5FrNFjuO/npxL8QZytql4CPeKAs
         Epn6/nlzTgLQN28a/ILFl+c/TIVMmPmdBlzGXvWz4+7tS6Ygi5YdGqL7xWFVcIyVcnvw
         53Kvif9oYq6IjS8ifioOmZ3l1/yMd97wX10wJKw3mLKbZmVTjgVhsePhOHIHjkg7t/wp
         soTVMyk64E9o70I9PmYRDlLtWP7Zkf8oAkNt+NhK0PbhvTPSbROFv1uYj2fSoT2jRJ7r
         1akmhaR7J9DKNdkxnQLp0nX9APGnIILImQWAf+zn8Q9eqSgTMfncfenuRDAmFG96Ogbt
         iNKw==
X-Forwarded-Encrypted: i=2; AJvYcCVsTph4GvohMUOqlMhrzcaymiqge81+5SND/9oIZSE1ZD5g8tDcjz5OJojS6XJhlh8i81hm0NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgP7rO3jYgAqCtMEewBACAjJhZqkQpPkcU/I/ncN0VzBRUY98
	SX1jVAyLoVWkZSAWQGQKJSOBFH71NeZJ+YQa5diEgVbB9459vUVH1iqHNNXwE7bj4Hzqp/VyzWb
	G/WDXnjeUtDqrvV+615EzngwvdCFNZnSIyxQAaqTk/ZPhdLBKOLWXWIBRE9vl4Pqn9mCXroci2W
	HAOjeAFdF1aNQ9gv72y2SR663Z20x06stcPEc9XBnXhevtqFNqG417+IEOmCvRz+UmHxS3qs9hT
	O2ks9QNIXg=
X-Gm-Gg: AZuq6aLU75R5P4+xxdnFSNnP1ooDPF+xxJc/mZb9OBGdMhxtLL/dRxMagDL8C12yVX8
	pnyga5VguXkc6Z7Sk6bAkEdpFd6KwvcNkCZlPrUg7/zTKgBrDk9RXc/AHW6/PCHSvlJ/Tv3FTed
	dvnDjNrAhJcJVjlJ2sF3adYBxCPs1IwgUdfjOwpYVmEBawOMypGeYZjCCB0ulF2P7rf4aU0+U7s
	L+okdKvgsHQLTYbCcLANSN8VHdcJTK8Dq1nfVENxbY190AOre1DL72Qed6cLLZdZsDGGJ5ZUr30
	QWnKq/7sr21J3PuhyFUziwE9LyzUKSkgRQsToDTT4O265+g0NRfPTa/3zYR0MXZQYnnXhjzdCQq
	IRgbv9lYvtnWo7YDCi1B2cIy8Y05p/FyNLyNlbGBwTtm94lpdaghLXW6oXY0SO+m73HDoi5qM8a
	762kLfIFK6R/rFajzhb1gbIaU+ceFhpNRNOlVW8zTGkDw8mBnoa3AwroZ6
X-Received: by 2002:a05:690c:dc3:b0:794:f14c:462c with SMTP id 00721157ae682-797930e9255mr57386527b3.28.1770923457764;
        Thu, 12 Feb 2026 11:10:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c18b045sm5167237b3.9.2026.02.12.11.10.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 11:10:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7fe37056e1so5881466b.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770923456; cv=none;
        d=google.com; s=arc-20240605;
        b=hNjM+wEflm9ZCDHRAEOUqGp86WxYj60FKmvB+Vf0Tbb2SgdboCBbuqhSh76yIID9uO
         PW/GOagYNW9EWbK8Uqx3izQI9tjifDcNa9MCG2LzIzwXLSkftyS/Jgo5hLo6+8ZxX7L1
         p4o/tbEalJgx4uQ39Pyxzx244ls0IIjPQSXx8pu23N2CC3JRkmvOHF5CJ/PSVOMerBfw
         L5mLyJnIn3kP3/7IubBsd9yOPFwsJ+rloga795nQT6iEZDENgTHelmUcdg7hhctwvD6k
         xK3p9WVAGmrc2ZvfnKYJeemuDYBBunIGSfYyGWyNdW4E31/LjvttIe48WDL5sxyu9AcT
         /mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i074dI8yhL9g8dgNzb8VTlddDSoM01qJKE86H/ioC38=;
        fh=E7g2oWajlAGHA5xXxsB4rvcmduP10ryTt1bXbJ4tWtE=;
        b=CW9GuXry2SmhMZR76/SNwfSM1M5SAxx4qqQ1FW7fz4NNwlHdp+I8OmrYG2Cz+KQUXV
         Idnz21LiWjLeqat7+Mxd+sQjK58ISwV6/3VDwFJMzLdSrh+CIGZeUAqfQPaOxgxXAOkp
         BiiGXpQ0/LRQG+OiVOBEeRyCYUpx8GZ/8kOyHgCMnt+6Q6r8R/7ri0P9VoIhOPQFGkR+
         87uq84l1ve7Royiknrqwzw8jPVq1BhjwqgGj4k+fahftAsnMFbgMkUq+3uCM1/9q3CfE
         KYRcc8yPvrqnY5JpC7jZCRXjaOaeRN0gq8xObinH0Z5D+loW4JPWYsj+IQOvpbeH0CiX
         3TbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770923456; x=1771528256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i074dI8yhL9g8dgNzb8VTlddDSoM01qJKE86H/ioC38=;
        b=ea0ZR3ktRxpPL5x9aEDNhMYUCXBi3GhiOmT1Tw9sWgI37LQfieFjjqag4KnLYI5wH5
         hqQRJ9YDaAAldZaLt0EK/MzqBm3Jhb/kF/+Rt5pACrcEnwlfuM3RKuKv85Mqobt055Yp
         hqNF/iHDttQcBJ/MgHeQb9MCSSDgf8xHtDtHg=
X-Forwarded-Encrypted: i=1; AJvYcCXj/+LUwgmdNeY9SKaZH3SQhNqauU98+KL8Ab1k4SkAvajp0+JcgN5xTd7KLtkSGLlsGx3FqrY=@vger.kernel.org
X-Received: by 2002:a17:907:7296:b0:b87:9d1d:ec6b with SMTP id a640c23a62f3a-b8fac8e67bcmr7375066b.0.1770923455834;
        Thu, 12 Feb 2026 11:10:55 -0800 (PST)
X-Received: by 2002:a17:907:7296:b0:b87:9d1d:ec6b with SMTP id
 a640c23a62f3a-b8fac8e67bcmr7374166b.0.1770923455352; Thu, 12 Feb 2026
 11:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff733f84-9688-48af-bb11-12362d6b9758@molgen.mpg.de>
In-Reply-To: <ff733f84-9688-48af-bb11-12362d6b9758@molgen.mpg.de>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 12 Feb 2026 11:10:43 -0800
X-Gm-Features: AZwV_QiSnn1sjpuJzmYyWhOZ6zouwUKlM_bm0lf8cIxa8wQ5V7qOUEHgRg-mCrc
Message-ID: <CACKFLin5vLXDBhheP7Tm7br0-Zew1zpdfyZw3Lu1EiHx9Fw8uQ@mail.gmail.com>
Subject: Re: bnxt_en: BCM57414: 0000:c4:00.0 (unnamed net_device)
 (uninitialized): Device requests max timeout of 100 seconds, may trigger hung
 task watchdog
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000889526064aa53faf"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258496-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mpg.de:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: E5704130959
X-Rspamd-Action: no action

--000000000000889526064aa53faf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 10:30=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> There seem to be two problems:
>
> 1.  It=E2=80=99s logged before the name is known.

Yes, this information is received from the first FW response when
probing the device.  So the netdev name is not known yet and the PCI
device number is used instead.

> 2.  The timeout of 100 s seems higher than the one you expect, which is
> 60 s [1].

I believe the latest FW should use 60 seconds, but there are older FW
in the field that use 100 seconds.

>
>      > But 60 seconds is the timeout on most production FW and cannot be
>      > reduced further.
>
> It looks like you addressed some of this in commit 0fcad44a86bd
> (bnxt_en: Change FW message timeout warning) and commit 8ff617513996
> (bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code), merged in Linux
> v6.16-rc1. Both were not backported to the 6.12 LTS series. Also, it
> looks like they do not address the first issue.
>
> As we do have `CONFIG_DETECT_HUNG_TASK` unset, we would not see the
> warning with the patches.
>
>      $ grep HUNG_TASK /boot/config-6.12.49.mx64.487
>      # CONFIG_DETECT_HUNG_TASK is not set
>
> I=E2=80=99d recommend to have both commits backported. Will you do this, =
or
> should I contact the stable folks?

If AUTOSEL has not selected these patches for stable, I can request to
have these backported.  I agree that the warning is annoying.  I will
do it later today.

Thanks.

--000000000000889526064aa53faf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDOdyQC
a8vsKLkv8gqBn9QEIl5oV+9d/RDDDTit+5W1hTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTIxOTEwNTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA54tpdbdy7uPRrkCHFhfs/DfG6iFjukKuK4IQrsVKJ
29y0J7RO+KPFWmg1kAdG06UmY8FnThSQlB8qqzXA2LF7hm596iY6UrsOCfNihtpn1iqdBavnA94z
xRfeYL3+Xcet98AW7GXLdIvPubBviQmYgNzSP2ZbCkp0xz8HzGze23+INrwe/5zzIZKdzcA5++14
ADmMmbNYKqfm2yfBAW88msGU6Sg/mVUYzfcyBEBXRTgw5BaKh0/TiY8aCuZCQUBPCexyqEZA4I6h
lpKflY/E+3YejbRHOALrLlOar4jfwoDmBiFVoegSent1pXQtHWxD1Sjhb1+1rPYdOkvaiTxl
--000000000000889526064aa53faf--

