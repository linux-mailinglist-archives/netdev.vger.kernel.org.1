Return-Path: <netdev+bounces-214108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C97B284C7
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8672AC6162
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55E30FF0E;
	Fri, 15 Aug 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gClLHy7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AB30FF0C
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277979; cv=none; b=tUsc2H5pZg3aL9vF5XaPOaZ0HufB6hHU7Q/pSoWMKC5e6ose+7ENmffg5bkT2ZbaHtjCzM9deWHnFs6Mjo1bgga7JuKv+nRxqgUSTClAzwz2Gk+D7Tc9FiHIoxTN++j+ZjPm8O4JsoxOr8xl2qahnE0D/JGSJq7fJGltDXzHU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277979; c=relaxed/simple;
	bh=eHDv5Vmq+l8bLS8wfLXZBcj/cD9Byz9OqCLZk2xn0fE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+Z2wTSgbQOWPfb3U6VENEDRcUQxPiuwsLSfMHkhhRzS2SZqDkrfoIL3aM7LGTZw7Q98dyHBStzYMzWeMc9mQQc0RE2DznfF/t7NspxhPbUa7ye6yNVj74tyguRa7xeLbW8sFy6T1rt749D9RW/kdwFb/X8zp7xW6LE/ivlpD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gClLHy7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B68C4CEEB;
	Fri, 15 Aug 2025 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277979;
	bh=eHDv5Vmq+l8bLS8wfLXZBcj/cD9Byz9OqCLZk2xn0fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gClLHy7bslGKQAwscbEb2yHkl97+sNTovRSvohsjEP8vU4Q001f7zA7qpkzci4ZWr
	 CNWTd/uu1kjZ+k39DBxCTsyXikSPLEfCGG8oa3nRmThEjGDD1kq9mTLaaoHgf7S6bY
	 czb6g8LfJvZNLJ9cEdArM7cbzbdqRM2fwY8ItXzwU9jKrUil2T6/esl+F4vCH+ZAvT
	 dyXTO+t8O8g0zc9OcSQe/pqwXIV+/Hxh4UnyHiTpB2CujasuAnVcNO9R4ukQqPjRVk
	 /0R+K1Bme/oNXXoXfYECL7D6j2NTANNRPXH3cWOLGZB1bxi/8L6LXCYFNzvPca3EK4
	 RXr+EzS+ROgXw==
Date: Fri, 15 Aug 2025 10:12:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, sdf@fomichev.me
Subject: Re: [PATCH net] bnxt_en: Fix lockdep warning during rmmod
Message-ID: <20250815101258.37cb17b1@kernel.org>
In-Reply-To: <20250815170823.4062508-1-michael.chan@broadcom.com>
References: <20250815170823.4062508-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 10:08:23 -0700 Michael Chan wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 2800a90fba1f..a208c2a73cd6 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5332,7 +5332,8 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
>  {
>  	int i;
>  
> -	netdev_assert_locked(bp->dev);
> +	if (bp->dev->reg_state == NETREG_REGISTERED)
> +		netdev_assert_locked(bp->dev);
>  
>  	/* Under netdev instance lock and all our NAPIs have been disabled.
>  	 * It's safe to delete the hash table.

netdev_assert_locked_or_invisible()
-- 
pw-bot: cr

