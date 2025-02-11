Return-Path: <netdev+bounces-165001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D8A2FFB7
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60433A9DDA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076771D47C3;
	Tue, 11 Feb 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAYGeke0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFD130A73
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234787; cv=none; b=tu2bBixTEbCd8Nrp2l9kG9TMJU7e1OMAUSXusbAxEoEHo7btyKIewYHNo8XCJBKai+yX/IFAYI+jSmxe5NvKVBU2N0YzJIKtenRMm4wkgE67h9kL/kFT28pYclwisWk+v3czg9dhABYk9YGilqwnP6c+dMSIPphJVMbhRvJ85xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234787; c=relaxed/simple;
	bh=SJs3kP05RR287cE6QD5Y5uMf7J7X6zTrPFdOt0VOix0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbcZi1bB1kZukObAH447QtL8PIFGeaNWxcAID6xIoFTuTJE9Lj83ku4OmLFvg+bclS38RN+fwHq1VzLOulM/A+tGXDUhMXX05TEqDPDx6BmR6hrPcdBzr06Ra16xEJSGHYxJ7E3a3PNZjhNPa8DImIvdkMONizrGt4+3EyhE33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAYGeke0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B531C4CED1;
	Tue, 11 Feb 2025 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234787;
	bh=SJs3kP05RR287cE6QD5Y5uMf7J7X6zTrPFdOt0VOix0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZAYGeke0nJBcEwGOL5CYCtZD3PqUzE1vofydlcE2Fhiw9YFVfOXUqZVecr4rjpg12
	 U/qkx71uG2/tyodrpIlQSkSl9o1VNZ2quBAHMgz10eEXygbVcYq1k+MycrsXYkrZbF
	 YiOT8ZWeXeEl3eIScNasb7rPcLfI54KQSgID4v72Wiv5AEwqcoB6gE1BPWvru6+iNn
	 9/0Nstn2TO6IekkmdsSSoK5uxRhIqMZTTDdVtStzsU3sxs00wB4Uw7FCu5Q5UGvCW0
	 Filzr4YhpbaH666LpYYyMQnDGP+ZLZiGK4/svvO2t3zKSjUmFwiy/MtI9qZ6/FOIeB
	 g3TkXRxAdPQog==
Date: Mon, 10 Feb 2025 16:46:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: David Arinzon <darinzon@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, David Miller <davem@davemloft.net>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, Rahul
 Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH v6 net-next 0/4] PHC support in ENA driver
Message-ID: <20250210164626.178efa58@kernel.org>
In-Reply-To: <7bc5e34e-8be6-46a2-8262-7129fff5e2f3@linux.dev>
References: <20250206141538.549-1-darinzon@amazon.com>
	<20250207165846.53e52bf7@kernel.org>
	<7bc5e34e-8be6-46a2-8262-7129fff5e2f3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 12:33:24 +0000 Vadim Fedorenko wrote:
> Yes, we have seen this patchset, and we were thinking of how to
> generalize error_bound property, which was removed from the latest
> version unfortunately. But it's a good point to look at it once
> again in terms of our prototype, thanks!

I was wondering whether they have a user space "time extrapolation
component" which we should try to be compatible with. Perhaps they
just expect that the user will sync system time.

