Return-Path: <netdev+bounces-76661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B986E757
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D411F2A4F9
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2718C17;
	Fri,  1 Mar 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdcOWCtT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA28BFC
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314290; cv=none; b=tRF5WQjzWhFcf9cqp6OT5r/pToEJAimMvM8fw4P8Ejgi5aXNpe6Yw0kwg4kcIpS4tisoTWTJP0MhjT9k2/4wBCh2td81+5ycGv7IzjF/qotZsIwx4R5olY1LW3vPCoWSqN53CsKIm+rAESEtLfUBQVd/kLOuRpvey2ekHe3bd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314290; c=relaxed/simple;
	bh=bwGV8WlkahX4hxvSdXSXuYuVskmQYNb6IgUCB5DjjXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHfEzi8pB1yfol76qXHz3KuTmIr5+1nCoY/tIZmZUf72ulUGHfU59QyXHDizUuPek9TyhCVkFQaSM0ejHn4WenlV7R2DYUerR19AV99oVUbDfd7NJMo6tpVdWvFLGiPZxFiZ0JNfiZEWMUINvj0pqeTKD6cv86Zaj0HtwvGUa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdcOWCtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262BC433C7;
	Fri,  1 Mar 2024 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709314289;
	bh=bwGV8WlkahX4hxvSdXSXuYuVskmQYNb6IgUCB5DjjXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdcOWCtTOAT9NAJV6TTkXorQThX8jJNX7oPQE3Uk+qkSi7IHOQI/ZlSclWbZwgs1D
	 kItxbO2N1k2i5Wp29d3kQuXdl7CTtewaAtN3Jl6Wlq5gZwFaONONYm8mFsh35KAbQa
	 TXz31nC50i26IyPaZGrJsAyhJEPgz0ZT+w4GXUhQ68b3WcASwop6qlqvq/IVGgCYQZ
	 GE/ktWMijlf/TH1WPhOc3MtD8xepPKkq1Q+kMwDrvz4g6ZgdD0c+9OtoW0IqcqDiJP
	 b0YnNKtBkjABy4mleMRZq1hLGuiVVpCGNMNsXyXFV/z3MjwUjRMKNvcrTDWvjfkIoS
	 mpmLa4SkR3+cw==
Date: Fri, 1 Mar 2024 09:31:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net-next] dpll: avoid multiple function calls to dump
 netdev info
Message-ID: <20240301093128.18722960@kernel.org>
In-Reply-To: <CANn89iLcOE7aJ6SSjCSixLOQd4CsMdmE1UQZWBsp6UgufA2pwQ@mail.gmail.com>
References: <20240301001607.2925706-1-kuba@kernel.org>
	<ZeH26t7WPkfwUnhs@nanopsycho>
	<CANn89iLcOE7aJ6SSjCSixLOQd4CsMdmE1UQZWBsp6UgufA2pwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 17:24:07 +0100 Eric Dumazet wrote:
> > >BTW is the empty nest if the netdev has no pin intentional?  
> >
> > The user can tell if this is or is not supported by kernel easily.  

Seems legit, although user can also do:

$ genl ctrl list | grep dpll
Name: dpll

> This is a high cost for hosts with hundreds of devices :/

right, a bit high cost for a relatively rare feature :(

