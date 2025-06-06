Return-Path: <netdev+bounces-195348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EAACFAD0
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 03:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8B73AF9A6
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7BF3B2A0;
	Fri,  6 Jun 2025 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDiBNQFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CC2BD1B;
	Fri,  6 Jun 2025 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174221; cv=none; b=dKL0HU8nA5u8Ay4ZEUwIG00jcqxHY98F8IJO3SDDyXLJs1IcgOxZgwRvP2cxOOttG6wbyjLm6kD/CuotY/3WUQkY1OQwdS3TX3RozDCK+JrpJ3CMdlcLuS3QxhwrmavoYVXRBvyF+6RqpyIs1EkOm3mSh3E5gJM+CkY/OjEDhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174221; c=relaxed/simple;
	bh=WHD4PuJMG/otH7gj9OW8gaFkbv8GJd+ZMOtkEz6VlI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPxulKgK7FXfACyUs4/SV75M4vwsw+mZpXbnyL854hKKrM8Ix0OV7frHmICXmeTWnZMADQWAf/rirybF5OCpXOtpVpNFqwclAx/hcs3MskzmHmkDAoGT4Et8U4TuiuLG92hf4SJHv4xld8BtLR3mNzgwKyISq14YvAs9O1VyVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDiBNQFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25719C4CEE7;
	Fri,  6 Jun 2025 01:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749174220;
	bh=WHD4PuJMG/otH7gj9OW8gaFkbv8GJd+ZMOtkEz6VlI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDiBNQFwPOJSHFPrrahSQhMOzBG9hBiS/dxK00kJTNqTOE3QOaOhTkOY9DfSBh6bX
	 ZCgWdmJM1YbRTIOlNFme98LasmYt/0R811/ItDw1NgUZB68+boR2uhQ6IoHqbukGzH
	 UVwmM0lNPIPhNcbSDRMXkQL/OAGg8NK88yWk7z3UAArRUhLYtvL9VTs7eLDihalUlv
	 kY3Gtd7+0Kbqnnk2O3sYzbsQWEbKVSn1OD/M9KQYUH/zp7UVKIl+8hBpnPv0Evcxbr
	 kxsL7dMK+XVSabsh1I6QnVHfrXdeEtQFCOuYwSmpHfJDE0AatbjLmiZekYjJkztQAJ
	 5UoDPBEOgJbUQ==
Date: Thu, 5 Jun 2025 18:43:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: horms@kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 brian.ruley@gehealthcare.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] igb: Fix watchdog_task race with shutdown
Message-ID: <20250605184339.7a4e0f96@kernel.org>
In-Reply-To: <20250603080949.1681-1-ian.ray@gehealthcare.com>
References: <20250603080949.1681-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Jun 2025 11:09:49 +0300 Ian Ray wrote:
>  	set_bit(__IGB_DOWN, &adapter->state);
> +	timer_delete_sync(&adapter->watchdog_timer);
> +	timer_delete_sync(&adapter->phy_info_timer);
> +
> +	cancel_work_sync(&adapter->watchdog_task);

This doesn't look very race-proof as watchdog_task
can schedule the timer as its last operation?

