Return-Path: <netdev+bounces-246812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E73CF1421
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C43663001184
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24362798F3;
	Sun,  4 Jan 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbz24gjy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7374C92
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554353; cv=none; b=qhjH3CmmnN/SncvpH+0QXKtQmI18BdtS/DqZM5wpga0MfuCBs9tMywBeUbajEBk/M70bvx/eB7UFCrqGvAEsUJHmot1mnZRljIP01kmxf0KbrtCrcW1597RUE2yCkEcghGgwBTxkUKwGKNtCEJGDC5IXnG6JDXIpPh15Fu9mKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554353; c=relaxed/simple;
	bh=HdmQKswoZx8azX9NuRqWZS3ubjazjBKaK9jb8oq3ATE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF69f0S2rYqeXqnrKFrzp1QKg8YjSFYCXQwq9a/cOWkUOnj8np5vLG69qoZWcGD02tNNkBl4je7bPEKiyiiJWAaUF+JBIvJb2mlDMdthEpgYCxzwL2bq6RJ66aJ2qbkeM4YfF5BrEDiUD/DDXX8IQIQi2YOwSZUq5KTBG9CzTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbz24gjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E24BC4CEF7;
	Sun,  4 Jan 2026 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554353;
	bh=HdmQKswoZx8azX9NuRqWZS3ubjazjBKaK9jb8oq3ATE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sbz24gjyPYJd6vZbP8fp2xewgM2Hb7taxO0OdGMsjk9e0UioyycsTu3vUlwi6K6jF
	 +7Df6G3YJ1mASJ3AxIpGGw8qFbgzQrK4+sWfU47Tf42XsWua/FuyEnl6E9T6A2GSCq
	 DEBdeYuJZjHVVIRRqKfPOHcFaPLjtTKAc/0mFol/Bgtnm0EoRwQuw+WTvw7nxs5j3j
	 PgA571POhldUAmqk9V6UMZAzvdrRCVWjSQFNWl7tA8aILaM3qo4+ikxnjh75o1KnDY
	 DjwNnNcxSIyM/ClaMPazZ7xHvRSFElsET1dZlb0mjcYCIqoZMh5xyOAj4fYCZlgHJf
	 qH6FraqJgwXzg==
Date: Sun, 4 Jan 2026 11:19:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, William
 Liu <will@willsroot.io>, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net v6 4/8] net_sched: Implement the right netem
 duplication behavior
Message-ID: <20260104111912.66940630@kernel.org>
In-Reply-To: <20251230092850.43251a09@phoenix.local>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
	<20251227194135.1111972-5-xiyou.wangcong@gmail.com>
	<20251230092850.43251a09@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 09:28:50 -0800 Stephen Hemminger wrote:
> It is worth testing for the case where netem is used as a leaf qdisc.
> I worry that this could cause the parent qdisc to get accounting wrong.
> I.e if HTB calls netem and netem queues 2 packets, the qlen in HTB
> would be incorrect.

Indeed, presumably backlog should be corrected with
qdisc_tree_reduce_backlog() ? Either way it'd be great to add / adjust 
some test cases to confirm backlogs are 0 after the traffic stopped.

