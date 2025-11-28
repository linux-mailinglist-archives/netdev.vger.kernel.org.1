Return-Path: <netdev+bounces-242497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0883DC90BAB
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 04:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEF83AD4F5
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0C2D7810;
	Fri, 28 Nov 2025 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtkId/SY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623C2D6612;
	Fri, 28 Nov 2025 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299681; cv=none; b=IDrvPaH8wMUxHejjYCJmz0rCP98IARy7MppMhadlo7RR+xLr1IiNJ2zugEgoVKd9G6SjcZJXR8SskeIVhryolzm90tN+37iSU/ghQkRJSQEdlR/stW6SVMCzM/CHohO+lgFh/qhATdPQe3pddymkCEnbf1KNyj3jdqlbJlTTxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299681; c=relaxed/simple;
	bh=HNwZOpl41q1uKPjyt5UcByvvpf7/4Bac8KzR9JTix2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMvNCOhrzgLC/C2rfNnglfc+HVRQRlSjrINd3qBIhJNJ+QIDRdt6KMq2oWto/c2I3yriCZTjYnvEyzzeHp0lUhCboYEyZT1r1U/e2lqlAJgs2MCCoadniDTbbh8q4u1O3+ojrv37zz3wLLdiSmyX9wkY1+8c0Dmi+0lnsjNrZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtkId/SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F87C116B1;
	Fri, 28 Nov 2025 03:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764299680;
	bh=HNwZOpl41q1uKPjyt5UcByvvpf7/4Bac8KzR9JTix2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DtkId/SY7Q6QHmWDuFUujgkKpNZY0S/wbFpLKSV/YoXtCekjtPoO/Ko6FiBR15cW3
	 2bM+PpZy+MqcdAjxtXh/4xvIzalOtVuDz9efON4fdsEliCt2QlyBBhK+zzzUqWqC17
	 BHkbYlFnBMVBvXuCReJhsWS7Ph/MxepPPfZ3JqIcLIkjYIa0EpTpYEe1FSmFC4PvS4
	 RI64c+QCp9Yo9KZT6kWJh3DmWgkSlShox7pnTs+xgAYNO9H9F6zh+skgTg6GSEGP75
	 fsHrlIQ+pB+UjzrSzKo/SOch07ZYBAfbnwwk3o1MWU5s9esB2GdXDIfgCmvgDpub5x
	 sAPHD/dJgM5yg==
Date: Thu, 27 Nov 2025 19:14:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com
Subject: Re: [v3, net-next 00/12] bng_en: enhancements for link, Rx/Tx,
 LRO/TPA & stats
Message-ID: <20251127191439.2f665ca0@kernel.org>
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 01:19:19 +0530 Bhargava Marreddy wrote:
> This series enhances the bng_en driver by adding:
> 1. Link query support
> 2. Tx support (standard + TSO)
> 3. Rx support (standard + LRO/TPA)
> 4. ethtool link set/get functionality
> 5. Hardware statistics reporting via ethtool S

>  13 files changed, 5729 insertions(+), 50 deletions(-)

This should be 2 or 3 series, really.

