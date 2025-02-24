Return-Path: <netdev+bounces-168879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3851DA413DC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 04:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12861891DA5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 03:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C41991C1;
	Mon, 24 Feb 2025 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FENZbBJj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520D157A5C
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366398; cv=none; b=I5YQkdnOhNjRLCK6Hq247V9n98bgOuvvm0wUHESyLgckOuD20gu0WZuij7ru5GMvlns5olnqk0OL0WLeORoFnH+4hqOgrccMrp/J/83tA0VwcDdnE1i1ldg9uVG0JWG29/PPJf+hWDJA7mUp1d/tI6h31SSjACU/06Z4/wo9uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366398; c=relaxed/simple;
	bh=FypSvXs26AxTGuO5Psk7CjjFhNw9vBrRBMlLY9ga5Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAXEhJj/RkgWmq8qqsrn3+oO+XUBgTyFacAURjSXKERyjz1qJpDFZvt/RHyQ4oTt7/w6UpEQDmKOO8xgz2koG+iz55RdbNnsQIZVfMa0wNqMT/IjCyMFWKTq5AdNU4wyKkiKyCeZzzWGv/N+WXfaYYa/3xP+P7/v5h4TMa2RuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FENZbBJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B480C4CEDD;
	Mon, 24 Feb 2025 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740366397;
	bh=FypSvXs26AxTGuO5Psk7CjjFhNw9vBrRBMlLY9ga5Ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FENZbBJjzCx+fIcxOk3PQm1kyiAPOAZJqyeRrio4IlsvpMQ4e7a1B79WXOgWEkbej
	 1g6sA/tEdFEXb1r5cJmRDRbpZ7di3OR4VkbVlH4G74jmPOhkNxc4DYuUOZ/tPDpHck
	 FNK2VphQZ8NseLOlEDVfg0YksZzUKdRQQCc7UWQdMy7NzljIpieTlCZgB/z3Q/XI+6
	 T20RVvoB8cqa0tci39s8ItJEqnajnAYoKczv5lVmUCU1JvY6dsHJFSpz6oM52IbhlD
	 pyKWvyh6PFCoItfmaR2Mh34OW3pUQwOeMm87bdk8uAwd+SdaWFGVIJl99kSx79I3Bi
	 k1lpv0yj33+iA==
Message-ID: <395fdc3a-258c-494f-914d-5da3861c0496@kernel.org>
Date: Sun, 23 Feb 2025 20:06:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
Content-Language: en-US
To: Jonathan Lennox <jonathan.lennox@8x8.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <20250216221444.6a94a0fe@hermes.local>
 <B6A0B441-A9C9-40B5-8944-B596CB57CF0E@8x8.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <B6A0B441-A9C9-40B5-8944-B596CB57CF0E@8x8.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 1:10 PM, Jonathan Lennox wrote:
> 

lacking a commit message. What is the problem with the current code and
how do this patch fix it. Add an example that led you down this path as
well.

> Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
> ---
> tc/tc_core.c | 6 +++---
> tc/tc_core.h | 2 +-
> 2 files changed, 4 insertions(+), 4 deletions(-)
> 


