Return-Path: <netdev+bounces-13127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333A73A629
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341B21C21128
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F71F17F;
	Thu, 22 Jun 2023 16:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB733E557
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8452C433C0;
	Thu, 22 Jun 2023 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687451724;
	bh=x/Wd6PrxzYI3rpvhusukXY9JQpF34iVnv0SJF+41EXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBXkMt3jO0/CGozRabKRpblI/PITPaKjskaZlW9UebLfle2mta0zFuY0TlZi7K/Md
	 ssKVlN5Xt5pk0wFCHDB/boWOEjz8YOoI98Lk9rcrCV1xYelyvxbJVvgyi5yg44faqs
	 h7x8PYxFdHO2UZr2unU01HFhQlVfxuTJn5My2FdOwa2USITQh+PtgJ4mRV6vSwXlK/
	 5pu5VcfVNdzuqYv7BWctbnYFWslU17WiqJasLiOASNsvssYmZ3FGSA8rA/FkCWY68e
	 QabDeL/d6rAIPJxNEqQXtU8/FBcjWJfVJKIRuP2pn6e+2t/nQw3LjRIG2lQDMtHkAN
	 5QJkgluDNyNiQ==
Date: Thu, 22 Jun 2023 09:35:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <20230622093523.18993f44@kernel.org>
In-Reply-To: <ZJPsTVKUj/hCUozU@nanopsycho>
References: <20230610000123.04c3a32f@kernel.org>
	<ZIVKfT97Ua0Xo93M@x130>
	<20230612105124.44c95b7c@kernel.org>
	<ZIj8d8UhsZI2BPpR@x130>
	<20230613190552.4e0cdbbf@kernel.org>
	<ZIrtHZ2wrb3ZdZcB@nanopsycho>
	<20230615093701.20d0ad1b@kernel.org>
	<ZItMUwiRD8mAmEz1@nanopsycho>
	<20230615123325.421ec9aa@kernel.org>
	<ZJL3u/6Pg7R2Qy94@nanopsycho>
	<ZJPsTVKUj/hCUozU@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jun 2023 08:38:05 +0200 Jiri Pirko wrote:
> I checked, the misalignment between sfnum and auxdev index.
> The problem is that the index space of sfnum is per-devlink instance,
> however the index space of auxdev is per module name.
> So if you have one devlink instance managing eswitch, in theory we can
> map sfnum to auxdev id 1:1. But if you plug-in another physical nic,
> second devlink instance managing eswitch appears, then we have an
> overlap. I don't see any way out of this, do you?
> 
> But, I believe if we add a proper reference between devlink sf port and
> the actual sf devlink instace, that would be enough.

SG. For the IPU case when spawning from within the IPU can we still
figure out what the auxdev id is going to be? If not maybe we should
add some form of UUID on both the port and the sf devlink instance?
Maybe there's already some UUID in the vfio world we can co-opt?

