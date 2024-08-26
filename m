Return-Path: <netdev+bounces-122061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3695FC0C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3E6282A50
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C419B59C;
	Mon, 26 Aug 2024 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqMAP0AR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0119CD12
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708903; cv=none; b=IaTB56WQ4iuohb57oyuLk3QRaEFpLJWwuwL3RSu0iLDqCGyIHCayplHPPhv+cPqrB0RC/JKdgXJJ/DidPFdq/WLsPoVO7sa3xnG2o3KYzo7U6cuj/XRnk7JywK7dpMhaIuSW/YTKNZRnM347HG0IW1JQV7Hp+qTSHJ631+7mJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708903; c=relaxed/simple;
	bh=KwLdG2Rxvc64NlZqugmBRF+kFOLmaZ8PPbnaoncixYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6MciBsCRSf6Yr1P3WS3zgMNfHCy/Bih9VhBwp1ogA+5rt0HU6efig233cFn0A4Ab6vjaL2V7rHcVaui5J/dMQ05XSNdNnsMofkzTAIiVt5oOn4YOpGu2lUCIFwQjhavQdWJZY3N+wUcfL3TtJ7Tx28wvSSes8SMCC0WMzK500s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqMAP0AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546C1C52FD0;
	Mon, 26 Aug 2024 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708902;
	bh=KwLdG2Rxvc64NlZqugmBRF+kFOLmaZ8PPbnaoncixYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqMAP0ARUhPYl2WLb1VR6Izd3dDLrrdqpMvghCsgYj8mu8bAQvPft01BX2csrXuSR
	 CWagAXiA9aXDnt8F6N9vnVE/LjtFMGAR5EBqyMH3I0p6s/tbxGgyQPIjb1vChGnbbM
	 0DKGEpVdetF30h5Zevk3zmQ8xWi+N5iz1QYdKv7B51ySplHLIl5zddxJpiV5qPSZ2l
	 is2hyknnlKBUDDZLokk90MDm7KHdmpMbQOhm+oFokPfaU+hXhgCtFcgxJa0TNjn3Ot
	 GZlBAkHvCFSufC83YMT8lBadjazcn726uepSDMIP0bXCfmvP/KjeBFBlVv5yGpVfv2
	 HOozsvOhIYASw==
Date: Mon, 26 Aug 2024 14:48:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [PATCH net-next 2/2] enic: Expand statistics gathering and
 reporting
Message-ID: <20240826144821.170f6019@kernel.org>
In-Reply-To: <20240823235401.29996-3-neescoba@cisco.com>
References: <20240823235401.29996-1-neescoba@cisco.com>
	<20240823235401.29996-3-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 16:54:01 -0700 Nelson Escobar wrote:
> Collect and report per rq/wq statistics in ethtool.

Take a look at:

https://docs.kernel.org/next/networking/netlink_spec/netdev.html#qstats

A lot of the stats you're trying to report should be reported via queue
stats. See struct netdev_stat_ops for more info.
-- 
pw-bot: cr

