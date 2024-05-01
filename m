Return-Path: <netdev+bounces-92744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856DB8B8892
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C4FB22364
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37B52F62;
	Wed,  1 May 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dRYJefUI"
X-Original-To: netdev@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39E50A87
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559210; cv=none; b=sKaHk1f5/34b0s5gHXM07XkV36UmMIAlClLS8hDc4EV/cMnqW8/8TSsA97Cp1C9L6VNfq8CaXKhf10xp67v2YiVWCvD33iW2XdR/qeVhKPYHDWFi6dnJcbLl70YSDVHchSCVR3Uh7IieekW+7SRBiYwl2IB+y0lLZbfBfPgafX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559210; c=relaxed/simple;
	bh=aKK2BleNQrwIDWmlVoya1ufH8h9bCfsMn9G2FuchbUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBlYXJXWOPgTQXFLCNLtCQhSZfOdpSRgXJSKA2FtsYfnPBW26R3/eTRxGMbEHE/mKAOM5JHlQG0RuzxjQo+fV9P0DD9SoxbeCGV95J4e2tfjSrTamvY2GErfjI5xlIDlUu/sNXaAiQQDWWyShOvYXXq/LHDqLJwSYq484FUP4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRYJefUI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9802A1380140;
	Wed,  1 May 2024 06:26:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 May 2024 06:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714559207; x=1714645607; bh=soL9MLSiLsU1pc8mZTNMqxQacrWN
	RB3W523uGKlElyQ=; b=dRYJefUIQXf7IZE3jGODtZEHz0xQFDcS3rMGryLh3uqr
	eWfcEIkAIf9xXl0Zq9iCeCW0FuMQ/A3XZKmEuR8cPD91hgFwx3sihkfYAOq23+tf
	08vXyo6BslE4zX9jMeOPf6NsWtMeq0ISclSfe8v5h0jkc1oaOrCvtIxD0kamEPsm
	KONrnY1JBErf0U16smayndlS9g9+uuFzAg1emR0s2QTAN69kUqfFwpQwvh7ZBcNR
	kd1IqMywizMpNFYK7RXz/cN2QO742b2K/gtbOo5OdBpkrKYYdjpoq1WzwSxokJrW
	htZq+Pd0kcNlCSB3bTyXepPtcuKkWVHp3DytgRbqtQ==
X-ME-Sender: <xms:5hgyZhbFR9an_BwLbaxjvnC8P1_iUi_M229-xGBGiANoK6ufybdDhQ>
    <xme:5hgyZobK3sMmjP8NEhijGmO-5IuJDFCyAgMDDQCiQPU-ylezidIk3AT2t4MVUcRNR
    xg9bXR4Ik5P4XQ>
X-ME-Received: <xmr:5hgyZj_3uG6LlvE3Pkc2GN61bkQaOm5RlX0amZKaSEoPO6p44XHceFecrBYp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:5hgyZvpL2yfxHvED9xygbVDGfnLuo47hzWXcgS0PnXtRZCHgGPyc7A>
    <xmx:5xgyZsq5XRGM_kainP8tmGnzn-vleNLNbYMLExkMqf-tN4WAWnqEmA>
    <xmx:5xgyZlQz8oxlAJTUW2bEYo_P2aGWavHEiDFRmQFCyA6kItnDgmALJw>
    <xmx:5xgyZkrkSjkRnFKtxWR2RooPx_WkqG-52GaSy9kMVd3vxq0jPAAzRg>
    <xmx:5xgyZj1fox-DvCectwFCVe6pZeZFwu8PHmdG2LeVc_lmEzBKPN_SB0hc>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 06:26:46 -0400 (EDT)
Date: Wed, 1 May 2024 13:26:38 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
Message-ID: <ZjIY3hkW8dYRPzSI@shredder>
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>

On Tue, Apr 30, 2024 at 07:11:13PM +0200, Davide Caratti wrote:
> Naresh and Eric report several errors (corrupted elements in the dynamic
> key hash list), when running tdc.py or syzbot. The error path of
> qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
> to unregister the lockdep key, thus causing use-after-free like the
> following one:

[...]

> Fix this ensuring that lockdep_unregister_key() is called before the
> qdisc struct is freed, also in the error path of qdisc_create() and
> qdisc_alloc().
> 
> Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/netdev/20240429221706.1492418-1-naresh.kamboju@linaro.org/
> CC: Naresh Kamboju <naresh.kamboju@linaro.org>
> CC: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

We've also hit the issue on two of our machines running debug kernels. I
started a run with the fix on both and will report tomorrow morning (not
saying you should wait).

