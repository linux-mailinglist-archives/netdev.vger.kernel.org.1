Return-Path: <netdev+bounces-204739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F9AFBF15
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E653F18947EF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB83184E;
	Tue,  8 Jul 2025 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="EuobKya+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D711712
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933142; cv=none; b=sVd9Vp7FmkO14YpZXLmKB7fUq77ooYc62PDbEwVfQyLPuly7isWAQcb0Wv7on/6jsD9KJTucJM+TgLBsa3GuDMi2G7GjKxFuGNscRtWz3nF6qxPCq4EwEZe6hwC8VLTMJuU0+a8v4nkJDCLBYw+na/HQtxpWDg3WZWcrHP4Xevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933142; c=relaxed/simple;
	bh=kSeyGcLKtdKoPRRDEx1djiAhpLebTZKUDw/YqD0rKos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy2ITijkwFzSNsMsaUKttsP1x0AnadJtuo03H6Lxu+AtNkd8RPdMa7M/noAm5BF92ojfJRh5DphbYpawOxQfnwqWPc2QJiMvgssj32kRLdIkj7dwm0LlwWZB9mBh27uL51kWP/BpkkBBvWDb3qjYOHRzDyK5HWXIJOsifuoU1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EuobKya+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23694cec0feso32876715ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751933136; x=1752537936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PNBZfXvjOjGzQuubLaMUwtvjev1tJIe1PRGjbweck4=;
        b=EuobKya+gojs2Bn9E09DFRb9mYp+UoU5VXVrWKUbYy6M828gL8kCRMgOP/l4AA0O+c
         s6vYdx7ct+iRpsu8pRNE0rXB2HvMbLivrqDEB8dJ6OC4UpZQYf2WZ3VG//ilAR+XJRfr
         OJLhDwen0H8wYPolfgCTu5vKxmPtzqY0yRGy6ntOsgEwLQdgS8Q5D+y18s/nhpQYwB9k
         q6cEGkpRVypfvcfeaXh2Pba1uEtWZo2Ey602ASjM3BbIquTWKHrIyu18INq9UAyIBlW6
         YTd+2ZHXAMRyPnP1tlS/M84SgciacoXtZOFB4v+MRnbpopqEghrmuirdaXj05jSDrDT1
         HbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933136; x=1752537936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PNBZfXvjOjGzQuubLaMUwtvjev1tJIe1PRGjbweck4=;
        b=iQtVVxbg1rCEmmbtZa2qwbUMZsjoBejLrwLf1XhaTadN7mQg+O7KrINpSuxmgIQoDe
         Tu4T4CajtMLuB2dvOklFWdfoMYW6pg3b8pzvqD1SEWLG1PHPb2/YzS9PSliTiBcKk9QV
         qbrC3TeHdv4TiEs9UsEtUi/vGAhrhNu+vfDSM1B296KPaVYbUoKXh3jZAGsGfsu+Ibhw
         2UNiYL2fWhRqEFxbch20ld77LpQdb1qercAjsAJ/fKwYRQBQ6ACpI3Us3BWpY+sVYUqx
         fGnjIubWRP6OQiGxwBB8RedRXkip1bsAKYuYEYeHheo32Bmx//ToYISr1OkvTD+oLb0R
         aybQ==
X-Gm-Message-State: AOJu0YyuzOR9ZvMds/KX9N93ikAsq1kAuFGNb3jJBBWqtwic7P4vmkF9
	kYu0bBF9/ardyIhP1Hec6eL9Zn0FcucK0Qgs8DsiANwnmlf7lXrem+SSWid+2YUvqw==
X-Gm-Gg: ASbGncvx6N2FPPb67vgQF5qIDSWUG0oQo485LGXz6b3vk7phr1VbjjjBPE2Dmd9Iua0
	7efJbIKzmUr2sKlr++2oBOZ8qRDTnHXH6/9Ohkaizy+/zJpWCn3F2qzuMz9qIO4Qg4qB4VLWtEj
	T7Tj8Qw7Fh44w6Vu8Az+Lls87flh13dyYeDtoAIdhw2mmpCMBiINMoy+PHEHjou+2hKueBq0Y3A
	yeuXLLs5L13QblnMbAs0jYcnzx4i1E/QBHiKykcRexPxVioBSQnQbGWPDlG5aWYNydv4Gtu58v+
	RpqslG9pKVdVfXK2sRDEJhhgBZNs4DaIM40TzfcMmcWoliJvBRTOeII7GwVCaZyAbVfZb7tX
X-Google-Smtp-Source: AGHT+IEF1yt3/e1XPDJYTaM3SisQxUvfxe+8U8j2f+9g/uISLV7Y2jZyi3qnuGhlExYw97B0UkQ9HQ==
X-Received: by 2002:a17:902:da8d:b0:23a:cba1:6662 with SMTP id d9443c01a7336-23dd1d9c82bmr7668605ad.46.1751933135725;
        Mon, 07 Jul 2025 17:05:35 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d09esm95489065ad.90.2025.07.07.17.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:05:35 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:05:33 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aGxgzS2dZo8fKUw5@xps>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
 <20250705223958.4079242-1-xmei5@asu.edu>
 <aGwMBj5BBRuITOlA@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGwMBj5BBRuITOlA@pop-os.localdomain>

On Mon, Jul 07, 2025 at 11:03:50AM -0700, Cong Wang wrote:
> On Sat, Jul 05, 2025 at 03:39:58PM -0700, Xiang Mei wrote:
> > A race condition can occur when 'agg' is modified in qfq_change_agg
> > (called during qfq_enqueue) while other threads access it
> > concurrently. For example, qfq_dump_class may trigger a NULL
> > dereference, and qfq_delete_class may cause a use-after-free.
> > 
> > This patch addresses the issue by:
> > 
> > 1. Moved qfq_destroy_class into the critical section.
> > 
> > 2. Added sch_tree_lock protection to qfq_dump_class and
> > qfq_dump_class_stats.
> > 
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Although holding sch_tree_lock() for control path is generally not
> elegant, this is clearly not your fault, the current code is already so.
> Converting to RCU requires more efforts, so it should be deferred to
> long term (net-next).
> 
> So as a bug fix, this patch is okay.

Appreciate your code review and guides for the recent two qfq patches.
I'll try to provide a RCU implementation on RCU after I triage other found 
 bugs.

> 
> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
> 
> (I assume you tested it with all tdc selftests.)

The patched version passed the tc-testing and my pocs can't trigger the 
bug after patching.

> 
> Thanks!

I have two more questions:

1) Is the patch provider the person who usually adds the "Reported-by" tag?

2) Am I allowed to request a CVE number for this race condition bug?

Triggering this race condition requires "unprivileged user namespaces"
(net_admin) and the bug can lead to privilege escaping 
(refcnt issue -> UAF).

Thanks,
Xiang

