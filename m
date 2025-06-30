Return-Path: <netdev+bounces-202326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11DAED5D2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D4416D46A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF75222597;
	Mon, 30 Jun 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="LtomjhuQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA66190072
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268942; cv=none; b=ABuIajTeoO4tbAxoJ51af79YUFQ4vVGLuDGBmNG9HBWWKNfCFplO34bzOUp/50XdqrBh6PiCj80j4vtf6qe+1fQMaCLNp9ImRZRKFqVsE68rMT5AaHTxWeqrPgWGNV8BkEiPqdB3XVORhPIHG9ys3Q3o/P+3uGpR8WvBbInvajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268942; c=relaxed/simple;
	bh=JhmOV40O+bSL2M90/npeI2Kz5q0Bnw0/S4OJW03R4b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2K1jKoS/Lm7KP/rJU1450yYadLupAy1w/q0UAr6AqrZ+luSN7QmNm5f11TIifdiuT1ZhuOx17sXT5h5F0VArsvRVat2HkE10Euz8urNjRcrP2O1ZzLEFh8z/8G0c92rmX0NE7ORlqi6TaHDgx2KP+kMIuXQCntktUJQ0Avm5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=LtomjhuQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so3339727a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1751268935; x=1751873735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJjHWRQFQERSX4N8A4WdlcHVSnGx7v+vOq1gWp3YDfQ=;
        b=LtomjhuQSUBTpMOtBXBe1p7o3NIOZ0u14YTtmhLx0vfaGKuCLKPnu/GQgKS+nRaawL
         cRTR3dPIeTYxAQDt/K/5M9uVyD0WJLuu+ppr93ruQKFi/I8TzOr88FGeFfPK20xQgVSG
         9jgTjEyP36U2IJn5mUbZrc/DvQ3BDu3CV07/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751268935; x=1751873735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJjHWRQFQERSX4N8A4WdlcHVSnGx7v+vOq1gWp3YDfQ=;
        b=M7urd3GClcYk3W3M97xYv5JlRNRpDpLuojhb2s+EYfuctHbp7BHhQEbqivuDn/gWBJ
         mBPfz5O8lR81+5PBO7ajfVsEdrbu6AGnomW8hcbI+3AR04jNRKCVh6eNXNvU/DtYU/QP
         s7/b+QbVVG3wjFdoZmq9UrEg4dQ1RD++CSucZb1WH33da6i5vRlULTNT4K8QCaWqJrwP
         MRfGH7nw5ZFaU7PaRFT388NrxnKYYkx5cxDyt3RrnzeheQtYW4yn3JlYxcJwROz7Wb6k
         DCLs6CrYv40ANol7lC7pPhWLgnvWfIxVSomm+0OIysasxy8GHKWHptdIUunThqz6w0I4
         7WBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWprXjnkWZbjyw0xi+DYPKec42AqjEf315SohYKRsJRofKvRTDA+Kb5NXRTz70lyEfOssodL4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc22oHF8I6dvUtdZgXLngoO/ISGSkHQFNqBtPX4JXdqU+0dSfg
	eLnHjeAjITLg6pgDUru5mxB0J9yuVLb8b2SqfnX4HYTSEFTlikjEQm1GqyA+HHDhF/gOsIEu3V4
	1pEBcteev/YwrEKwXBRfS6VnBkCopVWkJLBkzSUae
X-Gm-Gg: ASbGncvNWCOsmzLhjuQrfxC31ymP3m6E8TVMOUqJFX0QkfkFD52yUc1hO5d+i7mrFAy
	P5/Q9RGm/HSXRUThHt7pI0SdHFL9giS/HKy9IHvrZLC+5Hdq9nDZWY2/tBBvhay1uccii7Oa0la
	GBcAlx0L65+PbLudV6f1lQvqxiy4qC0fnXXQJKmJJLD28K
X-Google-Smtp-Source: AGHT+IFMO9vHwLlWhqFkVz4+FGrfY8iZ2eqXMm803NsyFasOLkn+3FGD3IdYRV5I0g/CF4qb6/D0+Zkfi0DytQwrHaI=
X-Received: by 2002:a17:907:9d17:b0:ae0:ad8c:a559 with SMTP id
 a640c23a62f3a-ae34fd336d5mr1176803866b.4.1751268935410; Mon, 30 Jun 2025
 00:35:35 -0700 (PDT)
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
 <20250625132545.1772c6ab@kernel.org> <CAK8fFZ7KDaPk_FVDbTdFt8soEWrpJ_g0_fiKEg1WzjRp1BC0Qg@mail.gmail.com>
In-Reply-To: <CAK8fFZ7KDaPk_FVDbTdFt8soEWrpJ_g0_fiKEg1WzjRp1BC0Qg@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 30 Jun 2025 09:35:09 +0200
X-Gm-Features: Ac12FXy0zTWCIUI055ElkQjsOkkMKHSQo1G-_vNnBe4EjUhDGc4Z9aQ9tsVUJsk
Message-ID: <CAK8fFZ5rS8Xg11LvyQHzFh3aVHbKdRHpuhrpV_Wc7oYRcMZFRA@mail.gmail.com>
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
> >
> > On Wed, 25 Jun 2025 19:51:08 +0200 Jaroslav Pulchart wrote:
> > > Great, please send me a link to the related patch set. I can apply th=
em in
> > > our kernel build and try them ASAP!
> >
> > Sorry if I'm repeating the question - have you tried
> > CONFIG_MEM_ALLOC_PROFILING? Reportedly the overhead in recent kernels
> > is low enough to use it for production workloads.
>
> I try it now, the fresh booted server:
>
> # sort -g /proc/allocinfo| tail -n 15
>     45409728   236509 fs/dcache.c:1681 func:__d_alloc
>     71041024    17344 mm/percpu-vm.c:95 func:pcpu_alloc_pages
>     71524352    11140 kernel/dma/direct.c:141 func:__dma_direct_alloc_pag=
es
>     85098496     4486 mm/slub.c:2452 func:alloc_slab_page
>    115470992   101647 fs/ext4/super.c:1388 [ext4] func:ext4_alloc_inode
>    134479872    32832 kernel/events/ring_buffer.c:811 func:perf_mmap_allo=
c_page
>    141426688    34528 mm/filemap.c:1978 func:__filemap_get_folio
>    191594496    46776 mm/memory.c:1056 func:folio_prealloc
>    360710144      172 mm/khugepaged.c:1084 func:alloc_charge_folio
>    444076032    33790 mm/slub.c:2450 func:alloc_slab_page
>    530579456   129536 mm/page_ext.c:271 func:alloc_page_ext
>    975175680      465 mm/huge_memory.c:1165 func:vma_alloc_anon_folio_pmd
>   1022427136   249616 mm/memory.c:1054 func:folio_prealloc
>   1105125376   139252 drivers/net/ethernet/intel/ice/ice_txrx.c:681
> [ice] func:ice_alloc_mapped_page
>   1621598208   395848 mm/readahead.c:186 func:ractl_alloc_folio
>

The "drivers/net/ethernet/intel/ice/ice_txrx.c:681 [ice]
func:ice_alloc_mapped_page" is just growing...

# uptime ; sort -g /proc/allocinfo| tail -n 15
 09:33:58 up 4 days, 6 min,  1 user,  load average: 6.65, 8.18, 9.81

# sort -g /proc/allocinfo| tail -n 15
    85216896   443838 fs/dcache.c:1681 func:__d_alloc
   106156032    25917 mm/shmem.c:1854 func:shmem_alloc_folio
   116850096   102861 fs/ext4/super.c:1388 [ext4] func:ext4_alloc_inode
   134479872    32832 kernel/events/ring_buffer.c:811 func:perf_mmap_alloc_=
page
   143556608     6894 mm/slub.c:2452 func:alloc_slab_page
   186793984    45604 mm/memory.c:1056 func:folio_prealloc
   362807296    88576 mm/percpu-vm.c:95 func:pcpu_alloc_pages
   530579456   129536 mm/page_ext.c:271 func:alloc_page_ext
   598237184    51309 mm/slub.c:2450 func:alloc_slab_page
   838860800      400 mm/huge_memory.c:1165 func:vma_alloc_anon_folio_pmd
   929083392   226827 mm/filemap.c:1978 func:__filemap_get_folio
  1034657792   252602 mm/memory.c:1054 func:folio_prealloc
  1262485504      602 mm/khugepaged.c:1084 func:alloc_charge_folio
  1335377920   325970 mm/readahead.c:186 func:ractl_alloc_folio
  2544877568   315003 drivers/net/ethernet/intel/ice/ice_txrx.c:681
[ice] func:ice_alloc_mapped_page

>
> >
> > > st 25. 6. 2025 v 16:03 odes=C3=ADlatel Przemek Kitszel <
> > > przemyslaw.kitszel@intel.com> napsal:
> > >
> > > > On 6/25/25 14:17, Jaroslav Pulchart wrote:
> > > > > Hello
> > > > >
> > > > > We are still facing the memory issue with Intel 810 NICs (even on=
 latest
> > > > > 6.15.y).
> > > > >
> > > > > Our current stabilization and solution is to move everything to a=
 new
> > > > > INTEL-FREE server and get rid of last Intel sights there (after I=
ntel's
> > > > > CPU vulnerabilities fuckups NICs are next step).
> > > > >
> > > > > Any help welcomed,
> > > > > Jaroslav P.
> > > > >
> > > > >
> > > >
> > > > Thank you for urging us, I can understand the frustration.
> > > >
> > > > We have identified some (unrelated) memory leaks, will soon ship fi=
xes.
> > > > And, as there were no clear issue with any commit/version you have
> > > > posted to be a culprit, there is a chance that our random findings =
could
> > > > help. Anyway going to zero kmemleak reports is good in itself, that=
 is
> > > > a good start.
> > > >
> > > > Will ask my VAL too to increase efforts in this area too.
> >

