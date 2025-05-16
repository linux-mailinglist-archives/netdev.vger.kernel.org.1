Return-Path: <netdev+bounces-190984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422EDAB992E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92F3503548
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F4230BFF;
	Fri, 16 May 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbioaSo5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751D18C008;
	Fri, 16 May 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388690; cv=none; b=kjO61Rr08ElnH8AHOKZQ0wWJGZgxvkH8o6NEnE5LDucRiyjaHpRiJWTrXrOInpvT3/W99n5lBQ7hmeny5MlO8OXH3fKy0oJlLQJbu9jvR1WuMAYj1Aaf8RBqaFuI/wyh9vjQHOrPe4mm7oa/2pohyNU73+EKaInVsYamJrlx0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388690; c=relaxed/simple;
	bh=NgSUy9/TUIWcSc5wRvHR2evt/6x18KOmHbwGmpmLoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8On2Uhn6uefclmm3TtlqYw0SxZRoAvqTo/1rI/Qv0+99iFccZDvMPWzmh7PCqbGWZF7GJty2s/zH0yWQbTpXe6hQMKFS/jonq+Wt4LXVBsohQe2/UnVkHPuiC7ibLpv/YreRskR48fuwCS+5GnpYFoYk0ayO5PbnItkPvgkWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbioaSo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A009EC4CEE4;
	Fri, 16 May 2025 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388690;
	bh=NgSUy9/TUIWcSc5wRvHR2evt/6x18KOmHbwGmpmLoD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbioaSo5jdwYLplqu4qjleDpg7E3MRGdBCFcOZCA1NAgPou9Z9VFkUijLpN6mdwU2
	 aiilv3a8Eb96BbiSiPsJp8ehkhIPXS0JVTRlopijJuhJCz4SCQYf+P7ToBRkuYn2Gn
	 kyDZtN4UAPcb3txZLn7laY1bN8cHh3H7aIPQ0RlREFXP7cXvlAgLovlMI+M9pmH9Nw
	 VMJYvJa3TdiFngC6yGxVwJyyZpC5b257KQ52zyt9Uly69UavCUCWWIR4g8oG5K+yyk
	 6gtAtKYpvCJU33WoGpsIr1d9YU8KG/AW8LKrW3PSFCme21/PX99QGJUnUqSOZ/YHDF
	 8DqK3J2YdYxPA==
Date: Fri, 16 May 2025 10:44:45 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-next v2 4/8] igc: assign highest TX queue number as
 highest priority in mqprio
Message-ID: <20250516094445.GL1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-5-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-5-faizal.abdul.rahim@linux.intel.com>

On Wed, May 14, 2025 at 12:29:41AM -0400, Faizal Rahim wrote:
> Previously, TX arbitration prioritized queues based on the TC they were
> mapped to. A queue mapped to TC 3 had higher priority than one mapped to
> TC 0.
> 
> To improve code reuse for upcoming patches and align with typical NIC
> behavior, this patch updates the logic to prioritize higher queue numbers
> when mqprio is used. As a result, queue 0 becomes the lowest priority and
> queue 3 becomes the highest.
> 
> This patch also introduces igc_tsn_is_tc_to_queue_priority_ordered() to
> preserve the original TC-based priority rule and reject configurations
> where a higher TC maps to a lower queue offset.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


