Return-Path: <netdev+bounces-80658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A16788033A
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0A1C2295D
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD317BA4;
	Tue, 19 Mar 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU6FWS3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B8179A6;
	Tue, 19 Mar 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868528; cv=none; b=AFxwRfUM4bMBKHM+wabOX/DdezkafF3NXpuuBTEpV2QerFDMo05MjYCcoz2fapO2Jx88ufZgvcbSKsECsl5TKLNNf25cMn1eqxt+fnt+zext/L0RF5OzRQvtvR/ErputLzzipcjMWSraQXz4LssMQln6T+DtVbFBjj1tPDAQNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868528; c=relaxed/simple;
	bh=cBcB6d6+i4J0E25xFREZKFr8Gi0/HhGKqA6mI9d7Dr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ozbo94a+rVUuvUbrT3HlHdAgMEZmHd2K9Qz5JrAfMVuGFOCJRxNmI8Lz7czLgOQhjRy+G9GUfCGfUhNSGbNtOf0SwAaUUxvXRsT2gGP9nbp0VsF2wpDXlNxUgeSMaE4qp1gOSdXP28MUbWR4+nr/nm728mQh/fc2hHuFgx0T1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU6FWS3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08106C433C7;
	Tue, 19 Mar 2024 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868527;
	bh=cBcB6d6+i4J0E25xFREZKFr8Gi0/HhGKqA6mI9d7Dr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BU6FWS3Osa9+Dn2am7oAuehEHNRiGwNK1VcKrsKgxxE3jql0jA8XWvsifl5qx/jY5
	 vy1SOnjA+ZAdBlMn1+BL8mLaFf0qbLyutGv10lYwBXpqUE50ByUhgpLXy3b/UilXlm
	 Hj4Pja6Bz3fDVNSit3eyirF4oDSjwzR4XECH2lVPKCuLfmKlT+HbXaZnYAUQpO/UgA
	 OMJEioTmjlsEkUDvTgf6gWeiSu9w1mvER2/PIsU39YhbBvDSLsQIDn7i7r1XHgKHkO
	 Xg0D+XmimCZNMT/ULptRsVY5ZtS2F+x+rn4A+z7PQJna4KIlQ+eEYmAt/nIpCKQcuo
	 vqaidrcNkgMyw==
Date: Tue, 19 Mar 2024 10:15:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric 
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
  Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei 
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha 
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/8] virtio_net: support device stats
Message-ID: <20240319101525.2452065d@kernel.org>
In-Reply-To: <1710489940.1772969-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
	<20240314085459.115933-4-xuanzhuo@linux.alibaba.com>
	<20240314155425.74b8c601@kernel.org>
	<1710489940.1772969-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 16:05:40 +0800 Xuan Zhuo wrote:
> > Don't duplicate the stats which get reported via the netlink API in
> > ethtool. Similar story to the rtnl stats:
> >
> > https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors  
> 
> Sorry, this patch set did not follow this.
> 
> I will fix in next version.
> 
> But I plan that will be done in the commit "virtio-net: support queue stat".
> This commit in next version will report all stat by ethtool -S.
> The commit "virtio-net: support queue stat" in next version
> will not report the duplicate the stats that reported via the netlink API.
> 
> Do you think ok?

I guess that could save time refactoring the code, but we generally
push authors to go the extra mile and make reviewers life easier.
Also, in a way, making the evolution of the code base look more
logical. So I'd prefer if the series was reorganized to never
expose the standard stats via -S.

