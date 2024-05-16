Return-Path: <netdev+bounces-96784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B578C7BBA
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2928102D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456A156864;
	Thu, 16 May 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VOjdr9Vb";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="kKT6QT4K"
X-Original-To: netdev@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50101EF12;
	Thu, 16 May 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882593; cv=none; b=mqFAkiML5AjbCcTiQvis6PzGjZx35tHy2i4A3g+DQZ1vzWC9DDH/BgBics6trMUhBEgBI4T+tQaExg0az0gUSnYq3EAXhnDDoxRP1foix5cOptEwpYfkD2SvKm13jAh4Ly532J2uur06AaX/Y0n8QAwXocHeKEhOdgq27AJpuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882593; c=relaxed/simple;
	bh=XJ0wq7P6oGLF/Wn9fqoUjoZ83n5V3K97kIES94DrOro=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kRODBWzQ6WkP+OXNG6sizA7L1BzOzDqIWqfWzYJEu+ix5YHtRjxQze2CyBlz1CF319xyC/k//O9NjXQxOlJFG0Nob9JnQ8UYXXYY7O5Zm85LMh/3RG2uY5uT+JLDgo9Lj6qgANkeRPUyDPuNhEYgBu/8k7QR/sQ9GVIJYdYSENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VOjdr9Vb; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=kKT6QT4K; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB39527021;
	Thu, 16 May 2024 14:03:02 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=XJ0wq7P6oGLF/Wn9fqoUjoZ83n5V3K97kIES94
	DrOro=; b=VOjdr9VbYqvAhJ1O1wr5RtgQWmrKG5y14NFIMLx2SWbJt8adLgVZAk
	S3KUinvn9IcpVeKYUmFJZSXEidYH5xTMtW55SJUnzhniNdbyv/p4hDrEWBS5NwMu
	pS5ElyQ1/3Ls0f0039ZXvxZY9hhGpnm9sUn9FIeyWYnBAz4JS0Nx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCCF727020;
	Thu, 16 May 2024 14:03:02 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=XJ0wq7P6oGLF/Wn9fqoUjoZ83n5V3K97kIES94DrOro=; b=kKT6QT4KePcP5IVss4cXNVmwc84T0rvzFBI5csD3UX3I3klIToJYmEK4zorZzLg7viXK/g/YEOfGVJwwToo7jExogWuyhxCTCCNPDEfxTSJccvxS2BU5hJjH6QiXYyh6dXrS30vm42B7CPdDyw6nkOOfIKXrnr4qD5cZk9Cj5nQ=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3607A2701C;
	Thu, 16 May 2024 14:03:02 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 17546CAFE2C;
	Thu, 16 May 2024 14:03:01 -0400 (EDT)
Date: Thu, 16 May 2024 14:03:00 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Lunn <andrew@lunn.ch>
cc: Thorsten Blum <thorsten.blum@toblux.com>, Arnd Bergmann <arnd@arndb.de>, 
    davem@davemloft.net, edumazet@google.com, glaubitz@physik.fu-berlin.de, 
    kuba@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, 
    netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: smc91x: Fix pointer types
In-Reply-To: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
Message-ID: <811pn38n-n071-6qsn-50qr-096048q07o40@syhkavp.arg>
References: <AEF82223-BB2B-4AF0-9732-0F2F605AAEC2@toblux.com> <20240516155610.191612-3-thorsten.blum@toblux.com> <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 8969512C-13AE-11EF-BFA2-78DCEB2EC81B-78420484!pb-smtp1.pobox.com

On Thu, 16 May 2024, Andrew Lunn wrote:

> You could add a follow up patch which removes the 
> void __iomem *__ioaddr = ioaddr; lines and uses lp->base.
> The code will then be more uniform.

Beware, It is sometimes overridden with __ioaddr = lp->datacs.


Nicolas

