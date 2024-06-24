Return-Path: <netdev+bounces-106200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1605915316
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8781D1F250E3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB1C1428E2;
	Mon, 24 Jun 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoTt0Gtd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15C4C637
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244928; cv=none; b=T1hRJ9MAfdjNGE6d9jNQmBLt+wojxgcGKWGO5a9uuTiFTABO6lBT8iEoZi+Jy4pgYVGI64mEZtmmevVn/okWy8fC7erhuTKQEhtDVMshffQftNVvSE/6njJ66mpSMhM0mnjcBTMSYs7C2KoAhuWdHu3DecvmJnsJRWCVwg6SLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244928; c=relaxed/simple;
	bh=jWLg0PO59NdjiOMU/QDpur2/oSi3rVu+EstGdPsvi5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWjmr4g8n0oKl6ghgfqNavkNqyyqV7osWDK+KG2TOAoRjBpY7mTUll6rz3v2VXxuGtV2GhBd+A+F7jLXhEXjK6T9gNfC2ffhiawYh1A5v50um6WWR1VQSswGW6W1BIh2csPW5eHBz6m3r4abZ12ir3wV3AOIU1wVlbRu6wTUnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoTt0Gtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C286C2BBFC;
	Mon, 24 Jun 2024 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719244927;
	bh=jWLg0PO59NdjiOMU/QDpur2/oSi3rVu+EstGdPsvi5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XoTt0GtdQFUuEtKPMyWMpPzUau7sb/HhA10PaErxymlH6EoUXxD9hXjZoF8aq3Fsx
	 sydrDfOtDx2nqgiy9EK8M+eVpaOBxVOyWbqrFDwo0eeCm4XmXqed737vtE2ymaDpPm
	 K2zJ4T+1LqepSoWN7299oZ5fY56eON+5qzW/Mxf+7ukFQZQtpUvEMTyh1hUKvEdNaA
	 8P30eZmOyBxU8xjZlfScdO4yVICt3ls6ypTz88sjVSV6biqHzMy2Xcq6M3zZ7dqgk4
	 CCksN39f4DX9lq8Oooi6KWaN8TD3qGdDHqVWcNLsTmU+S8uQcXo4IgEMuGvdXood4V
	 AcDtwM/+9dNug==
Date: Mon, 24 Jun 2024 09:02:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
Message-ID: <20240624090206.5585c2b6@kernel.org>
In-Reply-To: <20240624075035.037041e3@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
	<20240620232902.1343834-5-kuba@kernel.org>
	<6677d6e5e646e_33363c2944d@willemb.c.googlers.com.notmuch>
	<20240624075035.037041e3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 07:50:35 -0700 Jakub Kicinski wrote:
> > > +    key_len = len(data['rss-hash-key'])
> > > +
> > > +    # Set the key
> > > +    key = _rss_key_rand(key_len)
> > > +    ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))    
> > 
> > Probably too paranoid, but in case failure is only for some randomized
> > input, is the key logged on error?  
> 
> Will add!

I take that back, if ethtool() -> tool() -> cmd() fails we'll throw 
and exception which already includes the command as well as stdout
and stderr. So we'll see in the logs what the key was.

