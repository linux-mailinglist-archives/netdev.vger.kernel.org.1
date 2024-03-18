Return-Path: <netdev+bounces-80467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5AC87EF11
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BD51F20FBC
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C655E45;
	Mon, 18 Mar 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UuKaQd/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2013A28B
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783517; cv=none; b=YkGQMSHX+npd0GESTN3zhl2DbuPhoTlAUAp9E6I2yr6TVsIbDBlavquz7YH/PQe7J6EwhkYVBFjHA5QZH4l2PMhUt+TDvoTvtAHVh+YtkviWVpZhH0h1rtQ9rsZxGQJrB2sDe/kTmIao7X97BxPjZp79II3mZ48tVyGpJ43nC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783517; c=relaxed/simple;
	bh=R76I21nWlclOcet2e0P90I1PHkxwCPo5keHk8owejo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJGwABwlOxGpbSDXy1GnzHAzxJdQc2j1zPeoXOSTk/lZpasBeCDJvW3l4avVDx06Yh45Wjh8v6xUmCK1MZYxt3P9QH0HIrViMDgoRSOx6TLUTd28vYgk7C4JyNRoNbljGoMKXvy22AM4YivAcZBPblphbaN5yG/T86BlZM702KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UuKaQd/k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd9568fc51so36155635ad.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710783514; x=1711388314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=texmG0Gw1zeNIT3HK3A5521t3H/aX3K5C6j7gLeepPE=;
        b=UuKaQd/kdUfqjFpdzStNEI14LWD6cUu+mlPELBj0uTovOm248wSiuF8z29fsIttms0
         3jK7x5fmUURJ7wCOknt21/mkCZ3wHtLtpde78PS6cjxFx9yKGXU42LOE2stFLBTd5i40
         iOetnjbZ81AcABVxnKR1StvGJXG2rQv3ZZRVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783514; x=1711388314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=texmG0Gw1zeNIT3HK3A5521t3H/aX3K5C6j7gLeepPE=;
        b=n3GH3UTu1YHqgIDcAJKCvOy4+KMzgb2gD7rWCsci+LWLqV0Jzh3wHo+gghrKZP1GcJ
         0wVKeY8WhPtKI87gNIaoVdBwrfwmmMD5bqOCWqG3wdCQPYM9hEBa9yfx3LRiqzeV+Md9
         h0mbgoVLjKQp72cMDSKYrd6L6dKShHU+obiR79rxMK1RMIpixt/CrR0eJpghgboSHQbm
         P4wT4ho9fS1OG1mK2BvMF+9xmPk7ov6mJh/yIzVaKK6LExvdll8yDdo+Us+JFfXPINV3
         iGWPIJRp0Xjm7B41cd4eeDD+AO/Kg5Xg6fMe6DOSEmwl0unJuYZfMGs4s4jQWcHFI7m8
         AHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeqEDdfkrRmtjgMU8+rr0Z85WJDZrnifNNieB3m2TogHa2xhBCHmRcb5DqLhMuyt7iAsmam1oq78Fnjx1jeFnoMeqqz/pk
X-Gm-Message-State: AOJu0YwJwLBksReak7Uu+x9J/4ITKlgxvrI8x3zMUbbAtVW7L/gWkb8Y
	BcwYvZzKvaLiblU4lHAqCjWPvMmybe6wlKXgVOYkjXdIZk1jCuCYv1mjLH0cOg==
X-Google-Smtp-Source: AGHT+IFwifvFDojSxhKBkKKqy3uuDnQSOhhO6SnmFZueyTL3hVRvKoeX4hiPXzD3uMyruoUadtwycA==
X-Received: by 2002:a17:902:e841:b0:1de:e9b5:bb54 with SMTP id t1-20020a170902e84100b001dee9b5bb54mr478461plg.34.1710783514163;
        Mon, 18 Mar 2024 10:38:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001dd7d66aa18sm9500656plo.67.2024.03.18.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:38:33 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:38:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 0/3] compiler_types: add
 Endianness-dependent __counted_by_{le,be}
Message-ID: <202403181037.C66CB5ABE@keescook>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>

On Mon, Mar 18, 2024 at 02:03:51PM +0100, Alexander Lobakin wrote:
> Some structures contain flexible arrays at the end and the counter for
> them, but the counter has explicit Endianness and thus __counted_by()
> can't be used directly.
> 
> To increase test coverage for potential problems without breaking
> anything, introduce __counted_by_{le,be} defined depending on platform's
> Endianness to either __counted_by() when applicable or noop otherwise.
> The first user will be virtchnl2.h from idpf just as example with 9 flex
> structures having Little Endian counters.

Yeah, okay, that makes good sense. It'll give us as much coverage as we
can get until the compilers gain "expression" support for the
'counted_by' attribute.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

