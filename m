Return-Path: <netdev+bounces-219754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0D7B42DDA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530DF20748F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649594C6D;
	Thu,  4 Sep 2025 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxmwXSyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE01C69D;
	Thu,  4 Sep 2025 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944360; cv=none; b=poEBPutfEayMVIPFdea0xdlDL1z8YeQLEDDIoyXBGhopBACb3agbc/6NFCgw00O+5gB0GfNtEGpNFiQmOD1HRTXJ+mWWjWAxrP5G6ewlYIXeDfPw4DwFmT9i6R6gi1UPctdLSZgVO4Rlg7WDLAOwYNSr7BSNpH40m7e6QX2SvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944360; c=relaxed/simple;
	bh=RH+zEJf4Udc0SqAQI1FgDf2xae7Uq2AAUlBFAzJY08E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uICOa7wrjRrXqQvMrbG89Nm2S8LjXjsuKnQytqIMu+m07bDPtcnRDLebFCxqpOV7/UoxhAGfDrQkLXvl7s9eprZ+NBHfMPDVFCl963jHrAHkMXhZ7onMUT+hE6hK4bSIRpUGUL3zKYvIEHZns3gWz8fo5leQIf518crdMHbUk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxmwXSyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5155FC4CEE7;
	Thu,  4 Sep 2025 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756944359;
	bh=RH+zEJf4Udc0SqAQI1FgDf2xae7Uq2AAUlBFAzJY08E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TxmwXSywtfl+uj24I0Fpqx0GhLgqLoRdsZXpXj0AfVDGo4h/xx7aYkpeflM2Agvdl
	 4L73LhuxDcreW1MMzbacv7I56hsYSEz0fOjkpJPaP4xBJfWLu4X6ZzwmmOkRjYCixK
	 rVZHOKDsWm3hLJ6OgBwqyvUaULh3YVgkQbG+PUpPuhlt9SUgsr7po/Rr6gw4TYYQXQ
	 NRgB0Fsk2Ep2wRXThkuEYZwHpNTF12trfhk4WD3mcaV3P5R7kdLeYTfnHRfPF2K42P
	 jK3oKZVgLiNyHzJybXYHQ8vI1Qzv2uLzxZ7p4fK2JyLioNcKmuhUIut42oMkils/Wj
	 CV8uPAP6QNE3w==
Date: Wed, 3 Sep 2025 17:05:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>,
 <vladimir.oltean@nxp.com>, <viro@zeniv.linux.org.uk>,
 <quentin.schulz@bootlin.com>, <atenart@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] phy: mscc: Stop taking ts_lock for tx_queue and
 use its own lock
Message-ID: <20250903170558.73054e68@kernel.org>
In-Reply-To: <20250902121259.3257536-1-horatiu.vultur@microchip.com>
References: <20250902121259.3257536-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 14:12:59 +0200 Horatiu Vultur wrote:
> -	len = skb_queue_len(&ptp->tx_queue);
> +	len = skb_queue_len_lockless(&ptp->tx_queue);
>  	if (len < 1)
>  		return;
>  
>  	while (len--) {
> -		skb = __skb_dequeue(&ptp->tx_queue);
> +		skb = skb_dequeue(&ptp->tx_queue);
>  		if (!skb)
>  			return;

Isn't checking len completely unnecessary? skb_dequeue() will return
null if the list is empty, which you are already handling.
-- 
pw-bot: cr

