Return-Path: <netdev+bounces-102034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6D9012C3
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EB32823E2
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA717A902;
	Sat,  8 Jun 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAjIsKDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66E17966C;
	Sat,  8 Jun 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864328; cv=none; b=ak07OGLKKkcnGiCBvhwyX8hWIfs1uk011jDMgeJxaQcMLHtVCA1kbjobELdSncj7jRH46IXgg5AEv7Y/yBOxq7l3mEIh0zc277H4DByO8rpSg4Mzqy3QU7UNRhMAb/4VZPsl2hzUdwQXd+ybFUfhmjYuM5pWE/uVIaX41BZn8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864328; c=relaxed/simple;
	bh=o/u5WZeJigd1BA/22pBMeXDv1TvliwKZCiKlV3ON1+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp01JPKcD1XUe+5/z+Gx7l28ItO9EfyE9QFb/WYXw/362rHh7PbsMWZTNx5xKlbA95WnCqDZhs9BLHmb5ETtISsp0nc/eHUUcfeSx2f8AoeFO35E9Wj24jHGB6bbWl5NVl4kTPD5Zy11qfwhvIMs8RrZ7rjbIq9x/eyvnoqLpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAjIsKDu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7041cda5dcfso835448b3a.2;
        Sat, 08 Jun 2024 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717864326; x=1718469126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmEppoo7LJtI7/L6gS+2VAgxSOPXPX1I5fRFysD/WXU=;
        b=GAjIsKDuoZidD3tPGrgcjntWDbbwbWK9XjuwwIJRa6MymafQcqwqVJDZsCo+XdxYlo
         thOv2CgdbbU4S2qGv8PrYuBp6OkIJSxElKh40EWVYQR93empjBKj8C+lSX+iDijFww3o
         kmLvnvMVgTGUn9eHMupJdoQfvIFUMtkhzloz7TBzjW+yeS4r9YrnoTfGupkVJaKJ1nqE
         t/z7uG5T1VamfbBiwjnTyNjWKA89W6HuOSQg9ca5E8uc0VORnFOx1ZGakjFKzQfuVHJy
         zwMENZz4DmCAo4zJtNvm3Z1JGUOgHxf5Db5Yj9tcm6ZhrrkQ4d1uX346JqyEdvtfCs2i
         CQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717864326; x=1718469126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmEppoo7LJtI7/L6gS+2VAgxSOPXPX1I5fRFysD/WXU=;
        b=pRLhTxf1ggdNtRiO2/hL1hbVu3OVQfOur3oMesnQzudcrQfOQYQOtcf1WkRv6xkxC7
         NeQwnJJUTxgGqjy6RWA+M2HaMV3WkyLkuOp99FcGQsQQPWmGDh6wUwMPnyYY30uS+oZ4
         ZsDmOHsYQHAs2ancM+pI+/SKmvdKmw7fEIcEQrtqRHB/nI1JUQJTTQJIThoKcTDfQg9K
         QqHapVZclq0+ywWvPt7bSSh+uFnp6kW1RQTB8TD29wMo1RkO67SilvwUrpcfG79hY4LC
         Jnl+MnI4yct8cuxsyAO6xXl2bmW8r0mIBD0FUxN8l9jGVIm52ISGZR6+RHzr+2pmx91x
         8CIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4MZPXPEXWswl7QqaFf99cZ9OaDbdYYdesz52ajfdgbesDqD7Tf9QI4rH33TcG94mHbhDo1pk+JxmEO/1BBneGaATbynlL7wSI98tgPtX2pj5IG9VkgE6PzZI6jaeuVBHZ/Kgp1aPIbtX91gRA7fGTei3l/Ssy4gy4NtMbKPjBKJCvcJgS
X-Gm-Message-State: AOJu0YzHnuWr9ozLnVCyJymWpny4kVYKiz3pU0/BdIfwt+KtVqh4ElGr
	z20B0CGdYy721JdcJfLS6MpDUwaskYj1iYbVGzoLcqEXxQmRkj0t
X-Google-Smtp-Source: AGHT+IEORPWxgaU9VsAkekFiyGNzWmHyEcZ52yFJiGYOMyZlhMOslzX2Xu1u1mw/RWcqkaAqkvPlJg==
X-Received: by 2002:a05:6a21:6d9a:b0:1a9:8836:ae37 with SMTP id adf61e73a8af0-1b2f969bf66mr6030396637.12.1717864325619;
        Sat, 08 Jun 2024 09:32:05 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7043180d0e5sm321460b3a.99.2024.06.08.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 09:32:04 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski Rasmus Villemoes <"kuba@kernel.orglinux"@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] stddef: Allow attributes to be used when creating flex arrays
Date: Sun,  9 Jun 2024 01:26:49 +0900
Message-ID: <20240608163148.2141262-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240213234212.3766256-1-keescook@chromium.org>
References: <20240213234023.it.219-kees@kernel.org> <20240213234212.3766256-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Kees

I was looking to apply the __counted_by to the drivers/net/can
subtree, and a research on the DECLARE_FLEX_ARRAY brought me to this
patch.

I could not find it in any tree (tried Linus's tree and linux-next),
so I am not sure what is the status here (sorry if it was upstreamed
and if I just missed it).

While at it, and with several months of delays, here is my feedback.

On Tue, 13 Feb 2024 at 15:42:10, Kees Cook <keescook@chromium.org> wrote:
> With the coming support for the __counted_by struct member attribute,
> we will need a way to add such annotations to the places where
> DECLARE_FLEX_ARRAY() is used. Add an optional 3rd argument that can be
> used for including attributes in the flexible array definition.
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Keith Packard <keithp@keithp.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/stddef.h      |  6 +++---
>  include/uapi/linux/stddef.h | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index 929d67710cc5..176bfe8c0bd7 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -82,15 +82,15 @@ enum {
>  
>  /**
>   * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> - *

Nitpick: this line removal is not related to the patch and the other
documentation blocks in include/linux/stddef.h also have this empty
line. For consistency, better to keep.

>   * @TYPE: The type of each flexible array element
>   * @NAME: The name of the flexible array member
> + * @...: The list of member attributes to apply (optional)
>   *
>   * In order to have a flexible array member in a union or alone in a
>   * struct, it needs to be wrapped in an anonymous struct with at least 1
>   * named member, but that member can be empty.
>   */
> -#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
> -	__DECLARE_FLEX_ARRAY(TYPE, NAME)
> +#define DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
> +	__DECLARE_FLEX_ARRAY(TYPE, NAME, __VA_ARGS__)
>  
>  #endif
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 2ec6f35cda32..028aeec3d7f1 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -31,23 +31,23 @@
>  
>  #ifdef __cplusplus
>  /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
> -#define __DECLARE_FLEX_ARRAY(T, member)	\
> -	T member[0]
> +#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...)	\
> +	TYPE NAME[0] __VA_ARGS__
>  #else
>  /**
>   * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> - *

Same as above: no need to remove.

>   * @TYPE: The type of each flexible array element
>   * @NAME: The name of the flexible array member
> + * @...: The list of member attributes to apply (optional)
>   *
>   * In order to have a flexible array member in a union or alone in a
>   * struct, it needs to be wrapped in an anonymous struct with at least 1
>   * named member, but that member can be empty.
>   */
> -#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> +#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...)	\
>  	struct { \
>  		struct { } __empty_ ## NAME; \
> -		TYPE NAME[]; \
> +		TYPE NAME[] __VA_ARGS__; \
>  	}
>  #endif

How does this work?

If I take this example:

  struct foo {
         size_t union_size;
         union {
  		struct bar;
  		DECLARE_FLEX_ARRAY(u8, raw, __counted_by(union_size));
  	};
  };

it will expand to:

  struct foo {
         size_t union_size;
         union {
  		struct bar;
  		struct {
			struct { } __empty_raw;
			u8 raw[] __counted_by(union_size);
		};
  	};
  };

right?

Looking at clang documentation:

  The count field member must be within the same non-anonymous,
  enclosing struct as the flexible array member.

Ref: https://clang.llvm.org/docs/AttributeReference.html#counted-by

Here, the union_size and the flexible array member are in different
structures (struct foo and anonymous structure). It seems to me that
the prerequisites are not met. Am I missing something?

Yours sincerely,
Vincent Mailhol

