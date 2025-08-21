Return-Path: <netdev+bounces-215422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24775B2E97A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173DC1633B5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1B1C3BF7;
	Thu, 21 Aug 2025 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG9QwnqX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095620330
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736529; cv=none; b=CHfW1ugTgB+GpSbiZ5FlayfHiOsUbJ77nFsp3EzjTadKMYGOv+tTyrjFZ6kjCKNHiFWymM0zzn1peb8FTiu+DGTnPWOlLNJL9rVquHhoit9crVqLU86r5AdHpb7ZB92Gxy9QQbRu5w48XfcTlYVPsqGcLopLSKMvlCS5seoleBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736529; c=relaxed/simple;
	bh=AO7q8V/G4apPhyPSRSKocYkz0mZlUvmjN+/jNVCplJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIJ2qquT10M7Lyl3Q+9BWn3evrbAOx2FvYuM3Wzy48roONOUO9ffjNDDrJuUD3btl0GIgJbswzRNvvPSP4bIOAWC06zVHrJ2VxAb8jxOOu/GY/h38DLxFx+pVo23iOvGQygm7PBoZYnym91DmBvRJYB6MixDF0DHMXv4SREMJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG9QwnqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32694C4CEE7;
	Thu, 21 Aug 2025 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755736529;
	bh=AO7q8V/G4apPhyPSRSKocYkz0mZlUvmjN+/jNVCplJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XG9QwnqXc3zW4NSWLYSUyL201vQebbA1tDZWHsoR3jMGxVlCafZ7HIVSP5i7nOFtd
	 qtX3wXm77mRORBtHaw6TFKNGq3mRQPQZXs8QPd+xL0qhveDnp8v/GqUC3c+feEGnIm
	 K7OBwbhRJRt+gp3cu5W6zktd2vGWQrR+hft1xyMyoEIp6UcuqZbU9MHv1bst8bJlT9
	 E0zqvZjma2nMqUSFPiuqs0WXlXh0/cSpP08dAbcyyx6iHnQRUQSj+tDkgiFRodla6A
	 xzwu2k8/uVZSZpanmyF2t+Z5h8SxRWu2YzYp8jZtC8H/lTcXt4EyVpmrH1sUZ53PUA
	 u5KBKOjlaCLfQ==
Date: Wed, 20 Aug 2025 17:35:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Ilya A. Evenbach" <ievenbach@aurora.tech>
Cc: netdev@vger.kernel.org, dima.fedrau@gmail.com
Subject: Re: [PATCH] [88q2xxx] Add support for handling master/slave in
 forced mode
Message-ID: <20250820173528.68a5c33d@kernel.org>
In-Reply-To: <20250820181143.2288755-2-ievenbach@aurora.tech>
References: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
	<20250820181143.2288755-1-ievenbach@aurora.tech>
	<20250820181143.2288755-2-ievenbach@aurora.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A few drive-by comments...

On Wed, 20 Aug 2025 11:11:43 -0700 Ilya A. Evenbach wrote:
> In-Reply-To: <20250820181143.2288755-1-ievenbach@aurora.tech>

Please start a new thread for each new revision.
Change subject to [PATCH vN], where vN is the revision.
Add

v1: https://lore.kernel.org/20250820181143.2288755-2-ievenbach@aurora.tech

under the --- for reference to older versions

> Cc: dima.fedrau@gmail.com, "Ilya A. Evenbach" <ievenbach@aurora.tech>

The cc list is still pretty sparse

> Subject: [PATCH] [88q2xxx] Add support for handling master/slave in forced mode

the [88q2xxx] will be stripped by git when applying. Please look thru
the history of the file and find the correct way to prefix.

> 88q2xxx PHYs have non-standard way of setting master/slave in
> forced mode.
> This change adds support for changing and reporting this setting
> correctly through ethtool.

imperative mood:

 Add support for changing...


> +/* Marvell vendor PMA/PMD control for forced master/slave when AN is disabled */
> +#define PMAPMD_MVL_PMAPMD_CTL				0x0834
> +#define MASTER_MODE					BIT(14)
> +#define MODE_MASK					BIT(14)

Other defines in context seem to be prefixed with  MV88Q2XXX_
please prefer prefixing local defines.

>  struct mv88q2xxx_priv {
>  	bool enable_led0;
>  };
> @@ -377,13 +382,57 @@ static int mv88q2xxx_read_link(struct phy_device *phydev)
>  static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
>  {
>  	int ret;
> +	int adv_l, adv_m, stat, stat2;

nit: in networking we like variable declaration lines to be sorted longest to shortest.
-- 
pw-bot: cr

