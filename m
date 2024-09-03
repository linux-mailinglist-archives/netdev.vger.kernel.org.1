Return-Path: <netdev+bounces-124744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010A96AAD3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5014A1C219B9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8F9126BF0;
	Tue,  3 Sep 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrcLPpQJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500120E3;
	Tue,  3 Sep 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400828; cv=none; b=OSm7nAJSWibkND1BdihV8+UrkCGzhjOQe/44f4acI6IWHpS/KvCZWCYeDinnIk2DpjjLyf+RUXu9P7sszMduUvJhO3Q5VExBDj0GPhpM7qxXjIK89YIxdmg+APhU+ZdY3mEKtxjjsl2j39Q6iJz4JHxl84LpHwoDSxQ7ESyoO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400828; c=relaxed/simple;
	bh=8XcjVoqFny30F6fk2p96WH/symXBb4KHW8bGKXthHtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9wgTLZ4OnXc9Pv0mHV1uRFwAPGPMa2JoT8g6blC9D7/ooxykUxqOjMor2LpVR/a7HHLjVVsu8Sungoi0ss8BYDI38V8G2Rub9OdammolXCkRqKm8294s4hUARKB/cB71CBuI37UiYEjMYzUHbFzuKSuPw+X5zH49DUoSvEFk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrcLPpQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FB2C4CEC5;
	Tue,  3 Sep 2024 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400827;
	bh=8XcjVoqFny30F6fk2p96WH/symXBb4KHW8bGKXthHtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lrcLPpQJyMO6//PpL56rxySEc7mWHPCd1dtRSDVzEvvMBGP2vHL0e5Sa0grUjOic0
	 gvMtcqExIxt30DB4EKuxyb/G4sgsLtci21YjsmnldMNLHxoS8bC8g3WOn28uX3BXRG
	 gqvPL5G+4NYMh2vJRLzWm9tPUJrcJ+9NLhaYLOh8r81mYfrWdPK0+mANtS3dTH7IRA
	 MYE28TdppCAOiFCHHDsAPMeb0QryHRYBI5VquItB3Vo4NLEau1JCMOpWYLSbbKRdw2
	 eLcFLXv0LxzP/wwxKO/fm5EvVAY4Ks8arWWh1sEGBtYkrioBCtBzLycj6/49GhpPwS
	 B+hvMsKzkNXTg==
Date: Tue, 3 Sep 2024 15:00:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, jacob.e.keller@intel.com,
 liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Message-ID: <20240903150026.34de5a1d@kernel.org>
In-Reply-To: <CAD4GDZySRpq97nDG=UQq+C4jBdS-+Km4NjGNob7jrbtBW+SmOg@mail.gmail.com>
References: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
	<m2mskq2xke.fsf@gmail.com>
	<20240903130121.5c010161@kernel.org>
	<CAD4GDZySRpq97nDG=UQq+C4jBdS-+Km4NjGNob7jrbtBW+SmOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 22:08:54 +0100 Donald Hunter wrote:
> > On Mon, 02 Sep 2024 10:51:13 +0100 Donald Hunter wrote:  
> > > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>  
> >
> > Any preference on passing self.rsp_by_value, vs .decode() accessing
> > ynl.rsp_by_value on its own?  
> 
> .decode() accessing ynl.rsp_by_value would be cleaner, but I am
> working on some notification fixes that might benefit from the map
> being passed as a parameter. The netlink-raw families use a msg id
> scheme that is neither unified nor directional. It's more like a mix
> of both where req and rsp use different values but notifications reuse
> the req values. I suspect that to fix that we'd need to introduce a
> dict for ntf_by_value and then the parameter would be context
> specific. OVS reuses req/rsp values for notifications as well, but it
> uses a unified scheme, and that's mostly a problem for ynl-gen-c. 

I was worried you'd say it's ID reuse related. That is tricky business.

> We could choose the cleaner approach just now and revisit it as part of
> fixing notifications for netlink-raw?

That's my intuition; there's a non-zero chance that priorities will
change or we'll head in a different direction, and the extra arg will
stick around confusing readers.

