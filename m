Return-Path: <netdev+bounces-202688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF502AEEA05
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991C43B6C45
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE10242D82;
	Mon, 30 Jun 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhhT3/R8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EA21D59F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321462; cv=none; b=M3a02Ai8yTAUxRVTv6T5E4IbdJ3fQ586FyO/9vp7CzDoZC4Wie/Fz0jYgQK09W0UFSBEqvdz3yr7Xi12d14M+o1nbNXJH0MfHTtJkG9u+FJgK5LGTaIhMdYQwkOyQugsJuIyY+h18vtzCeNzod4CkqWsVFvreFWpreH4QoNexgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321462; c=relaxed/simple;
	bh=LuH80DecgUd9a5bFSCybWB5fvkQJm/YedwBwVO4Ifl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD0o3MmRlzEX5Rw68NSF0urFvO8B7kbA9fGp1Tmxd7OeIpDgpVgH4Un224qFzxpPcULUHZ3Qn/augXC7jorUmr0BFFQfh4o+QB77X/FaxBxesMyClxhrlSe2LiRVwPmoqUGmsZ9RbmCvsFOzSdYa/bGEmYgzRz7+eQ5uQ0lHu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhhT3/R8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3137c20213cso2612858a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751321460; x=1751926260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+s2GuhQpX7bJyV/8tPti3TH8xcbSYNx6pDODqeeIJis=;
        b=HhhT3/R8B92UjcVx87Fvk6nnkzDpKUJRR0ix0yFUX2qsVP9+y4Ae9/Q8WuoqrEasTM
         0WabUD/4IpEbQYzYiOZ/ydApZ8LeNT32OQPBF4AeqcRQKBojCA33OQ1H+wIY9RsK7YOi
         ijZAzqL1DENeSzNgnpaE0V21ZhtRFZHBRco/gTBRDC1yVqX8BadKlVtGRQZXVc4/eOt5
         3fcxoD4jRM0QH0UuXjtfrnZUI9VsJRmcxmLIqsuj0+e3YhKaHvL5Zsmae/Ik4T6t+BHe
         5Uo76WVbB0Ur0S8a85eemP2CcMeg00/+Pv6lA8O+4wv4iUc6NzsB4bjKmbIagqlgC8/e
         9Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751321460; x=1751926260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s2GuhQpX7bJyV/8tPti3TH8xcbSYNx6pDODqeeIJis=;
        b=f45FoCVemay+YRZ9AnOVoYpFqHd8PV9GBRrehKfqF9cnurCU7PFbrkKuM/Z5Uy3okd
         iAuP2nzpYH3cIr4aik0L58WVhBX72I5zN4LX4vhQhCEA9AR3d1SP+g3zJ6YE2WOVM13v
         PWnDvvt60LOJwf26PuRR4tpmCmIsDMk27OUKOmfW15dXUEqznbbeAwVSU3Dd5Sm0Wth7
         UW3ZGrgkHcNp0k1LeWsrcbH8ZKQ1rm6XkBgncKaVsRtRq1/lWYGlObGKk03USt016Qnl
         GlKR7kTZ1iaP3F13XIbOsn8+q2Sktzw8RG7hGte+F86DsGL1oFDm8cYUeMj23XtyhwlJ
         Iimg==
X-Forwarded-Encrypted: i=1; AJvYcCWnb023VWrwvvsYr9ZcCLxOJaBiyUGpWa4JInel1pHW4XtWGWhR6aIY5ES2RADxt+DSkYqwZgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnS1G5X1srEvi/LwR6WB/xWxLRybcEqAp8uIB88msA5gvRB3M
	Z2B3hIyBFO2GOOj72yTTc58ofbQ0Oy+buPLgZkq6wLVkEOZ1BjhGf7Xe
X-Gm-Gg: ASbGncuN9QzGZVEetwTxCLXYZxa0X0oUhpEo/lPalYLom/x+ba8eCAsnw9Akb3u7n7F
	9ILExh3Gs4VzzZHwMcti9y4Iut9incJJ8Lza2dSbV2QpM5GLU05N8SETQZfBT+d73VZvLXbCSbn
	Ttrrr6RpUe2UHuxJzFgVMjCamI2JM4izvPMgd8SbYKWVx+QKley9MRvz+SVJXoj7QoiT9/wIViC
	T+ZaxIFO+/ps47PPvelOtgCVB8SH+1EaKyI5eUAYsP92dwVJVYQbtyFmysn8lRUUQJVQLl7EhTr
	p9NRbbbeL4s2EM54Ba6jmnY+0XUt8nagXrhFPd9bIiDl3FGDCmzOJ50AVjkT0pHxcw==
X-Google-Smtp-Source: AGHT+IHb7srWuaqukaeiHclNWtrtItQVJVh1geFAxUrtuOqwEg4UGUcv+RAZ9N7RrXebrqzgns2uCw==
X-Received: by 2002:a17:90b:554f:b0:311:fde5:c4b6 with SMTP id 98e67ed59e1d1-318c8ecda6fmr22779010a91.6.1751321460440;
        Mon, 30 Jun 2025 15:11:00 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f543bdc3sm15095340a91.41.2025.06.30.15.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:10:59 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:10:58 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Mingi Cho <mgcho.minic@gmail.com>,
	security@kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: Use-after-free in Linux tc subsystem (v6.15)
Message-ID: <aGMLcnzpapXQFbA+@pop-os.localdomain>
References: <CAM_iQpV8NpK_L2_697NccDPfb9SPYhQ7BT1Ssueh7nT-rRKJRA@mail.gmail.com>
 <CAM_iQpXVaxTVALH9_Lki+O=1cMaVx4uQhcRvi4VcS2rEdYkj5Q@mail.gmail.com>
 <CAM_iQpVi0V7DNQFiNWWMr+crM-1EFbnvWV5_L-aOkFsKaA3JBQ@mail.gmail.com>
 <CAM0EoMm4D+q1eLzfKw3gKbQF43GzpBcDFY3w2k2OmtohJn=aJw@mail.gmail.com>
 <CAM0EoMkFzD0gKfJM2-Dtgv6qQ8mjGRFmWF7+oe=qGgBEkVSimg@mail.gmail.com>
 <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
 <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>
 <aGGrP91mBRuN2y0h@pop-os.localdomain>
 <CAM0EoM=jc7=JdHMdXM9hmcP2ZGF0BnByXWbMZUN44LvaGHe-DQ@mail.gmail.com>
 <1a169adc-fe99-4058-a6a7-e32bb694e997@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a169adc-fe99-4058-a6a7-e32bb694e997@mojatatu.com>

On Mon, Jun 30, 2025 at 08:52:22AM -0300, Victor Nogueira wrote:
> On 6/30/25 08:06, Jamal Hadi Salim wrote:
> > On Sun, Jun 29, 2025 at 5:08 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > 
> > > On Sat, Jun 28, 2025 at 05:26:59PM -0400, Jamal Hadi Salim wrote:
> > > > On Thu, Jun 26, 2025 at 1:11 AM Mingi Cho <mgcho.minic@gmail.com> wrote:
> > > > > Hello,
> > > > > 
> > > > > I think the testcase I reported earlier actually contains two
> > > > > different bugs. The first is returning SUCCESS with an empty TBF qdisc
> > > > > in tbf_segment, and the second is returning SUCCESS with an empty QFQ
> > > > > qdisc in qfq_enqueue.
> > > > > 
> > > > 
> > > > Please join the list where a more general solution is being discussed here:
> > > > https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/
> > > 
> > > I think that one is different, the one here is related to GSO, the above
> > > linked one is not. Let me think about the GSO issue, since I already
> > > looked into it before.
> > 
> > TBH, they all look the same to me - at minimal, they should be tested
> > against Lion's patch first. Maybe there's a GSO corner case but wasnt
> > clear to me.
> 
> I did a quick test of Lion's patch using Mingi's C reproducer.
> The patch seems to fix the UAF.

Good finding! I think Mingi's reproducer still exploits the
->qlen_notify() refcnt to expose issues, but the GSO segmentation itself
is also problematic even without ->qlen_notify(), IMHO.

I have an elegant solution to move the skb_gso_segment() to the upper
layer so that child Qdisc's don't need to handle GSO segmentation any
more. It fixes the UAF too, without Lion's patch.

I will wait for Mingi's response to see if I should submit it for -net
as a bug fix, or -net-next as code refactoring.

Thanks!

