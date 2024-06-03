Return-Path: <netdev+bounces-100402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7D8FA683
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3924E28216F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C3839FF;
	Mon,  3 Jun 2024 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWJ6TxBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA11877
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457373; cv=none; b=C8qXc/pB4oXIUI/+oMcls2XQASj61RTEkiXhmD7QxeCFDafbZJhW+CE+BaBUvYT93ljVk8mT8TCw6CDf5WMkv5z8HM1wx8SWnTTlqwWS/kb+bwi+4l/3MrwGUQfLDtLlhjp4TUABZhrIOg641MZaZPvS4waZgr68ibJREOrha4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457373; c=relaxed/simple;
	bh=QALVwpgYH/GX9Nkl+B+f4mWrrLzkTtNDZdbE+8qt2cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcknXkhisKQDAps29zeIkYUK4tp2tcsOHa8aPSl5/AZE+UXYVEVCipjWw+EhhFK2Q43Fdn2cQ39oyf1Dlf0esM7yDyQwSjDEI3QoHDxM71BILXhwx444NU35SvCUJRkZiwFBXpzjsZDLB71uMMvmYjXNTokubvaROpwSO/ZOc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWJ6TxBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E48FC2BD10;
	Mon,  3 Jun 2024 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717457373;
	bh=QALVwpgYH/GX9Nkl+B+f4mWrrLzkTtNDZdbE+8qt2cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XWJ6TxBaeaspZS1DXkEqVNAxIpVyqrSwkdJdHjAzxCrGyFep2dyRbZLrYlYA8wI2d
	 WzziySPwvYe/s+OkB1glgKxJ0rpBY9GoqcX2eZtKfu80+W8shR6A6rKVzXoNWmBd44
	 x5osZG8HT10l+T+0SoHbApOb0ouP1xBDbJ/vd5tvkxete2yWGPcAR+7MTn8x/yFSAG
	 g74Miv9GYU2BO+YmFFUQ86VJUUiYEu1e8gAQyTo8XF9SvrY0ch5vguakge/63OmCcA
	 BzbB/EY8RbXWd0X+UoFQYI2l9kmLazHsTawbX9MjKhFyKoj/qXWP2UlLPRxslxe1y1
	 SkOxlCQx1bFAw==
Date: Mon, 3 Jun 2024 16:29:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240603162931.3ab01750@kernel.org>
In-Reply-To: <c5dcf167aad610c6c623c5958bb252647773fddd.camel@redhat.com>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	<20240528101845.414cff22@kernel.org>
	<16d7b761c3c1b4c4bd327d4486d958682a5f33dd.camel@redhat.com>
	<20240531090057.02fb8616@kernel.org>
	<c5dcf167aad610c6c623c5958bb252647773fddd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Jun 2024 13:11:39 +0200 Paolo Abeni wrote:
> > ... and also what confused me here.
> > 
> > How are you going to do 2 layers of grouping with arbitrary shaping?
> > We need arbitrary inner nodes. Unless I'm missing a trick.  
> 
> I guess this part really needs some talk. I also don't understand your
> doubt above.

Each layer of shaping corresponds to some level of privilege or control.
Saying that we only need one layer is like saying that we only need one
layer of cgroups.

For example - application may want to WRR/shape between two sets of
queues (e.g. data and control) and then we may wrap that application 
up in a container, and WRR/shape multiple containers together.

