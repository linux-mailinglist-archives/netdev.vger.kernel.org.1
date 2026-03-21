Return-Path: <netdev+bounces-270175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qATzI2lIvmmpLgMAu9opvQ
	(envelope-from <netdev+bounces-270175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:27:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF62E3F33
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E3D300F13A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A22D8767;
	Sat, 21 Mar 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kf2hKcQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19D1F0E25
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078054; cv=pass; b=bwsNe7xAfytVzaZQ3rhKUNFqpfjfmz+XO/xsayQZzslEub9luMmajhUnUtdFqYSq48TidxW0k4fpV7kpGi6psqcj2G6bNKjfFRB8xaR5i9ufEGbk07YdgaWTWIgDGp8yVCEkgxKkOVuJfA7l+uU2FpD/TCjceSdvWTgqGA5Q/a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078054; c=relaxed/simple;
	bh=c75/9L8tHRGteLVIbE99Tls3IWNb77rQAByDg82Lwkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDT5eyNGrEWN9hgiMdKxdRvIm4Y2wE0Fb7hFK9pAUjYnVww5pWwNvNVrpBAkJN2lZlmgkhU+zoxmMe/V0s1nN1ArA7+8OjbbBxO/07gcEE8ziCZegqifw5KYF2hL+fHviU20Hl9zbrd8gz4IO9k4qkVfurvQLCdLDpOogOvuk4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kf2hKcQS; arc=pass smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64ad9238d8fso3689617d50.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078052; x=1774682852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8hmLvyOgoKDPIVvP6ka00vaS01pSAMWj6bPxhTBGEg=;
        b=fKNfS7/ikxn0/ouJ9+4h8RM0QHh8MB3q6dPYzJHSg/NB65LuSw+p+JXLVdmr59hDYC
         MMINW1KKfmqcpYFJVoJv+lOMbE+9mRFgNq4OfoRAgLncPMhJPWvC4oZswbpdArO/Ss2v
         j2xcVCg1xWuLGN+0PUV6QruMrySJli+EPJtMEoeVsNlH6AXDHFHcgKa1XRkUSlcv0FRe
         OlQWqC5bHAS7sSwBizMvcvWWbPJL+MAyyB8eIwpUwmhJfQH6ZaGIJPIUO/sYTXyw7gSy
         gMVyZsPj2MIuD2G07Kdezplmzgz+W/YAh+lcVLbz/znOkqxGIsb7vdMSgv/+86ftgTh2
         7DLQ==
X-Gm-Message-State: AOJu0Yyh0cUM0vici8WHLO+TMZHxPBhIk6Ly2YEhSIXTkhg/9VeJennF
	x1Go8Rpz6k6Q8H+NeP1O4uXakeWmkf+4ZMTtPMslTMGkKI5MA3XyQvC1gsKtxxnWxcOXqLzaW3k
	bMJ3yO5i2ZbhU9jsiEjJ+kPZxO7R6aFyokIqzK/DHjv5BEniwF5AmJB0NcOeV9iwbObrX7t7+pE
	p5w379YuSk1Ru6jhuLM9FHlNnFB0kT3LMpsntXS6qoxCJ2PDhMDddNy8iC06h2vCfGA0gqXtGOH
	KHsGulZTWo=
X-Gm-Gg: ATEYQzzsWRyK3/oCH4M8eabYdwW/WdJ3dpA3N2+oFauJfCjP2rJS+UOTfAtJy6uKRYV
	SI9fwD7jWfT6GTOfhQEmkC/6ZUAKMsDRPI35ljoRqKhQnrdozYCxm+xA7jF1vCuLVIliB74TW6+
	83nhhGw4J7dqCjPP0gA8vqbL3AsHeYzFihh5CuqqvxjS1EBgB+9bAukOjTRR6eeIX0EkYNHruCj
	lCgRRqBwut+Z2sr+YiVEfaF5Kc5W4iRgunsgy+YRqwcCMNVJUmFbOsrp+EhS8t4Muy9eSthoLZO
	VtaVqHjgNxEOycGioinc7Rx5w0a26dxGpiE/rBUgVelHFYzvDSrxm8uUnV5t2jvZtp7KW8bfhqT
	szg6/zoFscaKGgm1uyaFsCk+zL62aBwk+h14Mx0O8sN2NcDsPl0OHHb2rGtdwkJknfts1m4rtM2
	XMYZ+BkA1pprvIB+7VdiH0GrYFV//1r/uCg+NC4ItYP3VXh5Pt0v74jpDNvzs=
X-Received: by 2002:a05:690c:ed6:b0:79a:6eda:b24a with SMTP id 00721157ae682-79a90aab7camr63843317b3.14.1774078052051;
        Sat, 21 Mar 2026 00:27:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79a905605dbsm3787957b3.21.2026.03.21.00.27.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 00:27:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7381a95fffso1737297a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774078051; cv=none;
        d=google.com; s=arc-20240605;
        b=U73DNeZcD6V517Eii0Fj8oacBIlEsbUW+QQu6Co4o+rdPo2AkeW34+/okurks+QU9h
         Iq9J+eevwWI5fT3M7Wtjq0TsGtQ7Z+q7iT9cQH56Yw5rDxMuplbueLI9etRUisWUsO18
         dGWx2CZ7uCufomNu9CIXBt3455LYrTziR4D9gfOAm3T3FXy6Dwu9pjlTouDLpd9+agcr
         gcNrvZxrhnGNPBPG1Qzsai1ti1twaENl1epRmbAmznHYY8iBGK97v97Pn6MtmiI243c/
         UY4n4RbfQhI2Z72lAYMr2Y7g0PCAUC63/VA2WOEQsYEW+vBkrO55SppB4S+P7ZQUWb4b
         zcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k8hmLvyOgoKDPIVvP6ka00vaS01pSAMWj6bPxhTBGEg=;
        fh=mnz4pLJSGwwvZLl2lzZTPj3f6vRMBdNyavizvnGoydU=;
        b=RRUfKsGbZ9HhiFLlOdbQlcCO0JM4Zwlkl2lWCHVMRGe/dqK4Gw74dftHpNy3PqW/5z
         F8YJReGNIEjhD7crLwFkME6i+f1Qxkyvv5a0j7D3Q3fxhWh0r/+qkH+zIk5sEFbcTxJP
         6hAiIiKdHIFmHX5ujeLwJ1renABYRTDn+GiF4r6g+rmNfQpGE/KBjfMO3evVvyT12iTF
         ZF/foxjnsnP/hYFxmzSTGm9p5p9VFnh38djSEdcmlQwl7j8CrauXSnJ5ajuE0Mhiy813
         G6jomCmeRV99p7yAoe7uIUcBPdkBnK45xZ4cVUv7EpqEZnrgnhl1Odylmzk6bcd+je7k
         Vmug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774078051; x=1774682851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8hmLvyOgoKDPIVvP6ka00vaS01pSAMWj6bPxhTBGEg=;
        b=Kf2hKcQSULq7W+4zzYLSbcC9Yhgh8JHmAP6GQYgsZ5MbUt72cd/vI4DNGpQHHECQxW
         Eqp60mtuAUGsQSBNqDMOYjoyDGjbXXf9rwmhQICbXcOW0yn1dhp7lQGB9t9E502Ehh/0
         1jD0sAXcORck/KiFP8Oo3+H1ZsO+JjIO3rb5c=
X-Received: by 2002:a05:6a00:3c8b:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-82a8c298dddmr4885890b3a.20.1774078050743;
        Sat, 21 Mar 2026 00:27:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8b:b0:81f:5ec1:8bcd with SMTP id
 d2e1a72fcca58-82a8c298dddmr4885876b3a.20.1774078050334; Sat, 21 Mar 2026
 00:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to> <20260320144141.260246-7-joe@dama.to>
In-Reply-To: <20260320144141.260246-7-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 12:57:18 +0530
X-Gm-Features: AaiRm52wUIH07hR1PUDx9FjGCRvU3BW8M9xvzJvxygBcjhbpWXO5eyKLK1aCMOk
Message-ID: <CALs4sv0jCuw=CqX_mH2+fBmfGca-x7PGt+EFphRX9L8doiEf6A@mail.gmail.com>
Subject: Re: [net-next v4 06/12] net: bnxt: Add TX inline buffer infrastructure
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000a2468064d83bce4"
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
	TAGGED_FROM(0.00)[bounces-270175-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 45BF62E3F33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000000a2468064d83bce4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Add per-ring pre-allocated inline buffer fields (tx_inline_buf,
> tx_inline_dma, tx_inline_size) to bnxt_tx_ring_info and helpers to
> allocate and free them. A producer and consumer (tx_inline_prod,
> tx_inline_cons) are added to track which slot(s) of the inline buffer
> are in-use.
>
> The inline buffer will be used by the SW USO path for pre-allocated,
> pre-DMA-mapped per-segment header copies. In the future, this
> could be extended to support TX copybreak.
>
> Allocation helper is marked __maybe_unused in this commit because it
> will be wired in later.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  rfcv2:
>    - Added a producer and consumer to correctly track the in use header s=
lots.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 +++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++++
>  2 files changed, 41 insertions(+)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000000a2468064d83bce4
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAVK/ho
a+6Db/n86IkWXxcCjNpW8EFz3rFWXPizUs1YtzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwNzI3MzFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBBt9Ce6INriZkiJKcbWi7h//BHy4YJ9eXdcJ5GjoUZ
+74LRZ1rk1ULBkhckfzuDels/phURLME3rdZAq1kM1mBu440oB74wS2phFhak/53s1wx8cq3fR7e
b8AgO96I3YSRNw80yDHVX12lfwz8Z5nkGGWAc3KDZ7QWT6mMx0vqurH2LH3YUNzwnkdV4bz2Xjb9
ozIppYbs9dMPIorRSfkcUaudT09FVpWbrjjUhnTK/KOH6zXFZY15FItDDmDRuqOMT9CoHZHD3BCQ
H6Zawj287u9KI9UaEGed+SC3YEzMB9F42+4uXI9RTXAPw4ze4sHIJOAcQAtNc4bG54w26UFx
--0000000000000a2468064d83bce4--

