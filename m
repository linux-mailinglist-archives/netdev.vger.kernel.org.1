Return-Path: <netdev+bounces-192409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780AABFC93
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8581B683D2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71809289820;
	Wed, 21 May 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unpLTJ8X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE812E5D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850342; cv=none; b=sdBmBkhZUYyoHK/mJlHe5IiPDsYyJS2/VCkscz+eGO9lXvg1euqhET5MZCyzuk9f99qU44nWXYjZW1MFKHQ1L9l4G3wbJHKQA1h+V8BDEzlSEdDCWaYcS1PVO7Ju9E06+OEq24Ai5LsRu4w9lA1TUag9r4ZQncZuu/TXnzdfIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850342; c=relaxed/simple;
	bh=DpZwlLiToSgP9UvVjo312MLp7OeeAiuTw+KE77HGMKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTi8ohgE2sotQSjknT/TG3DX2OJRmTYNhTCK9coLyDDkUmVzDeVAwyJWgCYhCnNJjZzL9fM/eVCB76XK7yHLtih8ls2AiGKReLhQbm1FYZhH03ATqIxdz5lEikm0wJ44n/rqhr3+5xb7PQ0ljS3MqDaFk3+LjmNEaYP0Z0GZJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unpLTJ8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DE2C4CEE4;
	Wed, 21 May 2025 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747850341;
	bh=DpZwlLiToSgP9UvVjo312MLp7OeeAiuTw+KE77HGMKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=unpLTJ8XMfcI4nGGsThKNl9iRci5vPjSXhV//S4asNrz7Xp69Er+QMNi35k76iozw
	 of/NnJrYZoB5jLQTveq0dvbxDxD2R0dlMH3RN7O7u/smwXrVaoG18z/bQ1jai6jjo/
	 /McFvC4Ic/974s05qtwu3jEonCXvX8EAtzHKuWWSALYjT6jTG213xDs4aPMUHuyyIl
	 FEia6IjD1Fc95/pfKwRTkYyK10Laz6KbNE7GnZy8HppplMbDLtg1BDh9bwx8ce3PO6
	 JU51kDgAydtM1WTihb12odjbh1ZcIysu0ARuYLc/6ff3rUg8izSIZgfUfJYiM6NoWh
	 9Jn9YYrxto84A==
Date: Wed, 21 May 2025 10:59:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Hillf Danton
 <hdanton@sina.com>, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH (EXPERIMENTAL)] team: replace term lock with rtnl lock
Message-ID: <20250521105900.3111b6c1@kernel.org>
In-Reply-To: <9a12cdc9-1332-4ae5-8639-c71c91336b99@I-love.SAKURA.ne.jp>
References: <ff1d684a-22ec-4ea2-a6ee-fe9704a6f284@I-love.SAKURA.ne.jp>
	<20250517080948.3c20db08@kernel.org>
	<9a12cdc9-1332-4ae5-8639-c71c91336b99@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 22:54:51 +0900 Tetsuo Handa wrote:
> On 2025/05/18 0:09, Jakub Kicinski wrote:
> > I think this was a trylock because there are places we try to cancel
> > this work while already holding the lock.  
> 
> I checked rtnl_unlock(), and it seems to me that rtnl_unlock() calls mutex_unlock() before
> doing operations that might sleep. Then, rtnl_unlock() itself won't increase possibility of
> rtnl_trylock() failure...

I don't think you understood my comment :(

