Return-Path: <netdev+bounces-176690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1EA6B5F2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4802046507B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377F1EEA39;
	Fri, 21 Mar 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fls2TqWs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD61EE02F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545032; cv=none; b=ZHRiE43zWf3iIVT9dGu592RQ3SE5KVPQMndnDlaUtYmDlMjuSMaCKZDZjYcBkdq+0hPAcSnb42IWzhivTuLs0x4q+ezkFkelkqvD66fzep4BzyPbfLMrU6gDpQo7gjmW/hTHIJdj4AEIXKp/Y3AQrH7teeVl51o79oXbZuOMqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545032; c=relaxed/simple;
	bh=I6TBOGMG1VaLCmMd8p5mAIbd3Ka8wLm635EByw3igFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRhp20eXSdggAftwY4vWZzU63+b5iWDirfS25wadtDyyDUr9mGV5ZY6L7yntuwHMR6Dyl2Xb6F5cCJQKPcEndylYuih5GhoB39h5sfFikC0pKrrnMslfHCfxXlIrwdzk7g6H0N9dPuEW7Q8ql4BG0dgLooMAZnNrm7Q74bLvs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fls2TqWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A066CC4CEE8;
	Fri, 21 Mar 2025 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742545031;
	bh=I6TBOGMG1VaLCmMd8p5mAIbd3Ka8wLm635EByw3igFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fls2TqWsk9/NK/Y7GPxYu4cYuPktcf3gNfxfZi5Rj+oc81v2YgZmKYShcmCIEJxpe
	 YOLtXCEM7Xc7etfItJrXfNMDj7Rci0/BB+y/9L9L5iAixCj/YKPifwVECEoht17n+D
	 S+zfQ7UtuA5PBC/UDKffcYLdyqUgIT+t5j7a0YbbY663aI0+UrCTQWg0fRQZ9PpOCJ
	 Fe1+qkGiW1WVvggKgqY/8GYxhgR6EurpD3Je8nE9eN8xXuA164Eg+WUw7pM/PYKrf6
	 02XndYmBHhUnUlNEO/EV058d5wgXvEP9aisFDhG/XARAYKMPc8UbN/y/j9yWOxxEdL
	 RpP4xZGiG13tg==
Date: Fri, 21 Mar 2025 08:17:07 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net 1/3] net: dsa: sja1105: fix displaced ethtool
 statistics counters
Message-ID: <20250321081707.GM892515@horms.kernel.org>
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
 <20250318115716.2124395-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318115716.2124395-2-vladimir.oltean@nxp.com>

On Tue, Mar 18, 2025 at 01:57:14PM +0200, Vladimir Oltean wrote:
> Port counters with no name (aka
> sja1105_port_counters[__SJA1105_COUNTER_UNUSED]) are skipped when
> reporting sja1105_get_sset_count(), but are not skipped during
> sja1105_get_strings() and sja1105_get_ethtool_stats().
> 
> As a consequence, the first reported counter has an empty name and a
> bogus value (reads from area 0, aka MAC, from offset 0, bits start:end
> 0:0). Also, the last counter (N_NOT_REACH on E/T, N_RX_BCAST on P/Q/R/S)
> gets pushed out of the statistics counters that get shown.
> 
> Skip __SJA1105_COUNTER_UNUSED consistently, so that the bogus counter
> with an empty name disappears, and in its place appears a valid counter.
> 
> Fixes: 039b167d68a3 ("net: dsa: sja1105: don't use burst SPI reads for port statistics")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


