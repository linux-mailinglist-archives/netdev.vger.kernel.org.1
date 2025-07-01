Return-Path: <netdev+bounces-202736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F890AEEC8F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F071BC2FE2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34E1B0421;
	Tue,  1 Jul 2025 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Fa+pl0qR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83F1CFBC
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338370; cv=none; b=gWtvNQ5ygT17gYK2ZGRQAa4Pj3+80OL8BxjySyHW53S6TLbJJ7Y6Vs4cx+cjvdknOv6YTSSZywH66Z+mbYFM0C5ny+z+tk04T3+kSErHbbAuyMC3Dd7qSUu4hVFqPIGh60sBjZQm0RU0k7A0slxf6LDoAHoP+2ReT+7fgCZakKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338370; c=relaxed/simple;
	bh=v6Evnb2I3+fWSiDcOpifbaVXDVTtKPftTBRX2bCGo1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBUVKAfE8JcvWDcxvkK7c4Ti2YnjkNzVCQMJufr/ipMfoytQ/ZJ2UwioFjb2YcuAkpnS1XFgjOV7VBqGMykMfNau/wMXjaxkImKck7oJzIrE/3jvxUvXnIi1J7ISOO8yTSzafVIRFS07LA+PiQw8Ql4mtGZ6Teq5Qtwk4TJ9w9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Fa+pl0qR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234f17910d8so48609395ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751338368; x=1751943168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XA82WdDiuiRBhOxxHj4gjoxCVMawJewhm3zcgQmov4=;
        b=Fa+pl0qRsPsPjtXodhLGT4DcvxnzMFDgBj70v/1u7ArDBNgythxSLoAkKwNDe8oT5m
         gsaWLOxo/GTJnNIIIVPszoRWYTXxSYLJVjWsC2HFo0OUPodkvYKuNmCEAD5QYpikCPn+
         GlL5uXi8oyeH2UMLurAN8X2a4Z4WFpd0KCNT8pmEQ5n1808ThNhclvlRJmxZX1ZezuEG
         KGtEdq3ScSARX8BiBa6bVsAK9tfrSoDGBpqiwJbH1cSZ6n8dSTRQauQZWru+0pCjg+iw
         OJ6o+Cvw8pEyKA9UROlJ3BO8GIbJQvW41f+8VThW9S8djSoCpEAYErixeoUalyLD85Le
         xomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751338368; x=1751943168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XA82WdDiuiRBhOxxHj4gjoxCVMawJewhm3zcgQmov4=;
        b=e7U7RyrjM0EAicdZQzZ2OrtDEJayDZZXkLx8XwANn4Kj4s84b2cMDPMp7Z646FrDDl
         YKH3Fj6pBkcVRg8lR/t5Iw88HdguBuptmSvG1qUvFrVJUhw9Tfl4eVqCstUTodluSobt
         YGOWV0i5gw2j7kxX87ei4mtQ0mv48OSMVm3eOd9/scNmLX0XV1doi13ZIFYdHtRQKbZV
         ERCnwBUKEYjFlNkBSPQKkGB9LyjrXyjybPKkQ7d1V0DBRry1rvo+Nnb7FFy/MQD45w3L
         c+4FB9AuwHKBXf/3dwinAm3BZ6pBZ3cIhiqcphFHNPcyhFX8Xx4fbvRiji/0NrfAPyqh
         H3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXmcENorzMt3X7VyXHrX4NEadx4IZyp/YAkeb9eHsCCM1VsdoyeQAMegAzpsehLyliWzKZ2bhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMIavOTRWvyLxMhV25J5JZZe56m/MMvhUwHzk1DW9icCKhCx5
	lgYpjcgZJ7u/p9Xpsqy/mBc+EOhp1GJ5GGMjBpNGV9da/b8wf6AYss9/IuN4fGInkg==
X-Gm-Gg: ASbGncsYCC4ZsW9bfAfh2BQTZL1krGglhe5hsovXMITVOUVeybstpyx5kGKTeDPm1KP
	kC2F41mXwABu7qNO8HstxPvCYU/HM2L6vm1U7ggE1X7T0dax9bqAWPkfRzUvWvgXnZsgqHntXEA
	1eaSLsRO2vV3TRuAsaxbb5YJ8K4Oc5oNswmDo9NRsjvz9BvprRrjgjk9tBFqXNVh4IhPQpzyrJZ
	e+7K2UzafYXBh/DvBhc8yib2s2BGrav2ljoj8xMCV+cQbOEOnYR+L/pkgz+REXcwJVt7txkx/fJ
	2tdy2aJxNWWIUNaPEgRIV+vga2v1Wu4EplC7QPuAte3fHvduJBsOK9DsY4jxWxRuBlLUT9aX
X-Google-Smtp-Source: AGHT+IFXPuYYGCxTfvQ6rjCphuFAz32TXNfIisW06//VbjVHyqPmvGa+8Zv3+apWAQbliLfXO2I8rw==
X-Received: by 2002:a17:903:230f:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23ac45ea926mr244245235ad.21.1751338367712;
        Mon, 30 Jun 2025 19:52:47 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e39besm98891115ad.13.2025.06.30.19.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 19:52:46 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:52:44 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, security@kernel.org,
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
Message-ID: <aGNNfN_qoqLYm-34@xps>
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
 <aGIAbGB1VAX-M8LQ@xps>
 <CAM0EoMnBoCpc7hnK_tghXNMWy+r7nKPGSsKrJiHoQo=G8F6k=A@mail.gmail.com>
 <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com>
 <aGMZL+dIGdutt3Bf@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGMZL+dIGdutt3Bf@pop-os.localdomain>

On Mon, Jun 30, 2025 at 04:09:35PM -0700, Cong Wang wrote:
> Hi Xiang,
> 
> On Mon, Jun 30, 2025 at 11:49:02AM -0700, Xiang Mei wrote:
> > Thank you very much for your time. We've re-tested the PoC and
> > confirmed it works on the latest kernels (6.12.35, 6.6.95, and
> > 6.16-rc4).
> > 
> > To help with reproduction, here are a few notes that might be useful:
> > 1. The QFQ scheduler needs to be compiled into the kernel:
> >     $ scripts/config --enable CONFIG_NET_SCHED
> >     $ scripts/config --enable CONFIG_NET_SCH_QFQ
> > 2. Since this is a race condition, the test environment should have at
> > least two cores (e.g., -smp cores=2 for QEMU).
> > 3. The PoC was compiled using: `gcc ./poc.c -o ./poc  -w --static`
> > 4. Before running the PoC, please check that the network interface
> > "lo" is in the "up" state.
> > 
> > Appreciate your feedback and patience.
> 
> Thanks for your detailed report and efforts on reproducing it on the
> latest kernel.
> 
> I think we may have a bigger problem here, the sch_tree_lock() is to lock
> the datapath, I doubt we really need to use sch_tree_lock() for
> qfq->agg. _If_ it is only for control path, using RTNL lock + RCU lock
> should be sufficient. We need a deeper review on the locking there.


I agree with your point and that's also my initial plan to use RCU lock 
to solve this issue but I was concerned about the code complexity since 
applying RCU lock on agg objections would be a verbose change on the QFQ 
scheduler. I'll try to make an RCU patch as soon as possible.

Thanks,
Xiang

> 
> Regards,
> Cong

