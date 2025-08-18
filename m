Return-Path: <netdev+bounces-214678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F21B2AD9D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AB144E10FD
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590C33A017;
	Mon, 18 Aug 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ms83fx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E483376B8
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532811; cv=none; b=G3175wB9g4vNVi3IGkAOnWO6jNn2HkBuhjAgmzXm7feehlH74papRJyOeknAL3zLdrprCdEPkUeXg2BcOkPGnNb95nf6lKp9LGaiKgVmlgk2C3ntCV53fZ8UL7BV56HzZlbrRHBW2FsiZD4vdg+znye/JDVqOOly4Zjr7T9/Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532811; c=relaxed/simple;
	bh=FSlCD5RaSvZxFuFw4a32tctP7mGD+tB6sYhMCTGAHFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVo19uMS4nrissVLbaMDxZDdmqBMJ7uYFwsu5BuUDUMn4RM/IjPt76UH8eyjGzomfp437oS2YZTMmNDNDlSJRjkZUtjerA/y5Wan/1GapnGmlybgiNoSw3yIlfqrb/tTuFAUvazJf2CdR43PTW5IgpDqkkfn0j+gHPB6L00C4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ms83fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0469C4CEEB;
	Mon, 18 Aug 2025 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532811;
	bh=FSlCD5RaSvZxFuFw4a32tctP7mGD+tB6sYhMCTGAHFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/ms83fxLiVXGve5P2xWEfjAvzD4MxGOvtFgt3E3lF7WDN6Sh0psKyWJ/IUpbixph
	 W8MOwLj8D36fGll1IP+06EvlKeXnXE8oO/BaR8Yfyg3YekId39kdFtksVoCE8nU5mG
	 Lc94BLeJi5gLM1jgUGi5cp/CouMX6TsW+pixr7lvAvQEkGSSqlJ3CwKPRgo8LZfXh/
	 +JAkvN/ByO2duLGpiBdVj81Ih3HoQx7XXSQR1LXSPtg8pL7KoR81PZF5+wWLc46Xa9
	 SoC+O3MhbjPGewXFFsI4hiyih+q9WmRt3PgYLikZP4UHtYe+EFqi8TXxgGMRsIlnAP
	 7FVBdkcCLOdwA==
Date: Mon, 18 Aug 2025 09:00:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, netdev@vger.kernel.org,
 haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@microsoft.com, dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250818090010.1201f52a@kernel.org>
In-Reply-To: <31e038a1-5a17-4c13-bf37-d07cbccd7056@gmail.com>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
	<20250816155510.03a99223@hermes.local>
	<20250818083612.68a3c137@kernel.org>
	<31e038a1-5a17-4c13-bf37-d07cbccd7056@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 09:41:29 -0600 David Ahern wrote:
> On 8/18/25 9:36 AM, Jakub Kicinski wrote:
> > Somewhat related -- what's your take on integrating / vendoring in YNL?  
> 
> I feel like this has been brought up a few times.
> 
> Is there a specific proposal or any patches to review?

Not AFAIK. Erni is being asked to rethink his approach here, and 
if we're going with a new command perhaps YNL should be on the table.

I'd be very interested to get a final ruling on YNL integration 
into iproute2 -- given its inability to work as a shared object /
library it's not unreasonable for the answer to be "no". 

The page pool sample in the kernel sources is very useful, I find
myself copying to various systems during debug. If there's no clear
path to YNL integration with iproute2 it's time for that sample to
be come a real CLI tool.

