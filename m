Return-Path: <netdev+bounces-73514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED885CDA0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870E4B23354
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6C3C29;
	Wed, 21 Feb 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLHXMH1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104C4694
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480760; cv=none; b=Sk6+cy5A5tHSZAZy2zod0mcwtTRIZ1YAZq4xzuoe+fQ2ph6JZP3x9p+l/f1UbZVxF3xe/Pc5ZNOuWJRHT+Vm6JgQRZ0/BhS43SS6u6pHVScCnxUGGbzdTEY20omPZgE+wn41pPSPe6iW7CmV0/GtgwxT4kcQJuXW1IjS81JsVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480760; c=relaxed/simple;
	bh=D/WXMWe5i2zSbMKJxik9pdTuExGIduD+BswJJ/xibMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFblv3oHmxw5zZEugXc2Onpw3rvTFamCDNksrAlcG08wckmkbvtL1CcCk42ksUJN3QBcKApUfGziES8i5d0YHS3vOBeIuRcINL7CdaltHB3Ur9fI+lnQFDQR03DWMlA36OCwH0G2o+pTH0S4ojj7nJo1QLn2gLwsFqDdBpTURXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLHXMH1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D93C433C7;
	Wed, 21 Feb 2024 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480760;
	bh=D/WXMWe5i2zSbMKJxik9pdTuExGIduD+BswJJ/xibMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dLHXMH1WZLNBQZGoxVPyL9mYMRfN4dc1Dh65KysiubEPeU6++TKiRaKMCgjoexW+t
	 FNb99ZgK/oGrqWAl3sTNrkHGhk4v/aNmyj1TKpCnHt5yvccndvqIrHeV+Tz9HQjSpD
	 qj192gVDUFfPHepQPWJsuaIK38izD6HSvpt5eEnBDoWPtZg3q1GMGp9hg/ib27Ziwn
	 k9AuMLarpRd9COq+2WOa3Kaf88AbHJlsVyda4KoZDNbjPa2MTVst3WSPXI4HdqY6Nr
	 5HzN8Bu/q2Fvvk8iFeRFaNC6yXBHuMTlI9v/LpmFF1fEWZvpjyU52TmKeTyHokgKtL
	 g/WI6lAnlRFWQ==
Date: Tue, 20 Feb 2024 17:59:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <20240220175918.73026870@kernel.org>
In-Reply-To: <ZdRUfZMRvjMlDqtX@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-4-jiri@resnulli.us>
	<20240219125100.538ce0f8@kernel.org>
	<ZdRUfZMRvjMlDqtX@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 08:27:57 +0100 Jiri Pirko wrote:
> >If the user mistakenly passes a single value for a flag, rather than 
> >a set, this is going to generate a hard to understand error.
> >How about we check isinstance(, str) and handle that directly,
> >whether a flag or not.  
> 
> Yeah, I was thinking about that as well. But as the flag output is
> always list, here we expect also always list. I can either do what you
> suggest of Errout with some sane message in case of the variable is not
> a list. I didn't find ynl to be particularly forgiving in case of input
> and error messages, that is why I didn't bother here.

It's not the same thing, but (without looking at the code IIRC)
for multi-attr we do accept both a list and direct value.
Here we don't have to be lenient in what we accept.
Clear error message would be good enough.

Some of the sharp edges in Python YNL are because I very much
anticipated the pyroute2 maintainer to do a proper implementation, 
and this tool was just a very crude PoC :D

