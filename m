Return-Path: <netdev+bounces-128258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4C978C36
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 02:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE341F23D69
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3B4414;
	Sat, 14 Sep 2024 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBvmLCVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D5440C
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274080; cv=none; b=n9cPwOGPmVHVsNCzUEgo4ARooxCxShohStDhgwjYZYv4PEMdTzYV6vaBcDVVTn1wAZ6on/t1U0KQgjxk311cbvSEHcSaWq8uOYgtH1h7eLWQ5sWYqk9+fsP0CfNT9lEnFFZo/4VGNN6PCLmasklzpYQSAVSv2iie999enJy3D7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274080; c=relaxed/simple;
	bh=mzHLQrqSeQieg3UjlAKUaXdRI6j+XnCY5vAU6UlYWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7q928OVfdET89xOv+8fExF6Ku15Ab3rasXqcoU3abHLrxsLjFIatoE5Gh0MGCAB7d4vk7/Ef6haB5pY+S6aUONG06gAnXy+uv+GDxj6atjnNQ7DOA/ly+AonKD96ORWyTzGV2EsDvYjBXbtoPoE8Iy/ymqQGhNDvHOLyFX8bDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBvmLCVK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc47abc040so23820725ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 17:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726274078; x=1726878878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKNPb/025srgmjPIqCQe9c2UaJSrYB8BynH4jjtFvO0=;
        b=HBvmLCVKKtbL6E+zNovFXrj/UJkoD0qGkPYdoeHWK3TVii6SsBfw6YlCmzI2dsFfiA
         YodGXBQDlDq5xvvKKQ0uxiyC40+eLzQUUd6RpMUWXD9hIcM3+l6IDw0GzF09xQHc1pyC
         +TYcKgpJ7ZhlPKrTpwYVVsd12CUac7L3RujWyhBg8u5lTO8n9yFIFcFoVdxu0oCP0GSz
         ESxYEBissBu1UETF2mL60WSrG+MlgkW67aWuPKBQ93uBGyfs5XZBNlH+GUxB2cQBBEUq
         ezbBB9aUcqYfDNmHRKyWeJUxJzWD6VkRMs/a/at62RBNBX0rTnbpS0APoZkhIN0ll8Zi
         IqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726274078; x=1726878878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKNPb/025srgmjPIqCQe9c2UaJSrYB8BynH4jjtFvO0=;
        b=aP4hFiwu5Gtu79y19w9voMv9u4CjctuvwEqG43zlSwafWP7algQyyYt4HFVPhigaMO
         Fm9wKNOezoH5vVyCMdjvknJmkbKqET8HcdxQ8TAa7YxYLZdpDxWEwOintLsWy5wFmzzS
         1y88NL0OUfbahKE/FUogbFkfDiTsqxZlxFp7Pl2fsAB3ZxwHkwJJ6hl0t7AUKeHa9xQq
         I3YucyshfiXOy2meE6O7cZklV4GTBBFYMNJ+KbE9y9eOBUSIDih1KAUHKpnU/sXt1S/U
         W/Hs5OwnpctF2iM2EDPUNQKRxg+X+3ytbO3ts/+DLUA1twQN3Kgs1nYBWPhIA02F/F0T
         jKJA==
X-Forwarded-Encrypted: i=1; AJvYcCX29iStJsfft/gkcvc1f9iJdTov4oRzzSG3gUA6dLo0mocRgyfz+M5tybIuy/3hftISAqVkg6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2956PAu8I7va+7tjVhnoHX8fS7SZyCzdsdZH8uk6Sc5tXQ6NH
	iR8n7NmDg9aRwVAjT/zD5Q8QV9cEmbdxRknBhbrFFS6wKxvWMZZirwMmWIXx
X-Google-Smtp-Source: AGHT+IHB0vVAfpGvoUbUUvR1MJiOCauzkmdjZxNwF7a59uTEd7FV9PuqR+IAJfdqmhK2IUUKxsXyQA==
X-Received: by 2002:a17:902:e742:b0:206:a3a9:197c with SMTP id d9443c01a7336-2076e43d052mr115342455ad.49.1726274077793;
        Fri, 13 Sep 2024 17:34:37 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:97be:e4c7:7fc1:f125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947130bdsm1770485ad.231.2024.09.13.17.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:34:36 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:34:35 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH RFC net] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
Message-ID: <ZuTaGwM/8bTdWx1h@pop-os.localdomain>
References: <20240905064257.3870271-1-dmantipov@yandex.ru>
 <Zt3up5aOcu5icAUr@pop-os.localdomain>
 <5d23bd86-150f-40a3-ab43-a468b3133bc4@yandex.ru>
 <ZuEdeDBHKj1q9NlV@pop-os.localdomain>
 <1ae54555-0998-4c76-bbb3-60e9746f9688@yandex.ru>
 <ZuHJQitSaAYFRFNB@pop-os.localdomain>
 <9c8146a5-c7fc-40ae-81bb-37a2c12c2384@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8146a5-c7fc-40ae-81bb-37a2c12c2384@yandex.ru>

On Thu, Sep 12, 2024 at 06:59:39PM +0300, Dmitry Antipov wrote:
> On 9/11/24 7:45 PM, Cong Wang wrote:
> 
> > I guess you totally misunderstand my point. As a significant sockmap
> > contributor, I am certainly aware of sockmap users. My point is that I
> > needed to narrow down the problem to CONFIG_RDS when I was debugging it.
> 
> I've narrowed down the problem to possible race condition between two
> functions. "Narrowing down" the problem to a 17.5Kloc-sized subsystem
> is not too helpful.

Narrowing down from more 30 millions lines of code to 17.5K is already a huge
win to me, maybe not for you. :)

> 
> > So, please let me know if you can still reproduce this after disabling
> > CONFIG_RDS, because I could not reproduce it any more. If you can,
> > please kindly share the stack trace without rds_* functions.
> 
> Yes, this issue requires CONFIG_RDS and CONFIG_RDS_TCP to reproduce. But
> syzbot reproducer I'm working with doesn't create RDS sockets explicitly
> (with 'socket(AF_RDS, ..., ...)' or so). When two options above are enabled,
> the default network namespace has special kernel-space socket which is
> created in 'rds_tcp_listen_init()' and (if my understanding of the namespaces
> is correct) may be inherited with 'unshare(CLONE_NEWNET)'. So just enabling
> these two options makes the kernel vulnerable.

Thanks for confirming it.

I did notice the RDS kernel socket, but, without my patch, we can still
use sockops to hook TCP socket under the RDS socket and add it to a
sockmap, hence the conflict of sock->sk->sk_user_data.

My patch basically prevents such TCP socket under RDS socket from being
added to any sockmap.

> 
> So I'm still gently asking you to check whether there is a race condition
> I've talked about. Hopefully this shouldn't be too hard for a significant
> sockmap contributor.

If you can kindly explain why this race condition is not related to RDS
despite the fact it only happens with CONFIG_RDS enabled, I'd happy to
review it. Otherwise, I feel like you may head to a wrong direction.

Thanks.

