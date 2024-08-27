Return-Path: <netdev+bounces-122396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6F960F75
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D208B22ACD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763B1C8FD4;
	Tue, 27 Aug 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV4YB0g5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB501BFE04;
	Tue, 27 Aug 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770697; cv=none; b=hUuF20grtNUCaR6U1Q9u1kcuN3fbb5Mgweyz1KoGr3gtU+N7qgM9Vhn1cxvDMCYmwrbAf2YK+WB2z8KRgN0m5gSIaSl5icW2fIVEITEqm8+VEZDO6BMIcEBB+udhWjl0ZRxmjEgkxJDkNrzun8v766p+MI/XXcq8mv8kPFUF0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770697; c=relaxed/simple;
	bh=EmLXtVB8nXHw9ebOXwG1E4uZL0HbpT3+D1n4tmiJCAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQtPUPmnfQS40QzL1rOrgztOmwtf/f6NRm5fJofoIKdjeumL7scMRSr/YrXpkrHy+IRUfroNfLS+pb4ZT/OdTHnWIojnQEN8HACWZT90JKysjODy+O/D4JTbXJdtwdLKR3bVal2HNMpVfMJsK3B7MB0Er3IMadmdFXC0ooGkHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV4YB0g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0C2C61044;
	Tue, 27 Aug 2024 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770696;
	bh=EmLXtVB8nXHw9ebOXwG1E4uZL0HbpT3+D1n4tmiJCAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV4YB0g5lgU/EdDTHqrT5PMeTgBdt+ZkkMgjgWSpQYljWwBtQLADSaylK/KuPQymH
	 AbIj9fkmhojyVs+mdeTtPRR1KE20xpiT5uz3VBfr2m03h6VRgIy3kEvXgc0xnC75ER
	 QKey1Zk7cA5Mdbxv+BkXzE5cg6le3dXKc73TYYfHFQ33C3K4azndXL9G9wkuerQbnb
	 S6WJ9vf3ZIGHpb3dSLW5LMNzjjui/Wf/d71tK5D4DbuKuBeIDJW5NxUfhkVYl5lu+r
	 Yr3hiWPE13HvHieP0BTsJ9lh/q+TgUTiaoYJ6D5HeOfNDTyRN8dr0kfjiOTuYNKlQ8
	 B7G3GxPF5XPpQ==
Date: Tue, 27 Aug 2024 15:58:12 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Message-ID: <20240827145812.GL1368797@kernel.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
 <dc803f66-5f85-49d3-81e3-f56a452a71bf@web.de>
 <20240827144010.GD1368797@kernel.org>
 <6b483487-1806-424c-8237-07c0de481790@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b483487-1806-424c-8237-07c0de481790@linaro.org>

On Tue, Aug 27, 2024 at 04:41:50PM +0200, Krzysztof Kozlowski wrote:
> On 27/08/2024 16:40, Simon Horman wrote:
> > On Sun, Aug 25, 2024 at 09:21:31PM +0200, Markus Elfring wrote:
> >>> Driver is leaking OF node reference from
> >>> of_parse_phandle_with_fixed_args() in probe().
> >>
> >> * Is there a need to improve such a change description another bit?
> >>
> >>   + Imperative mood
> >>
> >>   * Tags like “Fixes” and “Cc”
> > 
> > I think it would be helpful if these were either explicitly targeted for
> > net-next without Fixes tags (the assumed state of affairs as-is).
> > 
> > 	Subject: [Patch x/n net-next] ...
> > 
> > Or targeted at net, with Fixes tags
> > 
> > 	Subject: [Patch x/n net] ...
> > 
> > I guess that in theory these are fixes, as resource leaks could occur.
> > But perhaps that is more theory that practice. I am unsure.
> 
> I'll resend with net-next.

Thanks, much appreciated.

