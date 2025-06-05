Return-Path: <netdev+bounces-195318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F846ACF83F
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7722A3AF884
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA0276025;
	Thu,  5 Jun 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkZRSyKy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3241DED70
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152850; cv=none; b=VBmDo6LL/Q/VLyq5oYzwcemPEUatnS5y8Jic5L+Q8xgDtZwMfyM0LvUWLxEdSKt/F9VrEPxUX2AHOwhEra3IdzomgyzQzCWZ6mRY5eT9YSoYhn1RB47kahNhDb5hp8whO7dU7c6dw66zCOy3Q2PsXkV8UTTZGYzPm0/5js1+OqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152850; c=relaxed/simple;
	bh=UCKucqpwIyXj8QqMkDicaIUSsgwwLiTElK59LUrl4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCWvSBB3Y/YwiuunlUq4ZC5EijbMZSu07Lxg0118dbwhbQGpjyO4PXa3Y48k5pW4XsAtsTkMAZCG2WwGoxjIzrO58JfI5EpSXAORBsYuD+74MBLhR68WA8hzuuYzDVYpU/fb2AI4i9otTKiwfp1YWSAIi9J2IVxUAF8y57etQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkZRSyKy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2357c61cda7so4945ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749152848; x=1749757648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCKucqpwIyXj8QqMkDicaIUSsgwwLiTElK59LUrl4fE=;
        b=HkZRSyKy1rL1pwe3LUs3LLl61kUzlQxWkvjm8DGMH0Jh1+YuGJ+VVhi7cx77uKFbBg
         Gnz0BDN8p9d9rzjxv1aUXQlPYomT18gULbI1Sg0884mf/SxaE0ViWcIdM4Le2N/d/WUk
         z3hWfH5ybmnBIdBHaP1f9yuyEWc3uVTCUzWpCBa5kNN9dor8zHrVEjokX3TXZGx2iZZr
         wZk6AmSJLK16W37apSBo1VmYyLncIpg3dCaCRVhVO3x3tc1fFrOYA9icQBw9tFcmqfPy
         nyZw1ZIYiEjHKQMJQ0Tof8z6lROTtXn26JffSpcK2hfYZcwbdR70IBWM7ZrxXEbl5cwk
         rF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749152848; x=1749757648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCKucqpwIyXj8QqMkDicaIUSsgwwLiTElK59LUrl4fE=;
        b=aSOWfa+d435O6tMqwSF/ly9ZgVz6XmalHMZtsM9IcxOM5kDSAbZkfl9HA8e3lpSZTJ
         +kkl4UqYUZD/uYaJCDSVPN1gZMFI8M1UbLGcbdIF+zNbgcxNc2nn/lKVSr+GnX4eNsHd
         AIqAsXGryB74HE3N/dIHgG2xnFlCnLW5cU8NpQtHcImvGipdcIWliMHtW+F8gYlGqXXs
         8MZVt59PaZLSjoOA61s8B+Z55NYcxl5wgiE37cZPCix0ObMX/1/gdbfMUHZ2B2LkGgpI
         te312WmaxxUHAaay647MNg5XIRSsChzm5bpVu42RWBGjwv7eMEDfT1mdjY71EWB9JXsV
         O6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUq6mQ7JmDi3C8AB1kaz68JbBk7uy+6f0ldgbBp9IEJJXiTOwHcl3ode4+CfcGPb0gsfMijrA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybbmU2kA16TbR0tV2ciI1O+bGfqHx9Js7Bi4I5NmWOzc76cimT
	5MBM0TpAxwecTPe+mjRQZEcCAQkfFPXich9GrcN+IIyddSJh3OrJ+0g1aHXz/ML/IKmh/HqopBA
	zvnnM34wW4wnekL5E3aMdBYkOXfnppc3O2udmpacI
X-Gm-Gg: ASbGnctB1y4WGTKYueMbkurSTRpBDDgr3e6aC6MUy5XxMgPvg23s0c0qFLw6jgrGG4x
	YrwHKNg482a+CwOlz7lyEQN/teQIs3DtuowM9ZiA9N/kJJ57XTvry23ofszsjl+FVhuebHfEoje
	Kg6wIcZSZ2CKIYO0HwJ64W2VQcnlYnOQNxtB173kZKUdaJ
X-Google-Smtp-Source: AGHT+IGEZRKG6xvZHogMtre77VgiSxDaYZdqjTk10sRxgiSBiBGpyaYgS/fptxzapbkZ7Jl7Refn+g7Umm+MVSkwFF8=
X-Received: by 2002:a17:903:22cf:b0:235:e1e4:efc4 with SMTP id
 d9443c01a7336-236021cbd7cmr556885ad.14.1749152847887; Thu, 05 Jun 2025
 12:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-19-byungchul@sk.com>
 <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com> <aEGEM3Snkl8z8v4N@hyeyoo>
In-Reply-To: <aEGEM3Snkl8z8v4N@hyeyoo>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:47:14 -0700
X-Gm-Features: AX0GCFuQUodCCzxMMKtUv6I9nARNgb_4QREwvin7nUUsfjMZH4C0VBF2D5sefUE
Message-ID: <CAHS8izPvdKZncxARWUqUqjXgoMb2MmMy+PaYa8XCcWHCQT-CSg@mail.gmail.com>
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Byungchul Park <byungchul@sk.com>, willy@infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 4:49=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> On Thu, Jun 05, 2025 at 11:56:14AM +0100, Pavel Begunkov wrote:
> > On 6/4/25 03:52, Byungchul Park wrote:
> > > To simplify struct page, the effort to separate its own descriptor fr=
om
> > > struct page is required and the work for page pool is on going.
> > >
> > > To achieve that, all the code should avoid directly accessing page po=
ol
> > > members of struct page.
> >
> > Just to clarify, are we leaving the corresponding struct page fields
> > for now until the final memdesc conversion is done?
>
> Yes, that's correct.
>
> > If so, it might be better to leave the access in page_pool_page_is_pp()
> > to be "page->pp_magic", so that once removed the build fails until
> > the helper is fixed up to use the page->type or so.
>
> When we truly separate netmem from struct page, we won't have 'lru' field
> in memdesc (because not all types of memory are on LRU list),
> so NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic) should fail.
>
> And then page_pool_page_is_pp() should be changed to check lower bits
> of memdesc pointer to identify its type.
>

Oh boy, I'm not sure that works. We already do LSB tricks with
netmem_ref to tell what kind of ref it is. I think the LSB pointer
tricks with netmem_ref and netmem_desc may trample each other's toes.
I guess we'll cross that bridge when we get to it...

--=20
Thanks,
Mina

