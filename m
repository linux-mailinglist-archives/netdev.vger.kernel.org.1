Return-Path: <netdev+bounces-226584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F43BA25AF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0A11C02257
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB593192D68;
	Fri, 26 Sep 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yy+Zmxjw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1E18FC86
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859230; cv=none; b=PivY7V3stRoCKfXQ1V1+63lf5quKm/ys3+8fup0gcaRbKcmKJC7H5e6Ri+hmcf0O3iBCtSrd/5H1eoHDWVqOE6wfvfR6+KImigO1PrF1E7kV8usDnjjPp/+eGpMQWTaxDMWE4SB34txG1+70YCTSUlMSefNy8chW4vvRuYzGmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859230; c=relaxed/simple;
	bh=cZ3HYoMqj7CtO4MXhZCsEKFNbR7PHnnp0F8SRswIasw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rij+kwIDvuZOAiCPjxBeYQnO72UGZyAGkPWIRhePtxnNSftSpdijVY+vs5TN/0TM5LoVY76/aBeIeHM/YwO4I5gII/bcYGWbd9RynHxqSmbOk0e/TYcmBev8PC+KL+SS9i6+kautS9XgobHRz+g3pE8tBlYZ0r2fFPQ+RnHV/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yy+Zmxjw; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8572d7b2457so150458085a.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859228; x=1759464028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZ3HYoMqj7CtO4MXhZCsEKFNbR7PHnnp0F8SRswIasw=;
        b=hZ3bnpI9QDznLoW9dUBAhSrcEhqn5KCgf0ygI0xzqZ2Zom2rK2ppAhomy57Jl9w0MD
         REom/TWzxskoXv5Gs53h4UFM6V551DMGEFqB5AxR/IVuqbOfi6zG8fEqtOcPFeI3O2dD
         Y3FuQwD0NtQW6/LO53DHed2lygxKhwn1vNjnuqDly3nlqbrYBgKbCGoy5C0Vyc0X6cno
         Xh1iwj8bVNgHaq7DVe1Nq9GhZ47z9QUO/45wzvSSb4/Senm9y1agTposgls6nKaedFkV
         LU9WJ8RjoCzxdKrZMrqXQPpw773kVoPyUL0oCkeTp9KrDg1J5yFuuypbk5AB90a1d5gi
         JFBg==
X-Forwarded-Encrypted: i=1; AJvYcCU4FQIQD02K4yHfQZyMSW/C5NWpwyWJDj88g/DB0ESEvsSIrHfp45JtQlbLW0Ar/DKQIlNl7co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN79wpbwBSRagg3hdS+RxAsQ4kfvuv9kT19xE4Q4JyxU6Q+99M
	kTPd08CX/YPHo1AYDqa0oaJ8bQ2OxsImNaC7fnSZmyyQSnhEYz4PsjLLGdarOsaP9eBF81uIOMU
	aXxMWu37iDg6cYcEI3s8hZuTw2uE0QxUKCcsXbNZ3OLf2aOX357m1emMpn66Qdj36AiXe/YAI1o
	Pa+4QYWnu/nNzOCr2x8r8zP8vYs1bvXC9qE0bWUiSdvHPhzvdz5csgC9HqhapZZvOv6MRNQ7+k7
	5XPOqduEyM=
X-Gm-Gg: ASbGnctEuWpZL9nhuFptluNHbGxAdQRRb7z7Tfd8TQIP4RFszDhPP0nXdRpdBLiXl2+
	XRzmKpVJ1GLOPSYPJLIn2dqnRb+omrCML0xtWtzKQlsw6KopR09Q6IE64Rl3lGmG0k/+U+M1k1L
	VRZRF7DTvwJUkN891blPmTjF9HMShA5JszY46xv2UHLI0UnYpmTo1PrruTeiiIMjtO6cgAl5UTN
	lj9GAb1msAbx/WL1OebheXuybWLY6uxRcRpIPKcMgI5/zLCvzQcR2YLPt5GgQmBHj7Z/17iDwX6
	DdT6+DM4WqmylGZHiMXRxUZw8iHoRKiL5tiyEyBGGXxb/6po0bC8NhCWLu1gfB55qywyawP1H3C
	/h+PS2XyLuuYuoEthMZLjo+8FtONDKrUYG9zxadYKKiNjcmKpDdKg6oy/BRNuTKzq7D+3/DJP68
	U=
X-Google-Smtp-Source: AGHT+IF2Euyhv/9m2KVuGxmv4nesduJiKL8q8fFGuuAIWfW2uqvwBjA1zTCN994gUig6Hj9ZgfKI4hTMLnkC
X-Received: by 2002:a05:620a:1a1e:b0:81a:8037:8592 with SMTP id af79cd13be357-85bc6ebbb21mr822184085a.35.1758859227706;
        Thu, 25 Sep 2025 21:00:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4db0ee49556sm1209241cf.9.2025.09.25.21.00.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 21:00:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3306543e5abso1756179a91.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758859226; x=1759464026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ3HYoMqj7CtO4MXhZCsEKFNbR7PHnnp0F8SRswIasw=;
        b=Yy+ZmxjwvZy5IEUHJu7u8GIe4YHmgVR+Tbha3Ktjmuxzu3c22wxdtpCsDBIMhkIVoX
         b8MLRTGAbVaUbD0jUMksmJlwfSWXxee6N4ckVWW0S3ICmoBAc/PvX+nhy0w3TbnlII1L
         BUKB2afAZpodFa304RzKS1m8l4H4IvXiV4N0g=
X-Forwarded-Encrypted: i=1; AJvYcCUr1vKUPONspcPTwOvwv5zW3N3Xmzn9ZrxtOgqyxPUDDNlkvTcZh8jZUFKoJ/wHymJ6+Ik0Bnc=@vger.kernel.org
X-Received: by 2002:a17:90b:3d89:b0:32e:3592:581a with SMTP id 98e67ed59e1d1-33456c715e8mr4766794a91.17.1758859225922;
        Thu, 25 Sep 2025 21:00:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-33456c715e8mr4766680a91.17.1758859224358; Thu, 25 Sep 2025
 21:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com> <548092f9-74b0-4b10-8db0-aeb2f6c96dcd@intel.com>
 <CALs4sv0GMBZvhocPr4DTUu0ECFCazEb8Db6ms9SwO9CVPzBNVw@mail.gmail.com>
 <74540a81-a7af-4a50-b832-679e7873cfe0@intel.com> <05958f83-b703-4ce7-a526-c6d0bc3fb81e@intel.com>
In-Reply-To: <05958f83-b703-4ce7-a526-c6d0bc3fb81e@intel.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 26 Sep 2025 09:30:12 +0530
X-Gm-Features: AS18NWD0cHRgwyY-onZ_WHTsha1Q3SUkpjKXNAA_66ni73Etw5HQ89RBv_NU7EI
Message-ID: <CALs4sv0N69mHzfMwA7Ly6sgxa+++s+yj3ufzrfetufOuDvXQcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
To: Dave Jiang <dave.jiang@intel.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com, 
	Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net, 
	edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000063f81d063fac53fd"

--00000000000063f81d063fac53fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:47=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> =
wrote:
>
>
> Here's a potential template for doing it with scoped based cleanup. It ap=
plies on top of this current patch. I only compile tested. There probably w=
ill be errors in the conversion. Feel free to use it.

Thanks Dave. I will probably build on top of this.
BTW, I was wondering how could you use scoped free for response and
dma until I saw return no_free_ptr() for them :)
Anyway I will send the v3 as said previously and follow it up with
scoped cleanups later.

--00000000000063f81d063fac53fd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMClwVCDIzIfrgd31IMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTM1MloXDTI3MDYyMTEzNTM1MlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGQ2hlYmJpMQ4wDAYDVQQqEwVQYXZhbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANGpTISzTrmZguibdFYqGCCUbwwdtM+YnwrLTw7HCfW+biD/WfxA5JKBJm81QJINtFKEiB/AKz2a
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDrgHEJ
SgvHfPuV9WOWl44vZTlP5GnA2ikNDC4weHfAETAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTA5MjYwNDAwMjZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA8Kh5OgAg1UdNeoUCyOerYwG0nHmb9LYzLuFmLDf7g
j6SuUTBs70/FEfXVim2GwbiyjHIGCQQV5h0FooTRZVAqxjaixUpkGNmGaKFzd8tdLdH206IKgalH
NjKPq8sRzDAIjPbf9/p2b3+ovHLNdB4SgIYkBP4Zze9TPpkPnkoaA6gP96YwhF0n4sObGXDA92Mb
kBHJw/te7o9v4vpjWKdKFh2XCEuIJ6TNYA6qOpasmuPV5rjre052lilmvfPWm2/q/sKs5ub52qrq
3bzqFCpZliRirVBiZueL0eVTn+xCRHU4KArWpJ0nxtgqDlmlD8PWQTLA5qVpIiVPyamk+blH
--00000000000063f81d063fac53fd--

