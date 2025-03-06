Return-Path: <netdev+bounces-172544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5416A5550F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6847A34C0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF8D2E3387;
	Thu,  6 Mar 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRDaLGzw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881E26B2DC
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285943; cv=none; b=kvFKMZmKACNwU3Cf2tNrOwkND9qfM74o5A0l7GsEKrBwKvMwp4qptKxKobPz0Jl2JC0+43/oGQP+swWt6zd+nA0I0Fjf0Wuw/Y3feiAK1qrsb+NHF//b/fDrY7GJkyCbn4PYEPGP9vwFk38PqWDg2JLFqmBHrE8ujGoy43uN+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285943; c=relaxed/simple;
	bh=dV9Xb1hC41imf9M9/jOE+q0X5l1P8MjD0QU/CyG3/ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGFWXNur15R80T1U3bWoUQooIXFzcgJAewvsu7pcCEu40Cbcv2QY9T56siGYAc+UBSASovpTxH05nVFoqcnlJ2ZhGj6Npohy1XocTTSOBbGEYgzexdhSu70n0nlbHDFw4QaHrsv7oqqhdLZZPBKuxIbYyEM02Wz1z6Zj/tdFjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRDaLGzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DBFC4CEE0;
	Thu,  6 Mar 2025 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741285942;
	bh=dV9Xb1hC41imf9M9/jOE+q0X5l1P8MjD0QU/CyG3/ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oRDaLGzwVOFYpFKiKF0JWTzoHl8VJ13UAQHYC2Xx+34QIYmi/1WlfPFGYkMXZSytD
	 1h4tPCVfE+Dcn7YfUO3pbF4DUwgP0K2giRGVRWJMjRCaSruMQGk58zLKTrvwIHyZdE
	 2a4YnTYk7KyslTytECEvWx5cRRVte0Viqja4UBteNWWZlPsERrhKRT4SyokNWRX6Gq
	 omivK2ctHk/cZEJ3g9+pSnOsOGL2syvg0ZPlay36UMVCrb12dUZdLLt6aQNJPfoIwy
	 WMOHmNFVYMKTrWd9qG4MtxzVL4/H586xMeXEbC6cGB/Iz7i/OVrhVXkPeGDPaSXuQa
	 IZjsPBjoYw8sA==
Date: Thu, 6 Mar 2025 10:32:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250306103221.7bde935f@kernel.org>
In-Reply-To: <amselxwxk5wimldqon5pwiue2canabbbzebrtb7um3osmnjsue@immvwjergd5m>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<amselxwxk5wimldqon5pwiue2canabbbzebrtb7um3osmnjsue@immvwjergd5m>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 13:47:27 +0100 Jiri Pirko wrote:
> Thu, Mar 06, 2025 at 03:30:16AM +0100, kuba@kernel.org wrote:
> >On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:  
> >> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>  
> >
> >Too late, take it via your tree, please. 
> >You need to respond within 24h or take the patches.  
> 
> Can I repost with Tariq's tag (I was not aware it is needed). I have a
> net-next patchset based on top of this I would like to push.

My knee jerk reaction would be to say yes, but we really need
to protect the sanity of core maintainers. You're both working
for the same company, you should be able to figure this out
between each other. We expect main stream of mlx5 patches to
come from Tariq.

