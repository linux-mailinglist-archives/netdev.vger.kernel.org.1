Return-Path: <netdev+bounces-116208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4B949790
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B5A284025
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B07580A;
	Tue,  6 Aug 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StgNTP1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD96F2E6
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968915; cv=none; b=TUuZz+YrbamRxEx3SsflbTokar0CsAS04YcVYP+RW/NP+QlYe3715UXc8jKbfDJ2Qtj1zSRSe4riDhO/MofDGHHrh43OHjF2z7yZy1HTvn+ZB0P5eNN2xIraZACDdcg9p66uSnE8xEfyBSYKmwit6iUf67r3b7TfSF0/WLoa0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968915; c=relaxed/simple;
	bh=f0WDRopsWj2uC2yh0QGpC1n22vlXbgyiCXLo+BUCAQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e98nO+VHKhA5sPP1pZEVAM6S56dWrCVzcr+sV+C0HeK72cpD7yO+vL4STuAmYILoebYb+9XNRcW/uDE+w5ZKIt5ol3nDmvcSltUp5cZmiNXmg7/CR47BIEpUKB0G6JmjH53K1mYlz4Xu+zGEvhAjrO8aJG9SdL3IXNpVAAtv9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StgNTP1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0443C32786;
	Tue,  6 Aug 2024 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722968915;
	bh=f0WDRopsWj2uC2yh0QGpC1n22vlXbgyiCXLo+BUCAQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=StgNTP1mQBl5UATdMsEhNUX3DPfcYmMMtD4iU/KbyXSyRQ6ChYScdsyV6woaaxoPX
	 t/eLX7xF0FEDkpEHkT4krfFTM0QUSP20hqd3wZt8A9nJW42nB8PTVWjPHAj/raGivL
	 +tXtI6RzfcNyglIkinLDzmxgzA313tX+XmUrj3MCZUyBNlPKGjVjZSZSB8ML0Po2a+
	 QqOE88lXsgDdibdMpgeNlGB2B0o2s84OYaXg1229YepAkxlVJWtxMET6nvMhLv+LkU
	 mQR03cj4bJe3HtXuKuCu+El78vwkFcQhoBY8qKOisiX515LWCk6ZLoiBp9GJWO8WYH
	 JY212War4n5wg==
Date: Tue, 6 Aug 2024 11:28:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 12/12] selftests: drv-net: rss_ctx: test
 dumping RSS contexts
Message-ID: <20240806112833.6a9d7826@kernel.org>
In-Reply-To: <915e5b8f-24c6-025e-97a3-3cd10a5018e1@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-13-kuba@kernel.org>
	<915e5b8f-24c6-025e-97a3-3cd10a5018e1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 17:48:27 +0100 Edward Cree wrote:
> > +    expect_tuples = set([(cfg.ifname, -1)] + [(cfg.ifname, ctx_id) for ctx_id in ids])
> > +
> > +    # Dump all
> > +    ctxs = cfg.ethnl.rss_get({}, dump=True)
> > +    ctx_tuples = set([(c['header']['dev-name'], c.get('context', -1)) for c in ctxs])  
> 
> Won't this return all ctxes on all netdevs in the system?
> 
> > +    ksft_eq(expect_tuples, ctx_tuples)  
> 
> Whereas expect_tuples only contains cfg.ifname, so this
>  assertion will fail if you have more than one RSS-
>  supporting netdev.

And RSS contexts are actively used on another interface, yes.
Will fix. More importantly we should check that there are no
duplicates.

