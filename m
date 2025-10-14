Return-Path: <netdev+bounces-229094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BFBD81A4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B23C4EA56B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904EA2D8371;
	Tue, 14 Oct 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1egXWzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A22DAFC8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429307; cv=none; b=oXWCrmRaAYMKcFP0X1JhVqenKTE3i2b2PHx94ObeLfNoTxUuYG5I5mAtD8FBLkuFabw/G4eNynXuANAPHXvIC0xSsFfwlC89ea5MypvkdQTL8QG+b0TT/AG/cQ887Cq4GDafsNeTzT8Nl89h55MK44L3pQJGZl/7v4pYv7LNfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429307; c=relaxed/simple;
	bh=iX8ybayOoB+zfG3Kr8ZxGBnoJV6Y9ikxx5cuxcSDcqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcIR6DD2/N9dXbOW73z2Od++YIojOUnPDyIeM/2RksObQZniMN8EVk7pERK4yYKc7taQIZOpkupQsq2salVkMmRpeJJA1mi8lHa9f1tp4TCFIxssfme3JOMeGLHHpR9qvK43K6CpfUxpVIglDdyOmndaVxWsWocTVaanY7qG3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1egXWzn; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so3114382a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429305; x=1761034105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNULsJSShi9Qv044L8BUWXwBT0WWB+xiPbW9Mna22LI=;
        b=D1egXWzn9qKfGDk05loyj0KG1RHa+0j34FhjHtEvxf1y10PZv2ZJE8zZZT5BvGFrLs
         GawQZxlmjdYZFGFWufVxmz/CdIEPScQBsdmPJk+xzHrpP13PaMUQYje1B1svKRMjK+pa
         XVsSZMeT5fjFY8Ib/Zio3cP0DhqQz+Tb7RC7h4njR9mgi7Vby80J4zhxZN5G3B01X+kB
         JBqO5eyB0BODhzzVFZcl+8Jbw6FQUbkvFsDg+DfZeyWoHQGQBHm9Hd1b+ei2EXORnmof
         wWRJi3S5CnsXZNxuq4E6bz6QcL4iycEInp8cmws2Uszm4ralrVbk/8wou79zOBubg7wi
         1E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429305; x=1761034105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNULsJSShi9Qv044L8BUWXwBT0WWB+xiPbW9Mna22LI=;
        b=TopJFT1HdqiIMQEneRHEx+rNz42LNOmoXC949ZnEu1NQ3qsLG76QCOdumFqW2M623h
         eSEsjTHyPuv35crp31gkNsEo0efCMFQVBEW7nxOj4XixrinXkI0vvW10zobGSZgvX6Cx
         BQFtLIOH1w83rykMVw0h3n/UGm/FzfwUb3rO+etb13f7yjwlly9Pwe51hgKweNiWFYeQ
         HUE2mg52Z/YMB7FvfQ104vC5BZj/7eETqD0fhBzmZFzZrGYHUXGc1piTLyVsyspaP8je
         VO8lvDZ17Fof5bp29dgnyDMoZsIg63bvhH20HrJdaxiznv2U7mmqU9Sxuh4LIypnQtVC
         4Azw==
X-Forwarded-Encrypted: i=1; AJvYcCXoy31FO+MyRsgnNW5gFIOzkBLDMSfrrzg4PwTI0+CHYXzw26IIBd5xLbv9Gk+jM4ySTLKNEQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaE5vzWoooj/SjjkdPKtZxujl7qVZQkr7QkdZtClrvbLbIEb7y
	LPCO8JLkpSVZRY92SAIcKmcfc4sXVls6MohqlJ9KqrXNAceoB/KekdAA
X-Gm-Gg: ASbGncumn2DL8JLoTVSBMgYTYXUA0I4Y0DK5B119tG2C4kw1dSA73cBS1N76yhjrC4U
	xsOM1KaKmoK+HLPYiggxeP5wvWfM7Qx9tB60uMqilWGE8CtskkdpEIx6BdZniEPYDKERno5XIR3
	YND9g//C3yKeWa5RXWWgL9j0uDZ2DxG9Rtta/TY4CFI1eiG4M30llfbqJxQTFGDgFSewV25B1lZ
	Xzg8Kt6RmmFSnQ6g6rPW78xIRE/9GTJy05MubaRkIfS1NMS2f0DmhU61IjL6fvmPM8mDKkpIuWq
	1mXSBqvuquAurnGFq77TVLsahfaILJ3agesx+mjCtbFGCONZ4mIYls3/HNhyhD36xGtRDRJGquu
	cNPLxLRabie+prEpibi6bj74JB+/25PIbXrGKdWDbiNNlBozB2utX4J5+TwWDvn4nT0z7aCh63k
	3DRMtrdNRc4bqBdg==
X-Google-Smtp-Source: AGHT+IEgCv4Yi86mKXuSGOsGI+y5z9FGwzXobVA9uILnehkakJ1dqhotPD42azyffPNXp0Nf9zpNBg==
X-Received: by 2002:a17:902:d58e:b0:28e:8c3a:fb02 with SMTP id d9443c01a7336-2902723eeb6mr285920325ad.14.1760429305163;
        Tue, 14 Oct 2025 01:08:25 -0700 (PDT)
Received: from Barrys-MBP.hub ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08912sm155263155ad.78.2025.10.14.01.08.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Oct 2025 01:08:24 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: mhocko@suse.com
Cc: 21cnbao@gmail.com,
	alexei.starovoitov@gmail.com,
	corbet@lwn.net,
	davem@davemloft.net,
	david@redhat.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	harry.yoo@oracle.com,
	horms@kernel.org,
	jackmanb@google.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linyunsheng@huawei.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	roman.gushchin@linux.dev,
	surenb@google.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	willemb@google.com,
	willy@infradead.org,
	zhouhuacai@oppo.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
Date: Tue, 14 Oct 2025 16:08:12 +0800
Message-Id: <20251014080812.2985-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <aO37Od0VxOGmWCjm@tiehlicka>
References: <aO37Od0VxOGmWCjm@tiehlicka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 14, 2025 at 3:26 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> > On 10/13/25 12:16, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> [...]
> > I wonder if we should either:
> >
> > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > determine it precisely.
>
> As said in other reply I do not think this is a good fit for this
> specific case as it is all or nothing approach. Soon enough we discover
> that "no effort to reclaim/compact" hurts other usecases. So I do not
> think we need a dedicated flag for this specific case. We need a way to
> tell kswapd/kcompactd how much to try instead.

+Baolin, who may have observed the same issue.

An issue with vmscan is that kcompactd is woken up very late, only after
reclaiming a large number of order-0 pages to satisfy an order-3
application.

static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
{

...
                balanced = pgdat_balanced(pgdat, sc.order, highest_zoneidx);
                if (!balanced && nr_boost_reclaim) {
                        nr_boost_reclaim = 0;
                        goto restart;
                }

                /*
                 * If boosting is not active then only reclaim if there are no
                 * eligible zones. Note that sc.reclaim_idx is not used as
                 * buffer_heads_over_limit may have adjusted it.
                 */
                if (!nr_boost_reclaim && balanced)
                        goto out;
...
                if (kswapd_shrink_node(pgdat, &sc))
                        raise_priority = false;
...

out:

                ...
                /*
                 * As there is now likely space, wakeup kcompact to defragment
                 * pageblocks.
                 */
                wakeup_kcompactd(pgdat, pageblock_order, highest_zoneidx);
}

As pgdat_balanced() needs at least one 3-order pages to return true:

bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
                         int highest_zoneidx, unsigned int alloc_flags,
                         long free_pages)
{
        ...  
        if (free_pages <= min + z->lowmem_reserve[highest_zoneidx])
                return false;

        /* If this is an order-0 request then the watermark is fine */
        if (!order)
                return true;

        /* For a high-order request, check at least one suitable page is free */
        for (o = order; o < NR_PAGE_ORDERS; o++) {
                struct free_area *area = &z->free_area[o];
                int mt;

                if (!area->nr_free)
                        continue;

                for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
                        if (!free_area_empty(area, mt)) 
                                return true;
                }    

#ifdef CONFIG_CMA
                if ((alloc_flags & ALLOC_CMA) &&
                    !free_area_empty(area, MIGRATE_CMA)) {
                        return true;
                }    
#endif
                if ((alloc_flags & (ALLOC_HIGHATOMIC|ALLOC_OOM)) &&
                    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
                        return true;
                }

}

This appears to be incorrect and will always lead to over-reclamation in order0
to satisfy high-order applications.

I wonder if we should "goto out" earlier to wake up kcompactd when there
is plenty of memory available, even if no order-3 pages exist.

Conceptually, what I mean is:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c80fcae7f2a1..d0e03066bbaa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7057,9 +7057,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
                 * eligible zones. Note that sc.reclaim_idx is not used as
                 * buffer_heads_over_limit may have adjusted it.
                 */
-               if (!nr_boost_reclaim && balanced)
+               if (!nr_boost_reclaim && (balanced || we_have_plenty_memory_to_compact()))
                        goto out;

                /* Limit the priority of boosting to avoid reclaim writeback */
                if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
                        raise_priority = false;


Thanks
Barry

