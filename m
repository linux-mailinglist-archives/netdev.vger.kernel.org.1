Return-Path: <netdev+bounces-115870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FC94825F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C4281AE2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18516B386;
	Mon,  5 Aug 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsJXMnqk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBF15D5D9
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886617; cv=none; b=ojPq6kizjWk3O0F1IeXlqu1/WPuzGvK+sOj+mlnr8HqbbitafMxWPwroT1BF19zAmAwKyIwgRaBz6vkbYEkkgdRvricJAy7b0MhAlW0CmNlRpeXuapigxv6eEWHNrbkAJUPfyFAWBTZV0vQ0rA+36lcHk/E9aw0vwzWvxNAddi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886617; c=relaxed/simple;
	bh=pIcM5w2TFsSg88YIZUckwkTNlIUnea7FVhbhsN0NvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAQyCvYos98IdjYv/eV6leMyw4JS7wJlyxxEa1rP8VRIDczHLeiXduDfNbu6eJplp8TqllVrcAIQSqNwaIhTjaeTugsVL3iFNO6adNzROBqCv2zjS+fje+EMLNei5/Xmjz3v6n3Bc7XIofPZnjYFRs6wsp9pq+w1vwxhnoJbaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsJXMnqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6239FC32782;
	Mon,  5 Aug 2024 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722886616;
	bh=pIcM5w2TFsSg88YIZUckwkTNlIUnea7FVhbhsN0NvRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bsJXMnqk1gDMgagmFYE4110Ixi9pLoh2Xi+57ZML8MqONLAbhu4pUR7fPffG03IOX
	 PleBesrHRssLQpKJbyv/MVT4VzfM2CrZh7cL9JsL7yHydYApugLFD8JykA8kqDAaav
	 BW3jPxA20cpoGwUwv8GC99N9V7qNvihQyK5M6Z7OWvMKF2qFqMqKnj0elI/AdnJJlv
	 C2xGMcTlPvJg+SN+QQqPxbrpdUilg211MTtX/1TxhFgiwo8GCGQjJmqqOvFEkKPpuv
	 E1mIL8+/qb2eaBkKs5WGR81VtbD/vDvIKVVJ7/2ciHxICfHu8yQQPE5tKSQ+3EdVYj
	 B1aZiVz4kwwfA==
Date: Mon, 5 Aug 2024 12:36:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240805123655.50588fa7@kernel.org>
In-Reply-To: <20240805142253.GG2636630@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
	<75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
	<29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
	<20240731185511.672d15ae@kernel.org>
	<20240805142253.GG2636630@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 15:22:53 +0100 Simon Horman wrote:
> On Wed, Jul 31, 2024 at 06:55:11PM -0700, Jakub Kicinski wrote:
> > On Wed, 31 Jul 2024 09:52:38 +0200 Paolo Abeni wrote:  
> > > FTR, it looks like the CI build went wild around this patch, but the 
> > > failures look unrelated to the actual changes here. i.e.:
> > > 
> > > https://netdev.bots.linux.dev/static/nipa/875223/13747883/build_clang/stderr  
> > 
> > Could you dig deeper?
> > 
> > The scripts are doing incremental builds, and changes to Kconfig
> > confuse them. You should be able to run the build script as a normal
> > bash script, directly, it only needs a small handful of exported
> > env variables.
> > 
> > I have been trying to massage this for a while, my last change is:
> > https://github.com/linux-netdev/nipa/commit/5bcb890cbfecd3c1727cec2f026360646a4afc62
> >   
> 
> Thanks Jakub,
> 
> I am looking into this.
> So far I believe it relate to a Kconfig change activating new code.
> But reproducing the problem is proving a little tricky.

Have you tried twiddling / exporting FIRST_IN_SERIES ?

See here for the 4 possible exports the test will look at:

https://github.com/linux-netdev/nipa/blob/6112db7d472660450c69457c98ab37b431063301/core/test.py#L124

