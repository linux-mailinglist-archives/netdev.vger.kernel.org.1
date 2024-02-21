Return-Path: <netdev+bounces-73819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4D85EB03
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905861F24FD7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA841292E1;
	Wed, 21 Feb 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGu4vyyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9630128830
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550790; cv=none; b=iJvKV4Noqu9SHHD0gsDLk/CeF74QQzF1hnMwOOW/8YTxk9LJj7BLfRQ2FK9guOHQ6a4dBokgcRKBL/Ws7/V8fqZib0ZSuGo0H69UWDVqHsmWYN3BFNl+5TiXy/DgSYZjWPCCUXL9CX39rpCP7zcqIEJZszbgW4+26vDGFhD3C3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550790; c=relaxed/simple;
	bh=spjmovyqWWJ+CnNL4umKyVRlDIu1FG7HgQO344HeZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUcqBh/W9hW+ZGo3U8b9mMKR9Yi5iI4HLxACexDbpCih7PI7cuQRzewq44eDwJtT3hxlLQdP+t0yBfSpQhZNQAKf82x3ics+3zMOc20sY9JAG0SWH/tjMV5XfC2pdTohp3R/IsbQ796McFRPtTRC4fXY9iPsf0RACSySEU2IOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGu4vyyk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3650df44657so16726405ab.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708550788; x=1709155588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei6xuNgF/xoTMzRe+RBiR7YMpzO4E4Wmr5k4IfUD1BE=;
        b=GGu4vyykHtXA/VGgP/j+FQl++3+a5FC+Crmix1M4TWLsGpDF4q5q2DruxE/uFnj9ah
         ewf/bEK4rqYsMuVr2ZVX+hE77YgWRECEg17eISkKuyou9HRdX6rgmLri7SGSHW3HXL0z
         Tv0csZk9jyA7j32XsANR72zK1wmaKfEOITpR2PMvriy8U+bHk++7DQIa5XzSXs4NzWLn
         EvCLeg6SfvclRdi/xdbUs8aoBOMzdtwSkYGeC5b+0ANsasbZt3DGUV2Dt6Hfgo5ScGWQ
         DPngbVs1BXN8wyNj1gcgfQ0ZCIo9P2odKIbewTI16dnOdH+iKV7BRJdQd07OE05s0NP4
         t+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550788; x=1709155588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei6xuNgF/xoTMzRe+RBiR7YMpzO4E4Wmr5k4IfUD1BE=;
        b=oWAEYaJIKIU/jJxOvo1F2VzzWuGgEUCRerezBSJfH/TctTazWYtrYv0fNiH4lH9dR0
         Scrb9nyHbcaQIdWEq7/zNhPfeMy4Z1UJp8rvZym56PsLLIfLbMTS4E7GZ2o6WOmwwPyA
         Gam30FYRCTaQvoRIHkC0V7+t73K3ooV78mQJX8V3jErawBTOuqwHntB/HsrqzziyzttN
         kRo4Rl7yb228+aBl4+gcMokXVaCAO4E8GNPpx9Bl3wmwlGvxUGAQrczjTbdn15jr6n/i
         rm776MwOhbtG4hHeQgJMXplli+0Li7Fa2i0Ju4eVw+bwzHpofyncEk+4v+0flkTS3Eky
         /IBg==
X-Forwarded-Encrypted: i=1; AJvYcCWVgYqs8ryhbOFjwrJ+qAknzbtqg/MzGZ54FZ/o+QQliCYopwTeAk/hcNXtItZ9B26LiB0Quvhv3Z4kHERUCGdQdXaeOkLT
X-Gm-Message-State: AOJu0Yy6hop5TZNTDsBDgIEQEpAlrrdIK+bqIrJxGH4FKGDRBTfxe3sJ
	CB9EUfXX6v1a+4JuRUU28YMUqfgl9jWhRTs8ju8Q8zCnAnGBePsn8KI0Ftkylg==
X-Google-Smtp-Source: AGHT+IE94cj8KTh5vsD6rggbO3A8K/diAIkIrFg2CCSYRvCxTJhEhQffit7CiRPnd2AjVYaPB7SsEQ==
X-Received: by 2002:a05:6e02:4cd:b0:365:b29:3fda with SMTP id f13-20020a056e0204cd00b003650b293fdamr16002018ils.24.1708550787816;
        Wed, 21 Feb 2024 13:26:27 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02069000b00362759b0e4asm3592139ils.32.2024.02.21.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:26:27 -0800 (PST)
Date: Wed, 21 Feb 2024 21:26:24 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6/9] net: test: Fix printf format specifier in
 skb_segment kunit test
Message-ID: <20240221212624.w4r2w6acijkwn7qg@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-7-davidgow@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-7-davidgow@google.com>

Hi,

On Wed, Feb 21, 2024 at 05:27:19PM +0800, David Gow wrote:
> KUNIT_FAIL() accepts a printf-style format string, but previously did
> not let gcc validate it with the __printf() attribute. The use of %lld
> for the result of PTR_ERR() is not correct.
>
> Instead, use %pe and pass the actual error pointer. printk() will format
> it correctly (and give a symbolic name rather than a number if
> available, which should make the output more readable, too).
>
> Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
> Signed-off-by: David Gow <davidgow@google.com>

Looks good.

For those wondering, %pe has a special meaning in the kernel which can
be seen in lib/vsprintf.c.

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  net/core/gso_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/gso_test.c b/net/core/gso_test.c
> index 4c2e77bd12f4..358c44680d91 100644
> --- a/net/core/gso_test.c
> +++ b/net/core/gso_test.c
> @@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
>
>  	segs = skb_segment(skb, features);
>  	if (IS_ERR(segs)) {
> -		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
> +		KUNIT_FAIL(test, "segs error %pe", segs);
>  		goto free_gso_skb;
>  	} else if (!segs) {
>  		KUNIT_FAIL(test, "no segments");
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Thanks
Justin

