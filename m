Return-Path: <netdev+bounces-269415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMlCmvhu2lXpQIAu9opvQ
	(envelope-from <netdev+bounces-269415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:43:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032B2CA800
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9CE31F207B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15589375F8A;
	Thu, 19 Mar 2026 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AWC42hD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C6221FC6
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920148; cv=pass; b=G2HTpAtUVtquTMyQlktwhv/bGKoGezkgzfknmASj5YfgfBnvAdd5ADaJe9+8M2q0UO4lZlTjbhfDcMCTOCzoKykuEEXIkcCJGVzGVgYGeZg7xY7VXz45FJX+l9QEcsbEGsETPABE4WDxaOmboA1BmEJGszhLoHyltYznlyHnvYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920148; c=relaxed/simple;
	bh=f7YiXk97hr5/dRBF7x0pf+mmo61Jh5komm9DceP7+RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3i5c70I4QKtddXiTIZghhsDJ2Fd0spUE73CiLe5HwUuAJcxLkiC5ODir/8qUfq9TcJ5IvQz1oX8GNH1vXhZZRBSY2th93i8Gsbqg7V+RNaMRkj/HN1l7fsIYM1SSpdNTTo9MJPPs4JPuc9r0E0+aFfkzyKbfnoXqkZ1VXEHV1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AWC42hD6; arc=pass smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-829b2019b39so533845b3a.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773920145; x=1774524945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUJRN+dL9LZGzn080oMpnN1dMwawJvVI2mEcsbu+/Ks=;
        b=gtDNxOhCbW840wUEqWhdkh4oTZPGaNqk3ZDgPaMbyz6UhoJBEyIZwLpLqp0YaB557v
         40lo9WVm5A+A4rh6kJ1HVXmzJWwl8ooMmvUIW7+f9/rpHqvjQCgRqKzCq1RAY50rVG5S
         Jjluc3zLGB9OrO5ZQ2JxMoT26+ySAjmDRT9IxB8v6FW1ceNIEhFER/Cm43A3sCIo9M3l
         7/mYA7EkxJLC1pVAQDaS0WURtcZa9koW0bhs39tnqcbMot9Qq1sP9L5weqo+KVS4dAFH
         X8khZOUjs2m7YMTlB3Q6yhyd8vfBja+YOnA9ICXV/0Hyt58Z8iV8Dz7wY4QhlbiJI11L
         +HdA==
X-Gm-Message-State: AOJu0YwZLaaJBb7LUz27M2BYRiyfJ1xxYaiH6aZpwgHlYiQpvDeQD6j/
	P1I5P/v+XkLqmVVfSHxCP4aIE/BUNs3G6wUsEwwLleoCPzfbKpbNbLfhohVOWtdynyq/MBt1twD
	lv6vrZ7q4ADow8PhGJSDdjb2WBQK5Cq09JuHOSdp4y4qIV1vejneZkRfBiPfQ2+0qld/4IQhxoF
	V8YLHcc8MjNtWGXk4xcDOY0seoFaii/u9Rnbw7jQ73/3LBbEyUVKGXVWRbUNmlQsrABuMJo8pR4
	10ozWj9FYQ=
X-Gm-Gg: ATEYQzy3/d2j7slK704SdRGoppMb/nwlFlsi9shl34CqgzFGeZdbX5gCnexAQVhoRdL
	oahk6qSZ5IFW3PDEiHQ2jKvLIpBb+5KBD6hTndJlFGR3F2fXcSG0BAlceXfWYCOoC+2PqJkk6n7
	0Ek/76+ROXQdfr3RnZymEJHozw4R9QiWVldDmb/uNhgEzdqofgA0Ug+txuDV6KnNLWopACjllTj
	zMc0P7l/LpU4KU6d1fAJcw+AVxNcqzPpo6TvNV73DM0SxO/7BkcEJB4OFAeOG5DN+3oF/fIxZSH
	BINxkUS4Bx0FWZ/76H5rowPmHYaZzfEPUFH7unuDvhLeaKCMKW5LCQKI1JzI4Tru+Jj2bh1Fp16
	u8X82j0uoP35B2+Fq28tMBzSNakN+jDcByd90+0L2QyTAXQ8Rc8KKG0o37FKbut2zG904xj8E3K
	a7yvOVnkMKs45bN8zPdThDtxha5pFVtmPy+BVBYASKfJe3W7ediqIkdasunjo=
X-Received: by 2002:a05:6a00:1942:b0:82a:12e9:c75 with SMTP id d2e1a72fcca58-82a6ae70563mr5907204b3a.30.1773920144621;
        Thu, 19 Mar 2026 04:35:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82a6c29587esm753987b3a.6.2026.03.19.04.35.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:35:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c741b950511so605989a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773920142; cv=none;
        d=google.com; s=arc-20240605;
        b=ay5mZ6ehB8wrZ7zYv2aM6deTcLwTQiNVpaBXH/EDO/Xe5IPubqrmUSzoU7CS/8a3C/
         iDyCBe5dP5/clNV4TWgj24EjUo56Md5MHyBrQLBR1E5Eh/D7b3WMAVoWtATXEIvvs9bc
         BnhXhyE4FTs6fowrcaCsNwvZrDY6dhJQ8jI8sW5i2fLafwXvbXyIJTKJCEFM0G2ATGfK
         6aor1qK/Xsby3UK7+7ARit4WlJ5I9vGVHrUVm5RFoKzPB0v03P2ehOlOz+MXKDpavMjX
         Pi0hN4y1Ebj0+EFAL3RH32HY0ZzSt0HT9q8l2iywt+Ob/GekMsIdfE7NZerk9kUOa4rG
         RgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YUJRN+dL9LZGzn080oMpnN1dMwawJvVI2mEcsbu+/Ks=;
        fh=mnz4pLJSGwwvZLl2lzZTPj3f6vRMBdNyavizvnGoydU=;
        b=fcnZorqQd0srA8a954J6oF999FustYxS2LmfbYwUqRVivbhoaQWA2WaZ58aSQ6T+04
         EKqmtJvEYUtCOPGcQEYJ/kHCVePZS2lxm0ioaGJLFxnUcQR1Fj5+x+qY35RDV76+l4zz
         m7dcmj0jWpUYe+03eQhePnWtYxBT654FedACkqHVZa3gri1Ldp88uXIAlvDmm8SJEFDQ
         wsoS0sio1aN8oJCA0EmazCtTZzjT6NxgSunH+ba8CoJNn5WhFghBF22Bzmj9+HM2UbOM
         vBNEkTF/VjLZ+c3MdVlt3XObpp6XZLdSN5riedxtrUCnlNugM5VofUsCXUgAiHU0Bfyd
         fNrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773920142; x=1774524942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YUJRN+dL9LZGzn080oMpnN1dMwawJvVI2mEcsbu+/Ks=;
        b=AWC42hD6akzMf5aoUiiMEgJBQmkWiHgNZ6/8i59t6lhwZ15K7ONH2NqUvu/QIOP7gj
         zMbKj+rmWQ/LFUFIhC786PVLd+M52jGPFdAtqDCNM2lNAFNui7Ax00IXDnUPHvLEmrOj
         RXq8jam7g7cQC98mdx33CQNMrf965o9BcTpeY=
X-Received: by 2002:a05:6a00:98a:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-82a6aee8af9mr6615456b3a.56.1773920142700;
        Thu, 19 Mar 2026 04:35:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:98a:b0:827:2dea:8840 with SMTP id
 d2e1a72fcca58-82a6aee8af9mr6615445b3a.56.1773920142276; Thu, 19 Mar 2026
 04:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318191325.1819881-1-joe@dama.to> <20260318191325.1819881-6-joe@dama.to>
In-Reply-To: <20260318191325.1819881-6-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 19 Mar 2026 17:05:30 +0530
X-Gm-Features: AaiRm53iigJRyDFkym7pCywO3YmcR99241OrXgL2PA4hxx8Z34DXtHzGA4xwOig
Message-ID: <CALs4sv2O3Y1gVdF0vHNJO87qfDJxqPPR_UAKHc9dKpppxD-vZQ@mail.gmail.com>
Subject: Re: [net-next v3 05/12] net: bnxt: Use dma_unmap_len for TX
 completion unmapping
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fb468e064d5ef719"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269415-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 4032B2CA800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000fb468e064d5ef719
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:43=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> Store the DMA mapping length in each TX buffer descriptor via
> dma_unmap_len_set at submit time, and use dma_unmap_len at completion
> time.
>
> This is a no-op for normal packets but prepares for software USO,
> where header BDs set dma_unmap_len to 0 because the header buffer
> is unmapped collectively rather than per-segment.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
> rfcv2:
>   - Use some local variables to shortern long lines. No functional change=
 from
>     rfcv1.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 ++++++++++++++---------
>  1 file changed, 40 insertions(+), 23 deletions(-)
>

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Thanks.

--000000000000fb468e064d5ef719
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBnrXF9
c5hkvxROA4y1qNu1RPPjQvC6jHpQmsojXagvZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTkxMTM1NDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQACfF+dI6K64zeYgaYZ1WZe+9+jRG0NVWR/13WAxm5t
E3XfSE52C4FI18BpvwWs9ET+oTp6j0d+QD54MTh6d4OjA4jW1Lk/IvJ3PfgK/CbjkI7Z/CwmaO78
Nd8mtN4GcVEbYZibnkzCpX/8/lTdQiKXz1WfWeLKpBCg4YwE1VFoPTh62L5pxaZhSbzvPEbBMVmX
AT7xSzvmuvIAl/HD/JNz6x7EwlfNtdWdu+7ji/hLBPCQ4m7oxXtdVoDbyN9Nfxf80dY3UoX2arIi
yLCKboC2hIadiY3bkwuBmdVseB/JeX6V2MtkSX2Yx4oEILOPcwIBR+J9rewxzVVSDRUVk1Ig
--000000000000fb468e064d5ef719--

