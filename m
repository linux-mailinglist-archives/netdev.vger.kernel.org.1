Return-Path: <netdev+bounces-108211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99391E5DA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42931B28096
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161E116DC30;
	Mon,  1 Jul 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWojnd3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEE15E5DC
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852744; cv=none; b=oNiQO0grJmJny8sZUO39ljOY8rcWe481iQpKj49caCl+pUW0rbKOCEnEyspbBy4jJo+PDN1T/AOZuzcym302CHbv7XNDPk1E6mihDLFqySci32RLxhZoUlRJtGVG+pg8dbKjitMHKmlj7NPeYEFdsA/gJz2D40LYV8JVcvAZX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852744; c=relaxed/simple;
	bh=OO5BddTOzU4MLowLv5gGnciASTzd1P1u5eu4NiEuR9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIZp2rdbg+/WmZPjBudIHkIfE3UauofTibuUfSAyUAOAnOeIah/sspT7xdlAhrUTd2nTReTV9aviGHrR1zJ/uQodiCjPqLpE3FeT87uIIRY+HRcO9AIIV8YjRAcDIK1jdzgwguXIp632b7vvpWYbmOicTO+sj1RvNH3GRbJzKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWojnd3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40350C4AF0D;
	Mon,  1 Jul 2024 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852743;
	bh=OO5BddTOzU4MLowLv5gGnciASTzd1P1u5eu4NiEuR9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWojnd3+6+oawxA2iyT7b3tMlX1qFeubAfCaSKeUSxELAzbAg0sAJpobovDs85QlZ
	 TKBwh2ap8jkGMFvWznkW0cq1ywVOLCD73Fh7ah2Op5DhGhWZJ8+YXVbmDydTPSWcTO
	 UUYLJ06rOmIhWfNZJHMYVUVJOZD2zM5CMyl1S4pLfM/B9dnrBAx+iTJidet9kNSIst
	 K9sOZf5pOUw6D5KYBRb69/ZKIDDvA833PuE2lpreystw4BndnxhaYPEhkmRui+rUI4
	 MbJ62GJvM+8UtnKng/YjpX9s4VtbYnJU4OItulrdVeWTmfo6iw8Ks30CW0cxaI9+uS
	 IUmNESnjRBiRw==
Date: Mon, 1 Jul 2024 17:52:19 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: Fix recipe read procedure
Message-ID: <20240701165219.GA598357@kernel.org>
References: <20240701090546.31243-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701090546.31243-1-wojciech.drewek@intel.com>

On Mon, Jul 01, 2024 at 11:05:46AM +0200, Wojciech Drewek wrote:
> When ice driver reads recipes from firmware information about
> need_pass_l2 and allow_pass_l2 flags is not stored correctly.
> Those flags are stored as one bit each in ice_sw_recipe structure.
> Because of that, the result of checking a flag has to be casted to bool.
> Note that the need_pass_l2 flag currently works correctly, because
> it's stored in the first bit.
> 
> Fixes: bccd9bce29e0 ("ice: Add guard rule when creating FDB in switchdev")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


