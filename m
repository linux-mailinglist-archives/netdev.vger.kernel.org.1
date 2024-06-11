Return-Path: <netdev+bounces-102409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D2902DAF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AD42819BC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3B370;
	Tue, 11 Jun 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w/aZNkPn"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910036D
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065868; cv=none; b=X4ZnJl77eFQiozzphHQjqG8Kjp0w5rvS90nmEib02vHKgMa98PQNwmFV729lRyemqrPY6/+G/3nnSzxUHoqU89cCva7Ia9dAxrfLqp6e2bA+/E0RKyXXxtNhri1lfur6oRQfr/3fJ6/W9y10h6PfZl3vLKRlIVVZvStu4dpT9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065868; c=relaxed/simple;
	bh=SVXkzoI1blO9jAvqkJ9nCUQTQ8RBafjjEK6AJCLPAUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN9ftCnZ0Abbt4uDuFOy6qfA4oIwdEG4Q+RBL7Ulfp/T8qWzj+HINBBOYvvhQErAzTODJTinjKBeXvkRXdbeVVCAzhLORmmeFgW5s+oy+p/V6HrQQ03EqRlJaSQ/zaV+p1lI6SiqcMFdHRJHl7bivPRjaSWeUt4DSKOBoL/k86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w/aZNkPn; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuniyu@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718065863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GPA3dSCcGkztdukKEcz5rKm1vv6D5teuaGri0PCbHds=;
	b=w/aZNkPnG5MY1OL1v9k8PP4tppfUZ+N+c2jQBaFZkG/+BG6yBvG+q74ELB5mjzFuzP/Gsg
	Wg1XrfDoaE6sVVU3U/i3MlXu5FOffL0nXtZndmE/6wBoyQmNsClQ1+pyCpIPrqLSqpSVrv
	fdrPbEwDaAfln/ar6ATJoc8P3I1v+LQ=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: kuni1840@gmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: pabeni@redhat.com
Date: Mon, 10 Jun 2024 20:30:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v1 net-next 01/11] af_unix: Define locking order for
 unix_table_double_lock().
Message-ID: <thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo>
References: <3vjpisr5vw5cts5h2wrtcqttgweyidtyjw5vgslhimtvy2oobu@b4hgsefmsmwj>
 <20240610235836.81964-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610235836.81964-1-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 10, 2024 at 04:58:36PM -0700, Kuniyuki Iwashima wrote:
> > No, we're defining an ordering, there's no need for an enum - this
> > should work exactly the same as a comparison function that you pass to
> > sort().
> > 
> > Comparison functions are no place to get fancy, they should be as
> > standard as possible: you can get _crazy_ bugs resulting from buggy
> > comparison functions that don't actually define a total ordering.
> 
> What should it return if we cannot define the total ordering like
> when we only define the allowed list of ordering ?
> 
> See patch 8, the rule there is
> 
>   if the nested order is listening socket -> child socket, then ok,
>   and otherwise, not.
> 
> So we don't know the clear ordering, equal or greater, but we know
> it's actually illegal.
> 
> https://lore.kernel.org/netdev/20240610223501.73191-9-kuniyu@amazon.com/

Ok yeah, that's a tricky one, and it does come up elsewhere. I think we
can allow comparison functions to return "undefined", and define 0 ==
undefined for lockdep.

The important thing I want to maintain is that comparison functions be
symmetric.

