Return-Path: <netdev+bounces-190860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C9AB91ED
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4B6A07526
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F451FDE31;
	Thu, 15 May 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQekBLlj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FE1922C4
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345701; cv=none; b=MVAPFfNW3JvU7+2FzL0XL4MXuGaTHUREKRAS/p6vzMBR6hHQqXkNTVV0C89rmzYu/JjfLR05iGVmMS8NolYqvPGVKgxW0UZ5WRNWYPvWz5eJN0s3bDR5k3Fkf7KIVvqBJ59mkzEf/40hEZ5Q+dlz49zf7VMguH954eyU60iRikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345701; c=relaxed/simple;
	bh=jmQq/z9h9b1PvDCEluUbK/8XOEKy1xeSiKMRrd6oa88=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CKgc/haeFJjLzvQ0gh8rqxWFDjrdIE10WHPheucaBqTaVvsw2mw8ObLTjJDWOyeSKlrKOhCCwHnvpq4S4DaXtIOrYqb/Ws/U/9O0W0b/70XpNn9ns5vsFE46l9mwfY44EcG9QhFuPgl2AYf++cxSJTCf49fmIDLUKETBM9rf3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQekBLlj; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so14109196d6.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747345699; x=1747950499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPyfukHzeKvRuexMUIpmQP5/LBWxLbFWKGDAGXjV/5o=;
        b=DQekBLljwb7z52a6nlhwyvcBSkUxrIkXLk0VxSUU5DCXTmroKfPHA0rb4eEzPf/LuZ
         7IgHEvKCNj4Pik0becyIEOOHXR/7hZQMi6uuoDkg8+yx7i4sH1nJf0HX7Yqy4xuu1iYF
         FKPmc6SrShJl+FppvQm21P4Z8VqK9Ur8t3gw161JPX6IjuyT7DbYmBv+Y36JqBLuHpMs
         D5SiKtBoAliPyNIC29FgRuTkE3/CSWTpnWO0U9bD9hcwH0OsgN5LBUsZioYNU0nXfDTM
         94KnpEuk5IlR20Gk4kcIl/eJfA26WaiJJXl8t/4sk/Hu7NkvklfYNfIwMx/t1oBhJxy/
         9plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747345699; x=1747950499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPyfukHzeKvRuexMUIpmQP5/LBWxLbFWKGDAGXjV/5o=;
        b=tg2kQvoRnLOw3hXl1H71tveLTnclw2jyz7uCt8qb5z+riIkgoVNyDAsI4sXbca4GLc
         AIOyrprXHiLzEbSfGDn2J80i5R2Ubwf3VZ7zzqHqSHly3umFT+2Lmj9y8G/qhbexyte0
         Gzw6SNhJFavcRrhBFGeBklRew+Chft8ooIypiO5tMIXfpieVIVJHRQ4L2GUhp8JTVK1k
         8h6gID7EsPm0E+NhhNgZBRELqbw48/tWApmeImglcwcPKpz/Dtdh/x9s+XUWcvmgOZ6B
         lhOr16CuY9nk3NthpRbuydi0eUvsoxHJjNm6GWCG+s0DyFmI9Tc/u1Kvze3xgzky+vpl
         PLfg==
X-Forwarded-Encrypted: i=1; AJvYcCXOjulfX7FullUWGPhE1mWzlpgPJerDa3RCF0zqTkP53OpFEv0GxS1X6kJt2UjKGhfHb8PdqO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlb8I2eDGWGaUNEpMCuYMxw5CjTkvVm/aBB7c0yrNrOeVRTgRj
	czkzXhmEs6H2uQp0y7vEPpIQTnVqyyx6rP64z3MyBiCuvpLVaO33vMCH
X-Gm-Gg: ASbGncse2Bwz4AJzEKdlmJR8vyZBpOFLDqVxS0BHsbxMEeExJYC8I2IKrhcLWd9DJtc
	gy8ffpWVuFKp/Qj+G4G3op/QfT9XWoxQ0Eo7WoYpgwt6XpBZTItcRPVd9sOR3m9pniHhC1KOjRS
	hywaJxMOY7yQeiPB3cJeDfMFXkQ8UNQbOharqt29RljnjpjPLKbifwT8ILvlFwt/PVIQMFImE7X
	kfQS1ZFVUb98qVyUIWyADewSo2eHhYv4oJ2v+O5vkWKAoAS+y95JXNW/9uqkK3ltUJcob7Z69yj
	5W9h6lZI8E6SyxS/RNM3dXSl23ijheVMxQYUbR5okj7UyWMCuGug4TFK7iYxyrUSXuoSlZ8hwIn
	f0ulKTi3j+NcraaAwPcHvhq0E2bGs1Z16Dg==
X-Google-Smtp-Source: AGHT+IHNWSO20A6E0+PTLBggIMz7qh969ZPRgGw0pr0BAKcvNrmRwn+mKIBMr+CvJLYJMpRMZbjy+A==
X-Received: by 2002:a05:6214:cc2:b0:6f8:ac64:64ca with SMTP id 6a1803df08f44-6f8b0828750mr20356306d6.6.1747345699147;
        Thu, 15 May 2025 14:48:19 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b097a3dbsm4207176d6.101.2025.05.15.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:48:18 -0700 (PDT)
Date: Thu, 15 May 2025 17:48:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <68266122301e7_26df0c294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515202304.82187-1-kuniyu@amazon.com>
References: <68262d4ab643_25ebe529488@willemb.c.googlers.com.notmuch>
 <20250515202304.82187-1-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 1/9] af_unix: Factorise test_bit() for
 SOCK_PASSCRED and SOCK_PASSPIDFD.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Thu, 15 May 2025 14:07:06 -0400
> > Kuniyuki Iwashima wrote:
> > > Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
> > > are scattered across many places.
> > > 
> > > Let's centralise the bit tests to make the following changes cleaner.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/af_unix.c | 37 +++++++++++++++----------------------
> > >  1 file changed, 15 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 2ab20821d6bb..464e183ffdb8 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -765,6 +765,14 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
> > >  	spin_unlock(&sk->sk_peer_lock);
> > >  }
> > >  
> > > +static bool unix_may_passcred(const struct sock *sk)
> > > +{
> > > +	struct socket *sock = sk->sk_socket;
> > 
> > Also const?
> 
> yes, but this part is removed in patch 6, so I'd leave as is :)

Ok

