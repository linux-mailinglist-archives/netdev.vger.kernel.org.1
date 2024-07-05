Return-Path: <netdev+bounces-109387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB3392839B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E4B286B29
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0814533A;
	Fri,  5 Jul 2024 08:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5741A81
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167854; cv=none; b=Yb1fMUF6G50YquQVgRTxqUtL7eixd5w6m1cU56mUxhc5cfuEoA+oIVV7pB5MjgM/RIfzIZh2oUW5lpw41FAPsBMg7PHv6lo04gRmhsJcEWwqfxQ9P0B0E3YBr86HBHewmB60nXy6qx+s2fgN5GqKcIe9nTEeVzbAxG8CDLW+xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167854; c=relaxed/simple;
	bh=A0yD+EcKx2ERF5iFxGBG0uKR26JTcv4coIWOigOtt+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyJDu0HbojIWPr12GEpKV9IBrwv2N5/kgc2ZAaB0s4QFAanxC3XvsDlGs0pn9C0o42nS6kdXEQPOknaI6pjMUIqDZ58DH6dwPmP+jotz3c5yl/APq0mbKG2fQd0JDoQc1xiQb4rNxKj/UwUcEzTt4h8yKmnJaVJITrJtNOlwYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <bst@pengutronix.de>)
	id 1sPeEi-0002t8-Gq; Fri, 05 Jul 2024 10:24:08 +0200
Message-ID: <5e81ddd2-b6c8-46f4-8a9b-2db521ea1739@pengutronix.de>
Date: Fri, 5 Jul 2024 10:24:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool 1/2]: add json support for base command
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Fabian Pfitzner <f.pfitzner@pengutronix.de>, mkubecek@suse.cz,
 netdev@vger.kernel.org
References: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
 <f30c683d-303f-40ff-967a-7c33ecc07202@pengutronix.de>
 <20240704110556.1ebea204@hermes.local>
From: Bastian Krause <bst@pengutronix.de>
In-Reply-To: <20240704110556.1ebea204@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 7/4/24 8:05 PM, Stephen Hemminger wrote:
> On Thu, 4 Jul 2024 17:21:16 +0200
> Bastian Krause <bst@pengutronix.de> wrote:
> 
>>>    	if (pause)
>>> -		printf("%s\n", asym ?  "Symmetric Receive-only" : "Symmetric");
>>> +		print_string(PRINT_ANY, label_json, "%s\n",
>>> +			     asym ?  "Symmetric Receive-only" : "Symmetric");
>>>    	else
>>> -		printf("%s\n", asym ? "Transmit-only" : "No");
>>> +		print_string(PRINT_ANY, label_json, "%s\n", asym ? "Transmit-only" : "No");
> 
> 
> JSON has boolean type, why is this not ysed here?

As far as I can see, the
"supported-pause-frame-use"/"advertised-pause-frame-use" field's value
can currently be "Symmetric Receive-only", "Symmetric", "Transmit-only"
or "No". How would you put that into a boolean?

Regards,
Bastian


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


