Return-Path: <netdev+bounces-171250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6453CA4C25F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FF17AA202
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BC3211A05;
	Mon,  3 Mar 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT3dqUjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B7211A11
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009787; cv=none; b=GW5pgxDd5BJE618yJoG5wk+2wRGfvBZvEDSqK1gK62d3PwWqfN5BYpKyNBhPRNB373IY521fSi5dRJe9hlhxcZ+s1AAz3lam1XbqJTmlP6sMthIrSqXewXfGzWnND4UUW3mCdSY+VMZtIgWrk8xMSQJLRVOQjsyhgyhrylei8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009787; c=relaxed/simple;
	bh=lgAbImJ18uS+0pEgdg6lJJUqs3C7WgEX7SaJ5zshD0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BWQG2FWa/ofWIwXeIhmmDxiV6DwTtIZl5nxAs+uuqDOxbwivkMhVQhp/r+JdNfSXsdZlNx1ZcNrPS2itCHncNEHn2O8pFSZVV51vMbEw6lSDWvOjHSwHatAMMCjc/1axkqslkpWlNQD4CMp0K3BaJR0SN/xpvbkPaEBNyUm+Rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT3dqUjb; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e897847086so33252886d6.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741009784; x=1741614584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgAbImJ18uS+0pEgdg6lJJUqs3C7WgEX7SaJ5zshD0w=;
        b=bT3dqUjbHNIPgdpu4AlPhNMKZEAMn6RnqiqerVdhmOaArb0hHAX+/AxkHvA8tsnad8
         kA5nwQgCoQkEvRtH/r1dvt/5F7liud500+gRz685kLpYfbGI8rUHG9nxy76s7swa11Fz
         gocMTUf2T9wadfnYs9MpCKMhO1bwlo15basu6PYrpJxH2yrbO4vtqNNECcMX8LeGn5RJ
         SqN4ZERvUvXC5zi7LiKNSzxq18jxnHZJT3qw9n+7bMzEQX1bxL3nghWFElquDDMxibgE
         /IfrTdBejXdI1hW7XBt1xE5JrjpoA0Woo+K3mH3JnuyrorTt99c8Yo9j/8pbZp8xWyXw
         oNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741009784; x=1741614584;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgAbImJ18uS+0pEgdg6lJJUqs3C7WgEX7SaJ5zshD0w=;
        b=XCNyx8FU8pyEdSaxAsca+YrKa0GqkR2Zv5DikmpaewGynS0gXwUwntWYlMoQjxkBaX
         8fNO3NURwSwbRHbwNHS6vw1/dSjouJPUTv5YEs/rts42fod1cm1DtH4aIFXrg9r5//Og
         /NyOEK/QJBSzLdrjnpwkM96lILZbGwSvMwZ4oqmGDqoGMv13myYQEIwrGKurbEOUqcvG
         FFiwcyqhoQXWel1B0kNd0f66/bSWkjDzxoxw7CBs5xBR4yUGVGIUTFI7PDOpQMs8vCkP
         R23psAZUSiSVpCNtkxtyrbYKteQO/c+X7gvpPNopJcEDHijqAGevkzSpCl9qN6HnBa1b
         8SLw==
X-Forwarded-Encrypted: i=1; AJvYcCXmHJuVAy/GRkcUzjfy9UdfZd7io6KRnuMudcVX0462HWgnVsvSO+PclF0Hf3yaGyl7wbyZ/3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8twGaXbUTnRnjC2INV0B4emROo9fDDSf73vosr4Gx5JoDH7I
	JU8hY4GUTAzZs3rOnUopva2UmMxtbHpBH++UqkVxQZjchV/sBXXW
X-Gm-Gg: ASbGncv08SZKlxrjPdZMxSU/VxIJvcfqL8jsrQGUihD3MzNYhhjWA3K+oOhTsikxK25
	3aCtZ4A2/ORx7QYyP1hUGJYsUgGCEwqK/HVEGZNlTvw2etdRlWqFq03p7/2NaAnO1UsxmZ5XlYb
	gvx98skJIf3V1VHbAQnSBi18q+pkBo8jk5SBHb4KLt/uuYjCqt93YXt9ZKqGTbOAIdhg6oro7D7
	IznMDIVc1Mm48aiK8vJ1S4A/+816/ug2Ac07nCWXegER+k3k4PFS0sO4GWN9yGjBmONNTQtS2Iz
	lPBSKEVDogrGsJ3wn6JVauRPXX4NDeF1eLdvtmc7LdVI74twsy1QUPdhKH/A7fiDaroNnPYBQmq
	N9C4wZLUUVDPsNv2XDzUF7w==
X-Google-Smtp-Source: AGHT+IFnq9P5+lqpoIWAR5TcUB+pzezVF/ro/UoQh1HYcSfh+67XDz28NFX8HRkfViqnVLRoWe+EvA==
X-Received: by 2002:a05:6214:2462:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e8a0d9990emr204909266d6.39.1741009784347;
        Mon, 03 Mar 2025 05:49:44 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976534cbsm53155846d6.31.2025.03.03.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:49:43 -0800 (PST)
Date: Mon, 03 Mar 2025 08:49:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 kuniyu@amazon.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67c5b3775ea69_1b832729461@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDg1mQ+7DtYNgYomum9o=gzwtrjedYf7VmHud54VfSynQ@mail.gmail.com>
References: <20250228164904.47511-1-kerneljasonxing@gmail.com>
 <67c5111ae5754_170775294fe@willemb.c.googlers.com.notmuch>
 <CAL+tcoDg1mQ+7DtYNgYomum9o=gzwtrjedYf7VmHud54VfSynQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: support TCP GSO case for a few
 missing flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Mar 3, 2025 at 10:17=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > When I read through the TSO codes, I found out that we probably
> > > miss initializing the tx_flags of last seg when TSO is turned
> > > off,
> >
> > When falling back onto TCP GSO. Good catch.
> >
> > This is a fix, so should target net?
> =

> After seeing your comment below, I'm not sure if the next version
> targets the net branch because SKBTX_BPF flag is not in the net branch.=


HWTSTAMP is sufficient reason
 =

> If target net-net tree, I would add the following:
> Fixes: 6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")=

> Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")

Please only add one Fixes tag. In this case 4ed2d765dfacc

