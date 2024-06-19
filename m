Return-Path: <netdev+bounces-104905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91890F156
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C0E1F20F09
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1AC15279A;
	Wed, 19 Jun 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAk59eCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD2152E0C
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808734; cv=none; b=D9VlexDkqkzEGk7xmDszMDj2N309ofIpx7ci5VQv37NTWtmlnwmBPdj1fYVF8/RfSASABTDYuIWvIuhvpTm0wRMM1LbWJNg+fbv3vRRISIGAXYxazdAgyoWcIC7k2aexNqWMs0T6nc/dOuekBhxL7Tbs7IHaqPnTNWSo8Dd0DI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808734; c=relaxed/simple;
	bh=BuOiOKK5aDLx1DsgEYlG7WpZ+q5oJLQJBOiGxO38KCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNlGNUKNgbDuUJMJ4Q1QASjMi6NP4Yjdj6kXS7Qjyd91CbmYIGmK2jxyP6GY0ZGHwLv2p60cyf34PfYGE+fNWs4Ev2C6corczKVxzWJ8vBGp2hSAoiDtzjVwvCEduxgc+TuobMGs4R9fN2mHzN7CBgMdHlm1ZnUk9ZtS9UB5S5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAk59eCQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so8451a12.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718808731; x=1719413531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCq/+wTbdRe/MBrO3RZS+P/9P4jtjVOkuULaPB8CHj0=;
        b=mAk59eCQoAlcbu8O7zjzmyFslO9rYOq7Uz0Uf9pAsytJM6gLaZUpxLhnRTNCWoa2xf
         F1JM/Hi9t17+gaxVekceDqXrsitRsG+/bcDfiIhsIaZ/J9KVxD3Eamb8kEhreIjclqxc
         yZDFHO2yIhfXmIaEhkWBKfN31bLzTgfDhHIdy89slXk23Ey7PiUFQH0fdq/BTP3yGI4B
         uEij21p2Mg76jyz0kuXzMJJevMzaEAHS9oEdMHRy2ZGCEHLcuTVd+Oupl7WVru346p1O
         VdDWG/rv1kLs3wqn92UwWjeBJQN1nhL1TYxuGKLJybZ7puVUH3nDDtwi/1eLB7zr1HPO
         rbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808731; x=1719413531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCq/+wTbdRe/MBrO3RZS+P/9P4jtjVOkuULaPB8CHj0=;
        b=Pp/81bI4WM6l1wVF7ElE3UnSDlPsPsJW2azlRSKTd4Umw8moPmPt1QavnEmGVHofnc
         9LjYp+owIGZHwHLFvxucJn4E3xsfvKBXTxUzAMAlFtes7fv/gTwN+Ms7FnZ53nj6MmT2
         7/+Zkz94PZ62G+mlEPVpgpScdS55li8/CxvgsT0Qjy32lx3Rf1cnuCiQII3H6IFandzK
         Iseap6QTmD+91NS/rzaiOYRfYKbbtPuVJ3kEpSyRE4E95x/+Svpffn2M4op0VQHCMjf6
         0K2h9uDpAsiWz/fliNvVEBt725hL4PmNjzx8qfNX6VHBKv+lGxpANvBGUaMehmsDHJnA
         hEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+07NX4egYq5H94ckeMHnhJb01hZ+2u20iGPUZ5FvHdFGGrWUEFo1sg6wjVa+LXORqDCj7D69pCukCLy9wTDEWXFA0T/mQ
X-Gm-Message-State: AOJu0YzhqPIcHGIIGycuEZKknhwlaCiHtWswVT3PZFSTYJ6WV3kRGpB+
	3g0tnrM4n+wKYcWsL5Fs61mPXhu8gliOI8olxLNf6CFKmJsimBSJb1pFIeF7A7C4MxdrAOYqhMO
	zijvx+xoGC/RGhUZryN+Ex4yKhdJHeHAd3SMJ
X-Google-Smtp-Source: AGHT+IHeayQHdHc6ZlcrLi4grq50zw8dS0xUR0Buy/Wkr87vPElkshOw/Vlf/GrEiL6XwjjfhqWLGmem7XSf+8s7Xxo=
X-Received: by 2002:a05:6402:4304:b0:57c:b80b:b2f4 with SMTP id
 4fb4d7f45d1cf-57d0d6d1871mr206239a12.6.1718808727028; Wed, 19 Jun 2024
 07:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617095852.66c96be9@kernel.org> <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me> <Zm9fju2J6vBvl-E0@casper.infradead.org>
 <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me> <407790.1718801177@warthog.procyon.org.uk>
 <0aaaeabc-6f65-4e5d-bdb1-aa124ed08e8b@grimberg.me>
In-Reply-To: <0aaaeabc-6f65-4e5d-bdb1-aa124ed08e8b@grimberg.me>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 16:51:56 +0200
Message-ID: <CANn89iLQ+9GYYn0pQpueFP+aYHnoWhqZSws6t6VCNoxs8pwL7w@mail.gmail.com>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
To: Sagi Grimberg <sagi@grimberg.me>
Cc: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:54=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 19/06/2024 15:46, David Howells wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >
> >> On Mon, 17 Jun 2024 09:29:53 +0300 Sagi Grimberg wrote:
> >>>> Probably because kmap() returns page_address() for non-highmem pages
> >>>> while kmap_local_page() actually returns a kmap address:
> >>>>
> >>>>           if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !Pag=
eHighMem(page))
> >>>>                   return page_address(page);
> >>>>           return __kmap_local_pfn_prot(page_to_pfn(page), prot);
> >>>>
> >>>> so if skb frags are always lowmem (are they?) this is a false positi=
ve.
> >>> AFAIR these buffers are coming from the RX ring, so they should be
> >>> coming from a page_frag_cache,
> >>> so I want to say always low memory?
> >>>
> >>>> if they can be highmem, then you've uncovered a bug that nobody's
> >>>> noticed because nobody's testing on 32-bit any more.
> >>> Not sure, Jakub? Eric?
> >> My uneducated guess would be that until recent(ish) sendpage rework
> >> from David Howells all high mem pages would have been single pages.
> > Um.  I touched the Tx side, not the Rx side.
> >
> > I also don't know whether all high mem pages would be single pages.  I'=
ll have
> > to defer that one to the MM folks.
>
> What prevents from gro to expand frags from crossing PAGE_SIZE?
>
> btw, at least from the code in skb_gro_receive() it appears that
> page_address() is called directly,
> which suggest that these netmem pages are lowmem?

GRO should only be fed with lowmem pages.

But the trace involves af_unix, not GRO ?

I guess that with splice games, it is possible to add high order pages to s=
kbs.

I think skb_frag_foreach_page() could be used to fix this issue.

