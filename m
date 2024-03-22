Return-Path: <netdev+bounces-81153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B38864EB
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 02:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F09C1C21EB5
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CDB10F2;
	Fri, 22 Mar 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b02KvSfT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5565C;
	Fri, 22 Mar 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072484; cv=none; b=Z7Ir9aDd5LFjVU0T8SiASV+hLDd0nc6KWAaHUbY0vyOzqJoeI2nFWmvreDNYeMjA+PrxXeeQ/ZDbwbGdTRe7r6ZNjzBY7wPgUOCgr2dxsApnVUFx9j6QU7d39a1YyKCYPiYTRWBNw5zhcBN2ZM2fht+GhKo9NIpMf8FM7TaFJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072484; c=relaxed/simple;
	bh=Cskx5u7yuBBojGXITmR1BsGPFSCdaJFtSUDscVEPewc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PL/g+4zTjnPrQnjOEugqvA8zFL1Nhenq+7yrv5uxHuv8ABYhIN9FkfMO+QmuBmOmBLfdwgSngLUvBRFrZKLj+k8+b5iOGNYrVfwPd8/E0318TJEumnzLbraB7CuUtAQPuS7oiiHzVzxbJcPw9TZ9rjbz8mBxNidEiHOcv8Is4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b02KvSfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC52C433F1;
	Fri, 22 Mar 2024 01:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711072484;
	bh=Cskx5u7yuBBojGXITmR1BsGPFSCdaJFtSUDscVEPewc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b02KvSfTT9oYOfm1Ri73hgarLQ/uA6yg+RnoxmamtnP80CJ39Se/RIGavSN1TElba
	 gzm3s5eh5dIqjYlfsn34iNqx0ue/GQw3KNUspBwHZ2Rb6H9a5QtJQIF0GF+aijqBOn
	 /NgrJUuk31yI6DedPOzVbP2OT45RkSjLHZR6u7KQV8SPhJOgr5cCxyyOxK/HtsopIi
	 hHjVYr/vQitf/dpmp4qO59XHw7ldEYetLQutVrdVqmKqEwfkMOVKrjRsgb3mA7tdII
	 vtw3F6743+MlnzT8Ez3G7cyz1EJxkUd7boVCJmiuWGwfBdsNFOYA/idaWanCnUqpQU
	 aFCBnr0EdcADg==
Date: Thu, 21 Mar 2024 18:54:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>
Subject: Re: BUG? flaky "migrate_reuseport/IPv4 TCP_NEW_SYN_RECV
 reqsk_timer_handler" test
Message-ID: <20240321185442.551658d5@kernel.org>
In-Reply-To: <0edaead1-b20b-4222-9ed5-4347efcebbc2@linux.dev>
References: <0edaead1-b20b-4222-9ed5-4347efcebbc2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 18:39:53 -0700 Martin KaFai Lau wrote:
> The bpf CI has recently hit failure in the "migrate_reuseport/IPv4 
> TCP_NEW_SYN_RECV" test. It does not always fail but becomes more flaky recently:
> https://github.com/kernel-patches/bpf/actions/runs/8354884067/job/22869153115

FWIW we had a handful of IPv6 and TCP tests start failing after we
merged first half of the merge window from Linus as well.
Maybe something in the scheduler changed and exposed timing problems
in the tests :(

