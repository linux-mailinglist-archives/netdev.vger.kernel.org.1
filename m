Return-Path: <netdev+bounces-203984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B471AF86FC
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25EF5638FA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490361F4615;
	Fri,  4 Jul 2025 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7SmIwQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867E20102B
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604928; cv=none; b=Hg20dlH+esFlQPqxktUx+S38N9UiNRgoZOQGsl53ugK2TBz0bnPQj452l3DdHVQimZesIIz+PSEkcTVRDZ+We+HPL74i/t+3G3guNExe1hBNZ1m0JGtZR7MlGcE2SCVOF7LwSwSdg6R0BZepETNy7iOV3XnNsgeq+Qn3LBTKJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604928; c=relaxed/simple;
	bh=4hik0Yeip35ulOHK/rHXvuRVsn7CASxYNWIDToseGjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwrBA8L/sZTZoWkhT3dqBuGWA17Rh0QUffqh3dQzdARp3kpe4tuXSOv9HCObcuuLAFfU36MVRG4DdsPVDa+v4npH2T/hiznHdTdgu7lJ3Ep5KqH3GBDSRO2pYMKE5wpDjIaR/aGIn+mnHUWq82qevud4Gi4V+prEwomcZXILHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7SmIwQ8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b27c1481bso412107b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751604926; x=1752209726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Yn9y8eKt2KpoBYvOThZKDa8CqGKn0nGbPMaFNRp65o=;
        b=W7SmIwQ8zrHzimzo9HyHMIaQ8URZ1hPb6MhMgJb4divi5eJ80IcpiT8Kf5ATObcsKQ
         6pdRPG1tCLdudFC8e02CkmgR94CE8fXBG8uZnD9ImAxIDhwi/4bt89eUAxqvaAD78MA5
         AomUcxeSFRT6XiVaSmbRLwGuAtt37H9yBVOXjD5TFUnP6D1bhQV04Zqb/7RDRCpofJif
         J05pqTqv84uLDFhrDq8H1uPoeh/Hq7H4T99ATViTKgNpUS5/u7O4t0U97h8FO2OptbMA
         OtdtaJH9IVnKhRIQtAtf6TDN4u5cPorwb981pnm5jw1L/nXOkyB4k9heoGXP2THm2yfL
         BtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751604926; x=1752209726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Yn9y8eKt2KpoBYvOThZKDa8CqGKn0nGbPMaFNRp65o=;
        b=kcFZAlta8ro32PIZAK+M9tjjmnz5Le0lUaCRUdQXrKkFwu8OtXRESzrFmHwY3Y+Zuf
         9dBcw/fDl9CR4+eLwpDfiCgw2j3hOXUeCMSgBY5niv/Ixtdd2JleUNLxJcScco0W9kcL
         gIbNxZn5Ov4FWI15LUbNl3k71xUoDRHXY05zCZvUDivzCcxz/ai5vxr9tArTl/gG5M7R
         9HZy9Om8TyVzbO5cMyGFQdh4ghSJ5IQCw0eM0mKm5tByXkPRj+LOrdcX/g2lX3o4eBVx
         Bc2vSeQstlQp5sTJ3T4tBan9Cs/qEebBrYQKmlyMBTF+LNd8AQr+arNDofMruilo/uH5
         bxdg==
X-Forwarded-Encrypted: i=1; AJvYcCXNa27fzYjsuQueUT/xqMkkaD0M7jfOwpKVVV6D1LnKZb3LCc3Zum7HyilPx03CR1HDJ+2fyw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3avpQAksef+XlMP5xm1f0IbLfotqNgt0Z9Z6Sb8NdI7THEf1u
	tU6rKKWmSD6+V1+61nt2bdN4EGA9ZR+bn3J+milNt6JnBDvMf7Oatehm
X-Gm-Gg: ASbGncuJO/EjbdjM7Hid0q8P02E4DScOGQtLdzJqqWbWp1xI4ZnV6sJtBpBLEA+ChPj
	SMzSBbvSq5XbksLfsM/ooZpb5Qatt8hl2mB/HyxYV9qrkeu0w5fjJNJUVhQUwnUU5yRRCUcjae2
	il10vogkfm94JjZsrJ1HmDaIEZOhy9z63njn/D4E2jVUWPNO2Zsgj3Orb1DWSmZGZ3R8XiUYzvt
	fp8jCHzbvYV/uNWQh9wzFk9bolVHOO3K3EI2AMfYLGz6TO235Iv/aBHrTAKd2JLh8yUjvO6QRPR
	Pc3+NM6FxRnGTW8PPun0kdN71MamA72hP93M/1Vev+SgcmwnoqyTnEqyYbWdwBoLsYHG
X-Google-Smtp-Source: AGHT+IHRp5YOw2fVBUGVpMhWAIAxEjoVMHuXmYYluzZFU1/CE6CvqubbUBsebVR9nMqw5DCTFZoScw==
X-Received: by 2002:a05:6a20:e613:b0:21d:2244:7c5c with SMTP id adf61e73a8af0-225c06eaab6mr2206328637.26.1751604926005;
        Thu, 03 Jul 2025 21:55:26 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:1aeb:7d0c:33d1:51f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62bc54sm1068673a12.59.2025.07.03.21.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:55:25 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:55:24 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, security@kernel.org,
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
Message-ID: <aGdevOopELhzlJvf@pop-os.localdomain>
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
 <aGIAbGB1VAX-M8LQ@xps>
 <CAM0EoMnBoCpc7hnK_tghXNMWy+r7nKPGSsKrJiHoQo=G8F6k=A@mail.gmail.com>
 <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com>
 <aGMZL+dIGdutt3Bf@pop-os.localdomain>
 <CAPpSM+QvO8LYVfSNDGesu4CUP0dBY+bumkxfbbuBQhYgddFaoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpSM+QvO8LYVfSNDGesu4CUP0dBY+bumkxfbbuBQhYgddFaoQ@mail.gmail.com>

On Wed, Jul 02, 2025 at 12:41:36PM -0700, Xiang Mei wrote:
> On Mon, Jun 30, 2025 at 4:09 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Hi Xiang,
> >
> > On Mon, Jun 30, 2025 at 11:49:02AM -0700, Xiang Mei wrote:
> > > Thank you very much for your time. We've re-tested the PoC and
> > > confirmed it works on the latest kernels (6.12.35, 6.6.95, and
> > > 6.16-rc4).
> > >
> > > To help with reproduction, here are a few notes that might be useful:
> > > 1. The QFQ scheduler needs to be compiled into the kernel:
> > >     $ scripts/config --enable CONFIG_NET_SCHED
> > >     $ scripts/config --enable CONFIG_NET_SCH_QFQ
> > > 2. Since this is a race condition, the test environment should have at
> > > least two cores (e.g., -smp cores=2 for QEMU).
> > > 3. The PoC was compiled using: `gcc ./poc.c -o ./poc  -w --static`
> > > 4. Before running the PoC, please check that the network interface
> > > "lo" is in the "up" state.
> > >
> > > Appreciate your feedback and patience.
> >
> > Thanks for your detailed report and efforts on reproducing it on the
> > latest kernel.
> >
> > I think we may have a bigger problem here, the sch_tree_lock() is to lock
> > the datapath, I doubt we really need to use sch_tree_lock() for
> > qfq->agg. _If_ it is only for control path, using RTNL lock + RCU lock
> > should be sufficient. We need a deeper review on the locking there.
> 
> My experience focused on vulnerability exploitation, and I am very new
> to RCU. I have some questions about the possible RCU solution to this
> vulnerability:
> 
> qfq->agg is used in both data path (qfq_change_agg was called in
> qfq_enqueue) and control path, which is not protected by RTNL lock.
> Does that mean we should use rcu_dereference_bh instead of
> rcu_dereference_rtnl or rcu_dereference?

Good finding! I think this is probably the reason why we are using
sch_tree_lock().

I have to say updating agg in enqueue() looks weird and anti-pattern,
but changing this requires more efforts, so we may have to defer it to
long term.

So, if we have to take sch_tree_lock(), what does your final patch look
like?

Thanks.

