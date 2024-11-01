Return-Path: <netdev+bounces-141014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354949B9191
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E914A280C89
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E031A00FA;
	Fri,  1 Nov 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wa9R8oC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497F19C566
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466671; cv=none; b=ReG0dn4VuyxLUX2ZUCDk1mG2IT45pazIkwFmP0T7h6wH4yGrLP08XFWcTqKQyDb7ePEDIBzKv3Dx2GOjspGN17r6zo86Qx1caOb+j/C8FFBYrD+UULj/8ZosnGw9wh8ZbQysLA1kCQOT/Thmtx54Q4OtnvadAJeUwdW+nq5KQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466671; c=relaxed/simple;
	bh=rBKvdBkDgEnZ8/2t7qkPf2PV6TUL/0RusHurefk/Ut4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX/lQKx8J7ZrlUDbQLB+//TwnzVAnGIfldIAGlPJMHrQCyXw66cn1cuIKvAMrigolxjKZUNfMAl3L3KA0wux8C9hHE+EV+9kkCX0xtUlKLzHN1IHWkmNHR1xjwOGvENKT3HY0TDOIuVFVpQgEb/aKUX9Xm9IGg+85I5aQOsz3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wa9R8oC3; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so236025ab.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730466668; x=1731071468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBKvdBkDgEnZ8/2t7qkPf2PV6TUL/0RusHurefk/Ut4=;
        b=Wa9R8oC30ojESYlGBaJN5FHhWFWGwcEABhXi/mNfOP60y6BuCHFir7o3TzMbmilvVq
         PT53JJ2yG/EGDClXQFIeNxVtIC2d0T0nNCq9OTngcuJ26YVOkTcrXA5zBeGQFnu7FDc1
         ObBB8rUPsHn/jS4Lh/EzOA2W68h+2befr+FLrxBasY/CbKW2LQdNQNIgAgaA1gvHvjvP
         VfsOKzT7C3RS3ftszzU4IOCrXkMnbjCTYk/nM97H//8sYv0oAWHO/v0ZxlQnHNBOdFFY
         dP4iZVsQ5acussnrc5cwIgYs72l8Q4sffYeIy5R8EKEDAMr9ELOUhxowAmR3bapuRcEA
         SyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466668; x=1731071468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBKvdBkDgEnZ8/2t7qkPf2PV6TUL/0RusHurefk/Ut4=;
        b=koF4cCa/E68up+YPsJtEmQ1uT3P0HiMz17r4JHVRf7Qgy5ZCJMnu2r6qJcnNcMqAzM
         11sNqgESVGIjFzS6moAUEA80ZYiDFkaawPFkfDZ63MY6cXWE7ZuzNtDE5G7g0RIWOZSt
         Cr2Ee2/tkz/ul30De9dKdkBPEsadHOHSvZio63easNuSfbSogD6Devt82NMYwLLsiRhi
         qYz6yWDK9G6DpwMzYYXrYkQicqOXquNTB2J+JiY9IMhPVYoth+VMRPFisIuSvPq/kB+6
         YkRPPl9gBQY+fwT0yDNKr+a5VVR6h4szOxcAlV5lJ8l5oJWOcMkUagjJhT23I9nre6m2
         u/tA==
X-Gm-Message-State: AOJu0YyNvqa+mswt/coWdQS3fyUWsKoIAooDykp7WZ3jFvTzp4yr8DbO
	+bJRU+icYlopeAZ++FcZD/VIEiCN5naxghGtBpPQEWsr5azTvn1exkk1PPoXhb8FkxEO4En7xC+
	+tJNR4Lr/S8QRv9X2nECEagbxO81VeBrw29aW
X-Gm-Gg: ASbGncvsOAkAcViqtZSomy33Py5DbUiBwcweWRvafqkqOsYxUlZb7EuktAWLCzQFzMd
	YDeZnYBDpAKp3TMUDznYbcZ6G5JTxhIM=
X-Google-Smtp-Source: AGHT+IGy5jtPAQs70nZmSVQRpEpNW+aE/1kV6A2Lr9FjnVTsOCY2FVzGfSbPMwj3G1YUCRVN/VYED/7JXkuD6qBixIQ=
X-Received: by 2002:a05:6e02:1a08:b0:3a3:dab0:2399 with SMTP id
 e9e14a558f8ab-3a6a9414a07mr7484945ab.27.1730466668433; Fri, 01 Nov 2024
 06:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
 <20241029204541.1301203-3-almasrymina@google.com> <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
In-Reply-To: <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 06:10:56 -0700
Message-ID: <CAHS8izMgF8nx87D9pWPmq1pfDm1v8x5Z6gc_eMHcYo8zKX-Lrw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/7] net: page_pool: create page_pool_alloc_netmem
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 4:14=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/10/30 4:45, Mina Almasry wrote:
> > Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.
> >
> > This enables drivers that want currently use page_pool_alloc to
> > transition to netmem by converting the call sites to
> > page_pool_alloc_netmem.
>
> For old API, page_pool_alloc_pages() always return a whole page, and
> page_pool_alloc() returns a whole page or a page fragment based on the
> requested size.
>
> For new netmem API, page_pool_alloc_netmems() always return a whole
> netmem, and page_pool_alloc_netmem() returns a whole netmem or a netmem
> fragment based on the requested size.
>
> Isn't it a little odd that old and new are not following the same
> pattern?

Hi Yunsheng,

The intention is that page_pool_alloc_pages is mirrored by
page_pool_alloc_netmems.

And page_pool_alloc is mirrored by page_pool_alloc_netmem.

From your description, the behavior is the same for each function and
its mirror. What is the gap in the pattern that you see?

--=20
Thanks,
Mina

