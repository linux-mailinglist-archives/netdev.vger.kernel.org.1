Return-Path: <netdev+bounces-153456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632889F810A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45C218945A5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E219DF6A;
	Thu, 19 Dec 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoJcMmNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9015252D;
	Thu, 19 Dec 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627843; cv=none; b=P8ds9fBARj5V3Y948CCwMPqE7TMojpSDW/4HPmNmT8zACj6/nCAazCjphTFxzxl4TcQjnkWX8Ot8DeEb7NoL+BOBLU89bE+q0Q8GW9pQDOzEQu1IgKe1Yf+KO9QVLIiL6Sok+ZSXgXPvKSgb5i5fNV2UX88I/GfqYifUKMUtk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627843; c=relaxed/simple;
	bh=Um6KpQMeUpI1o98cH9o1qH/UWhFM16FvOlogG0Gc6iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e97CC9qFyVDnK0FAlYS0rQpvXnU+rVnJ/wzSMdzuxqW9Q4EbFX1+b1ALVd8AM0aKjrFQHeWbAd+UaG6/oo8/4IVWeaXQ1kIxHHLnpThQqU3XU8mhaS0rCKRIVq3Ga5SiB4Y7kTA/TeHwyCbMCO5aXJPa3tuPYWwzrWKsUevm758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoJcMmNC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30039432861so10279211fa.2;
        Thu, 19 Dec 2024 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734627839; x=1735232639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sur0OeWfd50x4tbBVyuDh7nPTJzAWoHCo8e3rWELqB4=;
        b=JoJcMmNCSjD57XAALoBuplroqhja2XL2PDPmwKeMGsgQsKtru4mFxzhwELub4U2AK4
         SXFl5rYMAjvSc+qzd/1Mi/7vrhAalQzvsROqzjSeVPTBIZfLl8C3Zgp7zcZzpeDQg8r3
         XxWJ/x8JVkSdExU4Wt5iT1yHw6yc7Ibyh7BZVyZXkUAeX6cidDj0t4ugvLVKkn+8Abx5
         O7qHfFaPhevHtuulRTo3jTDfUss/hvvthgFYr2rVXFjAgIvflnv4ccu1O35SSLd7InWr
         ckJTYuHUX1g32bjOCLGE4VDLR2cs8vcuzr8rzuApZVL4YYcx1h94HiRvSEOuZAHOD4gv
         v1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627839; x=1735232639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sur0OeWfd50x4tbBVyuDh7nPTJzAWoHCo8e3rWELqB4=;
        b=LZkzjEAz9BBSCYp+dMHyWlVeAKg9vrb5Gn6Yhprco36BFFew/82eODod/QRyo0VE7n
         jx9nLjZjzL0hB2Qvoz5B+xmSErzKNtlROaBiSPMy0B0Q/7MLPdFDQs7MRdtjxXQqnc6U
         bzh0/42wvz+t3NO4KoVS+lGVwgnvhhU27dHk34vz2ZPM01liSNzKXPW989497PE5shWm
         q1xx45kDdk0Zm9h3rq7nyfQfoLAxTT2UFdz/p3/4aWs0hkx5GbYK5+yosnmaEFeFZ06O
         R5JtZfc+l+J9eBuIVGoswLlOAgpPUcTlb0vclWgDc69xm1v/L2sdA9czlxuRu8LSkXTn
         a+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV7fs2mK7vKcM+ryDsBcn49gFFqAf07+95vyvwHPkOClG1fQBid4c0j76Pl+iXUv1QJ4eK0aCtb@vger.kernel.org, AJvYcCW/CPGPxA5i6YNW7mwQZuKnd/+tNlpFTJz9gQ0S6MxcAABJDBfpVQYUtbB31OFCSZFRcYU10RywfmJFfpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyCOvx3wTozOox++VCEfQY+reoaRkGNGXmCKtLj98Nw0ex17D
	wNLxr51mL0xCtELN2iNR6zwo3n8Zq+h30efcKa7HaOn0elYnnKgi4R0rLOqqTCi2PmYbndhSW1o
	hj/VJOME9fMn2Wb7vO36ugFAMyOQ=
X-Gm-Gg: ASbGnctOl8OwVskAP+Xq+9syXibZbr9Jxg2RA9YxcChl40duOYw18HbB26m8Y4Qqey3
	fAwXchUXZffGwkaZdFXeB2crorX+q4jhajAzLoQ==
X-Google-Smtp-Source: AGHT+IEKsHKJaiNWPxarhgtnZN8O/nmNTDsV3KFFzk7Y+PV1ziPvwtrIF5ZsSH81W5pFevVXV3yL4kfI8HMNPd1vMi4=
X-Received: by 2002:a2e:a710:0:b0:2fc:9869:2e19 with SMTP id
 38308e7fff4ca-3044db56bd0mr25595751fa.34.1734627839217; Thu, 19 Dec 2024
 09:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219121828.2120780-1-gal@nvidia.com> <CAFULd4YHFFKBzaF28f8n3z8WcOzom1WUe_hfRBx0ehhCpT9xnQ@mail.gmail.com>
 <CAFULd4Z0PSzwvsFx_5deMKb7tV34uJWcHEadYGdk+D72QuHonA@mail.gmail.com>
In-Reply-To: <CAFULd4Z0PSzwvsFx_5deMKb7tV34uJWcHEadYGdk+D72QuHonA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 19 Dec 2024 18:03:47 +0100
Message-ID: <CAFULd4ZcSY+1WPn2T9dHVJZyyg1p+YaexQMJzAXHnCDy90j2fA@mail.gmail.com>
Subject: Re: [PATCH] percpu: Remove intermediate variable in PERCPU_PTR()
To: Gal Pressman <gal@nvidia.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002cb00e0629a28415"

--0000000000002cb00e0629a28415
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 5:02=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:

> > > The intermediate variable in the PERCPU_PTR() macro results in a kern=
el
> > > panic on boot [1] due to a compiler bug seen when compiling the kerne=
l
> > > (+ KASAN) with gcc 11.3.1, but not when compiling with latest gcc
> > > (v14.2)/clang(v18.1).
> > >
> > > To solve it, remove the intermediate variable (which is not needed) a=
nd
> > > keep the casting that resolves the address space checks.

[...]

> > >  include/linux/percpu-defs.h | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.=
h
> > > index 35842d1e3879..573adb643d90 100644
> > > --- a/include/linux/percpu-defs.h
> > > +++ b/include/linux/percpu-defs.h
> > > @@ -222,8 +222,7 @@ do {                                             =
                           \
> > >
> > >  #define PERCPU_PTR(__p)                                             =
           \
> > >  ({                                                                  =
   \
> > > -       unsigned long __pcpu_ptr =3D (__force unsigned long)(__p);   =
     \
> > > -       (typeof(*(__p)) __force __kernel *)(__pcpu_ptr);             =
   \
> > > +       (typeof(*(__p)) __force __kernel *)((__force unsigned long)(_=
_p)); \
> > >  })
>
> Actually, you can simplify the above a bit by writing it as:
>
> #define PERCPU_PTR(__p)                            \
>     ((typeof(*(__p)) __force __kernel *)(__force unsigned long)(__p)) \

Andrew, please find attached a substitute patch "[PATCH 4/6] percpu:
Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors" for your MM tree
relative to the above hotfix. The whole patch series (+ hotfix) has
been re-tested against the current mainline defconfig (+ KASAN),
compiled once with gcc-11.4.1 and once with gcc-14.2.1.

Uros.

--0000000000002cb00e0629a28415
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-percpu-Use-TYPEOF_UNQUAL-in-_cpu_ptr-accessors.patch"
Content-Disposition: attachment; 
	filename="0004-percpu-Use-TYPEOF_UNQUAL-in-_cpu_ptr-accessors.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4vkkzvw0>
X-Attachment-Id: f_m4vkkzvw0

RnJvbSBmYzkzM2M5Nzg0NDZkNmFhZTk3N2I1NDBmMDBjZmNmYmZjNjViNzU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBVcm9zIEJpemphayA8dWJpempha0BnbWFpbC5jb20+CkRhdGU6
IFR1ZSwgMjYgTm92IDIwMjQgMTY6NDY6NDIgKzAxMDAKU3ViamVjdDogW1BBVENIIDQvNl0gcGVy
Y3B1OiBVc2UgVFlQRU9GX1VOUVVBTCgpIGluICpfY3B1X3B0cigpIGFjY2Vzc29ycwoKVXNlIFRZ
UEVPRl9VTlFVQUwoKSBtYWNybyB0byBkZWNsYXJlIHRoZSByZXR1cm4gdHlwZSBvZiAqX2NwdV9w
dHIoKQphY2Nlc3NvcnMgaW4gdGhlIGdlbmVyaWMgbmFtZWQgYWRkcmVzcyBzcGFjZSB0byBhdm9p
ZCBhY2Nlc3MgdG8KZGF0YSBmcm9tIHBvaW50ZXIgdG8gbm9uLWVuY2xvc2VkIGFkZHJlc3Mgc3Bh
Y2UgdHlwZSBvZiBlcnJvcnMuCgpTaWduZWQtb2ZmLWJ5OiBVcm9zIEJpemphayA8dWJpempha0Bn
bWFpbC5jb20+CkFja2VkLWJ5OiBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4KQWNr
ZWQtYnk6IENocmlzdG9waCBMYW1ldGVyIDxjbEBsaW51eC5jb20+CkNjOiBEZW5uaXMgWmhvdSA8
ZGVubmlzQGtlcm5lbC5vcmc+CkNjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+CkNjOiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0Br
ZXJuZWwub3JnPgpDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+CkNjOiBEYXZlIEhh
bnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPgpDYzogIkguIFBldGVyIEFudmluIiA8
aHBhQHp5dG9yLmNvbT4KQ2M6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0
aW9uLm9yZz4KQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPgpDYzogQnJpYW4g
R2Vyc3QgPGJyZ2Vyc3RAZ21haWwuY29tPgpDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIHwgOCArKysrKyst
LQogaW5jbHVkZS9saW51eC9wZXJjcHUtZGVmcy5oICAgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wZXJjcHUuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCmluZGV4
IDY2NmU0MTM3YjA5Zi4uMjdmNjY4NjYwYWJlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wZXJjcHUuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaApAQCAtNzMs
MTAgKzczLDE0IEBACiAJdW5zaWduZWQgbG9uZyB0Y3BfcHRyX18gPSByYXdfY3B1X3JlYWRfbG9u
Zyh0aGlzX2NwdV9vZmYpOwlcCiAJCQkJCQkJCQlcCiAJdGNwX3B0cl9fICs9IChfX2ZvcmNlIHVu
c2lnbmVkIGxvbmcpKF9wdHIpOwkJCVwKLQkodHlwZW9mKCooX3B0cikpIF9fa2VybmVsIF9fZm9y
Y2UgKil0Y3BfcHRyX187CQkJXAorCShUWVBFT0ZfVU5RVUFMKCooX3B0cikpIF9fZm9yY2UgX19r
ZXJuZWwgKil0Y3BfcHRyX187CQlcCiB9KQogI2Vsc2UKLSNkZWZpbmUgYXJjaF9yYXdfY3B1X3B0
cihfcHRyKSAoeyBCVUlMRF9CVUcoKTsgKHR5cGVvZihfcHRyKSkwOyB9KQorI2RlZmluZSBhcmNo
X3Jhd19jcHVfcHRyKF9wdHIpCQkJCQkJXAorKHsJCQkJCQkJCQlcCisJQlVJTERfQlVHKCk7CQkJ
CQkJCVwKKwkoVFlQRU9GX1VOUVVBTCgqKF9wdHIpKSBfX2ZvcmNlIF9fa2VybmVsICopMDsJCQlc
Cit9KQogI2VuZGlmCiAKICNkZWZpbmUgUEVSX0NQVV9WQVIodmFyKQklX19wZXJjcHVfc2VnOih2
YXIpX19wZXJjcHVfcmVsCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BlcmNwdS1kZWZzLmgg
Yi9pbmNsdWRlL2xpbnV4L3BlcmNwdS1kZWZzLmgKaW5kZXggNGZkZTkzMzM0YWMzLi44YTdjOGQy
ZDU3MGQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGVyY3B1LWRlZnMuaAorKysgYi9pbmNs
dWRlL2xpbnV4L3BlcmNwdS1kZWZzLmgKQEAgLTIyMSw3ICsyMjEsNyBAQCBkbyB7CQkJCQkJCQkJ
XAogfSB3aGlsZSAoMCkKIAogI2RlZmluZSBQRVJDUFVfUFRSKF9fcCkJCQkJCQkJXAotCSgodHlw
ZW9mKCooX19wKSkgX19mb3JjZSBfX2tlcm5lbCAqKShfX2ZvcmNlIHVuc2lnbmVkIGxvbmcpKF9f
cCkpIFwKKwkoKFRZUEVPRl9VTlFVQUwoKihfX3ApKSBfX2ZvcmNlIF9fa2VybmVsICopKF9fZm9y
Y2UgdW5zaWduZWQgbG9uZykoX19wKSkgXAogCiAjaWZkZWYgQ09ORklHX1NNUAogCi0tIAoyLjQy
LjAKCg==
--0000000000002cb00e0629a28415--

