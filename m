Return-Path: <netdev+bounces-55372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA180AAA8
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A792819F5
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F839857;
	Fri,  8 Dec 2023 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GiY1k/0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53825199C
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:23:02 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce7632b032so1614414b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056182; x=1702660982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXDom1pGgFzD7z60+nX5wKE72JYAG4paS5sk2JCKg8=;
        b=GiY1k/0deCp31KIS/rscp6m71yTNYUEL+kB1zQ9qcDADBj76CBBvx96QLXr4UQf3Nf
         OYdJGf3XPP7YZoJg1Y2dC9/qVCN1IkX0g2Hy5/Ly98HxRGmVzHiV8Jv+CrND1k4IBlBo
         +AGAJa6nLkIv8JFMTzIl0elnYLMdooCku0EdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056182; x=1702660982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNXDom1pGgFzD7z60+nX5wKE72JYAG4paS5sk2JCKg8=;
        b=FJPfdXTJi2f7ZS85F3gxbpReQyHVxkiqrLyxQFIoYNVzmf1UWEzr6rqMDPZbc/jv5X
         yiEzmkZNx+lrvzAlCsdk31Tb/NxbMY9GfzM9yVnjECKVVZ7y0p47pFYwhxSLCA6UsHXb
         AvAQ1/qY9KkprmWRuQqNAZLUXQi/PTGp6UJenZU+QBE63OXNgvukX69GdFBgPevcukFo
         Uu3+pNPcugzGwK/NN5GSdjXF+0PgybUziguDsTaDys+3tLR8yyiZM2NhP6UIMtQfCs7N
         7hRhMjleYTvXzX5RCvxrwRM8HbCjSUB7hyX7UrBLw6gK7f4YaI9Q/T777PVy82zM/YWk
         gTlQ==
X-Gm-Message-State: AOJu0Yz4pOumufUn6uDpcXM3KmOQJ7vYnPKbfMIQh00HfKWgiwTxFk5i
	D25sZzQSV+HSR0TMIiY3ujLTniiF3QHsKFwNroQ=
X-Google-Smtp-Source: AGHT+IF0odaLvAeilH7K2WI0rkMDi0C9smclmU3oIrDkxldyXyKpbjGkUJWAwcvrZUO929m23SwWqw==
X-Received: by 2002:a05:6a00:1a8f:b0:6ce:50b4:a21 with SMTP id e15-20020a056a001a8f00b006ce50b40a21mr321026pfv.27.1702056181771;
        Fri, 08 Dec 2023 09:23:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00098300b006ce7fb8f59csm1837731pfg.32.2023.12.08.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:23:00 -0800 (PST)
Date: Fri, 8 Dec 2023 09:22:55 -0800
From: Kees Cook <keescook@chromium.org>
To: justinstitt@google.com
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202312080922.881A1515F3@keescook>
References: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>

On Thu, Dec 07, 2023 at 09:34:42PM +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> host_info allocation is done in ena_com_allocate_host_info() via
> dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq().
> 
> However zero initialization of the destination doesn't matter in this case,
> because strscpy() guarantees a NULL termination.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this reads much better.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

