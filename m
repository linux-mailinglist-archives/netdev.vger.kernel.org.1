Return-Path: <netdev+bounces-133299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC49957E2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B908F1C20D18
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D5213EF1;
	Tue,  8 Oct 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMcvCFei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0557212D21;
	Tue,  8 Oct 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417209; cv=none; b=tV/Y//KXgpaovXO3iYgr0yS3SwfuWUmocgR1ZW2N0AQlTv+tSDWgQ1HGofXT2zOaA1pE2bUyHc/GJGqO5Ok6pk/IlwdZ+6PvilgVNAYEbqIkhfbb5pkqQOSul/rfgG9M/CLUVUHVrMeZCUZPIY9/Pd/Nspu02ZGSYxIqk8gUApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417209; c=relaxed/simple;
	bh=Hy3ldGLiANp9fWX1F9t74ZmDpnYJQWtMHogoLeUFvM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTJd7GLhWDM5zRSSVVGmpJm4xbfnduGU0HTd/X/ZkaoOc1XYoOFPfj2VnNqK4WQtBR1wYG++I9+B8dciGiJgSMKKa56BK83RDZfYxdyDGYR1TsDgnJgGYHVD/Zgycogsn7yMBpQoayF2tuCu/3Q4E6+HHr75nWB+NxbSMOqR2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMcvCFei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E7FC4CEC7;
	Tue,  8 Oct 2024 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417208;
	bh=Hy3ldGLiANp9fWX1F9t74ZmDpnYJQWtMHogoLeUFvM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tMcvCFeieUr5lTimHf1M2JeI+yy7q6tEO62xmPpcRxoUOj6jdxvFUk6D3j6eQ2HvV
	 NQqkxiWb1JJg7irZJtLTvCwscn4goZDeSVx+6Jgzvrdc0KGti/xh9lhiuapVQVKpEf
	 3TYIWeq4q1wqCnzmgvngOa8kBaW9fp99O4QZkT0QcEgrOQaalhsIwoLNlprXyWZ067
	 De//3m0v8h5R1ycaeatyz5filB0PzH+7ovcwQpZPcv5lJ9SOhTtSES0RAf4DiNpM8P
	 avoPpFtdfo7qg3m7hEtrvRBYklf4LMxNHS82FIvBFZAOBVe6FSX4YXwsqoIebz7lQf
	 YCczw3AUV2qLA==
Date: Tue, 8 Oct 2024 12:53:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <20241008125326.2e17dce9@kernel.org>
In-Reply-To: <CACKFLikDqgewWCutDG9ar6UFup_EUefUEaXShEg0kmxC5yiHMg@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-2-ap420073@gmail.com>
	<CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
	<CAMArcTXUjb5XuzvKx03_xGrEcA4OEP6aXW2P0eCpjk9_WaUS8Q@mail.gmail.com>
	<CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com>
	<a3bd0038-60e0-4ffc-a925-9ac7bd5c30ae@lunn.ch>
	<CAMArcTUgDLawxxvFKsfavJiBs0yrEBD3rZOUcicYOAWYr+XYyQ@mail.gmail.com>
	<20241008111058.6477e60c@kernel.org>
	<CACKFLikDqgewWCutDG9ar6UFup_EUefUEaXShEg0kmxC5yiHMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 12:38:18 -0700 Michael Chan wrote:
> > Where does the min value of 64 come from? Ethernet min frame length?
> 
> The length is actually the ethernet length minus the 4-byte CRC.  So
> 60 is the minimum length that the driver will see.  Anything smaller
> coming from the wire will be a runt frame discarded by the chip.

Also for VF to VF traffic?

> > IIUC the copybreak threshold is purely a SW feature, after this series.
> > If someone sets the copybreak value to, say 13 it will simply never
> > engage but it's not really an invalid setting, IMHO. Similarly setting
> > it to 0 makes intuitive sense (that's how e1000e works, AFAICT).  
> 
> Right, setting it to 0 or 13 will have the same effect of disabling
> it.  0 makes more intuitive sense.

Agreed on 0 making sense, but not sure if rejecting intermediate values
buys us anything. As Andrew mentioned consistency is important. I only
checked two drivers (e1000e and gve) and they don't seem to check 
the lower limit.

