Return-Path: <netdev+bounces-136003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41C99FED6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A628286D92
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405E4436A;
	Wed, 16 Oct 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaRfohmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6121E3A4;
	Wed, 16 Oct 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045964; cv=none; b=NmvCthY/XdhCoqprusxv4aYK+qyulbnf+2/kY/EwEsoYnoJqz9iQXLS5OqHUoEOwgKu9IWJpTjsyKUZnmYxIuRx8kcfipMwwGLBypG5z87W4zIa2ZnCTGWHbWttx7Lo+7xzXGI4lcY+tGw7RJWwlpz37apCiVACEEMpM28j3oZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045964; c=relaxed/simple;
	bh=61QEnGv7r/V4dRJPciuISw++1V6Hqfpt/sanWJeqZTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o56KYzyV/1Nl9m4bs2b+h8oGN5mXTOamP8f/6IF3Mac3NyuuD2ha82eKtPaQTudY+ciEFjBDawc0Z90EcwA575drBvxJIJuZGYaDs0MT0HnrhU3TnJWFlTOFFHu20RpWxgmrTkyU77l68R7w4bT+OisJtXAV+GHVeoKeiv3lOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaRfohmg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b5affde14so37362775ad.3;
        Tue, 15 Oct 2024 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729045962; x=1729650762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnnss9YrAmLM8Pd5DE9aHoH6/N0s4ful4+dkGtvyIHU=;
        b=LaRfohmgkjS/nso4AfvoCrFuV0cjW+P9/8YrU7EVW5jnLiBSpmCFxsftWQwh50luM/
         b/g7YXRt4Kx1PBRuj9o+IL9SFmlrzCxkXlT9DN60pwCmHhrtc5ToAq3W8cRE8T64iHpp
         KtvRD6jvAtupKsZVlgfx6G6AVfLeyL/akK0jA9qwZFZUtTD/JDLGpw+/PgydZYAQb8MG
         MW+4pI1GzGB/0QZlYIIH4zafzCXehH+aotgDkfCLC2U4/y5thLL+CaG62SYwa5t+KvU3
         0mMwsPcHeX3o7mjAZseWXxJ4osgU0lLfoQSwR9HIkXN3UjxbiVw6KUSvazvM9QcKriq5
         4eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045962; x=1729650762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vnnss9YrAmLM8Pd5DE9aHoH6/N0s4ful4+dkGtvyIHU=;
        b=miBCWQe3mNdlJgkxCD5x+nV1O1mphqM1XAbn7gsPa646nf6Qnhnnnb4mfNMRX0VUTK
         89CmVUhmafoNAnSJJCTE+7ZVrMrpHefRZ7UuqqmNsNIMqdycIvwvZoCbhCcS+lhFzrHt
         +60th1QN+b70Dh00C+4n4Sj/U1Z6+YN34HBy+QkRWyasMwA/UeY9f8SFpaybwpvnU+ZR
         Phw+u0FaPztmwtXrtTaLvca4nk+nzb3FqBrMAcHiWNsZBj/S5Em5CwGWYwRjixSf1Qxd
         pi9ISOwpH+c5preXRBsmS/X39riepyv91kAyEuLHDk085Cr11rJutww0Xp+VxRyTgAyG
         XH4w==
X-Forwarded-Encrypted: i=1; AJvYcCVICpCxnkjHTp5mV2pAtrwnWaEjxPFHaopwOxH4NDdcDJGlnXaVXq1cte5rBerDcB4CdzWCi4+SEGSmIus=@vger.kernel.org, AJvYcCVbxwiqIJkgrsjP6m1h0yiQMribZt+7mBuJC6ITcOufbzYAzo51tadzT9vs/t19Aa7TWpJyvE5W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6swuTfDgPZTumIBQZ3PNkjGcrlE5nlpyw8O0doY/FowlT7q/V
	ndxJa6OEdP68yFwG8K3Of0iFQZ6AXeDh2LQQGHCzhw0qpAzS4bNeS3AAnw==
X-Google-Smtp-Source: AGHT+IGzxUBRQJyDqPuEHtWzFFcsOUKSczMZetLLUBOw3VfVIvAG9pVN59ZvPnGBoEv8U0L4FIiIzA==
X-Received: by 2002:a17:902:cf10:b0:20c:c1bc:2253 with SMTP id d9443c01a7336-20d27ee0936mr38138045ad.32.1729045961967;
        Tue, 15 Oct 2024 19:32:41 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9a0d6sm19167555ad.88.2024.10.15.19.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:32:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:32:33 +0800
From: Furong Xu <0x1207@gmail.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Message-ID: <20241016103233.00001da9@gmail.com>
In-Reply-To: <CAC_iWjKr7ZBmYT+pp-hWRGWJfWiC5TmzEDPtkorqiL9WQOHtJQ@mail.gmail.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
	<601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
	<20241011101455.00006b35@gmail.com>
	<CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
	<20241011143158.00002eca@gmail.com>
	<21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
	<CAC_iWjLE+R8sGYx74dZqc+XegLxvd4GGG2rQP4yY_p0DVuK-pQ@mail.gmail.com>
	<d920e23b-643d-4d35-9b1a-8b4bfa5b545f@huawei.com>
	<20241014143542.000028dc@gmail.com>
	<14627cec-d54a-4732-8a99-3b1b5757987d@huawei.com>
	<CAC_iWjKWjRbhfHz4CJbq-SXEd=rDJP+Go0bfLQ4pMxFNNuPXNQ@mail.gmail.com>
	<625cdab0-7348-41a1-b07f-6e5fe7962eec@huawei.com>
	<CAC_iWjKr7ZBmYT+pp-hWRGWJfWiC5TmzEDPtkorqiL9WQOHtJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ilias,

On Tue, 15 Oct 2024 16:25:51 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> I am not sure I understand the problem here. If we are about to call
> page_pool_return_page() we don't care what happens to that page.
> If we end up calling __page_pool_put_page() it's the *callers* job now
> to sync the page now once all fragments are released. So why is this
> different from syncing an entire page?
> 
> >  
> > >
> > > Ok, since we do have a page_pool_put_full_page(), adding a variant for
> > > the nosync seems reasonable.
> > > But can't the check above be part of that function instead of the core code?  
> >
> > I was thinking about something like below mirroring page_pool_put_full_page()
> > for simplicity:
> > static inline void page_pool_put_page_nosync(struct page_pool *pool,
> >                                              struct page *page, bool allow_direct)
> > {
> >         page_pool_put_netmem(pool, page_to_netmem(page), 0, allow_direct);
> > }
> >  
> 
> Yes, that's ok. But the question was about moving the !dma_sync_size warning.
> On second thought I think it's better if we leave it on the core code.
> But as I said above I am not sure why we need it.

You can read this:
https://git.kernel.org/netdev/net/c/b514c47ebf41
https://git.kernel.org/netdev/net/c/5546da79e6cc

drivers/net/ethernet/renesas/ravb_main.c and
drivers/net/ethernet/freescale/fec_main.c are calling page_pool_put_page() with
dma_sync_size setting to 0.

I will send another patchset to add page_pool_put_page_nosync() as
Yunsheng Lin suggested, then convert drivers/net/ethernet/renesas/ravb_main.c
and drivers/net/ethernet/freescale/fec_main.c to the new
page_pool_put_page_nosync().

