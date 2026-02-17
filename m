Return-Path: <netdev+bounces-259114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFJXK/WolGlSGQIAu9opvQ
	(envelope-from <netdev+bounces-259114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:44:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A914EB6A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35CFD301D6A9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938C37107A;
	Tue, 17 Feb 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SHep8Idh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11637105D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350243; cv=pass; b=DSDQmbuUfD4odEpBkORePbQaP/KJcl7Z1pNpjGFwukab8TzOeyZx8Tl/+Zp4uG1eOkfq7tXTHgwZsNmO+obYfx08/sxfutBUmvVODGftfqhBDHar8OhV9SCDvsr8wsRtK+UDbhgHQgOF7IWBXd7XIF/9+HNWR0wFo9eU9inA25k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350243; c=relaxed/simple;
	bh=IZHXOvyJk2e9x6ZABRwiCVKHGC+ZtgPcVOxezbz566c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4qxWixfH0hoE5h2Gm8m2sUN/E5/iz79ThLYIlqww9ljwVaiypxA2aIN8oZTuWtDjDyA3hiZK6qDm3DyZctLuitWgu1J71CAK/UNXPyyhn3I9/PMCYVmr6qDfJc5erwW34+YdO/8dFAGkT0moLHES9kialOVmpj1A0dR2KXNwSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SHep8Idh; arc=pass smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2157941fac.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771350241; x=1771955041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZHXOvyJk2e9x6ZABRwiCVKHGC+ZtgPcVOxezbz566c=;
        b=cSrKOJ6hmJ90r2Df9xVHG70FGnRotGu5qXzYFcEce8u/XnKBn1Dg0Usuh9cwJHBtp/
         ziRXjccO/grLoQwA9ul88EHN7nA5m68y/yI0Mb/ZzlGKTWbk5NLmKNNzNkvRddA0MVXJ
         6QiweKXXnNDxlsXbDz3LPUJR+G/zS4SLTnYU9c+JWgCzGzQ1lyPPDz9q9KOUeRIrdRgM
         p59FW9zw5j2DCpjXZ5EVe6eizDm9c/Z1lLydtZIQh4VqHA1d6o8dOxPzg5cj8grIMUMw
         S64K+8EhJV2LcKT6gqqWFPkriM2gu6lzm+FrRbwJ5JjPi2mum5wqOMLV7GDFVHV9xMtz
         niQw==
X-Forwarded-Encrypted: i=2; AJvYcCXyE46Atjhbswj4Xcf0kSpIlCWzJrPP3MWJNcV6g6e1D1Y9YFiMOkkjtJidjp+t62BQH0CEeak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcGV+idHt8T2IAKj8I7h0nqJiCZRzyuwdg/4MAjVRz/IQNHuk
	2SUtK2oFDFGEVGIVZYa7BfQ5Gl81lvIQ040ELEMnpc+FJHIXca1DrKrRA6xOqLDnz3kGviUQ4ax
	XKaUm7HH2iDcSL/TQTHX+1xTEsTx3J4SlFSVHm0PW20rWpyvV7IwMYme3seuY1fL326/Hi/ipDu
	GQ9VKpDNAB8j/LVJUXsG2vNttrCTIKPxBGwDVKr6Syl7dv3GzXyiohbUGxFBzi8mIeJUbeDbwTS
	88yXBr/mQ==
X-Gm-Gg: AZuq6aJFHkbt753fla0Kfyxj3jbewpjO4jPyN0lorWumPLfu2IZ610B0R3xHQ/6CqK5
	ER2xm1yWD1XuazWz1+xKYk847TcCrn7Iv0zJQ9TzovQy/1fN4BiOcTc56dKyNrkZHL9nCghG8Y/
	pAex7835J0yh6CC4qAQpSRBNomHwvaFAZTmxtAEaYLHC9+BX2HcEMVqwMks7dccPJkUcGUqR269
	Pd5y58qqP3PyZhI4RG7WJeYV5cXMR2IrUd5MifJC+cqU59DLsJ9GGjvfSkKsQz7bEAPHWyElPpi
	gz6E3KVgcwOa0GyDIGowpt8/h1rACPRnxHA/a42aDLZLB/Q7Rf3Ftu8QldLIqV4z6lDEFdXC+yi
	HcQSgNpCUVmkB2A4uKX7UN+OlANDjz11K/djCRXSH5kur02IEFyHebkpxcZX78QyzlZpMwx2V8f
	5atY/Aj8ppMG9+g5gt3zphWtrynlgqcKAnWGYA0XDGVSnDjcyJXa4dstgfNg==
X-Received: by 2002:a05:6871:4308:b0:3fa:eb8:4c92 with SMTP id 586e51a60fabf-40ef3ff8538mr8798944fac.50.1771350240575;
        Tue, 17 Feb 2026 09:44:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40eaf163459sm3492951fac.17.2026.02.17.09.44.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2026 09:44:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5676609ff65so51306763e0c.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771350240; cv=none;
        d=google.com; s=arc-20240605;
        b=bHX8AMCTJ4TaGliPemnWhyt8pB2dTT75yl8ensM2qicdAGOEOdaHqH2XuJWdzTWdrm
         B/UzNI7ybhMYoHCx38vTnmxiolKmctrLpfMLKWofMBQnwMEZK3lEf3k3RhefTXP8CKom
         ZB0+B4nOu2qtrt9btP7QPf+5Cd1tKUKT41lACDK0boWYqvuDtUTDiVuBCs5fHq+96yAR
         eAvbfeK3GT49bVtB5olQErO9/cy3SvyaoRl3IufL997XP3tTDHZ/9SbPxnjAHk5Wzva3
         9TBdD/9G1+YbCdYaKEACKIkK2aFI/rarWcHI4UMWwMgB8YelXUQN2a8wsWsrXGcxgUDu
         WqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IZHXOvyJk2e9x6ZABRwiCVKHGC+ZtgPcVOxezbz566c=;
        fh=rFIMoAy/MdF5j1ybzR9Kk0/dMAHQnWor9tzUgtPNkVE=;
        b=JmlsApJCALepcXn5cQi1OjMUVvgsomIqSLsTHc1vmos0qr4RWCgonS4BfAlVJY0V29
         fR7kXtG9HioO3EDAPV4GUzvdvslcm025VGZCDWCAYaBLqS5sbDqcreAblXnJakzqsSl7
         PXVSVUBk5T0zer/yf5gyEDmQFEHwMNK9ZqjK3cIEwkxlclmTwUPRJtsZPJ8wseam0Jc/
         g4SLjvs7xkZi2ZeUPRyUVQglG592h9TOlytJ26LH//dDvVJUZNi3xy4bgqXXlTNtP2ee
         Dx79TJWuL/GFZYnvOr1/YNojJQfr6xKR+pm9YPmhIW1Xvq9tgOwS+qnNGbHfUTKvdg4w
         6jDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771350240; x=1771955040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZHXOvyJk2e9x6ZABRwiCVKHGC+ZtgPcVOxezbz566c=;
        b=SHep8IdhA9GoMG3PTOVCGynoHWmjSwjWKIVbuZ4HesUhp0fVX3hrQhtI0CAx9nIZSz
         AXSbqLcjSjx8EVdFsT6DDE55NpK9TpdSH0TLJ/b7Gh5/j7+/v8naO3RhT5jkZtMXsJDT
         Yfj+d8bgd84ZjV2V5Kk8H774mX3EE7xkGT68w=
X-Forwarded-Encrypted: i=1; AJvYcCVw17OnrN/Nu0ddw+LakkTrJP+tS86lvOMPTLtX6ALumYJGdNcENWmaiIvAPeHJowCSII1qzlU=@vger.kernel.org
X-Received: by 2002:a05:6122:65aa:b0:567:4260:5244 with SMTP id 71dfb90a1353d-5676aac6032mr5382165e0c.21.1771350239883;
        Tue, 17 Feb 2026 09:43:59 -0800 (PST)
X-Received: by 2002:a05:6122:65aa:b0:567:4260:5244 with SMTP id
 71dfb90a1353d-5676aac6032mr5382153e0c.21.1771350239443; Tue, 17 Feb 2026
 09:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216140235.3764145-1-vikas.gupta@broadcom.com> <aZSPxEDPhyEVzAr_@horms.kernel.org>
In-Reply-To: <aZSPxEDPhyEVzAr_@horms.kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 17 Feb 2026 23:13:47 +0530
X-Gm-Features: AaiRm52STLb8qjC0063uywZ_a18pRh1eR9f_7Eiq0JgY0JmvitlJFPAbC6QC3zk
Message-ID: <CAHLZf_v1R_9egWmHtkq2QttLYrG8FG=-whEQBw8vBLjmhq=RuA@mail.gmail.com>
Subject: Re: [PATCH net] bnge: Fix typo
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d7421a064b089dc7"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 150A914EB6A
X-Rspamd-Action: no action

--000000000000d7421a064b089dc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Feb 17, 2026 at 9:26=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Feb 16, 2026 at 07:32:35PM +0530, Vikas Gupta wrote:
> > Fix the HWRM command type and use the appropriate command to reserve
> > the resources.
> >
> > Fixes: 627c67f038d2 ("bng_en: Add resource management support")
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
>
> Hi,
>
> I think this patch could do with a little more explanation.
> It's not clear to me, at least: what the difference is between
> HWRM_FUNC_QCFG and HWRM_FUNC_CFG; and why only one of
> the instances added by the cited patch needs updating.

HWRM_FUNC_CFG is used to reserve resources, whereas HWRM_FUNC_QCFG is inten=
ded
for querying resource information from the firmware.
Since __bnge_hwrm_reserve_pf_rings() reserves resources for a specific
PF, the command type
should be HWRM_FUNC_CFG.
However, HWRM_FUNC_QCFG was mistakenly used instead.
Does it clarify?

Thanks,
Vikas

>
> ...

--000000000000d7421a064b089dc7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIH1CDe1x7Bs+
zc7HKI5vr2UiCsyc0tVt2qMv5u3lL2cSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDIxNzE3NDQwMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBALm9cswHKakuyuzJnaCwMTkQtZWSVMyFvw8+h7SLDg8EFDqE
yCRBrxpCwJATKuif4A4HLSLGoTjI7zS5NVvxa8vFpjfUxcWqUPYYrUo3QkodfD21Kt9y4YJ3vs3e
em+PZj7DE+UCHEOZvX7Jvz8AQSYsoLBQDcqPy/5KRkk88ylXGi4LIbPdAbzxQcRZLAkZxujPW6Xq
hIwycEHT+Fp/aKcTms9XkQCi/mm38NXxkn4QLh5jXEqZX5GhrJppPC+HrEDtEN/9MihoWDazECL0
RPltBxM1VTVxW3zBMIrtCosDVoOVC1HrA1E8wng+89nfnp2+NV6bsDnGHxCLhbZngmI=
--000000000000d7421a064b089dc7--

