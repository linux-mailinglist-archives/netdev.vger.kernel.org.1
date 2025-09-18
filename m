Return-Path: <netdev+bounces-224449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA5B853DB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5019C560DBC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9531194D;
	Thu, 18 Sep 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBehxCs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D0131159B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205158; cv=none; b=Nl86UxFhN1wyhkZnomsIVI7kfSZgyrc8rrM8kR1fNYeMRnvOwX9q0mqrFYAzHB78iIgm/VMnJ3HqI0iF55CkQhxJ0sHTx3fJEEBsGr/vCmdG1mDMHL0pqQrbEXlIWlxLPf/rhBkIlm2um+TyDtm/97lQsVUF+p+XrHXX0xVXwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205158; c=relaxed/simple;
	bh=RQ9Z1kx85zQlnSoOrFhTvfy5+txdhW6JwPYMb+IwFM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAUEw+WRsBRgrQ70M8HLz2XvUDjVhKEGjBx4LplFwXiJ6TkLUWWETX/MmpE+H2eYqPoRg5XWf260yPPCjH/CaQuYN3Q2vzP/3Ah6EwxkhQ7/cHrzwZyE/TvD1nRwu5JA4k6qh+dGtcyj1RuAGIJFvYifrAYNu3GdSqBvI5XGu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBehxCs3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea402199de1so1306200276.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758205156; x=1758809956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qZ/G6ZSVs4k9erlC2f6Rzvjnd7FrleQnq9KmYnVqgJg=;
        b=WBehxCs3vtFrsM35NwmQ7LPf7MgcdmoILtiK6r9gsWGdqqVCHrjIH5Mq6V5iGE7IeY
         v5yRPj19s35dbSVp799ZzhlEWRovJTF9unig734wm4hkcbGXj3RyToULMz/0s2Rd0Zr8
         rp/FgKVyJmqSpdU76YwCCFKbsgy24VqglXdysbpEsygeIKe+PGRJUk+b2JM+L4cafuE8
         Gd8sL31OBjzvBrWMj/aVzjgg7AI6XTqZ76m569ffO4C2tI5lyS4L0nvyWXLgVyuXhTwa
         SeKZHv4T90pTwedcW5YvUBsDh0RqJxXqroL0aMyd9a0eTOCILacDtOGfs4SppDoIP0i2
         BGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205156; x=1758809956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ/G6ZSVs4k9erlC2f6Rzvjnd7FrleQnq9KmYnVqgJg=;
        b=HosyIN1KkgR0gUYZug+1nTYcvjhFS2AhMn126pLJu2ms2gUf5wJld80NVZtkL5tehn
         E0t+4tXI3hV1z3DYJQQmypxC5u/KGMR5fPgKCjWmDYyS9RyL05CZp7gvfizGa295cybo
         LSVoNWJBM9itCUkZfHXs4W8MMktCThSXu4xfOPBICaCv2csCLlCgZ9ntHuyAbIuDOvQn
         gXlfg5oxcLRqaUlFfvXDeZENmcuL4nHEc4ovlcBkTI+rb2oOXtqFe1YZVj/vPYuh7K8j
         e5NrtkSPBgSTuJRiN66W6j8sY1Yssfjjf8O3Th4hbyjWiMxIPbuG5K1BwnB7jmJLdZ3P
         1i6A==
X-Forwarded-Encrypted: i=1; AJvYcCWsyfjT+/2XzLWWPuEd73xIeW9eSjGsfudpuL4eY6bMe/988TahN0vycVi7RJDUyTeglW7y108=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHXS2RUeSYGGPT5HDHe6EQYDNmPsak7l/LOTyxODYCrGadiyS
	8GiBouzMI6UlGRw8J0n83MH/AjseOKV4mMBu82m/DlXmEl8du13hIS+g
X-Gm-Gg: ASbGnctaOqpgTH7W55FqYNxqEs+StoFLKF2o3mlJNII5lKHEoEb9sJETaVg5fzsSe7S
	NGQpQyR2Cxxrj4n97jx0yiwLN4uyU8Uw3PZuKmT3wiEcMzkeo5aL2+B+fmlzv3OGKQLrPFGogfE
	SDV9n1sVVry3FBbQ9Berc86PCFqj/gBQtaKC0yQ2L52SimNkdusUXD/6Ezv6pIAA+fCYhKNemzp
	cpl0iCAlfhroCdVAN9au7u1HAygtqhQ5YMOQxPLpALBwLSlXvkw3K3+1txGaSD28Q5hnUONGROL
	ReuX0hBWan2wqATGV9/94j7A33DKRL4/T+vmFayLLNDBd+vtaO1hsXh2Fouj2SFLLcpn+pwYJ29
	5wy84hfgMI4ocnh0CwZPgPeJtvOwLA0MPjC5Ryui/oCTdn+0m3YpE3lOO3JtvAuh/+g==
X-Google-Smtp-Source: AGHT+IG7gBtevs0hkEsojHqgLcCqhRh/vTUZDf3Hoe3SB7t+1GIpQn7iBnokxxVyhlltzD5uxMls3A==
X-Received: by 2002:a05:6902:722:b0:ea5:d7bc:1152 with SMTP id 3f1490d57ef6-ea5d7bc1b08mr1568771276.2.1758205155453;
        Thu, 18 Sep 2025 07:19:15 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce974212sm853450276.26.2025.09.18.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:19:14 -0700 (PDT)
Date: Thu, 18 Sep 2025 07:19:13 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/3] net: devmem: use niov array for token
 management
Message-ID: <aMwU4YPF+ERN9qxc@devvm11784.nha0.facebook.com>
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
 <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-2-c80d735bd453@meta.com>
 <CAHS8izPNC65OUr4j1AjWFwRi-kNFobQ=cS4UtwNSVJsZrw19nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPNC65OUr4j1AjWFwRi-kNFobQ=cS4UtwNSVJsZrw19nQ@mail.gmail.com>

On Wed, Sep 17, 2025 at 04:55:34PM -0700, Mina Almasry wrote:
> On Thu, Sep 11, 2025 at 10:28 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Improve CPU performance of devmem token management by using page offsets
> > as dmabuf tokens and using them for direct array access lookups instead
> > of xarray lookups. Consequently, the xarray can be removed. The result
> > is an average 5% reduction in CPU cycles spent by devmem RX user
> > threads.
> >
> > This patch changes the meaning of tokens. Tokens previously referred to
> > unique fragments of pages. In this patch tokens instead represent
> > references to pages, not fragments.  Because of this, multiple tokens
> > may refer to the same page and so have identical value (e.g., two small
> > fragments may coexist on the same page). The token and offset pair that
> > the user receives uniquely identifies fragments if needed.  This assumes
> > that the user is not attempting to sort / uniq the token list using
> > tokens alone.
> >
> > A new restriction is added to the implementation: devmem RX sockets
> > cannot switch dmabuf bindings. In practice, this is a symptom of invalid
> > configuration as a flow would have to be steered to a different queue or
> > device where there is a different binding, which is generally bad for
> > TCP flows. This restriction is necessary because the 32-bit dmabuf token
> > does not have enough bits to represent both the pages in a large dmabuf
> > and also a binding or dmabuf ID. For example, a system with 8 NICs and
> > 32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queues
> > == 256 queues total == 2^8), which leaves only 24 bits for dmabuf pages
> > (2^24 * 4096 / (1<<30) == 64GB). This is insufficient for the device and
> > queue numbers on many current systems or systems that may need larger
> > GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory per
> > device).
> >
> > Using kperf[1] with 4 flows and workers, this patch improves receive
> > worker CPU util by ~4.9% with slightly better throughput.
> >
> > Before, mean cpu util for rx workers ~83.6%:
> >
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0.00    0.00    0.00   17.41
> > Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0.00    0.00    0.00   16.67
> > Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0.00    0.00    0.00   16.54
> > Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0.00    0.00    0.00   14.86
> >
> > After, mean cpu util % for rx workers ~78.7%:
> >
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0.00    0.00    0.00   23.20
> > Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0.00    0.00    0.00   21.94
> > Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0.00    0.00    0.00   22.73
> > Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0.00    0.00    0.00   17.32
> >
> > Mean throughput improves, but falls within a standard deviation (~45GB/s
> > for 4 flows on a 50GB/s NIC, one hop).
> >
> > This patch adds an array of atomics for counting the tokens returned to
> > the user for a given page. There is a 4-byte atomic per page in the
> > dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.
> >
> 
> I think this may be an issue. A typical devmem application doing real
> work will probably use a dmabuf around this size and will have
> thousands of connections. For algorithms like all-to-all I believe
> every node needs a number of connections to each other node, and it's
> common to see 10K devmem connections while a training is happening or
> what not.
> 
> Having (2MB * 10K) = 20GB extra memory now being required just for
> this book-keeping is a bit hard to swallow. Do you know what's the
> existing memory footprint of the xarrays? Were they large anyway
> (we're not actually adding more memory), or is the 2MB entirely new?
> 
> If it's entirely new, I think we may need to resolve that somehow. One
> option is implement a resizeable array... IDK if that would be more
> efficient, especially since we need to lock it in the
> tcp_recvmsg_dmabuf and in the setsockopt.
> 

I can give the xarray a measurement on some workloads and see. My guess
is it'll be quite a bit smaller than the aggregate of per-socket arrays.

> Another option is to track the userrefs per-binding, not per socket.
> If we do that, we can't free user refs the user leaves behind when
> they close the socket (or crash). We can only clear refs on dmabuf
> unbind. We have to trust the user to do the right thing. I'm finding
> it hard to verify that our current userspace is careful about not
> leaving refs behind. We'd have to run thorough tests and stuff against
> your series.
> 

I can give this a try and test on our end too, this would work for us.

Thanks!

Best,
Bobby

