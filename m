Return-Path: <netdev+bounces-212277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C05CB1EE91
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7E916AC4D
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E9222577;
	Fri,  8 Aug 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqz1hdbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8881E32DB
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679220; cv=none; b=LKSJtv5MD6lWwaLCGsd55xfxTNPbWUKZTKE4EFif64xgfBm0+EJjwHpDW5bwJ/f4xEclfBzF0UaucbYViVnkkh2/vcj5/yQSHF6Mkm1ICEgqP8OcdOUnF9l0Kre59j6MyIs6Gk8MeYOE0rdc+aAjeCX2bUOuVpOTHbl3XKY2MPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679220; c=relaxed/simple;
	bh=nYAv4YhqZB4fcdkzXa3rOYswHlxV1SkG2ZD65PZgeME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsvioKasKaW/KPvTDNt6zeYZxRuWmnsOdGG/DQIhI9v6AGA3mDi/tsmRRAY13uXDhUuM3TAOAm2EWrIhGqBwShv2aIXZFH1m8P8ECqJupcqv0afQ4Ykk8CHt9kPc1HDvuXOFIn7kq9QSlj0C2caXB19Qn/uZKwt+bJZTwAhl7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqz1hdbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E722C4CEED;
	Fri,  8 Aug 2025 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754679220;
	bh=nYAv4YhqZB4fcdkzXa3rOYswHlxV1SkG2ZD65PZgeME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aqz1hdboWI5+7nAWBuS0wSh/hBhjEyY3D8mFwjQl1CcnMwzfwMzOTzYizQDRG9/kY
	 CB57uMySkvjXTichvtEE2A+C6lk5ikn0amQP8me5SjgbyyN4jnbdkvxxK5cs1lh6Fo
	 3drFYtEH64baXlG2slhXJ6WBM7odyI1NAD+23NMlCZzILtxwnBm2EurpApeeQ7182U
	 EHAj/pSMlKA/hk1Ya1gyn5xbR8oP81gY994+dyLudEzUyPp3mNjk43awBTV1ScPIxa
	 XnBmF41WJY+uG8LkMiBI8Yu2UVK2CUhBMpOBG5LF2ZDNR7B/+35vdTU+h0a+wvVOwZ
	 bT5XF9kWrglEw==
Date: Fri, 8 Aug 2025 11:53:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Kaplan@amd.com,
 dhowells@redhat.com, Paul Menzel <pmenzel@molgen.mpg.de>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
Message-ID: <20250808115338.044a5fc8@kernel.org>
In-Reply-To: <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
	<20250805223346.3293091-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Aug 2025 15:33:41 -0700 Tony Nguyen wrote:
> +	if (devlink_port->attrs.no_phys_port_name)
> +		return 0;

Why are you returning 0 rather than -EOPNOTSUPP?
Driver which doesn't implement phys_port_name would normally return
-EOPNOTSUPP when user tries to read the sysfs file.

