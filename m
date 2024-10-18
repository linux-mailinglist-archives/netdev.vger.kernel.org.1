Return-Path: <netdev+bounces-137090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF439A458F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C1E283939
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E032040AF;
	Fri, 18 Oct 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4XpRXC1N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9A20262E;
	Fri, 18 Oct 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275147; cv=none; b=qePu0rHerRAAhYsbdLs1BJwVKBfB9vWQG+CiX4f08EQeb58UAn8gV/JhRP/gLj8UsWT1S1CMonuh0fP2nrTJggipu0z2vuO9P1XTYq3bMOgJJef1tE5IIQRl4XUlWgcrwQIkTBiXdrZU5i6BudPtGSo7KU5wQ9N3jAZ1wsfYHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275147; c=relaxed/simple;
	bh=QrqxmWXjgCY3Our3PWK8IKvc4IHCIt6vhJs/zCEhTNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdu6QXLL5BQvF8CQvrw0jybBm0S8IN4KWx79J73QDb86AJh0MAo7vco8XjkFhdepyp4ufMXKtoywKAgIV8CNM5QRbIXje4HuKq5voMQGIrx5IgoH23hQVy0ySHQnJxak2MoyPvRbxJXS/sckTMZTVWSNnynmKrsu+aR6FyoM2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4XpRXC1N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rBbNs22uQervbwsUW0laACDJM6LC5rVXIqgu0VnFg1I=; b=4XpRXC1NF2Ox4BEDGsO6IEWoAq
	grScfco3CXGZ7Wk7NoSiytQxlILPdf8dzlHeVEi2Uh64VmrgtxTsLaWowoHNS0bZ345QqJtxCiyX5
	Q5xE5vRs05AB3KvgEvAKj3hxKqArajqJRfHfX9M6Ve7caqiVT3mrKz8YInLiXYlpRY5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1rSY-00AYYG-95; Fri, 18 Oct 2024 20:12:22 +0200
Date: Fri, 18 Oct 2024 20:12:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	johan@kernel.org
Subject: Re: [PATCH 1/2] [net,v3] net: wwan: t7xx: add
 PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Message-ID: <118ae5ef-6c6c-4e9f-80f6-9ccbced4a397@lunn.ch>
References: <20241018074841.23546-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018074841.23546-1-wojackbb@gmail.com>

On Fri, Oct 18, 2024 at 03:48:41PM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of Dell DW5933e,
> Add a new auto suspend time for Dell DW5933e.
> 
> The Tests uses a small script to loop through the power_state
> of Dell DW5933e.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> * If Auto suspend is 20 seconds,
>   test script show power_state have 5% of the time was in D3 state
>   when host don't have data packet transmission.
> 
> * Changed auto suspend time to 5 seconds,
>   test script show power_state have 50% of the time was in D3 state
>   when host don't have data packet transmission.

Only patch [1/2] made it to the list.

And you still have not explained why it is special.

    Andrew

---
pw-bot: cr

