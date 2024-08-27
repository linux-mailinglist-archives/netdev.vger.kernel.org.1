Return-Path: <netdev+bounces-122373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C3960DC2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B0285177
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B91C4EDB;
	Tue, 27 Aug 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx/VJ5jL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17D1494AC;
	Tue, 27 Aug 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769615; cv=none; b=fVpXOgbTSUV6/z/p74NPm1W8jxRi8pc36hzx09+3KrTbbtMxQeBkHmn2w2MN36fgIz4H6uwk2MLR3XtoU39RrX6Vkn823p9imvcRc71gJ4p+CfV89UbvKikcNdLG1cRM0nIsh/+6corHSy6QSyk8CSNxIafiBZioVB1caDXlIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769615; c=relaxed/simple;
	bh=KDoD72B8HOYnNcGNrKBCZEcBGEignDJUTMufI2/W9f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH0RKG67FqsESvAlXR5wjSIvScni8aMZW2P5IS6mQdR6roUtphCf876W32eJIq2gp5smaMcwblgmD0EPMX4ulMFFzKFDtYxiBx4rmdbuzkV4wZTaLNxIeMW7vxktxF94D/5Re67DwNEUgiMlAckUJ1EtjiiKmd2cRZk/dv3hmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx/VJ5jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E0C61045;
	Tue, 27 Aug 2024 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769615;
	bh=KDoD72B8HOYnNcGNrKBCZEcBGEignDJUTMufI2/W9f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qx/VJ5jLrU54aVdIohglRkELQmxP69aYhP7jV4kJvmrym+1Uw272WrjMF7qcCMv2r
	 jAkUU8xiqKriNPJVC63zJ0K56q6oTHPuwX0c5py9tS/lW0eGEOZGSu+OdUjJeIkIbc
	 ROVVV7YVyozMSOwvE8kywDdX00EdygTHcuZvLMwDl+440fL0kp6dsam7raXvB9L5NP
	 7jEVy7LBs/BgbgnwSztahg/xyvXHrIsuQE3MkBRoBE/bg7TywLurDY7nYAFkMTjwrJ
	 ZNDqJ75YK3x7ewxU/pXljcd9RPYDHoFPE6lc+wVZpWBTssgTdRX5w8olwSA+wCmfSJ
	 a2qHsVfHrhggQ==
Date: Tue, 27 Aug 2024 15:40:10 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Message-ID: <20240827144010.GD1368797@kernel.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
 <dc803f66-5f85-49d3-81e3-f56a452a71bf@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc803f66-5f85-49d3-81e3-f56a452a71bf@web.de>

On Sun, Aug 25, 2024 at 09:21:31PM +0200, Markus Elfring wrote:
> > Driver is leaking OF node reference from
> > of_parse_phandle_with_fixed_args() in probe().
> 
> * Is there a need to improve such a change description another bit?
> 
>   + Imperative mood
> 
>   * Tags like “Fixes” and “Cc”

I think it would be helpful if these were either explicitly targeted for
net-next without Fixes tags (the assumed state of affairs as-is).

	Subject: [Patch x/n net-next] ...

Or targeted at net, with Fixes tags

	Subject: [Patch x/n net] ...

I guess that in theory these are fixes, as resource leaks could occur.
But perhaps that is more theory that practice. I am unsure.

> * Can a corresponding cover letter help?

I agree that would be nice, it's the usual practice for Networking
patchsets with more than one patch.

The above aside, I looked over the code changes
and I agree they are correct.

