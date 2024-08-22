Return-Path: <netdev+bounces-121077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67795B911
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD501C20CC9
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7A1CC170;
	Thu, 22 Aug 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO7Xqsqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509F1CC151;
	Thu, 22 Aug 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338285; cv=none; b=Dof4wgXrLuJJ8NAmB91lBL5qn/pDwAQEQfjsAX/2dat9hkB8UoKwlNGbfANpncJEhZDJ/oD9N7QXD/UdXmrbvLZAj0vn1z4M0lMie3/a5GOwkAArll4Bg/YeQ8RBsW31drGA802gMbnDzsFAcBnrI2/FzZzrACzReK99oVkg3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338285; c=relaxed/simple;
	bh=V/moUsRuy3JJd+W77sFUhI4M89+kJ/jiiPJtireX0+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2nxH72+Gf0LyYR+pscjf+KTfisRzCUSmf78RMZmjfb/YP6E0BBr3o0wauRIRB6N0hWTXGF+SU9B082bNvWTzEEji5qDJqyrtBk72ewgMwOYd4l8u4mIsLDpaMnYsQVFoVRgW50M3HIhoJ7/j7sCtfOAxuxFTRJqNX9JPs1DXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO7Xqsqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4324BC32782;
	Thu, 22 Aug 2024 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724338284;
	bh=V/moUsRuy3JJd+W77sFUhI4M89+kJ/jiiPJtireX0+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VO7Xqsqts9vFHvENWLbtOzNWf3bcQGtgCoyan4QxHNfB1ekHLlZWbVXKpHsowj6s8
	 6t/3bUW+s8MzVK52lfv1panRM8NZ7R5DUZ25xytbqUPpg5dtK7SBwaGRSz+WEfSOPs
	 gbvLAfABlKuUneUBsTKVOwhEIaNPtUrBsdA3GqSB9JSD3VYE6p86ofbJB1Bu/Qb/yr
	 r85DIej3VravXi1we62SFnPsl7u+VXwfofKjwr5Ueje7vIx91Reho55Qape0SQm6KS
	 XmseuHaOjJQYbAvMJfUxRZSNXZS3wwvXFGcH1Wx1c0N1e38goBHEnLrmCJE3E/hirc
	 VtI/lXbPLVyzA==
Date: Thu, 22 Aug 2024 07:51:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Message-ID: <20240822075123.55da5a5a@kernel.org>
In-Reply-To: <2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
	<20240821171817.3b935a9d@kernel.org>
	<2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 10:07:25 +0800 Jinjie Ruan wrote:
> On 2024/8/22 8:18, Jakub Kicinski wrote:
> > On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:  
> >> Use scoped for_each_available_child_of_node_scoped() when iterating over
> >> device nodes to make code a bit simpler.  
> > 
> > Could you add more info here that confirms this works with gotos?
> > I don't recall the details but I thought sometimes the scoped
> > constructs don't do well with gotos. I checked 5 random uses
> > of this loop and 4 of them didn't have gotos.  
> 
> Hi, Jakub
> 
> From what I understand, for_each_available_child_of_node_scoped() is not
> related to gotos, it only let the iterating child node self-declared and
> automatic release, so the of_node_put(iterating_child_node) can be removed.

Could you either test it or disasm the code to double check, please?

