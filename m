Return-Path: <netdev+bounces-93494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403088BC17F
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D87D1C2086B
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0028E0F;
	Sun,  5 May 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njLXPII6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C41DA3D
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920578; cv=none; b=NiP+WtDn8Cqv+BsHjTRodM3iV6h3F7yuZFq5kFxiICiMlPH3p+zZHylrd/8Da8u4qATsa40ThO4iuNucJPF4wxG5wu4yQey6CmoHsyQAiW0aB09Kl+TvTwlhwC4hj89ZBT3K+5cXRkrPuXLksQRU6yxFZsyZxq5WTc94dvmYIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920578; c=relaxed/simple;
	bh=wV+nis0KaWy/RFcov2pno1hpzK5UYB9yBr0xrAkivbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y64kPllKMpI9i3ix8rwZ0ctYLQk2Mop95cNllf6cb8eDD5HcsmVfgtOHVr+bdaHOk1s1a0wVh/jPZko2Yjt44Sr7g3ERJIxT3PNDmzmUlpswDKAbXDne/2TlXt6rrqF1kWqNaXMsp50YJIQdK8pxzQnLYk/f59vam7zi0FhrA5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njLXPII6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4C3C113CC;
	Sun,  5 May 2024 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920577;
	bh=wV+nis0KaWy/RFcov2pno1hpzK5UYB9yBr0xrAkivbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njLXPII6i9ZkiuUL7Uv8Z6eVVwDQQuZQa2I7J3waSHvF0ZuVUMjOHEVXXkJlye6uU
	 mvyBiizOhrusEMxMr+bX0MXVY/Ey5ydqzfGO3KHzT13rAfhMhhFnHQq/nWbcrlDrsd
	 bXlUP3s4JUdqlqIrJNUSqI/Iy95RQEcDk3BeN+OqSL+ANrf575BCyjD6Qe+C/h8720
	 EDpdc76HuFPitUUfFYH836zaJoMaOUySz1plzM0GAryMN+fzWyh2TCi0YIMkjbM7v/
	 AW+S+/FmiZvSU5u+xuzoroOiczup879CKpINR2iuFZ1ZkALCKBDrmEJeVboudMekqQ
	 /zj7JACHjwl5g==
Date: Sun, 5 May 2024 15:48:03 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/8] rtnetlink: do not depend on RTNL for
 IFLA_QDISC output
Message-ID: <20240505144803.GC67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-2-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:52PM +0000, Eric Dumazet wrote:
> dev->qdisc can be read using RCU protection.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


