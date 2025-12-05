Return-Path: <netdev+bounces-243859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C534DCA898B
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23E773029DA5
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A524359716;
	Fri,  5 Dec 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FCfcucjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AC3596E4
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955370; cv=none; b=TPtzzkgtJ9GiKQH7QckpdDcEnPn4b2TjKXYaWVqyd+85agQC40ALA18/M8OtiBOLmD6qQKPILJA5uxgRwUA+2oA4dxDpFtam6pGOVdxeXHUYC3lKjDf7g7nIe2Lbq22AErKBOHPfgJazUs2ggb9cj6lYAVv9lDaeg2sCx5yfgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955370; c=relaxed/simple;
	bh=7MS7bTsr6UD/aSGSYxKc0t2WVdNOzdKw80dldo4OB3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UihheIwMuY1baM+z+z8rqFphSXbOtnFM83XduO9KU2B7SHLYql+EoDiNVFXpiY55DL9xZrK05UvI0kX8xT97zcy+QVSBrv4/CacROKKBBNVjy1YlWyXFkvYzH9ciF67/JTcnHUc26OYUKED3ZP8GZ1hx/H/UISpp7DPchWb2mFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FCfcucjf; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-787e7aa1631so41679147b3.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955368; x=1765560168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MS7bTsr6UD/aSGSYxKc0t2WVdNOzdKw80dldo4OB3s=;
        b=RBTimmnb7K+NU2FPaZxNyc7GG9BdksiK7fEg4IjiW6Ev7YazfNGU6GypTsH7jQ35lt
         zncguQw2fDD5lrECMgognj5bF8KVk/kPPCUm9WiKUsmgDIjijhqswjdk6VxEBfrwymSD
         +B9yu9Q5bT69PEwzi9pfXLNFccKlqIEIf/fdNmt1a5CVeW6TnYpybHlmNAmvlWrnzsvw
         QeOoLrNlDg66eS9UhKMkKP8bmv+WxLfMLuJOwtvPsw27gH4xVsf0rkG6HOsQwECDgjIf
         Y0O4Hzs13FC+7BTW6Sk5EuaObvrsmxHNXl+HtjvbBRDpq1A+gtlPC6tmZ8q4HTPErmxF
         rDgA==
X-Forwarded-Encrypted: i=1; AJvYcCWwsa3W1+0mFs1sedNILat/MhKbmG8iOBq37P5R9iTvdcispwJaxizq5PHYL3RuIuYNt1hu0cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2IqYxhiy9TtuFQN496Qyy12rjbSILK3NNsptWJ8blFMMjeGF
	KU9nSGAVcgSkLGWTQA3h/eAFUF1s7m3NrmdOOBQHTyIcXUwfaVcwg72GmtxaTs1hf3wQqrk4VZV
	FgICWFWR3DQMRW3uaSK559C0K5ZeNs6oOaU+q07/9he4YrvLrqkfn3kvLWYHAD134omyZW+xGzO
	4mqDxzF2Vp9mffqjH2ZhFWICuKp6v4hYjyfLuD6D1gheO3sEE5X5JfByi4uEOFUMYsG50KT4GH3
	JkPQilgoP4=
X-Gm-Gg: ASbGncsMca5UK7E+iW5eTNqsnnR+P8B44ieES7z2wjqfYfnDOSQpQToNvx7WVTFaRMR
	NLeNcJVmBD01mcVK5ecRxxooQlmNvHn4M/LR6ySI3T6AFFCz+FvfjlENL4eLmHLX3d5Ucc7BgLg
	PVF2d4KgFj0GDXp5qFsJMD2RYSQlimDibwbnL02dOT05QX2xmGICxKpTnD5iz6CsS1rB4JuBPPn
	ZwnqoPU3J6RAZY+yZhA7DAHOINysYeidctLwjSKwz9jaQJQ/5Ua27+X291xivHxSUoMJ8lLjS2N
	yvZdNlMG8udZghVkbfNbZnbG+xOyGgd0pcIASmDaE3ZBtkslmsL/9tlVNzL1VFqQEbsKCAN7D8V
	xd1JNNPTD2Fvn89mMtNesgIPudyUAxGU5qK6LiC+VHR+Get+HahAyYG/7a2bppvhQDObAF7g+hY
	0Iqyu7nClMN1PxJwGU6r6C2GKITRn/SWOHJP527iAxqjhdpds=
X-Google-Smtp-Source: AGHT+IHIG9IQEecdOe6ANOTmV2PnVmfBUVhogTJR5NeianUp/fzxxMtJtm4fadrL0lrwwhnnXCtQLGA8vSRA
X-Received: by 2002:a05:690c:660b:b0:788:1258:2042 with SMTP id 00721157ae682-78c172582a3mr65616287b3.26.1764955367537;
        Fri, 05 Dec 2025 09:22:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78c1b7adca5sm4102487b3.29.2025.12.05.09.22.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:22:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72a95dc6d9so335190466b.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764955366; x=1765560166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7MS7bTsr6UD/aSGSYxKc0t2WVdNOzdKw80dldo4OB3s=;
        b=FCfcucjfX0vSIrz6RGURpzn7cllFJmZT7YtLCo0UZiHuLrRvMtGhOwdj0etT3bk7FB
         hga6GHLE3Au+dMKhHrIM23vYdNwxpheY4eS7rmrZyH3+0kFfpXTWOBt7PN+QP/SdGjXa
         3iqfOayHpt7mPdIONUUPFAubgtAas10/j2AtA=
X-Forwarded-Encrypted: i=1; AJvYcCWvPCery0y5vVgezhh83dtL5v3Qde96503tNuX9Reb7BqdbkwQiAdQ3dijMcVziBhrrKsBmEHA=@vger.kernel.org
X-Received: by 2002:a17:907:3c83:b0:b6d:9576:3890 with SMTP id a640c23a62f3a-b79ec6b530dmr777124566b.45.1764955365746;
        Fri, 05 Dec 2025 09:22:45 -0800 (PST)
X-Received: by 2002:a17:907:3c83:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b79ec6b530dmr777121966b.45.1764955365293; Fri, 05 Dec 2025
 09:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205155815.4348-1-bigalex934@gmail.com>
In-Reply-To: <20251205155815.4348-1-bigalex934@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 5 Dec 2025 09:22:33 -0800
X-Gm-Features: AQt7F2rI7ZfYF3TuVk4FZJ0bRmho9k8TIcjme9jI6gqPZ-BAGlvchl3Zn5OUtGs
Message-ID: <CACKFLikjDcp5732_KLwxvU=Hjf9Pbu93FhEkkQTHKH8TEO6waw@mail.gmail.com>
Subject: Re: [PATCH net v3] broadcom: b44: prevent uninitialized value usage
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jonas Gorski <jonas.gorski@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a60bf9064537b1ff"

--000000000000a60bf9064537b1ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:59=E2=80=AFAM Alexey Simakov <bigalex934@gmail.com=
> wrote:
>
> On execution path with raised B44_FLAG_EXTERNAL_PHY, b44_readphy()
> leaves bmcr value uninitialized and it is used later in the code.
>
> Add check of this flag at the beginning of the b44_nway_reset() and
> exit early of the function with restarting autonegotiation if an
> external PHY is used.
>
> Found by Linux Verification Center (linuxtesting.org) with Svace.
>
> Fixes: 753f492093da ("[B44]: port to native ssb support")
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000a60bf9064537b1ff
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD8+yGq
Zw644rcAVmoKN8pcOgXiZuxER8iGo024bdfRvjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEyMDUxNzIyNDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMp9Gm7932u2xOBmLyHDdFU9CCGs5nwA2hQcpYv7i6
7bqVEYRjm+nYe4rixwZBkkEugOlGTG6/QZ8yEUe+9qx1FkOM4HM3h2r+43JaViawc5HS7ERJ827f
wDp/kdZdoqscso5AE/PnImW8iCLy64stobfMRBR5EJG3e37ceWuWzPAZwYSIfWW1FKgpn3BOosmR
z7/QPAuipNie/+U8bSGYG+t3Zeq/6y/kI1coZJw5ZmJF+fO5dKyZeTGyiBej78pt+HLGBgWc8Bj0
201U8h9QWdAfnSjeYabnFnGBMVk+GrQFPwQicFKhm6mwum6OlMOkkyynYbPGo1tlLdi4CqTI
--000000000000a60bf9064537b1ff--

