Return-Path: <netdev+bounces-97518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BEA8CBD8D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 11:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B931C20DDB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710980600;
	Wed, 22 May 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHBYrTBs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0737FBAE
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369226; cv=none; b=BlSQUh0ZD+/IfcIomvGcr2H1cQ4CjfpBpUq5N4A5/vl/SznW1dzMuK5FrsKdYWsOf68tF6yFjG5QrqasuhP5hQOV8aRfwXixPBLv2hATCrQthfEJ5tkYNpxo89sBZaXPxVDvzN/9EtEHsvU2hX6/YAhqetKj0N3WV49yKLPw6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369226; c=relaxed/simple;
	bh=8CawFPvWSZIP9JTwqdkwkq1/zPEWEbPmysHWGS1x128=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USaDo3EeDmMPtlXUATv4M5Tb6hr3PBnYeyGX8SyegDG2pjKezD8aff9TnhWd8RKvSXypZeJP/dgbTK3+Lk3I7G8V+tGyBDKOFqOsmgh2zuyIFwwDBSvXfi7x1QIeVtnMG6x0l86DyKpi8vonVi+iK8+l1E+mA4tut4x0bH4jtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHBYrTBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716369223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ilVQWBrwL5RwP+01/JpwvwSpKn8bRsUxUAFHD0KHiuU=;
	b=SHBYrTBsEAgsS8Dwo/brAFgLwE51uIKD9G+gJruKcDqsNPDwwJpnhA7cexNeq2MaptCPSu
	C2Qtr6hJAFWIRSuDXntkKLKGnh3JH8w6iVxfiI/Pbm2IXOoeI0ezYJ7xvt/AK7/ov+kMGR
	02tJfVO2/j3XOMDIZO5FhOjCsh+9C2k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-iKHhwVmvNNWKxvHFd0hDqQ-1; Wed, 22 May 2024 05:13:41 -0400
X-MC-Unique: iKHhwVmvNNWKxvHFd0hDqQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354d4404a76so136783f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 02:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369220; x=1716974020;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilVQWBrwL5RwP+01/JpwvwSpKn8bRsUxUAFHD0KHiuU=;
        b=Dy0ZcF0AtqLAoNV+UL8yLzQfwi2l4aRUIKM86qVweqkL9UUOGEx6EzB0xW6/twRNAJ
         KIO2du2pqn0LKhuEzc5p/zhsT5lQ5ccw1YH8/X+jvS0E9yHTMpydA3ceIl0upG4VJSac
         WC99TbwZZel/3Rvk9ig5Gb6HHVmacXXgbOJJAPbPPgtvN50H++/YDOWXCtCdjSGqFfcR
         inTdBKnx8qSCEocAwYOc1UcLjEjrAFhFG+mnWbTGC1hFDQFlYdr2PTqq9TkW4eEnRqg/
         Hh6aYr7VqIYZ0R3waOn6BHg4229dWlsZVmuEcIMw3imTkodkEOHoiC+gCBgniIyiL7i7
         1r7A==
X-Forwarded-Encrypted: i=1; AJvYcCUeidApsQv6WorRqVVcKJy33UP4Aw1N5QIogDszG9b6PISILFpwBvgAONH9NQso1kIKPu2gqndf2Ue0WpoIQ/EdpKwuymrf
X-Gm-Message-State: AOJu0Yw5/+QLms7RZOCUUCTGch6BpQX2+uUVBlrqsMBEbf3PkZ3Q6M/p
	m07Aa2JucEmkK4oCqorsysePQOS6T2KiL1hmJKyHLoe/8ydvnSKealcuVD3quu2rcvfVGX9ZKGV
	tFBBNs7F0HtLyJz+QRWW1fxPQPcmDxMa6/xxvOD+rAk3NGKbcXqHwWA==
X-Received: by 2002:a05:6000:707:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-354d8db8103mr1104388f8f.4.1716369220078;
        Wed, 22 May 2024 02:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt/BxL8jWjN/Qps/0RbVSfOP9/0Fw9JweCD36eUHU45FOSp0UgZ1UWy+mYeiE9YGtx6dxRwA==
X-Received: by 2002:a05:6000:707:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-354d8db8103mr1104370f8f.4.1716369219677;
        Wed, 22 May 2024 02:13:39 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc7easm33637996f8f.110.2024.05.22.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:13:39 -0700 (PDT)
Message-ID: <c60009edfc0e5f3bd389860ff9d0224b32e39ee0.camel@redhat.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-races around sk->sk_hash.
From: Paolo Abeni <pabeni@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>,  netdev@vger.kernel.org, syzkaller
 <syzkaller@googlegroups.com>
Date: Wed, 22 May 2024 11:13:37 +0200
In-Reply-To: <CACT4Y+afQ-Y-Lt=A8LGv5zrAcb29a2TEweCqiqCuU+iL9xAkSw@mail.gmail.com>
References: <20240518011346.36248-1-kuniyu@amazon.com>
	 <CACT4Y+afQ-Y-Lt=A8LGv5zrAcb29a2TEweCqiqCuU+iL9xAkSw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 06:16 +0200, Dmitry Vyukov wrote:
> On Sat, 18 May 2024 at 03:14, 'Kuniyuki Iwashima' via syzkaller
> <syzkaller@googlegroups.com> wrote:
> >=20
> > syzkaller reported data-race of sk->sk_hash in unix_autobind() [0],
> > and the same ones exist in unix_bind_bsd() and unix_bind_abstract().
> >=20
> > The three bind() functions prefetch sk->sk_hash locklessly and
> > use it later after validating that unix_sk(sk)->addr is NULL under
> > unix_sk(sk)->bindlock.
> >=20
> > The prefetched sk->sk_hash is the hash value of unbound socket set
> > in unix_create1() and does not change until bind() completes.
> >=20
> > There could be a chance that sk->sk_hash changes after the lockless
> > read.  However, in such a case, non-NULL unix_sk(sk)->addr is visible
> > under unix_sk(sk)->bindlock, and bind() returns -EINVAL without using
> > the prefetched value.
> >=20
> > The KCSAN splat is false-positive, but let's use WRITE_ONCE() and
> > READ_ONCE() to silence it.
> >=20
> > [0]:
> > BUG: KCSAN: data-race in unix_autobind / unix_autobind
> >=20
> > write to 0xffff888034a9fb88 of 4 bytes by task 4468 on cpu 0:
> >  __unix_set_addr_hash net/unix/af_unix.c:331 [inline]
> >  unix_autobind+0x47a/0x7d0 net/unix/af_unix.c:1185
> >  unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
> >  __sys_connect_file+0xd7/0xe0 net/socket.c:2048
> >  __sys_connect+0x114/0x140 net/socket.c:2065
> >  __do_sys_connect net/socket.c:2075 [inline]
> >  __se_sys_connect net/socket.c:2072 [inline]
> >  __x64_sys_connect+0x40/0x50 net/socket.c:2072
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> >=20
> > read to 0xffff888034a9fb88 of 4 bytes by task 4465 on cpu 1:
> >  unix_autobind+0x28/0x7d0 net/unix/af_unix.c:1134
> >  unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
> >  __sys_connect_file+0xd7/0xe0 net/socket.c:2048
> >  __sys_connect+0x114/0x140 net/socket.c:2065
> >  __do_sys_connect net/socket.c:2075 [inline]
> >  __se_sys_connect net/socket.c:2072 [inline]
> >  __x64_sys_connect+0x40/0x50 net/socket.c:2072
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> >=20
> > value changed: 0x000000e4 -> 0x000001e3
> >=20
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 4465 Comm: syz-executor.0 Not tainted 6.8.0-12822-gcd51db11=
0a7e #12
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-=
0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >=20
> > Fixes: afd20b9290e1 ("af_unix: Replace the big lock with small locks.")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 92a88ac070ca..e92b45e21664 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -327,8 +327,7 @@ static void __unix_set_addr_hash(struct net *net, s=
truct sock *sk,
> >  {
> >         __unix_remove_socket(sk);
> >         smp_store_release(&unix_sk(sk)->addr, addr);
> > -
> > -       sk->sk_hash =3D hash;
> > +       WRITE_ONCE(sk->sk_hash, hash);
> >         __unix_insert_socket(net, sk);
> >  }
> >=20
> > @@ -1131,7 +1130,7 @@ static struct sock *unix_find_other(struct net *n=
et,
> >=20
> >  static int unix_autobind(struct sock *sk)
> >  {
> > -       unsigned int new_hash, old_hash =3D sk->sk_hash;
> > +       unsigned int new_hash, old_hash =3D READ_ONCE(sk->sk_hash);
> >         struct unix_sock *u =3D unix_sk(sk);
> >         struct net *net =3D sock_net(sk);
> >         struct unix_address *addr;
> > @@ -1195,7 +1194,7 @@ static int unix_bind_bsd(struct sock *sk, struct =
sockaddr_un *sunaddr,
> >  {
> >         umode_t mode =3D S_IFSOCK |
> >                (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
> > -       unsigned int new_hash, old_hash =3D sk->sk_hash;
> > +       unsigned int new_hash, old_hash =3D READ_ONCE(sk->sk_hash);
> >         struct unix_sock *u =3D unix_sk(sk);
> >         struct net *net =3D sock_net(sk);
> >         struct mnt_idmap *idmap;
> > @@ -1261,7 +1260,7 @@ static int unix_bind_bsd(struct sock *sk, struct =
sockaddr_un *sunaddr,
> >  static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sun=
addr,
> >                               int addr_len)
> >  {
> > -       unsigned int new_hash, old_hash =3D sk->sk_hash;
> > +       unsigned int new_hash, old_hash =3D READ_ONCE(sk->sk_hash);
> >         struct unix_sock *u =3D unix_sk(sk);
> >         struct net *net =3D sock_net(sk);
> >         struct unix_address *addr;
>=20
>=20
>=20
> Hi,
>=20
> I don't know much about this code, but perhaps these accesses must be
> protected by bindlock instead?
> It shouldn't autobind twice, right? Perhaps the code just tried to
> save a line of code and moved the reads to the variable declaration
> section.

I also think that sk_hash is/should be under bindlock protection, and
thus moving the read should be better.

Otherwise even the first sk->sk_hash in unix_insert_bsd_socket() would
be=C2=A0'lockless' - prior/outside to the table lock.

Thanks,

Paolo


