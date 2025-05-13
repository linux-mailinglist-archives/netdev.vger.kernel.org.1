Return-Path: <netdev+bounces-190221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B20AB5A6C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E06865EF3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F812C0331;
	Tue, 13 May 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v5dm0lD1"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D12BF977
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154429; cv=none; b=RirPVQQjjH7TGxfAjpx7EHdgB/0MFHpbs8YAJzF9jToxO/JzlZcy2BEqFPI1uaF4ITEjai94imSdn9BLNun2UhTABBCPbiLYITlqLiHuOlF7HyA6NMqr31jq41D7JGWufLBG6KepxAh5YFKBYk4K3BBNoNNUKiJlRqqcVHS9OQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154429; c=relaxed/simple;
	bh=ZTvOfyt27ngXKsIHWQ1g0X5LM2B8iC/5VO98mqpFpBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+aziJtL3whodXnjSPUzsRGnwGe/c8grkQe+5KSwdbydaTtDV/Wh1hzmg/F4O6e81aFiJyY76C2+StXkwZAjZ1ciRFV1ft49Ze3aWNKPhYBKLeAcLyAI2NZh1yZw2Wyg/sCvp6R6B/vEj9wQwax+4+JtXsbTkBXhfbBrgpb+9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v5dm0lD1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <964d667a-c17e-47ff-b7d8-fb5b5a2f1eef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747154415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pd8a86ouCHKkC4nVa+pxW5IeRMYr8wsSfrdSRatPCY=;
	b=v5dm0lD1mmwG9XVDa+coeBFMQiCdVvbRDgihk9r4mx4Xi132k7MmF8jV5Yx3H79h6jAyPM
	PFclKaNv4y/EYlD0fe02SvWUj0QquI4WwSMmdTGkkBeYo9qB6cc9t0KCoutqdL9oTi9DBD
	tZu8+JQ0KoAmsBPlqbVYVeT3IBvKlD4=
Date: Tue, 13 May 2025 12:40:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 09/11] net: macb: Move most of mac_config to
 mac_prepare
To: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, linux-kernel@vger.kernel.org,
 Christian Marangi <ansuelsmth@gmail.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161416.732239-1-sean.anderson@linux.dev>
 <6a8f1a28-29c0-4a8b-b3c2-d746a3b57950@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <6a8f1a28-29c0-4a8b-b3c2-d746a3b57950@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/13/25 11:29, Karumanchi, Vineeth wrote:
> Hi Sean,
> 
> Sorry for the delayed response.
> 
> We are working on MACB with two internal PCS's (10G-BASER, 1000-BASEX) supporting 1G, 2.5G, 5G, and 10G with AN disabled.
> 
> I have sent an initial RFC : https://lore.kernel.org/netdev/20241009053946.3198805-1-vineeth.karumanchi@amd.com/
> 
> Currently, we are working on integrating the MAC in fixed-link and phy-mode.

I had a look your series and based on the feedback you got I think this
patch will help you ensure the PCS changes stay separate from the MAC
stuff. I found it confusing on first read that you were configuring the
"1G" PCS from the USX PCS callback. I think you are using 1G/2G speeds
with the "1G" PCS and 5G/10G speeds with the USX PCS?

Do you know if there is any public documentation for 10G support
(even on non-versal SoCs)? That will make it easier to review your
patch.

--Sean

