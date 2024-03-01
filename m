Return-Path: <netdev+bounces-76473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823A86DDE1
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB35E1F23F70
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B06A333;
	Fri,  1 Mar 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dV58ST0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DE6A32A
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284204; cv=none; b=aNHCL1f+am3xNLKGahwL7pR+USiOzypWn8LTqNrdlse5MnBWIMD1CKtUvd1v0oIyKxmvsQ0KHaAUcuRd2tEKGnBOunlRtNaWNvBYpvKNl8lCGlijO9vDngdywuRK2OUTmE85vGK0i+j3HKWEshuyo8T4tjpq2NJG+/jH9rtuKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284204; c=relaxed/simple;
	bh=mDeYp+/K2UzyizRtuI3W4E0SyYsHEQtnhLJ81m99uoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+Gygj9zkqVZzfCurxr86GTa8bYgfS6wXt5jFJ0lnegTf86Gr2XFK2GdapFNUpU0lohiREwes4ilNuTfT1USUuuqBsMcSxR8r7LN3SGb5XFVD4NdxM3hJKI34/h1WWGSewPNBZFwEh1cITG4voIkvZjZGG/eruhts3sEXFHDf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dV58ST0I; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so33635e9.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709284200; x=1709889000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/ANMr+3cEZ0ZNfgil/L+4To+nT1xIFH5lCy/naCOjA=;
        b=dV58ST0Icdi5amXIv94VWU5NSj+zzkGmaNd8ZUfVVws+y0iS4RP7nFbKN9HB3iWVam
         EX1vYP16Zb42DS5CWZTsx7xZ4eHOQtIDZmLwRIUCusHb5Jg14AxSJy1gI4xZVq4ZSq31
         zLSjy/sIeEsKP0rNpXmHxyIOGLUy5OOJAEBiBfWPNYBdlhIYG+I6hP6IlvSx8C49nyOs
         HjBlP8nE7MW+ptwShVPK8wuhjpWjeMBj0g0Vwg03hfkI5gHkPlTb2EgJmW2cD9uKZR5K
         zSj8wf0YzUuorJDjVAnJEYgzeqq/p6A1q5L8kQ2VBP18WCuxdxjD1+hHYmbuJQn1POYM
         CVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284200; x=1709889000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/ANMr+3cEZ0ZNfgil/L+4To+nT1xIFH5lCy/naCOjA=;
        b=FJLNeTN6wbm0rkCOUTMrHynG8Fc2Oty3QYeDGJHiriiTRXlrCydVK1X4Rc5bfdnJUY
         2fNzCVhkUZytZoEfXDNtTmY1FGdOJG29bErESLIttV7WNINFWKUebvRkZx87RR9aQsC0
         SitUtjSW/Ylpwmx0HyKk1X+YsP9AfI8izqTLq8jKHYEEhcdPIGttLDz6HA4S4Rgpc0qR
         /gtyrfL/1ZJ5fAHYoiRLG50GN8bysbm5k0RY4FZlG2kxsRRWLzR8a5jNUGl6ek0WRjEh
         xUBdzyAMyDLqvjaU6pI82AUmdDBzM+F00A+IhuogesIRvp2YRSb60Vke2KnsmbsoRlYQ
         EirA==
X-Forwarded-Encrypted: i=1; AJvYcCXocCPCLuLzec9ZRzUPkzyqno2NY1h+/iK4wB1B9hNLN365D8UP6iVu3FubtrhAnmgtaVGjCa/f1Ykr328kLtNZWimzcGMz
X-Gm-Message-State: AOJu0YyMrMYj96HQ5qvvAirMuPyo0G0w9S1myGExJTQXiTeYs0ooIJPG
	tVgPZJiQCtuhu1JL9tZIef+65KLy6zIB6r0RCGBRnUtQ/7/iV4fLTZR6Oz6cupaD6xyn7JeZRg+
	dRGeYaJzqOhEzLGOj1kYCpAVTGM4JuvXdqKJK
X-Google-Smtp-Source: AGHT+IG0r3zRJ6YjzCctr3gWX3Rox3vswBptriUgnXzxYzsyJh67YHrS1JihMP5dxjTnoPKebA9b7afZP3LHMY2ozrU=
X-Received: by 2002:a05:600c:3b20:b0:412:c810:ff9c with SMTP id
 m32-20020a05600c3b2000b00412c810ff9cmr48399wms.1.1709284200186; Fri, 01 Mar
 2024 01:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301121108.5d39e4f9@canb.auug.org.au>
In-Reply-To: <20240301121108.5d39e4f9@canb.auug.org.au>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 10:09:45 +0100
Message-ID: <CANn89iKpsHTQ9Zqz4cbCGOuj8sp5CCYGHe3Wvk2cyQL4HPADkw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:11=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> In file included from <command-line>:
> In function 'tcp_struct_check',
>     inlined from 'tcp_init' at net/ipv4/tcp.c:4700:2:
> include/linux/compiler_types.h:442:45: error: call to '__compiletime_asse=
rt_940' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct=
 tcp_sock, __cacheline_group_end__tcp_sock_write_rx) - offsetofend(struct t=
cp_sock, __cacheline_group_begin__tcp_sock_write_rx) > 99
>   442 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:423:25: note: in definition of macro '__co=
mpiletime_assert'
>   423 |                         prefix ## suffix();                      =
       \
>       |                         ^~~~~~
> include/linux/compiler_types.h:442:9: note: in expansion of macro '_compi=
letime_assert'
>   442 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime=
_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON=
_MSG'
>    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #cond=
ition)
>       |         ^~~~~~~~~~~~~~~~
> include/linux/cache.h:108:9: note: in expansion of macro 'BUILD_BUG_ON'
>   108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROU=
P) - \
>       |         ^~~~~~~~~~~~
> net/ipv4/tcp.c:4687:9: note: in expansion of macro 'CACHELINE_ASSERT_GROU=
P_SIZE'
>  4687 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_wri=
te_rx, 99);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   99123622050f ("tcp: remove some holes in struct tcp_sock")
>
> I have reverted that commit for today.
>

I have no idea. Maybe this arch has some unusual alignments on
u64/u32/u16 fields ?

The patch should not have changed tcp_sock_write_rx group...

My patch reduced tcp_sock_write_tx on x86_64 from 113 to 105 bytes but
I did not bother changing the assert,
because the assertion triggers if the size of the group is bigger than
the numerical value.

So I could have added the following, but really did not bother.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c82dc42f57c65df112f79080ff407cd98d11ce68..7e1b848398d04f2da2a91c3af97=
b1e2e3895b8ee
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4651,7 +4651,7 @@ static void __init tcp_struct_check(void)
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_tx, tsorted_sent_queue);
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_tx, highest_sack);
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_tx, ecn_flags);
-       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 113=
);
+       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 105=
);

        /* TXRX read-write hotpath cache lines */
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_txrx, pred_flags);

