Return-Path: <netdev+bounces-207280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72362B06907
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F4F3A6349
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741322A808;
	Tue, 15 Jul 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wui6ZYt1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61D19004A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617218; cv=none; b=AjFnT5B63rwvptCTPeat1zPgJnFsRr830aHLVsuDuXYLWLLZDQBTZdwpcbS4F7GnF4MPcXktxBcYSCWWN39CNJUgo6WFiSGvmjzX3M5R2ABSVP640OajJBznYGCtrnbt/6C7dNwrgNwFLiS8tkwEiW4/2fMDR/FdxdazuaDdTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617218; c=relaxed/simple;
	bh=FYN7qQ3wtMeIloFUwuYqVQw9nT5nQY1nJBAudAbgZ+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0BxZJ7GZXYRihyZc4cyKLM+vsbCrMUN3IH5jS2ZSmoPz82WEsJApY+l2NOHFZDjs+ENpe2irH2hS02vFklePIwjbRBtcq8l0j9gITul4S5fXmjiyHCGfQKv7MWnJzer5Cg4jrQrB6cMirEfCVqZfFq8gKn2oWZgsNZYtjugpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wui6ZYt1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso5620323a91.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752617216; x=1753222016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ivYWRJa+wKbkzRo+gsTKC6oLT3ayg8U72Q+PNGL7LQ=;
        b=wui6ZYt1ktnLar+FxHxwPW/5k9LwHEPUJ32Vn611S5Hx4VwUNJLsIjbfHqWvzoxa3A
         PPwG5nYXvamH1Ba8TY5GmCNL+04Pxy60fWyLuSEANanijz2VYQhrc5sahzWaLDExEzCT
         J6R4RSHBu4s+Yef0AunSplxDe1FUHTNSfw1aSfS7xFVAqWwuyXaE/IwTKKHtcXwZhuxW
         ZpWhZfiO2gUGKiqiK+P0sPsDb1DiWTZ8bisfLx6igQBCHUsLcTuHYcNkHQPT3w7E7RMB
         oI2ZKKVGvGML1cO6TffdtkvlEIS3QsC75Jiddfe13G29BI9fnS8QJ/o/R0w1lSqiObK7
         uAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617216; x=1753222016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ivYWRJa+wKbkzRo+gsTKC6oLT3ayg8U72Q+PNGL7LQ=;
        b=kjyiEWrD9m904Z4qcIcSjAS+LWsk5YobC3busVzgJhgQXQyKKkCR0XXYsUY7TKGnDr
         5ePM+I2HIdYtwVYuPorB3O8EN1QB4L3XOXIhbYhJkNNeP3Lerwr6mqae5w6Barapenwt
         6A54QRlDptbqZuUmSKC4o1PWCld6ykWOl633/yi6ylQnvd8V4ZCuKkQd9sop0yzlywzz
         rmlcO6xJfriVkPId07gC39fAgMkGcWOjoGTGNetk3kaU0f3wnBNikSJBv16Y3kqBwhUn
         hn3+EDCdLIF674JdPQKriMZayypjYfuQoTHlzqMZdqSAdDEMnQEsGIQ31b+ss7/rOsp1
         7nJg==
X-Forwarded-Encrypted: i=1; AJvYcCW9w0mMEGYkUBWeqvf8b2tIXWNb0LyV+3acSssRAAZwEJp/vfBnERrqB//3wm1yxa8cwxccMC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzuP0jYRt1BpesP+1lcqHLr7xLYOB2M0zfahso5P4CuMrf76i
	WqBMwvfq6EwOYJc4BHZnNM23VHUEEWTg23Fk57nHN8/rNaXH4KH3V0so3oJWRt8vi4Gycc8TMTG
	NTXnC0Q==
X-Google-Smtp-Source: AGHT+IFm+o492D+iYGYVXngXigmjJ56Ak7zLQn6QburTEMVEdENXrustG32q+qYj94bgOju10EwdS2remUI=
X-Received: from pjb7.prod.google.com ([2002:a17:90b:2f07:b0:31c:160d:e3be])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:311:e8cc:4256
 with SMTP id 98e67ed59e1d1-31c9e758d15mr851933a91.22.1752617216290; Tue, 15
 Jul 2025 15:06:56 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:05:39 +0000
In-Reply-To: <5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715220654.1337102-1-kuniyu@google.com>
Subject: Re: [RFC] Solution how to split a file in a way that git blame looks fine
From: Kuniyuki Iwashima <kuniyu@google.com>
To: przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 15 Jul 2025 22:33:40 +0200
> Hi,
> 
> I have developed (or discovered ;)) how to split a file in a way that
> both old and new are nice in terms of git-blame
> 
> https://github.com/pkitszel/linux/commits/virtchnl-split/
> 
> The purpose of RFC is to ask if anyone is in strong disagreement with me
> 
> There is more commits needed to have it nice, so it forms a git-log vs
> git-blame tradeoff, but (after the brief moment that this is on the top)
> we spend orders of magnitude more time looking at the blame output (and
> commit messages linked from that) - so I find it much better to see
> actual logic changes instead of "move xx to yy" stuff (typical for
> "squashed/single-commit splits").

FWIW, git-blame has -M/C to track X-times line moves within/across files.


> 
> Cherry-picks/rebases work the same with this method as with simple
> "squashed/single-commit" approach (literally all commits squashed into
> one (to have better git-log, but shitty git-blame output).
> 
> Rationale for the split itself is, as usual, "file is big and we want to
> extend it".
> 

