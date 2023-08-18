Return-Path: <netdev+bounces-28965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CF781449
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FFC1C2169B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931B1BEF6;
	Fri, 18 Aug 2023 20:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AE19BCC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BDEC433C7;
	Fri, 18 Aug 2023 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692390288;
	bh=Bv80yHrZ515K6YjLahsrhKI49AivXsUCKRTPPl7ffWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UeOLHiqZh4KBB+gvIac0sn5HlgC7fXTyA9dT77yikrhHzYQIOCPDA4uMThUu+EJMm
	 EPUyCUmBpflA77bJt5T9eNcmIQuXI1dmVKHgxZutTPv0i0ehTsC4dXocDlfv0cEyGO
	 lXSsKavimgctmkL1EWZLzc1dGmAVFiOpWBNWN4ZxSNA7M5Bd9stFrv+5TWEroddwP6
	 aKlczRy7+RcKUH+aL7nPZ+104VqWs7NwwLujJk5rsAh+65VZ8hDOrouAd4W32ogQtY
	 nrywHP3pWjeRNwpQlUl5sHuvH8ZOSlW+shaHj57ea9VYCAuw8iWjnEFm7x/s/6gvUg
	 boTgBUkjZ3t7A==
Date: Fri, 18 Aug 2023 13:24:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple
 cmds
Message-ID: <20230818132447.32d32df6@kernel.org>
In-Reply-To: <ZN+0RCxWBL74Ff+C@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
	<20230804125816.11431885@kernel.org>
	<ZN8tv9bH1Bq8s7SS@nanopsycho>
	<20230818085535.3826f133@kernel.org>
	<ZN+0RCxWBL74Ff+C@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 20:11:16 +0200 Jiri Pirko wrote:
> Okay, you don't have good solution, do you have at least the least bad
> one? :)

I was pondering this for the recent pp work:
https://lore.kernel.org/all/20230816234303.3786178-13-kuba@kernel.org/
search for NL_SET_ERR_MSG_ATTR.

I ended up hand-rejecting the attrs which I didn't want.
It's not great because the policy (netdev_page_pool_info_nl_policy)
is shared so if someone adds stuff there they'll need to know
to update all the rejects :[

I guess a better way to code up the same idea would be to check if tb[]
is NULL outside of expected attrs.

Option #2 is to not use the auto-generated policy, and write the policy
by hand in the kernel with the right members.

Option #3 is to add support for this to the YAML. With the existing
concepts we would have to redefine all levels as subsets, and then
we can override nested-attributes. A lot of typing. The YAML is really
just a slightly decorated version of the policy tables. The policy
tables in this case have to be separate.

