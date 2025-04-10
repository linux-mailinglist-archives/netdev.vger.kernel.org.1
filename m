Return-Path: <netdev+bounces-181441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69585A8502B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4184C0955
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775720F082;
	Thu, 10 Apr 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CbieWWDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4720C49F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328395; cv=none; b=bFgpdYIsojVqBrMSXE8+LVCjR+irZirW1JnrblQEP1kPTxfF9nbe2cCL5dd3Ns53Vdp0FeE3l49wfqASSo/DDOWHYvGhPaVMiJS0MDVH532dXlFZvBABE9kyDg7qI/LStm2ggROUpEXZcSJVVW/lREhjw/Uz0Weu8txwpnQZlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328395; c=relaxed/simple;
	bh=6J7OYI0B89b1Sspls6Ctb2g1nTWerPxbjQxWLYFytAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJoW1At6JDpbpdutlSPdy7uCcmzuCo9WlG2gtGuvl21rLwqJXvumikmD6IQO1Y0FXZltxw40J7zImfW/f3C2w8pwiPMQpe3bz0e/Y/LuR6O7HcgiRfvQBkDI1LV0MxwzEbaSwmpp/aP9RSoXpx3OFbUsJQxdIOdMor/8z5f1+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CbieWWDz; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53a91756e5so1342615276.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744328393; x=1744933193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/e65asYGXnncGQSR6NtE2jl8iv1mlv7n2LyOLlbUD4A=;
        b=CbieWWDzhyvuEibPy/IIst2O9t+vLkNePBJfOAjalx3F5saq7WcIDhVTdgj2WxoXS2
         +8W1bGgSFT4v/ze/dBkAwzW64IxN2yjfdnxFqyk43RHiWPuF6tGCKOZAGXTeL3jG9F7M
         JtZy5SqhC1RgrBhOYcOF/ALNprahPMF0wHr/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744328393; x=1744933193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e65asYGXnncGQSR6NtE2jl8iv1mlv7n2LyOLlbUD4A=;
        b=g63vV71GmliIwrlYBOQ3/adBdZ53EquvWgw+ar3T6wGaSNQYcCUYn7gJjkp/WIqkog
         38y9HyqThzCn8ntaDpwfqP/mDJAiN+RhSo+16VFK/29uF0ffPnXE/3y/0eTn8+0HX41v
         flqv7alvXgCF7YBfrKmGEIFYDjF4lkNjp+2LW1lBl1TuKJJ+v2DIzjFoHK/VEjIHIKdc
         +odl+LVSY0DphFLE3RCgzU9c0QylSsowlkzqYOYCLxT+lq/PX6MWocS2LLNsz6ujnVTf
         mkEbNGysyJVvRhPNLKrHuWzu43ZhWiOpHmHr6l++nheEfgVGs8VlS/Of77G0/SnEl3rP
         bzOw==
X-Forwarded-Encrypted: i=1; AJvYcCX8UivnAgBadutnw1vohTKKFj8J0x4mPhCLoepeW9BC8Z+NJWnMTNyFMhWlv3KNViG65DxrjvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNSpXjGfyYiZub6kLOQ/Sx5s4eFX96ShKNChAfCsKvm3mBv+G
	/o50cTBhY2s2xUjgvtIaUqoroBY8w0bwtprdunKxMZ/B/dnfFcsFzsm5S1Uy0gP1L57TTlL2hde
	t62HlZHT2J5W2S70AwCNnf4I6gjKvTKXcWpq5
X-Gm-Gg: ASbGncusbLWcucsHwk+a6j9USMWMvEqWz81QsPV07SOKGaBsV+hp5NbR2SdPAaCWmwd
	fnEwCv4GKQcbg4meSLSQ1ZuOv4LzeBvmL3NF6GNh95TC8Va/uzoK/vUBMWgL0S9gNdqUQ1lxk55
	T3N3G9GjczZ1F2a4hqEz9vv1c=
X-Google-Smtp-Source: AGHT+IEL+J8vjWemFan7tGN6Lzpd4IPPXJIE8QvqrLJIp6SFaSMpnoILvEZJickj24knHQ93QpdNgHNW+dqEpJaLBMI=
X-Received: by 2002:a05:6902:cc6:b0:e6d:eea7:35c3 with SMTP id
 3f1490d57ef6-e704de9baf1mr1525839276.11.1744328392978; Thu, 10 Apr 2025
 16:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410074351.4155508-1-ap420073@gmail.com>
In-Reply-To: <20250410074351.4155508-1-ap420073@gmail.com>
From: Hongguang Gao <hongguang.gao@broadcom.com>
Date: Thu, 10 Apr 2025 16:39:41 -0700
X-Gm-Features: ATxdqUFz7ILQselhZvBFKIFRwC2sEOIF5ub92440A9VE6hJHd_9379FOGZQVwdg
Message-ID: <CADYv5ecPX+k45W_0GJDGkojsx57g3bcfHk9FZVhD5UzgF=7sUQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] eth: bnxt: add support rx side device memory TCP
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org, dw@davidwei.uk, 
	kuniyu@amazon.com, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, Mina Almasry <almasrymina@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000040eebc0632751afa"

--00000000000040eebc0632751afa
Content-Type: multipart/alternative; boundary="0000000000003c6d510632751a86"

--0000000000003c6d510632751a86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 12:44=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:

> Currently, bnxt_en driver satisfies the requirements of the Device
> memory TCP, which is HDS.
> So, it implements rx-side Device memory TCP for bnxt_en driver.
> It requires only converting the page API to netmem API.
> `struct page` of agg rings are changed to `netmem_ref netmem` and
> corresponding functions are changed to a variant of netmem API.
>
> It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> page_pool.
> The netmem will be activated only when a user requests devmem TCP.
>
> When netmem is activated, received data is unreadable and netmem is
> disabled, received data is readable.
> But drivers don't need to handle both cases because netmem core API will
> handle it properly.
> So, using proper netmem API is enough for drivers.
>
> Device memory TCP can be tested with
> tools/testing/selftests/drivers/net/hw/ncdevmem.
> This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> 232.1.132.8.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Tested-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v2:
>  - Fix using wrong pointer in error path of bnxt_queue_mem_alloc().
>  - Fix compile warning due to a defined but unused variable.
>  - Do not define inline function in .c file.
>  - Remove unnecessary setting a pp.queue to 0.
>  - Add Tested-by tag from David Wei.
>  - Add Reviewed-by tag from Mina Almasry.
>

Hi Taehee,
v2 looks good to me.

Thanks,
-Hongguang

--0000000000003c6d510632751a86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Apr 10, 2025 at 12:44=E2=80=AFAM =
Taehee Yoo &lt;<a href=3D"mailto:ap420073@gmail.com">ap420073@gmail.com</a>=
&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Currently, bnxt_en driver satisfie=
s the requirements of the Device<br>
memory TCP, which is HDS.<br>
So, it implements rx-side Device memory TCP for bnxt_en driver.<br>
It requires only converting the page API to netmem API.<br>
`struct page` of agg rings are changed to `netmem_ref netmem` and<br>
corresponding functions are changed to a variant of netmem API.<br>
<br>
It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of<br>
page_pool.<br>
The netmem will be activated only when a user requests devmem TCP.<br>
<br>
When netmem is activated, received data is unreadable and netmem is<br>
disabled, received data is readable.<br>
But drivers don&#39;t need to handle both cases because netmem core API wil=
l<br>
handle it properly.<br>
So, using proper netmem API is enough for drivers.<br>
<br>
Device memory TCP can be tested with<br>
tools/testing/selftests/drivers/net/hw/ncdevmem.<br>
This is tested with BCM57504-N425G and firmware version <a href=3D"http://2=
32.0.155.8/pkg" rel=3D"noreferrer" target=3D"_blank">232.0.155.8/pkg</a><br=
>
232.1.132.8.<br>
<br>
Reviewed-by: Mina Almasry &lt;<a href=3D"mailto:almasrymina@google.com" tar=
get=3D"_blank">almasrymina@google.com</a>&gt;<br>
Tested-by: David Wei &lt;<a href=3D"mailto:dw@davidwei.uk" target=3D"_blank=
">dw@davidwei.uk</a>&gt;<br>
Signed-off-by: Taehee Yoo &lt;<a href=3D"mailto:ap420073@gmail.com" target=
=3D"_blank">ap420073@gmail.com</a>&gt;<br>
---<br>
<br>
v2:<br>
=C2=A0- Fix using wrong pointer in error path of bnxt_queue_mem_alloc().<br=
>
=C2=A0- Fix compile warning due to a defined but unused variable.<br>
=C2=A0- Do not define inline function in .c file.<br>
=C2=A0- Remove unnecessary setting a pp.queue to 0.<br>
=C2=A0- Add Tested-by tag from David Wei.<br>
=C2=A0- Add Reviewed-by tag from Mina Almasry.<br></blockquote><div><br></d=
iv><div>Hi Taehee,</div><div>v2 looks good to me.</div><div><br></div><div>=
Thanks,</div><div>-Hongguang</div></div></div>

--0000000000003c6d510632751a86--

--00000000000040eebc0632751afa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVKwYJKoZIhvcNAQcCoIIVHDCCFRgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKYMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGYTCCBEmg
AwIBAgIMHGTvXBdb4DkN+V0GMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDgxNTEwMjcxN1oXDTI2MDgxNjEwMjcxN1owgasxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEWMBQGA1UEAxMNSG9uZ2d1YW5nIEdhbzEpMCcG
CSqGSIb3DQEJARYaaG9uZ2d1YW5nLmdhb0Bicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQClwCQ8RdUmQwTPMTgmeORWbuoQz5wDy+NJVqLP252pkmNJ+JnAxnoGMx9h
LCFJNNfKj41QBKc/Ymm6naKPDMTb79r7i0LDD2srKn6k0cFaD/Dp8g3bol1Vcxv+Myb8JBwJGGIg
mULU8ZK3Tl7crejhU/ck3WrbUYKADGSTXn3GidVz2A146H621l3QV6yiokkLGZgKWrMdhTkAa1sp
6gPzprBwQBG2PSUZESRSSZBnOrEv67WUGjMQ2xKFl5QtV45AJsjwPv347WWEeRdwKKYqej+92zBW
Cy2bw1PMazGOtjTrXONkd2Hl91SPFtxzSmLmm/5ym8rztHNPjSbr3KD7AgMBAAGjggHbMIIB1zAO
BgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUF
BzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0g
BF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEW
Jmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0f
BDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMu
Y3JsMCUGA1UdEQQeMByBGmhvbmdndWFuZy5nYW9AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsG
AQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSKHph2Val8
0poL1cCemsH9smPYlDANBgkqhkiG9w0BAQsFAAOCAgEAWutujvKFZAVdJRrHwNB7y7c6pdfqz8hW
gZKnOKTC7pLuaklYzo0gm3t0PefLSnJoHpG8Ne72rWQbbjphkq2sPItB9EkI7MN8NWJT0NFb4d9p
7FMPidn81rqWfgCyUm0ZnxQ5kUvb0rEl6AtGWu1QeAtOQ2Yb5ywmBeoNbTfMRh5PiUWLw5yIc8jV
9ncHJbql0kO/qtVpGdYpQAs1BC0IM+5o59vCfhaRkIUKKOaEvD9R1qTbBLji0FqQ8H+B3hXl/Y0+
ZSyzTSXi17Fnzm0Zd2qiPL+5za87WYxVTXjMnvoUmSlLpkQlObVj9ygIWTX/emdVrksC5y9PiFmy
c61l4H8fP7UNtl512FH4ifkOIC0BVhh0YYumIoxnWQCxHLDNh2zrUOr84JdYonX//0gw9MXIoGJT
5m6UYttJzkZTm9pp2iVevd2tyOZnAGTGEztuVUuAR7f2lwC/7zbZc0e/hZte4WAWUFqv2fVkdNPW
woMhJ8FueSq8+KYzgFzJQoL2HaU04lr3QkRddLuvFrLhKu9hhR0A3KLpiQyZUFHCBcCxr/CtqZXt
js4a/l8yVFoVdTFTKggp3F8g/azSQwnJ9YabyIODwzEcgwP7OJqTNME23ruqveoJiLMzC6q0gH06
oJRbQELZ/hpso63dwEFbXOrxArN8O6bHUeWJlQdSKD0xggJXMIICUwIBATBiMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzAgwcZO9cF1vgOQ35XQYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIOrZXm8PvlVG0jaoT/8/6Gp9fQSLe9OWKtPDw1IJNyk4MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQxMDIzMzk1M1owXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJsdIpzBGO1Q2rI4mA/ZIZkObjZT
kml7b/xY51ip/m4fWoPnrGpdCLUD399ebbS/0Q5r2v8d+FdNz/epyOh2hoDh9R2aTyAbEzvc1+q0
9YAMwEZThw1EP/UY2O715Vr0sbTi0GrWyPIKxRRMqQ6ONIqvGSkRjHydCs7fIbKoGW1WxYdNUhxL
iQloK7FbaOTLQJcFBwKDTCi4cGIiaHOuyE62MM+uWvqUcLMw9Xy192MJ0KNg1qIwwh70hWiLZkB4
wsuiDMaxPmBL2jq4JDajpWbt1SFBqK1uL/2zMyHLwo3K5urhL0DmDnZV9M5RyF5Qq+AiwyCd3ptS
ZWI+iCgXEko=
--00000000000040eebc0632751afa--

