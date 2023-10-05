Return-Path: <netdev+bounces-38144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64227B9903
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 17FBB1C208EF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FC366;
	Thu,  5 Oct 2023 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRd87dnO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DA7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69215C433C7;
	Thu,  5 Oct 2023 00:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696464081;
	bh=pT9bmZ/bh9lBQv3geI9gE4cnZuBHmmOmTxUsClrb6Fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRd87dnOFadg5OvUjak2dHXVko0c6jmwa6+NDYsPZVf4pdl4xVij21I48MK4Ub96A
	 ewuuo/fsKr+1izHtrClBss4FJM58CPItamH8YToY1tF3WhWDi9jg+XU2+fxn2UFzD7
	 Fa2TWVeDy0UmYIfUXwdA9Coltz8+jLxgb10U8yoJBdQJIojur7FLv2fRCqcsUiuXWw
	 Axr3Udy/gPKlyvgXanCdlWnsc83jvhEqeKW1+rDdED1BuHAxrOEo1NW8IfQqt4zqSL
	 tD22Ab1ciklntJQ+V5mi8MOy344z9iAXedkpgKRyUPQyrMqQWQpNs0ukT9k+wbtHVU
	 G2g7K0ht1ILYA==
Date: Wed, 4 Oct 2023 17:01:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Message-ID: <20231004170120.1c80b3b4@kernel.org>
In-Reply-To: <20230926182625.72475-1-dg573847474@gmail.com>
References: <20230926182625.72475-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2023 18:26:25 +0000 Chengfeng Ye wrote:
> I find tcf_gate_act() acquires &gact->tcf_lock without disable
> bh explicitly, as gact->tcf_lock is acquired inside timer under
> softirq context, if tcf_gate_act() is not called with bh disable
> by default or under softirq context(which I am not sure as I cannot
> find corresponding documentation), then it could be the following 
> deadlocks.
> 
> tcf_gate_act()
> --> spin_loc(&gact->tcf_lock)  
> <interrupt>
>    --> gate_timer_func()
>    --> spin_lock(&gact->tcf_lock)  

This is a TC action, I don't think it can run without BH being already
disabled, can it?
-- 
pw-bot: cr

