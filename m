Return-Path: <netdev+bounces-256760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJezASd0g2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:30:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDBDEA40E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A4A303AB42
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518E421EF5;
	Wed,  4 Feb 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XrvvbGCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D92D8773
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221728; cv=pass; b=OeQ+PJygfia9e2vAIKr/C1iwZkVhsvDR+N15TiWWS+lq7wlkhy8Zl9QugTn3C1d3P1u1xrGInft40L977JoZSAM9BUM4/zV6ji1yPGtPQa7ZP4txnxVexjLaY0Vo++0fk3H6KNCbmgKbABIdjLSgZZxmLOFHfeNiE+WtTIhIDxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221728; c=relaxed/simple;
	bh=2Tfjz6dI+3Nvn3L8O/pFWyYFkiJe5GOGmdJ64QXdRNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlUEg1rZE1GH1SL1FhHwOzSwpkiEVAdEc7mQM0Z4ia3Z8ptkl+RJ1wcvBE1HjtiTOFe3r30/rPSKaqA8646AbH2OYvSsdL6GoN8U5+/vm9EK/65R4Zfd16MrA2/pVJ/6wiVLsqAa8rV8ZzRFO1JpgSRXnIArj31xpQ/ceJuCHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XrvvbGCO; arc=pass smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a933b9b591so84175ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 08:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770221728; x=1770826528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2nFbyXeO0U0JskjWaQBQ18ORC/5uXabJZL8Rc1CSwY=;
        b=XaEmT5by5/ZIPGwNNgXybIjv4F+/0ZtuZrdBpYZBXcjROASbzYA81wd2P8bPcuPRac
         +BeIGUpOZCZZ6tL9H9/BDMiojlOO01cVfiDQwGicKdFv/LqJ/VloX8rVwU5pzzeBRpcF
         1a2ebtaaKDgtzn3YEyY6ZgxCQnp83y7RnKr7NJAVWVK+B+GTu+73rG7NfgWpUY7+qrbd
         ZiiR/AzyJiX0DxX0dYAeAmDdFdi7Kmf8UrTE9jniDqKTnTzyJkovWcgkh+vOQL2GqvFg
         9O3ER0ii9zchFF3BR3HRJSPFbWUpne7V9c3g7DfjwTBF8YWiZjCmFxKVCOpYl0jnHpZd
         Qe9A==
X-Forwarded-Encrypted: i=2; AJvYcCVXTtFM7HbXBgHsXZnxxmEV8W4zAt8SF0hBATAG/MCiffmfmtRU/ODhp9caNr+htZht9GA3pMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhFBQp6cSDQAJGrO9iNgI0ABMiSSyOVi4plPENM3FCzEikTTw
	aY7kJFxhMbFTDr0qHdmPskfhXamCQG5KHqwjd9frXPoeNJ99dUtvNR0Z72UATfVtx6G4g/+boOL
	E1SL77bZIvBWFMqdQeSciu9rADwJSdB1BHX0rfPjI0tMzvfNZL9rYzDNh4u3hbDbvYFsDwbRxCN
	xGFYaQjWJqGONZK6+uKVLFNpaxYKDQIyVBEEjSfbOjxwfcYMnmZaZK9fpnxEbHZ+IPN1fwceotC
	Nc5wEojGOFjog==
X-Gm-Gg: AZuq6aJ/Zjuy7fOd9Od+clIsD5a/nQRAIdj1QnmZe3mqbt7cVvEFOIj7hCQCrmW+LrY
	zgeirg4c+dIjJ/gMNkaNfQt9KD4+XECGtvk/tHoErNmUZBo3JQkELORGn5ZrHkglnLKntRO6wAk
	gksQlcNj9ODPg2Sbc7IHWNWKa/JJAvokbzlSmBsOqIDjad7k2em40CT+PIP2mUP5O6h23LAh4MJ
	NEeuJABD+D73oM+ph0NiuNihbRRHBKi5/sQq2Sd1Fc9oUs3auzKqpeLYOOd6kteqiART+ylJ3fY
	M8C69cHje+CQZGNVvG22U/poars/CpvUCtrbln+bOm5j6KIk45iE1bEKBEuPpt7eD4cruNQOiYb
	B75im1Cw7ozQEhCOEX2g4xT2ITS4T6rkZOjTpNoKwsTK5TWlPEyk5ZtBuTrJkiSUywKWMLZv0O3
	houCjwkdL017oHVFd7q9ZUZQ78KrMzLEysBDSXsBb9jg==
X-Received: by 2002:a17:903:3c65:b0:2a3:e7fe:646e with SMTP id d9443c01a7336-2a933bca789mr41630005ad.5.1770221727375;
        Wed, 04 Feb 2026 08:15:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a933814e0esm3976835ad.15.2026.02.04.08.15.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:15:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81eef665b49so43191b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 08:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770221725; cv=none;
        d=google.com; s=arc-20240605;
        b=iaCbkLDxV8A5FWsvt93nNNRoYwjnNEDA8FOuYsN3G02rFD0MxqSrfUWnvT040+Bjrm
         KfOBsTs97tX2nIIcnYYDfQ6Ic8OUeEgeEvDzjcvAeRIgAC0ppWDJWNjGbv7JNsb/pE1o
         tVsAvhg6UQMIzg46CF+xRNN0BL8PryCGTZ/bqYxLW2uxU5GrGtPK12dcgsSyb/gvooZI
         WWbBUMOKnbblpA9mdKQ/xTfzTuDiA/7OWVrNwvrMVoN7z7Cu34nETLsmg+pnSORPqy9i
         NmK0y8s4PX5PWwUdduBXFCRg73rduoF85j07wwLQcZFrUePC1jXp9OPm4Sv2zIM9z8lV
         +sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L2nFbyXeO0U0JskjWaQBQ18ORC/5uXabJZL8Rc1CSwY=;
        fh=z72OJjPuNHAnDGA996HTqIuReFVTyf1UKl0RGMdy9j8=;
        b=a+NplqSisWgNv8nbLYUItiOFAjtl/3Jibl7/PQXmnPgDB3oQ331+XyYllBTdDNGSIa
         YdyyoqBnlRbyeel4mNdkkVmro8YUxQ9g/To85r/aL94ozn8ZBuQpsrVyWIOjRrHzF6d3
         yMo9DgvCAC4sJq6PyLptl608DqM+a2PJhrGWFOR4CM1HSoVz8KxR1IIWsWTfXAHGMyHd
         15U18nvmAWGYkFS4+2klDLb+UFQEryNND2UAMfYzin9YgGa8AB+2f0z3rxcHs86iifia
         KTYOCTAuhG/gthKUlhs62/1fDneeNyzTv8t3/kf7pWaQbI+U1SA0nIrUasVo8Z3DBnCV
         j5AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770221725; x=1770826525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2nFbyXeO0U0JskjWaQBQ18ORC/5uXabJZL8Rc1CSwY=;
        b=XrvvbGCO+vb/zteQXZaVakRWrtx+nM2yH4OTrGgamkAzVsIrkuox4TNQxn1FrGOWFJ
         76MwvUf+KMBQA/34dteIWjiedKhx9Vjzl/tb48Cd2dEaPoDZho93AHW2HnvCVJ8Ar3H/
         SyxXcXZFzA8tdlT1bIp5xjCeA73xH/y/U/XX8=
X-Forwarded-Encrypted: i=1; AJvYcCVHWjV5+Ac1BD5lAJIfIoGAieOe8kkJe+wxWOjQUyNBGPcRrwfGts0Dj6JKyirndF61TufVkbE=@vger.kernel.org
X-Received: by 2002:a05:6a21:1518:b0:38e:9e55:6dee with SMTP id adf61e73a8af0-393724aa827mr3851239637.57.1770221725319;
        Wed, 04 Feb 2026 08:15:25 -0800 (PST)
X-Received: by 2002:a05:6a21:1518:b0:38e:9e55:6dee with SMTP id
 adf61e73a8af0-393724aa827mr3851195637.57.1770221724853; Wed, 04 Feb 2026
 08:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
 <20260129061646.1417185-5-michael.chan@broadcom.com> <20260129180320.1c69a0c4@kernel.org>
In-Reply-To: <20260129180320.1c69a0c4@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 4 Feb 2026 21:45:12 +0530
X-Gm-Features: AZwV_Qh4Uw6s7XcP8FdV4_I80y5tEwhSNdWOyZdz2YupYjRipKDbyspxt0yMSBM
Message-ID: <CALs4sv2c9QaRtrV-21YsRsGOkap5LnGPcqEnk9ELn3WcUocFOQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000024ccd0064a01dd00"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256760-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CDBDEA40E
X-Rspamd-Action: no action

--00000000000024ccd0064a01dd00
Content-Type: text/plain; charset="UTF-8"

> > +
> > +    for ctx_id in ctx_ids:
> > +        try:
> > +            data = get_rss(cfg, context=ctx_id)
> > +            _rss_key_check(cfg, data=data, context=ctx_id)
> > +            persisted_contexts.append(ctx_id)
> > +        except CmdExitFailure:
> > +            missing_contexts.append(ctx_id)
> > +            ksft_pr(f"Context {ctx_id} is missing after ifup")
>
> You can use netlink to get them all
>
> ctxs = cfg.ethnl.rss_get({}, dump=True)

Jakub, maybe it's a rookie question but I am having trouble getting
the netlink call to work.
Not sure if my analysis is right but it looks like I don't have the
right schema..
It appears like the decode does not ignore unsupported ethnl options?
I always get the error:

# Error decoding 'input-xfrm' from 'rss'

with the below call stack:

# # Exception| Traceback (most recent call last):
# # Exception|   File "/tmp/ksft-net-drv/net/lib/py/ksft.py", line
319, in ksft_run
# # Exception|     func(*args)
# # Exception|   File "/tmp/ksft-net-drv/drivers/net/hw/./rss_ctx.py",
line 395, in test_rss_context_dump
# # Exception|     ctxs = cfg.ethnl.rss_get({}, dump=True)
# # Exception|   File
"/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 1159, in _op
# # Exception|     return self._ops(ops)[0]
# # Exception|   File
"/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 1146, in _ops
# # Exception|     rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
# # Exception|   File
"/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 814, in _decode
# # Exception|     decoded = self._decode_enum(decoded, attr_spec)
# # Exception|   File
"/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 672, in
_decode_enum
# # Exception|     value.add(self._get_enum_or_unknown(enum, i))
# # Exception|   File
"/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 662, in
_get_enum_or_unknown
# # Exception|     raise error
# # Exception|   File
"/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 657, in
_get_enum_or_unknown
# # Exception|     name = enum.entries_by_val[raw].name
# # Exception| KeyError: 2

Do you think I am missing some config?

--00000000000024ccd0064a01dd00
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCOIPrK
UdH/4KNHHwQ24ISDk3PpTx9Fq7XUQ7vu2KhQ5zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMDQxNjE1MjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBhr0DNux9x3ssrYX65rH30ofNAXH4cQxAzyIdOObt7
tAFGYe83CJZHVelgYAmfhODSSxo9vkUgxRCoEciU0GQNgxWAhT4dQHIPTgMQiE8kmJ0E0ZTYV2mF
ZJhPtNDZkiK+eZctp8hBfiCgQhcSroy3HEKff9pIhYj1pto8Oet/93kTx4cOou8aztlYi7W/xwI3
Mj1tszU0KeNBKfRsJwdVCQuI/wc36CWyBSRFI3EzsEzaky3/fEIHXFOpYaM4IqWJSJP3DUNH000j
MulG/1pS5MDllrlxOGegw4AEqlwjmCn/Xtr8hU2jqpp+CjmAvtYS/vqF3QgML3Q/AWYd1ogI
--00000000000024ccd0064a01dd00--

