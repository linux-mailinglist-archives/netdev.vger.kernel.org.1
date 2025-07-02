Return-Path: <netdev+bounces-203258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE814AF1097
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3887816D853
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E792376F7;
	Wed,  2 Jul 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="l+yLsUuv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADE1C84B3
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449770; cv=none; b=BVwQNxiJCd35QDSeivxv5PmWRT6swoEr6N3v6bNhUF8TglTr40j8zTXlJh/9Jp79prGc9EA83r2Raiv7qvOdj4ZAxFpmVnhUeeBDbxjV83hLAMdWLXausKR2U2Sg7hL2QJlqUJIvqd1Q5+7BoHzeONFzQotsK1FCG1XEvqKkPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449770; c=relaxed/simple;
	bh=l6h66bXvqLMD/8lLZ2G1UWXzI0Ya91/peGltOIGLWWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEpKn0DzmE2SbgwVRlKGr86I99zzFGxl7/KbcGm9FAlQiuLscawaO2LXxzOhwergcUKR9kmrvV+1TZODMrC09c+xUTUS8hu/tKxVUBwjgSmOr4dddA4Vp7NS3YKt3s5TM+t22wOiZdclFx6FG64lji5Oto/5S3QMKm8s0+VK7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=l+yLsUuv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0c571f137so1256865266b.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1751449767; x=1752054567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA4kV62GbuPsXF3xVfIE7JKO7kyc+h0H8JQpdDYlEYs=;
        b=l+yLsUuvw59SamOVfeEtu5hC/pT2CKfd68IBr8jR5770Jcw4xnRDzBIhPR1HVvzBKe
         PaD41L0Zvp26Un2osyhz00PLBDHHMBrGpDoFY9BDNFoUv1krEWc4JIylWw3pn+rr6RbK
         JcAOGInm0OGf4E1dPCzcV48gxJGNJOHx0HuZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751449767; x=1752054567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA4kV62GbuPsXF3xVfIE7JKO7kyc+h0H8JQpdDYlEYs=;
        b=gBoYk8VYMD6ff2IFF1KEA/oDQgYelEiwxNkulPtEEQCRXZ/Ipjt6o+B3EJHpqRDZRV
         PSinNBuDTmXBScRLXs1AcwAux1xaW7aY/4NpjpcB3eGouKwOUqTnZCl9AKsaFSm3b+3O
         d23JQguRPgbdX7HDZTBOBJv05p/fNor5+FaTWEUl0WJWpr9oDbDBV2PvDgFcPYbDVwpb
         qJ0J25Xs/4clKEbF9EDu7D/VDbeQUVFo6NeJOUjM/qNxYuyCGE81l4T79Nr80r6zLIRd
         d+wTYS2fx6oqYkVuPTTlYTQxmyTtJPR6VTf7DiCgOaYb9Vg+TYt+QR+xBWebp8Leuvtc
         cLlw==
X-Forwarded-Encrypted: i=1; AJvYcCWmRV4Btur3juywoIR1Rw971AGaWfS5sMBz9ILXc7mMbgq3nGFKR6WB80ZlypKesD/v7+bMmAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuzsi1AY3Yt73SnANoxHrPScyXEarWK+fWPv8s19aQ5wUZvFnj
	mTjWRmIxRTLkl1QdNgmdg6zn6vvtBkheNqI5dkBglAaaLGMA3HznUg0ynDpkq1JI1HHlP9bvrij
	IPlD3YevgRqxm5g98JdoCXT8k5Z7S6L628YKS5EMB
X-Gm-Gg: ASbGncuUxomYOm5uGP7DH3RRuU+8PnReQX8GDYI0Z0XNZlZ7uvPv6bAYSvT90fvv/nE
	MJeLvLAx9zh7oUle4hsASXvPSngHj8oFYGTEJBETcDFLHJL5rpEIlbsDfX5glJvymgE6lz/MZxh
	g/xf5DxBPhoQGHyEkB27Zn03up3ZO21maWoJm5Yzswas4qvqV00qKMaXg=
X-Google-Smtp-Source: AGHT+IGQVdGzbWklOW0HK5F7BREUrFJxaW+J8O42Zpbiw3jmWElX2XHrNgWH0DB8FJ38y112IwvwAFEx9SBX2hP11xg=
X-Received: by 2002:a17:907:7fa3:b0:adb:41e4:8c73 with SMTP id
 a640c23a62f3a-ae3c2d56586mr226600566b.55.1751449767139; Wed, 02 Jul 2025
 02:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <CAK8fFZ6+BNjNdemB+P=SuwU6X9a9CmtkR8Nux-XG7QHdcswvQQ@mail.gmail.com>
 <CAK8fFZ4BJ-T40eNzO1rDLLpSRkeaHGctATsGLKD3bqVCa4RFEQ@mail.gmail.com>
 <CAK8fFZ5XTO9dGADuMSV0hJws-6cZE9equa3X6dfTBgDyzE1pEQ@mail.gmail.com>
 <b3eb99da-9293-43e8-a24d-f4082f747d6c@intel.com> <CAK8fFZ7LREBEdhXjBAKuaqktOz1VwsBTxcCpLBsa+dkMj4Pyyw@mail.gmail.com>
 <20250625132545.1772c6ab@kernel.org> <CAK8fFZ7KDaPk_FVDbTdFt8soEWrpJ_g0_fiKEg1WzjRp1BC0Qg@mail.gmail.com>
 <CAK8fFZ5rS8Xg11LvyQHzFh3aVHbKdRHpuhrpV_Wc7oYRcMZFRA@mail.gmail.com>
 <c764ad97-9c6a-46f5-a03b-cfa812cdb8e1@intel.com> <CAK8fFZ4bRJz2WnhoYdG8PVYi6=EKYTXBE5tu8pR4=CQoifqUuA@mail.gmail.com>
 <f2e43212-dc49-4f87-9bbc-53a77f3523e5@intel.com> <CAK8fFZ6FU1+1__FndEoFQgHqSXN+330qvNTWMvMfiXc2DpN8NQ@mail.gmail.com>
 <08fae312-2e3e-4622-94ab-7960accc8008@intel.com> <366dbe9f-af4d-48ec-879e-1ac54cd5f3b6@intel.com>
 <CAK8fFZ6PPw1nshtSp+QZ_2VVWVrsCKZDdsxdPF9Tjc0=_gi=Wg@mail.gmail.com> <bdab5970-0701-4ba7-abd2-2009a92c130a@intel.com>
In-Reply-To: <bdab5970-0701-4ba7-abd2-2009a92c130a@intel.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 2 Jul 2025 11:48:59 +0200
X-Gm-Features: Ac12FXwkxKwefgLXSEGylK356ZNJGxoSse_2V1q2esdvDMykui_CAnYU8NXfe-k
Message-ID: <CAK8fFZ5XPQ-mW5z9qJNJhqFukdtYGJawYTYuhHYDTCvcD37oFw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Damato, Joe" <jdamato@fastly.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Dumazet, Eric" <edumazet@google.com>, 
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On 6/30/2025 11:48 PM, Jaroslav Pulchart wrote:
> >> On 6/30/2025 2:56 PM, Jacob Keller wrote:
> >>> Unfortunately it looks like the fix I mentioned has landed in 6.14, s=
o
> >>> its not a fix for your issue (since you mentioned 6.14 has failed
> >>> testing in your system)
> >>>
> >>> $ git describe --first-parent --contains --match=3Dv* --exclude=3D*rc=
*
> >>> 743bbd93cf29f653fae0e1416a31f03231689911
> >>> v6.14~251^2~15^2~2
> >>>
> >>> I don't see any other relevant changes since v6.14. I can try to see =
if
> >>> I see similar issues with CONFIG_MEM_ALLOC_PROFILING on some test
> >>> systems here.
> >>
> >> On my system I see this at boot after loading the ice module from
> >>
> >> $ grep -F "/ice/" /proc/allocinfo | sort -g | tail | numfmt --to=3Diec=
>
> >>       26K      230 drivers/net/ethernet/intel/ice/ice_irq.c:84 [ice]
> >> func:ice_get_irq_res
> >>>          48K        2 drivers/net/ethernet/intel/ice/ice_arfs.c:565 [=
ice] func:ice_init_arfs
> >>>          57K      226 drivers/net/ethernet/intel/ice/ice_lib.c:397 [i=
ce] func:ice_vsi_alloc_ring_stats
> >>>          57K      226 drivers/net/ethernet/intel/ice/ice_lib.c:416 [i=
ce] func:ice_vsi_alloc_ring_stats
> >>>          85K      226 drivers/net/ethernet/intel/ice/ice_lib.c:1398 [=
ice] func:ice_vsi_alloc_rings
> >>>         339K      226 drivers/net/ethernet/intel/ice/ice_lib.c:1422 [=
ice] func:ice_vsi_alloc_rings
> >>>         678K      226 drivers/net/ethernet/intel/ice/ice_base.c:109 [=
ice] func:ice_vsi_alloc_q_vector
> >>>         1.1M      257 drivers/net/ethernet/intel/ice/ice_fwlog.c:40 [=
ice] func:ice_fwlog_alloc_ring_buffs
> >>>         7.2M      114 drivers/net/ethernet/intel/ice/ice_txrx.c:493 [=
ice] func:ice_setup_rx_ring
> >>>         896M   229264 drivers/net/ethernet/intel/ice/ice_txrx.c:680 [=
ice] func:ice_alloc_mapped_page
> >>
> >> Its about 1GB for the mapped pages. I don't see any increase moment to
> >> moment. I've started an iperf session to simulate some traffic, and I'=
ll
> >> leave this running to see if anything changes overnight.
> >>
> >> Is there anything else that you can share about the traffic setup or
> >> otherwise that I could look into?  Your system seems to use ~2.5 x the
> >> buffer size as mine, but that might just be a smaller number of CPUs.
> >>
> >> Hopefully I'll get some more results overnight.
> >
> > The traffic is random production workloads from VMs, using standard
> > Linux or OVS bridges. There is no specific pattern to it. I haven=E2=80=
=99t
> > had any luck reproducing (or was not patient enough) this with iperf3
> > myself. The two active (UP) interfaces are in an LACP bonding setup.
> > Here are our ethtool settings for the two member ports (em1 and p3p1)
> >
>
> I had iperf3 running overnight and the memory usage for
> ice_alloc_mapped_pages is constant here. Mine was direct connections
> without bridge or bonding. From your description I assume there's no XDP
> happening either.

Yes, no XDP in use.

BTW the allocinfo after 6days uptime:
# uptime ; sort -g /proc/allocinfo| tail -n 15
 11:46:44 up 6 days,  2:18,  1 user,  load average: 9.24, 11.33, 15.07
   102489024   533797 fs/dcache.c:1681 func:__d_alloc
   106229760    25935 mm/shmem.c:1854 func:shmem_alloc_folio
   117118192   103097 fs/ext4/super.c:1388 [ext4] func:ext4_alloc_inode
   134479872    32832 kernel/events/ring_buffer.c:811 func:perf_mmap_alloc_=
page
   162783232     7656 mm/slub.c:2452 func:alloc_slab_page
   189906944    46364 mm/memory.c:1056 func:folio_prealloc
   499384320   121920 mm/percpu-vm.c:95 func:pcpu_alloc_pages
   530579456   129536 mm/page_ext.c:271 func:alloc_page_ext
   625876992    54186 mm/slub.c:2450 func:alloc_slab_page
   838860800      400 mm/huge_memory.c:1165 func:vma_alloc_anon_folio_pmd
  1014710272   247732 mm/filemap.c:1978 func:__filemap_get_folio
  1056710656   257986 mm/memory.c:1054 func:folio_prealloc
  1279262720      610 mm/khugepaged.c:1084 func:alloc_charge_folio
  1334530048   325763 mm/readahead.c:186 func:ractl_alloc_folio
  3341238272   412215 drivers/net/ethernet/intel/ice/ice_txrx.c:681
[ice] func:ice_alloc_mapped_page

>
> I guess the traffic patterns of an iperf session are too regular, or
> something to do with bridge or bonding.. but I also struggle to see how
> those could play a role in the buffer management in the ice driver...

