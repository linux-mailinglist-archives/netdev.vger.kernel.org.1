Return-Path: <netdev+bounces-199958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA97AE28AD
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828353B0640
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62D1F2B88;
	Sat, 21 Jun 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnVvIvnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BC43AA8
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750503233; cv=none; b=fG91AifZEFYTCS+LoosSYv6DpOgBvAXsDlFOhtL9SQbzqpMhYrNz3DRcxaDcJ3ighC8taaK/psrlkJ0hwpTXBAn4P4mR2xR0EBiMeCHEjFFgyMbkCySlR31rltfx5D8fcsWH/XPTkQRROwblf4+4x5GDiU2l2snxjevrGSobDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750503233; c=relaxed/simple;
	bh=Gth65kDkUA33Wz5sETJyWlyi8Pe/GaBh02usqmYjj0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLbjRDwbtti5k++cOIesg42QWXzU1HQ1mhy4btUVL1p21D8XPpdMyUFZ3U0BEM3n1mnQjiFn+qw8x7Nff7RFSQJSRFO9I5Q5+LV45ik4MA7Dw+1yh/5TBGgaK498px5Ok3ld6B6m/DZdM0N8GRDKsiFY7HHS7ob/P13TyQF7f6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnVvIvnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1564C4CEE7;
	Sat, 21 Jun 2025 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750503232;
	bh=Gth65kDkUA33Wz5sETJyWlyi8Pe/GaBh02usqmYjj0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnVvIvnNWwDX1ll2xE5AnP45dJIWZDeUjRcv7PWkw2A3DyCLNrrjRbTpm3F0IG4gC
	 k8BKgzAA7Jc4k2LYaYvU/l/A0MdT+MSIXe27MQ3UdK0Rt+ZCLYlsDA6E84OwJzKPkV
	 Mp17MBZIxtev9OwZcYBgr0vO023n67VuhwfeKOVmnYRPuTNy5/tCr8Q2Lux4NhCgNw
	 eab96u6ksBTg4Jr/tfWkleJtNa88h33cszwqeF1QRrf2I1CCbP4JzvLHcUuqR9jjGU
	 2uPEPCsFLw7PxepNxvk7Av1FjcAZXTRCOp8XsIsuhX9h6HxOIhS1urjOisTlyIURuJ
	 tGjz6M7jbvp4A==
Date: Sat, 21 Jun 2025 11:53:48 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gengming Liu <l.dmxcsnsbh@gmail.com>
Subject: Re: [PATCH net] atm: clip: prevent NULL deref in clip_push()
Message-ID: <20250621105348.GC71935@horms.kernel.org>
References: <20250620142844.24881-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620142844.24881-1-edumazet@google.com>

On Fri, Jun 20, 2025 at 02:28:44PM +0000, Eric Dumazet wrote:
> Blamed commit missed that vcc_destroy_socket() calls
> clip_push() with a NULL skb.
> 
> If clip_devs is NULL, clip_push() then crashes when reading
> skb->truesize.
> 
> Fixes: 93a2014afbac ("atm: fix a UAF in lec_arp_clear_vccs()")
> Reported-by: syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68556f59.a00a0220.137b3.004e.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Gengming Liu <l.dmxcsnsbh@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


