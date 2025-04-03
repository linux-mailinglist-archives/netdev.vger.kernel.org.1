Return-Path: <netdev+bounces-178929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A1A7994C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4298516DFE6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970642E3367;
	Thu,  3 Apr 2025 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHRWMCWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1AEAFA
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639137; cv=none; b=T+upQv5yUaOCv4+o/F238nDElIDiHeGu9w3wDzUZrGPONiHyGqWFYDG4/WoNQkMdG5CaJteC7A5PYC5TXpma+I3M9K5p0iP+gFH1dVeqcWQYYFX2tPureAhfwcheLG58cTtteOL0ahSL2b+RZLyINfAfr3zUoLenQOHvUE4Vyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639137; c=relaxed/simple;
	bh=yYEUFJvayMaVPcBXwisOfoqVVEHY86bh8nXTTcnjJmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkHIfPq1jhnSqjNoC7Mnaii56lWKVI4w7KinpBBhG2KzupArGSlmU6RJYQs1WTsPMzv3/X6sS8+LmEiw8YLtTZT7lqbrPy2HLslsU9mCnFogqs5yyVCRskHaLbXmX1dbvIfGjpXe3NiakL30ez/wmypYCd6utYG6NOaTFyMV/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHRWMCWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58003C4CEDD;
	Thu,  3 Apr 2025 00:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639134;
	bh=yYEUFJvayMaVPcBXwisOfoqVVEHY86bh8nXTTcnjJmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pHRWMCWlMO079XLLQKc5yt8SbGUf1lHKZpqeRoC8wM5t2vv/+VziHknmgebCyLl3b
	 gEqr0DJiN2vTT4ndKV+zfjEKErP/xYlIJhEgU0pWN6tBWc3RmsBS5fPhhEbqqpDjDF
	 tzI7IUw9j3xicavOEhAHYDSYUtG42cE0tlYnjY/9Z49ziGC4x1fJzCtcBNjpmP/f1T
	 0DPe3a2YM3g8TRuR51slTER55fG8fQs+AQQtHayUWuX1kI20BoYxpE3q4mLluiRr5w
	 UOYpQqRpbNY0/JLh+7NjhC2FBIWjyQXf72J1P1KpTPzRWZUfPT0IdPGjD9Syz7wfao
	 tFgbQ8I6iiD7w==
Date: Wed, 2 Apr 2025 17:12:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v5 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP
Message-ID: <20250402171213.10f809d6@kernel.org>
In-Reply-To: <20250402170220.4619a783@kernel.org>
References: <20250401163452.622454-1-sdf@fomichev.me>
	<20250401163452.622454-3-sdf@fomichev.me>
	<20250402170220.4619a783@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 17:02:20 -0700 Jakub Kicinski wrote:
> Is there a reason we don't hold the instance lock over
> unlist_netdevice() in unregister_netdevice_many_notify()
> but we do here? We need a separate fix for that..

I deleted too much here. I meant to say that we need a fix
for netns changing while netdev_get_by_index_lock() is
grabbing the device.

> but this series is big enough already. Unless there's
> a reason I think we should be consistent and not lock
> over the listing?

