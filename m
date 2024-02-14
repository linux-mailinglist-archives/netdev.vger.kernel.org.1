Return-Path: <netdev+bounces-71605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5698541D4
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB991C269B3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DE947A;
	Wed, 14 Feb 2024 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV2HF7VG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA936BE47
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882038; cv=none; b=dWUpmbt5atDHoyf+J6R36pjtxtZ4SyX/gc3Q1iyrSs51+7F+6KiRcLglmFqxH2tXqvoNqzP+x6BxObkVDRRiaNszzCTe0EHV1KfBXcgEu0Cmx0Q9lJ+o6qu4tzZc/2af5LmvZfX9RaXyjO9AGsEQo/ZejCXeExC4Hs6vJ9XkCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882038; c=relaxed/simple;
	bh=bQLQSaxy20GShD9XO/n+rtmHx82mbDcPi0TLyJOjWkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0LpLfDXyBevKPVX4Lg/lpSndUkNY37Yh2E6ovSZFoKz9EuW4soZrHBJBbuvsLceFhCzU82DmYPLpBn8QBkvEBGuHr+0suC7+DlJNCso83HN3uLj1lupnQPdZB2rVcrI8t1JSIV0Qmh3A4/2rJOY5PnhYKRfNYc4E/Y3SsKSLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV2HF7VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE94C433F1;
	Wed, 14 Feb 2024 03:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707882038;
	bh=bQLQSaxy20GShD9XO/n+rtmHx82mbDcPi0TLyJOjWkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WV2HF7VGBivY6pCR0tvVmGoSNr0RoYquwitvhL5byboNloyrU2aDmmeTqXjgST2lP
	 1m35xvh18ti8e5c2xFWffgarnyRPGqwpqNXA4oEkRDoByIvNyoCXeYrTCYA5KLUqjn
	 MzePAl2DI23befcb0YwanMSYMPdOvelaxkhXT/vCgpeHdTZYVs8jg+lECGIXFsoNQA
	 aaFhm3N0lLr6L4gO8MJA9jHsuDaIFwIFtpEZi/TEulnCr/vP2Pg9U+08C+qTAjAvZ9
	 ME401GkxxKdlmrDwNEECSZd+wYSpQKO57u4TiSmgkS8hCOsOYzKg6nfo9WdI1XjzyZ
	 nVwzMBJZ/2DZQ==
Date: Tue, 13 Feb 2024 19:40:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Davide Caratti <dcaratti@redhat.com>,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, shmulik.ladkani@gmail.com,
 victor@mojatatu.com
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred
 ingress
Message-ID: <20240213194036.176d4db0@kernel.org>
In-Reply-To: <20240213162744.6dcd6667@kernel.org>
References: <20240209235413.3717039-1-kuba@kernel.org>
	<CAM0EoM=kcqwC1fYhHcPoLgNMrM_7tnjucNvri8f4U7ymaRXmEQ@mail.gmail.com>
	<CAM0EoMnYyyf7Zpa9eUFBU1vzx5QrUhFfXSFH4_utXOPU4+YFxQ@mail.gmail.com>
	<93a346087193c57f4df807c478d0f7fc8e7db6aa.camel@redhat.com>
	<20240213162744.6dcd6667@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 16:27:44 -0800 Jakub Kicinski wrote:
> If I'm looking right the bug seems fairly straightforward but tricky 
> to cleanly fix :( I also haven't dug deep enough in the history to
> be provide a real Fixes tag...

I submitted a slightly modified version officially:
https://lore.kernel.org/r/20240214033848.981211-2-kuba@kernel.org/

