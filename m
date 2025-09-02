Return-Path: <netdev+bounces-219086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB80B3FB44
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C304E2AE5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A52F5484;
	Tue,  2 Sep 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqNrc8jW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172912EE26F;
	Tue,  2 Sep 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806630; cv=none; b=MnhtOJJFMfxobo/Q4lL87u8MBqGO6mWQ8/GYvhr06dq9bdmVNcF9zYxsNgr1Gl97rmvQ7xyFuYWGfi9h+Si5B39b/HH/UkHHYEc0NVHWXKgZK0QAu56kLAQozQt18haGkBYV37dJzWObly4zNppsszgFxwqVKduSFhKsxCOThl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806630; c=relaxed/simple;
	bh=IjciWVKVeDiCqwXrYhdDxhtJbkeS2xlNWZmzO33IbIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO3EjemKsucelDFlMaj1iNfsoY78pZSU1Jupb+nc6lHAW068zr+cca+QbRayG5cSoI520xx4ZKEwiTwdWW6zcKDbE4XOIRpSsaG5j7ryOtyBAHQCKcHSbqIZSzQyiuG2eHBMgDVh/Byyuqevqfrswv0LxsQAMSOAgkRA+UgElKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqNrc8jW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F102C4CEED;
	Tue,  2 Sep 2025 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806629;
	bh=IjciWVKVeDiCqwXrYhdDxhtJbkeS2xlNWZmzO33IbIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqNrc8jWPVyV+gBipGCQSvfMJQ4dMu3W/CRaEWJKoPs88vgLlkoQIVMXtrLNcBcJR
	 kIAR7aYWJtMOXiVsajs8A2k8cblBb+3vy8Oa7fBPYrIxBsv7dr8LZt1Zhrh6sf7Mkp
	 VC6Tvtrm/xwix2XnaK5nfxkBmcjMqYWlg4BaTZezqg/bmscMHS4sWG5Wrg1lGTRnvH
	 hPsTO3UMane3hrF/xiVvbjfDHYTGuBao9uzk+LyR9l5yzH5czUp4J6y17hn6H/aT92
	 ZAUOaNIHyBxeYb6ofmFxN90k6EmUrD/MEKIjiSK1nryQXPbrCmqidbqcl0Ya6Ld0Vy
	 wrTc3e23rJyDQ==
Date: Tue, 2 Sep 2025 10:50:25 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Daney <david.daney@cavium.com>,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: thunder_bgx: decrement cleanup index before use
Message-ID: <20250902095025.GA15473@horms.kernel.org>
References: <20250901213314.48599-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901213314.48599-1-rosenp@gmail.com>

On Mon, Sep 01, 2025 at 02:33:14PM -0700, Rosen Penev wrote:
> All paths in probe that call goto defer do so before assigning phydev
> and thus it makes sense to cleanup the prior index. It also fixes a bug
> where index 0 does not get cleaned up.
> 
> Fixes: b7d3e3d3d21a ("net: thunderx: Don't leak phy device references on -EPROBE_DEFER condition.")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

As I reviewed an earlier revision (yesterday)
where this was part of another patch:

Reviewed-by: Simon Horman <horms@kernel.org>

