Return-Path: <netdev+bounces-178837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68CA79241
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4873B445D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8C13212A;
	Wed,  2 Apr 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL89OE2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81E10F9
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608164; cv=none; b=nMTsqfUdW2uaHJZnUk1h+roelQ9UC0Dl3gDIxM2fZDnX69jq+4/wtpxaG7Ndz1pfdG1W3NtU3CpkFqgAXB2YV9fUR/8ruEn3EUbYKosQt0FEwOgi2AaPDjD4yQPAv22SpuSQaIW/lp0saF473Ga3alvJzkhpuml7iZQYO7Pk7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608164; c=relaxed/simple;
	bh=oqrkm42t++URKJgAKKelv+Vj09AHP5jIOHcUvpYk33c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVlZGpv6pVMkTB8RHybZ8WEp4C4sgXRyu3nI2rrcH9sOGcSWsCSn9siHaanj2AIj4sMTRXKclw4OUshcnwgUFfbUoy4G+ljTROHWT3RUY1LKsDyOLWBpvg4L2UEODHeN7I3ob8PkbewG9J1+QPothfNiOujqYeL54VTf0fQpMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL89OE2W; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso1968790a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743608161; x=1744212961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pJI+ESNGQdKe+KqOIgs/iupDTsG/43wPhR71UvgDZE=;
        b=PL89OE2WfkNtpni2lBTYNcX9JC3B+taSra76HNmjA19f8AXrOSAcRolLE9oidx4mHu
         r0kGS83SQW4MN+DTc8F9CQ5wx1gorRlzENO7n7Nj9rg8auQKx0W32tnfBJi/DMJHU9cN
         FApI8sIo85g3pQ3CdJj/8li8cS4UJW3O7TLj6gNNOJwT1QQhEya5lC9OsUbBoCzFqLuf
         H1BmuAnscp3Q26LC7fpwLxnzaYcZfH60smQj4BOW41VniIsvVl6ciiwu+B0hNt2VmOzm
         am5T4AMZRHdw43id11FxvEPGG3Hec1GFCjP8f7zerDbbqVWjbJX9SQgLNptbdMRzuRx3
         PxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608161; x=1744212961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pJI+ESNGQdKe+KqOIgs/iupDTsG/43wPhR71UvgDZE=;
        b=uZGrxuO+Y1DTW1jK/o0wc4gBszq1+cRq9MCxAG7DfYwEsqJzlGLayiw8hnA7//DvXb
         gEKETNwVoapuT0fwFcq0A/K6UGBJ3aP6UEd3kJXQ+/ABiaqeWWeZsiuJftn1JOyxbpRr
         WicOrJb/cob73xF+XulbtoZu0ig6AwSU38iJiwZTD7nonwjvnpzBUdKCspJ7pCJvrkbI
         pjW/JsrfxwSxa1CHBBtgUVkGkdRNqakVPlDa68MV83KWWFdolqgYqGI5AjsXmhYAJitP
         2ADRPLHqf8v6vQQB1tksb/CdCR77SH3O1s2Zuc/FuYunG0+xcR/HhKytTuGbb6btTw7b
         njVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkCDu8mzVJELA0A7v4WvTyloUGPeAcuJmad77MKwG9IySFQ9AZwu/N/MDCilqh13k3248YjiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BzLxcirNkQTg3e+hF1wir1RB4BbJcKqcMSsBYpm6LOxTIdme
	0av1Z8DHCb+NA6PfZHWMxpmiGkRMqL/p21BRWJx/pgyqj0oa5f156AdaEb6xJKlJqv2XatbG3nH
	FYXweLZmmuYKSm0inr41KaXD88kU=
X-Gm-Gg: ASbGncubEmVjcoQGL9h93d79oPreC/CDEvak/hUZyuifIEuk4CPhKDNZt7GNhxVVCQ1
	wWZ/5uX4px383D/nsoigIjSASAqEdHqROLVhUzApXmu4VHaqisrQX9JCW6jwTXPQMIs3Fzq3f4F
	2JM1jGVeJItPAAQscSpXuiiLkAQyM=
X-Google-Smtp-Source: AGHT+IHRk1DwQHPB5vNSR0XcnqQIdK4TBPFfGZ4t83P5o9HseoO4XEcOHYjdrw4IIvsvxYPQJVUyBG48ULTjx7KvVN0=
X-Received: by 2002:a05:6402:24a1:b0:5ee:498:76e6 with SMTP id
 4fb4d7f45d1cf-5f060373363mr2489320a12.17.1743608161012; Wed, 02 Apr 2025
 08:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331194201.2026422-1-kuba@kernel.org>
In-Reply-To: <20250331194201.2026422-1-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 3 Apr 2025 00:35:47 +0900
X-Gm-Features: AQ5f1JovRhkajo0JvPARUjOgWdDvdbIJzfgGTQIeUmeKq4C1YrX0XvwURJHWjkw
Message-ID: <CAMArcTWYSOZGKi1C8YTzSB7XnYb6xKLdKGF8nujX8Y0E3vRg3Q@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net: make memory provider install / close paths
 more common
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	asml.silence@gmail.com, almasrymina@google.com, dw@davidwei.uk, 
	sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 4:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for this fix!

> We seem to be fixing bugs in config path for devmem which also exist
> in the io_uring ZC path. Let's try to make the two paths more common,
> otherwise this is bound to keep happening.
>
> Found by code inspection and compile tested only.

I tested this patchset with my RFC[1].
This works well, and I can't see any splat by kmemleak, lockdep, etc.

[1]https://lore.kernel.org/netdev/20250331114729.594603-1-ap420073@gmail.co=
m/

Thanks a lot!
Taehee Yoo

>
> Jakub Kicinski (2):
>   net: move mp dev config validation to __net_mp_open_rxq()
>   net: avoid false positive warnings in __net_mp_close_rxq()
>
>  include/net/page_pool/memory_provider.h |  6 +++
>  net/core/devmem.c                       | 64 ++++++------------------
>  net/core/netdev-genl.c                  |  6 ---
>  net/core/netdev_rx_queue.c              | 66 ++++++++++++++++++-------
>  4 files changed, 69 insertions(+), 73 deletions(-)
>
> --
> 2.49.0
>

