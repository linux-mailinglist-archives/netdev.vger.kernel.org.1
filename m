Return-Path: <netdev+bounces-220805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A4B48D37
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4D53AB93B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A22FE564;
	Mon,  8 Sep 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dm60EjfI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357F2FB965
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333846; cv=none; b=hiX10Mnw/tJ54bBcIk/1/kkx3SrcDHn0QrviihDji5wy+pnULdMWE8fKzQEEhPHDXcYlmjlpUy9d3VZS+wgvCQKS0dd+7CkidIyC3bJaVaOYvE7GxGhVGLPNfM/A2MO7H970nReoCQ6UKkoqraWJAi5A/lr+IFggjV7oyy8wlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333846; c=relaxed/simple;
	bh=r0DBI/V8xAPY6M/SGiVbx2uVoE9/HmKg8Vr0g68qHJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCK9btaBh6KtKHHGAkSlxCg8AriPRMjW/iqhtAJ4vQOl3tCDhkB22/HXnnW0pGuk62QQvis9eGvyyP859IN3Bshh8Wt0ZMDS5P0yqlqZMzkKAl1p3f6C5auplFG7v4UZ5nBnvhSTiZogQa5OloMGFI/hrBTYN5m6Vg5iA+udwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dm60EjfI; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3656996b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 05:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333845; x=1757938645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PL2nR7bfZur3p5PgmTDodtSuwkCz6ZzCF3+v9PgYZoM=;
        b=R8xYmFOVLw5w9WdxYnjrpPzjmF/FkH1FrSwfCEOJvByuU5KcQl+UDWHlno3z2voAvV
         j/CtIlEDQwbMrC8TCKhjHVyL+9caa9OOChabPxx/sQO2hAApHgcwl0B6yRpll8dAIcZ3
         bB9aoSAf29do7DWwizcvtg6L9IISruqOgh9abdPmUs/WZCleKst1I2eDv5CniSluQp97
         5TRpvbuSI6PRxDpPEMU6eWMzA+6qlwqmIRDOoKbW83DocESYUoyL7ZWW/CUqP8Bx8cid
         g3PPApCedlng/E3XqjZgzhVIqPRTX8LLLJvdvj1EDPxqLQQvS3uxMhUMnAkbUW0x89qX
         FfHA==
X-Forwarded-Encrypted: i=1; AJvYcCVuKWa3qojUvf+j1AVWEEMzPqeoN6Bl/zOphgE7UjcgQWaUs1UF6qZpjNTjXOQl9wFF4SDjgVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJTdXOo/VOxnBbOTwj6UtgWD3MV3iAjjWnEYkx3jazCMTMUDX
	R1GvCtOMKIHfOsbGQUFHW9YFFcGmNQxCF50h4TPTBP4eHH3QwqYCxoz5bVSKDIDuftUnFcqPloM
	Sa2eQV9Trc/l/SsApOfEaIpEbz4MLfni3xsxQ1vd6mJfzjsu1JaLGGL0hV0kUzD7lUEQqkBsn3r
	LghBag0rTB08b44Q6eB9qpBQ6h1Ol1EtkqTtpm2fEih80EuDTBACdvlbfDgPRH2ZM4WiQIohPFc
	+rD1L5/LH9EazZvSA==
X-Gm-Gg: ASbGncsb/U86S8ZnINSkqmufoJiDQXD+yxapBhge56lmzV1bD4Qk6ntqseDlIJ7X2Nl
	+7/pZ9oWU+8I4sQA1ZvM+spQ9fYCHgRC3Tne70sCVVi4E8VX4kABljY4cKWhyZOrMvytnQxshf/
	HJqUzfVz3nvNlUq978pJEG+9qyxDHNSJoqi9MdcoQOAC3TaaHo3eTi2psfjHAjzxigMjPw3Z58Q
	TgEwWVOPp1l9nUFNhLetaK7HifQMN9PibDG+/fY00UBJv006mQxmZBVYA4leYhRKrSDFmge1jxm
	lAMuXd4A89kQ0isyFKr6pPOPwl5W4AnYm8btxbSoN7F5ASpxqHm561Qwjj9p9GzgiRO1mFcnOZA
	CRtIfe3hiYWI5TF0EiKCcdln62FmGEBrZrKuyYCFlgS7gBDAye5ZS06o1n3OHbfpz8zkYNH4t+i
	4O0aQUgw==
X-Google-Smtp-Source: AGHT+IH0A4aKn/nftre5rZ5qCclMqZHvka5xrQVGplrcmwdHUsILBzzWxUjkC8YwaNla68JddYVyRhyHxnLM
X-Received: by 2002:a17:903:b50:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-25175b96b2dmr91775365ad.53.1757333844679;
        Mon, 08 Sep 2025 05:17:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-24e8a6479aesm8593675ad.68.2025.09.08.05.17.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:17:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329e1e3b25bso4003454a91.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757333843; x=1757938643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PL2nR7bfZur3p5PgmTDodtSuwkCz6ZzCF3+v9PgYZoM=;
        b=dm60EjfIw9FSXczONpp3zkfKwHRHgNuKi0ZwQ/Wkrnm5SJ4jCzuNnaaGDEptC3SYr0
         5Fk5PCjIeXDdAbewVqOQFJ/Pehden45fKX2Iy3wlLnSpaGtQzTNbrthdoB5tjqr9M9/A
         IEHq3WLMypUmii8Mq0Br7MjWq1du0j2DqQAeY=
X-Forwarded-Encrypted: i=1; AJvYcCWPGd63gCfl5eakLhx7kD2fhTmkL9JrOhp76qp9D5EOwqItYR9BHMzvJnFdLpcoh3376ETYho4=@vger.kernel.org
X-Received: by 2002:a17:90b:1b4d:b0:32b:7d03:96c5 with SMTP id 98e67ed59e1d1-32d43f81ae9mr8476194a91.28.1757333842801;
        Mon, 08 Sep 2025 05:17:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1b4d:b0:32b:7d03:96c5 with SMTP id
 98e67ed59e1d1-32d43f81ae9mr8476158a91.28.1757333842351; Mon, 08 Sep 2025
 05:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com> <20250905151858.222c6b67@kernel.org>
In-Reply-To: <20250905151858.222c6b67@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Mon, 8 Sep 2025 17:47:08 +0530
X-Gm-Features: AS18NWATU-a7xZ8xVAQOehTQWzW1sYTcw1MC4SfZLpTzsWrYwPQoIX_cL5YfnpU
Message-ID: <CANXQDtb35RR8nK8Kij18zPvUCOF_p5r_7Wg=pfhWj6SPe7FkqA@mail.gmail.com>
Subject: Re: [v6, net-next 00/10] Add more functionality to BNGE
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007ac925063e492b5c"

--0000000000007ac925063e492b5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 3:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  5 Sep 2025 22:46:42 +0000 Bhargava Marreddy wrote:
> > Date: Fri,  5 Sep 2025 22:46:42 +0000
>
> Please fix the time(zone) on your system. I already asked you once.
Apologies for overlooking your earlier note=E2=80=94timezone is fixed local=
ly,
and future patches will have correct timestamps.

--0000000000007ac925063e492b5c
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
XzCCBWIwggRKoAMCAQICDH/Bh55Nn6Pe2/qMjjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4MzdaFw0yNTA5MTAwODE4MzdaMIGf
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xITAfBgNVBAMTGEJoYXJnYXZhIENoZW5uYSBNYXJyZWRkeTEt
MCsGCSqGSIb3DQEJARYeYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEApKt+sLxPSTFE+ruMyTpA8tU2ux9z4w711yS/nB4tbYArbQNC
KF9dH3b5h4X3Q6Fq9BLFbCWH7pJ/tEiQ7W19TQkQxiJbj1gdIzalTi4YFPMdTzD6/BaU8IELCGCs
Gjv4zuV2kN5uGAZ/K+WtRFRipB33fat/f0FWZ/FhdjAgTCTBrJ4nt7ENYOjNOZN4fjh78vjZqsul
Q+65ExyCjaRwqzdvCy5NQIZ78a6tvGl2Oj1lK7931edumLgCU6qbvk2FfhcD6tRp0xNL2jwL6Yn1
i2qNOdId5F0Uw9myUIwlW7Zg22U2c0Ce3GZggAfhiUwLYFfT2HXj+2kqrhLjK1T8qQIDAQABo4IB
3zCCAdswDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDApBgNVHREEIjAggR5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0O
BBYEFFh9UQJiPboINUMOwOo9HGoA4rwXMA0GCSqGSIb3DQEBCwUAA4IBAQCx4SG9qg18y5lkgQ4d
aBLzpJdJ9WDhmZ44XpTLWPl1MfjO1slu0OOnDU5YVCMikelOWoIm8CK4bkTJtEj/byNXz/X4yJ0p
Gc6hcQ+sxONsIIJxJiNHbpbUaA/cnobVUgEfxvz1tIDMKsHYia+tKFdJ63yd9IXdtBwark1k/D+L
+dDHf0sRsASxceuhNMc+BAs4rNgE6dqAhyNJnd0jL7m0SiCjJsHYElWwYrVH73TUAWgxOFw9ow68
wsf9W+/wSEvI3N6OBMoRcIL34Z0xhrMZDHNOkYxArYhN5BraAmSU/obLBAbwbfEsOtHgFQpTtcHo
C+fgh5U7No8Z3dJYOsl0MYICYDCCAlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIg
Q0EgMjAyMAIMf8GHnk2fo97b+oyOMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA4
3Osq3LMdIIequDEPlV/mOnISZQQkE/aTtXbe12klFjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA5MDgxMjE3MjNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA/rmqCEbidBlMztS76/CE47f8PAzTgzdb24x/t
d1oabaiTatk46AtRRYfqgT+t0bxt67RMXuqOE3aglgbxUNxrRp9TSU3cLTfuPxFl/EPy24kfDEHk
vUlKyl4DyAN0CCAhfMXGSZSqeuoK3xlhfRKYtJO8pm2MXGpEerMGig1P02VjDQMVEB57pF5q5wPd
SbmS9QeOdIxpGR0EHIEyzFDS50CDOFlO3eVSj0jAvbnodPzZgylN4yFgMNTcbcOIIbCMeD2IeSdS
/MG7ZrN3SE83v7APnT0IQ6rmN0fVVKW0OeIIsuXl7r4XNbuRS+H51oT977nBERjJz52bgnev+N+8
--0000000000007ac925063e492b5c--

