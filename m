Return-Path: <netdev+bounces-66260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CBC83E259
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 20:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758F61F21292
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32EA20B29;
	Fri, 26 Jan 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjzRcO58"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A91DDEA
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296666; cv=none; b=bKagE7sWMrLPd7m6lEOKbMaDaJkTWNAZJfebcXfieJQnwHj98PcX3MO91qE/iLRit7G3r/awH/6wvnGkHuUH8NZwR6Qhxb1mfdMU/EAwwA0p8HgxcAFByMGTAU5ev3D1aBmLf/J/vKyXhJihQHogv1+N0eY21ncHp1YW/+GF1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296666; c=relaxed/simple;
	bh=ANvJg7I6RIVftpiUyOnLxnc9j2xgbvD9gbI5LfkeH/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+2phDX9Xm+LGkyxMI1bBNA4cVgTTGGYgL4lIfkuKav9tGdi08SJq+2mOVZYJIBfHNDi/Xaf9Ot2ul3q5sQegALsplcr8Bs9Rej0pJpgupw60nHWXY7WDzt4cdIsMSPd2KBO7DmMg9yaNLiLFdPPfkm/yfVypWqQDMzBYUMom/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjzRcO58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1865C433C7;
	Fri, 26 Jan 2024 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706296665;
	bh=ANvJg7I6RIVftpiUyOnLxnc9j2xgbvD9gbI5LfkeH/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjzRcO58c21tn9T2s7yDNIeuL0XnUwKyLAEgjYSLHhI9p39THdTM/WrXlUwqDO6rN
	 e92xnel4R0kGb2ACMfLKjMGObU1kNkXgQKpU+2EJn6Ml2ODKDnSKUQlyb841Kh9YMM
	 qvNGlHB9WAeqikxQFe5FPjhKn5nezPWLNufDQMnF494CWYsplKgYbz1pwZzBIH8LvG
	 ZojmyV9MC7oukJoyT47DMJVhGx+CAgJyVyBIT7nkAp7P/CyerqjOksylNzTb6AFGSR
	 SJEZ2I6SJNVMOSCNBTNzFm0K/+sNpsn0Avy938ex7UMl67xLM4fhBhwlE9nx/WGKp5
	 qX/yWK4QtXYKA==
Date: Fri, 26 Jan 2024 11:17:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 1/4] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <20240126111744.7f2dd7a3@kernel.org>
In-Reply-To: <d1aae414-6225-4a1f-86dd-c185ebfa978f@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
	<20240126012357.535494-2-dw@davidwei.uk>
	<20240125182403.13c4475b@kernel.org>
	<d1aae414-6225-4a1f-86dd-c185ebfa978f@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 10:54:35 -0800 David Wei wrote:
> > since you're under rtnl_lock you can use __get_device_by_index(),
> > it doesn't increase the refcount so you won't have to worry about
> > releasing it.  
> 
> Ah, I will change this. Is this true in general i.e. if I hold some big
> lock then I can use versions of functions that do not modify refcounts?

I don't think so, generally you can ignore refcounts if you're holding
the lock protecting the table in which the object is registered while
it is alive, and you just looked it up in that table... if that makes
sense.

netdev lifetime is a bit unusual in how much the rtnl_lock protects.

