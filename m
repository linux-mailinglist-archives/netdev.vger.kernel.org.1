Return-Path: <netdev+bounces-99805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8D8D68D9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784CF1F25454
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10017D352;
	Fri, 31 May 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZWZCKnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E417CA17
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179451; cv=none; b=A+DnTpuoy+CWWfj/w/BYH9i0nMXy2myY+Vrx04JW5er/H7P0R/js2YoFIN7MJf/bL4bB5ORFhJDRrxwHgilzQQhG6V0x38pJoUkJg6ZcLNykzrHxUukelSO8uYzYitiGSExNq6fuWGd3NMpCXdlhJ2tBBz+WHK9bWhXMQsvAJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179451; c=relaxed/simple;
	bh=W/omXzBzUzF7Pk0fUDiQJKOo7GEZcS//QRExZnWoq8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePqdWaTYLmS97sLhe6Dc8yIlVa4+H3qIIhLWFrvxNC8ELZrSexImv+Rl57tJRU6duhxkzmJq+x4Y0Nf9wSwdhejZFZTkOmzuMyAKYboU4X7z/ueWlMZUWpHgJUe7qszLXyqqDWvQGoTK4jSP0VYyNOZGP/bm9GhDx6nFs+tZa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZWZCKnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B40C116B1;
	Fri, 31 May 2024 18:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179450;
	bh=W/omXzBzUzF7Pk0fUDiQJKOo7GEZcS//QRExZnWoq8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZWZCKnXPR19qBWCn4wnj6LherYSGqC5ZinZUqJlbUpwIE0Zp+9w8LZbLCHm2I1h0
	 mX8fEOe2cPuTYYY52vrAX7pe/b/4CK/+9NNrN1xQ1sqC79eCWaZqLL3Lljb6sYUPjW
	 OpmgeF3exyKvT3bGTTBUXvPqftaq84enNu5EOqxu4L4/RQIspgDIuU0AZD6+NfeHR+
	 K2MUqcH65LLA8aEjkYm7Hy9hB3PP3z5EzxlFPysHMja1pOg6Ovurvojlv2dubgom5i
	 16PGPNxjkWVFXbLibCTwZeVPx+k0Qhg96PmlaX29zJia+flQ/UDZy6H7AMtkoXSk+U
	 uiSAv/fFly9vw==
Date: Fri, 31 May 2024 19:17:25 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 10/15] ice: don't set target VSI for subfunction
Message-ID: <20240531181725.GM491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-11-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-11-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:08AM +0200, Michal Swiatkowski wrote:
> Add check for subfunction before setting target VSI. It is needed for PF
> in switchdev mode but not for subfunction (even in switchdev mode).
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


