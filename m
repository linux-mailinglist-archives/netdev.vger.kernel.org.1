Return-Path: <netdev+bounces-176478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19624A6A7A4
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343B2174DCF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525AB224252;
	Thu, 20 Mar 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwCjK8LE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADB222592
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478657; cv=none; b=TpeLyWjbB3PaUBGwreC+k8D+18xClnW55mSrpZ37uyNsiNFIJhvY1fB0o4RaK8WqePbxfu7uYfnbXa+xcPZ+J2gnEH0qc6Dvf9jMuJhxNKRNXTlCABFtGD7NPlIWcZnOQQ1oGPTUYOeWCJxUxr1dI9BCeuZabZVlI6rirRDbXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478657; c=relaxed/simple;
	bh=tArUgDU2Sfwn2/uvSHmy/M8i/INGzTtKVIAFi98uVW0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iBuqCdZ3qA/wI3g75e4sXggZKaPAfxuE523Dglp4xVdTCl69CIIMlXvBcvUVnkANvtdegRdt8vb6rqKhUDLhpREZ7hP9qdKmMj5l7zHp5H+UhMV1/978pfFAKAug4VWTH2eSuqtP7k/ds3P3h7GBmi6rUR969yT+uAMwc/Y/HBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwCjK8LE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08fc20194so171350985a.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742478654; x=1743083454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGJu5Lgnhl6DrM7z0DGdBHAJIbEZ7bh9YOjtbYmtSrI=;
        b=XwCjK8LEtR4nKl5LqK51DAlF7ukvlGSyd9UWKD2ebKPi2S+1WgNKQj+8OiFxUGocXb
         RYnhpVz6v7jH46LXgtM0fWhEELxLQd7Be6DeKBmyIb3IUK/6LCOKXBOvBQrM1S+eyfz5
         Tdmq70RCE0bQvYZkQBsXxaf8Ax6XNxuJhRuCwBQL3yytp7oXt/h6GFAL2v04wOl3xNq4
         BPis9CkEGRRuLP8ji1IewuoXr9wyiMCXNGJOTshsDeiERx6AdoMZXUlfdv/kBWDCw1B1
         I/X2sO+sj8anmYTjnKQUfvQnssoruj03usy7v8acKvzRgJrB/+BSOjg+02QepNu40B60
         Pb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478654; x=1743083454;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZGJu5Lgnhl6DrM7z0DGdBHAJIbEZ7bh9YOjtbYmtSrI=;
        b=L3xU4daN3sByok+GinLdXh3ss06fyDUYZPyigrdLxeuJGr1XtPRcoyTwCvI41KsmaM
         9WjyzBj97yyQDZ2p4hTKN5Bf5UNUwZBKdn18NeeJc8WkJWigsFHs8IrBaHz/bqxcmG6a
         ET/X486Jwup57pgPsisQOGDpiNb6XcXNevESf2MfLMIq5pD79wXzAmGGSp7A4YWxybtG
         m4lHg85ZcLM/SnAUX4Ul94tZMyeRPP/ffVK50Y/JKTCCP1j3GbgvJ4Xzc/eO37QDWCrc
         qhc4K0m51mLA46EVlgD1f9AP07nV83gk57qaCx272S549IJEdYQ4wv+2clhSs9QiSjgt
         U9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW3bhFLfJGSaJD94ca83ZpxaJBEccrYFh+EmsJ7f7vQP5kZwh5WCTFnkUA6VbZpLGkxaMWYznw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKVyDlSGN1H4L6mR7jE4tanc4PFTAyUwCgRighW15wbKIvMqg
	ziExmMB1eYRKgGG8cXZb7elutpE17QOjd1YXOA6ZUDunSPLsrjHP
X-Gm-Gg: ASbGncsixX+4zmDt4jmjntbjtbYc6sT4d1QjvzREQO4OqcDZrenUAA5Hqp3wULT6bp7
	I9vQNZ8uydCK7VqVfxQYXTfrvRvbMcJZmR3WNZkIn+z1IQ3ioem+D967GIi21hAfJ0yePnbGtOl
	9oCMrTy9kjEIKlpOvAgVT9SEv0XA7hl15AZVk+M9qGbPmbyNq0KNMAHzPlfpBQky81nv+DZNF4c
	f3+qRqNMwpWP7wjButv+sZL4gkUit+9IkDnexIhmyHiNxM+ZjttI4uBlnBfogtZ3wx/aSQz26Z3
	ziWpHKYkbqC2YYdoZ2yac+ATZgYya2EFrNQD+I4SXBxu67SKOXUzhgcNDRX+wWT5yixCxxoNoi3
	V5eCcM8+SuxGuA0Sz4MtYu7zwJbvbV5rt
X-Google-Smtp-Source: AGHT+IHg6pPgFjl0Lt7ofwca0qkV3lIqnuOAT1zhY1d6TKth1XgsfhlsBSCeKeXDuw0oMJZAqyYQOA==
X-Received: by 2002:a05:620a:2618:b0:7c5:658a:e584 with SMTP id af79cd13be357-7c5a84a50abmr1112949485a.53.1742478654530;
        Thu, 20 Mar 2025 06:50:54 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5205bsm1016373385a.3.2025.03.20.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:50:53 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:50:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 steffen.klassert@secunet.com
Message-ID: <67dc1d3d60383_a04b129455@willemb.c.googlers.com.notmuch>
In-Reply-To: <fa4a449a-9af9-4106-924e-97e14e7fe7c0@redhat.com>
References: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
 <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
 <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>
 <67db0295aca11_1367b2949e@willemb.c.googlers.com.notmuch>
 <fa4a449a-9af9-4106-924e-97e14e7fe7c0@redhat.com>
Subject: Re: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 3/19/25 6:44 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> Given syzkaller has found another splat with no reproducer on the other
> >> UDP GRO change of mine [1] and we are almost at merge window time, I'm
> >> considering reverting entirely such changes and re-submit later
> >> (hopefully fixed). WDYT?
> > 
> > Your call. I suspect that we can forward fix this. But yes, that is
> > always the riskier approach. And from a first quick look at the
> > report, the right fix is not immediately glaringly obvious indeed.
> 
> One problem to me is that I have my hands significantly full, since the
> revert looks like the faster way out it looks the more appealing
> candidate to me.
> 
> WRT the other issue, I think the problem is in udp_tunnel_cleanup_gro();
> this check:
> 
>         if (!up->tunnel_list.pprev)
>                 return;
> 
> at sk deletion time is performed outside any lock. The current CPU could
> see the old list value (empty) even if another core previously added the
> sk into the UDP tunnel GRO list, thus skipping the removal from such
> list. Later list operation will do UaF while touching the same list.
> 
> Moving the check under the udp_tunnel_gro_lock spinlock should solve the
> issue.

FWIW, the full revert doesn't have to happen in the net-next timeframe.
Can always revert to that in -rcX. And try a forward fix first, after
the merge is over.



