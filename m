Return-Path: <netdev+bounces-148187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABB9E09E1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19908282AEE
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4672A1B8;
	Mon,  2 Dec 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asSf3Ayh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C51D63CA
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160538; cv=none; b=Uw8jeQ3AYr4AxxFVW5De4QEImJ/5SnL7oUR/WzIdHkd7T6xWhcQbCXK0dQYEf3/x2Hgw57fs4HA6N+AXndqyMeo8+kBdZeZUiLhpD7EuEluOCz6oh3ehyl6zJmQChkK0DF6Y4nHyBr/ZQKDpqDzJQgkTCOEykuXRUYwjydHFXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160538; c=relaxed/simple;
	bh=oA4h/pWuNzuIA53XuC2H0CS1AjE8LYq3vUvL0BHAu7o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mjDLoBSz4hg2arsUDSaWWn4aKgziIOWBusthPKfp243P++aqulmgdisF5Ydq+9AmY57AESewrYpV1b4nS2tczTa7mdxRvSndrRy4sWXkRske4VjasOaD+2/wySZZCIYs8DyUt7ASik7gtqIB4T4TPzpFDIxmWw29iisWAzdB7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asSf3Ayh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso41938545e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733160535; x=1733765335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da4GBTp8TcJ/LMSH22c3IAuZduc7mnbiMyj9O+lxw/c=;
        b=asSf3Ayhxm/FACXrwuS7hB417Ms1fLe4z42CcblnZuDHBQH+MzDhKqh0Vka74qW30d
         pnk14hB0SSNceF9dH1e6Z6ooAOhXcE5hb7pvCvAK6Nv7xMclJp5DkiogfdAdOW6an88b
         rTeYMClYAQJQnWEiMQX5I+VlQkJXhgoXInEOeUd/pmKq2/CewFSszTW+lHMhlJtTY4ka
         yAggC2lQKRtA9ftcmEt8kQvn9L6K0GQIyuynwzUBs5ptNOH3f8uzevrn2zWAnBQxhYAz
         t63qUgSkjABv72dU8F4p2Itb+2ghS4iHigpfv1oTFOtERfwh7hfJ5HAXO1wrujF1FpCE
         lofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160535; x=1733765335;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da4GBTp8TcJ/LMSH22c3IAuZduc7mnbiMyj9O+lxw/c=;
        b=ucrAdI5oziGJiJfvkCdVGz6iWTXqLU3CB29pQ88vJKNJAkAr2YiR3BFCZPCbPP1xZd
         pZAOJoSqbhnkh79SNOgcvMIUPUm5CEXFA9NI5s7K1ia6ckaX5EHnu906I/RhirYG4cqM
         37Ktd9O+6ckxbnP1j6q5QKHtbRiDUvxdxYlHClcDETraSYSLreQ7XE9l1LqSsu6v1hkE
         niVyy68DTgcf79uOhCUkErQYCwRRBAUHaqNbezOBQ3sA8aTRdygAZ9F522nqqZd5MvU7
         38nDpppe/iRlwBOKZL0MEVilk4Uv4z5f6mz18omBmQuz0Gi8e+v1IbovweAeL6S18jW+
         pnQw==
X-Gm-Message-State: AOJu0YxWxIydQ1NhWeAmWIHbvXSgdGXJRzUgH2vzVKm/wiA7QW541fES
	qs4+dsOlrrAKd/OfNy8IG8z2TlXUtWW0Tz2grUEjexTtJF1i9u8E
X-Gm-Gg: ASbGncswXIGIKLM231fIE2uNpZU8j7U29SDMc4bip/+40s5Y6EiyOHtfWerViojtchc
	9M497LezWrKP/0hxI4Dvnl7zScl0YCsAqXi7yRGkBtasWIpq89HdQ0qSpwGMgg2rxoyS9x1Iqz2
	oOem9PTUfkOv7rDbycsTjkleYjLmKxA/wV+QlXWiEqqM7qWqCxqPXt3X1PFmcxBFNT4APq2TJeE
	Pdmhftp0AvnMoLQDm8byRnKEd9QSfhq/ivxAE5oKQDhEybEF7Lndbwb4a3ZIpYUcFBgoZ45TESE
	U3HVOn5fOdTH6N1bbDSIvbFqIas/7och57LKyQ==
X-Google-Smtp-Source: AGHT+IHmrqHloyNjgttPN4DyrTQiTQo3gXnbXscerhCtKOjfU/UWHZOeX3PRkHbVKohT9C6ipobv1w==
X-Received: by 2002:a5d:5f4f:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385ecdfa4ddmr6133017f8f.33.1733160535313;
        Mon, 02 Dec 2024 09:28:55 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763aaesm189973065e9.14.2024.12.02.09.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:28:54 -0800 (PST)
Subject: Re: [PATCH net] ethtool: Fix access to uninitialized fields in set
 RXNFC command
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20241202164805.1637093-1-gal@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <41d7f809-a75c-6107-3698-796163b5ab3d@gmail.com>
Date: Mon, 2 Dec 2024 17:28:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202164805.1637093-1-gal@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/12/2024 16:48, Gal Pressman wrote:
> The check for non-zero ring with RSS is only relevant for
> ETHTOOL_SRXCLSRLINS command, in other cases the check tries to access
> memory which was not initialized by the userspace tool. Only perform the
> check in case of ETHTOOL_SRXCLSRLINS.
> 
> Without this patch, filter deletion (for example) could statistically
> result in a false error:
>   # ethtool --config-ntuple eth3 delete 484
>   rmgr: Cannot delete RX class rule: Invalid argument
>   Cannot delete classification rule
> 
> Fixes: 9e43ad7a1ede ("net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in")
> Link: https://lore.kernel.org/netdev/871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com/
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

