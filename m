Return-Path: <netdev+bounces-180339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F4A8104E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7078822DE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9622B8DB;
	Tue,  8 Apr 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xHjiYEdg"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC11A8407;
	Tue,  8 Apr 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126269; cv=none; b=B48K3JxE5ZAvA8Z9d6igBTrFdgyYa74v+85XnNSpwzAGens4b2sHW05TlMq8d1IoOLODPSnn58WxexXRQs6Q+gflxtNVsje3D92A7INfqKkuag2GZBKyTw94CLVWb5O1LWCaX41GiRvCAwnOVLj5iKmopfSma1E4ghAl0KYNzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126269; c=relaxed/simple;
	bh=0YFuHjXItMALCF9I61SplNMuKtnWRp5UV2h38diSEak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuxTuH7WqCJ4CX9Vz+hoAby8IsV+BnXYkJ6J9ftCepnsFeonNCe+Rs2Pv6a8Qe0icOC2wtbR5ZGmJZ4lKoIjwVDBX5bvTClpyldhtEqmodwyy7ggEDWeD0LOzsdSl4zheXAo0H5bZgodrF5/rKTxMoa3VhQP/a9V8RIyK3WsaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xHjiYEdg; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08c0e1eb-2de6-45bf-95a4-e817008209ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744126252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BoOWeNe+pe93MVOTNw72S8eDhTJzWNGVCLyplYdrjU=;
	b=xHjiYEdgV7tMnhbjUS9rxzHVYtisqRgofwAbFgKBjHeCW/w+sALVnUMiySoFUarrOrSbJp
	Ecqv/CNdAQM8aUz/+aPqTRou80iDO+z9ZzmUuIVt85PyF9sLMmnGUY26Em+RgqaMhsISwv
	mClV4f4j7VSPhAIpytBuD78aAgb4MhI=
Date: Tue, 8 Apr 2025 11:30:43 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v2 00/14] Add PCS core support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Joyce Ooi <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>,
 Saravana Kannan <saravanak@google.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250408075047.69d031a9@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250408075047.69d031a9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 10:50, Jakub Kicinski wrote:
> On Mon,  7 Apr 2025 19:17:31 -0400 Sean Anderson wrote:
>> This series depends on [1,2], and they have been included at the
>> beginning so CI will run. However, I expect them to be reviewed/applied
>> outside the net-next tree.
> 
> These appear to break the build:
> 
> drivers/acpi/property.c:1669:39: error: initialization of ‘int (*)(const struct fwnode_handle *, const char *, const char *, int,  unsigned int,  struct fwnode_reference_args *)’ from incompatible pointer type ‘int (*)(const struct fwnode_handle *, const char *, const char *, unsigned int,  unsigned int,  struct fwnode_reference_args *)’ [-Wincompatible-pointer-types]
>  1669 |                 .get_reference_args = acpi_fwnode_get_reference_args,   \
> 
> Could you post as RFC until we can actually merge this? I'm worried 
> some sleep deprived maintainer may miss the note in the cover letter
> and just apply it all to net-next..

I would really like to keep RFC off the titles since some reviewers don't
pay attention to RFC series.

Would [DO NOT MERGE] in the subject be OK?

--Sean

