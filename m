Return-Path: <netdev+bounces-76016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2981186BFD6
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF901C21396
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3553771E;
	Thu, 29 Feb 2024 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE5wyup7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE45376EB
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180457; cv=none; b=bTZ3EQ5KyCMwTZyuG0MZ5rP2JWuHvNp0r8OOgbZWZlEOGOBo0PZONHmDMVPehevf7CGgj+XSxGLzztf2omCDBNcSJpQP4ZXNZVlIAVSTkS6Act+78JC+drmvrkAvMtSY+8BTwzKNqjIcTYjOg4i2XW4mWbEpknWFnIpHKxplbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180457; c=relaxed/simple;
	bh=dRtWuimfyzeVcKkgDwWnlIuQ1Qdpg5LdnJFd8QA4ahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orTUMLYhMp7CPZeS0MFh1p/h7wLXX+E+3uBosj7XG2JeyPh4NJBzsjrYgd4pTLtbcmkChU/U2zh3w4RbenBlljfJZVRTURDVIgIJJPyoeVAbIAhqAMLcLTBaY1I08k7ZS91BbrKbpreM7vyseh+P6Epa/rkoCe/UZLhHZbGNZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE5wyup7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FA7C433C7;
	Thu, 29 Feb 2024 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709180456;
	bh=dRtWuimfyzeVcKkgDwWnlIuQ1Qdpg5LdnJFd8QA4ahQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OE5wyup79OQjEGdyt4dGbTiLiCNCH4RDOk48pfwAP4ST8ZEwqgm6Y4Zi6E3aa1j1Z
	 Vhy6ulBAY4zhLYLMmfeQ1tJ9cQitt9LP7mRuLTbI7Why31R+WaeLWytJk70d5MBnjw
	 ByhaDIuJmW3w8Cr8mrF1FBPbZ6EmbIIPMsvmJWwT9CPlKMiMupALmMKVFhJtVJ3k5t
	 NvoXm5ylly9B2qfLoeV63y7WQZb6uBNzSg9N+CKZIWPL0idMd6SoCDKMkmdGAuNEmn
	 fyQZc0bUNSksHNsz9wzWbpCSrtzPWEdiCnd813Nlk+HNVGll5RemaPVuGyydiljykn
	 nj1FrCFbJFxcg==
Date: Wed, 28 Feb 2024 20:20:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "nathan.sullivan@ni.com"
 <nathan.sullivan@ni.com>, "Pucha, HimasekharX Reddy"
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
Message-ID: <20240228202055.447485cb@kernel.org>
In-Reply-To: <PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
	<Zd7-9BJM_6B44nTI@nanopsycho>
	<Zd8m6wpondUopnFm@pengutronix.de>
	<PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 17:43:03 +0000 Keller, Jacob E wrote:
> Without this, the i211 doesn't apply the Tx/Rx latency adjustments,
> so the timestamps would be less accurate than if the corrections are
> applied. On the one hand I guess this is a "feature" and the lack of
> a feature isn't a bug, so maybe its not viewed as a bug fix then.

I tossed a coin and it said.... "whatever, man". Such sass, tsk tsk.

