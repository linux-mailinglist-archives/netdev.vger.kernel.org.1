Return-Path: <netdev+bounces-115907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF77494851C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615C01F2299F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A716C426;
	Mon,  5 Aug 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyyY+uV+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751414A099
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895174; cv=none; b=pug9KutnuV4Ijdj/IpQ5uKMsLVLwIz+xA9sROUW7MAtq06oaw3OstE4sswfVPrt/xnhXZnWjaESm3d3rU0upE7DBMyFrmxwDV7Kt33zM7dDrhVi9zTKsAvZiKJNlX6U6YUgxdu7ohT6vUl0rHb/XTTr6s+hEUgvRIceBYuo+1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895174; c=relaxed/simple;
	bh=E75jJmtub9aZzW3AkNv6E+QnGNyGj1HrPolYSv0GJ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh+7xY9HdX3Y5uKBO26PSsKmWhnTtGAITfWZsEaRvVKM3KD8RBtt0r+DU+Z+cvX7ppOxbMfKKmpwtWkYSjKH9PttuXIUdcvH300lJKG3T5LmHKUtRtzvlRdrKZOjxRoGDrdz3VKtN+cRbDqb1TyTPa7mHg4XsLm0le0DjXFFQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyyY+uV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F26C32782;
	Mon,  5 Aug 2024 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722895174;
	bh=E75jJmtub9aZzW3AkNv6E+QnGNyGj1HrPolYSv0GJ0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uyyY+uV+ZR+3x+y/DRwE5qRW0RmNnwqC5gWEueBuxBe+ZIbKhNt3mKne0RHbx7lAx
	 ZyCxzuyJ3sEKuOf8Ymcksx5AGlq45iIBVyg8KrIjGmNRbHqqUAcgx8AGIUL1gF1ezG
	 4M7nKD5yyIC6ICXt1+Nmjc4o51wVwcRYrrwfOQG24U6AHD92qnxL7YbkuCC2bkB+om
	 bHKJm4Tp3KAbC8LOfWJHO13j8LrlBu8rBLusi0BiallU+BD8D/KtlUbIxO+GXUN95O
	 qTjRuaFLFvPexJlklNqo9SFRlMK/baWTCMdnQqaEUg0fooXBV15LnO8OufgD1YB+RV
	 wcDgSJUf3WlWw==
Date: Mon, 5 Aug 2024 14:59:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
Message-ID: <20240805145933.3ac6ae7a@kernel.org>
In-Reply-To: <Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-10-kuba@kernel.org>
	<Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Aug 2024 19:11:28 +0100 Joe Damato wrote:
> > +struct rss_nl_dump_ctx {
> > +	unsigned long		ifindex;
> > +	unsigned long		ctx_idx;
> > +
> > +	unsigned int		one_ifindex;  
> 
> My apologies: I'm probably just not familiar enough with the code,
> but I'm having a hard time understanding what the purpose of
> one_ifindex is.
> 
> I read both ethnl_rss_dump_start and ethnl_rss_dumpit, but I'm still
> not following what this is used for; it'll probably be obvious in
> retrospect once you explain it, but I suppose my feedback is that a
> comment or something would be really helpful :)

Better name would probably help, but can't think of any.

User can (optionally) pass an ifindex/ifname to the dump, to dump
contexts only for the specified ifindex. If they do we "preset"
the ifindex and one_ifindex:

+	if (req_info.dev) {
+		ctx->one_ifindex = req_info.dev->ifindex;
+		ctx->ifindex = ctx->one_ifindex;
+		ethnl_parse_header_dev_put(&req_info);
+		req_info.dev = NULL;
+	}

and then the iteration is stopped after first full pass:

+	rtnl_lock();
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		if (ctx->one_ifindex && ctx->one_ifindex != ctx->ifindex)
+			break;

Unfortunately we don't have any best practice for handling filtering 
in dumps. I find this cleaner than approaches I previously tried, but
we'll see if it stands the test of time.

I'll add the following comment:

	/* User wants to dump contexts for one ifindex only */

