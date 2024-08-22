Return-Path: <netdev+bounces-120899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBE095B281
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A5F281DDE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFD16C854;
	Thu, 22 Aug 2024 10:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9D1CF8B;
	Thu, 22 Aug 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320891; cv=none; b=MxdZb5X8+suy3BkmIa6WhyFfYgPjXS3LEifw98v1lTwaVls3TCxBomDzbjpNRBMQuVhn0S9Dm0TUoFIQABsuBoZXUI68nDRaS/kCRfO3HySBTW52r2AE2EGeUx9BgcJ6EHkkseg1rY2bV43P8l1PMOAMDzkQzzdmQH7QaYNxH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320891; c=relaxed/simple;
	bh=7ZEa66fyURuV1fbnNHt5mKuuWKxBlIhyOPWTYv3E1xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPpXpRpyFm/JcxzFzwUjEiKdocw2TRf1Q4Z5oJtKuq/0mLoVUXvBSzWWjPSToRyWrQIIGKtl2yhNkw0k+0VE/sacFdMhzcwv1awDNvak+NTjpYPqXOBvOHmxGAyrK461ekdMmPReB4oNFHpIv6pNOkihLgVgRaKATU2Oz7OQH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a868d7f92feso88481966b.2;
        Thu, 22 Aug 2024 03:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320888; x=1724925688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o23hpveZ+o8bf108WnazpxlGoC+Tu+8Galxf6dwbYs4=;
        b=LqLPnfPBAGhKgWhjI6oMd6R/03gdvGdWeNRYf5TfpNpYc6VN7vriQt/u2DboVdA80t
         +638h8JimDZtjnzArWyoRQhBleZvahp3LgtLvsbt48z3DGjaBiB1wBjIx5FLSkc/Q+L8
         49zRG9k+CFZ0NKOENZl2RiPcibKU/BQMNLxIvVHwLhEi5AOJEo5vioMk6hY+fWd7Bltm
         q9fHBcswW4z5dtJKRk1/08/8W6nac8B1iSPc3NHhHew5q9tZqnSFWYXRZzBR2jaMGisF
         BISy/6iTZ9i12iCk1tt6wXgsPLfkpV4nGUQSRxLCO8QfRrC5J7oyAfZ6RWHF6sP/KkaI
         rX8A==
X-Forwarded-Encrypted: i=1; AJvYcCUo1t9JWdi4wd89Ef30bAlPxo5MjGEOAdAK+jdV4FUT/TVuEiQni8ZUqH/ipyWakAc3OIlOLklE@vger.kernel.org, AJvYcCWQp6EBB7OFJHC7fSfPrw0CnNFOZ1kKq8eet2pWQFcTZ5s5YX71KwCmFi/bNv/bCIlSVjfBIBB5qB6t5sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgjc6cygr7EnT1uBMMH3lqrVzc2R2MBf3tmv6epkdZUHz4Xjb
	ig9L+KwEdWQi4ZbxELe92mlzorYGC3WvxqX8dhP26o+MtPbb8V1q8chs4A==
X-Google-Smtp-Source: AGHT+IEAPkOprgDKnw1tUB0SdWgKACTGrgO6BJHQBoZZlaKbu/YVCFHPRJ2eSRSUB1TOiuTawXP70g==
X-Received: by 2002:a17:907:1c90:b0:a86:7f6e:5fe4 with SMTP id a640c23a62f3a-a8691cba654mr137436266b.67.1724320887857;
        Thu, 22 Aug 2024 03:01:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862b6sm95776566b.170.2024.08.22.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:01:27 -0700 (PDT)
Date: Thu, 22 Aug 2024 03:01:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] netconsole: pr_err() when netpoll_setup
 fails
Message-ID: <ZscMdc6wmUGlusM4@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
 <20240819103616.2260006-3-leitao@debian.org>
 <20240820162409.62a222a8@kernel.org>
 <ZsWoUzyK5du9Ffl+@gmail.com>
 <20240821155404.5fc89ff6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821155404.5fc89ff6@kernel.org>

Hello Jakub,

On Wed, Aug 21, 2024 at 03:54:04PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Aug 2024 01:41:55 -0700 Breno Leitao wrote:

> > Do you think this is useless?
> 
> I think it's better to push up more precise message into the fail sites.

Makese sense, I will remove it, and add the failing message once we
refactor ndo_netpoll_setup() callbacks.

> > Would it be better if the hot path just get one of the skbs from the
> > pool, and refill it in a workqueue? If the skb_poll() is empty, then
> > alloc_skb(len, GFP_ATOMIC) !?
> 
> Yeah, that seems a bit odd. If you can't find anything in the history
> that would explain this design - refactoring SG.

Thanks. I will add it to my todo list.

> > 2) Report statistic back from netpoll_send_udp(). netpoll_send_skb()
> > return values are being discarded, so, it is hard to know if the packet
> > was transmitted or got something as NET_XMIT_DROP, NETDEV_TX_BUSY,
> > NETDEV_TX_OK.
> > 
> > It is unclear where this should be reported two. Maybe a configfs entry?
> 
> Also sounds good. We don't use configfs much in networking so IDK if
> it's okay to use it for stats. But no other obviously better place
> comes to mind for me.

Exactly, configfs seems a bit weird, but, at the same time, I don't have
a better idea. Let me send a patch for this one, and we can continue the
discussion over there.

Thanks
--breno

