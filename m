Return-Path: <netdev+bounces-176438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B277A6A526
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45B4189F5A3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42670221725;
	Thu, 20 Mar 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFOwjvTe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998422157F;
	Thu, 20 Mar 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470979; cv=none; b=HdgxM957OsTONZnyE0GF3ZcLkgclRks0Hy10UQw788iMlSAkvwIR7bH0EnruB0ilIQAIMgzIAS7HtDg3I39I6mIIB8j2/DKTsGJwHBFawWNJD+bvSW7C1xar8cAnDPrmJuGN35bkblPMoggyzOpIjpSdYapRIcUNStwxvEFTL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470979; c=relaxed/simple;
	bh=jCvarqBKWorrrpUzuPAMbwKq4dDSB6+ZMUEviakxeIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSl27BwbE544EqR0wDLDotf7iUI4WomaxC8JGq6IuaGh6iQxn1U5on5rFVhQSIfvPK68GRvCXq1w+h++h6gSBM2o37WHe3aafq0nd15XHrg31CgJoxQOOjA1plCRJjC5hYVS5Zfs29Q+Sa/toekTrEVvSsBYTjvmQRE/QWoji2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFOwjvTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFEFC4CEEA;
	Thu, 20 Mar 2025 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470978;
	bh=jCvarqBKWorrrpUzuPAMbwKq4dDSB6+ZMUEviakxeIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFOwjvTepPKm0/EgUOUo4CQAgKdBdzkXt+Pzutohh1tr0Ru9epzXWuuExYOOCeHIK
	 VdTIYSl7QYb0fle2eufzGR4PdlpIJZtGD+yX6D9yEai0LlyBII0cWChUZre9I5AFgT
	 49IYOib0Gb5MbEnfE61iRJKK/NLeSlgpcIsFgcP5phpqyFqT3LMX3/HjRb7UcMCHmT
	 yxkAR32JwyD6ZY4o56V12IW3poaqJhW/WbIT38J3DhilM0NG1PMRwMHinp5P3A30u7
	 0WkoslmXOfYOZmU34GYaiOhUFhSS3kvQckvNmO23cFEyf2iCZO6em0NLK9qyGZP2jk
	 bVPTRCOdvcDMw==
Date: Thu, 20 Mar 2025 11:42:53 +0000
From: Simon Horman <horms@kernel.org>
To: tang.dongxing@zte.com.cn
Cc: krzk@kernel.org, davem@davemloft.net, feng.wei8@zte.com.cn,
	shao.mingyin@zte.com.cn, xie.ludan@zte.com.cn, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yang.guang5@zte.com.cn,
	yang.yang29@zte.com.cn, ye.xingchen@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH] net: atm: use sysfs_emit_at() instead of scnprintf()
Message-ID: <20250320114253.GJ280585@kernel.org>
References: <e0204a28-7e3a-48f9-aea9-20b35294ada6@kernel.org>
 <20250317170902154iQh7_gBiO8KjCrFrhnAqn@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317170902154iQh7_gBiO8KjCrFrhnAqn@zte.com.cn>

On Mon, Mar 17, 2025 at 05:09:02PM +0800, tang.dongxing@zte.com.cn wrote:
> >On 17/03/2025 08:51, tang.dongxing@zte.com.cn wrote:> From: TangDongxing <tang.dongxing@zte.com.cn>
> >> 
> >> Follow the advice in Documentation/filesystems/sysfs.rst:
> >> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> >> the value to be returned to user space.
> >> 
> >> Signed-off-by: Tang Dongxing <tang.dongxing@zte.com.cn>Dear ZTE,
> >
> >Can you slow down? You sent a bunch of emails with similar issues which
> >means that dozen of maintainers will deal with the same issues
> >independently. This looks like another vivo or huawei style submission,
> >leading to bugs sneaked via flood of patches.
> >
> >First, fix the name used in the SoB (see submitting patches) to match
> >Latin transcription.
> >
> >Second, use proper SoB chain, see submitting patches.
> >
> >Third, really, really be sure that what you send is correct. You already
> >got quite responses, but you still keep sending patches.
> >
> >Fourth, respond to received feedback instead of flooding us with more of
> >this!
> 
> Dear Krzysztof,
> Thank you for your feedback. I apologize for my previous submissions.
> Regarding the issues you've pointed out:
> I will correct the name used in the SoB to ensure it matches the Latin transcription as required.
> I will double-check my work before sending any further updates.
> I appreciate your guidance and will follow the submission guidelines more carefully going forward. If you have any further advice or resources to help me improve my submissions, I would be grateful for your input.
> Best regards, 
> Tang Dongxing

Thanks Tang Dongxing,

Further to Krzystof's comments: please coordinate with your colleague
Xie Ludan who has also posted a patch in this area.

  https://lore.kernel.org/all/20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn/

It will be much easier for review if there is a single patch
that addresses these issues for ATM.

Also, please consider reading the following guidance on processes
for the networking subsystem of the Linux kernel. These are similar
but different to other subsystems.

  https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

