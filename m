Return-Path: <netdev+bounces-233692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E83C176D1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24DA404CCA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85E3090CB;
	Tue, 28 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIb/lTpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4112FF177;
	Tue, 28 Oct 2025 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695805; cv=none; b=u3+JmzF7NYvFGmeRPtM8U9+XvibBetQNWpuGWj7L1IHbUIvgwYlhQacEZEKaf+iS8Xq8PS8x82PzC/SMHMWYnfOBOwvTVijMATyu26dGLnmgMaIM8DHk+0w2Qr0XdURnixzkpm+opvgUGOdWamIGktESj6Cqw77IHh5mo4Z0GOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695805; c=relaxed/simple;
	bh=r3tatAHPgaGmk+xL/lY2K+oGmVyOYNcBx5cflnPIndE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXaoWvlqBayRWg/05YiMtNVcEkxgDI9dIt+qNUSFtGhqfC2SPNvB+2hpmlaHpF2V1+9NaxxSzFUnSub3OjfQxIATz3uWx3d2gYzsyZSgFynPoENcZp22uvdZtqWeV9DDCt5dbaZZBNVhOf+m4st4yBNwJFXNj5dAc/9DPKq92WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIb/lTpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277FAC4CEE7;
	Tue, 28 Oct 2025 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761695804;
	bh=r3tatAHPgaGmk+xL/lY2K+oGmVyOYNcBx5cflnPIndE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HIb/lTpf1B1fCqU0GhLzxjcgTOOTr3Z8qWIKKcN5yLkM8fHx2zF+ez7SswHLToPQq
	 r+ZRw2sYyI+XtIg/yebFV8u/0ye1bvYUMqP1VRn00VT9NQtIdWyBIDYuqcnEmIgyVx
	 uBzG3Fm4d9JR6Cp7jFWfYjvVxPWBP3fpKxAWy2Q/xoAIn1qoK9xnebSDNyVSkPlhxm
	 KM413pPtGBcBWAwCbHWZAd31mcN9QMNeeig1mUUdeb9P8xOEfDvV2mi6/PB9VMGe/U
	 cpQGwT6rW9jMnXx/REvq0M4SHmGTBNgpNg/2jLfUlA1FH1yLpK2zFu6HcE+pJnXOY3
	 AnyjCp2NSGI1Q==
Date: Tue, 28 Oct 2025 16:56:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 Frank.Li@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/6] net: enetc: add ptp timer binding
 support for i.MX94
Message-ID: <20251028165643.7ae07efd@kernel.org>
In-Reply-To: <20251027014503.176237-5-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
	<20251027014503.176237-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 09:45:01 +0800 Wei Fang wrote:
> +	struct device_node *timer_np __free(device_node) = NULL;

Please go back to the code from v2.

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

