Return-Path: <netdev+bounces-178843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADBCA792EB
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0155C16D3A0
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D95F18B484;
	Wed,  2 Apr 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT1TAGeM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D1189520
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610722; cv=none; b=m3xbT3F8qP/KzwFKIoPUqswB2d4w/ORbo0iYYoO5gV2+PzcXg8eZhNvA5VVJpXDJHRDJ6EePmX0O8eq3zZEJDbsLFXaDhUoTyActprGuTKIpL1PpzPGpUHakxbdJmJqBpoHYgI9mI7sGYgJMJO33lKaJHgQgaSZ74dWXFNPwreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610722; c=relaxed/simple;
	bh=0VVA7EBtxKuEpnkGfs+O9MReAgDX8pQAhyesOWMAu9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSjo06ksMReMyRxtlbO6kg3+LIvjM/bznya/vj4J590imKUqpMcHkoB9ALE59oeJk2hCqtHAluqojim7dqCymEzGZ2gewgADxFaZmrFxKB6+6D5k2o29z14RLuYgjM4zUsBPG0iJIOK9glEUp2l1hBvj/YBRhe7cjQXJQQukYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT1TAGeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D45C4CEDD;
	Wed,  2 Apr 2025 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743610720;
	bh=0VVA7EBtxKuEpnkGfs+O9MReAgDX8pQAhyesOWMAu9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AT1TAGeMpzFkAUdwEGBHSXO/nNVdeTFX2u/Cst50ymQMcgeWtO0s3tgzfJo7P1DvH
	 KhzUrHTOm6HBX9Z5kH3tEU3JL3vHXf0pGwqTcwE0shFnzJWTFsvht75IxOHPCXKFOy
	 DIKjF+4s6kU09AmH/AHh/sNvAdyzOHz0GiTcWfqYG2TRwhWMChTWYe5zWOy/Im/N4K
	 8jCzWs3nCgKQslk18k3WeEd/JiKAjnjUaMeFccWYC4Zp6tUvdG41ZUgRvqORxV/OuB
	 98qN4/4yC0gw4UP9PZFKC/lblmfcEvers3OAi3xMm5IQbTa6oaST0L31BLz8hdA8k2
	 O8U5f5qhRR/1g==
Date: Wed, 2 Apr 2025 09:18:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Message-ID: <20250402091839.0a70f23d@kernel.org>
In-Reply-To: <7f47bb1a98a1d7cb026cf14b4da3fe761d33d46c.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-2-allison.henderson@oracle.com>
	<20250228161908.3d7c997c@kernel.org>
	<b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	<20250304164412.24f4f23a@kernel.org>
	<ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
	<20250306101823.416efa9d@kernel.org>
	<01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
	<20250307185323.74b80549@kernel.org>
	<3b02c34d2a15b4529b384ab91b27e5be0f941130.camel@oracle.com>
	<20250326094245.094cef0d@kernel.org>
	<7f47bb1a98a1d7cb026cf14b4da3fe761d33d46c.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 01:34:40 +0000 Allison Henderson wrote:
> I had a look at the example, how about we move the barriers from
> rds_clear_queued_send_work_bit into rds_cond_queue_send_work?  Then
> we have something like this:
> 
> static inline void rds_cond_queue_send_work(struct rds_conn_path *cp,
> unsigned long delay) {
> 	/* Ensure prior clear_bit operations for RDS_SEND_WORK_QUEUED are observed  */ smp_mb__before_atomic();
> 
>         if (!test_and_set_bit(RDS_SEND_WORK_QUEUED, &cp->cp_flags))
>                 queue_delayed_work(rds_wq, &cp->cp_send_w, delay);
> 
> 	/* Ensure the RDS_SEND_WORK_QUEUED bit is observed before proceeding */ smp_mb__after_atomic();
> }
> 
> I think that's more like whats in the example, and in line with what
> this patch is trying to do.  Let me know what you think.

Sorry, this still feels like a cargo cult to me.
Let's get a clear explanation of what the barriers order 
or just skip the patch.

