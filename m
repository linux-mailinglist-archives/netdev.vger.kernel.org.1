Return-Path: <netdev+bounces-156577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17BA0716B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75564188622C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099A2153D9;
	Thu,  9 Jan 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dr7K1FuO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D042153D1
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414698; cv=none; b=CwfW8Ohlk3acyk+6hyL55U/YQkLZGaUuv8IbdDdEdqJjnlQLZscHxBJJfrwXBQKWAByUruMPvV9FzUKXlJPLykgLaISyfCDcL1eXfOiAkuc05fIpv/QOUafQuDwIo7PD59HR31qG3ucOr2w+ufd3xeztqGopNqDAj9EdzZKOzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414698; c=relaxed/simple;
	bh=L5i8L8vWWYkt0gtsjdsyrb1GPxinM310z9jA2KtCYN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx9Hod7kwte9riqr6m8gaFpAPhPu3eDVUVhqhkkBRROOcxTXFwKpYPChnTOUkhXYY7rWZ9DhA9pe1WdbnVCRsxlCqSS12cXJAeC9DoG4+RRYqsHs3Dt8li9lPum5vQdSe++I8e+EUvU2C9NEtH5WB3b87c383ikX8wgnZitjn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dr7K1FuO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso1060205e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1736414695; x=1737019495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6fwwdpIdVMnI2XF+i5+tXNgS/k7VPLfX7Im7tSV5FSU=;
        b=dr7K1FuOeP7o4jbX95OzPmN4xLx3XjwiTCHUe8dVk/+GNPTLYgA9xV5qQzolt38vCR
         P+uB0TtvJjWvNB53bFi6BcN3I6ENqv6FmIy7tRKkMAlvDfqgio2n6F5FOVcl4Xl5T6Em
         mDXpWpxO7m631UgkZoHkCPRQoTEXNYi9nFuZZgjsYWBVMLCmh3eNdaBbxkCcF1utAawE
         Rz3zmrIU5coR6nugpB/UxXztojv+ROh/lEUdOCyE67xKZYxuEY+tB9glEAt9z/YxNu8w
         uEY0bCQy0cyPM9YyaXfv8cl7P19Km3O10OqCwozi1SEVf623EXJ9plwUbQqh3AuSyILi
         ZZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736414695; x=1737019495;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fwwdpIdVMnI2XF+i5+tXNgS/k7VPLfX7Im7tSV5FSU=;
        b=B5L3dAJwQTULZak8LHsopjjRdE+qvTcXzO+VngYWZYkFic713kCS2nINg06imJF/CG
         gyJEfJe8ehVLjL8WOtoIk6rFHDfUh86boVIE4jYk0bguOJFnVyvXarNpCpKqfkP7v+Zp
         SoQGFrSaOY7kw+ghLB0xMnJONBnqL4IsXwefPqOSZ+SB38c/9xCOh7JLset0tKvsIlND
         R0eV15VNraGosVKNkI9acDGvRd0RxClOmQVPu3WPbgpmN5zXowrl7Bwlt8bLbVIWP3bV
         Ewnbe2rRDMm9ke8kUh4YWMLRvVYxYonQvASYp1gfukXiKw9b+9WLggnvv7M1DFJnS1/3
         InpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC2saTNDiEc34S5pDCJ8EcuEVx9aX5F4ahWUNkdueHMouebsxKuY0DESDQsdHS5FmMjJ+skRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFbluP2wd1jg2E7nZ15ed9IjsoQgL0R1LR63Rg3owzgxnfjAJ
	NMfz88GvT2PSbPG9b+bd31V5F4US8rESbuogQMpVPtSc2D5pySBLoEIF+64FylGAcEXdcVT39CA
	7
X-Gm-Gg: ASbGnctLVKp2M9zEZCFDeI0b19gP39O87WogWz5eyIAB6AfSNnUKX356pGq8rD8nwjR
	wFfWLu1iuJuFCAZnrpFns51U3LBFk/bMhWifoIr306r2K091MSkrpd2brxA9iIWJxaU93X71fWI
	MdkQKfOelMJXQkKx12qcZiBK3Fy0sdd3nVTz7PK+o4RkV1jwNSpP1mYtQ3+GI2vjlfu17f0GgIU
	WdbSIAc3Nn3QlDPm4w/j+xxbHZw0FhSoljQa5OckEsrM9mfJOoQoJFovQ7D+AH3lzzsGc5bKcEp
	NnZc7e1VbaK52nQlUt2yc25qXJKCsCIlVQ==
X-Google-Smtp-Source: AGHT+IF567dxiBb/07iXMh69b5WH52czFz7cR2N65fQFUZV1SxcNFwyyB0gXKeKlwZX0jZJH6XqZLw==
X-Received: by 2002:a05:600c:1d07:b0:436:1902:23b5 with SMTP id 5b1f17b1804b1-436e26f4abbmr20840175e9.4.1736414695099;
        Thu, 09 Jan 2025 01:24:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:e7da:5a6d:1e09:2e14? ([2a01:e0a:b41:c160:e7da:5a6d:1e09:2e14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6336sm48679115e9.8.2025.01.09.01.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:24:54 -0800 (PST)
Message-ID: <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
Date: Thu, 9 Jan 2025 10:24:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] selinux: map RTM_DELNSID to nlmsg_write
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Paul Moore <paul@paul-moore.com>
Cc: "David S . Miller" <davem@davemloft.net>, selinux@vger.kernel.org,
 netdev <netdev@vger.kernel.org>
References: <20250108231554.3634987-1-tweek@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250108231554.3634987-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/01/2025 à 00:15, Thiébaud Weksteen a écrit :
> The mapping for RTM_DELNSID was added in commit 387f989a60db
> ("selinux/nlmsg: add RTM_GETNSID"). While this message type is not
> expected from userspace, other RTM_DEL* types are mapped to the more
> restrictive nlmsg_write permission. Move RTM_DELNSID to nlmsg_write in
> case the implementation is changed in the future.
Frankly, I don't think this will ever change. It's not a problem of implementing
the delete command, it's conceptually no sense.

I don't see why the DEL should be restricted in any way.


Regards,
Nicolas

> 
> Fixes: 387f989a60db ("selinux/nlmsg: add RTM_GETNSID")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  security/selinux/nlmsgtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 3a95986b134f..f97e75301018 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -71,7 +71,7 @@ static const struct nlmsg_perm nlmsg_route_perms[] = {
>  	{ RTM_DELMDB, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>  	{ RTM_GETMDB, NETLINK_ROUTE_SOCKET__NLMSG_READ },
>  	{ RTM_NEWNSID, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> -	{ RTM_DELNSID, NETLINK_ROUTE_SOCKET__NLMSG_READ },
> +	{ RTM_DELNSID, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>  	{ RTM_GETNSID, NETLINK_ROUTE_SOCKET__NLMSG_READ },
>  	{ RTM_NEWSTATS, NETLINK_ROUTE_SOCKET__NLMSG_READ },
>  	{ RTM_GETSTATS, NETLINK_ROUTE_SOCKET__NLMSG_READ },


