Return-Path: <netdev+bounces-241331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B3C82BE6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DA8834B1CD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47A26E70E;
	Mon, 24 Nov 2025 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqj77QGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911123D7E3
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024678; cv=none; b=AHdufid8q972YITPkbwLt/6uTvjKDhzanFcWfQzE+sUMji7cWB1YCJcnrXa4MsJpWuqnGenLyi+hk3ALsxzw4XaWY+WFk4sGK+FQNves1GsnUGRMuFfXPmbkd3LAXhE6JyO9hyWrZKsrojspIzkGPwWsa7GXXKFsOxvNHw7tWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024678; c=relaxed/simple;
	bh=hjXnYw5HRglMbCQmZp2eAHRkhimR1MdWHU+cDhUg4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q47mOK/g6zlmOHzvACMnSlIIrGXiUgNnvX9uPykpY+iSa93H44LuppbbVP2HqJB2JMzmpqmOrrv3AGlZaNuaOtg2SuAaGHbdutSGO8mmNMXvuolH7BtGb0nhVxt2WllI6jrWJ7Pvzsu5K0ptcf2+WRBobCkNZBjqlYHJhuaeGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqj77QGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5253C4CEF1;
	Mon, 24 Nov 2025 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764024677;
	bh=hjXnYw5HRglMbCQmZp2eAHRkhimR1MdWHU+cDhUg4bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qqj77QGgfuGbm0Vhc4CmV2QvNrjcWQsheXw8fOTqMQUkWaSQuW+Uo7X5BXIunyqUb
	 89nH9LbOP74x0P4j6fw5PGmsfPwIjyf/oZVdkdhbwimpWsAgKfZgOZ7u6buKFkAn8U
	 2N8VutQA4R7AFNqxQjvuCCMYhkkszYJQx/qqhk4YPvllgwrVd+Rn54tvsO+tGA9RJY
	 7wJgRFLOI9kCA3Q01CbNv16ZLk9DBSL2WarW7BRIb7YafiHqY82uj5BonFZ1fmqlhr
	 mbissnc4rcMc1XY7cxwC4jNFAs8Elq/oD7afSNzAy+N+M7TtvZqT19hv9rg/CjCjaX
	 mpj5GSGpzHY6g==
Date: Mon, 24 Nov 2025 14:51:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 dcaratti@redhat.com
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
Message-ID: <20251124145115.30c01882@kernel.org>
In-Reply-To: <20251124200825.241037-1-jhs@mojatatu.com>
References: <20251124200825.241037-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 15:08:24 -0500 Jamal Hadi Salim wrote:
> When doing multiport mirroring we dont detect infinite loops.
> 
> Example (see the first accompanying tdc test):
> packet showing up on port0 ingress mirred redirect --> port1 egress
> packet showing up on port1 egress mirred redirect --> port0 ingress
> 
> Example 2 (see the second accompanying tdc test)
> port0 egress --> port1 ingress --> port0 egress
> 
> Fix this by remembering the source dev where mirred ran as opposed to
> destination/target dev
> 
> Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Hm, this breaks net/fib_tests.sh:

# 23.80 [+0.00] IPv4 rp_filter tests
# 25.63 [+1.84]     TEST: rp_filter passes local packets                                [FAIL]
# 26.65 [+1.02]     TEST: rp_filter passes loopback packets                             [FAIL]

https://netdev-3.bots.linux.dev/vmksft-net/results/400301/10-fib-tests-sh/stdout

Not making a statement on whether the fix itself is acceptable
but if it is we gotta fix that test too..
-- 
pw-bot: cr

