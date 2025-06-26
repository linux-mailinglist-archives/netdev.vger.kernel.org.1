Return-Path: <netdev+bounces-201703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A3AEAB89
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03611C21944
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BC124678E;
	Thu, 26 Jun 2025 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axke/vH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8F1F8724
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982226; cv=none; b=DScx8mLjzosVFORvyV11jXcqgx0Ed5vMRblWAkW6zBVgDpin/TGO4onKmoBYdaz0McN1hJJ5ce/Q+lINqYAbAlNpS13bWnoGOou9iATf5r7aMf+WwtHPk+w4oc4OZkjwMZnxvZiIN64fsHWQvM5pC0MrBoQw6FjoPJSYzx244gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982226; c=relaxed/simple;
	bh=wzVt+nHP2o8z2BHruWH8j+Mi0NoTNjmawTBQ7Emw7Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTTdSBO1VDKsMUwNy9HOsMd3jNiP+w7ncfmMNSGpb7W1595HvuvdMgoylSVfL9Ff4mRfvVrpMHMceFKNB6+PIXfVBUlAnfvzTYJRfp2lZDZBDuHNmQE/O+iLIwvI6GjLYJal4IAcsW9ahuVocZgEMXilSoEPxbcc68MF2Mlk6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axke/vH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8722C4CEEB;
	Thu, 26 Jun 2025 23:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750982225;
	bh=wzVt+nHP2o8z2BHruWH8j+Mi0NoTNjmawTBQ7Emw7Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=axke/vH0XrHrRx1PQNrXA5jCUXvT2VDGOwohShZNlMSoMCBJwoE2pVmacSa73GsiH
	 /DKfeLBmMLqBzFnBrev5LUqOEFR/Rvz+XuLJDkyuk3lRuXLUm4Zworp52jPrWpevAr
	 K7jMgRaWYt4em5LaqHJk4E6SShzliKt2zHVhnnmXDUiAsiXgXGOuNxd/TUz8DfeBbs
	 MOvo2+z4Sl01GE1eFxuyeSKxdjBZnbpVT8ydmogqDVYrN5K+3k8SJPHidtVJaoF4+P
	 S5jFUG7CIll30ouDuOQLF5Z6fbxlDRtZhhu4fWra26/hbEr+bhwg10qvpxq4tKz89Z
	 zvNoZS4EcyUmw==
Date: Thu, 26 Jun 2025 16:57:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Message-ID: <20250626165703.0d03f415@kernel.org>
In-Reply-To: <685d816dd20ff_2eacd529452@willemb.c.googlers.com.notmuch>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
	<20250625135210.2975231-3-daniel.zahka@gmail.com>
	<685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
	<20250626070047.6567609c@kernel.org>
	<685d5847a57d7_2de3952949b@willemb.c.googlers.com.notmuch>
	<20250626081156.475c14d2@kernel.org>
	<685d816dd20ff_2eacd529452@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 13:20:45 -0400 Willem de Bruijn wrote:
> > > IDPF does support multiple "vports" (num_alloc_vports), and with that
> > > struct net_device, from a single BDF.  
> > 
> > Upstream? If yes then I'm very bad at reviewing code :D  
> 
> I then don't think I want to focus your attention on this, but..
> 
> See use num_alloc_ports in idpf_init_task. Which keeps requeueing
> itself until num_default_vports is reached. Which is a variable
> received from the device in VIRTCHNL2_OP_GET_CAPS.

That's not too bad, one of the older drivers had a sysfs interface
for creating the sub-interfaces IIRC :/

We should be able to share one psp_dev if the implementation shares PSP
between blocks. I was trying to write the code so that it'd be possible
to attach the psp_dev to veth / netkit
IIRC the main_netdev was supposed to be special in terms of
permissions, the admin in the netns where main_netdev sits is
the admin of the device (for rotations and config).
But I was planning to add a secondary list of "attached devices"
which have access to non-privileged operations. 

