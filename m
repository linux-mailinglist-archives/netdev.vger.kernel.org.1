Return-Path: <netdev+bounces-65709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ECE83B6D1
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320961F22408
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99BA3D;
	Thu, 25 Jan 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw/R03sD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB3136F
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147214; cv=none; b=G8eaFYHmCD2/sVqI4QbgNWClYQTEjzMjm5fy1lRFStQA922yNcMMRuiXYXeWBOvYtLHLzAIjVMyzQbc2u+RmjZ3QcLvQprwwLg9vEG3v6TJsvVJSiEIqPP7ZJpiwffv5fHEN+HwtXAwZH2p1CYoG3TOIP3hmNYdi4H04ySDobSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147214; c=relaxed/simple;
	bh=DxNHxjQDkc1QD619p/JjXngvCug49O1ClJEFlQM5+t0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KD9yAG/7xdKzYHbLZZfJQsHaLWDDX50DzlhtVk6cAzV67uT2VfmuHlSeLN/HU2Tx7qNNG+uagEqEWyN70Q+Wm99uznUxiTz006nmtrGUi36omYuB8rVSk2cF9/vX+D3rO/2vdXXpGHVdCevfWP0ZDyGQdXCWZR+icBW2OJ6Q/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw/R03sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA2C433F1;
	Thu, 25 Jan 2024 01:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706147213;
	bh=DxNHxjQDkc1QD619p/JjXngvCug49O1ClJEFlQM5+t0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cw/R03sDT3a4KP4V1vkgxobrpvyAZq/yPRCufPOlupLytQH0sxBh9vQSxoRbYrI/5
	 LuT8rCLPvRc0nUBp0yGH4rqfrbrUlAH55dSiC/DU+jjDDHdM+0BS2Q7Ynu8ZHfK940
	 F0SU+wpOFb6+kjSQesG8/LQnd0fr2NzuGHYase9EkBjtoIoY+2iuX+8Zf70VMYMkdo
	 jyAGsOAeT0G5VEzTJUbZb/gScZHFlnwwrw53FL5P5rWCgG1TDhYeU3Z3tRskhwXuOf
	 VsVscJrP12wQRkvkudLZGgs6dvIJCzerM/8oR1mB/fpn6FfyzM0fQC3xGW29625QZc
	 e0a5oBgcGuJyw==
Date: Wed, 24 Jan 2024 17:46:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: heng guo <heng.guo@windriver.com>
Cc: David Ahern <dsahern@gmail.com>, Vitezslav Samel <vitezslav@samel.cz>,
 netdev@vger.kernel.org
Subject: Re: [6.6.x REGRESSION][BISECTED] dev_snmp6: broken Ip6OutOctets
 accounting for forwarded IPv6 packets
Message-ID: <20240124174652.670af8d9@kernel.org>
In-Reply-To: <493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
	<20240124123006.26bad16c@kernel.org>
	<61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
	<493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 08:37:11 +0800 heng guo wrote:
> >> Heng Guo, David, any thoughts on this? Revert?  
> > Revert is best; Heng Guo can revisit the math and try again.
> >
> > The patch in question basically negated IPSTATS_MIB_OUTOCTETS; I see it
> > shown in proc but never bumped in the datapath.  
> [HG]: Yes please revert it. I verified the patch on ipv4, seems I should 
> not touch the codes to ipv6. Sorry for it.

Would you mind sending a patch with a revert, explaining the situation,
the right Fixes tag and a link to Vitezslav's report?

