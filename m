Return-Path: <netdev+bounces-89268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A98A9E58
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF512824FE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E99168B06;
	Thu, 18 Apr 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5XCK/d6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C7161935
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454136; cv=none; b=ouucKr2piYLY5rk2MNvakTDzl9F6uikl3mHNum/eWq6J2nYd7q0yVoqXwWUYMiNaOfzy0+P/DvCIjz6ntG7OHt3bvsLRoXSx01zlQNMhMsk8XosRCQARqnf3sg1spRcWKlhFdbq4brQo0cWnkGgqIGXojBGRaljwqSdlEDMAtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454136; c=relaxed/simple;
	bh=5jW+uUnwhrvCXx0fYT6Qo68D1DmncWy9nhmFLVw8Nak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXZ/x5Qdzgp9g6bxTps3h15U9VBDhxC9Ln1nfI+PLGYhCJzeMxaZr39tpxecni7fI/2FF8WXcUEOjxjzzDhLQvUkubDidzmESf9mGx7XPpmOLERf9XSt8o6S6ulTsFG8XPvjc1hhmSKn6RS0jLrHjdDC4hgZy82VE8sggsvLSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5XCK/d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83CC113CC;
	Thu, 18 Apr 2024 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454136;
	bh=5jW+uUnwhrvCXx0fYT6Qo68D1DmncWy9nhmFLVw8Nak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5XCK/d6SQBMPnddECTwJerWBS92z8iOsPIdocgPxvQHLUNWyqCk5YiRC29kAhFXv
	 B92uGwrUtShnWM8Rff5unIl7HfBjKffsZwyEa+flSB9s2BQ5v6df13yMVEprw2IIZV
	 6ykQTt09iPM55T69ePNiP5St35Mx4n9WtgyQOsLzkP+CRw8Qdlw4doTOiruExQLWX8
	 gPCw0acZ5HpbWHsj7OvQFh5DDoAuxNVtWSx6iK3DUzfzxwyEZPLPkdPnKBQTAtAJbX
	 OS7WMCldGUSrNymNlLp4lKcKYFkNlPtawqHgvRWJnOAMUqyDR4xWzG5CFwxmR13a8E
	 5X5TS/jYfjHTg==
Date: Thu, 18 Apr 2024 08:28:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de"
 <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com"
 <axboe@fb.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, Shai Malin
 <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or
 Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Message-ID: <20240418082854.7bca40cf@kernel.org>
In-Reply-To: <27e21214-7523-43e2-a3a4-0b6327190fec@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
	<20240405224504.4cb620de@kernel.org>
	<1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
	<838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
	<20240409155907.2726de60@kernel.org>
	<27e21214-7523-43e2-a3a4-0b6327190fec@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 08:29:27 +0000 Chaitanya Kulkarni wrote:
> > You're not sending these patches to the distros, you're sending them
> > to the upstream Linux kernel. And unfortunately we don't have a test
> > lab where we could put your HW, so it's on you. To be clear all you
> > need to do is periodically build and test certain upstream branches
> > and report results. By "report" all I mean is put a JSON file with the
> > result somewhere we can HTTP GET. KernelCI has been around for a while,
> > I don't think this is a crazy ask.  
> 
> That should be doable, we can run the tests and make the results
> available for others to access in JASON format. Just to
> clarify what you mean by the Kernel CI ? what I understood you want
> our tests to run and provide the results, still not clear about the
> Kernel CI involvement in this process, can you please elaborate ?

Kernel CI was just an example of CI being a thing upstream.
For us you'd need to generate a much simplified JSON which netdev CI
can consume. Could you reach out to Petr Machata or Ido Schimmel 
internally at nVidia? They are involved.

