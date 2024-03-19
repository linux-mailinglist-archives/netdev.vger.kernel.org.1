Return-Path: <netdev+bounces-80600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6A87FE72
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4116E285347
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2580627;
	Tue, 19 Mar 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6QRqikd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8E2D78A
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854002; cv=none; b=XgP+t6o+O3SkbbITvJ5KMfGP2C6bXf5/YXnq4wcmce6zLIJWN15Zb+dS2MTDyeJKwPd0ytBiCBHPfbAwvAh/x+JFWjMlZYJ0WJG+jEKByM/VQgfGeyzAHGD0ua9mddYno2iTd/co7Ro2u2ti2O5ZfoGCfJNa0O8nkMxRYruV00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854002; c=relaxed/simple;
	bh=/k6w/C3HqYNL+qFKR1UMl7fOHfYVBTRZJ6L5/LETnFY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=almpM/ZuSGCg6okLZX6hLlVzALOByzmPwAGnxiuno6F8kfrXqc4X7437cToLOSyNG8J/iIOit3FsTeoqq+bLNdnXaq9VTltrDlN6KQuHuz1l0mfx0ar74XDp5pjy9YA0uSrAu2BHKKO9oOl+yEMPzYDNBMFYLy85T8fDbORZzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6QRqikd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430c41f3f89so21753501cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710854000; x=1711458800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rpr+KE3jBv0Li9Mws4DYHT1rMwMD0GfQA8K3t45dWk=;
        b=T6QRqikdWxoksHmSr7pUCatmpkSIIsnaubTZWIeiTW9uIsBfXgm876g4lIqEcrlL7r
         NHTDmOi9RtAUshgZR6zfigifd4wOnCF7YmhaSaNIsrHFqrdoCTeYdHl6xHCea9KsaE5Z
         we50Cn2bNiWnZTLQCht+/axaYb4mATqr+TXNn71tLh3IDBkVWSL9qhrzB3QnhoqUvkSu
         311BkzN2mtiv3cCL7dhlquZHOOjaCQ1sv/An/wCn5z6hIM75/8QLMnBBLUOBclU38JpU
         ddNJmUns/gHMNvr44BF5841uRRrzBgID4oTYgS2pwv1Irci8o7icBfIIabkFtFrOoMKj
         6vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710854000; x=1711458800;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8rpr+KE3jBv0Li9Mws4DYHT1rMwMD0GfQA8K3t45dWk=;
        b=tId1SEJenes+Bfle56DcTsWYG59IwW0nzG6MfJ9NuVIt12LpUc0NvzgkA/oRywBc9g
         vhls2XNJdEbFUbSb/ZwW1noAwW5JvAbE64yFxDt89BvhU4OlezqMl6t7PzEGhogZephg
         EbYDyUHakATvRPqh50gwS/4lxqZjaz4QY72ib8g88IgZTHAql0sQHQKiqT1HOPXwykcS
         rtOik8JXTNTM2uYtTijVgQ17R+4xwzbee2JbFDC+hoIYUQZZ7szqLCrNvYI033LSYDPg
         zrwsJ4f2tBXOzn7HQX75qd9THHuR6sYQLPCjvBSCTJj08CD719wJf3ixxqntAofScbH0
         RbHw==
X-Forwarded-Encrypted: i=1; AJvYcCXen0xqdBfxGGWHtxQZm7hTrPDWvPMjLxLMZkLt3Ti/nkW4iK37tetdRUTrffgd9H6AOzCikg6Wh0aRoX+8EguVtgONq3Vp
X-Gm-Message-State: AOJu0YyJg+yHsvCvVE4iEcklXwE1pcB0F7ODUbn6z6vFo2/z1TzOJ5Fx
	JOS+ewsr0y1ggME7pTJ2hXezIc7cto6S6Hzr0WAKw9rNTyE1XGrS
X-Google-Smtp-Source: AGHT+IECpGFmjNl3lh92MmLmRNUv0SxUhVYMNgzdKXEtOnew37kgCbdAA60OZtsNBwR2PSDtaFqFTg==
X-Received: by 2002:a05:622a:a98:b0:430:afdd:30d0 with SMTP id ku24-20020a05622a0a9800b00430afdd30d0mr3500391qtb.9.1710854000229;
        Tue, 19 Mar 2024 06:13:20 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id k5-20020a0cf585000000b006915b8b37a0sm6473650qvm.55.2024.03.19.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:13:19 -0700 (PDT)
Date: Tue, 19 Mar 2024 09:13:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <65f98f6faf355_11543d294d4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240319093140.499123-3-atenart@kernel.org>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-3-atenart@kernel.org>
Subject: Re: [PATCH net v2 2/4] gro: fix ownership transfer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> If packets are GROed with fraglist they might be segmented later on and
> continue their journey in the stack. In skb_segment_list those skbs can
> be reused as-is. This is an issue as their destructor was removed in
> skb_gro_receive_list but not the reference to their socket, and then
> they can't be orphaned. Fix this by also removing the reference to the
> socket.
> 
> For example this could be observed,
> 
>   kernel BUG at include/linux/skbuff.h:3131!  (skb_orphan)
>   RIP: 0010:ip6_rcv_core+0x11bc/0x19a0
>   Call Trace:
>    ipv6_list_rcv+0x250/0x3f0
>    __netif_receive_skb_list_core+0x49d/0x8f0
>    netif_receive_skb_list_internal+0x634/0xd40
>    napi_complete_done+0x1d2/0x7d0
>    gro_cell_poll+0x118/0x1f0
> 
> A similar construction is found in skb_gro_receive, apply the same
> change there.
> 
> Fixes: 5e10da5385d2 ("skbuff: allow 'slow_gro' for skb carring sock reference")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

The BUG_ON in skb_orphan makes the invariant clear that the two fields
must be cleared together:

        if (skb->destructor) {
                skb->destructor(skb);
                skb->destructor = NULL;
                skb->sk         = NULL;
        } else {
                BUG_ON(skb->sk);
        }

