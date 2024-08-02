Return-Path: <netdev+bounces-115382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DC99461E0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E486B1F21E1F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3B136322;
	Fri,  2 Aug 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ3BS24F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75116BE02;
	Fri,  2 Aug 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616759; cv=none; b=YS3td0cISYYs7MPhu/KTnq5gSwr0iFfyBx7Qbj6AgCr0ibtIwrOniA+tNVgelsGqISAYatNBG2SEZ8KjGq0KZTpkHv92oMDy3dxWHWYoC+C/P9O468pBJx4E1NAF7AdUzywbMxKtvMm5Q/n7QlcL1uCG2ss8iINT2z1jc7/yxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616759; c=relaxed/simple;
	bh=swId7oroTu3TqgOI05wTJP8FJJmti7+QK63OhDZnFLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnKILHGg5pgIsvwaB09qRGIQUog2Y60hLU5BrAb5ZNGpK0OoctSOdRKCyeiYm3Q7k4LalZefMIA/nUlxX6cz2JRmosjXAovzfSDX3PC4JQVpgXStRVvMynBicP+7mZiTpn1QQWDhacvAgLWxzT2VlZ1anEoHeT7WKFwSzEy6wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ3BS24F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so47702655e9.2;
        Fri, 02 Aug 2024 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722616755; x=1723221555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHXTtic285MnD5nnqP+GtkQhQ7otumGS5wb+fLs+p4w=;
        b=IZ3BS24FtLkyTloo+XmjJBHo3eP3sRGJxL0GCKiXldDzJmGHCMp44XhglJVDnQODAY
         Rdt7gVzX6tOKIQrOpDKdw5dyV+oseTUIudhnVaeAs5mP4zz/1pJcnfD03PRbFR/IKGAj
         tYLBdxj0kqTA9xoZB6F4fgFgbjSVTU5uy1AMsI6QgvbJ2QIFPNtZMWEej0nzJVb5Jbzs
         B+iXOeLRflJSiN6CkKgo1ghVZh3v3DJ+3njq611ABV3sbBH3JpRySAwK6aOOBzsNrzqf
         OZy/rqVEkclzVWxHbpy8JDB0tWQ2e2nFoQKIu8CSp9ytsJp51sApZI2k2YFUQmIVK4GR
         /Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722616755; x=1723221555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHXTtic285MnD5nnqP+GtkQhQ7otumGS5wb+fLs+p4w=;
        b=R0k6ohcWtR+xrBCiVmI2iJw/Q2MHKc+PQU1RZ91IBtc9pu+OJNdy7TQP5wJH6/vtrU
         TEOT0hs+mPLibqTT/zpsOChq3y/Mouj7p8pgLFb+IsBrs/IMobbpJlEP1qAWqP2kOa8u
         sPcq5SDO7rfJpzA434Skov6z7BQnF9U7Sfv6uFsKVAL7YgqtoFAsQHItwnzl4pc0YboI
         zdZS23BsY0dmjbRxB2CZlc/6nuKUSQFvUc8RzxPuD95b/uCbjHgDKxOxmwiZA1HiBPRs
         0ckPVzzyW6/PMYgAEAU8Qx32zpdaOJpKrQbBHXwwBq9V6WznkERHkV+7RzEjhonpfWMd
         q8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQ0UPHNRDEhncdMInVYnUutnhN68IYlAEFP+aSyWCDgPzZGunr8zgHl4sk+VSEsOnhh+JKMUMbK9ZCaz2tDrhd//NnlvEIhZavk6U5ruY3yYoTTMSZSs5mlK0ShaZEeO67hva
X-Gm-Message-State: AOJu0YxzwQE0/1YZYWbV6L1g2jM04paOg1SIUBVm3y1lb89Loseu/Cmg
	m/YdyBpDVjT62f0CcH4mKh2M7JmWxD/j6+DOIua4NNPQ52jci0u/+tuVHLc17QvIsIRtv68XbQc
	C0yCblOtT9UwpFEQh3sqq9a/rJXjCqbfE
X-Google-Smtp-Source: AGHT+IGNb/PHAyV1RSLqzcQva7gsuFy+pG9mruoc/d+wkjJypH7sDDHCXL5tVkJRq6jb+o73spG0SpHvEDCNGLurT50=
X-Received: by 2002:a5d:4ac7:0:b0:367:9237:611d with SMTP id
 ffacd0b85a97d-36bbc17bfebmr2468244f8f.60.1722616754662; Fri, 02 Aug 2024
 09:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com> <8743264a-9700-4227-a556-5f931c720211@huawei.com>
In-Reply-To: <8743264a-9700-4227-a556-5f931c720211@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Aug 2024 09:38:37 -0700
Message-ID: <CAKgT0Uf4xBJDLMxa3awSnzgZvbb-LN82APkPi7uVpWw+j7wqRA@mail.gmail.com>
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at iommu_get_dma_domain+0xc/0x20
To: Yonglong Liu <liuyonglong@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linyunsheng <linyunsheng@huawei.com>, "shenjian (K)" <shenjian15@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:08=E2=80=AFAM Yonglong Liu <liuyonglong@huawei.co=
m> wrote:
>
> I found a bug when running hns3 driver with page pool enabled, the log
> as below:
>
> [ 4406.956606] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000000a8
> [ 4406.965379] Mem abort info:
> [ 4406.968160]   ESR =3D 0x0000000096000004
> [ 4406.971906]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [ 4406.977218]   SET =3D 0, FnV =3D 0
> [ 4406.980258]   EA =3D 0, S1PTW =3D 0
> [ 4406.983404]   FSC =3D 0x04: level 0 translation fault
> [ 4406.988273] Data abort info:
> [ 4406.991154]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [ 4406.996632]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [ 4407.001681]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000020282832600=
0
> [ 4407.013430] [00000000000000a8] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
> nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
> ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype
> iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
> hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
> hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi
> scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
> hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
> xhci_pci_renesas uacce libsas [last unloaded: hnae3]
> [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
> [ 4407.093343] Workqueue: events page_pool_release_retry
> [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
> [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
> [ 4407.114255] sp : ffff80008bacbc80
> [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
> ffffc31806be7000
> [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
> 0000000000000002
> [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
> 00000000fcd7c000
> [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
> ffff8000d3503c58
> [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
> 0000000000000001
> [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
> 000006b10004e7fb
> [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
> ffffc3180405cd20
> [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
> 0000000000000010
> [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
> 0000000000000002
> [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
> 0000000000000000
> [ 4407.188589] Call trace:
> [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
> [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
> [ 4407.199361]  page_pool_return_page+0x48/0x180
> [ 4407.203699]  page_pool_release+0xd4/0x1f0
> [ 4407.207692]  page_pool_release_retry+0x28/0xe8
> [ 4407.212119]  process_one_work+0x164/0x3e0
> [ 4407.216116]  worker_thread+0x310/0x420
> [ 4407.219851]  kthread+0x120/0x130
> [ 4407.223066]  ret_from_fork+0x10/0x20
> [ 4407.226630] Code: ffffc318 aa1e03e9 d503201f f9416c00 (f9405400)
> [ 4407.232697] ---[ end trace 0000000000000000 ]---

The issue as I see it is that we aren't unmapping the pages when we
call page_pool_destroy. There need to be no pages remaining with a DMA
unmapping needed *after* that is called. Otherwise we will see this
issue regularly.

What we probably need to look at doing is beefing up page_pool_release
to add a step that will take an additional reference on the inflight
pages, then call __page_pool_put_page to switch them to a reference
counted page.

Seems like the worst case scenario is that we are talking about having
to walk the page table to do the above for any inflight pages but it
would certainly be a much more deterministic amount of time needed to
do that versus waiting on a page that may or may not return.

Alternatively a quick hack that would probably also address this would
be to clear poll->dma_map in page_pool_destroy or maybe in
page_pool_unreg_netdev so that any of those residual mappings would
essentially get leaked, but we wouldn't have to worry about trying to
unmap while the device doesn't exist.

