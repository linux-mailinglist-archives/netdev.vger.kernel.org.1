Return-Path: <netdev+bounces-112789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44C93B358
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D21C209EE
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3D1591EA;
	Wed, 24 Jul 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5HWbUwO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB85158DA3;
	Wed, 24 Jul 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833443; cv=none; b=Zy3wC129ri72VHYTNE9qBzvpn+aN1HelrdfLGpyT7aKrnFlcEFiYM0lzYjex82cbJEz2fPiIwJTQpFyNTet7qtIrjdk2x39xPZKBa5vUa0hgrhSlGByByqU/6FGxsdj6yysqTprKaJVTimLImHSRCGUGR4md1/KV72kvt3k+Esk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833443; c=relaxed/simple;
	bh=hBpWpJkWyTZ8je65jaFAdKJXtzeCLvXLbr/NJo1n6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZDh41fgiK0tG6GfHlLPdH5e07A/xO0E+xFaH9x7JX4sB5Biuf4/hNb53vk5GxkAB6CfHZgKmjdJb4jreTS1KJbZ+g81HesQVQL/T0pTj2/h6Y9nU2l4h4xixVaJxJlxshJDhy5ZlXBTNrVyw+lQfUUjh9VLpv4FC71aCOnYrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5HWbUwO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso52536895e9.3;
        Wed, 24 Jul 2024 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721833440; x=1722438240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPvWKR2PLPzi3D5yHk1cl8pcpkDoIM3okaADhc+L+64=;
        b=C5HWbUwOGOWI8jtE1LdBvnEgkDyjX6f0EAMrQaV3B3KvZCeScAVm0HJv+IE/GzTiM9
         M/Wh2GynN79tccdmG5cvTbfAsbOt6UUdPxldZGmx8H4m2hXjlf4qiA1oGFyJWL5GV7KA
         z7vWjZ3+E/Lkwc0WkiZ8mkPGj9Q4t7jF/C1e1YFJ96KgVldcNxDbnvSsPHZ1vaTsg1jc
         6pj7v85wl4K58M5tHl5cdegI0X1iwbaQrYCyrqdgpMSDR99zV6IfW3js8HGTiAG1z/Il
         Fz3WkqOe6BehudUrYt9JMFPVHYZozilfJNwDS+7MQQK24Ffzm77vg0VskpD3hLscHIow
         X4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721833440; x=1722438240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPvWKR2PLPzi3D5yHk1cl8pcpkDoIM3okaADhc+L+64=;
        b=FcGGDDdtADsRgWHMDLX64vLejjIrIa8DQSoRwLK4++hmFs2WGrJxN19/hEhO4AnvPU
         Gg0S6zfPGO95jQApA4Dk6Nz+OVUJDGG+Yqf/YjMquympo31bZzXFUWVplA0fZhHilQim
         KiGJ85GguZnUepTEBRyZFEbgZJUTDQpCu/iBTnce8fq5Yf5Kfr2//GziIplnMilD2a7Q
         vJP3eBx0rpw11Fa7UW1D1DKkfcYjOVS/tBv22x0+LzoX70aGMP/4C155UmVQshQGYuds
         ajYejK0FTagH0hkG/Ma2FCQhbqY2J0G4pk/JN4wnrx+P2xRzh4h7IBBd9E1POrKeQoJ6
         J/fg==
X-Forwarded-Encrypted: i=1; AJvYcCVGXU2+tLTBLVamJJyRVFaOFGBIvul6/ktfiOL2qymJMpwCddtdv5ZHWLJMGBfm+1gxTjTlRwcKseE0GMfP50ZaJ4eFvOW0bPwSrSERBLt8V84AwI8UKob3f6qxUjd8fLSTQJFW
X-Gm-Message-State: AOJu0YwKZl26NdsTyPFYtte8GsZRzZtBD7Kjxj/UzEATNSwlutA3AiAg
	5XW5CcuzG7p2O+TxeURINYKl3YVyQQgk7+f1QQazgbotH5xrUPUp/vMC31Z4k18zydSvpctbP76
	Bec10ho6xbaGDhV+06PER47O+gQM=
X-Google-Smtp-Source: AGHT+IGRehIHe7oI2KBNV6dibdwlRyBBsOutgRPRaF36jnIlTmaAazTBYjAILxRbMGnmPORx5UR7Itj+UkiW7eCLIWg=
X-Received: by 2002:adf:eccb:0:b0:367:4dbb:ed4e with SMTP id
 ffacd0b85a97d-369f59c21b3mr1406072f8f.0.1721833439697; Wed, 24 Jul 2024
 08:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-10-linyunsheng@huawei.com> <e9982acd0eba5d06d178d0157aedfba569d5a09a.camel@gmail.com>
 <e7a9b79b-f1ab-4690-a3cf-4e9238e31790@huawei.com>
In-Reply-To: <e7a9b79b-f1ab-4690-a3cf-4e9238e31790@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 24 Jul 2024 08:03:23 -0700
Message-ID: <CAKgT0UdxB3OqS41PcGrB9JNkYKxsTDGx_sebkas+-A2bcx=kUA@mail.gmail.com>
Subject: Re: [RFC v11 09/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 5:55=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/7/22 5:41, Alexander H Duyck wrote:
>
> ...
>
> >>      if (unlikely(!page)) {
> >> -            page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> >> +            page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
> >>              if (unlikely(!page)) {
> >>                      memset(nc, 0, sizeof(*nc));
> >>                      return NULL;
> >
> > So if I am understanding correctly this is basically just stripping the
> > checks that were being performed since they aren't really needed to
> > verify the output of numa_mem_id.
> >
> > Rather than changing the code here, it might make more sense to update
> > alloc_pages_node_noprof to move the lines from
> > __alloc_pages_node_noprof into it. Then you could put the VM_BUG_ON and
> > warn_if_node_offline into an else statement which would cause them to
> > be automatically stripped for this and all other callers. The benefit
>
> I suppose you meant something like below:
>
> @@ -290,10 +290,14 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, =
unsigned int order, int nid)
>  static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_ma=
sk,
>                                                    unsigned int order)
>  {
> -       if (nid =3D=3D NUMA_NO_NODE)
> +       if (nid =3D=3D NUMA_NO_NODE) {
>                 nid =3D numa_mem_id();
> +       } else {
> +               VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> +               warn_if_node_offline(nid, gfp_mask);
> +       }
>
> -       return __alloc_pages_node_noprof(nid, gfp_mask, order);
> +       return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>  }

Yes, that is more or less what I was thinking.

> > would likely be much more significant and may be worthy of being
> > accepted on its own merit without being a part of this patch set as I
> > would imagine it would show slight gains in terms of performance and
> > binary size by dropping the unnecessary instructions.
>
> Below is the result, it does reduce the binary size for
> __page_frag_alloc_align() significantly as expected, but also
> increase the size for other functions, which seems to be passing
> a runtime nid, so the trick above doesn't work. I am not sure if
> the overall reduction is significant enough to justify the change?
> It seems that depends on how many future callers are passing runtime
> nid to alloc_pages_node() related APIs.
>
> [linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vml=
inux
> add/remove: 1/2 grow/shrink: 13/8 up/down: 160/-256 (-96)
> Function                                     old     new   delta
> bpf_map_alloc_pages                          708     764     +56
> its_probe_one                               2836    2860     +24
> iommu_dma_alloc                              984    1008     +24
> __iommu_dma_alloc_noncontiguous.constprop    1180    1192     +12
> e843419@0f3f_00011fb1_4348                     -       8      +8
> its_vpe_irq_domain_deactivate                312     316      +4
> its_vpe_irq_domain_alloc                    1492    1496      +4
> its_irq_domain_free                          440     444      +4
> iommu_dma_map_sg                            1328    1332      +4
> dpaa_eth_probe                              5524    5528      +4
> dpaa2_eth_xdp_xmit                           676     680      +4
> dpaa2_eth_open                               564     568      +4
> dma_direct_get_required_mask                 116     120      +4
> __dma_direct_alloc_pages.constprop           656     660      +4
> its_vpe_set_affinity                         928     924      -4
> its_send_single_command                      340     336      -4
> its_alloc_table_entry                        456     452      -4
> dpaa_bp_seed                                 232     228      -4
> arm_64_lpae_alloc_pgtable_s1                 680     676      -4
> __arm_lpae_alloc_pages                       900     896      -4
> e843419@0473_00005079_16ec                     8       -      -8
> e843419@0189_00001c33_1c8                      8       -      -8
> ringbuf_map_alloc                            612     600     -12
> __page_frag_alloc_align                      740     536    -204
> Total: Before=3D30306836, After=3D30306740, chg -0.00%

I'm assuming the compiler must have uninlined
__alloc_pages_node_noprof in the previous version of things for the
cases where it is causing an increase in the code size.

One alternative approach we could look at doing would be to just add
the following to the start of the function:
if (__builtin_constant_p(nid) && nid =3D=3D NUMA_NO_NODE)
        return __alloc_pages_noprof(gfp_mask, order, numa_mem_id(), NULL);

That should yield the best result as it essentially skips over the
problematic code at compile time for the constant case, otherwise the
code should be fully stripped so it shouldn't add any additional
overhead.

