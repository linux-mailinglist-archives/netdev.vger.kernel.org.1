Return-Path: <netdev+bounces-140892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEFE9B88F9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644DBB21667
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0082D91;
	Fri,  1 Nov 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2xWVFQS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76774BF5;
	Fri,  1 Nov 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426347; cv=none; b=b248NnGXVg4gYp+GfWZSfZgxN0WvDZIdaCuvLcCeKfsKzfaOiMw/sFUkLr+k3iW2VXuolYkFWqo+JY7DhYSH/KFVg3tQ9uCKoIyzpdvtrRKmN5IjEAzmlHl11lQlmylrGeDJ+RIhUsCvQbFy4RrzxuhL/XgMSowTEcfC1KvQBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426347; c=relaxed/simple;
	bh=e/5+w9O+7c3DfCZH0rpgxQmU5SaumU3upXo1zXNjSmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9NckdNi5OqDQ5kzNeYcBh0IyKERL6Rm3jmjIOAhpB+LrYmu+e2DZfwaNdboKrFv8UyZ5wAjZTcVZruGblnUeQ85pmrEQ1mhImmD+CIyV0TWWyQRd/CDHlNAcOf0yS2ZipXtUuqFtcxCzruDAhJf6blcUZfVraUmCscarFV2DSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2xWVFQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8EDC4CEC3;
	Fri,  1 Nov 2024 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730426347;
	bh=e/5+w9O+7c3DfCZH0rpgxQmU5SaumU3upXo1zXNjSmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D2xWVFQSchYgDt7XMziCsV/TwybO5ItBh8+biDjxhSe+OJJKaqZw1LG+w93C+23pi
	 +xHrn6F0t2A5SFyOo7XPS8iwvT8pi1LN66ECI60EKWYFMkZCKlWsw1ZAEkZNHPKHIc
	 A76Ecesjm5jK0TU/5tAW56twZvG+CN6+IBZN3CT6uCApoo1e1JRPf5cJ6ZUad4q1oL
	 0nNvLeLs7cycdJiODevXkLt54trgSv/pEzibbOZdrxl/5F//TQw09omCcmrZ2uCQqe
	 z64EX+lQh+ayjIHnCvFHL/jD1iMiru8gMUPskGRqQNsfIGXWRpw0T8ruHhHMc1pjv8
	 9rqCnFkOspyjA==
Date: Thu, 31 Oct 2024 18:59:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <vigneshr@ti.com>, <grygorii.strashko@ti.com>, <horms@kernel.org>,
 <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>, "Vadim Fedorenko"
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix 1 PPS sync
Message-ID: <20241031185905.610c982f@kernel.org>
In-Reply-To: <20241028111051.1546143-1-m-malladi@ti.com>
References: <20241028111051.1546143-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 16:40:52 +0530 Meghana Malladi wrote:
> The first PPS latch time needs to be calculated by the driver
> (in rounded off seconds) and configured as the start time
> offset for the cycle. After synchronizing two PTP clocks
> running as master/slave, missing this would cause master
> and slave to start immediately with some milliseconds
> drift which causes the PPS signal to never synchronize with
> the PTP master.

You're reading a 64b value in chunks, is it not possible that it'd wrap
in between reads? This can be usually detected by reading high twice and
making sure it didn't change.

Please fix or explain in the commit message why this is not a problem..
-- 
pw-bot: cr

