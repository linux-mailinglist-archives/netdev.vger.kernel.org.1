Return-Path: <netdev+bounces-222362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E387B53F9D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EA51BC8439
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C72282EE;
	Fri, 12 Sep 2025 01:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITtgu04T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A4168BD
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 01:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639190; cv=none; b=Yk64HkvZUdhM0bb0YsRWmT4k7jHiszGrvlDZFeAnhgwZiC0p3MQ5TPE3o2o6SILJ68CiRJ0IS7Gkv1IyIFORPb86zfYLpiCVyBYp/3OeVxOjydTK//TLb+YKlD1jTV9RQ/mDs7ulY8dw+4rxKBGg4bARbVcpgR3eSXyYfydkS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639190; c=relaxed/simple;
	bh=WQS4j1jK9IITVhX8epiRdfi2aG7KsOnlKfwnvcN6y7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7mMn8bByEqsSkmX0gKvz4JJe1hH35MMezncjAkmB7awbFXdrY34cPswQKyWmpSUcnSlzMGv//zxctZpLA16EebH/FrP8Gm6abRlwFLWjXiW4yRfmT7FEE18ZxA+q7+qZFxtgwMbh+oj7InYjhbi9qHA4oIkwXgPHoEbY5SjkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITtgu04T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DEAC4CEF0;
	Fri, 12 Sep 2025 01:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639190;
	bh=WQS4j1jK9IITVhX8epiRdfi2aG7KsOnlKfwnvcN6y7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITtgu04T5Q3BjTkK4a+9NZNdNWmw2cZ1RG5UdYbLbZGOKwJg357gmkThKpN/Wpabh
	 2gTpbeCicc3porx7LcGce8QUBg0tMDnLNf7KC2XflJcR2nReNEj4Xh/0oWURR8i8K1
	 hn5/P8OCVkkdG67KZEpKotVxDJtQxxLNyBfMu1NelVu451PWmnHZpZdnCqMY8b55ki
	 5YIW/7J7m/qovnVQ/ZZ3t3l6CPkFKWhFPD5l41pM3PHCu6KgcoxS2eXmGsC4Yqge08
	 I7JHvWYRdI6Eptv2sKyo2xBob/GHSBZFRimXVYqiLVwRqYojndXn2176ypHpVdSpcu
	 +nOTZ7p7NMS9g==
Date: Thu, 11 Sep 2025 18:06:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Neal
 Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com, Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v3 1/2] tcp: Update bind bucket state on port
 release
Message-ID: <20250911180628.3500bf0c@kernel.org>
In-Reply-To: <20250910-update-bind-bucket-state-on-unhash-v3-1-023caaf4ae3c@cloudflare.com>
References: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
	<20250910-update-bind-bucket-state-on-unhash-v3-1-023caaf4ae3c@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 15:08:31 +0200 Jakub Sitnicki wrote:
> +/**
> + * sk_is_connect_bind - Check if socket was auto-bound at connect() time.
> + * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
> + */

You need to document Return: value in the kdoc, annoyingly.
Unfortunately kdoc warnings gate running CI in netdev 'cause they
sometimes result in a lot of htmldocs noise :\
-- 
pw-bot: cr

