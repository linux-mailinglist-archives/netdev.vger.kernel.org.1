Return-Path: <netdev+bounces-162415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C8A26D27
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461D63A848A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB72066EF;
	Tue,  4 Feb 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YS6kCUTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA602066C4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657247; cv=none; b=TRZTLyjKoL6eovIrm3VfWYsSZMji8+uXjIbg/SpEB/LpQdl94k0bs2koZGxLM2J23c0YblfjvAf0prW2dDOsfjGENIZqi7bDvOCLfCC/vTsZ1F81F/joGYaB8k9X2uaqyLIP1/RalpR/leiFb97xneQkinzh8CZxgF9STmXQ7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657247; c=relaxed/simple;
	bh=4MJX16hV0ZmzZ7bMPmLn59F+PjnHrleKM9ghobD0txE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmt8jfMx6vPUTd5rmnLyz4IifrCSf+QI0LlKLvlNmaLDjIREjbg7OaEPKAxIKm3ynrmDahXBONzjv4F/qZm7U5zbk1Nyz1Sf6QnY81cx86bUvs5+8nzc9n+obYJDuMLMHmbdxpalHD649u83GfdrhP3WgivrhAK9IrHQIyjacVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YS6kCUTi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so9192246a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 00:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738657245; x=1739262045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MJX16hV0ZmzZ7bMPmLn59F+PjnHrleKM9ghobD0txE=;
        b=YS6kCUTip8PWCZq/oiDOxH9BJKt/Nt/g4uAWHCIRM3It1ls0rnoP+DBRa1AmKeQlgp
         lqUJVkZNEi8+ZdW2gjDMy1oXRIPYbkEjnWLKq0GsFcLso1bCTJOlCfYhDZaIdanrDPkF
         PTY0KbVMLtClfTQ3otEgQ+ZLs1ojzJqaCGg8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738657245; x=1739262045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MJX16hV0ZmzZ7bMPmLn59F+PjnHrleKM9ghobD0txE=;
        b=G+jw5ALSStIK0cQhCQxlehqcq1fAPRrgg9kI/7Kel1bJccoEhSwG1Sz1ds6WLzmbrN
         UL75LLGVNs5UwhBszX2hvHQivIH0tdEW6BQJx44UMXko4REPEp2ZqG9LhwENz+XTnLPM
         lrO74i9+TRK4Y2KtqdJdqN1W8YqWdKl1WRBAvrSIUoGmfgMe0DsrBCahZys6NKYxfPO3
         tEiyeaEhYicXK7Xo2So8xBdI+BmXPHELiRGjepS4WeZE7yA9as2vegB+C8k7c1Er8QVq
         np7z95krzreFQTvbh/Dua1aOnaSsfey0w+JhBrhcAug1d+okNId5CBoG2BdQmE1Z6pcM
         kv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHlT/i3OjVoH7mVD+KZCI0fYUj6WpGNEPWhc4/kBiZm3wozIMcxixa2zJPG3AV+QPNhB88HNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgrgfpot4eQII9341pG83RobWoNMt6+lP1qiAXC/RrWO+3Ubae
	+w2ybJdqNXXm0S4iDs41S7Gc42Pv9REaY7ue11hewrUN0I3duxTbn9S8TAp3ebYMJbz8PSYJjiI
	m7dKIoUKb+lGs5Op6bdHV9UuHxo6IL2aHsDPx
X-Gm-Gg: ASbGncudDRfMJb0VIIIcj8jQUs0lgDW9eyrYGeoQ75doWaXq2kNeL2muC8Ua3tYbjda
	QMSlpi3zXyc589WonCChl4OtJup9OX0LQ5O0nHTFWVaIWSiQGj8RJsm7PON6kjM7zn48fEVhh7A
	==
X-Google-Smtp-Source: AGHT+IFxbhmXRavAe0L+0ctJigTEDkB5jFYt3PKhvc7fTBTfwj2e87debVpBVw0v/hgd9FQExy7yhXSPT/JzO+Nb3ro=
X-Received: by 2002:a05:6a00:180b:b0:725:e499:5b86 with SMTP id
 d2e1a72fcca58-72fd0c714abmr40134656b3a.20.1738657244903; Tue, 04 Feb 2025
 00:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203185229.204279-1-linux@treblig.org>
In-Reply-To: <20250203185229.204279-1-linux@treblig.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 4 Feb 2025 13:50:32 +0530
X-Gm-Features: AWEUYZns3V7t6dKjtJ_m_w4cCjAgqAohIkpYS5iV_RZ99M2bdt3jlRHzhse0dI4
Message-ID: <CAH-L+nNpygfP9HZJ_4eLJY8gAQ8cpPHPR7V4+i1BOypsb-0UiA@mail.gmail.com>
Subject: Re: [PATCH net-next] mlx4: Remove unused functions
To: linux@treblig.org
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, yishaih@nvidia.com, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007d4034062d4caffb"

--0000000000007d4034062d4caffb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:22=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of mlx4_find_cached_mac() was removed in 2014 by
> commit 2f5bb473681b ("mlx4: Add ref counting to port MAC table for RoCE")
>
> mlx4_zone_free_entries() was added in 2014 by
> commit 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
> but hasn't been used. (The _unique version is used)
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Reviewed-by: Simon Horman <horms@kernel.org>

LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--0000000000007d4034062d4caffb
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
AQkEMSIEIHIRVxrpHciYf4+CsIbv9BlTjlYBDPYYEpkjMBufF4byMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNDA4MjA0NVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB7zFwaxYiJ
FUJSVx0GiNfoOMqJsPxQ85bOMUDjgButGoV7BVJD5Dh423RopTodgrWaBvHBF0fZsU2loWpEqBnD
JIf903A3t8rNXvXQtrVBPgF3tZM5agK/DLuF7HWXC6eSR9pAEDeSJEpK0GkQvCUny9HBE/ikf5V4
XzFNzJxeblvVeDCtILUnlP4g3RIwLWTgzEhDZEKnn3Rpx8Z/hxfkCOyIMyEdLtFIB9ysg+W5SNXq
LRhS2zVgYZr9s33U8LhBdpieWkGm3N14aW38pQ5Zh2adcQ9sMJJ6HeJnRnhzYOsTcSl83Xna7kix
bKu2xbVlmx04RKP56GYK99IlgjqW
--0000000000007d4034062d4caffb--

