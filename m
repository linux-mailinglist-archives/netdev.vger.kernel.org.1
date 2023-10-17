Return-Path: <netdev+bounces-41632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708DC7CB7E7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A761CB20EDB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DD17D2;
	Tue, 17 Oct 2023 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0SYGznn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D915DA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67174C433C7;
	Tue, 17 Oct 2023 01:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697505443;
	bh=7ROoh33B4S2Q8HMlE9WFvuHJg58fYlf2DYwWrsmMf3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0SYGznn0p/q9hG4OWB0taG9gEVS6J/UfZMU1ZuxWIyG/P4AGQTysEWSbdJlQAV2r
	 9Zv1wt8MOExF1wh6jYBBj9rvUEFWuyXwjrtTqOP3tzAgj1wmobV8I3b1sVHC7PzM4h
	 3JGwyVV2xekE4pL65bHjq/PGm7AbcHmOEpKq3S9ARDeIpSIZHyDhbY3LIo2xteHxpy
	 hJ3ZqrRX5VCSV75sxmmctjMjhdxdw85DlAwH72goSvSaTrqk5GlDBTV+2gIBm8ba/d
	 5RVAR7nUWzcnWuy+AheLpf8Fm7RuB2ZBrfNRmJMYdgfkMCvFjHm49OP7OE4M9vwA4n
	 fwJAXn5uToOsw==
Date: Mon, 16 Oct 2023 18:17:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Christian Theune <ct@flyingcircus.io>, Budimir Markovic
 <markovicbudimir@gmail.com>
Subject: Re: [PATCH net 2/2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when
 it becomes a inner curve
Message-ID: <20231016181722.50e9284e@kernel.org>
In-Reply-To: <20231013151057.2611860-3-pctammela@mojatatu.com>
References: <20231013151057.2611860-1-pctammela@mojatatu.com>
	<20231013151057.2611860-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 12:10:57 -0300 Pedro Tammela wrote:
> Budimir's original patch disallows users to add classes with a 'rt'
> parent, but this is too strict as it breaks users that have been using
> 'rt' as a inner class. Another approach, taken by this patch, is to
> upgrade the inner 'rt' into a 'sc', warning the user in the process.
> It avoids the UAF reported by Budimir while also being more permissive
> to bad scripts/users/code using 'rt' as a inner class.

Perfect, thank you.

> Users checking the `tc class ls [...]` or `tc class get [...]` dumps would
> observe the curve change and are potentially breaking with this change.
> 
> Cc: Christian Theune <ct@flyingcircus.io>
> Cc: Budimir Markovic <markovicbudimir@gmail.com>
> Fixes: 0c9570eeed69 ("net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve")

git says this SHA does not exist. From the title I'm guessing this is
the patch itself, some mis-automation, perhaps?

All in all I think you can squash the revert into this and use
b3d26c5702c7d6c45 for Fixes. I don't think there's a reason to keep
the revert separate, given how small it is. And if the revert is
first what if someone backports just the revert..
-- 
pw-bot: cr

