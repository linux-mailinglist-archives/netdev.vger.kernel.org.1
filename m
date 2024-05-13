Return-Path: <netdev+bounces-95845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B78C3A58
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A69E280E8E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12F145B18;
	Mon, 13 May 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaAz/ENJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6023E47E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715569421; cv=none; b=n86Whskpcof+RQKgfdJMJCCyDVXHszWjdliC/7yfhEG+bAhSzUc3m2yHRJAXsnJLzJFidamQWCTz90QKmCMdG1XwUbhNVZsKqt0lQvWU05hnryRjmeg0T//XLmBRfo8Xm0m9X+akEVEA3dYLkH7q8grPHfn2ruP/6yi1mSjEkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715569421; c=relaxed/simple;
	bh=z4NlVMZtR0r+DtTYPkbCuUFcxQnmejuMc8+xSsKlqFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoP3JtckDNJATLDLRgXF7UjohmdUDr5VQDmN5sipgBuyu/om8xqrOdfGjpQfCyBXfkNlpiLaEGBQaNhFEcVuC2gAYOCNGIsE9wuSF6WyrTeJYwPvgChhz3oQIcxQXj4tLYpkWPpnq/Ma2W1CoKb8W+IRijy3kRKppVQZ+bbg53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TaAz/ENJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23f5a31d948so2749555fac.0
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715569419; x=1716174219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzBJEORmly2uweAvFf1l8zuxXIyjPhUuwee5HZnj+NQ=;
        b=TaAz/ENJRmk2nXOWjPkrKvqSHiD+1amGYqc9jImroruKtcSZhetmkp/p8WRydH4e1c
         qRkmec0KhfxkupyvIKJR7oc0GGOjy7YTPKTkNHKaXNvjVI5gjtXPSJ8Zz+5uxdTrEOM7
         Hr7F5R3d8A3z72lkUJnCe4iN4gYcXs0+KhOtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715569419; x=1716174219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzBJEORmly2uweAvFf1l8zuxXIyjPhUuwee5HZnj+NQ=;
        b=EiCi+peJHXNlsRU1816kia66MxsUZLI3SZ5Ct0ApiysjpMQhwr8lcW/+dzDsZMS2Zr
         FawCUSnqmWCzxsLjeDcMeCLbg/xi/s6rFeMBvi1KiE7Ht6bTM9mqr6WHnRzibw1jbo9I
         yzVFQS96kMje5K42yYV780zNEGaHUwUHiQ1k6kCydXZxyDs0c8CiWIcoWQdDPYgTtFHA
         XG2dpoaht6SbVMFHJl8KoyBRblMgkp57Iz5aNmyCsBCyzHMGaTtSVK5WELk6gndm4miS
         wVC/DAqXqLPmNh+p4s7gSPn62QCg6JUOB/f9c378312hff7SeYQnHeq3KsN6KyZPc+xk
         538A==
X-Forwarded-Encrypted: i=1; AJvYcCW0uRtdoqBqYVoom36dBUWzGfTHo4Zmd0OBuZQ+H4d/+MnHrHPKEu7Tfo6tAsnB76IkMXuk9R6t2KTfmnwCZWX7v7f4zDbX
X-Gm-Message-State: AOJu0Yw/p07mcqtvZG9zPTfW4fqE5Vp6hoW8ro6DFnbObIQTFuwp4w+3
	o6Ga6KRyekas8gcdoMegezKrHGPIThsY16tWFCN9/ZWMn6MO2mMuoBQNyCAzPQ==
X-Google-Smtp-Source: AGHT+IGLWGypu7OaOGynSM5xuNyLMM/e8nAmPw78+sRaeDRTGamx3zP5noERhX/KkAF69EuemkT4TQ==
X-Received: by 2002:a05:6870:b6a7:b0:23e:6d9a:8f45 with SMTP id 586e51a60fabf-24172f79503mr10911205fac.48.1715569419606;
        Sun, 12 May 2024 20:03:39 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b30341sm6317982b3a.208.2024.05.12.20.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 20:03:39 -0700 (PDT)
Date: Sun, 12 May 2024 20:03:38 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] tty: rfcomm: prefer struct_size over open coded
 arithmetic
Message-ID: <202405121959.50F6DDA@keescook>
References: <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sun, May 12, 2024 at 01:17:24PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
> this structure ends in a flexible array:
> 
> struct rfcomm_dev_list_req {
> 	[...]
> 	struct   rfcomm_dev_info dev_info[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc() and copy_to_user() functions.
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> In this case, it is important to note that the logic needs a little
> refactoring to ensure that the "dev_num" member is initialized before
> the first access to the flex array. Specifically, add the assignment
> before the list_for_each_entry() loop.
> 
> Also remove the "size" variable as it is no longer needed and refactor
> the list_for_each_entry() loop to use di[n] instead of (di + n).
> 
> This way, the code is more readable, idiomatic and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

> [...]
> -		bacpy(&(di + n)->src, &dev->src);
> -		bacpy(&(di + n)->dst, &dev->dst);
> +		bacpy(&di[n].src, &dev->src);
> +		bacpy(&di[n].dst, &dev->dst);

Not an issue with your patch, but this helper is really pointless in the
Bluetooth tree:

static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
{
        memcpy(dst, src, sizeof(bdaddr_t));
}

So the above could just be:

		di[n].src = dev->src;
		di[n].dst = dev->dst;

:P

-Kees

-- 
Kees Cook

