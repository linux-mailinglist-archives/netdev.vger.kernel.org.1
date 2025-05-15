Return-Path: <netdev+bounces-190807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC309AB8E7D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF697B6F5F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA01258CF0;
	Thu, 15 May 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1zT36O0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB201EA7F9
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332489; cv=none; b=ZRAb9bb2l8C0XW6DFXmj4tLdSjE/Hgz/8YH5VE13wyQxZFn5G5z6fldCOHqHq6E9a1ptWfF3QammpjLbQjtPpOfEwKqUuM2+4nCRY6ygEDhSLvXVnGakwPGpZov+34VOZDDBWUZzR1CK+enUn/d64TrURKSHMUrVNECEmrhDt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332489; c=relaxed/simple;
	bh=pIlXmsZVtdjDzH6K+82qwJMox70wQ/aQo1Dm6MKI5xw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LCTK17o63H0G8avqxz2hwVnUAugbkNXYE2prhVJtKfTSBsnvfoTg01jnC5Xo63Z1QphqOPfAjpu4Q6ITsHOHNRoGz6ynwBk5+GpzCYWm+3mogDYm9L4/wlD3hd9yUNcNw5mDN/Jo64IM3dCDyrNmKnJM+G9ItweAVRGHaznVIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1zT36O0; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so15445836d6.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332487; x=1747937287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws9tT78KrA0YTyhBNVLd6n4o+gLTz8KX8UVh4d7JKH4=;
        b=Y1zT36O0Rj2QBEbEFvgNah5heXoVH4pYpGZRQAReUKLnpEo6ZtcQfDfG6H0BEb8zc9
         waAkz4Vs4YaJTS1Qh7jlC5uC6SoJVq8dgL74uc+RneE4p3yS/6p065EQOETrl9nyhsZH
         PeDSWz0SYqGvU0TmCe6ojsGvgKMMpx1AGn10FCfY+8GxRuav3PYhvLKY1ybkwB8zdqs0
         Plt7/PeY3Y2qU67MTfIS4CUg8dc5D3YRYoF/B1b5PyRoBK0dC3u68DBF3nffc78U2J1c
         zZ3PkSMVP7C34twnqEmK/7ktqa04HAS0Jk7GmRgNnLvNkeqJxJdSZ9R0bn+je2qKWDh2
         8tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332487; x=1747937287;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ws9tT78KrA0YTyhBNVLd6n4o+gLTz8KX8UVh4d7JKH4=;
        b=gjTVV7wB+KU0Ea0mQBoLxEK4bLvw1i4PMfbF7qLp9IAj/o491HcOloJ5rMPySGVMht
         Z7qgG4AAMxn0NegReRhfVzqbcIjHRYYYvm8MYbvvi409y7L600B9A/lQfjEyJT4yCjID
         z9sdMELz1aeiVtQzvJnv07JkV9vubqfqk5/D86kXeb5eJmGGhNFEYj3xFd7Tfz6pTY4H
         Tv6+ohTQnPiuZ3ATQw4fZz4wJACJLGUrL1wi2U9yPolwKW25HB2RSmY+bBQpBQ/6J0kn
         bVcWYUEfdAAUNM85vL/2UDCu0fwTuWsAiH/ug/AbezsCc7sZvUVkNrG0IHfvrOnvlG3n
         RfKg==
X-Forwarded-Encrypted: i=1; AJvYcCWza+gP4/7PzgN60hff1ebyC0gwAli/MR2Pyw5EnIqELYgFyJGUbMdCMShWlhBo8BrAf6vaGEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cyilQ1buuY8xLfhCI5AzlUCmBIZDucNeka+YJmasBvNNr4S2
	INl+tnZtFu0ZjvyaDRdFSZBp9rnYmCCsuDSCD6A01Kw7ZkOigF8SvaAR
X-Gm-Gg: ASbGncsRHbRlN21Nzlwb25q5Sdcdpy2natFKSHg8uHu9d7m+GcZ3orWGfQOdGIgCkWS
	4Yh7Pq8HTw1Jun5LKLbcRJT0CrfZn6xuLao4bZtuXEiKOKEQ3guDmHziqrIrdpsMPgn2nsTY4oF
	bFv11a6VasNxF0/ilIf54na2fEGjezrywoIx4KT6hE6Fcjeejhux0IRxmC7fvIW9yoYH7akvBEE
	Vj/q2hGHoz4B9C+yEaVFbDz6wuV1wrJYmGAO6yU2/O9r3Irfr5WSO3wMImbPtZ2RS/1r0C0/eDe
	+pP9rFHo4rO3VCsOpK7kElNrSxQV1U5tfkzhBVUL2BvClEfI5coT0mK9inCwWUqCL0p5A2xikAs
	GfLunH6qNrms4dB85Hj525n4=
X-Google-Smtp-Source: AGHT+IHDTklR8tA6dmEyXAGBndmD/yrR+zPfMuoMCyOqwZuxqP53FiU0x3VXnlc3X6w8vyqNW0bw6Q==
X-Received: by 2002:a05:6214:1311:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6f8b12be68fmr4322076d6.16.1747332486581;
        Thu, 15 May 2025 11:08:06 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0966069sm2177556d6.79.2025.05.15.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:08:05 -0700 (PDT)
Date: Thu, 15 May 2025 14:08:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68262d85460a2_25ebe529485@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-4-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-4-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 3/9] scm: Move scm_recv() from scm.h to scm.c.
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
> scm_recv() has been placed in scm.h since the pre-git era for no
> particular reason (I think), which makes the file really fragile.
> 
> For example, when you move SOCK_PASSCRED from include/linux/net.h to
> enum sock_flags in include/net/sock.h, you will see weird build failure
> due to terrible dependency.
> 
> To avoid the build failure in the future, let's move scm_recv(_unix())?
> and its callees to scm.c.
> 
> Note that only scm_recv() needs to be exported for Bluetooth.
> 
> scm_send() should be moved to scm.c too, but I'll revisit later.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

