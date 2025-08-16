Return-Path: <netdev+bounces-214273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD52B28B61
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE65B1C246A1
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C292264B6;
	Sat, 16 Aug 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fQ0sK/hx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127521E098
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329241; cv=none; b=J448va+Bdtu8axnGlD0Rx+PwhU64X4mxe93FHPTISGUzx2bcSxc3xNwtjtiDNjHk/GUIXc1qjWxpn+sqhMO+rHf22DBX3ybPx9WWqIxPlJBlaFrbDrcONMoviAri7FPMAJgBOVngDWKDSZjsnASe32t4Eq9goddYvu0NCgJnaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329241; c=relaxed/simple;
	bh=6t+pWXtNvn3PngcOHMQ0az8IKzQqpXpauzoUr3nAI3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB4pzdo/ArQFA3SYCrgP4SWhaZXHgXeedZG3uGzYE3XjZdKmhq4siMuXRO0hHmgb87flmbHi04UcUVUKKd4vZNxr/TDVmyJd5gVrrPiLV6JAqr5E8vsyA6S61M8HIQ4nu0Ojby5R/GR2+nkaXMeCjP71pvFUwbjqGXoQ1VjeVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fQ0sK/hx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb73621fcso317832966b.0
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755329236; x=1755934036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpiVReBk4pxi7WdSyaid9+sMC8akMMwfHAVHbbVirOA=;
        b=fQ0sK/hxNVwmGst+oxWhkC/dXmt6K/rFa859hVG8g47Zycx0qEC1R8nZoswGF1Hwz/
         jn8e1pBPnzIWD16izOjpOy8eDVvdmvgiqgdD6zO66cEEQXLIOB+dzgCHJqI77/x/V75D
         WKqU6wqV+lQyzGbECZ8Uhg/vnz9NrKkaewXIqO+tBpW8ZZGoEsCv0iPO3T/8pEQV232M
         heAao2AHf4HeKbyIX2OkWQu68voSvoA+7BIi32p6WS4MPJN9EbyIif7ki0VS44SWf7aN
         f1KLlGL3dXdVrT4eeuz3VdyY5ilo9N+DxPHx6Z1hB0Id6BRM5inOTUKXh3A3RaUFpcOy
         lPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755329236; x=1755934036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpiVReBk4pxi7WdSyaid9+sMC8akMMwfHAVHbbVirOA=;
        b=rO9XzX/lwvC7EdAEdYBiU7IZXMQksmMeiSoKNVQpFwoJomIzZNpQekJtvvqRkxu90y
         774uSywUZoUXQZib6hWylYRjKPgwaaJZKGsSblDqAiDQ//4TCUNHAJeMUTOlrh9hHxLm
         BwgaQH4ae99lvZhb5St6JYcKqDLu2rRz58GGaQXp7be6m3GZaNbSw8WVQXIhWtk8AubS
         50vbm39xPym0tPY5WhR79bZmaXI68BFRCvLJAGlJKaX/MdhIHfana7SMSGUaBim5NmkA
         TytECqvbtEn2O9LruYOggprJ+wcKY8zWZDBeF3d92rTES7ta6/aGlQcD5qszyPi/bTGT
         yCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHFJJs1jg6s+grR9XoT/6mnNJpzlF4whYVOw8dNuK6mBaQ2Q/bB5FvmF+frlgdW6Kpd7ljflA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vsDDLrJNbytDfiLOB8N/OCmwrUJ/okkSSfM0PWnAyY9Sj8NF
	0Xu0ylE3a6GCvW9YpSGp7u+g2qURggxbxebdIsPCEjMG26vBvyOcUw0HtQwfag0iww==
X-Gm-Gg: ASbGncuo5U0qU2fHvhM5E7P1/gaNz2bw6x+y+OTAeO6bGZQKk1ah8IbmW6Z4ouTt9+4
	INFeY/quVG79E81je0oIzmnfjohYnbOQX2Yl7+OgBP2Yt8AtUZTQiUra4/MCMt0nUtAsgTW/60I
	HnWx6/bDXcK/acz/fsvC1wYM9dOE96RmLzr04ZPHJrMXbjdqOhZzsR4qz+jt6c4lFn411BONelQ
	d5yFZJ0hgjg2K/u9JnfLvNKkfhOmcqQllWMyiGFBugJ0ZeN7MAVdeCHt+vwB+dgzQHPnMBCJWiu
	S6yhJ3Y4CzcS7WwVl1JYqBO+XYfq4HFy5HfI4DkHArS4ScMrBwYhz8d53VbKL57heCH70iM78bU
	yNktzxuULW0U=
X-Google-Smtp-Source: AGHT+IFg7imxaFEagNP0U5Ayia7U3tygLpXsVf6xKmyOpZitxVfNDophojGzUA2/MzddJEvPpEzhfA==
X-Received: by 2002:a17:906:6a0f:b0:ae8:4776:fbb1 with SMTP id a640c23a62f3a-afcdc03d360mr411785966b.11.1755329236202;
        Sat, 16 Aug 2025 00:27:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcea179esm312796166b.57.2025.08.16.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 00:27:15 -0700 (PDT)
Date: Sat, 16 Aug 2025 07:27:14 +0000
From: Wei Gao <wegao@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Menglong Dong <menglong8.dong@gmail.com>, kraig@google.com,
	lkp@intel.com, netdev@vger.kernel.org, dsahern@kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, oe-lkp@lists.linux.dev,
	kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
	davem@davemloft.net, ltp@lists.linux.it,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
Message-ID: <aKAy0nu2p6X9sKUw@localhost>
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com>
 <aJ_qbZDvDJwVoZGA@localhost>
 <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>

On Fri, Aug 15, 2025 at 07:35:10PM -0700, Kuniyuki Iwashima wrote:
> On Fri, Aug 15, 2025 at 7:18 PM Wei Gao <wegao@suse.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 01:27:12PM +0800, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash" on:
> > >
> > > commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: ip: order the reuseport socket in __inet_hash")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-ip-order-the-reuseport-socket-in-__inet_hash/20250801-171131
> > > base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 01051012887329ea78eaca19b1d2eac4c9f601b5
> > > patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2@chinatelecom.cn/
> > > patch subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
> > >
> > > in testcase: ltp
> > > version: ltp-x86_64-6505f9e29-1_20250802
> > > with following parameters:
> > >
> > >       disk: 1HDD
> > >       fs: ext4
> > >       test: fs_perms_simple
> > >
> > >
> > >
> > > config: x86_64-rhel-9.4-ltp
> > > compiler: gcc-12
> > > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> > >
> > >
> > > kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800)
> >
> > This kasan error not related with LTP case, i guess it triggered by network
> > related process such as bind etc. I try to give following patch to fix
> > kasan error, correct me if any mistake, thanks.
> 
> Note that the report was for the patch in the mailing list
> and the patch was not applied to net-next.git nor net.git.
Thanks for note. 
Since this email sent to LTP group so i got this. Since
i'm interested in this 'kasan' problem, so trying to fix it.
> 
> 
> >
> > From: Wei Gao <wegao@suse.com>
> > Date: Sat, 16 Aug 2025 09:32:56 +0800
> > Subject: [PATCH v1] net: Fix BUG:KASAN:slab-use-after-free_in__inet_hash
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  include/linux/rculist_nulls.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> > index da500f4ae142..5def9009c507 100644
> > --- a/include/linux/rculist_nulls.h
> > +++ b/include/linux/rculist_nulls.h
> > @@ -57,7 +57,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
> >   * @node: element of the list.
> >   */
> >  #define hlist_nulls_pprev_rcu(node) \
> > -       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
> > +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
> >
> >  /**
> >   * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
> > @@ -175,7 +175,7 @@ static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
> >  {
> >         WRITE_ONCE(n->pprev, next->pprev);
> >         n->next = next;
> > -       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> > +       rcu_assign_pointer(hlist_nulls_pprev_rcu(next), n);
> >         WRITE_ONCE(next->pprev, &n->next);
> >  }
> >
> > --
> > 2.43.0
> >

