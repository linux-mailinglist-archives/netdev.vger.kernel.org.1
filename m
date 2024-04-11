Return-Path: <netdev+bounces-86809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A08A05AD
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BEE2883B0
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454363102;
	Thu, 11 Apr 2024 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ5x3K4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E8629E6;
	Thu, 11 Apr 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800485; cv=none; b=YWppFhQgd1a9Dos661XODXPABeARODmDf9AQ3/fkWtbrmYs8s+ZZ+/DZW9p8/9Syf9f9GaG/NtuoCNgJ0tVgp4Cvw7xCtco/CS3VLEHfUJ1eKI8D5VsTWgUvZVI0anZEBoVnpl9YxC1zqthvyzRtIB7ekWjtD1qvNg2Zifio+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800485; c=relaxed/simple;
	bh=AtfV+JHLU8oQZvTzDg2yxUrd2XeuBceS8icQY4Tvmng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+crOQIcU1yFC+VsTrsy0Xi7JbWvpHKuJgmsIpAx5Va/WbMhiE0JvXAhWa6B/T8mi6dKC/V8Aj8b7D5m0cCsQNOiTZsZbY2SwUrTeUfNFN3eLaZaz+C7y4NmwzQwhwyyiyjaRBZ8CSFpprywBa9cAw1KFCQ75B/iZ/Rg4IJwseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ5x3K4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9006C433F1;
	Thu, 11 Apr 2024 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712800484;
	bh=AtfV+JHLU8oQZvTzDg2yxUrd2XeuBceS8icQY4Tvmng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gJ5x3K4SmUkkXdhOSFzPOUSPlnY+xVhLkLrbZd16d1qgs5wqN3ZVmOyG06MThaNHj
	 E2ERagnK/cEAnKZQR9TNPO2Vh7fyCZx/F4SQZsQdQ9qppMzCNTpWEeo5d5ID2132pt
	 qmbGPy+/PeewsuykeqYn0OUj9rqMWVdHoeWfjzKCpn5wS6zD0KB1Vwhy4vymWxXSon
	 TkN2gURTE8Ve3DPjeYKPGCXy4VrD4friUeNEsnLOPPhx+JdEgRbdnohSgs7Nm+Wt35
	 0qXBbmQsQf1vCKDOHGZUR+/CaIYM6Cv9FKUFqTHkq0N0VNbXa1GKn3wqZe5SuHx/rq
	 KHmih7TdvipuA==
Date: Wed, 10 Apr 2024 18:54:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240410185442.7ff17c47@kernel.org>
In-Reply-To: <1cd6cd7d-5cf2-4f86-b084-6e88b0cbf229@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
	<1712664204-83147-5-git-send-email-hengqi@linux.alibaba.com>
	<20240409184020.648bc93c@kernel.org>
	<1cd6cd7d-5cf2-4f86-b084-6e88b0cbf229@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:09:16 +0800 Heng Qi wrote:
> The point is that the driver may check whether the user has set 
> parameters that it does not want.
> For example, virtio may not want the modification of comps, and ice/idpf 
> may not want the modification
> of comps and pkts.

If it's simply about the fields, not the range of values, flags of
what's supported would suffice. If we need more complicated checks
you can treat the driver callback as a validation callback, and
when driver returns success - copy in the core.

> But you inspired me to think from another perspective. If parameters are 
> placed in netdevice, the
> goal of user modification is to modify the profile of netdevice, and the 
> driver can obtain its own
> target parameters from it as needed. Do you like this?

Yes, IIUC.

> In addition, if the netdevice way is preferred, I would like to confirm 
> whether we still continue the
> "ethtool -C" way, that is, complete the modification of netdevice 
> profile in __ethnl_set_coalesce()?

That'd be great. If the driver validation is complex we can keep some
form of the SET callback. But we definitely don't need to extend the
GET callback since core will have the values, and can return them to
the user.

