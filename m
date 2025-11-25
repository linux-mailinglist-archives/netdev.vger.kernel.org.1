Return-Path: <netdev+bounces-241393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5131C83549
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8034AC10
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEC284B29;
	Tue, 25 Nov 2025 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGPYTtXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE55284884
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044870; cv=none; b=NeYgI9D1k18HZYefOQrMPFAqubKV/r3LC8goex8vXRsf1uSZdDkmwOfo+eCSXG9Ejl1Y+bEf2jLJVOgZaxTk8TjO+nqArrbqAdP/O9hsIkfwNCjDwP39nPhVlkcaNvJ1IutZNkHjWTF46NjSZuZ7XdWTfzg0WVV+rJOQ/jLwmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044870; c=relaxed/simple;
	bh=AOrnJkxs1Dj7S3TVgm/O02Bpac6mqEApIiKD37xlh6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGEUqR0CVLip+VDWSbQKdm0zhOiVovJ0QZlzk0FmAtHAou032hxq6frVm9IY3wlg9uGF/a99AlD8fumItWpekHf719s/Lp008PNEFBogPlslAjbu9JZKA/+zaEmbO45fvT1E4eRInkmJLIZwmKMaCZZK9WS+qk2Wg3whviZWlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGPYTtXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943BEC4CEF1;
	Tue, 25 Nov 2025 04:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764044870;
	bh=AOrnJkxs1Dj7S3TVgm/O02Bpac6mqEApIiKD37xlh6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGPYTtXUyKAlGkSpqHOa+m5y6FuLp6TotF2ltuAfdZcJaAVwR3k/ja2kfaDZik4ko
	 4xmFJajO3baPRPYPFEqX7oxnv4NSI72Z1BYHjnmD4SShzyuyX6kiFlEMHIIpK6jsrG
	 TsBUZgi6p/ccegNDXD2sa3qifO2NFimg9feO2ufsESf+FehCzsAnVwlILlPQDpeRi9
	 mwc282/m2l3TYWWpU6cjAI/dRbrIJWdB+nt8//fvlKsE7kz1r79jTIXVsgDAi/zakH
	 dBNKd3jdwctWQ3OZdW3dMTHGCY+adUyWbJh/UGYtvbUruRmZE/6EAqY1rBmW6mOZUn
	 iuR75la8Om6xQ==
Date: Mon, 24 Nov 2025 20:27:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <20251124202748.1816f4a0@kernel.org>
In-Reply-To: <fiiqvm3to3rq6yzdvj2uybfqtolrlep63ttjtpa2p7x2p2y6xb@3wh3ya5ujeud>
References: <20251119165936.9061-1-parav@nvidia.com>
	<20251119175628.4fe6cd4d@kernel.org>
	<32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
	<20251120065223.7c9d4462@kernel.org>
	<q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
	<20251121064813.57f2018b@kernel.org>
	<fiiqvm3to3rq6yzdvj2uybfqtolrlep63ttjtpa2p7x2p2y6xb@3wh3ya5ujeud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 10:14:35 +0100 Jiri Pirko wrote:
> >> For the sake of consistency, shouldn't the name be ESWITCH_NEW?  
> >
> >No preference on the naming, we can go with _NEW, tho, as I think Parav
> >is alluding to, we don't send _NEW when device is created (which would
> >be the natural fit for _NEW). Perhaps we should?  
> 
> devlink_notify(devlink, DEVLINK_CMD_NEW); - is this what you mean by
> "when device is created"?
> 
> If you mean DEVLINK_CMD_ESWITCH_NEW, then I believe we should send it
> both when
> 1) device is registered, right after we send devlink_notify(devlink, DEVLINK_CMD_NEW);
>    in devlink_notify_register()
> 2) when eswitch config is changed in devlink_nl_eswitch_set_doit()
> 
> And for the sake of completeness, we should also send
> DEVLINK_CMD_ESWITCH_DEL from devlink_notify_unregister().

Sounds right!

