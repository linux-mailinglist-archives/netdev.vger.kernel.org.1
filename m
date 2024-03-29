Return-Path: <netdev+bounces-83471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAE189268D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 23:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED721C2134D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E913CFAD;
	Fri, 29 Mar 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDD13CF9A;
	Fri, 29 Mar 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749678; cv=none; b=TOauJdfJGKU0duUd8J4pHoHhAwsXcDn6HiMRRbIxMC8w4F8N/R6CuN8UW0dSXad7zTr71uirgCxvjz3p8yWCCy8Lua4blaGweObu3zF4POrf+k9u15OLletc265FFN5y6QWVgkTghnrO2lA7BPEgSHApf/YoTu1URgNAYZ6V86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749678; c=relaxed/simple;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0voKxc3wu4aN9dqdlqCvCcRErWY477ia2U3s+zapOl4w1ETHJYUStVobjEYNexg0unHlP7Tb6mRFUmIC7L9k9Abt8vOwswUXlovEv/RYRNqCZh58Etm9FyIYE6rOXh15uvgsy9g+fHu21flV2ooGENu10WR0Qfm9Eo1N8RV3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53666C433C7;
	Fri, 29 Mar 2024 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749677;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCDVp1+6GYWN8GFmGWMO5xXfiuZa6bY/GlLwKiqaSa1TLzIxcYJihxRE0e5VLztHR
	 5zX4huDJPpeCfgrjlALPODEyY9ok6t6XZyC94u9P4uGbsdD+Vf7/goAP4qAxHkI24l
	 Vp+Ec9ugCQi0u85nWx6u6+59B7MSXHvK7H7/fZ+H3lv3tvBPDnMR4RgmsEhvVyxon1
	 xplQn51eQjcegvhK7Sath6j4gOuf2pbrolfo17ILhabO8CfloJKPB+aXedyLdVRpG7
	 sAjIkjQeyiL63kut8QYGl9CThsDY1mDSdXu6r8nXPwWsINSIlXd0gVG41OCygsqiwZ
	 FdtrYL4sDV2IA==
Date: Fri, 29 Mar 2024 15:01:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpts: Enable
 PTP RX HW timestamp using CPTS FIFO
Message-ID: <20240329150116.67da2b07@kernel.org>
In-Reply-To: <20240327054234.1906957-1-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 11:12:32 +0530 Chintan Vankar wrote:
> CPTS module supports capturing timestamp for every packet it receives,
> add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
> of received packets from CPTS FIFO.
> 
> Add another function named "am65_cpts_rx_timestamp()" which internally
> calls "am65_cpts_find_rx_ts()" function and timestamps the received
> PTP packets.

Maybe i'm unusually tied today but reading this patch without reading
the next one makes no sense. I mean, you say:

  CPTS module supports capturing timestamp for every packet it
  receives...

How is that relevant here.

When you post v5 please make sure to include a cover letter, explaining
the overall goal and impact of the series.

> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);

list_move() ?
-- 
pw-bot: cr

