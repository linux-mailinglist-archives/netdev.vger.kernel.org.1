Return-Path: <netdev+bounces-145339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7F9CF1D1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F2284560
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C531D5AD7;
	Fri, 15 Nov 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqVBq9mW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BB1D5ACE
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688699; cv=none; b=geF+4/hZKRmXEJusVXIUHjMRodrg8h/8n/v4S32GCclo3lzeNnu2GfmyGxnLHMC6JHM+Y6bG/+TVZbrSiZ9z3uhbvkLOlYtk7gfxMb1o12dPzevUUC7visiiKv3zDs0AgedwubhB1Y0XfkQMAEPk9HVbWrdats4hVcJPs/5zpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688699; c=relaxed/simple;
	bh=yNxv8H1kwezl25jeUX1WG/FL8L3nT2LWn0AE/j1qjkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZBMiju4rINaHGxdpsSiupVnBKK6a51uvonM/KShaY2v9C8zYSZnmT6qG510P//9Gsgt77IFJlX/fFMfKAEWfEmId7j8LatDcYFLgymbbrfgeqMLo6UzdBGPj3oBqlxu9YNkU/iBzorYAJSQaMqb+ixo1yHpwCeGymyxGUYKh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqVBq9mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B796EC4CED0;
	Fri, 15 Nov 2024 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688698;
	bh=yNxv8H1kwezl25jeUX1WG/FL8L3nT2LWn0AE/j1qjkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqVBq9mWRlJx78zJ1rRfpdZxelbY4hgbR4CvpxamoV0pZlTfla7O6YeuhUuCnA2t9
	 IfPjtmt+HcnAF+LNTFpqFwuuevgujmgBVt0hN6jfz/7qKSXqHeFi0AxB02bZk4MBvk
	 w2BT0NlqxgEtjrEkmyQAqFaj5socHZQ1Lr9ujTnrOjaJXziISKfC6fnaJ1V8DPWqdG
	 cUnPgXQuvl2pVcyVmbtyCmrSDBweoqeat1P28ysLP15cOV9ws/lrYm8Vo1whAKDk6v
	 Lkf33d9k7vD91+MAJXIevX/5Df3X9vyX6suG/UI3b6uw1djbW4At9b8M6UpEUgVwwf
	 WRwaSOdXDP6pw==
Date: Fri, 15 Nov 2024 08:38:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com,
 dsahern@kernel.org
Subject: Re: [PATCH net 1/2] netlink: fix false positive warning in extack
 during dumps
Message-ID: <20241115083816.3040dffe@kernel.org>
In-Reply-To: <20241115140007.GR1062410@kernel.org>
References: <20241115003150.733141-1-kuba@kernel.org>
	<20241115140007.GR1062410@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:00:07 +0000 Simon Horman wrote:
> > + * nlmsg_addr_in_payload - address points to a byte within the message payload
> > + * @nlh: netlink message header  
> 
> nit: something about @addr should go here.

Ah, thanks, I just sent a mass conversion, the missing Return
statements make the warnings hard to spot.

I'll also move the warning into the helper in v2, I hate 
the double negation in the caller.
-- 
pw-bot: cr

