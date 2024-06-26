Return-Path: <netdev+bounces-106994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539A9186D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA2E282B6E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157F190490;
	Wed, 26 Jun 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUAG00ky"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998B18EFCF
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417862; cv=none; b=kdDkr1BHWUyGaXT127rqkuSicFOOK/pjwY/y6RgdIzkxg6CLWZ2nk+O66tj6lh7QlUDcv2b5cYB9lN189e4eKorfmHXx44ZF9loVAMWbixV7q7TmAnm4zuRgTcFgx9aM2cUBnvzeemsy6NG2iZIwzhevaO6A0U82pe0KhbH1d0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417862; c=relaxed/simple;
	bh=yNTzG0J7wNN4igxR6F/IrxrlToSh8eTK5c9Wq8lBZA4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RyPEq0tYHWt5vMZzq6kZhCCd5mXJLcFknYnGD7DwplCM7tO91UX1Yf51KtJ1fCvx+OZqcnkwuboNbiiIj7vPYVL5ZWIDMTGeXnGOeB/l2zwIk2IpTKtGp+g1Fl27s7VEhNO7zjUIag0dDnY4YaRGoAJxt27aJG7ZToFZecTaGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUAG00ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719417859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHjTMyH5Rwk5yjh+iWMH6LJrfct1/DpGEQ3xLofZHeo=;
	b=CUAG00kynsaLnouu5krjgvhDgi9Vt1vagguELZ722K58ga+UUrHNvbxlfElD4qA5ZprD9r
	/18975CKEV9dBeFyyBR8rRpUr9fSRnJukV3Mj785yj1KcJHO9/DnoIk6j+PCagyFq40jyD
	a8TPl3hjSP8kUavBkE9BKuW6yc+gGHE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-9aP481BXPz6q9Bm-AjEReg-1; Wed, 26 Jun 2024 12:04:18 -0400
X-MC-Unique: 9aP481BXPz6q9Bm-AjEReg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b50f5610cdso109262606d6.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417857; x=1720022657;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DHjTMyH5Rwk5yjh+iWMH6LJrfct1/DpGEQ3xLofZHeo=;
        b=G4SXM/7hHpE5deACV3uwhcLi5vukloPNzBYYziy7yPOnwYOc+AmrYqkC0R7x8NPwrR
         G8PBVJXv5GFsAWlTqo8kzEMUAzZun9KpYjPVDS3RdSVUXz9X4OzPPRVsY/5apjmsqM1O
         z5/3kNTYC4KwlyqpeVbWbn9PzKD/AYU44JEcotW0EMUT8Ae6Ml4Na1nFsOd7A1DY4KHj
         dssB1B233FISaTcZJ46+IpSU1z+UBult1MtsikMG5a/SncJpL728WHKsJpslRy2/pX8r
         fy8rpuzvJpvMBzKgH811Fg/VYtmuN8k684lP4t3BV90qZx3E/vCgSCdN043d3plh3HME
         w2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQX8ZqPr+UDGKmLc3lAZlCDVLhU4SHTtlk1ZhlPugFtlk0BJxH2o/fWQP1oV0gB6CeiHCJPFi7IEybmjUq/9tLgJbEV677
X-Gm-Message-State: AOJu0YyIVVqU3cGhyGQsonR5SNx48j0qlS7K860ORjCBLUxBJ93MOdeP
	62QzFGmLOcj7YlRijpQcIjFpfpMf1fmfiQFdMMQsThVhGCYANlgaQBWzDzU9S45HKapcSJKHEPD
	6A9HAQxbxhELEbhmkvyonNlWGmsijcYiYkwI4QniCpkLcWIbicgLWDS7RZyhPKQ==
X-Received: by 2002:ad4:5bef:0:b0:6b5:474a:8f74 with SMTP id 6a1803df08f44-6b5474a96b1mr116363916d6.29.1719417857468;
        Wed, 26 Jun 2024 09:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7mtK9WggPDqb2LDlMb/2bFXu9tv4zKoByK+QchHf6bUv6I5JnQc+16tYBiRf6dJ+/0v+J9w==
X-Received: by 2002:ad4:5bef:0:b0:6b5:474a:8f74 with SMTP id 6a1803df08f44-6b5474a96b1mr116363476d6.29.1719417856953;
        Wed, 26 Jun 2024 09:04:16 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed18e44sm56047916d6.40.2024.06.26.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:04:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 01:04:11 +0900 (JST)
Message-Id: <20240627.010411.908967860275845205.syoshida@redhat.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] af_unix: Fix uninit-value in __unix_walk_scc()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20240625195849.55006-1-kuniyu@amazon.com>
References: <20240625152713.1147650-1-syoshida@redhat.com>
	<20240625195849.55006-1-kuniyu@amazon.com>
X-Mailer: Mew version 6.9 on Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 12:58:48 -0700, Kuniyuki Iwashima wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> Date: Wed, 26 Jun 2024 00:27:13 +0900
>> KMSAN reported uninit-value access in __unix_walk_scc() [1].
>> 
>> In the list_for_each_entry_reverse() loop, when the vertex's index equals
>> it's scc_index, the loop uses the variable vertex as a temporary variable
>> that points to a vertex in scc. And when the loop is finished, the variable
>> vertex points to the list head, in this case scc, which is a local variable
>> on the stack.
> 
> Thanks for the fix !
> 
> More precisely, it's not even scc and might underflow the call
> stack of __unix_walk_scc():
> 
>   container_of(&scc, struct unix_vertex, scc_entry)
> 
> 
>> 
>> However, the variable vertex is used under the label prev_vertex. So if the
>> edge_stack is not empty and the function jumps to the prev_vertex label,
>> the function will access invalid data on the stack. This causes the
>> uninit-value access issue.
>> 
>> Fix this by introducing a new temporary variable for the loop.
>> 
>> [1]
>> BUG: KMSAN: uninit-value in __unix_walk_scc net/unix/garbage.c:478 [inline]
>> BUG: KMSAN: uninit-value in unix_walk_scc net/unix/garbage.c:526 [inline]
>> BUG: KMSAN: uninit-value in __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
>>  __unix_walk_scc net/unix/garbage.c:478 [inline]
> 
> Could you validate the test case below without/with your patch
> and post it within v2 with your SOB tag ?
> 
> I ran the test below and confrimed the bug with a manual WARN_ON()
> but didn't see KMSAN splat, so what version of clang do you use ?

Thank you for your comment!

I ran the test below without my patch several times, but it couldn't
catch KMSAN splat.

Perhaps this issue depends on the state of the stack. Even the repro
created by syzkaller takes a few minutes to catch the issue on my
environment.

I used the following version of clang:

$ clang --version
clang version 18.1.6 (Fedora 18.1.6-3.fc40)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg

Thanks,
Shigeru

> 
> ---8<---
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Tue, 25 Jun 2024 19:46:59 +0000
> Subject: [PATCH] selftest: af_unix: Add test case for backtrack after
>  finalising SCC.
> 
> syzkaller reported a KMSAN splat in __unix_walk_scc() while backtracking
> edge_stack after finalising SCC.
> 
> Let's add a test case exercising the path.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
> index 2bfed46e0b19..d66336256580 100644
> --- a/tools/testing/selftests/net/af_unix/scm_rights.c
> +++ b/tools/testing/selftests/net/af_unix/scm_rights.c
> @@ -14,12 +14,12 @@
>  
>  FIXTURE(scm_rights)
>  {
> -	int fd[16];
> +	int fd[32];
>  };
>  
>  FIXTURE_VARIANT(scm_rights)
>  {
> -	char name[16];
> +	char name[32];
>  	int type;
>  	int flags;
>  	bool test_listener;
> @@ -172,6 +172,8 @@ static void __create_sockets(struct __test_metadata *_metadata,
>  			     const FIXTURE_VARIANT(scm_rights) *variant,
>  			     int n)
>  {
> +	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
> +
>  	if (variant->test_listener)
>  		create_listeners(_metadata, self, n);
>  	else
> @@ -283,4 +285,23 @@ TEST_F(scm_rights, cross_edge)
>  	close_sockets(8);
>  }
>  
> +TEST_F(scm_rights, backtrack_from_scc)
> +{
> +	create_sockets(10);
> +
> +	send_fd(0, 1);
> +	send_fd(0, 4);
> +	send_fd(1, 2);
> +	send_fd(2, 3);
> +	send_fd(3, 1);
> +
> +	send_fd(5, 6);
> +	send_fd(5, 9);
> +	send_fd(6, 7);
> +	send_fd(7, 8);
> +	send_fd(8, 6);
> +
> +	close_sockets(10);
> +}
> +
>  TEST_HARNESS_MAIN
> ---8<---
> 


