Return-Path: <netdev+bounces-73376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EBD85C319
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2222FB24B20
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334B78665;
	Tue, 20 Feb 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IO6VsUpf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7577A05
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451751; cv=none; b=Wkwc+ByWcLd/JOwiGViXnU9Ybtmty7nDGE3DohDa4aRTVGGnzATM9N5LbDRXPRZlvr/C0VfXg2KJzTLn4aG0pFRIa4yKwRaPxLd43Nu0k9yMhnMF62xrF46KPWwEzMDElY20BLW/wHOJFOkTCMRXtnbDcDkJuY4hbQJy95MuQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451751; c=relaxed/simple;
	bh=hqb1KpK8idTkVHw05D9DaOecFdA77V8n0hYYGqZ4o2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qsUQN1CTyB76sfwuVnsClpyfwuq3bxvBdZAu2LMlbLLv1lH8sO7+je3eXjw3R3syBl502OcfdeRJhThz+IHbaJMagjB58082FMOl8caPHyXQ+4v3CWSFGcg8pR0yBOckCJl+zGqTv8YSETXlJqyiQD5YWmI0CCL2pTl0fvJYPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IO6VsUpf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so5488501a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708451748; x=1709056548; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cs7a6JxSri8UPMBfIFAC6zzBgd9E4B30piovcQly+DY=;
        b=IO6VsUpfVdC8MenT19L0XGvhc72FARmcJPBnMmmthFdvbHdKXRVq+WWxpXN4SuwPRo
         eAScsA7VkmTO7dzA0RzHXM/cewb1NE6T+mRZPam1B2vqXR5CFyvzMi2AADzmmxuO22PB
         0li2nLbSp/IyA9XSPdPHvILKCldq+Rf4aRPMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708451748; x=1709056548;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs7a6JxSri8UPMBfIFAC6zzBgd9E4B30piovcQly+DY=;
        b=Tdu/VROqr0kcyivIu6X3yl9FLaabd2t2uUAbIEr11wGYqLRZ8ULNNu9AGmc/bKJe2E
         ZqNd6zR+or32HKwSaKWDqjo8F0g3PsLR4dpB7N1Hxhkgq1EeJyr2SMcOf0x9Y6AOCU8g
         1DFLErOEBVHxvd9HMsGiCXKBjrYs6jAq8E5z0KYcR3cW/hqgPFAY2mDMMYvf2XzlDm0z
         jLDvdzgZM/qsuW2rJYzoK64LLH5ufU3H5xdkFPnOWwbXiGJe3URgIsHPP8Q1Lxn/UT+J
         /OOmtra1YwwsIq8Leh0yYXf7NOP0Av0H6GuzZ80l6R0X+2IH1SLf/zpFZH0acYk/f45r
         5Juw==
X-Forwarded-Encrypted: i=1; AJvYcCVtjaBun4ke6dcXvVXW+ABEtmjb0tszSfjAYw/NltcZjSujVu3G+/uW/TkPTVb3mZBYAQbmeesJLZ1HZsN3sjKIry1Gktsc
X-Gm-Message-State: AOJu0Yy5epTwcRtPhzxahg7iOKJsmtKwqlmUwhrnqsSCTjAdC0CJKqFv
	nKuUXWH/Hudc/bvIoWUG8bPTjnh9w2HF8+fE0aNF+ewlOKxFtDkf9RrKgIfrfmchl7PTEHsLG0n
	ySAjKoQ==
X-Google-Smtp-Source: AGHT+IE5PaYtgAmcC/JggxDszCk8XgeWbgcbMfQeiCkoT0Pye6gJqcWcBm2LyDudeeRNxjiJ2IFiKg==
X-Received: by 2002:a17:906:29cf:b0:a3f:17fd:620c with SMTP id y15-20020a17090629cf00b00a3f17fd620cmr954351eje.27.1708451748114;
        Tue, 20 Feb 2024 09:55:48 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906c41700b00a3d81b90ffcsm4157102ejz.218.2024.02.20.09.55.46
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 09:55:47 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so7811115a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:55:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKWjzSgetkySzm31d9gJO7nR3jT4UbacZ0os/qlqcY+jYsaOWPeuMZuNydquk0DnrDmQgRdtio8O3Va5HCAGMSqZQ+QSQK
X-Received: by 2002:aa7:d393:0:b0:564:3d68:55f5 with SMTP id
 x19-20020aa7d393000000b005643d6855f5mr5518556edq.5.1708451746591; Tue, 20 Feb
 2024 09:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-6-tj@kernel.org>
 <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
In-Reply-To: <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2024 09:55:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
Message-ID: <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
Subject: Re: [PATCH 5/8] usb: core: hcd: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 09:25, Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> In the past this tasklet removal was held up by Mauro's device not properly
> streaming - hopefully this no longer the case. Cc'ing.
>
> https://lore.kernel.org/all/20180216170450.yl5owfphuvltstnt@breakpoint.cc/

Oh, lovely - an actual use-case where the old tasklet code has known
requirements.

Mauro - the BH workqueue should provide the same kind of latency as
the tasklets, and it would be good to validate early that yes, this
workqueue conversion works well in practice. Since you have an actual
real-life test-case, could you give it a try?

You can find the work in

   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
refs/heads/for-6.9-bh-conversions

although it's possible that Tejun has a newer version in some other
branch. Tejun - maybe point Mauro at something he can try out if you
have updated the conversion since?

                Linus

