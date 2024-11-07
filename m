Return-Path: <netdev+bounces-142831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3D9C06FE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD2E1C215B0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C91EF087;
	Thu,  7 Nov 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X+daPMKY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8541DBB37
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985133; cv=none; b=MMTk3DIeyDDcjjDxvrVvYh0lOijdgJ+HJfD+gIyiLat5ddjHJY/1CHKRyk70sHC53vnBGVv6cyVDthialf6h/WMlnNX0bfbC5GTkUrKzvURE46SnWDj0qcyzKnV7BMTsD9UFHfjzOki6wsl2p8uZr0TFCZfDZjzZg7R75TUcMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985133; c=relaxed/simple;
	bh=ZQmdTgr3HyzO+7UQYNDUVZ8VkWoHH2wnlVF3c+l/QUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJG1K9Qs/TfJjSPbOfCFI2GpVpW0/qojbzh6Oa3wZhlFDl7Ds5uWAhmB/x3RjuF/BN0ySsWmxws57aD5IutCz6uc0CNTtLzNlKpsK63OKByKEmckKAU331ElhOrsuLLEUnBosw+SnSaJAbBcvwHjrbp10R2/PnHaQv/Ksn6xvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X+daPMKY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so714465a91.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730985131; x=1731589931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48HrATcv1fiW1LORbSujXAEO/qtFDEUDB4NccLC4qaA=;
        b=X+daPMKYJlamZs2C9/NNXFIEbU4YzAt7hyTm38WYKOhqVWEecOInn0BQa6/orsghP9
         fM07flNh+nlYOb4JbpGEaeDF2+ioyFgVI1mHGKdxOU1NApdhc2TV9FaO2z/sRFxMKnI6
         A6WUVLPFWqDkekBsoWZL2rpPJ55ykjX+g2vhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985131; x=1731589931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48HrATcv1fiW1LORbSujXAEO/qtFDEUDB4NccLC4qaA=;
        b=m9J/kWw6F3Sw/D/cnsRxbtqbfhKG2OHxmDGU+jZa8EU4vr5onm5Fi+CCO8Pcim18C6
         5H46elaVyU1A2GtgrGHfOCB+UQUeID94OxhfrD7mVxLmuih7/jR1egJzkYA5YhQ7HobT
         3H2RsTTSbJzjnXqRZbPPqL+i6Vz0lalLP8yybDL6+uojSK1rfKKgEy8+nNRFzzIKsqbD
         vDvo8z+tOaez/x+YMv1Xz6km/Hl40gUmlFrUmnccOPaKqJ0Lw9v5mH9MxqQZJQHFEFSc
         jTT6E8tVV/kOOJvnBmRYQGVno5qpKgDmBoCmhZYSU6oV3LLV6yjxlSK0ALXKhnBLnyl6
         9YlA==
X-Forwarded-Encrypted: i=1; AJvYcCVbwRjc80h8w0cjdRCGq+vqcE6G6lkwOILHbR8xunOpK8VOVG7l02rzUjwZGbS1YAMNmFoAad4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQn1WuEXWyf9ArzHCEaUmN01191diWqafg7GtPFgk7E/wBrNml
	sES0RuWSlFt/jGqPRP6BPuD5LAvQTAkQfdpsZ6n+DpjzKVzli9Sm3Ad2F9zpL348cbXzigKdAHM
	eoSVzfijhBkMsUIcLoflmMFvav3vh9JIIL1bG
X-Google-Smtp-Source: AGHT+IE4b0OQLcyq2nN8XW+DmDhLIPj5MBFaATFAjvHa6zdKA4R2+6rPV7mt67mk05Ebf5BIc8BcpYV8NTFKM+ibGpE=
X-Received: by 2002:a17:90b:180d:b0:2e2:b204:90c5 with SMTP id
 98e67ed59e1d1-2e8f11dced0mr48754323a91.33.1730985131002; Thu, 07 Nov 2024
 05:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106213203.3997563-1-vadfed@meta.com> <CALs4sv1VTT7L9t+BjuvW8naO7fm5Wq0qKgVkv2DW4nrNe1bucA@mail.gmail.com>
 <90aea4dd-cb37-4dab-99ef-d45915514787@linux.dev>
In-Reply-To: <90aea4dd-cb37-4dab-99ef-d45915514787@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 7 Nov 2024 18:41:57 +0530
Message-ID: <CALs4sv10sWUyRfUDSQsU0N1jevDdenbMejyeKSwOM6uC=uVhYg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: add unlocked version of bnxt_refclk_read
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Michael Chan <michael.chan@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000de8da60626526172"

--000000000000de8da60626526172
Content-Type: text/plain; charset="UTF-8"

> >> -       bnxt_refclk_read(ptp->bp, NULL, &ns);
> >> +       __bnxt_refclk_read(ptp->bp, NULL, &ns);
> >
> > With this change, bnxt_cc_read() is executed without protection during
> > timecounter_init(), right?
> > I think we should hold the ptp_lock inside bnxt_ptp_timecounter_init()
> > just like we do in bnxt_ptp_init_rtc()
>
> Well, yes, that's correct. Technically we have to hold this lock (and I
> will add it in v2), but if think a bit wider, do we expect
> bnxt_fw_reset()/bnxt_force_fw_reset() to be called during device init
> phase? If yes, we have proper time frame between bnxt_ptp_cfg allocation
> in __bnxt_hwrm_ptp_qcfg() (which assigns it to bp->ptp) and spinlock
> initialization in bnxt_ptp_init(), during which spinlock must not be
> accessed. And if we imagine the situation when fw_reset request can be
> initiated during initialization, the next flow can happen:
>
> CPU0:                           CPU1:
> __bnxt_hwrm_ptp_qcfg()
>    ptp_cfg = kzalloc()
>    bp->ptp = ptp_cfg
>                                 bnxt_force_fw_reset()
>                                   if (bp->ptp)
>                                     spin_lock_irqsave(bp->ptp->ptp_lock)
>    bnxt_ptp_init()
>      spinlock_init(ptp_lock)
>
>
> So we either should not have an option of resetting FW during init
> phase (and then there will be no need to use lock), or we have to
> re-think FW reset serialization completley. WDYT?
>
I don't disagree. Since bnxt_ptp_init() is happening at the probe
time, absent async event queue and devlink infra, in my mind we can
safely assume we won't encounter a race with fw_reset.
The holding of lock is more for being theoretically correct, like you
pointed out.

--000000000000de8da60626526172
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAzonuCdvNEIOBS6rWmdlLZ2WL51Azzh
hCTjDp8leUJQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
NzEzMTIxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCnVuMv5P2Pdd2p/osuYvQx/7wdcjnr7iujL+8EEZSENW/ieHEz
IPCaapReKfiUGOk2U3bd77qo1C3T4f3dC0L6YMsQa4pQcccjO5OPvOUkwr8BbM09Kzv6KcWhTkI2
HFhevqDpI1X3qEq0IjjRB/ATOZfD52gKoIxleoGriMoXkob3XEM3PK4jCQwt8uzE9dHS6ykwn7kq
hRkjEKQatuhxA6MWsMgicST1MGMV5O0jKPGO1z9+Q1yHsr2VFU3RHFug/PACO5r2rfUWm70tLOoJ
MA012aAarJD0DozK4klAFrrW4Gju07rjCjJfeyXW74WGvDl3LFhRsU0DRYAwQt01
--000000000000de8da60626526172--

