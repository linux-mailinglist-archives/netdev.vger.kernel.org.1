Return-Path: <netdev+bounces-130216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A370989312
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 06:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9278B23793
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D593BB50;
	Sun, 29 Sep 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="vCc2+lZP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4E184D
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585648; cv=none; b=GiWaRT0E05G/qYbGihd5xX1yhJOqvhH5GaMSaB9wAYY9ulMbU6OL5y8psLpgsMJr2c9ZJIis0PYBQ0DANhSlYBSqqjhCntieAtHqZAW8U1n+7wYBOUiNz9nsABTaUj/ZJDF+gHogECJ8ynRGtUxvtySTqNEj3N6ROGCqVa58b3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585648; c=relaxed/simple;
	bh=DDcStd9dj4GhKmuuYWqPICakSvn7nJ2Imq8JsqCJzSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/G9rP8nfkP1bK39AoGgOUtOS6CntKz19pjhP7lMthLzsM8sLqmiY0pbjHw1bg0GCwk0gobdr37XwZuYYBELpZ8RB0WC8T47mgIewtNlXvZOZyqSbAmOkDX2sKtzcZdeY+bMTGsQE1N/1gNppfxG8M3JEzTji8GNZ2NkxNyXOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=vCc2+lZP; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DDcStd9dj4GhKmuuYWqPICakSvn7nJ2Imq8JsqCJzSk=; t=1727585646; x=1728449646; 
	b=vCc2+lZPgZDiMFaB3yR22leoXnYrswqYNyfDC/EWWSiYRBtKIij06fV+lrghZIeqwmWWcJUeFv6
	Y3xQ+PT7QvhLbNmnjlTEjtkjUC91EXZopw95jYIA5/2FYqlkuNLOjIkxw5u2o1a/ue95fjxj7R8rO
	9fGCinn2ySkXnqzvP2ml1FLyJuQQPFMiPKUttCbrJHVTBJ6HS6PXjsQKg8qgzp0ZTp4NBaqyR5IBI
	BiSw1zrpZbk9TVa7vH96Vxc4IrS2iMSZRTJSpPassA04t3DknG46hxX0bwZPyn7FT60Wu3Lmon0Ft
	ztbZbQyYNzyk0H2v/yOMi3yoUSIillJL4NQA==;
Received: from mail-oo1-f45.google.com ([209.85.161.45]:54760)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1sulwV-0005Wf-Pz
	for netdev@vger.kernel.org; Sat, 28 Sep 2024 21:54:00 -0700
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e1cdfe241eso1240246eaf.1
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 21:53:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YzDgo2VYVNimUynS6yBJi21FY8HpecxcV4pTYacwtfGEVlVGXBq
	DAn76tHQJGjxx9QypEG78pl2Kv7Y9/x4Phr3XQXHBMbgJabpNz1dkKUnnfIG1npsmh4uEtFRM9f
	AbRQhkRQvspXVWzJo+ps90zpJh5g=
X-Google-Smtp-Source: AGHT+IFJE/Z3+jHTyPbGtyE9yJ7jWOG/wCGHZcAUGDQ6NbNG9UTUGIUvZkwc3NA8SWPS6KwYgx0NpMrwCvLNO1WyQwo=
X-Received: by 2002:a05:6870:670b:b0:261:39d:afa1 with SMTP id
 586e51a60fabf-28710aad16amr4422444fac.22.1727585639166; Sat, 28 Sep 2024
 21:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXJAmxbJ7tN-8c0sT6WC_OBmJRTvrt-xvAZyQoM0HoNJFYycQ@mail.gmail.com>
 <577c1d8b-1437-4ff2-b3d1-1261c4f73fec@intel.com>
In-Reply-To: <577c1d8b-1437-4ff2-b3d1-1261c4f73fec@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sat, 28 Sep 2024 21:53:22 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwMNfoRK42veVS5uFgr0dVZ2G=jj6bR-kn2xV2v+TGFww@mail.gmail.com>
Message-ID: <CAGXJAmwMNfoRK42veVS5uFgr0dVZ2G=jj6bR-kn2xV2v+TGFww@mail.gmail.com>
Subject: Re: Advice on upstreaming Homa
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: ae7d61d5ad21aa0d569d6b6c8168eb46

On Fri, Sep 27, 2024 at 4:51=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 9/27/24 06:54, John Ousterhout wrote:
> > I would like to start the process of upstreaming the Homa transport
> > protocol, and I'm writing for some advice.
>
> I would start with a RFC mail stating what Homa is, what it will be used
> for in kernel, what are the users, etc.

I think Homa is already pretty well known to the netdev community:
I've given talks on it at multiple NetDev conferences and there are a
couple of published papers describing both the overall protocol and
the Linux implementation.There is also a Wiki with lots of links to
topics related to Homa
(https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview). Are
you suggesting that Homa needs RFC standardization before uploading?
I'd prefer to wait on standardization so that the protocol can evolve
a bit more based on user experiences.

> I saw your github readmes on current OOT module and previous one on DPDK
> plugin. Netdev community will certainly ask how it is connected to DPDK,
> and how it could be used with assumed value of 0 for DPDK (IOW upstream
> does not care about DPDK).
>
> describe what userspace is needed/how existing one is affected

There are a couple of Homa GitHub repos, and I suspect you may be
looking at the one that is implemented in user space using DPDK. The
kernel module I'd like to upstream is in this repo:
https://github.com/PlatformLab/HomaModule. This is an in-kernel
implementation that doesn't use DPDK.

> > Homa contains about 15 Klines of code. I have heard conflicting
> > suggestions about how much to break it up for the upstreaming process,
> > ranging from "just do it all in one patch set" to "it will need to be
> > chopped up into chunks of a few hundred lines". The all-at-once
> > approach is certainly easiest for me, and if it's broken up, the
> > upstreamed code won't be functional until a significant fraction of it
> > has been upstreamed. What's the recommended approach here?
>
> the split up into patches is to have it easiest to review, test
> incrementally, and so on

I would be happy to have Homa reviewed, but is that likely, given its
size? In any case, Homa has pretty extensive unit tests already.

> if you will have the whole split ready, it's good to link to it,
> but you are limited to 15 patches at a time
>
> >
> > I'm still pretty much a newbie when it comes to submitting Linux code.
> > Is there anyone with more experience who would be willing to act as my
> > guide? This would involve answering occasional questions and pointing
> > me to online information that I might otherwise miss, in order to
> > minimize the number of stupid things that I do.
> >
> > I am happy to serve as maintainer for the code once it is uploaded. Is
> > it a prerequisite for there to be at least 2 maintainers?
>
> are you with contact with the original implementers/maintainers of those
> 15K lines? one thing that needs to be done is proper authorship, and
> author is the best first candidate for a maintainer (though they could
> be simply unwilling/not working in the topic anymore)

I am the original implementor/maintainer of almost all of those 15K lines.

> 1 maintainer is not a blocker
>
> >
> > Any other thoughts and suggestions are also welcome.
>
> no "inline" functions in .c,
> reverse X-mass tree formatting rule
> no space after a (cast *)
> use a page_pool
> avoid variable length arrays
> write whole thing in C (or rust, no C++)

Most of these are already done; the ones that aren't (e.g., reverse
Xmas-tree formatting, which I only recently discovered) will be done
before I submit anything.

