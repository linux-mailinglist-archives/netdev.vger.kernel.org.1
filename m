Return-Path: <netdev+bounces-211407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC14B188D0
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794917ABA77
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637B270ED7;
	Fri,  1 Aug 2025 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvv5V5v3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8128DB78
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084145; cv=none; b=nCCVZpC6YiHc54gAr7OjugrzziyrLqnLW/EIuic/6x03gIU2klEcMjvsDuiHeeej0cZNt8KTvJXOgTxeI9/JH1r9DL5PvhPcl5YPlL05WOFFwf5+P6VkKS32ESPYT45NgrW8UzbH102YOyJKa2oTYtwqbe/CqM3SY7GaZ3Xw04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084145; c=relaxed/simple;
	bh=pD025ITb988BlZDolJqj3imsbpfgRrVjkSaY4rZxmMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oriRjUFK+OIBPaIgAiOq0PYRdzzF3gcxMHq6H3JaeN7BaAp+zAoIZNH9CdLLj0S0g1doL1EV4yDXFh3KIZkmxPigRY5usfCeWk4MTdukR08hkqBiSgaWTCMRNttEwy1MlEtLl1M8Xs5BrCx5CCOFBKUxPLt9hgn2yODhqNEZjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvv5V5v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8D8C4CEF4;
	Fri,  1 Aug 2025 21:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084145;
	bh=pD025ITb988BlZDolJqj3imsbpfgRrVjkSaY4rZxmMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qvv5V5v3zyxWC/Y0/IhDW5ENQwd/HZqCUEtrqEsYHrQB8dafGCPMS6hAUI53WPzJM
	 dSCdnrdA54N/kn9nUyXZAv51kUh11x1SzvoXSNyk4nFiHxdrLp5I5WKQd/h9TsUsuJ
	 sy7MUddJFp3Iqk45HqCwSleYTszbtH7C/sJIidA6a72MBRtAjOejG8BfFYNcWJNQ5Q
	 B4dHLHWk5Y5JHrX60Dgphn5L3bG3J7R3D59K3l3bnHPs2njQv7PFahQNJvqV74oMQ1
	 I8u0BWOo5LayTJqV4SDEOJgr3X/rsjPC4xSRsX6JDFTkVmVlnMqhvyWuHwGCxkc7gQ
	 g1EapgUYiXusA==
Date: Fri, 1 Aug 2025 14:35:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 atenart@kernel.org, krishna.ku@flipkart.com
Subject: Re: [PATCH v7 net-next 0/2] net: Prevent RPS table overwrite of
 active flows
Message-ID: <20250801143543.43c6843c@kernel.org>
In-Reply-To: <20250729104109.1687418-1-krikku@gmail.com>
References: <20250729104109.1687418-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 16:11:07 +0530 Krishna Kumar wrote:
> v7: Improve readability of rps_flow_is_active() and remove some
>     unnecessary comments.

Thanks for dropping the comments. The 6.17 merge window is open now,
so we can't apply any patches. Please repost after Aug 11th.
-- 
pw-bot: defer

