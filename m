Return-Path: <netdev+bounces-105829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B8913156
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADFF1C21134
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0641FA5;
	Sat, 22 Jun 2024 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5C+XF8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341C441D
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019289; cv=none; b=n5VlGhyJ8Yp0dUcWCE1Yx7Dw+QwG6yxxaYQW6dO6VvW6iv+a6ay/H8IniqHwQfl+wq6XNRsCOBbJf2ONMS35ZhBb7+Q02dP3Hu6ZtWZqln8B8oWrg0rwwiNJ9TydNTCoPC9SGr9YYY9sgkIJ3I/PMH3v0g1jrF19MZDwkB5rcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019289; c=relaxed/simple;
	bh=CYq91PGI1owXao7NdTHH2vp6AeUAkWhepoU4T0qbR+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1c5R0x5VtvP9Bqd+/2Rngh6sev4uyXG9QSoBp4X0TTWZl83AUWv7vAkdD327PPeFBsYugrxV12+9MVGWfEUARjm1ohJ4FXbhzy3wK7l+P7445BCityEW6USRJrPlrkfysFU1sa3te0ZL9EusH/gN4RQmZtxWTEoT4B6Q28ukGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5C+XF8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FA7C2BBFC;
	Sat, 22 Jun 2024 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019289;
	bh=CYq91PGI1owXao7NdTHH2vp6AeUAkWhepoU4T0qbR+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5C+XF8mnJgfWIaeuVPyfUb+53cmr57tcciF6d2PQFdCIUNkWJmifcdZ7yf6dqIBq
	 WsxYMmN5iYrp3eVALw359xyK1vZQ5aS89tScUEiuPwRlbsmkYIcrqf56IWpegbh2bD
	 G9RqJcB8V0U598zFeoUv33/c7CGrVqAxmA7EI8zR+CgvK9MdtDt56RA8N/vCIxOd4f
	 H/Ft/0UHUWgqW0Lh8GOjaGORcKRWvJt87d1Ixg6sGpYBP+WVcsi8Zo4ibl34RZGdg/
	 35sAZrX9JMKRJGLmKTYT0pY1pjnjiLR3LoeBVYPTmFzjdbRMrU1cbHhy17PG5JR8Gw
	 93SagYiCvWSVg==
Date: Fri, 21 Jun 2024 18:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH v2 net] ionic: use dev_consume_skb_any outside of napi
Message-ID: <20240621182128.3a9481ce@kernel.org>
In-Reply-To: <20240620192519.35395-1-shannon.nelson@amd.com>
References: <20240620192519.35395-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 12:25:19 -0700 Shannon Nelson wrote:
> -	work_done = ionic_tx_cq_service(cq, budget);
> +	work_done = ionic_tx_cq_service(cq, budget, true);

you gotta use budget. When budget is 0 you're in netpoll not in real
NAPI. So you can keep the bool but instead of unconditionally passing
true you gotta pass !!budget.
-- 
pw-bot: cr

