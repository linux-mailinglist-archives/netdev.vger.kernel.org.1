Return-Path: <netdev+bounces-125876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED996F156
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EBD1C21588
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B81CCEDE;
	Fri,  6 Sep 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4w1WPvn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C481CB154;
	Fri,  6 Sep 2024 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618115; cv=none; b=j2QI8GKyDf2siKQntlg3puTFfsomM+mR5XnXrErPxOGeiI5zSdmaWY9iwXNfek3q4E+oWWtruEYdkJT/Tr4W+EDo/g2MXIKlucnbs22p/ew6rcuMM1LMCB64f/m77i1puwUhW40ntXaLpOq7BPH0cg39QInSgYlaqmpQjo+TYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618115; c=relaxed/simple;
	bh=13JETvl8tIjqOz1E2ioRYcW8dthjCRqOi/4ddlq18Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvMpfbxHebjYja+ctrblgVbphcxaHKG8kM1ntx16Vwj/Dc8ttSer8wpqFEZObmxwKeL6PzuRhrpYrRG5O4Zfc/BAt6VLhJLCBdKhVudKDtmda/gglWAMOy4i1H+m+eKECPsA9TOvbQ+TJ72OOREywqKn9KmzU+CVprHhA7sUAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4w1WPvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E52C4CEC4;
	Fri,  6 Sep 2024 10:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618114;
	bh=13JETvl8tIjqOz1E2ioRYcW8dthjCRqOi/4ddlq18Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4w1WPvnqR/IZPh0Cu8bW7FUnzpjFPYrczgYYtdUX3icC5tyJMOlnY5+h7tl2JeeB
	 SBoZevzCE2o9cmeK0oPaD+2r8EV7xlsIeZ46Ex2raUu8J9Rgwq3PRbBgW/dIDNnZC2
	 feUV96xwU2d43upEVFE9zqsdCL9i2FQ1B+TUPony17h5dUY1IP8xNfmMMyZoqr0QkN
	 3Yafk6glpjiNZAanzRYHXp8llqv0XCK37Ktmu3PrCQRF6FhSVn9X78h7wslp+qTf3a
	 dCZmmE7CL4xvss7Q1jAltZOH8tPs8lt9Zk2hYTZUhmt3STxjkW81Y9+Uc6YeO9k6kT
	 Q6jO6t1KUyprw==
Date: Fri, 6 Sep 2024 11:21:50 +0100
From: Simon Horman <horms@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] net: sysfs: Fix weird usage of class's namespace
 relevant fields
Message-ID: <20240906102150.GD2097826@kernel.org>
References: <20240905-fix_class_ns-v1-1-88ecccc3517c@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-fix_class_ns-v1-1-88ecccc3517c@quicinc.com>

On Thu, Sep 05, 2024 at 07:35:38AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Device class has two namespace relevant fields which are associated by
> the following usage:
> 
> struct class {
> 	...
> 	const struct kobj_ns_type_operations *ns_type;
> 	const void *(*namespace)(const struct device *dev);
> 	...
> }
> if (dev->class && dev->class->ns_type)
> 	dev->class->namespace(dev);
> 
> The usage looks weird since it checks @ns_type but calls namespace()
> it is found for all existing class definitions that the other filed is
> also assigned once one is assigned in current kernel tree, so fix this
> weird usage by checking @namespace to call namespace().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> driver-core tree has similar fix as shown below:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=a169a663bfa8198f33a5c1002634cc89e5128025

Thanks,

I agree that this change is consistent with the one at the link above.
And that, given your explanation there and here, this change
makes sense.

Reviewed-by: Simon Horman <horms@kernel.org>

I don't think there is a need to repost because of this, but for future
reference, please keep in mind that patches like this - non bug fixes for
Networking code - should, in general, be targeted at net-next.

Subject: [PATCH net-next] ...

See: https://docs.kernel.org/process/maintainer-netdev.html

