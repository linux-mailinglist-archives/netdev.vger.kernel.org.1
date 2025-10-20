Return-Path: <netdev+bounces-230819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E50BF01AC
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A5318807E6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9A2ED168;
	Mon, 20 Oct 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="0jU3TVqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXwIPP9v"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07882ECE9D
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951455; cv=none; b=JAMJSZCdAwhtXTWQguUnn5ng54hkfj0kmNYiV8mtoIj2BYsssWT1mXT50ggzvOAcRer0irwBkNDYsvZqGLSDmsZkf07QNJOmz63ete0gTdPxWbSqIvGhXIrEt35CUS/QCBepzkUiaW4JWjW5+qUnz2DrfeOQYj3bZnqbQ4bSAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951455; c=relaxed/simple;
	bh=oYtTqecCnNQx2Ik8xx5C830t05U2Un7+CpAD1L9SKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG+mJrZCneifA3fiDmILRfBPXcb4Xl+YHkRcheo9e6DvyQlxcmteLpUX/v03mrNfR8tYwUAT8mdm0KTucenvJIiWFpKjXq6rh9ZX/cWEsTya2YWUB30u1qB3NuR8eYeBLRXQYLuLTAbRZJklNQM+pah24cGZwgaZvhdeFi/exIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=0jU3TVqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXwIPP9v; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 483751D000C3;
	Mon, 20 Oct 2025 05:10:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 05:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760951451; x=
	1761037851; bh=wGI4UPOkusN6cayT7+rVnJToFhsPbfwHu5GfFivImJQ=; b=0
	jU3TVqqtXu8AFffzzU1t+1+ZK+VXVpnRKRu6j9EXLxiI3L44grhgqSgNN3Q+HS4A
	jsKdQ336JNPE9J9wmDaPWH+X7G38ctZt4fVBhuL3QhIDa6dhBn1HcjeYkyomcnAH
	1dW+HWP0/Bbqv8Ug0JS4S1YrfSfneFqwwBJE+QxWpsF/fdaDFz5ezTCJVWtD0CbQ
	JXYNZe3EI4akCaSaxrQHMtQkzmWshMri6A4N1Hbv21DTBsuh/6Z9ZsOLviC3u9VA
	pcDOXRxIQdR8byrnhfhwE8UVNfXb6wjxk9q71akOMrdYmmhq3D+ZEQtxMaBAQi7u
	TZRaLfYMi76s0bQtIUiNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760951451; x=1761037851; bh=wGI4UPOkusN6cayT7+rVnJToFhsPbfwHu5G
	fFivImJQ=; b=NXwIPP9vGPf7q9bWfkpJa0fDydEvcdTf6T52RPSL0hQrDtJPZ76
	Hud7YF00GO5W2Nz6Z1ScJDQet8JJ8+4skPtc8bzVpl1ZIwOml9+JnRtj3Si7mNYZ
	vFq/fwqsfKJmp50GeF12FJl+CLIwZK/qa7spZuMSXXqqsHkXX1+dNN1+0ZJsHqD6
	KBqw1b4Za0Ow8nIut6WNcar6LDDTmiflkHiYniJE62F5YGurcjSLF7POj7jzZFYi
	SxQPMQrk6rPNXxOvNgnyx0rnVmvbkaqzXzZFoRlA6rD+zsGo7I6s2bkSRkK0l5+C
	OiPuiKGFvWq9Xcu2FH97DWVqq2ZdHeaEMaQ==
X-ME-Sender: <xms:mvz1aMLfLBY3plZMsgMS9y1TcoH5JtaewMdhsOpF3XeJBqysQBlyLw>
    <xme:mvz1aHXP-hTlSX1MZl7H_aKEkcu6IUoGhvmHqNV51B5Tpt6SfZePKtyVyoi9lQUJ-
    oR7YEJMx_ZXBJmxmneFfYaQjP01Exv5dWs5_un4dBcKDR-rZl8vuBw>
X-ME-Received: <xmr:mvz1aAjxQTeoicMirR8gI0GyE95l01GeieIDT5J4r3s_RIfoCKLj3vFxhHY_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhird
    hush
X-ME-Proxy: <xmx:mvz1aDvWrce7U_ALcaSo7SeDqPcHKifdu099_lydaOuAc_SI-PDu3A>
    <xmx:m_z1aAwDY4nv1FdsErNRMqKpgITskmrOl-4u5aBIgnSgcFBUUUM9hA>
    <xmx:m_z1aIa26mQNpdpX_Jgnwm0ZX1uEYFofs3SNNVpjP-KftvZmVzIy8g>
    <xmx:m_z1aPXZuJjz7gsKSSti_r7oU7mfxjQ-1k2pATS3tEL89CgKixHY7Q>
    <xmx:m_z1aCHP3-yl_2PsKkrdFsFpCkLPG4H7mXC0v6iO3YZG8zALo4R9fyP8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 05:10:50 -0400 (EDT)
Date: Mon, 20 Oct 2025 11:10:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 2/4] bonding: use common function to compute
 the features
Message-ID: <aPX8mDzY7whZ9gp4@krikkit>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017034155.61990-3-liuhangbin@gmail.com>

2025-10-17, 03:41:53 +0000, Hangbin Liu wrote:
> Use the new functon netdev_compute_master_upper_features() to compute the bonding
> features.
> 
> Note that bond_compute_features() currently uses bond_for_each_slave()
> to traverse the lower devices list, and that is just a macro wrapper of
> netdev_for_each_lower_private(). We use similar helper
> netdev_for_each_lower_dev() in netdev_compute_master_upper_features() to
> iterate the slave device, as there is not need to get the private data.
> 
> No functional change intended.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 99 ++-------------------------------
>  1 file changed, 4 insertions(+), 95 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

