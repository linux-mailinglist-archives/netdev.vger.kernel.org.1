Return-Path: <netdev+bounces-159858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D6A17337
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F741163C46
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A01F03C6;
	Mon, 20 Jan 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nauLqaBT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A811F03C2
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402242; cv=none; b=ALUDuL4F0sNV4HKiP4LoSwimVTvwKAPZW0HQ+kqbxh6GIptmiy8bULgmHrZxkqz7H5WTTVNtsiFauDve4edJEw+QY5xsjT54XVUxuQ0zOPv7E+4dC3emHRvgY4aQLIkuJKT2HyhfRBIhQXY5Tbw6KyLmPjCRKY5eoBI1vd4FPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402242; c=relaxed/simple;
	bh=fiUrI0yl85lt+vr1BkJDEFGBoNlFCOxHhmKCJ4zvdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiRPYR6d+HXW3SUetWxUXYS+Rl5dJOHHveqa3zk/k3GCEx7Tz3S0bPSGpD1FX2CmuF711QfBCCzNWBVCncLhrWsCT/GUQeXS2dF46k5mh/HXx0+s87NsoksVGTj3K+ZK/SzzKqO2iLgweuKXt07BnIqhgEn/LUq9TfYwuGsH4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nauLqaBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF858C4CEDD;
	Mon, 20 Jan 2025 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402242;
	bh=fiUrI0yl85lt+vr1BkJDEFGBoNlFCOxHhmKCJ4zvdAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nauLqaBTujgd5KD78g8QFEwOlJjL+rCew1p4zo6eI4MWmwNqkWQiyUULBoi+T8qni
	 Wm+bRwYjeK+gmo7XEjrtH9BwF1C0cCzxcQp2HQQKkhJmWrMTeQs4GF3bFYtFcpQNMq
	 8zfXisMEKqCeu30/8sM9801jrpywVXhLM3B0hXQbH8dv8iLNpRTR/OwgNicHpU3crg
	 NlexOGDfaW+mJG1K5EXK2eq0jFvYlsfzWO2aLEOWyuRvMa594beRA3khDV6LlfrkJR
	 cJ/0KKxDhpuyD4sR+wJIONXTlrQqveGVAKcgwyk1wYHocV/ZzHsXwEaqF7EYxZSwQH
	 OZ8v/Vy4+6JTg==
Date: Mon, 20 Jan 2025 11:44:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 stephen@networkplumber.org, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net-sysfs: prevent uncleared queues from
 being re-added
Message-ID: <20250120114400.55fffeda@kernel.org>
In-Reply-To: <20250117102612.132644-4-atenart@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org>
	<20250117102612.132644-4-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 11:26:10 +0100 Antoine Tenart wrote:
> +	if (unlikely(kobj->state_initialized))
> +		return -EAGAIN;

we could do some weird stuff here like try to ignore the sysfs 
objects and "resynchronize" them before releasing rtnl.
Way to hacky to do now, but also debugging a transient EAGAIN
will be a major PITA. How about we add a netdev_warn_once()
here to leave a trace of what happened in the logs?

