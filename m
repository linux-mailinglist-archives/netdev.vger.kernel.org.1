Return-Path: <netdev+bounces-163309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D79A29E4B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E443188856D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434821F957;
	Thu,  6 Feb 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB/2frjP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65F748F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805195; cv=none; b=erejHAQO8eQN0Zmz+oJhzQ0Vv8//79cqa7YdXuzqxdYzQQtxDrW9fMoNl4zOYQnnuklHEPOH7TUhT+NHHVDiXXOjM0/xyZDxLSNFTUzbhTUegSPrJVHZCTf+a1Zze3uxjBVWpncKi9CYrsuppGTNnUZCeNM8mZGIaBF+VSK5i+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805195; c=relaxed/simple;
	bh=tQwxxSKakncVAfPrXx3Qgg9QynuH2PZ5e1SWt+w6mvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXIsAYy5BUjYMbtXpd0IHlLQrMdj2mffJJkQhZzQ5giVXhnQix/DEoXlpfhjFRGsPaSc/TK8PYxzdr5ae+hz0wKYPbiN5qbcb9+vIQ5E81oMutU/2SyEqfR5br+kJ3zJtuFqkHyr5TwIFGWDi1QzfhB5QhYkj4nR59EwErGJlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB/2frjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B571C4CED1;
	Thu,  6 Feb 2025 01:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738805193;
	bh=tQwxxSKakncVAfPrXx3Qgg9QynuH2PZ5e1SWt+w6mvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gB/2frjPb8QM2lT6dQTAQ8CgF2vCvW6X1ysDuo/1PST8GlSYZ3mXXWFtWoBE/uBdN
	 qaKOU1BTghnsGPxkk4uMw0Dcei1M2kwjIaDDvd9hb+ZlfGElcF2gAY29MdIjojlUFU
	 UQbzX1KAzF48tqCV1uQ4swE1YVNMAmA+90LkareyxdnMJMHBFNhVTdZtI6Mpy8rFiN
	 vskYb/GuTw9gjNoYifgfNZ5zcCTu8foQ4qDtK1znYTFeuo8nFW0Z6BFE+bMCOOcOol
	 71oMJHayn7YXFqoMDRU+VKZvPWdi+J8X/TGHed7FRZ5SuteATsBHteTdTV+GBlyIWP
	 tyZiHZne622zg==
Date: Wed, 5 Feb 2025 17:26:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 2/3] net: devmem: don't call queue stop / start
 when the interface is down
Message-ID: <20250205172632.61f41a06@kernel.org>
In-Reply-To: <CAHS8izNgVd_bPDCiFD5mN=TgkcaKmQK1RcLgw_051GRHcLXHvw@mail.gmail.com>
References: <20250205190131.564456-1-kuba@kernel.org>
	<20250205190131.564456-3-kuba@kernel.org>
	<CAHS8izNgVd_bPDCiFD5mN=TgkcaKmQK1RcLgw_051GRHcLXHvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 12:35:30 -0800 Mina Almasry wrote:
> Why not return an error if !netif_running(), and change the call site
> in net_devmem_unbind_dmabuf() to not call into this if
> !netif_running()? Is that a bit cleaner? It feels a bit weird to have
> netdev_rx_queue_restart() do a bunch of allocations and driver calls
> unnecessarily when it's really not going to do anything, no?

The bindings survive ifdown, right? So presumably they exist while 
the device is down. If they exist while the device is down, why can
they not be created? Feels inconsistent.

