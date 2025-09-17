Return-Path: <netdev+bounces-223965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58925B7C8A4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB5C3A517C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8B28315D;
	Wed, 17 Sep 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KfJ5e/O/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FFB27990A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106039; cv=none; b=LqGdyZ+YK9ImRL61R2L/WbpKdkqa63RZPgk7SWPJ7t7nOOTB8dy3ZjEzecN5uZbWefi6zkBZrz1jGe+iUiKb+JOft9dfNAMApGMJXQuclgQzsJPoUvKK5NiEgyFtQRykCGDJwJ8BhAJA04MyDZwx98BbZE5q8XFKHpGDnXDQB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106039; c=relaxed/simple;
	bh=VRLwGUcuRKvY24Qe4T2v4d9v5n56AV4gdzIOLjHFicE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWDlfRFUaAEv72h/WD+BIuAwXPoLUobGCqeJKjpeBCdm3Sy49A00CRP/0hMttycGjmQbv7I98pbjELaAwcgAy+WB8uvroXQ7psbZgmoVB/N58w8Xb5ZEJSuIwnKCtCqvHplesrRPOlB631Vle8ZR9x7DxDe4BaMy2P2i6U/bbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KfJ5e/O/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8994414a-07f3-425f-8b76-5d433ff4716f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758106034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXvN9zguKxTNFj65lLAAK90IdwxrcqN9SiKarg0zXno=;
	b=KfJ5e/O/KhKd96q2i3CAATfQT+IfK9EVuUHgX0Z5dZ481iRGJUY44exufBYubXLTvzBiNh
	l5d4JlA78FXiKiXE/mCPN59mc3sKv5AfBv5LoHluHdhxobYquAyXEbpVVYn4l5+z4YFuXM
	dJ2MC06zispZ469q84bmL7MfxZ2fB7c=
Date: Wed, 17 Sep 2025 11:47:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/2] ptp: rework ptp_clock_unregister() to
 disable events
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>,
 imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
 Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Yangbo Lu <yangbo.lu@nxp.com>
References: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
 <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/09/2025 22:36, Russell King (Oracle) wrote:
> The ordering of ptp_clock_unregister() is not ideal, as the chardev
> remains published while state is being torn down, which means userspace
> can race with the kernel teardown. There is also no cleanup of enabled
> pin settings nor of the internal PPS event, which means enabled events
> can still forward into the core, dereferencing a free'd pointer.
> 
> Rework the ordering of cleanup in ptp_clock_unregister() so that we
> unpublish the posix clock (and user chardev), disable any pins that
> have EXTTS events enabled, disable the PPS event, and then clean up
> the aux work and PPS source.
> 
> This avoids potential use-after-free and races in PTP clock driver
> teardown.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Now LGTM, shouldn't break our use-case, thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

