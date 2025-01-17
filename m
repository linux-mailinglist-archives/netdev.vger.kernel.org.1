Return-Path: <netdev+bounces-159386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEDDA155E9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09483188B6D2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E819F461;
	Fri, 17 Jan 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iSOS6Qsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED081192D84
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135867; cv=none; b=aHAU4DaRAkTMHeGwGHd9BflRD/ap6npsOgJOcvSbk83eJ6/YFaqFWmgjt+/AVNvKIsKaLOwFH7S+4FfRLMssGvF8N5COXesE3NUMm8pA6DZVyOun5x/bw68Wvg9yYr4WDyV145io7Pxp/k3qpJNXaX5ivPNvfh5TvQcNaw2Ma1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135867; c=relaxed/simple;
	bh=1IuL/qqZXB/pfu99mOQufObNv4sVYnrlfZSwsjw+H7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kycdwWFTpLhxeHWPsvD4Ny1+Hp0hO/xdFuVoBKN9IYvygn2XUjXSTTRs7OzRV+WG/8NL9Ke/q/G409KflT9QLl+Nc1CgnS+7Jc9+CHd0W2SgLRDoDFnvyj8cmV5FUYdRxTh0HrLIiPuuc+d6IW4z61Rwq3qa+1F943H22fCyV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iSOS6Qsd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so3919267a12.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737135864; x=1737740664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hy53ahmlf+cPx+01a4uqCOHyr7EE87P4PFBhUsoN6vU=;
        b=iSOS6Qsdv2obgRmyG1/Ax+Zl6k5Y1DCVy3ZitfWKH9s1OfFOLsp4cBQOH6eCMriI3w
         ypoXaUbLVQ66OphQO7/VuT1YtKUAB4tVtCjHy31aRzj7KuydV09iblCMMe0+sPUc15IH
         WfmWsxGZmESmRY2nuydn+QQCoEpyZuQrN772g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737135864; x=1737740664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hy53ahmlf+cPx+01a4uqCOHyr7EE87P4PFBhUsoN6vU=;
        b=f2peetOarqalDszoyBi8AN3C7dPGy0rWbZHYx16jClTlA1/sSKQLhcjww4XAoKJBuC
         tiAh5uU0gARBmyrlzTIO03azTKXT9G/Dzn2eCM1QMfe1S7R/i2B6WiyeYw46XNYTKPL2
         borkz5njydDVxKLKiEG2FFrL7oLwHfRCXwDsfZNjK3PGXGLeCOkuJLQ+77qkm9kUDkrQ
         25AvC/TV957oaTh5bOb93y3zp2JwUpZpiXbvX5rkVON/hQXORr+3ACx+lLU9IrCz9tnR
         VWyCwT8CqJZZPCJZBUjxB8NSu/dGu6ZACsUp7EcOzM06Xvt0FLroSDCTAO/yPNxF0Q2Y
         MgWg==
X-Forwarded-Encrypted: i=1; AJvYcCVEaW0j8Qr7BzzuwIZG33Hirysy2c0aLtZWh511iePSnMgh6ZVu7SGCFVpjOdY0LQiH6n8L4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7wInM1QpTHoTIOM2uYzgHREW226FKfjAawLe4HY39x8zk/8n
	E5gDBABtuUb6Rb17UnbN4P/WbMHUN/IvUefboP6WQdg875MMwJSJoMzHYTnlIbNHJAG2BbNU2b9
	hpSsYVTZmYBYqqRsO1cd9B9Kkrt4XXZaAl76KoMRdJQun2Gs=
X-Gm-Gg: ASbGnctM4FrQkbnoyvx7afFLwWfhiDVKTrEaij7Wxu8y7j846xV2XUCaXnah+B6Rdsv
	LhLnA4GMU0qL39MEP2+CHxyL2KwUVQNkXIKP3m4g=
X-Google-Smtp-Source: AGHT+IGBPgP/xmRLeJsv8VHwlcWXrRyYzo96aCF59zs5xJVrSNrlcAkWtFtmkIAAXvFnoSKrHZvK8cj9sq/Ql4KwaBw=
X-Received: by 2002:a05:6402:27cc:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5db7d3005b5mr3722843a12.18.1737135864282; Fri, 17 Jan 2025
 09:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117-frisky-macho-bustard-e92632@leitao>
In-Reply-To: <20250117-frisky-macho-bustard-e92632@leitao>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 17 Jan 2025 09:44:12 -0800
X-Gm-Features: AbW1kvaQN0nFOhJev7LK5E9pFFghRLLGVCygRQWTihGq_pbr48TrY6W3X5uNpb4
Message-ID: <CACKFLik4bdefMtUe_CjKcQuekadPj+kqExUnNrim2qiyyhG-QQ@mail.gmail.com>
Subject: Re: bnxt_en: NETDEV WATCHDOG in 6.13-rc7
To: Breno Leitao <leitao@debian.org>
Cc: pavan.chebbi@broadcom.com, netdev@vger.kernel.org, kuba@kernel.org, 
	kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002309f7062bea76d1"

--0000000000002309f7062bea76d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 4:08=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:

>          Showing all locks held in the system:

>          7 locks held by kworker/u144:3/208:
>          4 locks held by kworker/u144:4/290:
>           #0: ffff88811db39948 ((wq_completion)bnxt_pf_wq){+.+.}-{0:0}, a=
t: process_one_work+0x1090/0x1950
>           #1: ffffc9000303fda0 ((work_completion)(&bp->sp_task)){+.+.}-{0=
:0}, at: process_one_work+0x7eb/0x1950
>           #2: ffffffff86f71208 (rtnl_mutex){+.+.}-{4:4}, at: bnxt_reset+0=
x30/0xa0
>           #3: ffff88811e41d160 (&bp->hwrm_cmd_lock){+.+.}-{4:4}, at: __hw=
rm_send+0x2f6/0x28d0

Since there is TX timeout, we will call bnxt_reset() from
bnxt_sp_task() workqueue.  rtnl_lock will be held and we will hold the
hwrm_cmd_lock mutex for every command we send to the firmware.
Perhaps there is a problem communicating with the firmware.  This will
cause the firmware command to timeout in about a second with these
locks held.  We send many commands to the firmware and this can take a
while if firmware is not responding.

>          3 locks held by kworker/u144:6/322:
>           #0: ffff88810812a948 ((wq_completion)events_unbound){+.+.}-{0:0=
}, at: process_one_work+0x1090/0x1950
>           #1: ffffc90003a4fda0 ((linkwatch_work).work){+.+.}-{0:0}, at: p=
rocess_one_work+0x7eb/0x1950
>           #2: ffffffff86f71208 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_ev=
ent+0xe/0x60

Meanwhile linkwatch is trying to get the rtnl_lock.

>
>
> Full log at https://pastebin.com/4pWmaayt
>

I will take a closer look at the full log today.  Thanks.

--0000000000002309f7062bea76d1
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHQhFEjYrwo7/kx3gB3U6LV1naRlUBZe
LkczIwpJmRi8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEx
NzE3NDQyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAA+mIqOyh7P7v64ZEw5jJo7t0WVnXVPCi9bOL4xB56gFrzNdZ2
Xk4YxKGDHArJHtzfuQ0m9BPjcFwV7Ih4KEnV78opMEROeA0F7123KnpHu0U+E7UBIl+cXK1cT4Q9
NKJmwfgZTleLkZ7ixOIhDK+o0mvb5YNaiQf+/eKq98QrMbqaScEqu8zpS4nstN3/Z7sYqT/XZwU4
+2jvCtkcgQOyx6q/LHywYPTnKzmhdANNCXCOogkY90AZrlL2fqjgxGDJFnA6E/C5qqsIk2jk4de3
AdjtQ3BupjqZAi7Xl2gk8CgZOVvfD39lBnuVvlYwxg0qJnr8/gYwNYikh9V31m5e
--0000000000002309f7062bea76d1--

