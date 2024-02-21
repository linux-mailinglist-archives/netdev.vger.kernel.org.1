Return-Path: <netdev+bounces-73814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E679085E924
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD62834D4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4723C469;
	Wed, 21 Feb 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aupDeewO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D263B298
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547889; cv=none; b=BmxbpCQIw5xYZGpPBxFNZrnrrKOEoJOPguS+IG7t8lFiuAQ/Wx+a+drcqlptAQBQbERiYm9bc/v/9kEriVhAP7iSDAkFXT2WSHP7tW/E/Hl0of2nLThzK2xLJPgNSO4BgX/YCnFogoDaMFK09i47Y9caW0WQba3n25fjb+X8kG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547889; c=relaxed/simple;
	bh=GFhPlma8ElxwHflsLYpQTVGFiMO4B/Q3z9xrY8lb7y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHFnpMau+aKdihRzixez7IYNFZgr8Aj8ugzu/zQta/HMlW0AXISMySwrGcO8l4sVWcpTx9KyEDoukWjNytrfx64+tCTc8K7ZpFipI6EKJIwuvUKXBnEFgTvsdOhfdYwMs07HYuyhClAPuvbeEHDZnl2FEQ8kxTKlJDVYsQZiQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aupDeewO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3650be5157fso1215ab.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547887; x=1709152687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=aupDeewOPr95DfcKzO//TQVMVx1z7YxR8/TenZSYNDEQ4kXXsX0pWB3n4owAszKmQP
         gyXXMQLuQIIkTyXuXB1gq9K7oDjIZFPDVeedbGe0piaAv6erXPToFy6u1vw6i5bHmWq1
         g6Kk9QtI4WbeeCd+Q4Xjb9AgH1kzUlRIpR+WTllYXoVA10oAxgV+JRnAD1zOlYpNVoR8
         COlxkfEFgeWssFLprHTUgglbfEMLUkOwOk6DQ7ynMPobAkcThlWjGLXvQEhyrGoDOryA
         BA4X1vKAoNF6UsiT6XVhjSwzIkRtPl46gXOfmyjD15OXBTVnq++Y2CkaTdPiix3KcP0e
         B2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547887; x=1709152687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=uRo+kbCF7avsDKRzopzhvgzXLEBNzpLpiymA/36fT8RPVAKRzGyybyyIGaD5kazlBe
         diVwyhT716y4l5++sr5bIS7FQcOZmfDKZLN1j4y9VQuxggne3CHcku6nIzQCcPNfhbic
         CjHQy/XUkpNT/lpv0VqXiE5L80VruQe00DpiSYabOAOSavX9XnhfKWxm8YcyxSHy08qy
         gQo8DWmSLVoWXWXeFvGGIxo8fiHKakjWwBpUNueSAU1BSEeE2lHdptIoCfz2z1aYzKte
         TKV4h6U/Y/BSH+6nZtsVADTObI32Js4IAM5HuMW8mnwwJOLp/6wiY96IugdCdEGA1WrU
         b/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/sjnvArdIqcuPu35svHzuccrq3KYB8O2J6hHyGjBL6ZVI6et/FnNbxNIMzh3hb1w5oPkvC4Nd86E7mmdbz2DcCAYsqsp
X-Gm-Message-State: AOJu0YxxBkoUXwSkc+g8jkzqOR6iiS8lfnkpaftZ2/9Sp9uv2Btl/6NV
	9xS3Ei9OT6cNpvvI7jKm/8+QYwjWCMGd5Kz6tCaydzdmrpNPAtIOs4FQf8BETCKOpTzmGblFYjw
	KsxaT5eHTBdl8v2e9MsNPN9YNvTliOG45TFu1w4pf7Wm1Rnz5iA==
X-Google-Smtp-Source: AGHT+IHkUH8682wBjX2MlXCiKDKRKTZ78A7IDkSZwKh62FAeHimOB2zWqCHjoUmuvZXD72aiFX0+O0WGwp10g7NziwQ=
X-Received: by 2002:ac8:4907:0:b0:42e:660:eb8d with SMTP id
 e7-20020ac84907000000b0042e0660eb8dmr285459qtq.5.1708547393077; Wed, 21 Feb
 2024 12:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-2-davidgow@google.com>
In-Reply-To: <20240221092728.1281499-2-davidgow@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 21 Feb 2024 12:29:38 -0800
Message-ID: <CAGS_qxpyNVqigHB+kS-1xqzR4BAOQXoMSNS+d5khkLYrkpmOgA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: test: Log the correct filter string in executor_test
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:28=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
> but passed a random character from the filter, rather than the whole
> string.

Note: it's worse than that, afaict.

It's printing from a random bit of memory.
I was curious about this, so I found under UML, the string I got was
always "efault)" if I make it fail for j=3D0.

>
> This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
> the format string.
>
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 22d4ee86dbed..3f7f967e3688 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test=
)
>                         GFP_KERNEL);
>         for (j =3D 0; j < filter_count; j++) {
>                 parsed_filters[j] =3D kunit_next_attr_filter(&filter, &er=
r);
> -               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 '%s'", filters[j]);
> +               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 from '%s'", filters);

note: if there is a v2, it might be nice to include `j` in the message.

