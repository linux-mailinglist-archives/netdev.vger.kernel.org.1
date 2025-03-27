Return-Path: <netdev+bounces-177990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5FFA73E14
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AC617A0DB
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5D2192E1;
	Thu, 27 Mar 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg/6b4Hg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD1140E30
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743100853; cv=none; b=lmBBtIKhuAIGzZy4IOjZRdG+peVLmzrdSVOGS6m/U6M6vM8uzWxDb7nYyaNIYMaX7T6mqhk8v1UBu6cb0WYjMGKQR38PohrJ7qaHMlvv1ZvqjYOkAe62DkkvYJqsJ7b/SOphWNiBbmZuoQjremUC7EfzwmdTje9qyDxpj7Tz4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743100853; c=relaxed/simple;
	bh=KczP247zmAJOV35Uqb6SRSWuoVseBTvPiybrBPiZ/4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjGnJEU5jHc6zJnnJDGFlt3AgMrpmSnc0z1HerrgenU7LgsEWpHKjB54l0Be92nItXpJn4yIMbKTEI2K56EUfRCIkb2ApmyX+UlMwOc9s4UwxdukprtbPKBDVJ2E0+KJNrxtpK2jT1r+gCKFMNOpMjgX7iqAU1kitMOtNC0Qb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg/6b4Hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8869CC4CEDD;
	Thu, 27 Mar 2025 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743100852;
	bh=KczP247zmAJOV35Uqb6SRSWuoVseBTvPiybrBPiZ/4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rg/6b4HgKNkVLeY3kJC1yTTxVIjfo397gZTLIERlSbMlcxgO3pO2TOseUOF4nlhYm
	 nT6OCqMmQ7qhWgaV8t+Bq4n4M2A2k8gk2O5KxOY3+xq8Pcs+PlGkh2UR7qFT0Kl/Ru
	 o4tUpX2qQpFlS45KC1Mho1lD3y1Kb2K92v0qZrJR85PNd66k+0OgP7rQZlT3M7+2Yl
	 5s+AQB51nPKqD7/mgCN7EliZlr1uhlDhFxP3dfzwh8MauIZVi1uW1fwVSPGJ+fZGB5
	 t4r626S/nO6DIYu8s3vIIZCEuE+ZUlgha8W3C3o5sFcYVRi0S4Bc9qpg9P9hLMesXP
	 2IyCxNeVYithQ==
Date: Thu, 27 Mar 2025 11:40:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <20250327114051.62f12283@kernel.org>
In-Reply-To: <20250327135659.2057487-2-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:49 -0700 Stanislav Fomichev wrote:
> Cosmin reports the following deadlock:
> dump_stack_lvl+0x62/0x90
> print_deadlock_bug+0x274/0x3b0
> __lock_acquire+0x1229/0x2470
> lock_acquire+0xb7/0x2b0
> __mutex_lock+0xa6/0xd20
> dev_disable_lro+0x20/0x80
> inetdev_init+0x12f/0x1f0
> inetdev_event+0x48b/0x870
> notifier_call_chain+0x38/0xf0
> netif_change_net_namespace+0x72e/0x9f0
> do_setlink.isra.0+0xd5/0x1220
> rtnl_newlink+0x7ea/0xb50
> rtnetlink_rcv_msg+0x459/0x5e0
> netlink_rcv_skb+0x54/0x100
> netlink_unicast+0x193/0x270
> netlink_sendmsg+0x204/0x450
> 
> Switch to netif_disable_lro which assumes the caller holds the instance
> lock. inetdev_init is called for blackhole device (which sw device and
> doesn't grab instance lock) and from REGISTER/UNREGISTER notifiers.
> We already hold the instance lock for REGISTER notifier during
> netns change and we'll soon hold the lock during other paths.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

