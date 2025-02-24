Return-Path: <netdev+bounces-169199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC04A42ED6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE9816ED53
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF141D86E8;
	Mon, 24 Feb 2025 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r06LxFpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497131D6DB9
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431925; cv=none; b=ZMOIuwAN1T83BXfj9xvp1AwIPiu4ApbAhqNC5f2Zmg7klmPj8Tog/VbbkLxrSgFuDWFw5C0Ry58YKLY9BBugRMyh8JsDPLTy98tS4ldIe4slSBECnxGumt6n8XaubltWDU0666BkmioFiLlnAr0oNvidmxPJL3nq7nyxjG2EuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431925; c=relaxed/simple;
	bh=3EcKWlNLl1gHbLuiJReP3k+3EKQB91E9pGuFaGy+VZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzJdn0pQsThNANEBKMbrkD0pQ89Bli7uiVwfVX7CR5n8t/5eCVeaZTqq9SlLMTOwOGPAY/NH+1dvnf3QOQpNKeWGYMqRpgHab1TuBq+19qtOTPe68DVvUl9/Aefx/rjbw9gl+0kv1vyXJP4IoPEF2hujnY9KQuzts2PxNGTaGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r06LxFpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C32C4CED6;
	Mon, 24 Feb 2025 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740431924;
	bh=3EcKWlNLl1gHbLuiJReP3k+3EKQB91E9pGuFaGy+VZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r06LxFpPnm1sienapYgnUftrOmmcOPbFp8voDzqm3Ujx3dc/0pPBEeFgNQVf7IuWX
	 hw1sKpPhY8TxHZTg67bfZxUPvLCh5ePOwVkPfXCPLaGRYf12+Ab/N/1H11tC75+D2l
	 70EvE9SoLoEaG6PYb65PVAlUHgbYs7mH9mmJDD3WuiIrL84B0TrTcAUgCXDkpxCltC
	 nvFTZLpCiqEZKFcMPmyxXGT5Ay7FDK748zafAkaAAXQ9GMMk/7oNGjmH7yQxmNbnAI
	 QT1C3CBuEIw6rJ2+3k2NzjNvH6+yNh88qZ8//GGHu3gD65Vv86wG9plViaS7FJ1XTJ
	 Dzpf0z4Dk2wIA==
Date: Mon, 24 Feb 2025 13:18:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, benve@cisco.com, satishkh@cisco.com
Subject: Re: [PATCH net] enic: Avoid removing IPv6 address when updating
 rings size.
Message-ID: <20250224131843.4ef2307d@kernel.org>
In-Reply-To: <20250223214203.2159676-1-mheib@redhat.com>
References: <20250223214203.2159676-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Feb 2025 23:42:03 +0200 Mohammad Heib wrote:
> To avoid this behavior, this patch temporarily sets the interface config
> `keep_addr_on_down` to 1 before closing the device during the rings
> update, and restores the original value of `keep_addr_on_down` after
> updating the device rings, this will prevent the ipv6 stack from
> removing the current ipv6 addresses during the rings update.

Wrong direction, you should support reconfiguration natively 
in the driver. Pre-allocate all the resources for the new config
and swap it with the running one.
-- 
pw-bot: cr

