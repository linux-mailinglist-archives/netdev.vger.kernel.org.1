Return-Path: <netdev+bounces-104627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0A90DA46
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762B9287548
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD313A868;
	Tue, 18 Jun 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OukbcIEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55F446DE;
	Tue, 18 Jun 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730303; cv=none; b=SvxoPafmtNd3L3MkOGnTVRbBzhupa5llYmrpIQnHUHrdaAUoDw2+vjplzpV5FlAhLuFdW68YQrnof3Rw/Sz8B2aNWhHDF9gix7f4D0olw9Bndluji6xPSSELR6Yqs9sgqYAhBSqc3/AHMpBSocMSS7zS0d2QLPg6jogGY7voNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730303; c=relaxed/simple;
	bh=ZGKWTfzgdsRzX+gb0DKjPB4QTpCqlNfAGwSotcVfJfQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0Iv6ChIaZXAayT7o8jO39IPg51r8K+koiAOEoJEcvJPNKSSsYRfLPbe46Nv5oQB1/m1v29DjpS9GgWmhKYDRrxjmNwRGp49YooRUsyP4JqNDCGahuvKxs/HhJcnJzcPacw4qLKLHqKx16mEuUvfyCj6ccekROTxGfYJgLTZoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OukbcIEE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cc1528c83so1390274e87.2;
        Tue, 18 Jun 2024 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730299; x=1719335099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUxkOd1P94AHf2/v22AwVnsR6zTygx+CenIExiQ2kdI=;
        b=OukbcIEEzEULfnngkvOfWN5Jxtd8f9bUskkaRi10JvQK/N0LV1RsfkXVfizjUMFaTq
         hkQA3oatdvpZPhK5X99w+nR280UspF2wR7oEtkFcNTKIc+GoTn52yQ8XT9QmN4Qczlq/
         SDOWpvX6pJuDQz979WkszmrHAdW7rlj2sxtNW71TMq5TQ9HFs3t6mVcky91sXkdibyye
         Ri8Vy9CcyHL6YWdZFyFIB3NFKdQVUVydG78pzD+j86Nbw5qSPmTvJOijz3xHvGwI3xCS
         Pv5gMQxPD9hlo+oI1/LsQt+Zk1g44DT6lA0Sjg4trJOpwxL12MR/hj2EwN0Uq1/Ccpis
         GycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730299; x=1719335099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUxkOd1P94AHf2/v22AwVnsR6zTygx+CenIExiQ2kdI=;
        b=FuWoVuGWgYqykKuQjfs2mZiesvRlfFhEVw0KtFjfnY0cVCVfmKmrE7CwEBIyWzMNjD
         ME6zv6C5CcLcxqG9+V6Clk8PDA+rvnRsWPR35u3jl+paKmbCxB5TYSgtkvNoTcSkxkzA
         3gOUiSQXBezfKC6Bu2GNCKh3qNMMqpHls2hVGxWTgX+x0iEnwN1shMFbRWU+AnrGkzQr
         p7ejh6TAxyByc6EHLWR8sfnXF7IEiW+fz7dOU7YUnyfh7+EdImYFnP1ZlOPwZS3bPthp
         +tEJ0U3naLoH43IsrGnbni7T/9d1eyk2a46tATid4tQYkswjqE+GaLJ/WIi30bZEeeE1
         cZwA==
X-Forwarded-Encrypted: i=1; AJvYcCUryeFt+RBiZLOVLvPpWwztXvy0rC16PeWkcmAYmoD+DXdaFwsXvCo5gczrYedVHftf7CPfVAR2gDOpm+I9BXhDGzwnp/p1E/WdAd2b5yx95EmhTxmrEVr0cTbV
X-Gm-Message-State: AOJu0Yzb35DyZo2Sko2hM+7H5FzD6OjnJzxtDrba8N8fyQHmjUWldpjC
	nR4UzL8lCxC9psmbBHsWSHra8Qtw7gKIbAFytOxGDzClVwT456JM1SHM3bed
X-Google-Smtp-Source: AGHT+IHes2RYjoazEyMOFAVg8gbqKFVipIBrWoqotKt6HG2FRIYgS8sfRN2AqCcv0I+tP2O5RuXVUQ==
X-Received: by 2002:a05:6512:348c:b0:52c:8c5b:b7d8 with SMTP id 2adb3069b0e04-52ccaa60842mr124012e87.30.1718730299049;
        Tue, 18 Jun 2024 10:04:59 -0700 (PDT)
Received: from pc636 (host-90-233-216-238.mobileonline.telia.com. [90.233.216.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f0dbsm1551538e87.109.2024.06.18.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:04:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 18 Jun 2024 19:04:56 +0200
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <ZnG-OII33VP7bPJp@pc636>
References: <20240617072451.1403e1d2@kernel.org>
 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org>
 <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
 <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
 <20240618100210.16c028e1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618100210.16c028e1@kernel.org>

On Tue, Jun 18, 2024 at 10:02:10AM -0700, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
> > > FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
> > > freed pointers, that where addressed by to this patch:
> > > 
> > > commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
> > > Author: Catalin Marinas <catalin.marinas@arm.com>
> > > Date:   Sat Sep 30 17:46:56 2023 +0000
> > > 
> > >     rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> > > 
> > > I'm wondering if this is hitting something similar? Possibly due to
> > > lazy RCU callbacks invoked after MSECS_MIN_AGE???  
> 
> Dmitry mentioned this commit, too, but we use the same config for MPTCP
> tests, and while we repro TCP AO failures quite frequently, mptcp
> doesn't seem to have failed once.
> 
> > Fun!  ;-)
> > 
> > This commit handles memory passed to kfree_rcu() and friends, but
> > not memory passed to call_rcu() and friends.  Of course, call_rcu()
> > does not necessarily know the full extent of the memory passed to it,
> > for example, if passed a linked list, call_rcu() will know only about
> > the head of that list.
> > 
> > There are similar challenges with synchronize_rcu() and friends.
> 
> To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
> call_rcu() as something he was expecting to have a similar issue but 
> it in fact appeared immune.
> 
In the kfree_rcu() there is "an ignore" injection:

<snip>
	/*
	 * The kvfree_rcu() caller considers the pointer freed at this point
	 * and likely removes any references to it. Since the actual slab
	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
	 * this object (no scanning or false positives reporting).
	 */
	kmemleak_ignore(ptr);

	// Set timer to drain after KFREE_DRAIN_JIFFIES.
	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
		schedule_delayed_monitor_work(krcp);
<snip>

--
Uladzislau Rezki

