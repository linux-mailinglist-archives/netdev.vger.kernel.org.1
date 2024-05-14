Return-Path: <netdev+bounces-96220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089B68C4AAC
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395021C20AB5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D023136A;
	Tue, 14 May 2024 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1BAXk5e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD5EC5;
	Tue, 14 May 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648037; cv=none; b=VgzyU0V+DSQTMJXaMZQZdfAakXX+tkP8YQd6djEMVfXSSpgIe2qh64EizLriwbpy88rQx6AOaoKHoo3KFg2h8rAm/8OUUq70EmrjaNCwK3WknJQye/yfXKSTyrj/lcpkYycOkNEVyC97VDwH6qMGU8DiwI2DP9TXq+mWhagf06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648037; c=relaxed/simple;
	bh=s1n/JR8kGKHYvyCvVgeNEF7EnS9ebyhfaRGZ8+kz990=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd0Q3HKwrwqereddhHq5roVBBbq5JFNXACMzF5Zbia6w3oCfNLhzP1E4OlELTT/5oa5WQvNjyytpAAoEosRKODRjBTSQkVo9EQKBY86oWvH03gR/Lvznb4O3FSksntmuSdth1PGJBwPdFjHx9AKi8QtwS68kRd7HMMevvUsmUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1BAXk5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966DAC113CC;
	Tue, 14 May 2024 00:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715648036;
	bh=s1n/JR8kGKHYvyCvVgeNEF7EnS9ebyhfaRGZ8+kz990=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s1BAXk5esInT1Hqsnj9I200E7+U+rkfROt0r2OTRz6faGUQQfNGUmH6L5I7lJao5C
	 AAcFwsFU2uaf/Hgjfv8w3LolrQSYdXZl5sEqVlmhPd4hlRHNL8bvpEurTMuC4Q+ylD
	 OCHFnUBCkpb9XOWyfat/oiqNcqF40vyGW7EiSNeCRbBM5vYVn+Bhp9NKw16gHK5LkP
	 PHM7pBPjM4cMW39L6Xq2wZeCOv85E4yM7rCzzhEOg0s7LBpEagnYpS0ASv9ThynjGW
	 Doei/OBzfDeUyDjMqPe6V6DcnyVZIugkkXESBlw4DGBNnnVdG4m29aGCiTF1s5KiNf
	 dLlhjr6T6VG2w==
Date: Mon, 13 May 2024 17:53:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Jan <zoo868e@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Jan
 <matt_jan@trendmicro.com>
Subject: Re: [PATCH] connector: Fix invalid conversion in cn_proc.h
Message-ID: <20240513175355.2b34918e@kernel.org>
In-Reply-To: <20240510154919.874-1-zoo868e@gmail.com>
References: <20240510154919.874-1-zoo868e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 23:49:19 +0800 Matt Jan wrote:
> From: Matt Jan <matt_jan@trendmicro.com>
> 
> The implicit conversion from unsigned int to enum
> proc_cn_event is invalid, so explicitly cast it
> for compilation in a C++ compiler.
> /usr/include/linux/cn_proc.h: In function 'proc_cn_event valid_event(proc_cn_event)':
> /usr/include/linux/cn_proc.h:72:17: error: invalid conversion from 'unsigned int' to 'proc_cn_event' [-fpermissive]
>    72 |         ev_type &= PROC_EVENT_ALL;
>       |                 ^
>       |                 |
>       |                 unsigned int
> 
> Signed-off-by: Matt Jan <zoo868e@gmail.com>

Why not. But please fix the checkpatch warning:

CHECK: No space is necessary after a cast
#36: FILE: include/uapi/linux/cn_proc.h:72:
+	return (enum proc_cn_event) (ev_type & PROC_EVENT_ALL);
-- 
pw-bot: cr

