Return-Path: <netdev+bounces-217093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED2B3758F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEBA3BF9FA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD059308F22;
	Tue, 26 Aug 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ClKxExNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E60306D47
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251147; cv=none; b=P6tbSy4gmwmVNzT6B6ZD6TGqCecdxej3zsv7Rq01pa3pkTc8alv1BlC4gYEEm3rtVIYgjEMY7wqblhsc685sOuWnEA1fvIVU5RRfHF711vAbvio1/wb0ag18UOTThMq6K4gG3+lB0LKFX8qnPYAJXs3OgXglmKexZ4IMdIxaBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251147; c=relaxed/simple;
	bh=rr66sSJ/sz/wOgqawj8kQqE8+gcEOBTLuTOOjG0+mlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdLLNBKAbIQz7+ENrJqmZaUafdhQPbLtItxHiNRkCziaQlcc+sjFHTPj/US7QhZZ+YvzWbHlCpEResHAL89lqj7HaQ+NXiBmCYPkQfWjbaNZdthmg+RhWy3TABlF9874UNy9FeMmz7gOxpSCEdoDj/mMXpccYWXpMdhhi3j7Ezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ClKxExNA; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso3720135b3a.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756251146; x=1756855946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1qF16fpFKINCLUROQ9+I5lXV8Tbtu+vlaDq1WDANNM=;
        b=t7tBhTUim1AtepDGVAcc7+N96HDRGSyQDZJ8Q20KBfMEDT8OVayUakTTT3m3x8SLKt
         MD75MgO0Z02VOBiR2a9LcdULbx2bzrHP+0e2Y1f1UBwyZnSu/g4s9OjpFD5DxpxdosyF
         Q694cb2IpRyUEAFREH8IMriBwzEAWfkxkkOrnz0v3HkNUsiRQ5kvEgnhbd5JuPKjM5Sd
         AUzXqlWjWgJyVNWyPegA7njtVFSge0gbRMajchttMYLqHy1FZQQGsFqaO+lxCKle6N3+
         iG9nyGiqQPFoP/DYwIX9UsGdSmk7t+wxXjs5LVcgP6OJB8WHnIZgffNdm4H6wvJqqYGV
         5V0g==
X-Forwarded-Encrypted: i=1; AJvYcCX/HjVRPuNR3qpVnsOG47KjtqDs6OGA3e+OvKAKmBvtrVNWKnJL4q0XRhHKpXS6z17Sqf0ntW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHzJdI/NDm8XaklSevFNFXWv6AC2zOSfIBZEByfADB/0VzC38
	hvm8MI1wMzspwFAeGoG0OmRjiYmAoDSPSyrkP3xzkr9SM6jR4qYCyRZXl0xTKVrMFnEfQNpD0Uc
	+JXkAEixo79cZyRyhAL7YZ++6cd1RuxntsMjdRTq6YY0bZvkXsnKG56lUv7bhGTov0ey4sDPhM/
	i4vOF968jD6MfGOhKwLVeqvNzmSzQyNuiPNMSH9ybI54Xe2LvJ4XEV0/CdsobcMFfuMpbai3K0x
	UYdSCDp8Zo=
X-Gm-Gg: ASbGncsOnKYehm2V+FvmySFHknWvMWTWYXHnFfJGn+msAP2ikqHg1wMeaCMSDaYTe4b
	ZwcFIFccONW1S1g/kllyCdDe2+s8eGWSadfZENEADxpR9TzdWx7KS3Zbl1M4aXdzGxUvPt+jyVM
	jBKvBwZi0PESZB7rWC3htD92ggqrusYqVZBcG6VTlgTiG/9WnaBvcRWkB5aKfp7H9gyMeo7GY4f
	bj5j+poWlE5riwYHJ97eSfDaGCN0bvDxQVY3K8AlKc+hKTqbVnDIPhorVKhM/M6NuyXaPRJxBzT
	Jzq1Uc4vonAP5lIs5v3JNTq+Zjc1lAyBoc/gTrlqiCH2vp5XWpbncRpM+wVAbJ1NLXM6o+Xp2To
	ehWB9VVuKeu0xM43M8O3/6DNOn1ZQaEcATKqVPfbaag9iXwVdFltM/lANJtrXNpx18yJ32Sdn
X-Google-Smtp-Source: AGHT+IH0Oy6DYwl/cH0lUce1ki2a/3GkC3ttaNcOklJ9f3+grPY8FGPvSo/hCuP/A8h4krt/puY+GEpyDE73
X-Received: by 2002:a05:6a00:7619:b0:771:b230:f0a3 with SMTP id d2e1a72fcca58-771b230f3a2mr9981482b3a.19.1756251145611;
        Tue, 26 Aug 2025 16:32:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-77053c86f02sm650086b3a.5.2025.08.26.16.32.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 16:32:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb790fcfdso467913466b.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756251143; x=1756855943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+1qF16fpFKINCLUROQ9+I5lXV8Tbtu+vlaDq1WDANNM=;
        b=ClKxExNADcNSjqQKKcag8udFxY7XyeteGm4fD5IczOPoYd27/7BbKvaDqM2IF9w0zp
         Oidy6jzgD425++upTu89AIstGFi+OL7asML+ZChcwKUasczEYTc/nUG2bWw5rU4byphs
         PwKXGY1ORcAafaNbLOT7Z+9PkVwyabDoq1p5o=
X-Forwarded-Encrypted: i=1; AJvYcCWfxlJUmxX6JWtcgdBanJyJqS96TewwRETUo0tZlb8PKM9WMLkK/DEyCpLd1IkznXYdbRuL/gM=@vger.kernel.org
X-Received: by 2002:a17:906:6a1f:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-afe28f2750dmr1614027266b.26.1756251143052;
        Tue, 26 Aug 2025 16:32:23 -0700 (PDT)
X-Received: by 2002:a17:906:6a1f:b0:ae3:bb0a:1ccd with SMTP id
 a640c23a62f3a-afe28f2750dmr1614026166b.26.1756251142662; Tue, 26 Aug 2025
 16:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826162541.34705-1-qianjiaru77@gmail.com>
In-Reply-To: <20250826162541.34705-1-qianjiaru77@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 26 Aug 2025 16:32:10 -0700
X-Gm-Features: Ac12FXw3OJwmOdRtTFdWBPv9wNpD7ENFEGqbAyGAqVUSK0iRJJFSiHoOpohK3PY
Message-ID: <CACKFLins__qAd=RrSGLXf+2_rf-VWbodqEaoMAZZJoU69Uw7=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] VF Resource State Inconsistency Vulnerability in
 Linux bnxt_en Driver
To: qianjiaru77@gmail.com
Cc: pavan.chebbi@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000897f18063d4d1566"

--000000000000897f18063d4d1566
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:25=E2=80=AFAM <qianjiaru77@gmail.com> wrote:

> ## Root Cause Analysis
>
> The vulnerability exists in the VF resource reservation logic
> where older firmware versions receive incomplete state updates.
>
> ## Vulnerability Mechanism
>
> 1. **Incomplete State Update**:
> Old firmware path only updates `resv_tx_rings`,
> ignoring other critical fields
> 2. **Missing Hardware Sync**:
>  No call to `bnxt_hwrm_get_rings()` to sync complete state
> 3. **Inconsistent Resource Records**:
> `bp->hw_resc` structure contains stale/inconsistent values
> 4. **False Success**:
> Returns success without performing actual hardware resource reservation
>

I will review the driver's code path (!BNXT_NEW_RM(bp)) to support the
older FW that only requires reservations for the TX rings.  This FW is
generally about 7 years old.  More recently added code may not handle
this code path correctly and may have the issue that you pointed out.
Thanks.

--000000000000897f18063d4d1566
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKktCTI1reuotA5WxfslcRDyblkm8lMa
u+jYwmakR8fcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgy
NjIzMzIyM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAH6ezteXNSvjMjON8a3mF2afYYp+XBtk2mPhz8yClE7vNBqhhIyE1CIEOL9G2J/W4aoB
+GGi33YEjRKgC2YxGkAFOxRYwojPOtBqs2aPHlXM6Kq8+bcwzBLRjUPponUF45VQhLtbfzIwOfTI
L12UWi0+yZObd6w4Cum0KYXutapzB0xBUgBU6oTStWzAtQreChNOdzohmJS8HgBUiSve79DetqSF
GuFNde1jkCjglfaQNnSi8ErhBqSrtoOhjuFbY+M3zpMdxCoFkxSNPVzdtVPFf5MDribTZDgDGrLD
ZQkyDs/LzQ9U55lyHXvjoieYaQqQYrwl9/YlFg9qHkLe0z8=
--000000000000897f18063d4d1566--

