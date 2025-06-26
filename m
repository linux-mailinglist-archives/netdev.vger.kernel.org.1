Return-Path: <netdev+bounces-201429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627FAE9704
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA64189AF37
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA325485A;
	Thu, 26 Jun 2025 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="f2SLXA10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625F24E4C6
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923768; cv=none; b=AAOyZ8HI6d95G82UfP1T+QBAB9xQ5pWXGZTNoG9cUUzw7b9RVjXG/wKcD0lOq5XhhU+f4lUDqgHPQdMeT/P73/RXqHNAWpsdA7zxmzAcphK25S7t9S9kiixe1/eZQ+o2+LypxacWnZRderIv4BkFzH2S1rc61jqPP9FXXgH5+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923768; c=relaxed/simple;
	bh=XqoCUNoIiXGdV4LT9cOwCfiJqNJ2Cfp6GN5FZdKyQLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5CE9ER9oXuZTQiGD3nrm0IVc+4feroK9iqEUO0wZI8IzhRmKzWLOPaVgjMyLdxDodiGhYXXc+0ae1UJ/UDQtXegvzgkugus0kPI0Y5s3sElEvwJaQB0Sh7J5SVLosl5y15nuX9RoT4l2Rhlqja1O2CF6xdt7OgzmoaAIcKks94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=f2SLXA10; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so118388966b.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1750923765; x=1751528565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmlQgV9vWUgrOGrYQ1qTDZBBqbmkBrpQQvLdyRNMshw=;
        b=f2SLXA10OgDElQ3OEuNBu6Qk/hhc/Iu/Bgou2t9Q4Gw96jsE3RjDfzNqBTiAiTkybf
         1ToPU0l95CX5FLYY9A1fJOxC+SW1Eql7Bj14Yx3/Qt5girolUHjtSjDZg6xjCfR6iXTY
         RgPyUoLn4F6cVIlSyWQGUX6yHkItQgZ3IaKNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750923765; x=1751528565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmlQgV9vWUgrOGrYQ1qTDZBBqbmkBrpQQvLdyRNMshw=;
        b=JDBzxxLqlAAM+NPOY/mX+XuPL87j46Znck9itlItoNOEsENtXV3ZxspCPtCh1hwbm7
         67KuHHcK9B3lP028i2pS49reuvad4by37qAGqJV7syddMrOrDCF0O1CksMSzuxrlUm/a
         4xzeh4TJWT7b5GzYA3XWfBvClhbMeYuMBdNJWi92bXAJgoJecIg5scZEtfedSboRclsm
         nsz2Sqv+/+WLgtIfFVmSCx7gHx000Jdhy/gzfZyAgpC6eNin12XXf65Pdpfq6H3+KsP+
         oPitupxlgxcwRWEK/YRHp2mlN9B3Xhm5KW1caAT+gq0GxE+M3mbHP/7QI2luAwVu1JbR
         UL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5JeQTJlBVuGJWycS/xvRrcOJYpEHtxXrvSfPRjfcoOd4ga0HyskDNOX8pExdMQqnjfJzbOLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4h8zASdQPtrDOEJKjq8n2GfirBbYNP/0Ye15LenQGosUwl39
	zukzzBryxRKPXDZtKBAYHi1imLgzGEBVuaoI5AuFA4Iuicy072UAfoZimNQAkT4Kax1HsHEFzng
	GYgcW+VXisxAw2dKRcAhiPgaZ7TZ/MexeNcsqzvZZ
X-Gm-Gg: ASbGncvRMWj5Gj39At9z6OZ20bSIt5iIFK8Uxc0nMqxPURaZmuVTsLldPXO+LiEjxxt
	jypwlAL29umbvPswfWbIN/k26+smp8L1HuR286/TCMfZf7W48j/VwOCOdOcstcw/NVVdPA/Vx+f
	S8WfhpjRtx5KeGsf7noaizTzvmp7c4MqTs5JIqierbiU6t
X-Google-Smtp-Source: AGHT+IGQ29SGdr4U8XdsEp043TI4qqT4doANfCqlH4050quc3HJ8Dr4GriJAlIEzNsBr4wRg0VBwCQ401xKutfq2aME=
X-Received: by 2002:a17:906:c452:b0:ae0:16db:1b62 with SMTP id
 a640c23a62f3a-ae0beb852cdmr433825266b.59.1750923765153; Thu, 26 Jun 2025
 00:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com> <20250415175359.3c6117c9@kernel.org>
 <CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
 <20250416064852.39fd4b8f@kernel.org> <CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
 <CO1PR11MB5089365F31BCD97E59CCFA83D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <20250416171311.30b76ec1@kernel.org> <CO1PR11MB508931FBA3D5DFE7D8F07844D6BC2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <CAK8fFZ6+BNjNdemB+P=SuwU6X9a9CmtkR8Nux-XG7QHdcswvQQ@mail.gmail.com>
 <CAK8fFZ4BJ-T40eNzO1rDLLpSRkeaHGctATsGLKD3bqVCa4RFEQ@mail.gmail.com>
 <CAK8fFZ5XTO9dGADuMSV0hJws-6cZE9equa3X6dfTBgDyzE1pEQ@mail.gmail.com>
 <b3eb99da-9293-43e8-a24d-f4082f747d6c@intel.com> <CAK8fFZ7LREBEdhXjBAKuaqktOz1VwsBTxcCpLBsa+dkMj4Pyyw@mail.gmail.com>
 <20250625132545.1772c6ab@kernel.org>
In-Reply-To: <20250625132545.1772c6ab@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 26 Jun 2025 09:42:19 +0200
X-Gm-Features: Ac12FXyfYBwNw7r-sTtnJ3Pq-xINRVOqJANIwsOhTjNx6hz7HmeFqHgFcDwpzd8
Message-ID: <CAK8fFZ7KDaPk_FVDbTdFt8soEWrpJ_g0_fiKEg1WzjRp1BC0Qg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Damato, Joe" <jdamato@fastly.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Dumazet, Eric" <edumazet@google.com>, 
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Wed, 25 Jun 2025 19:51:08 +0200 Jaroslav Pulchart wrote:
> > Great, please send me a link to the related patch set. I can apply them=
 in
> > our kernel build and try them ASAP!
>
> Sorry if I'm repeating the question - have you tried
> CONFIG_MEM_ALLOC_PROFILING? Reportedly the overhead in recent kernels
> is low enough to use it for production workloads.

I try it now, the fresh booted server:

# sort -g /proc/allocinfo| tail -n 15
    45409728   236509 fs/dcache.c:1681 func:__d_alloc
    71041024    17344 mm/percpu-vm.c:95 func:pcpu_alloc_pages
    71524352    11140 kernel/dma/direct.c:141 func:__dma_direct_alloc_pages
    85098496     4486 mm/slub.c:2452 func:alloc_slab_page
   115470992   101647 fs/ext4/super.c:1388 [ext4] func:ext4_alloc_inode
   134479872    32832 kernel/events/ring_buffer.c:811 func:perf_mmap_alloc_=
page
   141426688    34528 mm/filemap.c:1978 func:__filemap_get_folio
   191594496    46776 mm/memory.c:1056 func:folio_prealloc
   360710144      172 mm/khugepaged.c:1084 func:alloc_charge_folio
   444076032    33790 mm/slub.c:2450 func:alloc_slab_page
   530579456   129536 mm/page_ext.c:271 func:alloc_page_ext
   975175680      465 mm/huge_memory.c:1165 func:vma_alloc_anon_folio_pmd
  1022427136   249616 mm/memory.c:1054 func:folio_prealloc
  1105125376   139252 drivers/net/ethernet/intel/ice/ice_txrx.c:681
[ice] func:ice_alloc_mapped_page
  1621598208   395848 mm/readahead.c:186 func:ractl_alloc_folio


>
> > st 25. 6. 2025 v 16:03 odes=C3=ADlatel Przemek Kitszel <
> > przemyslaw.kitszel@intel.com> napsal:
> >
> > > On 6/25/25 14:17, Jaroslav Pulchart wrote:
> > > > Hello
> > > >
> > > > We are still facing the memory issue with Intel 810 NICs (even on l=
atest
> > > > 6.15.y).
> > > >
> > > > Our current stabilization and solution is to move everything to a n=
ew
> > > > INTEL-FREE server and get rid of last Intel sights there (after Int=
el's
> > > > CPU vulnerabilities fuckups NICs are next step).
> > > >
> > > > Any help welcomed,
> > > > Jaroslav P.
> > > >
> > > >
> > >
> > > Thank you for urging us, I can understand the frustration.
> > >
> > > We have identified some (unrelated) memory leaks, will soon ship fixe=
s.
> > > And, as there were no clear issue with any commit/version you have
> > > posted to be a culprit, there is a chance that our random findings co=
uld
> > > help. Anyway going to zero kmemleak reports is good in itself, that i=
s
> > > a good start.
> > >
> > > Will ask my VAL too to increase efforts in this area too.
>

