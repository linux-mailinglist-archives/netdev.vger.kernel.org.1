Return-Path: <netdev+bounces-109220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45E927734
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57267B226C8
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471751AC240;
	Thu,  4 Jul 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzf9K8ba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330B28373
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100007; cv=none; b=UQ2SLR9O8P3zRFEDSNxosXWB/Eoq8OtpU5bWwe5sfdVgDnZjis49Hq4wpM0dU5QNzQm7Nn1wQVPVqDPvporSW+uWs0VqwNvZSC7QuAJ6zFmx3Op5b1jVhuPvmwXYeKtiCBbq0JujGJkcse2JR+JQBpcQGg6rpO1jlWGaz6r7V50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100007; c=relaxed/simple;
	bh=onZyk67XC5dvCg0sQLsXUONTk2UG7LtK3OBlHdDPHRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJ0UNvsNnD/bm3ivdbgplwnigZOdNOc/xYNLEHT8eDjndKiPQBQBSVRmOowjUA6wJssBiwb40JlCj6pLOQOf+rPii8hHIbxbK5KT2/vYjUsi8NXuGwqYnyAT9eSnMvOPXUebEbu21kBKK0T5oeH2GkFKFNILbc2Oye516eOtP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzf9K8ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48661C3277B;
	Thu,  4 Jul 2024 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720100006;
	bh=onZyk67XC5dvCg0sQLsXUONTk2UG7LtK3OBlHdDPHRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uzf9K8ba26ZvRv1q020kMBLmpYCmtGwrhAAkdYkVlqO7kJ/iQCcI4ElctQfDB7Z92
	 5lBMcziDXuWEwHtJ++Xg0xFQ/ClBEuN5okYMfVrhwWBAS25RlJeXXaVmMezbZPwhd8
	 H8MClj5I/2vTe1KpYORTVO7K5FbQ8sBJkHmlYXypZELLRL8yFbEhy2vXHpCghRRWnW
	 et0iKKqGOgwhALqNXrNL6XfAC/tw8TDDBdGaMLG4KE+JulACm6IZ8I8d4CDYroga2g
	 XQHFyfTVQSmPd3csc9iwhrnw7U/TltLm9DOqd2xsrwd7VBQuI2FTISriBoq+eapxLO
	 azw26jWNWcggQ==
Date: Thu, 4 Jul 2024 06:33:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 michael.chan@broadcom.com, netdev@vger.kernel.org,
 somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
Subject: Re: [PATCH net-next] bnxt_en: fix kernel panic in queue api
 functions
Message-ID: <20240704063325.7ddd6e8a@kernel.org>
In-Reply-To: <20240704074153.1508825-1-ap420073@gmail.com>
References: <20240704074153.1508825-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jul 2024 07:41:53 +0000 Taehee Yoo wrote:
> bnxt_queue_{mem_alloc,start,stop} access bp->rx_ring array and this is
> initialized while an interface is being up.
> The rings are initialized as a number of channels.
> 
> The queue API functions access rx_ring without checking both null and
> ring size.
> So, if the queue API functions are called when interface status is down,
> they access an uninitialized rx_ring array.
> Also if the queue index parameter value is larger than a ring, it
> would also access an uninitialized rx_ring.

Shouldn't the core be checking against dev->real_num_rx_queues instead ?

