Return-Path: <netdev+bounces-99812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643C8D6907
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FDA1C23E32
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0717D096;
	Fri, 31 May 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOn+msaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862D1E498
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180569; cv=none; b=QFZwB3ylOmUS6TtBVE1EC8qR29yDspctvQaqQyKWpsliL6AJdnbsvQDMyBgLBRCXv9349agpWTnNe9dPbx3Q317v70UTzk3wvKxEuXJQZP3lqx6tQq1LaRz/yG13/TDxG13DZHeVCrG8219duegzQPeMgNhGCn4q/lQ/iPZs1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180569; c=relaxed/simple;
	bh=APZp/Sg/IvUU6X9RIdHMs+5h8MyNDaJVSunTiD6hDCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyNXa6+wLnPNcIY01m8/xsN8xBPqiDwkpGqAwpgdIzqV2R9YWDYpvGOP48Sn/ChK9C5oDQ98gzjIw6r+ZmC/P+OrwlpcJxrvj5UwnB+gEI1pD5rXlePya/LodTtMh01krQysiGcrGFLn1sqhppyId4JCIPqTtvb4EKtkRMMT/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOn+msaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B666AC116B1;
	Fri, 31 May 2024 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717180569;
	bh=APZp/Sg/IvUU6X9RIdHMs+5h8MyNDaJVSunTiD6hDCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOn+msaSKfqWtW6MxJljDTwYafz6gzYTntS9ycyGiGy3ViaJ4/xdM74g5+F8Gk8v8
	 yU++uHmBmKdWxpYYH3pR2Cieu1Z8T7tSYlUag9ixkuAUVYeqZnLeYNeNOhDJMnVKl/
	 F9HYTcCp5cqTnkCcrZ/uPGXZIn5OsQGubLIhNagrFT42qYhDY6U6bQzsaOh4HXqaWm
	 r/bg91pkRb03Wv4tLXvjYdfU02SlNtfXpP48tR+X1b48EsbP6pbd5rGaGbMVwbIyhR
	 At4nxX/0Q0deWhbtgy494Hr2f/ureJ9DMJCcfk51e1RXD7MBY/MjnksiZjstAhw038
	 hS4wxLSUYMmIQ==
Date: Fri, 31 May 2024 19:36:05 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	naveenm@marvell.com, bcreeley@amd.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net v2] ice: implement AQ download pkg retry
Message-ID: <20240531183605.GS491852@kernel.org>
References: <20240520103700.81122-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520103700.81122-1-wojciech.drewek@intel.com>

On Mon, May 20, 2024 at 12:37:00PM +0200, Wojciech Drewek wrote:
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> to FW issue. Fix this by retrying five times before moving to
> Safe Mode.
> 
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


