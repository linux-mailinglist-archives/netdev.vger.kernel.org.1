Return-Path: <netdev+bounces-162838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A20A281E7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5A162B5F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589C210F5A;
	Wed,  5 Feb 2025 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahpsrPP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064A20FA98
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723135; cv=none; b=u+CiDq9SbWRO0GxZHXmUCN0EBDH8f7iiBiHnLUWfZb4jLFIGQVTB7ja24pv89Vx+b3kxZJwM3n94jqVV1PTwRVD+a0RIFJot8EATvTjh4/JV5jraJFT1s0dNxJ5QGn06vEVac1/IEax+0V5/Gj9NVlTfTpPvzwOIkdA2qe/I9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723135; c=relaxed/simple;
	bh=RVQo8GEKtf4NTTZFdQIKXIlAWjr3I0pHv/1jnCITZrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acjxjjdhHgGS2DLIVVVP4PYOpynLNT9zPgcd04RBQjLyHJOTjcXkvIF/cOVPTMtYwqxv+o/wTeTi3rrs2TIYG3TeY1x7k6e2WaV6u/uHCpLo+QMid73RH8qdEX1C5eGY3Cf60XeyZMCDoM0+8x1X18nSLcgYMbT2ZK7fY+lY/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahpsrPP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5D2C4CEDF;
	Wed,  5 Feb 2025 02:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738723133;
	bh=RVQo8GEKtf4NTTZFdQIKXIlAWjr3I0pHv/1jnCITZrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ahpsrPP67ktWI8ukzpwfzovWWzJQxss1rcvRUi1McIhkNPClVr+R5qai8AP77J2ag
	 HUh21UzV/gLPyfuP1SD3bSlheztvcS3Q0Pryn/Uuxt6+gT0cvPT8xhyFdVrPB6kFXg
	 D+w8vZZ/FADFHbas3xyMn87KqlCbmre1Lcl6vEhGtM+1Z3bVh/xmUV3fAtr708G2Jy
	 kS5Ke48Rf6pFvQIZ4TyB5Maxt0v6mwtAGyA6jxGvxINRLuqvHLKWuBobgCpGH64IGc
	 Q4/6gyZzBc/YtkRiSgyYpVuZsJtKYUAJ0iZuoJICHJ7nTmEmNQI97Lh9KK2v09Hh/v
	 lt0EZtLh6JV7w==
Date: Tue, 4 Feb 2025 18:38:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Simon Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 mincho@theori.io, quanglex97@gmail.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <20250204183851.55ec662e@kernel.org>
In-Reply-To: <b06cc0bb-167d-4cac-b5df-83884b274613@mojatatu.com>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
	<20250204005841.223511-3-xiyou.wangcong@gmail.com>
	<20250204113703.GV234677@kernel.org>
	<20250204084646.59b5fdb6@kernel.org>
	<b06cc0bb-167d-4cac-b5df-83884b274613@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 23:21:07 -0300 Pedro Tammela wrote:
> > This is starting to feel too much like a setup issue.
> > Pedro, would you be able to take this series and investigate
> > why it fails on the TDC runner?  
> 
> It should be OK now

Thank you!

Revived in PW, should get into the run 22 min from now.

