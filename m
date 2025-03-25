Return-Path: <netdev+bounces-177487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B1A70509
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC824189CF09
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66A25A351;
	Tue, 25 Mar 2025 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss/sdlnT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123513D8A0;
	Tue, 25 Mar 2025 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916473; cv=none; b=HqwBaeTq3s7NJaw+aSgJCVDqRuN5TO84uTvUCGhHb7EpFFT6X8vQyigqo4PrEvZbCp4J9Q3IiyOi19zA7lrnWbGqDeNSJGsvQhWF0EI9co9F07GizTx9Nx6yVpeZikJrGPkipypMInC/V/FLxhLcoRa4THLXEqX3rXuCV9ZMCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916473; c=relaxed/simple;
	bh=3vBzB0bC4Yz0py1GjLKu6FQytam9E2Tto+wWFuf5NgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7VxjoO5fl8yZJjvWj0XQxj6QEPCWrjjQm+L0EpqdS+bsPoJINEYPU7ynDQ6rCDeFSgiLm46/Oz3EjoTBxtSTxMNzfr58TbUYQCRhWF4AA6sUMAesaMGRnvxYKIBYUEXXl0sHEjK1weBTVNckNGhUuPGwXDHLXQqJ2o4vgi3y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss/sdlnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4413DC4CEE4;
	Tue, 25 Mar 2025 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916473;
	bh=3vBzB0bC4Yz0py1GjLKu6FQytam9E2Tto+wWFuf5NgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss/sdlnTE6NzWizQPrks2yd7B7N8OaAN41OuF4vjLlBPs3PJA/grti5Yhnlj85vf0
	 Atjmv/Rlz18L5wgzEmVg1itZ4Ekqajb6hwM+A1G03AI13FimkbqwtMde9PCVm5ZxM4
	 ZTHvrEAw/jGus5/yXkmdEHOjlwsnYgF5Sso3VtpXQWfcPpWfY8owCfX7hnW0w7GK1F
	 2KGwGpAvH4Q2p4GeG8Z0vcHd2QufIsqprjOUSsL74NqXTYN+QQl7pSyPbC4GABsjVd
	 hUx6Mpzg+AYaXSTeP7XaJRfsBduhMcnAQyEk8OW2RZ0SfvpvxFGQO7tUZJPT5tH7fd
	 ZGUl/+2beVV9w==
Date: Tue, 25 Mar 2025 15:27:47 +0000
From: Simon Horman <horms@kernel.org>
To: tang.dongxing@zte.com.cn
Cc: krzk@kernel.org, davem@davemloft.net, feng.wei8@zte.com.cn,
	shao.mingyin@zte.com.cn, xie.ludan@zte.com.cn, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yang.guang5@zte.com.cn,
	yang.yang29@zte.com.cn, ye.xingchen@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH] net: atm: use sysfs_emit_at() instead of scnprintf()
Message-ID: <20250325152747.GU892515@horms.kernel.org>
References: <20250320114253.GJ280585@kernel.org>
 <20250321104557426O89NLhm9SSuAOJwRDq75V@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321104557426O89NLhm9SSuAOJwRDq75V@zte.com.cn>

On Fri, Mar 21, 2025 at 10:45:57AM +0800, tang.dongxing@zte.com.cn wrote:
> >On Mon, Mar 17, 2025 at 05:09:02PM +0800, tang.dongxing@zte.com.cn wrote:
> >> >On 17/03/2025 08:51, tang.dongxing@zte.com.cn wrote:> From: TangDongxing <tang.dongxing@zte.com.cn>
> >> >> 
> >> >> Follow the advice in Documentation/filesystems/sysfs.rst:
> >> >> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> >> >> the value to be returned to user space.
> >> >> 
> >> >> Signed-off-by: Tang Dongxing <tang.dongxing@zte.com.cn>Dear ZTE,
> >> >
> >> >Can you slow down? You sent a bunch of emails with similar issues which
> >> >means that dozen of maintainers will deal with the same issues
> >> >independently. This looks like another vivo or huawei style submission,
> >> >leading to bugs sneaked via flood of patches.
> >> >
> >> >First, fix the name used in the SoB (see submitting patches) to match
> >> >Latin transcription.
> >> >
> >> >Second, use proper SoB chain, see submitting patches.
> >> >
> >> >Third, really, really be sure that what you send is correct. You already
> >> >got quite responses, but you still keep sending patches.
> >> >
> >> >Fourth, respond to received feedback instead of flooding us with more of
> >> >this!
> >> 
> >> Dear Krzysztof,
> >> Thank you for your feedback. I apologize for my previous submissions.
> >> Regarding the issues you've pointed out:
> >> I will correct the name used in the SoB to ensure it matches the Latin transcription as required.
> >> I will double-check my work before sending any further updates.
> >> I appreciate your guidance and will follow the submission guidelines more carefully going forward. If you have any further advice or resources to help me improve my submissions, I would be grateful for your input.
> >> Best regards, 
> >> Tang Dongxing
> >
> >Thanks Tang Dongxing,
> >
> >Further to Krzystof's comments: please coordinate with your colleague
> >Xie Ludan who has also posted a patch in this area.
> >
> >  https://lore.kernel.org/all/20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn/
> >
> >It will be much easier for review if there is a single patch
> >that addresses these issues for ATM.
> >
> >Also, please consider reading the following guidance on processes
> >for the networking subsystem of the Linux kernel. These are similar
> >but different to other subsystems.
> >
> >  https://docs.kernel.org/process/maintainer-netdev.html
> 
> Dear SimonHroman,
> 
> Thank you for your guidance. I have contacted Xie Ludan,
> we recommend that the community review be based on the https://lore.kernel.org/all/20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn/

Thanks, understood.

> I will carefully read the the networking subsystem guidance before sending any further updates.

Likewise, thanks.



