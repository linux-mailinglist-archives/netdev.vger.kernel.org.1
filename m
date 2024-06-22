Return-Path: <netdev+bounces-105823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C6B91312C
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 02:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB731F23735
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C672A32;
	Sat, 22 Jun 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXAQUwSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573567FB;
	Sat, 22 Jun 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719016439; cv=none; b=X6QRh2Q91Pfkw9N+IzV8hWuRgTTP4+VuaD9flCx64kO6R6a5yO+B2tBIA5wgugHZbOGAxQany/qQ8BBnJVtxpFgCGO3bszVK8Aa4KWf1YKOitpWoO+tEjJfy/acjkvgUimQImBgw5XtouOg1K5DHXTqkcsXhQbB26YTSECtNP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719016439; c=relaxed/simple;
	bh=1UQ/3HLxAuk0p5S3ALFUJTzXk6WXfVAQ8KIlf3/bj10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOAHPD4S/NnOgHBwQXUoHZMpb1sAbAqSUXlZ4Tv/xyGNJodEoRPppLKE29hPoKs+A49QzmAdlXvLhYIMTfDTWigc4S8qgGjl8HijK0JF5GjJqMZZ/Pnj59WrTS38y7laGjmO7VSF9jKfXErsuUJimpfxB8jKvg058EJ+icwHGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXAQUwSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A52C2BBFC;
	Sat, 22 Jun 2024 00:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719016439;
	bh=1UQ/3HLxAuk0p5S3ALFUJTzXk6WXfVAQ8KIlf3/bj10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BXAQUwSXQ69T5EHhtqnHIdm2XbMatQIr41bySNQqSE83yp6G5lcbMO/tjr121hKh1
	 VCtQZ1V9PxMo4IAvkvqnTyuTv9l0fgh7U8ypBdsW7nlabWeNnOW7rztnQYCqpkfRtK
	 G/npx/9tLV3/QlXwidZD4jDAz211XUoiB1RFsh07Fx1aQ+JlZYhsY1rbUzoSc83KSb
	 5aygPIw4dqAJLiZ5pVnllAT82ZiBaBQq7Fc2J2Hh3x7DqkM7UXjD4MDLSkbpXonLVn
	 uPUbGhd8oNcNcxL4NPTY45zbk6iRxdSmnMbjG0EdpCUxxe1NmWNrsO1V7TkL2EGR5w
	 LcU8V38rbYulg==
Date: Fri, 21 Jun 2024 17:33:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net: virtio: unify code to init stats
Message-ID: <20240621173357.0f383e1e@kernel.org>
In-Reply-To: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
References: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 03:44:53 -0400 Michael S. Tsirkin wrote:
> Moving initialization of stats structure into
> __free_old_xmit reduces the code size slightly.
> It also makes it clearer that this function shouldn't
> be called multiple times on the same stats struct.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hm, doesn't apply?

