Return-Path: <netdev+bounces-194039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A3AC70F0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AE17AA01B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC9283C90;
	Wed, 28 May 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mPrPz57+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB0210F65
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457131; cv=none; b=MWtlJjIXuC5DQj6bY+uuSaDdWlCNiqviXmbub4d0tgsnni1AtlGKM6GFkGEMHWx6TOzlqb1o4USm7w1qofthrqm81lqQiafb7TJihnrRkZXsExjSibj9EPEkGwN5U0xZkxONZpF9330QyBOgviAAz1EfUrUnnkQ2uBCPBfD1fxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457131; c=relaxed/simple;
	bh=j6Sexigi7Ko8moPzmdhRrHMZjcpmS5XcMWzEaea4Ivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKLZLk0js2cWQORvXS2YHbn4wHXBWH/sYlGOPZ6nMMv3zwdy/zV2ZOErMV1n9ihbfgLZLHqpmWDOSfqDO2P9e3X9zMvfvaUhZmMhmjwTQx2f/4RBfPzkfR4dHFJgIH6LCRzp8LACpjrrrsMHOsNJYd+LOdc5dcYhzUiD8IG1New=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mPrPz57+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742a018da9cso4080b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748457129; x=1749061929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSXXxUU0J9wn1C2a0Hb2G3HBJn5qgVk3D5sCsbBOtWY=;
        b=mPrPz57+xsZkqxYvcGK/e6GR7BikkRse3aibLL3zI0hqsnkPZgWsOMoBU9CzUsY9Rt
         A3zMq0aRUIOCt9zrGJodKznjCCndlJ0AXmBvqMXWHY2nxB/h4KUPX54j6OWDEzwM2sQW
         RG6wTyBQLmGgipastNfdcDdtFqn+poNWZq+TnsBZAIpAk4wJVEJGtP1E0TJ3aRLOs7cX
         mMdEX6nVQtvulwPCHjZUYEnaCTNg7uLOMYwASFkQQjmvaXy1t2stAAYY9D9CpUDgF7zy
         8byxANbDWbirFSG/RCVtg1KyHPiKLcXU8JSNd6mQSwPHaL/Nn98uaWwQpH/tZ7LUxSAL
         rFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748457129; x=1749061929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSXXxUU0J9wn1C2a0Hb2G3HBJn5qgVk3D5sCsbBOtWY=;
        b=ZNGeVCQGx4hD0lSm+N9M7SSYECqop2tFMUnm6K7WkgyJGghRrwACYxYTWfHMHWoL9P
         CobXzpt8gSpVVHWn8FMUlIPNpZ/rsumyT5y9gr3kMymzPAl9Y8SYf2Zvgy9RVmlM/+bR
         31RG7aQrGVytoDs87yQjJiwQYaGXn0YPvGzRGIPRj+/xvQfeqj4YLv0JJ7Hf/1Q0/N13
         9NmyOcGOANQLphKGfYpU6LAIy73f42VXgsQj2QO0IZRm8cAt0OQUQ9zo0lt79EOwL6MA
         +4H/EH8ZJfdbUj7FcQULD2Ht/rx/ELqsFz7+obonnWD4RytfwcZkb9/i84QTqeHQ+R8o
         Dq3A==
X-Forwarded-Encrypted: i=1; AJvYcCUOAFzOclQ/2T4YIBS0p1qFiRUCi7SQg8T1D36+enSISPfzFCeNGq3BtdjG/FJr4fF6ZS0dtaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtgK73+uTgtqPB6satdhfglSQ3mE7PFI7vZGXbHJdxy2V4cE9
	Aw5+yI3XpLOvj+l6DmYfBJXKAEHNW9oUOizA0lAE+qo12G0ZWo8+IA5MCPSp3gU75sjroLznRoB
	5TH0Dhcw=
X-Gm-Gg: ASbGncsHEAiv15p18hmQcExG7DSMRHdM9UJF76C3hRS2WUhTQfhWT66K94cDJGy6Bmb
	X8CdSANuhmzuoER0SRk93Kq3d13s7Y7x5wra9smadZGkM1auaJ1xhVhdANyB9Hy3EfRUSWPBZ8X
	ksZC6RS0TwP8aSHpsm/IhmpiS0vFSurAg5/bCNodVsMhZ7mjLky9kjCM0xtv+HFnuuuu5o0Zd0l
	ACJe6IP1XxUv/Y6r4bVtmH1SGHVoIh/1hiNAlcNkWVoHtHzX1Zp26v7WXqklYMjO91knaxXkp9h
	+ylPmplXTGF2O/OMPLRIwTm1YoDe9OjnO/cx3w==
X-Google-Smtp-Source: AGHT+IGIvTZszuSKTVNXSfZS/0V+U2FZDA/JF4Wke2bpKg+9jHyjK0gIBkU5hxpFhN3ydqkarK4Hdg==
X-Received: by 2002:a17:902:ecd1:b0:234:ef42:5d52 with SMTP id d9443c01a7336-234ef426080mr6415835ad.6.1748457128699;
        Wed, 28 May 2025 11:32:08 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:3166:3eaf:6a29:60e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2dd18dcsm15077255ad.0.2025.05.28.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:32:08 -0700 (PDT)
Date: Wed, 28 May 2025 11:32:06 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 10/10] selftests/bpf: Add tests for bucket
 resume logic in established sockets
Message-ID: <oqnwzaemu6agvwqt6vgcjygklzhcvxghbzzi7x65dqapzsjsxh@rif4xe655t4u>
References: <20250520145059.1773738-1-jordan@jrife.io>
 <20250520145059.1773738-11-jordan@jrife.io>
 <ae95a774-2218-4ddc-b2e0-d7bac2b731fd@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae95a774-2218-4ddc-b2e0-d7bac2b731fd@linux.dev>

> > +
> > +		close(iter_fd);
> > +
> > +		if (!exists)
> > +			break;
> > +
> > +		usleep(100 * us_per_ms);
> 
> Instead of retrying with the bpf_iter_tcp to confirm the sk is gone from the
> ehash table, I think the bpf_sock_destroy() can help here.

Sure, I will explore this. I was a little worried about having a sleep
here, since it may introduce some flakiness into CI at some point, so
it would be good to have something more deterministic.

> 
> > +	}
> > +
> > +	return !exists;
> > +}
> > +
> >   static int get_seen_count(int fd, struct sock_count counts[], int n)
> >   {
> >   	__u64 cookie = socket_cookie(fd);
> > @@ -241,6 +279,43 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
> >   			       counts_len);
> >   }
> > +static void remove_seen_established(int family, int sock_type, const char *addr,
> > +				    __u16 port, int *listen_socks,
> > +				    int listen_socks_len, int *established_socks,
> > +				    int established_socks_len,
> > +				    struct sock_count *counts, int counts_len,
> > +				    struct bpf_link *link, int iter_fd)
> > +{
> > +	int close_idx;
> > +
> > +	/* Iterate through all listening sockets. */
> > +	read_n(iter_fd, listen_socks_len, counts, counts_len);
> > +
> > +	/* Make sure we saw all listening sockets exactly once. */
> > +	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
> > +			       counts, counts_len);
> > +
> > +	/* Leave one established socket. */
> > +	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
> 
> hmm... In the "SEC("iter/tcp") int iter_tcp_soreuse(...)" bpf prog, there is
> a "sk->sk_state != TCP_LISTEN" check and the established sk should have been
> skipped. Does it have an existing bug? I suspect it is missing a "()" around
> "sk->sk_family == AF_INET6 ? !ipv6_addr_loopback(...) : ...".

Agh, yeah it looks like it's the "()". Adding these around the ternary
operation leads to the expected result with all established sockets
being skipped. I will fix that in the next spin.

Jordan

