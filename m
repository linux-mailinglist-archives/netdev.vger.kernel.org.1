Return-Path: <netdev+bounces-246345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A6CE97D0
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FC4C3004636
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF82C21D8;
	Tue, 30 Dec 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QinhXco5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB1258CE7;
	Tue, 30 Dec 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092366; cv=none; b=SiBiw670IOww+jLBNOPkANyFnhgD7hlz4eGzPWdN+1f2Szi3Qaxj7fSH6gOtONSBqjOGIO2Dz0AsMPMgcj7gIjBu1C/CgCb47ahUDtNDrUHmEkXLG/Yq/xRPOXdW2a0Tt7wcDCaxHtamJFyWdJDjUTwSSD0+VGMFWUgGNNrO2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092366; c=relaxed/simple;
	bh=mBNgiCsbSbLba8pgrZ5acucYZsdOjD//Gs2x4d979GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmRPuyq8zQk+HlJbrHWjzonLhoFHYaZfZrv0sbHKGaRxFOSvCq6Pn4jmagT+6wJNPCnNuXVRdcrxH3srWP8T3Spgql5bKrvlucxGFZ2YYcG3YLrJ8nVRvZILX9UOWEbs1ZQANqueLKmT1sCsAQu9XF9pgs7v9nrV+P/JsnLy6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QinhXco5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=r0vlyfz/7Q1MBhaTGNvzPIw3XYgI9bG2JOqdkDlVXgI=; b=Qi
	nhXco5D336dMtk5sAqrN9pufIFwKYkDk6LVT8RsEPbiRegS3L/2/ETwHfmFBrNWU5C1xWqr5QOKKt
	LbGdFABk4p0tIAAStW2QDEHx0DQsiwPe6meJyFSoXuVQJYT5ZpmPIzSUokhaI7JjxAVnqV8DLxakn
	xC7hdu7BZ14WS7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vaXRc-000rfD-3B; Tue, 30 Dec 2025 11:59:16 +0100
Date: Tue, 30 Dec 2025 11:59:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: TINSAE TADESSE GUTEMA <tinsaetadesse2015@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix PTP driver warnings by removing settime64 check
Message-ID: <67fb6d48-148f-49c7-86aa-4f4244ec6f31@lunn.ch>
References: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
 <f04e466b-8b8b-466e-a67c-d7fbfea2fbfd@linux.dev>
 <CAJ12PfM3zkJCJLJ3dLtvab2t9O9Dqs8MnoEo=zDb5OcyAPDuJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ12PfM3zkJCJLJ3dLtvab2t9O9Dqs8MnoEo=zDb5OcyAPDuJQ@mail.gmail.com>

> This patch resolves warnings triggered when either gettimex64 or settime64 are
> NULL.
> The CONFIG_PTP_1588_CLOCK=y option enables PTP support for all Ethernet
> devices.
> In systems with Intel-based network devices, both the iwlwifi and e1000e
> modules attempt to register clocks, resulting in calls to ptp_clock_register in
> drivers/ptp/ptp_clock.c that produce warnings if any function pointers are
> uninitialized. 
> 
> Without this patch, the following warning is logged during registration:
> 
>     info->n_alarm > PTP_MAX_ALARMS || (!info->gettimex64 && !info->gettime64) |
>     | !info->settime64
>     WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x54/0xb70, CPU#
>     2: NetworkManager/1102
>     ...
>     iwlwifi 0000:00:14.3: Failed to register PHC clock (-22)

It seems this patch is no longer needed. But FYI, this explanation
should of been in the commit message. The commit message should
explain why a change is needed.


    Andrew

---
pw-bot: cr

