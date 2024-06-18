Return-Path: <netdev+bounces-104643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13B90DB3B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A118D2831EF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240A13D880;
	Tue, 18 Jun 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5Arj6x3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B713C8E5
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733792; cv=none; b=TO1fm1e263FWNjqoIgYLPlFhrhPIO7YRBuUuo8ye5r6bNHgEGP0Io77vBWl3Grya9OMA49FOVbqe3g3ayzoBzcPuu5vmqwSfsN/6gVD4WdauzdMWYlIc/lvQXk87w8YhHdZFM/SEzmlsI8qRV7BbYLkAbxkKn1YB76HIzh5MBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733792; c=relaxed/simple;
	bh=KhhrNVdzKpZwo7tgWmaHkM6zH0KI8e8QiCWYk/t55gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmBFiHBWhVttSXXKbYxAYM/7rWXQnbVxNDoXVtYrTFySG1OvuyEwpJXe1eryk0DQ7/kFSevKg+L5gh5W6nl4/uNln3DeUsBO1ZL6u2lWv/BJAWCVPMA7d9Q8Iz9WWsrjynmN88q2SPI9Abm8bGxQABAGppGV5aW/mixUug4Hw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5Arj6x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D98C3277B;
	Tue, 18 Jun 2024 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718733791;
	bh=KhhrNVdzKpZwo7tgWmaHkM6zH0KI8e8QiCWYk/t55gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5Arj6x3DRPkiHBKNKyvSusOzVtgtuQ4QVCkxRi2goH03LXqNz0NJ/UaZa0HRdlpA
	 iUywqiv8UgnxryEcUS5ZGCUXpLBM73+rLu/Oe5QoummMRJ0L7SPJe+3eE0Nxf9U7NN
	 qlJETTEYlwKSE3N0GxQuaaDCO/zsZudILuhm3Zr4E5bcX59+guCSsyfvP7rmVVpsGQ
	 6u4qDGJfM3uZMqnjRXG1CHGrmIbg+i0latWNUGQBs/YWYvvJPaucr/O6qodXHLxAlu
	 UXQxFD7DFjRMEujBcJqV1r5bo0K9EquX77ULGNTrF5+JmFx/ASfqv0ZdX4v3xQ5GCa
	 PWE3j/l9CJQOw==
Date: Tue, 18 Jun 2024 19:03:08 +0100
From: Simon Horman <horms@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] net/mlx4_en: Use ethtool_puts/sprintf to
 fill stats strings
Message-ID: <20240618180308.GV8447@kernel.org>
References: <20240617172329.239819-1-kheib@redhat.com>
 <20240617172329.239819-2-kheib@redhat.com>
 <20240617172329.239819-3-kheib@redhat.com>
 <20240617172329.239819-4-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617172329.239819-4-kheib@redhat.com>

On Mon, Jun 17, 2024 at 01:23:29PM -0400, Kamal Heib wrote:
> Use the ethtool_puts/ethtool_sprintf helper to print the stats strings
> into the ethtool strings interface.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


