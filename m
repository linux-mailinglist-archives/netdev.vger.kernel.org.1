Return-Path: <netdev+bounces-122356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AB1960CB4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4575AB24F17
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE31B4C27;
	Tue, 27 Aug 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlYuibVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE621A0721
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766786; cv=none; b=S0UALZh47Cm06KlewIFcI/5ItawfS52oYMPBQQ/mXJ6g8aPtV9RUpfCRgV/4ISZdu5IKP7nNYPiwy0nu81DIn96R8v03l36g5qDQSsNdDwlV97RrvqQZOUFShfBK1RoK1yYkP8qki7Hm7sWLtO9FvL5zspe6bB+1n3mxitwuaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766786; c=relaxed/simple;
	bh=lH9dw/sYBKtuOf6KL6SslPmK0ayr3nnEB/HbCUjd1vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uO62524pBEYh+zNzlXzbXg+/dooM8A0xJFTH2ZB7GqvlrnaMdcgF6lwBFRtrSXiIO3RVmBMPy+LubDr/th6Ut+VvvAQDS8KClgX/XesT/DVmlJql2tk9JdnN27c2NJ0BCW+WcEohk2vANsLCOjjMAAhOMuEmS/gXpuwHsnphXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlYuibVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76730C61040;
	Tue, 27 Aug 2024 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724766785;
	bh=lH9dw/sYBKtuOf6KL6SslPmK0ayr3nnEB/HbCUjd1vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JlYuibVFJjPKDWt0EmoSwNavqi6y863SUxY/Vl5g+BmoqXxDTjL5n3nPkQF53NxeM
	 98yukBBSVcoQwYtBXl8cuAYZ6I3d1s4anUTG/t0hoZwWv/850G0nAFQcI2FdoPVkJu
	 7j6RJGjV4KMV9rKBoygaDzG3xtocO4GAzOljQMANsVnEhTX0+jejQqPqDqzuiNxKOr
	 y+CFR2XFj7uACE9JHt3Fvbi6QvMjFB1Rtg4IvzawYaALsQVAzQdV9tvqFh+IQ424Nl
	 80TUkuw8JgB8811n1CS4ii5+j/k4IJQyjurfnsdCh6jwyzfBlVLqFUVw6VronvfXTh
	 J38xKe3fDJnRg==
Date: Tue, 27 Aug 2024 06:53:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
Message-ID: <20240827065304.05ae49a9@kernel.org>
In-Reply-To: <1a364cc3-3b22-447d-bfa8-376de41d1f64@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<20240822174319.70dac4ff@kernel.org>
	<d9cfa04f-24dd-4064-80bf-cada8bdcf9cb@redhat.com>
	<20240826191413.1829b8b6@kernel.org>
	<1a364cc3-3b22-447d-bfa8-376de41d1f64@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 09:54:52 +0200 Paolo Abeni wrote:
> > For the case above we could technically identify the correct parent by
> > skipping the nodes which will be garbage collected later.   
> 
> I think that implementation would be quite non trivial/error prone, and 
> I think making the new root's parent explicit would be more clear from 
> user-space perspective.
> 
> What I have now in my local tree is a group() implementation the 
> inherits the newly created root's parent handle from the leaves, if all 
> of them have the same parent prior to the group() invocation. Otherwise 
> it requires the user to specify the root's parent handle. In any case, 
> the user-specified root's parent handle value overrides the 
> 'inherited'/guessed one.
> 
> It will cover the above and will not require an explicit parent in most 
> case. Would that be good enough?

Yes, that's great.

