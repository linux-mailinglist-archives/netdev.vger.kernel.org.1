Return-Path: <netdev+bounces-75381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B1869AA4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C211E1F2483E
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8F145B0D;
	Tue, 27 Feb 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3BSgYIX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91611DFF5;
	Tue, 27 Feb 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048479; cv=none; b=rLBqOe3vcMhd1/5frVon7fo+NK06jCPc93ArWjY92k+T9lfjaaZ3y4W/ay8VL57kCHFDGAttlntky6McAKryGmv2OukLrq+WMPnGwMxxTygk1EfmLmErlvLOWUwBUt3FKHDX1OZDXs7jwBN4QgJF3K5df8FtwckTBMJ2yrSMi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048479; c=relaxed/simple;
	bh=dbYKUrsiEZ8AtrtFqQWsUVE2x5kWHMwMiErSa6C5Ycc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R783la9C3ZtiCRePMDiV+77KclntfuWBtLE3C0Jp5uwdUGB117ayyOH1zYFgROc0drB5xeHJiEW3TPZKwwFslZpjwu7I/uEYtjIRqq6GqvDtxbjZxrfrKQCSxFPF+qVAZmbjxVBu9d8vm8gJvxKP7J/4uWyjbezDezjLcKSzAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3BSgYIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69EFC433C7;
	Tue, 27 Feb 2024 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709048479;
	bh=dbYKUrsiEZ8AtrtFqQWsUVE2x5kWHMwMiErSa6C5Ycc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c3BSgYIXd8X3GgeAi9jLtvYeAsulcy/BZBKGSemQcTSl58YPBIh3mhtr1T4ZM08rH
	 NNAa7zatUH4u1jxY/tWRfcUSsFap68cjFndtftznmWsQ+4fPeFKxZ+z5ynb0ZVxxJG
	 UGLcqKnF0KUcjUYC4yI52CpFNK39qUKqgs/uKFfPmEd/TfMQBpkh9F8UIcNxLvnnUw
	 fzZfPaNsO86xAT2VDlUt/j3+BNWKdGe0OepQJwdwvxfIJXgEx8Gd+CrO3CkyE6NNUl
	 p4srMTKXKNk2QxfdeFJyasoefexkJMaKy7OgBZ9Zqmj6ROJtX0WuEtPxrOGAFV8aNB
	 N7ZrwOKLLDThg==
Date: Tue, 27 Feb 2024 07:41:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <20240227074117.128af8ca@kernel.org>
In-Reply-To: <Zd36oZMvIvqtNSzr@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
	<20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
	<20240227065424.2548eccd@kernel.org>
	<Zd36oZMvIvqtNSzr@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 16:07:13 +0100 Jiri Pirko wrote:
> >Please wait for this API to get merged:
> >https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
> >A lot of the stats you're adding here can go into the new API.  
> 
> Can. But does that mean that ethtool additions of things like this
> will be rejected after that?

As a general policy, yes, the same way we reject duplicating other
existing stats.

