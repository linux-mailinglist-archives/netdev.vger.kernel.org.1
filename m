Return-Path: <netdev+bounces-202690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67634AEEACB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD023AF63A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B523F405;
	Mon, 30 Jun 2025 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QExfAQOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA81A073F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751324979; cv=none; b=a/Pjy2+hAHKkWTo7F8oc4BKM65jhv76Irrl7AiGKbNoRIJgWGX1myCfSl7bTUsfGfg5v6g8lbf4hlqGwOx91w5AkRXFJ5YlWoFGsu76jimvQDJ5KrBvSy2zpfrSI2nLtrwlwq1VH3zEiWASqv41M8sm/xiRwGPNO1xgSI7GpaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751324979; c=relaxed/simple;
	bh=SI1g1Af8bUWqv7klGvJxfnxWjUPQ1hdLpG3e98+Btgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqPh5unbNMCaRRzsKUjoyhlTkPrSFmZKfoLZReHiq1ZE8D9TKSf6T+we2rubM94wZRatrBsAiSkMBuMd31LAaeJWp5PZcXkG6M/GFlJdhp5ZocjRubm22x+Y3mC3zLcKGsz0mSFQBGd5OdfDmwdEQ/0ZIpVMx8zA6euDmsLAOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QExfAQOP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234b9dfb842so23000235ad.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751324977; x=1751929777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgryavIzHrW84FfdezKAaodrH5ik4DncWG+n1x4XASo=;
        b=QExfAQOPX8XBCmfLRq/8HGn9+CJoeDD1wMMJQ3NgxulRoF9VHkenyODy5wY+TaQSxa
         c6tZWKCBog3qqGxzEHU9NoFddZqeUZ3EpBj1a+qqDB5zMqMQY3kgifdXJ3LMakt/Sqsc
         P8HSPKCGhxQCpEzIyZQt0ltO8s4b0kuJ8Fvj5CDEZjQCxvHL+M+nH6aRkGEcIo5JG3rx
         R422QB1TG7i0yZd2wL0W/UceI2bsPv3n7/JFxMH6x7HEbtZ5Q1DqLrFJ1FWy4+ivwKUr
         hIh8pC8eMJDCJXkDA2m4vK6RKqaLSNkLq1BkPhQQ56qHNopsaG7txjY57GS/xAkMP70F
         2KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751324977; x=1751929777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgryavIzHrW84FfdezKAaodrH5ik4DncWG+n1x4XASo=;
        b=RjSZO03tdMZVpOXxgTSwlw3iC5xAk1nEBudNhlqBigCBUjsisGrWNUbebvKCi7U7Fi
         t5rL0lGmUxM6biU5cgCAMNDTEoMrtnXn+t8Mhb0DaYvl/HnQQdgYtPTxTCRZA03rmpWJ
         4z/tvK5ZNQr44fV9cQaFfM0VjTvrQYGPC4GbF6iHKelULo2rwnuSUZUp/YcOx8JhYFO0
         38qDN5AVVKPqxk+ppBAtA0oB21n+FyKFawgWZOE/nk3uSdSo9ac2aGbyUXtV5AhYIegP
         h87JMmHXk2VRB9qdsbD/KNln7hWebeb1BNQKBzaWQWHD2bFFdAC9UxbM7mdavMG82cg4
         8eTA==
X-Forwarded-Encrypted: i=1; AJvYcCURBE+iaFQI9N1mDVA7ajilEMCfOv0Nz/yvltN49MvKxwlZD6jBO+qh1mbB2zNCG90isfMN00s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1CsP3YBRjEAVSO1CSvk6b68VHZhasb1Zylytzdn+Sx9WpB7h
	/nKuoKOrNqtzACozsVg5Icd3Ou4x5dne3cnGzQveCjrxO+qXcZj2xWdz
X-Gm-Gg: ASbGncv2bnwDYI83tUBD6dvfi9LqIXAVZMNiskfq+6LVDitsVfa+/p/Q+HFpQYllVic
	4KUoyQr/8nmxbaKAUqs5ilsj4mvS5TmbqHRYgVf/wx+Ovzs9imc/43kJYBQ33sGI0onJpLBxWWm
	e0qruyWjFqaf57GKMjnnODIYsokxEG8PoOTWFKKA9+sVubjdTJW0e51DEtUvsMITXdcCNwQ5kzs
	e2CzdwQaaxN51jglbtOtEwsyAKhiGp/qQzN7bkO6doEzwQDwJGEXVXg9qRl34KEcxszK2y+xk7Y
	kYTBo8PV5Fic9l0iEa/gkxeGyLULEeAgqNKGNC8oFY7ug0XidLnNili6q5hQ8ax+87Ws5nimE/n
	/
X-Google-Smtp-Source: AGHT+IHqpuheXiz3SzX0uLBOapgJRWWSfXN77768bWhsIZmGcfw342WDAnclJo5dWBaNSnlb0T4byQ==
X-Received: by 2002:a17:902:f90c:b0:234:f182:a735 with SMTP id d9443c01a7336-23ac45e24a2mr165077845ad.34.1751324977002;
        Mon, 30 Jun 2025 16:09:37 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ce960sm90776245ad.250.2025.06.30.16.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 16:09:36 -0700 (PDT)
Date: Mon, 30 Jun 2025 16:09:35 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, security@kernel.org,
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
Message-ID: <aGMZL+dIGdutt3Bf@pop-os.localdomain>
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
 <aGIAbGB1VAX-M8LQ@xps>
 <CAM0EoMnBoCpc7hnK_tghXNMWy+r7nKPGSsKrJiHoQo=G8F6k=A@mail.gmail.com>
 <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com>

Hi Xiang,

On Mon, Jun 30, 2025 at 11:49:02AM -0700, Xiang Mei wrote:
> Thank you very much for your time. We've re-tested the PoC and
> confirmed it works on the latest kernels (6.12.35, 6.6.95, and
> 6.16-rc4).
> 
> To help with reproduction, here are a few notes that might be useful:
> 1. The QFQ scheduler needs to be compiled into the kernel:
>     $ scripts/config --enable CONFIG_NET_SCHED
>     $ scripts/config --enable CONFIG_NET_SCH_QFQ
> 2. Since this is a race condition, the test environment should have at
> least two cores (e.g., -smp cores=2 for QEMU).
> 3. The PoC was compiled using: `gcc ./poc.c -o ./poc  -w --static`
> 4. Before running the PoC, please check that the network interface
> "lo" is in the "up" state.
> 
> Appreciate your feedback and patience.

Thanks for your detailed report and efforts on reproducing it on the
latest kernel.

I think we may have a bigger problem here, the sch_tree_lock() is to lock
the datapath, I doubt we really need to use sch_tree_lock() for
qfq->agg. _If_ it is only for control path, using RTNL lock + RCU lock
should be sufficient. We need a deeper review on the locking there.

Regards,
Cong

