Return-Path: <netdev+bounces-140565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B269B708F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7722B281F33
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4661CCB53;
	Wed, 30 Oct 2024 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y16y9rUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03419CC24
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331306; cv=none; b=ZYgXfE2I0f15yFCJN1xZi5ADnFIJPBUH1RlBbDpIInjvXiW3RXhz0FdHPhJDLZ9xacHprCUCvlf3Pp/hRHmNGAJToZhQaJ9qU0pQIz4AIIgCcrQST5qvxBb83z6Z+KSDe6W5VlJtsDvPuuZ4Y3N4LL26B39E/TrdwJAkwZCbdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331306; c=relaxed/simple;
	bh=q8eYmhOGsCtwPj/BlxPsFFFQrnAydrOcHFD07ejWSuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8yXFyqPpZWlbj6wnKxYmSKF8/ogAVQVQosGhNBXCd+YsdJDYgyEkKGRo3LVJbrzsRYcjMV4RrFYHv0YvAf6AwGHov/LYmFIupfogo314vBQC022zvQaI95Ke20uhMid1AMrsvGK5V+0Tuyr/uL8Cj8AkrhqDrGp4S3Pvs9RHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y16y9rUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E01C4AF0B;
	Wed, 30 Oct 2024 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730331305;
	bh=q8eYmhOGsCtwPj/BlxPsFFFQrnAydrOcHFD07ejWSuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y16y9rUIIawMO+jVicq5oUgA51Rufw79+y1/oZz2uKXIdhPXFxx0J8uFpfoINHrAT
	 Q0feU0QBIt+nI5cGeAKCldkLxXl5K8m3jEd10IP2grIzuSO0eNEI5M8iPZEK2tECu7
	 YBkYEB3DNtxuIRr7JxPbGLOk9QHlw4ol/FCbNhraQAjXj+PoVLj5hcDGgfCbp1L852
	 oHnwh4uEe1xjMRSE9o6OiNu/burvCn7sRf8sM9HdWwoYfKmywccKALBE5UlKJsavzt
	 og3KjraHKd/evdHxaD5WyfVB9iQopgljiFI140qKhMvIqpibtqtIr+Bsp3Z2cYnItA
	 dx5GZCUipQHeA==
Date: Wed, 30 Oct 2024 16:35:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH net-next 0/5] net: Improve netns handling in RTNL and
 ip_tunnel
Message-ID: <20241030163504.47a375f5@kernel.org>
In-Reply-To: <CABAhCOQ60u9Bkatbg6bc7CksMTXDw8v06SDsfv77YpEQW+anZg@mail.gmail.com>
References: <20241023023146.372653-1-shaw.leon@gmail.com>
	<20241029161722.51b86c71@kernel.org>
	<CABAhCOQ60u9Bkatbg6bc7CksMTXDw8v06SDsfv77YpEQW+anZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 10:10:32 +0800 Xiao Liang wrote:
> > Do you think the netns_atomic module param is really necessary?
> > I doubt anyone cares about the event popping up in the wrong
> > name space first.  
> 
> We used FRRouting in our solution which listens to link notifications to
> set up corresponding objects in userspace. Since the events are sent
> in different namespaces (thus via different RTNL sockets), we can't
> guarantee that the events are received in the correct order, and have
> trouble processing them. The way to solve this problem I can think of is
> to have a multi-netns RTNL socket where all events are synchronized,
> or to eliminate the redundant events in the first place. The latter seems
> easier to implement.

I think we're on the same page. I'm saying that any potential user 
will run into a similar problem, and I don't see a clear use case 
for notifications in both namespaces. So we can try to make the
behavior of netns_atomic=1 the default one and get rid of the module
param.

