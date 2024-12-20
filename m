Return-Path: <netdev+bounces-153749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540639F98DC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D017A0369
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61E2206A0;
	Fri, 20 Dec 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpwqIA1D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D0220699
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716327; cv=none; b=c8RLcJI6+VisM3DNUyBKRL8hnrs1C2GLiaZztLbAdk3jI1VzL6olxmCnRtmwaH/GvLSMtPXcjSAnEfzbc8NOR28z0dZ+ZuJE7rHNvEuyFfDC0gVr50r0NYnxD2+aeXX/Myy33qA0LuV9KwSjq3OKwM681WdewA7n7S+1gLXh7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716327; c=relaxed/simple;
	bh=LirUPkGPm5KDTiN4ybL489hKfDMnI0mD4meLAHv1tHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxyfuJR0b/C2DJkulRrfD9QI3/crQ0iKKsENOv9Js4CQkkflXpMMECpauk38S+Qw9DxxlJ6DILaVsQksHw4zsUXBwIJvLceHMM2Dk78Oj+Sz+SoBzGODlwAa3/UEhuZ/OQ5TapYShKDnmKkwIg/PIBQycIVrt23C26vPoSTH5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpwqIA1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6DEC4CED3;
	Fri, 20 Dec 2024 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734716327;
	bh=LirUPkGPm5KDTiN4ybL489hKfDMnI0mD4meLAHv1tHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpwqIA1DolVdnh+fwDLJdS1AbQcAZGCtt9iKwKKD+IbjyHQdPYqBmvULlSWS1BfeU
	 aFbaBe5ZAr9WDEYod62k14he2+BKmnWo8SiMaz1gzst0KwyZMInDV7NB8Y36y7QJcj
	 f69lRdyyRoiMiHhCj9CKWKOOy8VlEsiOO8pBgAMlDkq7ck0LkZYf3pOHXD6bbrMlvJ
	 8KYa9K+Ge6pId/V+twNgjvnyTLNAJ7Plx4yOlvWtcXslrwYWEuW8hmDXBaue+s059r
	 1D5CeUJjlrrqUBjMPUV5Zzp/rwNz5cg2QFIAttXDb/nO49wC4VHeAMn50SMeLEuuBN
	 lNRjZ5pihYl/Q==
Date: Fri, 20 Dec 2024 09:38:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] eth: fbnic: reorder ethtool code
Message-ID: <20241220093846.3dcec7e3@kernel.org>
In-Reply-To: <Z2WE3u2xrBw8XYxr@lzaremba-mobl.ger.corp.intel.com>
References: <20241220025241.1522781-1-kuba@kernel.org>
	<20241220025241.1522781-2-kuba@kernel.org>
	<Z2WE3u2xrBw8XYxr@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 15:53:18 +0100 Larysa Zaremba wrote:
> I thought type and name on separate lines are not desirable, it could be moved 
> to a single line in this commit. Assuming such adjustment,

I find this style more readable, TBH. I tend to break the line after
return type if the function declaration doesn't fit on a line and the
type is longer than 3 chars (IOW int/u32/u8 are exceptions).

Functions which end up looking like:

static struct some_type_struct *some_function_name_here(struct another *ptr,
                                                        int argument);

are really ugly. And break if > 3 chars is a simple rule to follow.

You will find that most of fbnic does not follow this style, because
I didn't write most of it. But most of the nfp driver does.

I think I learned the breaking after return type from Felix Fietkau.
Not that he specified the 3 character thing as pedantically as I do.

> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Also, this would be a little bit out of scope for this commit, but seeing 
> relatively new code that does not use `for (int i = 0,...)` is surprising.

I think you at Intel try to adopt the novelties much more than the rest of us.
Let us old timers be, please.

