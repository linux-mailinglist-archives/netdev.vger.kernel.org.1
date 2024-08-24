Return-Path: <netdev+bounces-121653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CF95DE3D
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E318B21EA8
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966711714B2;
	Sat, 24 Aug 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5irSxDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72576155758
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724507920; cv=none; b=tW3GhEgFEihext8Bf7GjIhzWtN9w4mjW5cJBNW0VXiblkUSEcs+hw/ILDea6tb+hQfkdvDUUAK4iurCnwyDXOxpIP+lkgjbcNVmjiygbOWOwy7EPnyiuNKU/opURbvQcTPBysFNaqO9gklouIHcxcLPbLO1XYPudhEuS5nvVIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724507920; c=relaxed/simple;
	bh=MyaHm4/jqfyXmm+qOcdwO0g5N2J//Qv06F//5xrumO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4tkxdzPG3x4MhKYdXYoavEKIUjE+dphI8CMJgh5qoizV3qC0QIRawq5SXKQt7ckEEE/2SFw3g2JhFS/JzPM6HxUnbOhCUlvzYkPuEaxqblDjDZthMKASnYw336UHP82VARXdQQcZ5NLimt6Eze6b+VVc6DpOXFKrOMf3wK2FN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5irSxDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8FAC32781;
	Sat, 24 Aug 2024 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724507920;
	bh=MyaHm4/jqfyXmm+qOcdwO0g5N2J//Qv06F//5xrumO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5irSxDkcoxY/xqZdBbkzHelgjOWZlhGRo8NmbxiXowskXHVx0NcdipvKimljPk19
	 cB5Xo8XRzA30R4n4IioqXB3C8YpwBhusk7N7xPmAB0sTc4xbKkbsfPNEtjLSmm6QFc
	 sb4L7n/iH/eqU8r7U6yeAHPB2ByT+mwbIcgvRPlerHm7fpdpTO90SP8FXOcsY450Jm
	 Lkc7Rog9Ottwi0Q4RHjdk/hIWXonO0Ptux2qL7ZUT33mZyritQy0vzU5xMDKGdOHTt
	 kLUKlVksR/g2jHN2qHyrmsJtFtTgsYlycTuzHazjcUv0i1VeG4v0e6CRYvZ5QWJuiQ
	 x4JKb+7Sz/sgg==
Date: Sat, 24 Aug 2024 14:58:36 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net] ice: Flush FDB entries before reset
Message-ID: <20240824135836.GL2164@kernel.org>
References: <20240805134350.132357-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805134350.132357-1-wojciech.drewek@intel.com>

On Mon, Aug 05, 2024 at 03:43:50PM +0200, Wojciech Drewek wrote:
> Triggering the reset while in switchdev mode causes
> errors[1]. Rules are already removed by this time
> because switch content is flushed in case of the reset.
> We can avoid these errors by clearing the rules
> early in the reset flow. Remove unnecessary
> ice_clear_sw_switch_recipes.

Hi Wojciech,

I think it would be helpful (at least to me) if the patch
description included some more detail on
1) How the current flow results in these warnings; and
2) The new flow ensures resources are released.

> 
> [1]
> ice 0000:01:00.0: Failed to delete FDB forward rule, err: -2
> ice 0000:01:00.0: Failed to delete FDB guard rule, err: -2
> 
> Fixes: 7c945a1a8e5f ("ice: Switchdev FDB events support")
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

...

