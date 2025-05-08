Return-Path: <netdev+bounces-188860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F843AAF15A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7CE4E2DE7
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4072626;
	Thu,  8 May 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOGBHFta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209F4B1E5E;
	Thu,  8 May 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673291; cv=none; b=Y6xmgZRT2cORajysJbwqI5ug7v3rTzur1jLf8z/mIcP2QgWGav504WQlnbk/OjWYn8eRZE+lxgn7mPHXuraF6kwDlMHK+wYvyVcWWVH8IlptVcxmnfADD5TvLJhazYTksDyCyqVOThcZ6i+rCIB6u6UuRlXyfHUhV2kuXyAhjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673291; c=relaxed/simple;
	bh=Xrh96RoA/f/NJpZEpoIgqKMhNzj7nFGY7CfMX0FrR/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDIhVSixks0EJCjGrgfiXMMagznrE5r1jjBy6vij0jzPmYEZo/cypIfSspbhdcL0btoBU00r+3kBcBldtvRj1O/RSREyCDtq534qHh9MyFpvBuoAmxNvfWqiHSdmwq3WhXuwYd0ZVGAcIAghwEOHOYJR0zHfNu1Ot2WMYNSGyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOGBHFta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F03DC4CEE2;
	Thu,  8 May 2025 03:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746673291;
	bh=Xrh96RoA/f/NJpZEpoIgqKMhNzj7nFGY7CfMX0FrR/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOGBHFta6HOVJNokUXV8bLxjXnILVj9OzrQFZEGC2yEpAUCjPI4splRyNHrLdkNLC
	 OulWNRTLMYEie7nb7ZBJeN2QGxNwCg5gGp0/R8B/r+kYJjRVHkah/ex8BnrJdLt1QV
	 3pOWvO+rPKJ/y8piy9bxj7nVjqZ7lL+Yx5PvLyHcxZllIXkNhcx1zhJ3E1aVuiyiv5
	 3DHPKW8TT2o3mGceXYLh7PRYUudwOYC+XYQR8mddRW5c1EHGmfD8k4WWyEVBi7JaRb
	 4be8uXdHfhh/abghEsNWlf4WtBvVWFKnFN7CtfSvJldN0KQSd7KTq48dCNqpSjrLO3
	 0GCKv7LHzxnZw==
Date: Wed, 7 May 2025 20:01:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v8 10/10] ref_tracker: eliminate the ref_tracker_dir
 name field
Message-ID: <20250507200129.677dc67a@kernel.org>
In-Reply-To: <20250507-reftrack-dbgfs-v8-10-607717d3bb98@kernel.org>
References: <20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org>
	<20250507-reftrack-dbgfs-v8-10-607717d3bb98@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 May 2025 09:06:35 -0400 Jeff Layton wrote:
> + * @quarantime_count: max number of entries to be tracked

quarantime
        ^
:(
-- 
pw-bot: cr

