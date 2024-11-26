Return-Path: <netdev+bounces-147319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB79D910C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 05:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8698B220CA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C242AA2;
	Tue, 26 Nov 2024 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHJn18Vo"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513162260C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595756; cv=none; b=DvV9hTR4gBkhZCt3oanky9yp0y0FvD/AWTPtnB9eV1zgzi47ZvyySV04tQskLqYGAt46lyN9CcYwZ7wMRBEy1lkKAF6SMlWmKdUM/+q60OfcxFM4AJpxqcfcbkn5El0aB6KYYFsSmiSrtpzmULPWzE4UvwXElzo75xG6ahv4JZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595756; c=relaxed/simple;
	bh=w0a7laltbCAyWrZakTD+qFIXTZu9L6aTl3+FmyrA1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIKP/e9RkyQdyU1ThaqNgtkUDpEh7Xk/hBaqdUr1nH2tOKpu6wwdldyJiiG6FzN5TGlhGJYADHG+zqiYwUsOOzCQw2Y34eRzMfnHbPS92bYzV21bkfVneFRyGbvraPfF4hrJ1hG4HOAWhZvb/zY6i+M3y4qSa93GHKmBHDmaiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHJn18Vo; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Nov 2024 23:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732595751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ms3SNLuCPwKxinj7AVS6hyjHOWnJA/mWxFozSkndvrM=;
	b=jHJn18VoRHbL9w7mYtEEAdXUSzrjNQgRl3Yk1xdKTzxdA5p655W8e/zglWsmVv4CKrnmCW
	pyhtw3lqAbo+FmbcgrocnyDPsK2ypJRfF6D4xeQTMUhssz7JntHDggfqUb9rvcM5vPLZAM
	VCXrIzrNxDCPgqkvpKItseVNjYxYYTE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <bdnyshk47krppnfczkn3tgdfslylof3pxhxu7nt2xq4oawyio4@ktfab5bu7lis>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
 <Z0U9IW12JklBfuBv@gondor.apana.org.au>
 <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>
 <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 26, 2024 at 12:00:01PM +0800, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 10:51:04PM -0500, Kent Overstreet wrote:
> >
> > I just meant having a knob that's called "insecure". Why not a knob
> > that selects nonblocking vs. reliable?
> 
> Because it is *insecure*.  If a hostile actor gains the ability
> to insert into your hash table, then by disabling this defence
> you're giving them the ability to turn your hash table into a
> linked list.
> 
> So as long as you acknowledge and are willing to undertake this
> risk, I'm happy for you to do that.  But I'm not going to hide
> this under the rug.

That knob was. That's not what I'm suggesting. Can you go back and
re-read my, and Neal's, suggestion?

