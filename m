Return-Path: <netdev+bounces-210899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F0B155B4
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1941652C1
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E9246BA4;
	Tue, 29 Jul 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnQIG7sl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415E1DE2BC
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830370; cv=none; b=s8Lhh6qZfQKxqINUMn6UuxeJgFaCFJGGTAYJAP5LV3qdal+VR+vXZRvGPuOcW+7+C98am2/ntlRv56g4071O9aHUBycb/87wDJ/SlPxZvgW5s4TJQHDKusUUfudvc/7M/MZluxW0FKvVCtulJFHNOLu+LIC102AGG/q07N+gauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830370; c=relaxed/simple;
	bh=+Wr4K6PcN4qzFFnplG2PSa5iNR1f/ScDM8zomogNbtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NCVG0YE8OuUHNcx75Pfm1dYth0PGnlwC5T/3uxPB2j9tsvWTlRZNGcQnBqQ5Dmwz6+7YFMEgIHG+zQpfgm3xb6BxRiSx65mMIOKVklmnei+jQ3uTjsUSaB+f6yjpXHvr5jC74MbwsJhJcWOaj7bFRa7lPUxYPVxPtbVbT7zm4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnQIG7sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDABC4CEEF;
	Tue, 29 Jul 2025 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753830370;
	bh=+Wr4K6PcN4qzFFnplG2PSa5iNR1f/ScDM8zomogNbtU=;
	h=Date:From:To:Cc:Subject:From;
	b=fnQIG7slpb3P/KRYP1r0SPZkZEGRpIu/mrhP8YWxkqwCwix66vZm1+25s3vz1TEJ5
	 eWFAhdEAkW2MaC2gSG2bRBSjuUt+fIoVJKVolmZgPJWQ7ic8KQT8DDhm4OIufGUfzy
	 ocRXtr5WG8iaqXSgC+lC82t5IZhZpfC2xf5xb6IKBDDoWQmhygOvc1V+kVdhihac5y
	 rzHM7iFOIlcbHSpxA8ptihurtZzYrNU8FwEl4J05pR67MlepfA1mVXP7O25D0JH2TE
	 Ppm2HJcr6KrFHRNPfkDjvYLdBX8JeIJHImpUFnShFrg5BdXP+r3ZumTiBGBn9jV+1B
	 Fu2kvGIdBs7sw==
Date: Tue, 29 Jul 2025 16:06:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: [TEST] netdevsim/nexthop-sh is flaky on debug
Message-ID: <20250729160609.02e0f157@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ido!

Hope you don't mind two reports in a row..

Looks like netdevsim/nexthop.sh has gotten a lot flakier on debug
kernels since around the time of commit 25bf7d7f458c ("Merge branch
'neighbour-convert-rtm_getneigh-to-rcu-and-make-pneigh-rtnl-free'")
It has always been a little flaky (4 flakes in May, 7 flakes in June)
but after the commit in question we got 8 flakes in 2 weeks.

