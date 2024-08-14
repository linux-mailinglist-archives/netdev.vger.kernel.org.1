Return-Path: <netdev+bounces-118582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4952952216
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F881F231EC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C01B14F8;
	Wed, 14 Aug 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCYYmTs/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB992B679;
	Wed, 14 Aug 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660488; cv=none; b=eV34tG4xRw0bRLxmmuSUET3NPu+MIh3s7SmrFNudEy5iNEHqGSZudG/FXqOrVqT9RfsvwLCFHu8Km9/qVqnnZDKzn47uV0lwMGTU+PF9+eM0cWf4AfiGhMnxzjap93jvmCSAJbwzWZWUaeYqYfSQGEKfi8xUHZf6CUo7c2uvrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660488; c=relaxed/simple;
	bh=AwWtjohlWyM+W0d3NPf+9sbhOWEflVlPFIyTONE7alA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNYcsopbzRI8xFvcTh0Y0/TljMFRYJZzmGiGtj0zmzOpuoMtDSr30FqttOGs9Ba5AdWBHAN/bUQCOW5oqBM1CTbwfgkMcViBJiEtyM8xWqUZvvqzNaYN2GGDG0M7QnWlMoJs4Zi2LbcbQ/DJBYiKCHY9uP+sij8iv07NIkyu+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCYYmTs/; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3dd16257b87so79115b6e.2;
        Wed, 14 Aug 2024 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723660485; x=1724265285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7fBiR5n5YVska8nCpcg/V51Z88Uf3Sx/H0PEnfkJY0=;
        b=BCYYmTs/efx88wWFU/PXoKJ1I90l0f/wfSdHQFMBe/JXGUGfA4X+hlXDr9cQwT65RM
         drFaybZLpiKdc22k3OgS8jlHkKrC0QXcF7l7eHfNqXlQqpmsLMO3qB6Qk/ZnhRlz/0C+
         TOEwv0IszsvdozbIWFKx8cPgi94FqmXMhV7J2LZmChlIo0YjmtQGoh7eu2UQSCQ1CWGj
         kcjTSbgzB0kW2Sns3/hSC9VUgb2QvD1m7YccWMZ2Wn5R8U457jSpw+hYEFHFWwIN+n+p
         AGzf4xwBUEYnh74KKIQOS1wCv0icWgRWcoaUIw/Lu1jC765DQZR8yLy7dss7YvZFSAcv
         felQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723660485; x=1724265285;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7fBiR5n5YVska8nCpcg/V51Z88Uf3Sx/H0PEnfkJY0=;
        b=UVnt2BuguTkfI3ivNQpb/uz2KzgFKrQrTBQFptyCkrHYWQWsbdmN1B/2xH7DxaYS/n
         UzkQ4ucP3uHvr+k9RjcLcvPRfjKGYgcPfKXuVRQ/XHTC4WZ7eyD0HsUtoCpF9NwxCEe+
         VJF8UVeOFlZ19pNLMjK/capSjRSJEIbNx0kAyuCnAUunLT/r6JQdAK2cfw32/lPPAzwM
         D0MMMckt5dowmQxE+XiCISEimnDyFX6bluLr8KufqHoio/RCQ/IN5rDWWfThAky8hUcy
         Xpxz5a0qzU8gogW6qMiJc+oyt1QHbeRFftXT3CjD78oEL8m8xCqQXNTciH0IdvCo7dJI
         WkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7sAxMJDYFwvUm+p2rHLXtk8c7HzEd8AL2ylXw1TU1qmUo3J8P1KXXbvHy7LXDllJajtguc1k40r1VdEc=@vger.kernel.org, AJvYcCXLgs9FLFQrZ8GHtjvw/4vel/tgFE1DEiU8G6hNzqaJcCRJY4RoJfsLFEKDeuYgcCRh6i3aNoz2@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwimfY5JHwvEmYLmDZkpIrWymlkny0HidXVCDT8AJQFC7VTvA
	Dj6WpS2jV0MBn7yJkOuNwQxyVbOszd309xFEzAmFHys3l8GaXNvM
X-Google-Smtp-Source: AGHT+IGp8VHH+vp2sKO+De9Eidc0HJA7E4M5OPTwjtvkmOM1+JzDyIk439bt2yD24VQafvrTKUyYKg==
X-Received: by 2002:a05:6808:3a15:b0:3d5:2afc:94f5 with SMTP id 5614622812f47-3dd298de1efmr3814010b6e.10.1723660485303;
        Wed, 14 Aug 2024 11:34:45 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3dd060bc374sm2194680b6e.51.2024.08.14.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:34:44 -0700 (PDT)
Message-ID: <31546afa1e9b715f01e43a1ef9389415a8f8b05c.camel@gmail.com>
Subject: Re: [RFC v11 09/14] mm: page_frag: use __alloc_pages() to replace
 alloc_pages_node()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 14 Aug 2024 11:34:42 -0700
In-Reply-To: <5df99f22-801c-4b0a-a3bc-0e2e0fadfdd3@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-10-linyunsheng@huawei.com>
	 <e9982acd0eba5d06d178d0157aedfba569d5a09a.camel@gmail.com>
	 <e7a9b79b-f1ab-4690-a3cf-4e9238e31790@huawei.com>
	 <CAKgT0UdxB3OqS41PcGrB9JNkYKxsTDGx_sebkas+-A2bcx=kUA@mail.gmail.com>
	 <5df99f22-801c-4b0a-a3bc-0e2e0fadfdd3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-25 at 20:19 +0800, Yunsheng Lin wrote:
> On 2024/7/24 23:03, Alexander Duyck wrote:
> > On Wed, Jul 24, 2024 at 5:55=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> > >=20
> > > On 2024/7/22 5:41, Alexander H Duyck wrote:
> > >=20
> > > ...
> > >=20
> > > > >      if (unlikely(!page)) {
> > > > > -            page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> > > > > +            page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
> > > > >              if (unlikely(!page)) {
> > > > >                      memset(nc, 0, sizeof(*nc));
> > > > >                      return NULL;
> > > >=20
> > > > So if I am understanding correctly this is basically just stripping=
 the
> > > > checks that were being performed since they aren't really needed to
> > > > verify the output of numa_mem_id.
> > > >=20
> > > > Rather than changing the code here, it might make more sense to upd=
ate
> > > > alloc_pages_node_noprof to move the lines from
> > > > __alloc_pages_node_noprof into it. Then you could put the VM_BUG_ON=
 and
> > > > warn_if_node_offline into an else statement which would cause them =
to
> > > > be automatically stripped for this and all other callers. The benef=
it
> > >=20
> > > I suppose you meant something like below:
> > >=20
> > > @@ -290,10 +290,14 @@ struct folio *__folio_alloc_node_noprof(gfp_t g=
fp, unsigned int order, int nid)
> > >  static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gf=
p_mask,
> > >                                                    unsigned int order=
)
> > >  {
> > > -       if (nid =3D=3D NUMA_NO_NODE)
> > > +       if (nid =3D=3D NUMA_NO_NODE) {
> > >                 nid =3D numa_mem_id();
> > > +       } else {
> > > +               VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> > > +               warn_if_node_offline(nid, gfp_mask);
> > > +       }
> > >=20
> > > -       return __alloc_pages_node_noprof(nid, gfp_mask, order);
> > > +       return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> > >  }
> >=20
> > Yes, that is more or less what I was thinking.
> >=20
> > > > would likely be much more significant and may be worthy of being
> > > > accepted on its own merit without being a part of this patch set as=
 I
> > > > would imagine it would show slight gains in terms of performance an=
d
> > > > binary size by dropping the unnecessary instructions.
> > >=20
> > > Below is the result, it does reduce the binary size for
> > > __page_frag_alloc_align() significantly as expected, but also
> > > increase the size for other functions, which seems to be passing
> > > a runtime nid, so the trick above doesn't work. I am not sure if
> > > the overall reduction is significant enough to justify the change?
> > > It seems that depends on how many future callers are passing runtime
> > > nid to alloc_pages_node() related APIs.
> > >=20
> > > [linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org=
 vmlinux
> > > add/remove: 1/2 grow/shrink: 13/8 up/down: 160/-256 (-96)
> > > Function                                     old     new   delta
> > > bpf_map_alloc_pages                          708     764     +56
> > > its_probe_one                               2836    2860     +24
> > > iommu_dma_alloc                              984    1008     +24
> > > __iommu_dma_alloc_noncontiguous.constprop    1180    1192     +12
> > > e843419@0f3f_00011fb1_4348                     -       8      +8
> > > its_vpe_irq_domain_deactivate                312     316      +4
> > > its_vpe_irq_domain_alloc                    1492    1496      +4
> > > its_irq_domain_free                          440     444      +4
> > > iommu_dma_map_sg                            1328    1332      +4
> > > dpaa_eth_probe                              5524    5528      +4
> > > dpaa2_eth_xdp_xmit                           676     680      +4
> > > dpaa2_eth_open                               564     568      +4
> > > dma_direct_get_required_mask                 116     120      +4
> > > __dma_direct_alloc_pages.constprop           656     660      +4
> > > its_vpe_set_affinity                         928     924      -4
> > > its_send_single_command                      340     336      -4
> > > its_alloc_table_entry                        456     452      -4
> > > dpaa_bp_seed                                 232     228      -4
> > > arm_64_lpae_alloc_pgtable_s1                 680     676      -4
> > > __arm_lpae_alloc_pages                       900     896      -4
> > > e843419@0473_00005079_16ec                     8       -      -8
> > > e843419@0189_00001c33_1c8                      8       -      -8
> > > ringbuf_map_alloc                            612     600     -12
> > > __page_frag_alloc_align                      740     536    -204
> > > Total: Before=3D30306836, After=3D30306740, chg -0.00%
> >=20
> > I'm assuming the compiler must have uninlined
> > __alloc_pages_node_noprof in the previous version of things for the
> > cases where it is causing an increase in the code size.
> >=20
> > One alternative approach we could look at doing would be to just add
> > the following to the start of the function:
> > if (__builtin_constant_p(nid) && nid =3D=3D NUMA_NO_NODE)
> >         return __alloc_pages_noprof(gfp_mask, order, numa_mem_id(), NUL=
L);
> >=20
> > That should yield the best result as it essentially skips over the
> > problematic code at compile time for the constant case, otherwise the
> > code should be fully stripped so it shouldn't add any additional
> > overhead.
>=20
> Just tried it, it seems it is more complicated than expected too.
> For example, the above changing seems to cause alloc_slab_page() to be
> inlined to new_slab() and other inlining/uninlining that is hard to
> understand.
>=20
> [linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vml=
inux
> add/remove: 1/2 grow/shrink: 16/11 up/down: 432/-536 (-104)
> Function                                     old     new   delta
> new_slab                                     808    1124    +316
> its_probe_one                               2836    2876     +40
> dpaa2_eth_set_dist_key                      1096    1112     +16
> e843419@0f3f_00011fb1_4348                     -       8      +8
> rx_default_dqrr                             2776    2780      +4
> pcpu_unmap_pages                             356     360      +4
> its_vpe_irq_domain_alloc                    1492    1496      +4
> iommu_dma_init_fq                            520     524      +4
> iommu_dma_alloc                              984     988      +4
> hns3_nic_net_timeout                         704     708      +4
> hns3_init_all_ring                          1168    1172      +4
> hns3_clear_all_ring                          372     376      +4
> enetc_refill_rx_ring                         448     452      +4
> enetc_free_rxtx_rings                        276     280      +4
> dpaa2_eth_xdp_xmit                           676     680      +4
> dpaa2_eth_rx                                1716    1720      +4
> ___slab_alloc                               2120    2124      +4
> pcpu_free_pages.constprop                    236     232      -4
> its_alloc_table_entry                        456     452      -4
> hns3_reset_notify_init_enet                  628     624      -4
> dpaa_cleanup_tx_fd                           556     552      -4
> dpaa_bp_seed                                 232     228      -4
> blk_update_request                           944     940      -4
> blk_execute_rq                               540     536      -4
> arm_64_lpae_alloc_pgtable_s1                 680     676      -4
> __kmalloc_large_node                         340     336      -4
> __arm_lpae_unmap                            1588    1584      -4
> e843419@0473_00005079_16ec                     8       -      -8
> __page_frag_alloc_align                      740     536    -204
> alloc_slab_page                              284       -    -284
> Total: Before=3D30306836, After=3D30306732, chg -0.00%

One interesting similarity between the alloc_slab function and
__page_frag_alloc_align is that they both seem to be doing the higher
order followed by lower order allocation.

I wonder if we couldn't somehow consolidate the checks and make it so
that we have a function that will provide a page size within a range.


